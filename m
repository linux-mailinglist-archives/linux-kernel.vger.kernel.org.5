Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C91792B89
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244861AbjIEQy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354840AbjIEO44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:56:56 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8863C18C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 07:56:51 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 85490100023;
        Tue,  5 Sep 2023 17:56:48 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 85490100023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1693925808;
        bh=j9WIM1QwjBQaTjxYjUQA7Rlw46Hleq4M73BzeKtUxCA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=SWyAwGXWBWuzrAxrV5mQGBGpQ3HBlWtnGQ8PD7Vwj44nclVuVbHc1rt0Sw8kwO63W
         BJ7O0cU+1oZr0cBCZ3KmlOHD4/kW6vsxbOMHtvMP8uAjFlrVXionpuQ2eeEs6WG7ur
         fDVnUrWCMZ3mSnBDQVCHWE+PfiXd1aJuFPA7ue83m6uekxiuTXDzlZK/vvOl56Xh3S
         kQkoB8JFShEWrRhVj/ufbP8i1GzMw2pC9BUApOtBPnnUXljrWL2lcc2mFxJidYauTk
         feRbtXIIIdavmzghY6/jwIaE3YEMPJxrYn2tVVb5ouTZN0NrWdGLr5pL+8AB0MrH7f
         XbYaAVLY4AQrw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue,  5 Sep 2023 17:56:48 +0300 (MSK)
Received: from CAB-WSD-0004828.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 5 Sep 2023 17:56:46 +0300
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH v3] mtd: spinand: micron: correct bitmask for ecc status
Date:   Tue, 5 Sep 2023 17:56:37 +0300
Message-ID: <20230905145637.139068-1-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179666 [Sep 05 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 530 530 ecb1547b3f72d1df4c71c0b60e67ba6b4aea5432, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/09/05 13:24:00
X-KSMG-LinksScanning: Clean, bases: 2023/09/05 13:24:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/09/05 12:20:00 #21804326
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valid bitmask is 0x70 in the status register.

Fixes: a508e8875e13 ("mtd: spinand: Add initial support for Micron MT29F2G01ABAGD")
Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes v3 since v2 at [1]:
  - Remove the commit for fixing OOB layout.
  - Add Fixes tag.

Changes v2 since v1 at [2]:
  - Split into two individual patches.
  - Remove the fix for using only non-protected ECC bytes from OOB area.

Links:
  [1] https://lore.kernel.org/all/20230822122534.872646-1-mmkurbanov@sberdevices.ru/
  [2] https://lore.kernel.org/all/20230815161024.810729-1-mmkurbanov@sberdevices.ru/

 drivers/mtd/nand/spi/micron.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 50b7295bc922..12601bc4227a 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -12,7 +12,7 @@

 #define SPINAND_MFR_MICRON		0x2c

-#define MICRON_STATUS_ECC_MASK		GENMASK(7, 4)
+#define MICRON_STATUS_ECC_MASK		GENMASK(6, 4)
 #define MICRON_STATUS_ECC_NO_BITFLIPS	(0 << 4)
 #define MICRON_STATUS_ECC_1TO3_BITFLIPS	(1 << 4)
 #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
--
2.40.0

