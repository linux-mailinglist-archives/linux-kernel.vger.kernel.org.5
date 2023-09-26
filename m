Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C277AE353
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 03:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjIZB2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 21:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjIZB2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 21:28:00 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id F3DD4101;
        Mon, 25 Sep 2023 18:27:52 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id D75F9604DFA33;
        Tue, 26 Sep 2023 09:27:48 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     sfrench@samba.org, pc@manguebit.com, lsahlber@redhat.com,
        sprasad@microsoft.com, tom@talpey.com
Cc:     Su Hui <suhui@nfschina.com>, dan.carpenter@linaro.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] cifs: avoid possible NULL dereference
Date:   Tue, 26 Sep 2023 09:27:34 +0800
Message-Id: <20230926012733.814657-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch warn:
fs/smb/client/file.c:4910 cifs_oplock_break() warn:
variable dereferenced before check 'inode' (see line 4881)

If 'inode' is NULL, print some warning and return.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 fs/smb/client/file.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 2108b3b40ce9..de705c8b2d22 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -4878,8 +4878,8 @@ void cifs_oplock_break(struct work_struct *work)
 	struct cifsFileInfo *cfile = container_of(work, struct cifsFileInfo,
 						  oplock_break);
 	struct inode *inode = d_inode(cfile->dentry);
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
-	struct cifsInodeInfo *cinode = CIFS_I(inode);
+	struct cifs_sb_info *cifs_sb;
+	struct cifsInodeInfo *cinode;
 	struct cifs_tcon *tcon;
 	struct TCP_Server_Info *server;
 	struct tcon_link *tlink;
@@ -4888,6 +4888,13 @@ void cifs_oplock_break(struct work_struct *work)
 	__u64 persistent_fid, volatile_fid;
 	__u16 net_fid;
 
+	if (!inode) {
+		cifs_dbg(FYI, "%s : failed to find inode\n", __func__);
+		return;
+	}
+	cifs_sb = CIFS_SB(inode->i_sb);
+	cinode = CIFS_I(inode);
+
 	wait_on_bit(&cinode->flags, CIFS_INODE_PENDING_WRITERS,
 			TASK_UNINTERRUPTIBLE);
 
@@ -4907,7 +4914,7 @@ void cifs_oplock_break(struct work_struct *work)
 		cinode->oplock = 0;
 	}
 
-	if (inode && S_ISREG(inode->i_mode)) {
+	if (S_ISREG(inode->i_mode)) {
 		if (CIFS_CACHE_READ(cinode))
 			break_lease(inode, O_RDONLY);
 		else
-- 
2.30.2

