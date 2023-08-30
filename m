Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEA778DF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344378AbjH3T1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244814AbjH3OJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:09:06 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30630122
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:09:01 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 0192910000A;
        Wed, 30 Aug 2023 17:08:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0192910000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1693404538;
        bh=ZQuVbTceDJhV/D756QtsxPuAvKXLmIA2HTloQ25Xbdw=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=vBzi5TFYlg9GnSdaJQP6Iq7s66cADSWqKmGXHWOTQPON0tzNoLTDrEwdxWOsihszW
         qbz7Aj1cHipz3tiJmpzBW1Pcao1nhiUsIXb1njbbzHdVoqNOQcFhe+IrY+BI8mMamY
         fNQtz/AKSxVEYUDJiaZG7MNIMjOEgvtN11WNTBFChtrnsAfNlU4y1EdXE0caSkwD+Z
         +qSqX5ttQTC+T09sDRaibobA7y0Eb0Ic4X7Yy9bH/wVbgCHnMx85eB54ezNe+BJT02
         yHw22LHTHHnbtqrA0m+vQf7ghJRR268im9v1Qb1Lha0aF/Do2hZE8tLvFvKf4EUXKH
         7TTzcWf3eZK9Q==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 30 Aug 2023 17:08:57 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 30 Aug 2023 17:08:35 +0300
From:   Alexey Romanov <avromanov@salutedevices.com>
To:     <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <miles.chen@mediatek.com>, <martin.blumenstingl@googlemail.com>,
        <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>
CC:     <kernel@sberdevices.ru>, <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1] drivers: meson: sm: correct meson_sm_* API retval handling
Date:   Wed, 30 Aug 2023 17:08:50 +0300
Message-ID: <20230830140850.17130-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179535 [Aug 30 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 529 529 a773548e495283fecef97c3e587259fde2135fef, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/08/30 10:10:00 #21746118
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Following the ARM SMC32 calling convention, the return value
from secure monitor is a 32-bit signed integer. This patch changes
the type of the return value of the function meson_sm_call().

2. Now, when meson_sm_call() returns a 32-bit signed integer, we need
to ensure that this value is not negative. It is important to check
that the return value is not negative in both the meson_sm_call_read()
and meson_sm_call_write() functions.

3. Add a comment explaining why it is necessary to check if the SMC
return value is equal to 0 in the function meson_sm_call_read().
It is not obvious when reading this code.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/firmware/meson/meson_sm.c       | 20 +++++++++++++-------
 include/linux/firmware/meson/meson_sm.h |  2 +-
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 798bcdb05d84..27a8cd4747f8 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -67,7 +67,7 @@ static u32 meson_sm_get_cmd(const struct meson_sm_chip *chip,
 	return cmd->smc_id;
 }
 
-static u32 __meson_sm_call(u32 cmd, u32 arg0, u32 arg1, u32 arg2,
+static s32 __meson_sm_call(u32 cmd, u32 arg0, u32 arg1, u32 arg2,
 			   u32 arg3, u32 arg4)
 {
 	struct arm_smccc_res res;
@@ -102,9 +102,10 @@ static void __iomem *meson_sm_map_shmem(u32 cmd_shmem, unsigned int size)
  * Return:	0 on success, a negative value on error
  */
 int meson_sm_call(struct meson_sm_firmware *fw, unsigned int cmd_index,
-		  u32 *ret, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
+		  s32 *ret, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
 {
-	u32 cmd, lret;
+	u32 cmd;
+	s32 lret;
 
 	if (!fw->chip)
 		return -ENOENT;
@@ -143,7 +144,7 @@ int meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
 		       unsigned int bsize, unsigned int cmd_index, u32 arg0,
 		       u32 arg1, u32 arg2, u32 arg3, u32 arg4)
 {
-	u32 size;
+	s32 size;
 	int ret;
 
 	if (!fw->chip)
@@ -158,11 +159,16 @@ int meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
 	if (meson_sm_call(fw, cmd_index, &size, arg0, arg1, arg2, arg3, arg4) < 0)
 		return -EINVAL;
 
-	if (size > bsize)
+	if (size < 0 || size > bsize)
 		return -EINVAL;
 
 	ret = size;
 
+	/* In some cases (for example GET_CHIP_ID command),
+	 * SMC doesn't return the number of bytes read, even
+	 * though the bytes were actually read into sm_shmem_out.
+	 * So this check is needed.
+	 */
 	if (!size)
 		size = bsize;
 
@@ -192,7 +198,7 @@ int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
 			unsigned int size, unsigned int cmd_index, u32 arg0,
 			u32 arg1, u32 arg2, u32 arg3, u32 arg4)
 {
-	u32 written;
+	s32 written;
 
 	if (!fw->chip)
 		return -ENOENT;
@@ -208,7 +214,7 @@ int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
 	if (meson_sm_call(fw, cmd_index, &written, arg0, arg1, arg2, arg3, arg4) < 0)
 		return -EINVAL;
 
-	if (!written)
+	if (written <= 0 || written > size)
 		return -EINVAL;
 
 	return written;
diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
index 95b0da2326a9..8eaf8922ab02 100644
--- a/include/linux/firmware/meson/meson_sm.h
+++ b/include/linux/firmware/meson/meson_sm.h
@@ -19,7 +19,7 @@ enum {
 struct meson_sm_firmware;
 
 int meson_sm_call(struct meson_sm_firmware *fw, unsigned int cmd_index,
-		  u32 *ret, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4);
+		  s32 *ret, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4);
 int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
 			unsigned int b_size, unsigned int cmd_index, u32 arg0,
 			u32 arg1, u32 arg2, u32 arg3, u32 arg4);
-- 
2.25.1

