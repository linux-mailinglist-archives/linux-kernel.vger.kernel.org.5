Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FA47B1750
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjI1J0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjI1JZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:25:23 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE4310DE;
        Thu, 28 Sep 2023 02:25:16 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38S9P1JF118832;
        Thu, 28 Sep 2023 04:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695893101;
        bh=p9ke9yR4lxAzb71HYkGxjOjuDERO4DFpweRDLMyT/GY=;
        h=From:Subject:Date:To:CC;
        b=LcfNF9pKydt3FbsTG+v4J4IS4xBdsqeCrdKF8huDtX7oegJzO7ZAbjg3BQlEUwnoC
         iKocQhz9SXevLZRA3+lSuVLG9WpVb90ejdhoxBSL2KF+Lbuf5GYWj/3vKOitnYrP77
         Rmhvun0cEHFVU5G73W93kLlSGJABUJkAAeUr8mhM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38S9P1NK012654
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Sep 2023 04:25:01 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Sep 2023 04:25:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Sep 2023 04:25:01 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38S9P0Ao021772;
        Thu, 28 Sep 2023 04:25:00 -0500
From:   Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v2 0/6] arm64: ti: Enable audio on AM62A
Date:   Thu, 28 Sep 2023 14:54:25 +0530
Message-ID: <20230928-mcasp_am62a-v2-0-ce9f0e1ba22b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAElGFWUC/23MQQ7CIBCF4as0sxbDgIHqqvcwjUEKdhaUBhqia
 bi72LXL/yXv2yG7RC7DrdshuUKZ4tJCnDqws1lejtHUGgQXkmuJLFiT14cJShhmPCrFlbj4q4b
 2WJPz9D60+9h6przF9Dnwgr/1v1OQcdY/J5Tae9N7HDY62xhgrLV+AYLJ/c6jAAAA
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devarsht@ti.com>, <a-bhatia1@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Julien Panis <jpanis@baylibre.com>,
        Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=BHtCb2PMXGV0tQRjk09OqvvmhzCZSOL04njidPR9a8c=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlFUZgwirUMDt1tyJ3P47oSRFPJkrvAAdCz0/7/
 muummsYJzOJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZRVGYAAKCRBD3pH5JJpx
 RRgKEACRSnxhjrepqp+KSFnZNvl7Z0rz6G3T3BwdLOnQH+mWlyCz3+jYPvO+k0QBs/lGQiVum/a
 Y2dJRBpZUbVHze++aEmiazKplovdOZQesCaa8+5s9eeF2bH3mRsYeoufIsFhhIMYMfBpRJHXP5t
 PxjyGdMpX+vIdhLHXHpKvdepLAwGs6o5d77AD8218XuyTqUoVrRGq6Wb2wKgwbqr2OWFShxe0Kv
 XPhJXiVHa2zY/58PNo468ZbaVsKqZlnnC/w7qjbZIOxw2yVA1x3qDkYt8bgIcLKTJyULOyNkoC6
 B7NWpAZsJeTLWk07FRxmfh8yogTD6xlHBrqIXM1tktZ3LPB6F4zFnheIjtswsPozSXTO1UPk12D
 DVq5jUcaQBUuhvzujuGm5EszFMj45bBREXczZ/vVvO3Hm62A2bokUj/k262m/sP6Dmt8hZoc1qq
 M8gtK692DHJtahmWr3iWCGOUlkE8o3n4vcwO8XwS4R0KqvEgdWoZf2APkLEicfrlcy4fsBdxyRA
 74HUYr8xBvdGmcnRFVsc+yE902Rb8Wj2Ny3oH9eoojEbel0A1YisY5XYnsXXw875F3hoZpZT25Y
 R3i15+/iLsaHQNwtKjfoQ5kL0aAWskb7MPbTpZbgTpj5IqkORlNn7O4Nwleu9rdgdUO3k6zliVO
 TN3KFf1mFMv2vuA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for audio via headphone jack on
SK-AM62A-LP. The jack is wired to TLV320AIC3106 (codec), which is
connected to McASP1 (serializer) on the SoC.

The TRRS 3.5mm jack can be used for simultaneous playback and recording.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Changes in v2:
- Move the patch that enables TPS6593 PMIC to this series
- Link to v1: https://lore.kernel.org/r/20230731-mcasp_am62a-v1-0-8bd137ffa8f1@ti.com

---
Jai Luthra (5):
      arm64: dts: ti: k3-am62a-main: Add nodes for McASP
      arm64: dts: ti: k3-am62a7-sk: Split vcc_3v3 regulators
      arm64: dts: ti: k3-am62a7-sk: Drop i2c-1 to 100Khz
      arm64: dts: ti: k3-am62a7-sk: Enable audio on AM62A
      arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A

Julien Panis (1):
      arm64: dts: ti: k3-am62a7-sk: Add support for TPS6593 PMIC

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi |  60 ++++++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts   | 189 +++++++++++++++++++++++++++++-
 arch/arm64/configs/defconfig              |   1 +
 3 files changed, 247 insertions(+), 3 deletions(-)
---
base-commit: 18030226a48de1fbfabf4ae16aaa2695a484254f
change-id: 20230731-mcasp_am62a-af1660624f97

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>

