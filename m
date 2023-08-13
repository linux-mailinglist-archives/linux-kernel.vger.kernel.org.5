Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E9677A79B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjHMPth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHMPtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:49:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B56BE73;
        Sun, 13 Aug 2023 08:49:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE6166303A;
        Sun, 13 Aug 2023 15:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DAE0C433C8;
        Sun, 13 Aug 2023 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941777;
        bh=3ApvIlZZA4WudpNm9wDNZHzywduZ0gCxqbaZPavlcjk=;
        h=From:To:Cc:Subject:Date:From;
        b=ZDIKyQx+ANJTkNdKapts/vBwAq5oxCVGYR8EXORED62d4cxgsw8ZNhuyKrobgxIkc
         JQp7an/Qa9AKldZF656jprHd/0gupfN4U7M7lg/pcwDVFUFY6iq1ci+1KUZ39aqaVX
         ePh+2EZJJaMgCTKp0ijMlNQfzA6un7yXBERsd05o2n3ycAidzqyLmcTAMIUB9sMz+N
         QJT/UTK0yL307qV4eI24/YCf0YdgUCDQMtkr2k/jxzd6C0nUgNjsu2AxBcsZ2h/Bg1
         hHEgluriW+CzfSIuy2llj6YlaT5ylBYOCtw6S0rY4S4CGIqgeowg5sVna32zpzraTH
         3Ub6XRGU8v4OQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wang Ming <machel@vivo.com>, Tom Talpey <tom@talpey.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, sfrench@samba.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 01/54] ksmbd: Fix unsigned expression compared with zero
Date:   Sun, 13 Aug 2023 11:48:40 -0400
Message-Id: <20230813154934.1067569-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Ming <machel@vivo.com>

[ Upstream commit 0266a2f791294e0b4ba36f4a1d89b8615ea3cac0 ]

The return value of the ksmbd_vfs_getcasexattr() is signed.
However, the return value is being assigned to an unsigned
variable and subsequently recasted, causing warnings. Use
a signed type.

Signed-off-by: Wang Ming <machel@vivo.com>
Acked-by: Tom Talpey <tom@talpey.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/vfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 81489fdedd8e0..525fda90ed686 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -416,7 +416,8 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 {
 	char *stream_buf = NULL, *wbuf;
 	struct mnt_idmap *idmap = file_mnt_idmap(fp->filp);
-	size_t size, v_len;
+	size_t size;
+	ssize_t v_len;
 	int err = 0;
 
 	ksmbd_debug(VFS, "write stream data pos : %llu, count : %zd\n",
@@ -433,9 +434,9 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 				       fp->stream.name,
 				       fp->stream.size,
 				       &stream_buf);
-	if ((int)v_len < 0) {
+	if (v_len < 0) {
 		pr_err("not found stream in xattr : %zd\n", v_len);
-		err = (int)v_len;
+		err = v_len;
 		goto out;
 	}
 
-- 
2.40.1

