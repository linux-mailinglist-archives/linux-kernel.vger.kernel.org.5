Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672917840B8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbjHVM0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbjHVM0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:26:00 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D64D1B2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:25:57 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 7983712000D;
        Tue, 22 Aug 2023 15:25:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7983712000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1692707154;
        bh=hGLCpp8kF6fiAnZ+P/Yb76gyGxaPZI9c6OUPVuPR9xE=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=cba8YCe7I0zCib6OiN7uC7RpNlN+ExWjAM3KEAw5YMkMpTTo8pTlZHBUu1lkbloMa
         pGEHzC37zErzP7RT4YR2Dm5xfEHZ5HIal+o/iX6fGp26quv3fKKkj1y3HsWUCFQ1YH
         QMt0JnjA4fF12jZmQhNUsfgUSUibVMj3qP1AdvPmZWKg5nH8rfPrGpvIBdmKPm7Cdz
         +DxHSt8pFX+EXX50YxNR5d/tMagf/igxVHtKgg4FsZ06/0GwqtAGTMYWWINlpDFMMM
         /dGTlpcxrubccKcPgIbdzfQ3BPcLva+QQ80p9Vta7MEX2alzEiOWxGzEVNClqxqckC
         OuQ/ExnaixcNw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue, 22 Aug 2023 15:25:54 +0300 (MSK)
Received: from CAB-WSD-0004828.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 22 Aug 2023 15:25:52 +0300
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v2 1/2] mtd: spinand: micron: correct bitmask for ecc status
Date:   Tue, 22 Aug 2023 15:25:33 +0300
Message-ID: <20230822122534.872646-2-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230822122534.872646-1-mmkurbanov@sberdevices.ru>
References: <20230822122534.872646-1-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179374 [Aug 22 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 527 527 5bb611be2ca2baa31d984ccbf4ef4415504fc308, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/08/22 09:22:00 #21674243
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valid bitmask is 0x70 in the status register.

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
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

