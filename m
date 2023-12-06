Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E873807367
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442436AbjLFPJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442406AbjLFPJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:09:41 -0500
X-Greylist: delayed 99 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Dec 2023 07:09:48 PST
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ADDC6;
        Wed,  6 Dec 2023 07:09:47 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 75DD71E1A;
        Wed,  6 Dec 2023 15:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1701875001;
        bh=Ifmg2OmIcc1e099M3eAc7+M0D09LHndtu4YB0fZ10AE=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=CM28fQWfl2jtqKv/4Q00K5fqN1XehGPo+klnsLEdY+l3HE67RQZYkzBqf6GrkQUfr
         djhTyaAxCW/vH267eQpmpDRK6Px0x/CmTqlYadmRB8vyT2X9uyiv7/Ivcky6dxEE49
         O+rzp55tAH/NRfKemZdi/99Qye5kO0nISMZtbgX8=
Received: from [172.16.192.129] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 18:09:45 +0300
Message-ID: <c005f117-6c66-40d8-95d4-e6384cffbcbf@paragon-software.com>
Date:   Wed, 6 Dec 2023 18:09:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 02/16] fs/ntfs3: Modified fix directory element type detection
Content-Language: en-US
From:   Konstantin Komarovc <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <00fd1558-fda5-421b-be43-7de69e32cb4e@paragon-software.com>
In-Reply-To: <00fd1558-fda5-421b-be43-7de69e32cb4e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.144]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately reparse attribute is used for many purposes (several dozens).
It is not possible here to know is this name symlink or not.
To get exactly the type of name we should to open inode (read mft).
getattr for opened file (fstat) correctly returns symlink.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/dir.c | 30 +++++++++++++++++++++++++-----
  1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index ec0566b322d5..22ede4da0450 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -309,11 +309,31 @@ static inline int ntfs_filldir(struct ntfs_sb_info 
*sbi, struct ntfs_inode *ni,
          return 0;
      }

-    /* NTFS: symlinks are "dir + reparse" or "file + reparse" */
-    if (fname->dup.fa & FILE_ATTRIBUTE_REPARSE_POINT)
-        dt_type = DT_LNK;
-    else
-        dt_type = (fname->dup.fa & FILE_ATTRIBUTE_DIRECTORY) ? DT_DIR : 
DT_REG;
+    /*
+     * NTFS: symlinks are "dir + reparse" or "file + reparse"
+     * Unfortunately reparse attribute is used for many purposes 
(several dozens).
+     * It is not possible here to know is this name symlink or not.
+     * To get exactly the type of name we should to open inode (read mft).
+     * getattr for opened file (fstat) correctly returns symlink.
+     */
+    dt_type = (fname->dup.fa & FILE_ATTRIBUTE_DIRECTORY) ? DT_DIR : DT_REG;
+
+    /*
+     * It is not reliable to detect the type of name using duplicated 
information
+     * stored in parent directory.
+     * The only correct way to get the type of name - read MFT record 
and find ATTR_STD.
+     * The code below is not good idea.
+     * It does additional locks/reads just to get the type of name.
+     * Should we use additional mount option to enable branch below?
+     */
+    if ((fname->dup.fa & FILE_ATTRIBUTE_REPARSE_POINT) &&
+        ino != ni->mi.rno) {
+        struct inode *inode = ntfs_iget5(sbi->sb, &e->ref, NULL);
+        if (!IS_ERR_OR_NULL(inode)) {
+            dt_type = fs_umode_to_dtype(inode->i_mode);
+            iput(inode);
+        }
+    }

      return !dir_emit(ctx, (s8 *)name, name_len, ino, dt_type);
  }
-- 
2.34.1

