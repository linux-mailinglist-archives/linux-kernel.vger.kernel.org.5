Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5756680739C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379164AbjLFPLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379221AbjLFPKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:10:48 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096DCD5B;
        Wed,  6 Dec 2023 07:10:54 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 751C91E1A;
        Wed,  6 Dec 2023 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1701875068;
        bh=mAuuCGMqlStfHaypyBJ9iLMuzcr3BmzULzMWMwWTRuE=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=bLupnkpLf7fzkUc2Zt5omBwLubjPcPeYPgaJ3tqLEQExUyjSso2/GDYWv58+hM9Zd
         fhwCheq3GPFBlwishCkRPuzN547xVQMTB6CcNxkddptzAQzbiVxJDeavPAQdzRFKtx
         4XYrwbbISqytrtKzvacmxjfRMfH0G33BplXtpoVE=
Received: from [172.16.192.129] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 18:10:52 +0300
Message-ID: <8cb671f9-252b-443b-a903-ca62c9097533@paragon-software.com>
Date:   Wed, 6 Dec 2023 18:10:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 04/16] fs/ntfs3: Correct hard links updating when dealing with
 DOS neams
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
  fs/ntfs3/record.c | 16 ++++++++++++++--
  1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 53629b1f65e9..7b6423584eae 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -535,8 +535,20 @@ bool mi_remove_attr(struct ntfs_inode *ni, struct 
mft_inode *mi,
          return false;

      if (ni && is_attr_indexed(attr)) {
-        le16_add_cpu(&ni->mi.mrec->hard_links, -1);
-        ni->mi.dirty = true;
+        u16 links = le16_to_cpu(ni->mi.mrec->hard_links);
+        struct ATTR_FILE_NAME *fname =
+            attr->type != ATTR_NAME ?
+                NULL :
+                resident_data_ex(attr,
+                         SIZEOF_ATTRIBUTE_FILENAME);
+        if (fname && fname->type == FILE_NAME_DOS) {
+            /* Do not decrease links count deleting DOS name. */
+        } else if (!links) {
+            /* minor error. Not critical. */
+        } else {
+            ni->mi.mrec->hard_links = cpu_to_le16(links - 1);
+            ni->mi.dirty = true;
+        }
      }

      used -= asize;
-- 
2.34.1

