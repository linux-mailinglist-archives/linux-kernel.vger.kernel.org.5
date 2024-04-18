Return-Path: <linux-kernel+bounces-149340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221088A8FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A6A9B21B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D1D53AC;
	Thu, 18 Apr 2024 00:07:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53D9181;
	Thu, 18 Apr 2024 00:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713398874; cv=none; b=ck47VMdXygpvdTAesAKjMc1ZzHxKLOWBmGcKsk2F419NrT7VSsRjKNPm57z1cBvTNGdNZJqyrP7t88s+Y+6T9LsZ9gphlFdssruqnB3xCWLXD6GFpZdQG8IabnSinJvvfMi18Q9xySpaooTdunp/EZGVpcodj5AWOLXnkEdjXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713398874; c=relaxed/simple;
	bh=X2cCbx91QZfJW/xTsS4lQGNc45bO5sehXG54tMDzDg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QONBAjd5oN/Be/UdDVZigRz3ccSZm4K9DCFYlnnUuvKkJQT0dn1NI2+DN17klFV1fZlH2KHpOkSVC9Si0GlIhyRCeKKdEoSQYbVbX5UT5EpIomzc/yvL6JPZ/jtQkjh3gyNQzSnofZNThgmHgj3D705fL4zei0lm1wiS5VgUNm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0051DA7;
	Wed, 17 Apr 2024 17:08:18 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1977A3F64C;
	Wed, 17 Apr 2024 17:07:48 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@csie.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ryan Walklin <ryan@testtoast.com>,
	Chris Morgan <macroalpha82@gmail.com>
Subject: [PATCH v2 1/5] mfd: axp20x: AXP717: Fix missing IRQ status registers range
Date: Thu, 18 Apr 2024 01:07:32 +0100
Message-Id: <20240418000736.24338-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240418000736.24338-1-andre.przywara@arm.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While we list the "IRQ status *and acknowledge*" registers as volatile,
they are missing from the writable range array, so acknowledging any
interrupts was met with an -EIO error.

Add the five registers that hold those bits to the writable array.

Fixes: b5bfc8ab2484 ("mfd: axp20x: Add support for AXP717 PMIC")
Reported-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/mfd/axp20x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 48ce6ea693cea..d8ad4e120d379 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -210,6 +210,7 @@ static const struct regmap_access_table axp313a_volatile_table = {
 
 static const struct regmap_range axp717_writeable_ranges[] = {
 	regmap_reg_range(AXP717_IRQ0_EN, AXP717_IRQ4_EN),
+	regmap_reg_range(AXP717_IRQ0_STATE, AXP717_IRQ4_STATE),
 	regmap_reg_range(AXP717_DCDC_OUTPUT_CONTROL, AXP717_CPUSLDO_CONTROL),
 };
 
-- 
2.35.8


