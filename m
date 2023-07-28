Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207BB766931
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbjG1JoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjG1JoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:44:06 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A452D5D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:44:02 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 4F07710000A;
        Fri, 28 Jul 2023 12:43:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4F07710000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1690537439;
        bh=mmWbMSYEkF9c1GueptbbjSnMca6xFSgsbHmgMNQrKo0=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=QUEv9IF58Zlk1wiA+EuPLQL6++PwN2EtVvBEVPNKvQtwi0s+x8grWRio9R5q6CiAp
         FFciygYvsKJ6wJTNhkPSSapiFfwDZRwI4VpBFgictyBZgJbFMKghxUQhs4+DFT7K/8
         SbdecHgZKDp+n75uq1R2cIMUXLSxN5+JuwJ/v1JY0I/ESegspbabqVc3u1TKLqwPje
         jLbIRKPgL0fgPV4gUzd260rUnqmc3V3vnyIRJ4zjmZLUHvX/zWci29bmpnDs2MIXgc
         PSJrhdtNng7udT+JdoXL3NNnCUn83C4HG/I0J+D4IPFyx9d/JVdticUDvlNEG0mRdQ
         E8egdGyJbEAxQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 28 Jul 2023 12:43:59 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 12:43:35 +0300
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        kernel test robot <lkp@intel.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] mtd: rawnand: meson: fix build error
Date:   Fri, 28 Jul 2023 12:38:10 +0300
Message-ID: <20230728093810.2985324-1-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178796 [Jul 22 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVKrasnov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 525 525 723604743bfbdb7e16728748c3fa45e9eba05f7d, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/07/23 10:45:00
X-KSMG-LinksScanning: Clean, bases: 2023/07/23 10:46:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/23 08:49:00 #21663637
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following build error:

drivers/mtd/nand/raw/meson_nand.c:244:59: error: initializer element is not a compile-time constant
static const struct nand_ecc_step_info axg_stepinfo[] = { axg_stepinfo_1024, axg_stepinfo_512 };
                                                          ^~~~~~~~~~~~~~~~~

Fixes: 0e1db39336d8 ("mtd: rawnand: meson: support for 512B ECC step size")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307281007.MMuVjmJ9-lkp@intel.com/
Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 drivers/mtd/nand/raw/meson_nand.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index ff673a9d52af..561d46d860b7 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -229,20 +229,20 @@ NAND_ECC_CAPS_SINGLE(meson_gxl_ecc_caps,
 		     meson_nand_calc_ecc_bytes, 1024, 8, 24, 30, 40, 50, 60);
 
 static const int axg_stepinfo_strengths[] = { 8 };
-static const struct nand_ecc_step_info axg_stepinfo_1024 = {
-	.stepsize = 1024,
-	.strengths = axg_stepinfo_strengths,
-	.nstrengths = ARRAY_SIZE(axg_stepinfo_strengths)
-};
 
-static const struct nand_ecc_step_info axg_stepinfo_512 = {
-	.stepsize = 512,
-	.strengths = axg_stepinfo_strengths,
-	.nstrengths = ARRAY_SIZE(axg_stepinfo_strengths)
+static const struct nand_ecc_step_info axg_stepinfo[] = {
+	{
+		.stepsize = 1024,
+		.strengths = axg_stepinfo_strengths,
+		.nstrengths = ARRAY_SIZE(axg_stepinfo_strengths)
+	},
+	{
+		.stepsize = 512,
+		.strengths = axg_stepinfo_strengths,
+		.nstrengths = ARRAY_SIZE(axg_stepinfo_strengths)
+	},
 };
 
-static const struct nand_ecc_step_info axg_stepinfo[] = { axg_stepinfo_1024, axg_stepinfo_512 };
-
 static const struct nand_ecc_caps meson_axg_ecc_caps = {
 	.stepinfos = axg_stepinfo,
 	.nstepinfos = ARRAY_SIZE(axg_stepinfo),
-- 
2.35.0

