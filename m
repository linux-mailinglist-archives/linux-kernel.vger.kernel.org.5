Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110D280737A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442505AbjLFPOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379228AbjLFPOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:14:02 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CCDD50;
        Wed,  6 Dec 2023 07:14:07 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 6E1C01E1A;
        Wed,  6 Dec 2023 15:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1701875261;
        bh=/4I47So9TsCFHrAhRoQV8zzXSeAqCb/39siaVWL+gX0=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=kN9J13WYKnTwM0/sOLGjGLDz5CC0z/k/AWpQjtIuyS78sqffL6F87LGiEKPYmwkL7
         XsjaUGyF0vm3bNzJtlU1jEwm+8I+J8WbK9Qb1LZvwz2k8okN3eA6tNWNsW0vDDrybY
         zpr03m2YeMhs+FawFYMsmtMwLO398U/xikV1iWiY=
Received: from [172.16.192.129] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 18:14:05 +0300
Message-ID: <9cfeb726-0b6a-48bc-a640-435bcb6e359a@paragon-software.com>
Date:   Wed, 6 Dec 2023 18:14:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 14/16] fs/ntfs3: Add and fix comments
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


Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/dir.c     | 4 +++-
  fs/ntfs3/fsntfs.c  | 2 +-
  fs/ntfs3/ntfs.h    | 2 +-
  fs/ntfs3/ntfs_fs.h | 2 +-
  4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 726122ecd39b..9f6dd445eb04 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -536,8 +536,10 @@ static int ntfs_dir_count(struct inode *dir, bool 
*is_empty, size_t *dirs,
              e = Add2Ptr(hdr, off);
              e_size = le16_to_cpu(e->size);
              if (e_size < sizeof(struct NTFS_DE) ||
-                off + e_size > end)
+                off + e_size > end) {
+                /* Looks like corruption. */
                  break;
+            }

              if (de_is_last(e))
                  break;
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 350461d8cece..321978019407 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -2129,8 +2129,8 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
              if (le32_to_cpu(d_security->size) == new_sec_size &&
                  d_security->key.hash == hash_key.hash &&
                  !memcmp(d_security + 1, sd, size_sd)) {
-                *security_id = d_security->key.sec_id;
                  /* Such security already exists. */
+                *security_id = d_security->key.sec_id;
                  err = 0;
                  goto out;
              }
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 13e96fc63dae..c8981429c721 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -523,7 +523,7 @@ struct ATTR_LIST_ENTRY {
      __le64 vcn;        // 0x08: Starting VCN of this attribute.
      struct MFT_REF ref;    // 0x10: MFT record number with attribute.
      __le16 id;        // 0x18: struct ATTRIB ID.
-    __le16 name[];        // 0x1A: Just to align. To get real name can 
use name_off.
+    __le16 name[];        // 0x1A: To get real name use name_off.

  }; // sizeof(0x20)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 7510875efef6..abbc7182554a 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -874,7 +874,7 @@ int ntfs_init_acl(struct mnt_idmap *idmap, struct 
inode *inode,

  int ntfs_acl_chmod(struct mnt_idmap *idmap, struct dentry *dentry);
  ssize_t ntfs_listxattr(struct dentry *dentry, char *buffer, size_t size);
-extern const struct xattr_handler * const ntfs_xattr_handlers[];
+extern const struct xattr_handler *const ntfs_xattr_handlers[];

  int ntfs_save_wsl_perm(struct inode *inode, __le16 *ea_size);
  void ntfs_get_wsl_perm(struct inode *inode);
-- 
2.34.1

