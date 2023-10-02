Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C917B582A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbjJBQQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238488AbjJBQQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:16:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63889E;
        Mon,  2 Oct 2023 09:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696263389; x=1727799389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DPrZPdYeRNfXZOtbRB8PnTVno3GzcqOBQS4+4QktUg4=;
  b=lu8FI5Q/DBu+DUAfA7dIG6R/munxfToM5VLF8zyz56uM6I/YVxSaGXSG
   s/dFBKkd4CxsjMputLBUnB+2DZHClgj/5zWvbYJtXLZ1hm5rj0vRz7w/q
   W28497nGRh4RMwpO2C6E5hBolRIDNVJY1WGAv2DtiN7TuPI1YH2IXWan9
   jBle+S1ccjNcXa1sDfthA1KpWwZuXXbEVEKrX8kY6ftBZSBaUZoqBYNVx
   UAorNKaOyZPbJOUK1KUUjeJNq+PM+v3OLoHJXrkcsDiDUp7iOdF0K1AYg
   ljYlkw3CK7IxeVPRXXd4ZwdqdGs4/Nu/2n3Xsu4j7lo3gxnvk58QTEnMo
   Q==;
X-CSE-ConnectionGUID: M5MHFYEZQ66VfybJvKr2SQ==
X-CSE-MsgGUID: yuxl+01OQCaK38yX3xDJQg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="7940525"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2023 09:16:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 2 Oct 2023 09:16:28 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 2 Oct 2023 09:16:27 -0700
From:   <marius.cristea@microchip.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <marius.cristea@microchip.com>
Subject: [PATCH v1] iio: adc: MCP3564: fix warn: unsigned '__x' is never less than zero.
Date:   Mon, 2 Oct 2023 19:16:18 +0300
Message-ID: <20231002161618.36373-1-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marius Cristea <marius.cristea@microchip.com>

The patch efea15e3c65d: "iio: adc: MCP3564: fix the static checker warning"
leads to the following Smatch static checker warning:

   smatch warnings:
   drivers/iio/adc/mcp3564.c:1105 mcp3564_fill_scale_tbls() warn: unsigned '__x' is never less than zero.

vim +/__x +1105 drivers/iio/adc/mcp3564.c

   1094
   1095  static void mcp3564_fill_scale_tbls(struct mcp3564_state *adc)
   1096  {
   .....
   1103          for (i = 0; i < MCP3564_MAX_PGA; i++) {
   1104                  ref = adc->vref_mv;
 > 1105                  tmp1 = shift_right((u64)ref * NANO, pow);
   1106                  div_u64_rem(tmp1, NANO, &tmp0);
   1107
   .....
   1113  }

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309280738.NWjVfVt4-lkp@intel.com/
Fixes: efea15e3c65d (iio: adc: MCP3564: fix the static checker warning)
Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 drivers/iio/adc/mcp3564.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index 9ede1a5d5d7b..e3f1de5fcc5a 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -1102,7 +1102,7 @@ static void mcp3564_fill_scale_tbls(struct mcp3564_state *adc)
 
 	for (i = 0; i < MCP3564_MAX_PGA; i++) {
 		ref = adc->vref_mv;
-		tmp1 = shift_right((u64)ref * NANO, pow);
+		tmp1 = ((u64)ref * NANO) >> pow;
 		div_u64_rem(tmp1, NANO, &tmp0);
 
 		tmp1 = tmp1 * mcp3564_hwgain_frac[(2 * i) + 1];

base-commit: 5e99f692d4e32e3250ab18d511894ca797407aec
-- 
2.34.1

