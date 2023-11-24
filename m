Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088677F6B86
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 05:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjKXE55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 23:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXE54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 23:57:56 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEDCD67;
        Thu, 23 Nov 2023 20:58:02 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AO4vs48103199;
        Thu, 23 Nov 2023 22:57:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700801874;
        bh=DudPOU9UQ3hB64Er+3q7A3laXlUnc064WgE+sKHDjLk=;
        h=From:To:CC:Subject:Date;
        b=GJsFN6QQAukkj9vjtcsko9NqOgLD1Ta1gryqq51BNhVtda28slmL8g0izQI/n06r4
         Y6+JSgy4CQRmw9s7lNbPQb7rMaq7stRCb7CKuVSvVMeZzuWCQ4OtypTpX3m3kc4zv8
         cOwp2gRKNPEA1wTfuBVTEyq4A0ZqfXyCOCUrL/vQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AO4vsc4080853
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Nov 2023 22:57:54 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Nov 2023 22:57:54 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Nov 2023 22:57:54 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AO4vo8f004756;
        Thu, 23 Nov 2023 22:57:51 -0600
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
Subject: [PATCH v3 0/4]  dt-bindings: dma: ti: k3*: Update optional reg regions
Date:   Fri, 24 Nov 2023 10:27:18 +0530
Message-ID: <20231124045722.191817-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

This add bindings for such configuration regions.  Backward
compatibility is maintained to existing DT by only mandating existing
regions to be present and this new region as optional.

This update is mainly to aid SPL/U-Boot to reuse kernel DT as is. And is
applicable to entire K3 SoCs.

v3:
Add back toplevel reg and reg-names constraints in k3-bcdma.yaml
v2: https://lore.kernel.org/all/20231122154238.815781-1-vigneshr@ti.com

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

 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 39 ++++++++++++++++---
 .../devicetree/bindings/dma/ti/k3-pktdma.yaml | 26 +++++++++++--
 .../devicetree/bindings/dma/ti/k3-udma.yaml   | 20 ++++++++--
 3 files changed, 73 insertions(+), 12 deletions(-)

-- 
2.43.0

