Return-Path: <linux-kernel+bounces-127977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AF38953F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267412869AB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07031823DD;
	Tue,  2 Apr 2024 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VQopndSg"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBAC7FBA3;
	Tue,  2 Apr 2024 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062479; cv=none; b=ebMA4+dT6U8tvGheFajGuTdH9YM6NEk2wgH6hH7ay21F4Yu9u5WHztJuaXxnJPExqz7RaqfIbWh3rks1UQsqbGoo402p9lUuS/2wpLqWvewfSPMQW54gnL1qmeQ1QkPPSkzaXYXg+mg+Tjr1CPYGaHI715gylFl1POlK+hldfYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062479; c=relaxed/simple;
	bh=PK+HEVqFsevHHF+17hPtIOkqwfqfNEdE0CdmS3ZYJZM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PRoc1eofUk/Lei+98N3bjibLlYhRyuxoMzDdKGu+JtW8CrIP5z+uvB0cdctEHXRPs1MmBtKYJrK6Gn6JZOxyeWhbzmOnNKyJ8yf6RZZHVoF+wwvvlAuS64wBk6uEjFGk5y4SwqC27Mb+fyj8UgGdTDSb98KkcKWVxosje4BiCnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VQopndSg; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432B9Gre019355;
	Tue, 2 Apr 2024 14:54:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=zaPY/Fi
	i7n1522i/lEuTYz0M022TA0flX4c6e/PmMDY=; b=VQopndSg9oLaZb/OAqSajRM
	iaQYlIZ9YwfwMCHZb+anFPyjlSKHsPFgrTsWsggWm3hUNpyxKEAjc3K3nCByAYqI
	Pz5JPtXEtGgIm/vlIlLzb7yo45eXXyBew4kswO9e9KG31XhQ1hAmA44xhD6TvDEG
	h1xreepUvy0/wdBGupmMfBFt6H77DHgFPXdi0LxueDAdHSkkGfjn96RkgeI4UVze
	Wcli73jinh7Ng1LUJGpty8aJzeuSNdkeI7+5HJvevaCpqg1wCIpWQBtm/O+7BUZw
	vYPn70moebjo9N2SQBtq9Q2tuUfiOuRaF0IhPilY+vFgKNjiHnlgfNMXLZanTXw=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x691m4hkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 14:54:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DCA6740044;
	Tue,  2 Apr 2024 14:54:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 609A621B531;
	Tue,  2 Apr 2024 14:53:15 +0200 (CEST)
Received: from localhost (10.201.21.240) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 2 Apr
 2024 14:53:15 +0200
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
Subject: [RESEND PATCH v9 0/4] Introduce STM32MP257 clock driver
Date: Tue, 2 Apr 2024 14:53:08 +0200
Message-ID: <20240402125312.277052-1-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_06,2024-04-01_01,2023-05-22_02

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

v9: base on next-20240207
  - update dt binding documentation with v8 modidification on RCC driver
    (use .index of clk_parent_data struct to define a parent)
  - rebase patch "arm64: dts: st: add rcc support for STM32MP25"
     with next-20240207 tag

v8:
  - use .index of clk_parent_data struct to define a parent
  - remove unnecessary dependency check with SCMI clock driver
  - convert to platform device APIs
  - convert to devm_of_clk_add_hw_provider()
  - convert single value enum to a define

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

Gabriel Fernandez (4):
  clk: stm32mp13: use platform device APIs
  dt-bindings: stm32: update DT bingding for stm32mp25
  clk: stm32: introduce clocks for STM32MP257 platform
  arm64: dts: st: add rcc support for STM32MP25

 .../bindings/clock/st,stm32mp25-rcc.yaml      |  171 +-
 arch/arm64/boot/dts/st/stm32mp251.dtsi        |  144 +-
 arch/arm64/boot/dts/st/stm32mp255.dtsi        |    4 +-
 drivers/clk/stm32/Kconfig                     |    7 +
 drivers/clk/stm32/Makefile                    |    1 +
 drivers/clk/stm32/clk-stm32-core.c            |   11 +-
 drivers/clk/stm32/clk-stm32mp13.c             |   72 +-
 drivers/clk/stm32/clk-stm32mp25.c             | 1876 +++++++++++++++++
 drivers/clk/stm32/reset-stm32.c               |   59 +-
 drivers/clk/stm32/reset-stm32.h               |    7 +
 drivers/clk/stm32/stm32mp25_rcc.h             |  712 +++++++
 11 files changed, 2922 insertions(+), 142 deletions(-)
 create mode 100644 drivers/clk/stm32/clk-stm32mp25.c
 create mode 100644 drivers/clk/stm32/stm32mp25_rcc.h

-- 
2.25.1


