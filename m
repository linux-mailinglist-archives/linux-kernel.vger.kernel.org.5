Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925DC807380
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442470AbjLFPOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442535AbjLFPOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:14:21 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B67112;
        Wed,  6 Dec 2023 07:14:26 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id E6D181D0B;
        Wed,  6 Dec 2023 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1701875280;
        bh=W/TNdgmKDqNDYIi7mUSo5ayyxeI6Wi55D54a4MJS5O8=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=uB7SJ5ZV34Sc6PLOrZBUBpCENFmPGqlFtRZvqJoH9vKlKM7YeJH4IMKAHPy9I9iEa
         ejo/mhQFbObUfY7QSS46h7IJ+xwplvgdoZFTxSFtWgAmYnNnVdXzTJPHQhaaWOBNo5
         SWLDXhH3caMbQcpe06yX7DO97jt+0K3UDKKUucwE=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 32A922117;
        Wed,  6 Dec 2023 15:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1701875665;
        bh=W/TNdgmKDqNDYIi7mUSo5ayyxeI6Wi55D54a4MJS5O8=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=HwerjDqSLEHZuqFn+zzPuEhCBWA0uFcD4nADai1942YJ983cNo0j/pryidiex2rWP
         H0uuBaQ306w3AFnBoJcJRFcIIK8vQDQuWbmPIeusCe3s3FXdqFM+hDeHsYQD0L0g+x
         O29n04DNf2rqk9XpwAgCpKfKdguOdnw9nTpi3aCo=
Received: from [172.16.192.129] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 18:14:24 +0300
Message-ID: <f876d196-bfeb-4b0d-bb10-dc793717db49@paragon-software.com>
Date:   Wed, 6 Dec 2023 18:14:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 15/16] fs/ntfs3: Add NULL ptr dereference checking at the end
 of attr_allocate_frame()
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

It is preferable to exit through the out: label because
internal debugging functions are located there.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c | 20 ++++++++++++--------
  1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 4b78b669a3bd..646e2dad1b75 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1743,8 +1743,10 @@ int attr_allocate_frame(struct ntfs_inode *ni, 
CLST frame, size_t compr_size,
              le_b = NULL;
              attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL,
                            0, NULL, &mi_b);
-            if (!attr_b)
-                return -ENOENT;
+            if (!attr_b) {
+                err = -ENOENT;
+                goto out;
+            }

              attr = attr_b;
              le = le_b;
@@ -1825,13 +1827,15 @@ int attr_allocate_frame(struct ntfs_inode *ni, 
CLST frame, size_t compr_size,
  ok:
      run_truncate_around(run, vcn);
  out:
-    if (new_valid > data_size)
-        new_valid = data_size;
+    if (attr_b) {
+        if (new_valid > data_size)
+            new_valid = data_size;

-    valid_size = le64_to_cpu(attr_b->nres.valid_size);
-    if (new_valid != valid_size) {
-        attr_b->nres.valid_size = cpu_to_le64(valid_size);
-        mi_b->dirty = true;
+        valid_size = le64_to_cpu(attr_b->nres.valid_size);
+        if (new_valid != valid_size) {
+            attr_b->nres.valid_size = cpu_to_le64(valid_size);
+            mi_b->dirty = true;
+        }
      }

      return err;
-- 
2.34.1

