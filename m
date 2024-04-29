Return-Path: <linux-kernel+bounces-162151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C27278B56B9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B6B282BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135194779C;
	Mon, 29 Apr 2024 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="LZifYU4S"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADAE200CD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390397; cv=none; b=E+gMwp+L7ALIoIuF/rLlJCEygnEUfi+TgiLs8sYbj+le2ufUcluMcTXEiEdddGBnaCnmQmqhzJ59UHqoJa/2L66+0RKgfT80i0cKz9KiIjm0ctCUWYMgTgcTR+pJXMfJFib+Ul4CP2IDvLd9sWZ0u756BQGCnceL5Mdxga3s7ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390397; c=relaxed/simple;
	bh=12pNV/3v45L2MvCn7S9EqWK9lwdw7rPRpQGj+Sgofag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EcNVwwvA8QTMzvuea8AH8tyVqLAi4dmhONQBPx/Db/tkWge9LKd/0c3h35iaoAhkwm3vuN9EI8t0DE98ep/hrhDF2/LI4cEzEC5S4Vr/LqhrhlyUU464jz5BfUSNBSPm8IA5YA6mpAqiM+bGm7QqzHnhhwynnQd56S8+LiEqVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=LZifYU4S; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=Vgux3aE3wJGJ6D
	mN+k2dPKSst7IED0Ek/dvVSF5yq0g=; b=LZifYU4S7NUCZENs8jHvem7CPVc3RO
	Z3op2lLszJOlJW1oB5HiWE7k2lz1H+HkpBtnYKqtl7Lp8rQRdP9YXnjf6sPTzO4j
	Wk8RtkToMA8SV96difp+7EyiKQOCJ2ifDGF1OE2meSCScZGzXtRX8dv8uSIjrXRT
	1Gk/Roz7bw3hlJUSwnHCOHS8z+lRdyxGEJC8I2TXDabw4CYqDmJXVGsI7MEP4T9z
	D8cDOIGDMfMvH96D+lULSj1D+HbRqQk9cZlnluoi0G+iWOM83jhL/6p5zh5KS0ir
	JwwH5q/TFzeIOAMMa0JiHpRDafNE5erJTauOlwdCZG6ig419naUxKWmg==
Received: (qmail 2280950 invoked from network); 29 Apr 2024 13:33:14 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:33:14 +0200
X-UD-Smtp-Session: l3s3148p1@eC5qnjoXbxxtKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-iio@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 0/8] iio: use 'time_left' instead of 'timeout' with wait_for_*() functions
Date: Mon, 29 Apr 2024 13:33:03 +0200
Message-ID: <20240429113313.68359-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_*() functions causing patterns like:

        timeout = wait_for_completion_timeout(...)
        if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
obvious and self explaining.

This is part of a tree-wide series. The rest of the patches can be found here
(some parts may still be WIP):

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/time_left

Because these patches are generated, I audit them before sending. This is why I
will send series step by step. Build bot is happy with these patches, though.
No functional changes intended.

Wolfram Sang (8):
  iio: adc: ad_sigma_delta: use 'time_left' variable with
    wait_for_completion_timeout()
  iio: adc: exynos_adc: use 'time_left' variable with
    wait_for_completion_timeout()
  iio: adc: fsl-imx25-gcq: use 'time_left' variable with
    wait_for_completion_interruptible_timeout()
  iio: adc: intel_mrfld_adc: use 'time_left' variable with
    wait_for_completion_interruptible_timeout()
  iio: adc: stm32-adc: use 'time_left' variable with
    wait_for_completion_interruptible_timeout()
  iio: adc: stm32-dfsdm-adc: use 'time_left' variable with
    wait_for_completion_interruptible_timeout()
  iio: adc: twl6030-gpadc: use 'time_left' variable with
    wait_for_completion_interruptible_timeout()
  iio: pressure: zpa2326: use 'time_left' variable with
    wait_for_completion_interruptible_timeout()

 drivers/iio/adc/ad_sigma_delta.c  |  6 +++---
 drivers/iio/adc/exynos_adc.c      | 16 ++++++++--------
 drivers/iio/adc/fsl-imx25-gcq.c   | 10 +++++-----
 drivers/iio/adc/intel_mrfld_adc.c | 12 ++++++------
 drivers/iio/adc/stm32-adc.c       | 10 +++++-----
 drivers/iio/adc/stm32-dfsdm-adc.c | 12 ++++++------
 drivers/iio/adc/twl6030-gpadc.c   |  8 ++++----
 drivers/iio/pressure/zpa2326.c    | 10 +++++-----
 8 files changed, 42 insertions(+), 42 deletions(-)

-- 
2.43.0


