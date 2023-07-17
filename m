Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109EC755AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjGQFjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjGQFjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:39:45 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16395E6D;
        Sun, 16 Jul 2023 22:39:43 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 8297112000F;
        Mon, 17 Jul 2023 08:39:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8297112000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689572381;
        bh=ScCXR9HXhnFNVkOIKX8tcXBCrwrwJ57BZ2yHabgHWv4=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=UFyEiHu12dn/4lkzf3Se8v8qAWntQPQCDHu4ABUAdUkPbToc16O1nkVOs/Wd49Y9Y
         lbwFX5qgkLIy//Y+7nB+n5s0aT2cOcqlp1eUXQQEONKdHbnAGvKtDzCq6uSd0vTlim
         3KeyL2sw+CH6FGf4Eee3wBJ1zz/R2CZjHu8nMhXJzHx5XSaz/qIylwNleXFOzD7OVN
         QUX8MUu59bv+wumBN45OmOWzMczeNJwiXEwF0aCHcADv5YTzdZkqpocRFz8gNDCYQE
         EOBOrKa1S3GVu2duEIqfJx+akqt8KWHoZ7cXwM6JZpgHnTCZwP8OLx4kze0gMRC1pv
         1YoyB7qYbz3Iw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon, 17 Jul 2023 08:39:41 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 08:38:46 +0300
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/2] mtd: rawnand: meson: support for 512B ECC step size
Date:   Mon, 17 Jul 2023 08:34:01 +0300
Message-ID: <20230717053402.1203724-3-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20230717053402.1203724-1-AVKrasnov@sberdevices.ru>
References: <20230717053402.1203724-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178635 [Jul 15 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVKrasnov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 523 523 523027ce26ed1d9067f7a52a4756a876e54db27c, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/17 00:56:00 #21624503
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meson NAND supports both 512B and 1024B ECC step size.

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 drivers/mtd/nand/raw/meson_nand.c | 45 +++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 91eeac49d18f..9bdea97abe4c 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -135,6 +135,7 @@ struct meson_nfc_nand_chip {
 struct meson_nand_ecc {
 	u32 bch;
 	u32 strength;
+	u32 size;
 };
 
 struct meson_nfc_data {
@@ -190,7 +191,8 @@ struct meson_nfc {
 };
 
 enum {
-	NFC_ECC_BCH8_1K		= 2,
+	NFC_ECC_BCH8_512	= 1,
+	NFC_ECC_BCH8_1K,
 	NFC_ECC_BCH24_1K,
 	NFC_ECC_BCH30_1K,
 	NFC_ECC_BCH40_1K,
@@ -198,15 +200,16 @@ enum {
 	NFC_ECC_BCH60_1K,
 };
 
-#define MESON_ECC_DATA(b, s)	{ .bch = (b),	.strength = (s)}
+#define MESON_ECC_DATA(b, s, sz)	{ .bch = (b), .strength = (s), .size = (sz) }
 
 static struct meson_nand_ecc meson_ecc[] = {
-	MESON_ECC_DATA(NFC_ECC_BCH8_1K, 8),
-	MESON_ECC_DATA(NFC_ECC_BCH24_1K, 24),
-	MESON_ECC_DATA(NFC_ECC_BCH30_1K, 30),
-	MESON_ECC_DATA(NFC_ECC_BCH40_1K, 40),
-	MESON_ECC_DATA(NFC_ECC_BCH50_1K, 50),
-	MESON_ECC_DATA(NFC_ECC_BCH60_1K, 60),
+	MESON_ECC_DATA(NFC_ECC_BCH8_512, 8,  512),
+	MESON_ECC_DATA(NFC_ECC_BCH8_1K,  8,  1024),
+	MESON_ECC_DATA(NFC_ECC_BCH24_1K, 24, 1024),
+	MESON_ECC_DATA(NFC_ECC_BCH30_1K, 30, 1024),
+	MESON_ECC_DATA(NFC_ECC_BCH40_1K, 40, 1024),
+	MESON_ECC_DATA(NFC_ECC_BCH50_1K, 50, 1024),
+	MESON_ECC_DATA(NFC_ECC_BCH60_1K, 60, 1024),
 };
 
 static int meson_nand_calc_ecc_bytes(int step_size, int strength)
@@ -224,8 +227,27 @@ static int meson_nand_calc_ecc_bytes(int step_size, int strength)
 
 NAND_ECC_CAPS_SINGLE(meson_gxl_ecc_caps,
 		     meson_nand_calc_ecc_bytes, 1024, 8, 24, 30, 40, 50, 60);
-NAND_ECC_CAPS_SINGLE(meson_axg_ecc_caps,
-		     meson_nand_calc_ecc_bytes, 1024, 8);
+
+static const int axg_stepinfo_strengths[] = { 8 };
+static const struct nand_ecc_step_info axg_stepinfo_1024 = {
+	.stepsize = 1024,
+	.strengths = axg_stepinfo_strengths,
+	.nstrengths = ARRAY_SIZE(axg_stepinfo_strengths)
+};
+
+static const struct nand_ecc_step_info axg_stepinfo_512 = {
+	.stepsize = 512,
+	.strengths = axg_stepinfo_strengths,
+	.nstrengths = ARRAY_SIZE(axg_stepinfo_strengths)
+};
+
+static const struct nand_ecc_step_info axg_stepinfo[] = { axg_stepinfo_1024, axg_stepinfo_512 };
+
+static const struct nand_ecc_caps meson_axg_ecc_caps = {
+	.stepinfos = axg_stepinfo,
+	.nstepinfos = ARRAY_SIZE(axg_stepinfo),
+	.calc_ecc_bytes = meson_nand_calc_ecc_bytes,
+};
 
 static struct meson_nfc_nand_chip *to_meson_nand(struct nand_chip *nand)
 {
@@ -1257,7 +1279,8 @@ static int meson_nand_bch_mode(struct nand_chip *nand)
 		return -EINVAL;
 
 	for (i = 0; i < ARRAY_SIZE(meson_ecc); i++) {
-		if (meson_ecc[i].strength == nand->ecc.strength) {
+		if (meson_ecc[i].strength == nand->ecc.strength &&
+		    meson_ecc[i].size == nand->ecc.size) {
 			meson_chip->bch_mode = meson_ecc[i].bch;
 			return 0;
 		}
-- 
2.35.0

