Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0404E807371
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442411AbjLFPMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379090AbjLFPMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:12:36 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A799A;
        Wed,  6 Dec 2023 07:12:42 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 6CBA71E1A;
        Wed,  6 Dec 2023 15:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1701875176;
        bh=uNOivJvRpFbPgTjjVYSC1qoe7uSyIYuTw1rYbo9Hp0w=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=bj/RGX+6H/0ra5+wZHFHw7x8ZHxC4RWyNh6puOtIUKz5QvQUmsZ0xpgJCSi/3kgd8
         CIsytNXKjsTuT5Mx61jzLyhwiQnJd83CIzQ/z1e9e85Gj6tRy0SUOh6XKrUueruEHx
         18Yo98VSLGmUOGFrBa2t/w8+BTvfuN+wPVYQ0NHY=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id AF2152117;
        Wed,  6 Dec 2023 15:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1701875560;
        bh=uNOivJvRpFbPgTjjVYSC1qoe7uSyIYuTw1rYbo9Hp0w=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=EDu7HbCK/E19/EVWbQReaNUWjnJLDH4T6JYEPDGhrvSGr5wZUxVJQM4lhLYJD/t0W
         oR+i7ET+/BXRId+BZ8LmBGtxuI6ob1ldfPfm/VIOAwEHZKDQULAHXsEE6jT94qMOJ2
         9BGkKHDpMtgzU6Cv1q/cZpWUFN0QVVDb06lPOESw=
Received: from [172.16.192.129] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 18:12:40 +0300
Message-ID: <29a1087c-c903-488c-993a-2e3c23c2d4d2@paragon-software.com>
Date:   Wed, 6 Dec 2023 18:12:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 09/16] fs/ntfs3: Correct use bh_read
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
  fs/ntfs3/file.c  | 19 +++++++++----------
  fs/ntfs3/inode.c |  7 +++----
  2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index a5a30a24ce5d..5691f04e6751 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -188,6 +188,7 @@ static int ntfs_zero_range(struct inode *inode, u64 
vbo, u64 vbo_to)
      u32 bh_next, bh_off, to;
      sector_t iblock;
      struct folio *folio;
+    bool dirty = false;

      for (; idx < idx_end; idx += 1, from = 0) {
          page_off = (loff_t)idx << PAGE_SHIFT;
@@ -223,29 +224,27 @@ static int ntfs_zero_range(struct inode *inode, 
u64 vbo, u64 vbo_to)
              /* Ok, it's mapped. Make sure it's up-to-date. */
              if (folio_test_uptodate(folio))
                  set_buffer_uptodate(bh);
-
-            if (!buffer_uptodate(bh)) {
-                err = bh_read(bh, 0);
-                if (err < 0) {
-                    folio_unlock(folio);
-                    folio_put(folio);
-                    goto out;
-                }
+            else if (bh_read(bh, 0) < 0) {
+                err = -EIO;
+                folio_unlock(folio);
+                folio_put(folio);
+                goto out;
              }

              mark_buffer_dirty(bh);
-
          } while (bh_off = bh_next, iblock += 1,
               head != (bh = bh->b_this_page));

          folio_zero_segment(folio, from, to);
+        dirty = true;

          folio_unlock(folio);
          folio_put(folio);
          cond_resched();
      }
  out:
-    mark_inode_dirty(inode);
+    if (dirty)
+        mark_inode_dirty(inode);
      return err;
  }

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index fa6c7965473c..bba0208c4afd 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -345,9 +345,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
              inode->i_size = le16_to_cpu(rp.SymbolicLinkReparseBuffer
                                  .PrintNameLength) /
                      sizeof(u16);
-
              ni->i_valid = inode->i_size;
-
              /* Clear directory bit. */
              if (ni->ni_flags & NI_FLAG_DIR) {
                  indx_clear(&ni->dir);
@@ -653,9 +651,10 @@ static noinline int ntfs_get_block_vbo(struct inode 
*inode, u64 vbo,
              off = vbo & (PAGE_SIZE - 1);
              folio_set_bh(bh, folio, off);

-            err = bh_read(bh, 0);
-            if (err < 0)
+            if (bh_read(bh, 0) < 0) {
+                err = -EIO;
                  goto out;
+            }
              folio_zero_segment(folio, off + voff, off + block_size);
          }
      }
-- 
2.34.1

