Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAC275E896
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjGXBm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjGXBlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:41:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B860419BF;
        Sun, 23 Jul 2023 18:36:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AC8260F3C;
        Mon, 24 Jul 2023 01:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DA1C433CB;
        Mon, 24 Jul 2023 01:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162388;
        bh=GtI7Xn86CJJEpQ7HU9Pm51q5IZp6MIdv4UJn6+FBfAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jODLUkrIgFxr3oamDKiqhMoDEgpX4iWRKBFTpuJJuz9l2Aok2L1jxdO5IOXkN9Ozg
         eZU1dxFW4b6Xs9S4nYPFbuek8/aqHgtQIOa8KIHZlYBeCCG0jUiplSbQFGjB/cEn6G
         PRPXrD5apwU9r029/xVYEoj18MvpejeYtYiAi360xob7V82lU6r5n92dooFQ/ZCG/J
         tZ+Na043I6MxmN7NSJuIT4nkUgcOoz+V/Wk07MgXiG4DElbkU1aXgN5st90vPx9b7h
         gLowp+h982DSe3u9O5QaQK6PVMjquxcOYy62mIA0Azzdpo9EqxftUJhk5ufxzrDguM
         VonRfovoO4Glg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiubo Li <xiubli@redhat.com>,
        Milind Changire <mchangir@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, zyan@redhat.com,
        sage@redhat.com, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 22/34] ceph: try to dump the msgs when decoding fails
Date:   Sun, 23 Jul 2023 21:32:25 -0400
Message-Id: <20230724013238.2329166-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013238.2329166-1-sashal@kernel.org>
References: <20230724013238.2329166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 8b0da5c549ae63ba1debd92a350f90773cb4bfe7 ]

When the msgs are corrupted we need to dump them and then it will
be easier to dig what has happened and where the issue is.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 1989c8deea55a..c3632a22348a3 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -645,6 +645,7 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
 	err = -EIO;
 out_bad:
 	pr_err("mds parse_reply err %d\n", err);
+	ceph_msg_dump(msg);
 	return err;
 }
 
@@ -3534,6 +3535,7 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 
 bad:
 	pr_err("mdsc_handle_forward decode error err=%d\n", err);
+	ceph_msg_dump(msg);
 }
 
 static int __decode_session_metadata(void **p, void *end,
@@ -5254,6 +5256,7 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 bad:
 	pr_err("error decoding fsmap %d. Shutting down mount.\n", err);
 	ceph_umount_begin(mdsc->fsc->sb);
+	ceph_msg_dump(msg);
 err_out:
 	mutex_lock(&mdsc->mutex);
 	mdsc->mdsmap_err = err;
@@ -5322,6 +5325,7 @@ void ceph_mdsc_handle_mdsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 bad:
 	pr_err("error decoding mdsmap %d. Shutting down mount.\n", err);
 	ceph_umount_begin(mdsc->fsc->sb);
+	ceph_msg_dump(msg);
 	return;
 }
 
-- 
2.39.2

