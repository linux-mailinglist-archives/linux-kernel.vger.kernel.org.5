Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E583077A867
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjHMQBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjHMQBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:01:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A521BC0;
        Sun, 13 Aug 2023 09:01:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7379634BE;
        Sun, 13 Aug 2023 16:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE76CC433C7;
        Sun, 13 Aug 2023 16:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942460;
        bh=KPozp3XFVsCBL4Zz6wEhzoLnmhS1oIbHpQEHhZ9vol4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6tUu7tO4KdrcAmkgjK/MDhmxc5Igwx2s3nF4YPXgOq8SRqZUMWpGzaUlYvpcv5g1
         RxuxL8O/p7HuuBouM4CS4SiBaVEJzC1Gunuzcm8mYuUtsuUMB6QBlmCZ5ibgtv8jlo
         Xp1HeH/0EU/gQw3Mf3OSOMq5TRxsO4+kOMCgP8chuCu5ZdnYYX8QSR2baXRQfbcfwM
         +z/Nxl2rJKYUOgDd5aQcAEB45CCl6aQ3Cuh29JFc/arNuIsbsBDxmAyd+RQCdL8hI5
         dZ6zcPACL05bkoqFJL2OiAr2OeMpSc7NfkN61232L+FFENqRG4G3gUKPqsja6Yz3yS
         FBNR5fmcXqUKQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        zdi-disclosures@trendmicro.com,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, sfrench@samba.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 12/47] ksmbd: fix out of bounds in init_smb2_rsp_hdr()
Date:   Sun, 13 Aug 2023 11:59:07 -0400
Message-Id: <20230813160006.1073695-12-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160006.1073695-1-sashal@kernel.org>
References: <20230813160006.1073695-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.45
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 536bb492d39bb6c080c92f31e8a55fe9934f452b ]

If client send smb2 negotiate request and then send smb1 negotiate
request, init_smb2_rsp_hdr is called for smb1 negotiate request since
need_neg is set to false. This patch ignore smb1 packets after ->need_neg
is set to false.

Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21541
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/server.c     |  7 ++++++-
 fs/smb/server/smb_common.c | 19 +++++++++++--------
 fs/smb/server/smb_common.h |  2 +-
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 847ee62afb8a1..9804cabe72a84 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -286,6 +286,7 @@ static void handle_ksmbd_work(struct work_struct *wk)
 static int queue_ksmbd_work(struct ksmbd_conn *conn)
 {
 	struct ksmbd_work *work;
+	int err;
 
 	work = ksmbd_alloc_work_struct();
 	if (!work) {
@@ -297,7 +298,11 @@ static int queue_ksmbd_work(struct ksmbd_conn *conn)
 	work->request_buf = conn->request_buf;
 	conn->request_buf = NULL;
 
-	ksmbd_init_smb_server(work);
+	err = ksmbd_init_smb_server(work);
+	if (err) {
+		ksmbd_free_work_struct(work);
+		return 0;
+	}
 
 	ksmbd_conn_enqueue_request(work);
 	atomic_inc(&conn->r_count);
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index d937e2f45c829..a4421d9458d90 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -388,26 +388,29 @@ static struct smb_version_cmds smb1_server_cmds[1] = {
 	[SMB_COM_NEGOTIATE_EX]	= { .proc = smb1_negotiate, },
 };
 
-static void init_smb1_server(struct ksmbd_conn *conn)
+static int init_smb1_server(struct ksmbd_conn *conn)
 {
 	conn->ops = &smb1_server_ops;
 	conn->cmds = smb1_server_cmds;
 	conn->max_cmds = ARRAY_SIZE(smb1_server_cmds);
+	return 0;
 }
 
-void ksmbd_init_smb_server(struct ksmbd_work *work)
+int ksmbd_init_smb_server(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
 	__le32 proto;
 
-	if (conn->need_neg == false)
-		return;
-
 	proto = *(__le32 *)((struct smb_hdr *)work->request_buf)->Protocol;
+	if (conn->need_neg == false) {
+		if (proto == SMB1_PROTO_NUMBER)
+			return -EINVAL;
+		return 0;
+	}
+
 	if (proto == SMB1_PROTO_NUMBER)
-		init_smb1_server(conn);
-	else
-		init_smb3_11_server(conn);
+		return init_smb1_server(conn);
+	return init_smb3_11_server(conn);
 }
 
 int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work, int info_level,
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index e63d2a4f466b5..1cbb492cdefec 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -427,7 +427,7 @@ bool ksmbd_smb_request(struct ksmbd_conn *conn);
 
 int ksmbd_lookup_dialect_by_id(__le16 *cli_dialects, __le16 dialects_count);
 
-void ksmbd_init_smb_server(struct ksmbd_work *work);
+int ksmbd_init_smb_server(struct ksmbd_work *work);
 
 struct ksmbd_kstat;
 int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work,
-- 
2.40.1

