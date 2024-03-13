Return-Path: <linux-kernel+bounces-102064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC2F87AE19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6951C22C22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D8315956E;
	Wed, 13 Mar 2024 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCfK00eU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A91158D93;
	Wed, 13 Mar 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348444; cv=none; b=C2xVgSGMAtabzdVIzctQ1Rrsz/4aNJF3JHKSFnDqG0grFPAC61m5BPqGFZdtQIdpmNDb83cU0WOiz2Jb1fIZhF1lbwehQbBAc5Zq+iI3Bcl5T4akOxqrJEmmfhk50DCMApHIuLMAOFA4jXzHtK1nMrqiBzIIOFFuwfsAJ5rbJdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348444; c=relaxed/simple;
	bh=5F8DJBRhvFfkT6zRKT0jjF22bUNX95SUh7FnLyf5P6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPzyJD1fwWXd6LjGxJAALVU/gkco86AU81wweOGr26po1H2B+6226rSWkUCurDHRhUjseSDjqFuk1UY/PnIqPCffI2uPNb3kflJhP/qv+PhXeybQz2aq8WRJtgsakp0coZx0dMv6jUKX/+a5iiTliSNq4UNqyjhJU/4jpFtPVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCfK00eU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73969C433F1;
	Wed, 13 Mar 2024 16:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348444;
	bh=5F8DJBRhvFfkT6zRKT0jjF22bUNX95SUh7FnLyf5P6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCfK00eUGrgfqM2yuJsMOfa3Y/TUPGVcfkU+yt3uAi8ElFAeFpPlujp91Qf7Oy1T7
	 gfRc/ktNrKxmsoexk2J0mFtarx41zIAlxr0G1b4DTJj7A6g45ZG7X16Y7wns83fK1K
	 f54NvNDZv+vhgBOxBBqake8esHV2GZhmnShUWZLoe78tP2iavgznBi227W0eHr11pp
	 K4NvqOeQNa+aGFA1wzCY5e+zjTA+S8owNQJirtF6c8ZDnGJHHcCzgfe+n6P+46T03u
	 cAoy7g5D0U8M7l8jxJr7vZMW937LQwqZGb4f5FaRWwDUh2r4fb8C5kcXVb4xN1MOuq
	 BjtLUM1gkh67Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 38/73] serial: max310x: Try to get crystal clock rate from property
Date: Wed, 13 Mar 2024 12:46:05 -0400
Message-ID: <20240313164640.616049-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit d4d6f03c4fb3a91dadfe147b47edd40e4d7e4d36 ]

In some configurations, mainly ACPI-based, the clock frequency of the device
is supplied by very well established 'clock-frequency' property. Hence, try
to get it from the property at last if no other providers are available.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20210517172930.83353-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 8afa6c6decea ("serial: max310x: fail probe if clock crystal is unstable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max310x.c | 40 +++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 8bf3c5ab59431..0e0f778d75cd4 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -556,7 +556,7 @@ static int max310x_update_best_err(unsigned long f, long *besterr)
 	return 1;
 }
 
-static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
+static u32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 			       unsigned long freq, bool xtal)
 {
 	unsigned int div, clksrc, pllcfg = 0;
@@ -629,7 +629,7 @@ static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 			dev_warn(dev, "clock is not stable yet\n");
 	}
 
-	return (int)bestfreq;
+	return bestfreq;
 }
 
 static void max310x_batch_write(struct uart_port *port, u8 *txbuf, unsigned int len)
@@ -1264,9 +1264,10 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 			 struct regmap *regmap, int irq)
 {
-	int i, ret, fmin, fmax, freq, uartclk;
+	int i, ret, fmin, fmax, freq;
 	struct max310x_port *s;
-	bool xtal = false;
+	u32 uartclk = 0;
+	bool xtal;
 
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
@@ -1278,24 +1279,20 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		return -ENOMEM;
 	}
 
+	/* Always ask for fixed clock rate from a property. */
+	device_property_read_u32(dev, "clock-frequency", &uartclk);
+
 	s->clk = devm_clk_get_optional(dev, "osc");
 	if (IS_ERR(s->clk))
 		return PTR_ERR(s->clk);
 	if (s->clk) {
-		fmin = 500000;
-		fmax = 35000000;
+		xtal = false;
 	} else {
 		s->clk = devm_clk_get_optional(dev, "xtal");
 		if (IS_ERR(s->clk))
 			return PTR_ERR(s->clk);
-		if (s->clk) {
-			fmin = 1000000;
-			fmax = 4000000;
-			xtal = true;
-		} else {
-			dev_err(dev, "Cannot get clock\n");
-			return -EINVAL;
-		}
+
+		xtal = true;
 	}
 
 	ret = clk_prepare_enable(s->clk);
@@ -1303,6 +1300,21 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		return ret;
 
 	freq = clk_get_rate(s->clk);
+	if (freq == 0)
+		freq = uartclk;
+	if (freq == 0) {
+		dev_err(dev, "Cannot get clock rate\n");
+		return -EINVAL;
+	}
+
+	if (xtal) {
+		fmin = 1000000;
+		fmax = 4000000;
+	} else {
+		fmin = 500000;
+		fmax = 35000000;
+	}
+
 	/* Check frequency limits */
 	if (freq < fmin || freq > fmax) {
 		ret = -ERANGE;
-- 
2.43.0


