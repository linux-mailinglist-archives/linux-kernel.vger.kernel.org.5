Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D907CF174
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbjJSHjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344886AbjJSHix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:38:53 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D80418E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:38:50 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id EED9A10000B;
        Thu, 19 Oct 2023 10:38:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru EED9A10000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1697701127;
        bh=BBTzZEqsm/wZZOPygxY/squ4vnYn9Ag4bIEvCJkN4iQ=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=rgYrhySUwSqy03N87r3OURo82Afg0GJYP+xbiL2q0ccNh7WTrQDW6LryU5sWx1PMW
         Myx4/yP1xQSDYXuC1NJqpGhfnsKjW/VRKQup1U7cJgyEH0+Jo1eHnxVMihvDLgVfGG
         b0ijbntjWsjMQjkYLyE+GUAl62nGHXHqP9xeHQMb3VQ2uJc/qU9QZBVqFwikefx9j3
         r/ikVZmK/GrL0esm/7VAHq3PTxeeGA2Q75wy/xBtNQTwTuYcnEQdtCkPg1ud/4tHwn
         AH7npaf/m7TfZoNThjbNDGAkNgALFzjNz6ZGrINjdwV0dQr9fOR37hED5oTNIwsmZR
         9UEjyVR2jv9wA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 19 Oct 2023 10:38:47 +0300 (MSK)
Received: from CAB-WSD-0004828.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 19 Oct 2023 10:38:47 +0300
From:   Martin Kurbanov <mmkurbanov@salutedevices.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, Yu Zhe <yuzhe@nfschina.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@salutedevices.com>
Subject: [PATCH v1 1/2] jffs2: introduce jffs2_nandflash()
Date:   Thu, 19 Oct 2023 10:38:37 +0300
Message-ID: <20231019073838.17586-2-mmkurbanov@salutedevices.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231019073838.17586-1-mmkurbanov@salutedevices.com>
References: <20231019073838.17586-1-mmkurbanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180720 [Oct 19 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 541 541 6f62a06a82e8ec968d29b8e7c7bba6aeceb34f57, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/19 05:18:00 #22229383
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce jffs2_nandflash() instead of jffs2_cleanmarker_oob().
The jffs2_nandflash() is used to determine the type of flash.
And the jffs2_cleanmarker_oob() determines whether cleanmarkers
are needed.

The function name is chosen by analogy with jffs2_dataflash() and
jffs2_ubivol().

This is a preparation patch making further changes a bit cleaner
(no functional change).

Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
---
 fs/jffs2/erase.c    | 2 +-
 fs/jffs2/fs.c       | 4 ++--
 fs/jffs2/os-linux.h | 3 +++
 fs/jffs2/scan.c     | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
index acd32f05b519..4475de5206c0 100644
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -173,7 +173,7 @@ static void jffs2_erase_failed(struct jffs2_sb_info *c, struct jffs2_eraseblock
 {
 	/* For NAND, if the failure did not occur at the device level for a
 	   specific physical page, don't bother updating the bad block table. */
-	if (jffs2_cleanmarker_oob(c) && (bad_offset != (uint32_t)MTD_FAIL_ADDR_UNKNOWN)) {
+	if (jffs2_nandflash(c) && (bad_offset != (uint32_t)MTD_FAIL_ADDR_UNKNOWN)) {
 		/* We had a device-level failure to erase.  Let's see if we've
 		   failed too many times. */
 		if (!jffs2_write_nand_badblock(c, jeb, bad_offset)) {
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 038516bee1ab..6de91c00eb73 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -687,7 +687,7 @@ struct jffs2_inode_info *jffs2_gc_fetch_inode(struct jffs2_sb_info *c,
 static int jffs2_flash_setup(struct jffs2_sb_info *c) {
 	int ret = 0;
 
-	if (jffs2_cleanmarker_oob(c)) {
+	if (jffs2_nandflash(c)) {
 		/* NAND flash... do setup accordingly */
 		ret = jffs2_nand_flash_setup(c);
 		if (ret)
@@ -720,7 +720,7 @@ static int jffs2_flash_setup(struct jffs2_sb_info *c) {
 
 void jffs2_flash_cleanup(struct jffs2_sb_info *c) {
 
-	if (jffs2_cleanmarker_oob(c)) {
+	if (jffs2_nandflash(c)) {
 		jffs2_nand_flash_cleanup(c);
 	}
 
diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index 8da19766c101..c604f639a00f 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -81,6 +81,7 @@ static inline void jffs2_init_inode_info(struct jffs2_inode_info *f)
 #define jffs2_flush_wbuf_pad(c) ({ do{} while(0); (void)(c), 0; })
 #define jffs2_flush_wbuf_gc(c, i) ({ do{} while(0); (void)(c), (void) i, 0; })
 #define jffs2_write_nand_badblock(c,jeb,bad_offset) (1)
+#define jffs2_nandflash(c) (0)
 #define jffs2_nand_flash_setup(c) (0)
 #define jffs2_nand_flash_cleanup(c) do {} while(0)
 #define jffs2_wbuf_dirty(c) (0)
@@ -124,6 +125,8 @@ void jffs2_wbuf_timeout(unsigned long data);
 void jffs2_wbuf_process(void *data);
 int jffs2_flush_wbuf_gc(struct jffs2_sb_info *c, uint32_t ino);
 int jffs2_flush_wbuf_pad(struct jffs2_sb_info *c);
+
+#define jffs2_nandflash(c) ((c)->mtd->type == MTD_NANDFLASH)
 int jffs2_nand_flash_setup(struct jffs2_sb_info *c);
 void jffs2_nand_flash_cleanup(struct jffs2_sb_info *c);
 
diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 29671e33a171..005d0af950ea 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -113,7 +113,7 @@ int jffs2_scan_medium(struct jffs2_sb_info *c)
 	if (!flashbuf) {
 		/* For NAND it's quicker to read a whole eraseblock at a time,
 		   apparently */
-		if (jffs2_cleanmarker_oob(c))
+		if (jffs2_nandflash(c))
 			try_size = c->sector_size;
 		else
 			try_size = PAGE_SIZE;
-- 
2.40.0

