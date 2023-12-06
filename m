Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B95807375
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442474AbjLFPNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379228AbjLFPNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:13:11 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF039DE;
        Wed,  6 Dec 2023 07:13:17 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 903201E1A;
        Wed,  6 Dec 2023 15:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1701875211;
        bh=F097v/jB8ZR21e/O3vd36dCK4gneA3BrFHtMeimQuV4=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=m3/oqph84dOfSvsyEUrnjup2sI052twZlQVgqAS6UOH+jafuQ1FPCmz6Fu7lGEQQi
         2/82ZDbxioT09DRo45akAqbUhutD4t5bbxSm44sL5MnKUhvjmAyx/0IIaHypmgn1vm
         OEh6DBzuauAM8FnZ1RUItM5m01Y3W9cCWxkOJYF0=
Received: from [172.16.192.129] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 18:13:15 +0300
Message-ID: <89861d9e-f3a4-483d-b88d-4085dc2e0a8b@paragon-software.com>
Date:   Wed, 6 Dec 2023 18:13:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 11/16] fs/ntfs3: Drop suid and sgid bits as a part of fpunch
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
  fs/ntfs3/file.c | 9 +++++++++
  1 file changed, 9 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index bb80ce2eec2f..0ff5d3af2889 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -498,10 +498,14 @@ static long ntfs_fallocate(struct file *file, int 
mode, loff_t vbo, loff_t len)
          ni_lock(ni);
          err = attr_punch_hole(ni, vbo, len, &frame_size);
          ni_unlock(ni);
+        if (!err)
+            goto ok;
+
          if (err != E_NTFS_NOTALIGNED)
              goto out;

          /* Process not aligned punch. */
+        err = 0;
          mask = frame_size - 1;
          vbo_a = (vbo + mask) & ~mask;
          end_a = end & ~mask;
@@ -524,6 +528,8 @@ static long ntfs_fallocate(struct file *file, int 
mode, loff_t vbo, loff_t len)
              ni_lock(ni);
              err = attr_punch_hole(ni, vbo_a, end_a - vbo_a, NULL);
              ni_unlock(ni);
+            if (err)
+                goto out;
          }
      } else if (mode & FALLOC_FL_COLLAPSE_RANGE) {
          /*
@@ -563,6 +569,8 @@ static long ntfs_fallocate(struct file *file, int 
mode, loff_t vbo, loff_t len)
          ni_lock(ni);
          err = attr_insert_range(ni, vbo, len);
          ni_unlock(ni);
+        if (err)
+            goto out;
      } else {
          /* Check new size. */
          u8 cluster_bits = sbi->cluster_bits;
@@ -639,6 +647,7 @@ static long ntfs_fallocate(struct file *file, int 
mode, loff_t vbo, loff_t len)
          }
      }

+ok:
      err = file_modified(file);
      if (err)
          goto out;
-- 
2.34.1

