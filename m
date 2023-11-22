Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417797F4B59
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344591AbjKVPo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344463AbjKVPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:44:31 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1FF1722;
        Wed, 22 Nov 2023 07:42:53 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFgkoF031020;
        Wed, 22 Nov 2023 09:42:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700667766;
        bh=DLJe1Pv87UHy4+v/+5Kl00sc0UqsngVKRFxbrZDoRBc=;
        h=From:To:CC:Subject:Date;
        b=mji1BkSeSk8jptEDhZpS9TG7R2mKKMR2VLHw0WFskUBSkNtKuiospkQSzYFuezXWv
         maYIxJIFzleiV9fuBCC5pEkWrgABRPWkz6qWW7MOcMzn2iRLlZjOJzd3PQs+mA3VPR
         7xjLF7FsySaoedySQEEVOP/Dizw3LS6+/GpDLbk8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AMFgkMn011949
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Nov 2023 09:42:46 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 09:42:45 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 09:42:45 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFggJl046973;
        Wed, 22 Nov 2023 09:42:43 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/4] dt-bindings: dma: ti: k3*: Update optional reg regions
Date:   Wed, 22 Nov 2023 21:12:34 +0530
Message-ID: <20231122154238.815781-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMAs on TI K3 SoCs have channel configuration registers region which are
usually hidden from Linux and configured via Device Manager Firmware
APIs. But certain early SWs like bootloader which run before Device
Manager is fully up would need to directly configure these registers and
thus require to be in DT description.

This add bindings for such configuration regions. Backward
compatibility is maintained to existing DT by only mandating existing
regions to be present and this new region as optional.

This update is mainly to aid SPL/U-Boot to reuse kernel DT as is. And is
applicable to entire K3 family of SoCs.

v2:
Fix issues pointed out by Conor and Peter
* Add new patch 1/4 to describe existing register regions
* Rename cfg region as ring
* Add bchan register space for bcdma
* Include descriptions for new registers
v1: https://lore.kernel.org/all/20230810174356.3322583-1-vigneshr@ti.com/

Vignesh Raghavendra (4):
  dt-bindings: dma: ti: k3-*: Add descriptions for register regions
  dt-bindings: dma: ti: k3-bcdma: Describe cfg register regions
  dt-bindings: dma: ti: k3-pktdma: Describe cfg register regions
  dt-bindings: dma: ti: k3-udma: Describe cfg register regions

 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 43 +++++++++++++------
 .../devicetree/bindings/dma/ti/k3-pktdma.yaml | 26 +++++++++--
 .../devicetree/bindings/dma/ti/k3-udma.yaml   | 20 +++++++--
 3 files changed, 71 insertions(+), 18 deletions(-)

-- 
2.42.0

