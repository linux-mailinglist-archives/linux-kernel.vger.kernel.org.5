Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39917DC5E0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjJaF1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJaF1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:27:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49037C1;
        Mon, 30 Oct 2023 22:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698730021; x=1730266021;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iRvap8S+l6/iAjI+NYP2vz5PJ2QlTLfvmIyoMb9M6DY=;
  b=sqJCZLm1Ql/FXv7CNWnOM7r7uE5cV6Dt1E4GyclqOdfkScab0uCDmCbE
   DDX8su3BzPUn5+uncyONzrm7h/SSp8Ik0qeztVjPCyaWr1WPY3Yjy3qts
   MKHdThSG7Bp3hD2sogHP7VhuOwzTrBQagQvSgPmVPJIcDTDdsy3hgL/EO
   aiB/SKcmk3sjqjv61aijEF5sibYQgQjouq1Q2Iyl3JEH/+KdOQQTZOcpn
   FAGOovLOtntTRAiQ4Z4Cqjf83HVLrLfx461NujaksiXR6W6FoBj4MpNFl
   tuGqPMjxmaMbhfDrzFWuxMgFI5PMLgyrQ/AKhcbXGmOyqw9UaOXwcGtu4
   w==;
X-CSE-ConnectionGUID: chmGaGncRm67Nps8P+k0sw==
X-CSE-MsgGUID: AVwFY3bkSHuO/Xm9QlHChQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="10872646"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2023 22:27:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 30 Oct 2023 22:26:43 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 30 Oct 2023 22:26:38 -0700
From:   shravan chippa <shravan.chippa@microchip.com>
To:     <green.wan@sifive.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <conor+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasuresh.relli@microchip.com>, <praveen.kumar@microchip.com>,
        <shravan.chippa@microchip.com>
Subject: [PATCH v4 0/4] dma: sf-pdma: various sf-pdma updates for the mpfs platform
Date:   Tue, 31 Oct 2023 10:57:49 +0530
Message-ID: <20231031052753.3430169-1-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

Changes from V3 -> V4:

Removed unnecessary parentheses and extra space
Added review tags

Changes from V2 -> V3:

Removed whitespace
Change naming convention of the macros (modified code as per new macros)
updated with new API device_get_match_data()
modified dt-bindings as per the commmets from v2
modified compatible name string for mpfs platform

Changes from V1 -> V2:

Removed internal review tags
Commit massages modified.
Added devicetree patch with new compatible name for mpfs platform
Added of_dma_controller_free() clenup call in sf_pdma_remove() function

V1:

This series does the following
1. Adds a PolarFire SoC specific compatible and code to support for
out-of-order dma transfers 

2. Adds generic device tree bindings support by using 
of_dma_controller_register()

Shravan Chippa (4):
  dmaengine: sf-pdma: Support of_dma_controller_register()
  dt-bindings: dma: sf-pdma: add new compatible name
  dmaengine: sf-pdma: add mpfs-pdma compatible name
  riscv: dts: microchip: add specific compatible for mpfs' pdma

 .../bindings/dma/sifive,fu540-c000-pdma.yaml  |  1 +
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |  2 +-
 drivers/dma/sf-pdma/sf-pdma.c                 | 71 ++++++++++++++++++-
 drivers/dma/sf-pdma/sf-pdma.h                 |  8 ++-
 4 files changed, 77 insertions(+), 5 deletions(-)

-- 
2.34.1

