Return-Path: <linux-kernel+bounces-5240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98096818860
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3053A285A83
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A61D19464;
	Tue, 19 Dec 2023 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="YkMd9YAQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8519BD9;
	Tue, 19 Dec 2023 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BJAp1BU015045;
	Tue, 19 Dec 2023 14:09:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=3XPfSMe
	xOVKWq+whcvLdlAIAFwG0ty//S+OEFdiBKgk=; b=YkMd9YAQpyTQ+2dnEGmDKwY
	WOaUJm/2nB1y9nRMV56NSFa1fV3Vn7/mAegQ5RYmxrKko5yu4T7bMKs+INBYiRBT
	jNAdGJHVMcFGgsMhNEOT9WyrMPR6kmHwTOE327bVdQV4MpCcFCAIM9awiVXOBUuW
	VwLq+yBx3nJUnICvNpzeH/kWBaTl1K/VtPbEtTOzAUOBzzbpvkUVvHPYNg8tEBuF
	X2vCzhHbFB+k3WxTH3tUaK6N70EbspT6Kuhr45VykAICAzK9o7MRxi/iNQf7DQtf
	zaq4JnFrAYErfBL7gj4oxqufGUvtEb01G11PwIak7iRi3V2hisgWSquQyoZ6gCQ=
	=
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v1pb4jdtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 14:09:20 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6F74C100059;
	Tue, 19 Dec 2023 14:09:19 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6495A227896;
	Tue, 19 Dec 2023 14:09:19 +0100 (CET)
Received: from localhost (10.201.21.240) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Dec
 2023 14:09:19 +0100
From: <gabriel.fernandez@foss.st.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/2] Introduce STM32MP257 clock driver
Date: Tue, 19 Dec 2023 14:09:07 +0100
Message-ID: <20231219130909.265091-1-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_08,2023-12-14_01,2023-05-22_02

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

v7: base on next-20231219
  - These patches below are applied to clk-next:
      clk: stm32mp1: move stm32mp1 clock driver into stm32 directory
      clk: stm32mp1: use stm32mp13 reset driver
      dt-bindings: stm32: add clocks and reset binding for stm32mp25
  - remove unnecessary includes
  - migrate clock parents to struct clk_parent_data and remove
    CLK_STM32_XXX() macros  to have a more readble code
  - use platform device APIs (devm_of_iomap() instead of_iomap())
  - move content of stm32mp25_rcc_init() to stm32mp25_rcc_clocks_probe()
  - simply get_clock_deps()
  - add const to stm32mp25_data struct
  - remove ck_icn_p_serc clock (will be integrate later with security
    management)

v6:
  - remove useless defines in drivers/clk/stm32/stm32mp25_rcc.h

v5:
  - Fix sparse warnings: was not declared. Should it be static?
    drivers/clk/stm32/clk-stm32mp13.c:1516:29: symbol 'stm32mp13_reset_data'
    drivers/clk/stm32/clk-stm32mp1.c:2148:29: symbol 'stm32mp1_reset_data'
    drivers/clk/stm32/clk-stm32mp25.c:1003:5: symbol 'stm32mp25_cpt_gate'
    drivers/clk/stm32/clk-stm32mp25.c:1005:29: symbol 'stm32mp25_clock_data'
    drivers/clk/stm32/clk-stm32mp25.c:1011:29: symbol 'stm32mp25_reset_data'

v4:
  - use GPL-2.0-only OR BSD-2-Clause for clock and reset binding files
  - use quotes ' for #clock-cells and #reset-cells in YAML documentation
  - reset binding start now to 0 instead 1
  - improve management of reset lines that are not managed

v3:
  - from Rob Herring change clock item description in YAML documentation
v2:
  - rework reset binding (use ID witch start from 0)
  - rework reset driver to manage STM32MP13 / STM32MP15 / STM32MP25
  - rework YAML documentation

Gabriel Fernandez (2):
  clk: stm32: introduce clocks for STM32MP257 platform
  arm64: dts: st: add rcc support in stm32mp251

 arch/arm64/boot/dts/st/stm32mp251.dtsi |   59 +-
 drivers/clk/stm32/Kconfig              |    7 +
 drivers/clk/stm32/Makefile             |    1 +
 drivers/clk/stm32/clk-stm32mp25.c      | 1826 ++++++++++++++++++++++++
 drivers/clk/stm32/reset-stm32.c        |   59 +-
 drivers/clk/stm32/reset-stm32.h        |    7 +
 drivers/clk/stm32/stm32mp25_rcc.h      |  712 +++++++++
 7 files changed, 2628 insertions(+), 43 deletions(-)
 create mode 100644 drivers/clk/stm32/clk-stm32mp25.c
 create mode 100644 drivers/clk/stm32/stm32mp25_rcc.h

-- 
2.25.1


