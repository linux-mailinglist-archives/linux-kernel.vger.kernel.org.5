Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2514E7F44BB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjKVLLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjKVLLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:11:36 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF8ED8;
        Wed, 22 Nov 2023 03:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700651493; x=1732187493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bqZy+15bGo0cAdv3T10s82WMPZ8WYesT6PFaGMF8gZQ=;
  b=vwdiwioZydBIWvwyyGiELvkWNuiTRl3OPS/tCKiaN184v4a2H6UHnZxg
   MIX0mMwJwYUYHy29D0/+ABKMlgigIvMeCy9YYde3bDIXykmn8ZgVa0kPJ
   kCLXnLhSyPO46FoaRozaH1LPnIommQWOtFDjJs4LtIzCRkVKtHJDt9PzD
   yHARgDmbntFu2r7FgPcja13euXuo23d+t4S26jawGMeNcxRZ2qj1dpKns
   F4XRe89hHjMkxWRBXQpcW7TF4ipGNEiuOLDFsUzp5O26+klcWzUGcm+ud
   LDi0jtSMS3m/G7Y0emfgUE5kvmgG/5ZHqm7Bb6Yu4+zYbQdELhY66WTuG
   A==;
X-CSE-ConnectionGUID: pzcGjbUNQWmjzz0egclpxw==
X-CSE-MsgGUID: AdC0IIYsSDao5AmsIV7zzw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="179248509"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Nov 2023 04:11:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Nov 2023 04:11:10 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 22 Nov 2023 04:11:08 -0700
From:   <marius.cristea@microchip.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <marius.cristea@microchip.com>
Subject: [PATCH v1] iio: adc: MCP3564: fix hardware identification logic
Date:   Wed, 22 Nov 2023 13:11:06 +0200
Message-ID: <20231122111106.45288-1-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marius Cristea <marius.cristea@microchip.com>

In mcp3564_config() fix the hardware identification logic
based on the hardware ID registers. Second part of the code was
disabled by an logic error.
Fix a typo related to the "MODULE_DESCRIPTION".

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 drivers/iio/adc/mcp3564.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index e3f1de5fcc5a..e914a885a868 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -1122,7 +1122,7 @@ static int mcp3564_config(struct iio_dev *indio_dev)
 	enum mcp3564_ids ids;
 	int ret = 0;
 	unsigned int tmp = 0x01;
-	bool err = true;
+	bool err = false;
 
 	/*
 	 * The address is set on a per-device basis by fuses in the factory,
@@ -1509,5 +1509,5 @@ static struct spi_driver mcp3564_driver = {
 module_spi_driver(mcp3564_driver);
 
 MODULE_AUTHOR("Marius Cristea <marius.cristea@microchip.com>");
-MODULE_DESCRIPTION("Microchip MCP346x/MCP346xR and MCP356x/MCP346xR ADCs");
+MODULE_DESCRIPTION("Microchip MCP346x/MCP346xR and MCP356x/MCP356xR ADCs");
 MODULE_LICENSE("GPL v2");

base-commit: 6543f376ec8aa90a6c1ed44b765f4f0d6c3eb1db
-- 
2.34.1

