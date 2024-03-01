Return-Path: <linux-kernel+bounces-88842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD2686E762
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E811C24DD9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE00725610;
	Fri,  1 Mar 2024 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ay3h0ZBm"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A0227451
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314432; cv=none; b=W/r4VkJ1nEBs9H+RijoFiAfChU5O5YUlH1LdRz4v957GNfIT3Jv4VCUMPytSL5JpIJhNL2Ddf+0XMd6gk7HC3WWqjECH2ZUSB3kwHORg1dZ7Q56Ay8L1mx4lQ/p6KrCFnufk1uG1GtPaMdphjd4OkKyqS7GzMi790uqOB2LrCMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314432; c=relaxed/simple;
	bh=TCSXMg81EsOE/fbyZwViVsT5K6QOfN37XAWM9EXzavc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FEN4ay6I1wOisg7bkUi5SDV2HP9qaDJmnqGR+T2Bx0Vb34o/15DkexTjisP9d1Ls3asoFZbmK1+yMY1QBMAilVmkMmg6VA7XzKhtVjVOaNt/yX3nmv5AKmPycvtfdn3Fd2D33VXz8kbY3logz3Pp1QsAYwD00EZ2KT8kaRfvVTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ay3h0ZBm; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a0deaf21efso1300661eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 09:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709314427; x=1709919227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xImxJWc7Iog9OBF/0ks2T7kTvBm8QFAslDMxg3rdGPY=;
        b=ay3h0ZBmVuRkGAoh2VyfAUd0ZhymQ7vgPYPcUM5Lhl/88nCG7pGWEDu5idilOve55f
         PrHsq2VrVdklHKaNu4IQrwOGmxVmrVToejea8/bYe5Wp7Ij+njH2xscsEpOEfrQWp+by
         AzRI3YLBBfKzv8TelPmIYbIZQB/XY0TVCS59up2quYyRE/r68Pp+W105zK74+Ex+grvH
         6LZ5JIEVQuJ+rNZ8o5dxnbNTAjmuui683ZaXEYKM6vqyEGdqrqdU4JQNbl8RMcjel0kK
         sZ7GDocVOi4s2jWVS2BPTGWJ41g4l3V7HPZRtybklizUDaXaMuG++kMcCQK418di92OI
         uqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709314427; x=1709919227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xImxJWc7Iog9OBF/0ks2T7kTvBm8QFAslDMxg3rdGPY=;
        b=XKxVGYUmYNJilPFVlEwubzAI07kb5aNj9vb3inOpZLiSV8+ioAyQVCz1xwP26MUwjt
         athvk+LzaPOlUFqLmGHoBrM4guzYvPMVuS4GT/MpBcbqtlSslzK8wda2s15jtZBZQ+76
         i5Ic6KAtZdutTLbsJLmCF+YKGpiueZmh7b9xMAv3HqRr6t88hDfe7tpuPjhXPwtQYTya
         R1b0eUva763Cgp45CNdLXi3Ycx1pPy2r7i/koRXUbqFdcDqSHLZjDEgkmIZE3azhPmAA
         ErWXOm4I5swV3RaX0xmM/bPmqfUmkOO3X4HWwor2PW0A0ZD3G7QZoKZJPya0fizTMHuV
         5Vmw==
X-Gm-Message-State: AOJu0YxNsNVW4urC3X/PtZDAOEbRxmlI6Vu08Aa1pZnzJYuduTROvjAI
	j9lefPNz4CMLrTii1e3jJLr9jLHHvYxF5h9nVQb0GHWvhAisIMlQa1fsP9gAj7w=
X-Google-Smtp-Source: AGHT+IEaS7QiqN3fYN6eqlEpEHexB1BrGI/DGifcbsfq0aYXNTMbYdF9ufVL3gHeLbRiAI+Dvz03rA==
X-Received: by 2002:a05:6358:7e99:b0:17b:7738:de5a with SMTP id o25-20020a0563587e9900b0017b7738de5amr2678947rwn.2.1709314427513;
        Fri, 01 Mar 2024 09:33:47 -0800 (PST)
Received: from workbox.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id t14-20020ac86a0e000000b0042e6b901ebesm1885433qtr.40.2024.03.01.09.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:33:47 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	tgamblin@baylibre.com,
	dlechner@baylibre.com
Subject: [PATCH 0/2 v4] pwm: add axi-pwm-gen driver
Date: Fri,  1 Mar 2024 12:33:40 -0500
Message-ID: <20240301173343.1086332-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the AXI PWM GEN subsystem found on FPGA IP
cores. It can be used to generate configurable PWM outputs, and includes
options for external synchronization and clock signals.  The work is
being done on behalf of, and therefore lists maintainers from Analog
Devices, Inc.

The series has been tested on actual hardware using an EVAL-AD7985FMCZ
evaluation board. An oscilloscope was used to validate that the
generated PWM signal matched the requested one.

---
v4 changes:
* Address feedback for driver in v3:
  * Update to use devm_pwmchip_alloc() function
  * Simplify use of dev symbol in axi_pwmgen_probe
  * Remove unnecessary axi_pwmgen_from_chip function and use
    pwmchip_get_drvdata directly

Link to v3: https://lore.kernel.org/linux-pwm/20240131214042.1335251-1-tgamblin@baylibre.com/

v3 changes:
* Address feedback for driver in v2:
  * Remove unnecessary blank line in axi_pwmgen_apply
  * Use macros already defined in <linux/fpga/adi-axi-common.h> for
    version checking

Link to v2: https://lore.kernel.org/linux-pwm/20240123220515.279439-1-tgamblin@baylibre.com/

v2 changes:
* Address feedback for driver and device tree in v1:
  * Use more reasonable Kconfig approach
  * Use common prefixes for all functions
  * Rename axi_pwmgen struct to axi_pwmgen_ddata
  * Change use of "pwm" to "ddata"
  * Set and check state->polarity
  * Multiply safely with mul_u64_u64_div_u64()
  * Improve handling of max and zero periods
  * Error if clk_rate_hz > NSEC_PER_SEC
  * Add "Limitations" section at top of pwm-axi-pwmgen.c
  * Don't disable outputs by default
  * Remove unnecessary macros for period, duty, offset
  * Fix axi_pwmgen_ddata alignment
  * Don't artificially limit npwm to four
  * Use clk_rate_exclusive_get(), balance with clk_rate_exclusive_put()
  * Cache clk rate in axi_pwmgen_ddata
  * Don't assign pwm->chip.base, do assign pwm->chip.atomic
  * Relocate "unevaluatedProperties" in device tree binding
* Remove redundant calls to clk_get_rate
* Test contents of AXI_PWMGEN_REG_CORE_MAGIC instead of
  arbitrary AXI_PWMGEN_TEST_DATA in AXI_PWMGEN_REG_SCRATCHPAD
* Remove redundant clk struct from axi_pwmgen_ddata
* Add self as module author
* Add major version check for IP core

Link to v1: https://lore.kernel.org/linux-pwm/20240115201222.1423626-1-tgamblin@baylibre.com/

Drew Fustini (2):
  dt-bindings: pwm: Add AXI PWM generator
  pwm: Add driver for AXI PWM generator

 .../bindings/pwm/adi,axi-pwmgen.yaml          |  48 ++++
 MAINTAINERS                                   |   9 +
 drivers/pwm/Kconfig                           |  13 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-axi-pwmgen.c                  | 244 ++++++++++++++++++
 5 files changed, 315 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
 create mode 100644 drivers/pwm/pwm-axi-pwmgen.c

-- 
2.43.2


