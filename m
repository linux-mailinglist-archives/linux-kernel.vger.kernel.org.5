Return-Path: <linux-kernel+bounces-58866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D3E84EDD8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8141F23F4F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476A555760;
	Thu,  8 Feb 2024 23:24:48 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167CB54F9D;
	Thu,  8 Feb 2024 23:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434687; cv=none; b=IfYIsIMnghvR95MttK4wE1261hP1WDBmfGC3ew2/1BfkUFVhahb3OXKkz3SrC7OoR7wt5quLQD3sQE3qJpmO7z1hw2h1iitrzRV/M7bSiVlF5FBiX0BdY7UH9jl5oTKWCuEvOMfswcumct/RLcyXmcFCw8/Nh8aglHJCPFy8aSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434687; c=relaxed/simple;
	bh=iJ4h27b2stDbHUbzrUkIwBdpRJ0K3N623MbRZI78gZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=izg74EBX3FHxCCyFfxNLQF3XVeldryjUFYrECFZsJ1sgOCOI4SA6j9u06zC4pA28d9s3yt0RsXqw9MeE/vYQOR/zWqpi2imz2nKPCgkvoiN/SVgKBHDnsuW0rYUqW1djsIAGaMX9m40Gk2SpXvM9gbp+bOqWpbEzPks/tPofZ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.05,255,1701097200"; 
   d="scan'208";a="197291914"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 09 Feb 2024 08:24:38 +0900
Received: from mulinux.home (unknown [10.226.92.227])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 66D7C4009BDC;
	Fri,  9 Feb 2024 08:24:34 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v6 0/4] Add RZ/V2{M, MA} PWM driver support
Date: Thu,  8 Feb 2024 23:24:07 +0000
Message-Id: <20240208232411.316936-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RZ/V2{M, MA} PWM Timer (PWM) is composed of 16 channels.
Linux is only allowed access to channels 8 to 14 on RZ/V2M,
while there is no restriction for RZ/V2MA.

The RZ/V2{M, MA} PWM Timer (PWM) supports the following functions:
 * The PWM has 24-bit counters which operate at PWM_CLK (48 MHz).
 * The frequency division ratio for internal counter operation is
   selectable as PWM_CLK divided by 1, 16, 256, or 2048.
 * The period as well as the duty cycle is adjustable.
 * The low-level and high-level order of the PWM signals can be
   inverted.
 * The duty cycle of the PWM signal is selectable in the range from
   0 to 100%.
 * The minimum resolution is 20.83 ns.
 * Three interrupt sources: Rising and falling edges of the PWM signal
   and clearing of the counter.
 * Counter operation and the bus interface are asynchronous and both can
   operate independently of the magnitude relationship of the respective
   clock periods.

v5->v6:
 * Updated copyright in driver (2023->2024).
 * Several improvements to the driver, as suggested by Uwe.
v4->v5:
 * rebased to pwm for-next.
 * Sorted KConfig file
 * Sorted Make file
 * Updated copyright header 2022->2023.
 * Updated limitation section.
 * Replaced the variable chip->rzv2m_pwm in rzv2m_pwm_wait_delay()
 * Replaced polarity logic as per HW manual dutycycle = Ton/Ton+Toff, so
   eventhough native polarity is inverted from period point of view it
   is correct.
 * Updated logic for supporting 0% , 100% and remaining duty cycles.
 * On config() replaced
 * pm_runtime_resume_and_get()->pm_runtime_get_sync()
 * Counter is stopped while updating period/polarity to avoid glitches.
 * Added error check for clk_prepare_enable()
 * Introduced is_ch_enabled variable to cache channel enable status.
 * clk_get_rate is called after enabling the clock and
 * clk_rate_exclusive_get()
 * Added comment for delay
 * Replaced 1000000000UL->NSEC_PER_SEC.
 * Improved error handling in probe().
v3->v4:
 * Documented the hardware properties in "Limitations" section
 * Dropped the macros F2CYCLE_NSEC, U24_MASK and U24_MAX.
 * Added RZV2M_PWMCYC_PERIOD macro for U24_MAX
 * Dropped rzv2m_pwm_freq_div variable and started using 1 << (4 * i)
   for calculating divider as it is power of 16.
 * Reordered the functions to have rzv2m_pwm_config() directly before
   rzv2m_pwm_apply().
 * Improved the logic for calculating period and duty cycle in config()
 * Merged multiple RZV2M_PWMCTR register writes to a single write in
 * config()
 * replaced pwm_is_enabled()->pwm->state.enabled
 * Avoided assigning bit value as enum pwm_polarity instead used enum
 * constant.
 * Fixed various issues in probe error path.
 * Updated the logic for PWM cycle setting register
 * A 100% duty cycle is only possible with PWMLOW > PWMCYC. So
   restricting PWMCYC values < 0xffffff
 * The native polarity of the hardware is inverted (i.e. it starts with
 * the
 * low part). So switched the inversion bit handling.
v2->v3:
 * Removed clock patch#1 as it is queued for 6.3 renesas-clk
 * Added Rb tag from Geert for bindings and dt patches
 * Added return code for rzv2m_pwm_get_state()
 * Added comment in rzv2m_pwm_reset_assert_pm_disable()
v1->v2:
 * Updated commit description
 * Replaced pwm8_15_pclk->cperi_grpf
 * Added reset entry R9A09G011_PWM_GPF_PRESETN
 * Added Rb tag from Krzysztof for bindings and the keep the Rb tag as
   the below changes are trivial
 * Updated the description for APB clock
 * Added resets required property
 * Updated the example with resets property
 * Replaced
   devm_reset_control_get_optional_shared->devm_reset_control_get_shared
 * Added resets property in pwm nodes.

Biju Das (4):
  dt-bindings: pwm: Add RZ/V2M PWM binding
  pwm: Add support for RZ/V2M PWM driver
  arm64: dts: renesas: r9a09g011: Add pwm nodes
  arm64: dts: renesas: rzv2m evk: Enable pwm

 .../bindings/pwm/renesas,rzv2m-pwm.yaml       |  90 ++++
 .../boot/dts/renesas/r9a09g011-v2mevk2.dts    |  70 +++
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |  98 ++++
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-rzv2m.c                       | 469 ++++++++++++++++++
 6 files changed, 739 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzv2m-pwm.yaml
 create mode 100644 drivers/pwm/pwm-rzv2m.c

-- 
2.34.1


