Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D000C774B66
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjHHUqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjHHUqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:46:03 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E235F36851;
        Tue,  8 Aug 2023 09:36:51 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378DZ5Te081658;
        Tue, 8 Aug 2023 08:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691501705;
        bh=jy4GKmu9/yFWvhbR0WMZUXmg+/1eYfi+XlkukQq9/Sg=;
        h=From:To:CC:Subject:Date;
        b=Wfs+ElKzrMXopnxkB7DuRRHw6c8qsnLc8gjsSHLpX/3OIoYKSXFKWqtM8J/h+zofk
         AdSLCpUXu9wLI9XYmI+W05TSvCZWz6Gtl8Y5TgDKn7c5fFMGuBFDOgT24ZyfvNpBFd
         5Ejr151iPYBrD7Ee47h6LJfuppFRSlry6r9Pm/sk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378DZ5WG103118
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 08:35:05 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 08:35:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 08:35:05 -0500
Received: from fllv0039.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378DZ4Pq053163;
        Tue, 8 Aug 2023 08:35:04 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Dhruva Gole <d-gole@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2 00/13] Another round of K3 DTSI disables
Date:   Tue, 8 Aug 2023 08:34:44 -0500
Message-ID: <20230808133457.25060-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Similar to a couple previous series on this, we disable by default
nodes that cannot function standalone.

This helps prevent folks from forgetting to disable unused nodes
in their boards. One benefit of that is you can start out with
an almost empty DTS file for a new board and have it still
function without warnings or misbehaving hardware. Adding as you
go, this helps ease bringup and upstreaming of new boards.

Thanks,
Andrew

Changes for v2:
 - Added Reviewed-bys (thanks Dhruva)
 - Removed "default pins" comments for GPIO
 - Reworded message for 12/13 to make it more clear on dtsi files

Andrew Davis (13):
  arm64: dts: ti: k3-j721e: Enable SDHCI nodes at the board level
  arm64: dts: ti: k3-j7200: Enable SDHCI nodes at the board level
  arm64: dts: ti: k3-j721s2: Enable SDHCI nodes at the board level
  arm64: dts: ti: k3-am65: Enable OSPI nodes at the board level
  arm64: dts: ti: k3-j721e: Enable OSPI nodes at the board level
  arm64: dts: ti: k3-j7200: Enable OSPI nodes at the board level
  arm64: dts: ti: k3-am64: Enable OSPI nodes at the board level
  arm64: dts: ti: k3-j721e: Enable GPIO nodes at the board level
  arm64: dts: ti: k3-j721s2: Enable GPIO nodes at the board level
  arm64: dts: ti: k3-j7200: Enable GPIO nodes at the board level
  arm64: dts: ti: k3-j721e: Enable TSCADC nodes at the board level
  arm64: dts: ti: k3-am65: Enable TSCADC nodes at the board level
  arm64: dts: ti: k3-am64: Enable TSCADC nodes at the board level

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |  2 +
 .../boot/dts/ti/k3-am64-phycore-som.dtsi      |  1 +
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       |  1 +
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        |  5 +-
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   |  6 +-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  4 ++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts |  3 +
 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 24 +-------
 .../dts/ti/k3-j7200-common-proc-board.dts     | 19 ++----
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  6 ++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |  3 +
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   |  1 +
 .../boot/dts/ti/k3-j721e-beagleboneai64.dts   | 60 ++++---------------
 .../dts/ti/k3-j721e-common-proc-board.dts     | 42 ++++---------
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 11 ++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  6 ++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 57 ++----------------
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   |  1 +
 .../dts/ti/k3-j721s2-common-proc-board.dts    | 18 ++----
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    |  6 ++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  2 +
 21 files changed, 91 insertions(+), 187 deletions(-)

-- 
2.39.2

