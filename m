Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B936275E82F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjGXBig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjGXBiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:38:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047831704;
        Sun, 23 Jul 2023 18:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 327C660F9B;
        Mon, 24 Jul 2023 01:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81866C433A9;
        Mon, 24 Jul 2023 01:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162334;
        bh=ghRo+rXAUjJh1hkFHcUYKhv4miA1Uh3Ll2WLG8r/l4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lToGHX4tTUS7LZbjP3PTnqXHvtjkir64Y+UTujX0hvjuyzmgvDbgIO7dimkOM1tYc
         5sE8NonMYcdOIAXwL/5QQJ6PHf/sXPu95TBavmtAd3y2zxm0xOpjdTRMQ4etAu0ZBR
         XKtBNwx4SNBlIV+8eajRvH0E0n1wFAdAfzxvJPXjruQRQFXwKDJg70sVv8gSDlDbyr
         FM8KR1zYYHRZmx1I3qD7rdgyFRtoOCsmt2OZFfFGr77ZDV3dzjeduggopmCjQXuaN6
         cLJOBpuXskZUifjy1Ec1knzMi6PNly1w+At8CfdJYtEcJ8u7/FQQquq4jF9Wgo1G20
         vvlMBn4XJbMBA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiubo Li <xiubli@redhat.com>,
        Milind Changire <mchangir@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, zyan@redhat.com,
        sage@redhat.com, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 24/40] ceph: try to dump the msgs when decoding fails
Date:   Sun, 23 Jul 2023 21:31:24 -0400
Message-Id: <20230724013140.2327815-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013140.2327815-1-sashal@kernel.org>
References: <20230724013140.2327815-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
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
index 4c0f22acf53d2..66048a86c480c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -645,6 +645,7 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
 	err = -EIO;
 out_bad:
 	pr_err("mds parse_reply err %d\n", err);
+	ceph_msg_dump(msg);
 	return err;
 }
 
@@ -3538,6 +3539,7 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 
 bad:
 	pr_err("mdsc_handle_forward decode error err=%d\n", err);
+	ceph_msg_dump(msg);
 }
 
 static int __decode_session_metadata(void **p, void *end,
@@ -5258,6 +5260,7 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 bad:
 	pr_err("error decoding fsmap %d. Shutting down mount.\n", err);
 	ceph_umount_begin(mdsc->fsc->sb);
+	ceph_msg_dump(msg);
 err_out:
 	mutex_lock(&mdsc->mutex);
 	mdsc->mdsmap_err = err;
@@ -5326,6 +5329,7 @@ void ceph_mdsc_handle_mdsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 bad:
 	pr_err("error decoding mdsmap %d. Shutting down mount.\n", err);
 	ceph_umount_begin(mdsc->fsc->sb);
+	ceph_msg_dump(msg);
 	return;
 }
 
-- 
2.39.2

