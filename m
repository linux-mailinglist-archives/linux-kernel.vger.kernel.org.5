Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8253C77487C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbjHHTdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236267AbjHHTdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:33:16 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D314AC791;
        Tue,  8 Aug 2023 12:04:58 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3784jWc9099071;
        Mon, 7 Aug 2023 23:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691469932;
        bh=gOn0Xm5Ns+UYBBHCJQY6EKsCBpx22wZiaoVRu7YAI+k=;
        h=From:To:CC:Subject:Date;
        b=rqr2b5PaKyOrcsbl3CuDDay802u2cvS9Dfq+opVKwjBwdlejXBOrxPYNhtnoFrMeD
         oRbzHCSDCXyxuDagw3FpjwhjSA/SE2aXEjFaRoj1vghCOXvNJGqdNorwcH1O5bbGre
         WJpZKXxq73hMFaMyRnJ+Qz2SSVm9e0SML32AaJC8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3784jWEb073740
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 23:45:32 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 23:45:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 23:45:32 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3784jWBQ017300;
        Mon, 7 Aug 2023 23:45:32 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <p.zabel@pengutronix.de>, <martyn.welch@collabora.com>,
        <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v5 0/5] TI K3 M4F support on AM64x and AM62x SoCs
Date:   Mon, 7 Aug 2023 23:45:24 -0500
Message-ID: <20230808044529.25925-1-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

The following series introduces K3 M4F remoteproc driver support for
AM64x and AM62x SoC families. These SoCs have a ARM Cortex M4F core in
the MCU voltage domain. For safety oriented applications, this core is
operated independently with out any IPC to other cores on the SoC.
However, for non safety applications, some customers use it as a remote
processor and so linux remote proc support is extended to the M4F core.

See AM64x Technical Reference Manual (SPRUIM2C – SEPTEMBER 2021) for
further details: https://www.ti.com/lit/pdf/SPRUIM2

Hari Nagalla (3):
  dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs
  arm64: dts: ti: k3-am62 : Add M4F remote proc node
  arm64: dts: ti: k3-am64 : Add M4F remote proc node

Martyn Welch (2):
  remoteproc: k3: Split out functions common with M4 driver
  remoteproc: k3-m4: Add a remoteproc driver for M4F subsystem

 .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 136 ++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi       |  12 +
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  19 +
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi       |  12 +
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       |  18 +
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        |  18 +
 drivers/remoteproc/Kconfig                    |  13 +
 drivers/remoteproc/Makefile                   |   3 +-
 drivers/remoteproc/ti_k3_common.c             | 513 +++++++++++++++
 drivers/remoteproc/ti_k3_common.h             | 108 ++++
 drivers/remoteproc/ti_k3_dsp_remoteproc.c     | 598 +-----------------
 drivers/remoteproc/ti_k3_m4_remoteproc.c      | 333 ++++++++++
 12 files changed, 1213 insertions(+), 570 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
 create mode 100644 drivers/remoteproc/ti_k3_common.c
 create mode 100644 drivers/remoteproc/ti_k3_common.h
 create mode 100644 drivers/remoteproc/ti_k3_m4_remoteproc.c

-- 
2.34.1

