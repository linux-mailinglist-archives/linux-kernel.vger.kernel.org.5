Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB277C86BB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjJMNYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjJMNYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:24:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4709EC0;
        Fri, 13 Oct 2023 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697203456; x=1728739456;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qbYnMk/PklOc0qHxIL6AsmTgq+JW0Tw9jXwiPLpTzqA=;
  b=bkVYaM7Hk5xiBe0akduqH+MgoNvab0JyZId8aBPhcMWTNMQagdPTdr4f
   /w64vHcEWj4h2br5d0luVLtSGjKtuqnAx0aZlkT750uBRC5+P41m1yz48
   CT5fussSnBvCSYWPQuHUnT0sFQP0CqO79vUxOfosjP1KIHk1/qGWLIvBX
   rR4Rxt2Zs/b4QioIrhQJwEBFCouOhshrUuYzu7fTZOiHHWEf2v8fSoQSb
   3BMTghQsI0PsAkjCX15s2y68dwbhkedkpRimb4AnhvpVDuJaiXhn/exbH
   NYuWK19lLASkb5acRu5Z8Uhl9d93yf1Rpi6MAauPU0ypAvURPqXiX773/
   w==;
X-CSE-ConnectionGUID: wo16nO66Q8+fbxSUIcLVMQ==
X-CSE-MsgGUID: Rhe3GexBQSuFx8F9wttwvA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="9931472"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2023 06:24:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 13 Oct 2023 06:23:37 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 13 Oct 2023 06:23:35 -0700
From:   <marius.cristea@microchip.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <marius.cristea@microchip.com>
Subject: [PATCH v2] iio: adc: MCP3564: fix warn: unsigned '__x' is never less than zero.
Date:   Fri, 13 Oct 2023 16:23:33 +0300
Message-ID: <20231013132333.10582-1-marius.cristea@microchip.com>
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

The patch 33ec3e5fc1ea: "iio: adc: adding support for MCP3564 ADC"
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
Fixes: 33ec3e5fc1ea (iio: adc: adding support for MCP3564 ADC)
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

