Return-Path: <linux-kernel+bounces-124414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3579F891739
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2DC1C23F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CA48562E;
	Fri, 29 Mar 2024 10:56:51 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A037D416
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709811; cv=none; b=XOvOGxVQjI6xm7vGMw1y0PZb27c2adA8Yce1qbBpQQbCE0nj9CD2FlUtzs+rppi++Q6tGuQJ6ZsX6Y1zR5OgKDI5SYoP3KyS3gxN+EF+wMUTb+rETVbxVspSqpOSQ/lVPMkYtPR3lxdj3apbAW5PN+D7EjZuYWppdhSwW4QVy2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709811; c=relaxed/simple;
	bh=76IT1a2GUz6XBzbVi4WyO5trFZFO8WMfWnONPgI9AQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huF7rJl4SWtusmPNUbPkChJP62TWZl3nSL0Mh+SSOxS9CAXwA26wCDQjbF5nLQSE6YAiCq3QH6crWw8/i00tp1SQr1fGXoIVfv7NX7Mubqmx/S9EvKsAlDSiGnvTXf88u28uRt8GUjvkItAvGh6WptMWuDTNqJbHTPId7b4M8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 058b1d91-edbb-11ee-a9de-005056bdf889;
	Fri, 29 Mar 2024 12:56:41 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 04/11] pinctrl: aw9523: Make use of struct pinfunction and PINCTRL_PINFUNCTION()
Date: Fri, 29 Mar 2024 12:55:18 +0200
Message-ID: <20240329105634.712457-5-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329105634.712457-1-andy.shevchenko@gmail.com>
References: <20240329105634.712457-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Since pin control provides a generic data type and a macro for
the pin function definition, use them in the driver.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/pinctrl-aw9523.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-aw9523.c b/drivers/pinctrl/pinctrl-aw9523.c
index d93640a02d1d3..7db901216a94c 100644
--- a/drivers/pinctrl/pinctrl-aw9523.c
+++ b/drivers/pinctrl/pinctrl-aw9523.c
@@ -66,18 +66,6 @@ struct aw9523_irq {
 	u16 cached_gpio;
 };
 
-/*
- * struct aw9523_pinmux - Pin mux params
- * @name: Name of the mux
- * @grps: Groups of the mux
- * @num_grps: Number of groups (sizeof array grps)
- */
-struct aw9523_pinmux {
-	const char *name;
-	const char * const *grps;
-	const u8 num_grps;
-};
-
 /*
  * struct aw9523 - Main driver structure
  * @dev: device handle
@@ -158,17 +146,9 @@ static const char * const gpio_pwm_groups[] = {
 };
 
 /* Warning: Do NOT reorder this array */
-static const struct aw9523_pinmux aw9523_pmx[] = {
-	{
-		.name = "pwm",
-		.grps = gpio_pwm_groups,
-		.num_grps = ARRAY_SIZE(gpio_pwm_groups),
-	},
-	{
-		.name = "gpio",
-		.grps = gpio_pwm_groups,
-		.num_grps = ARRAY_SIZE(gpio_pwm_groups),
-	},
+static const struct pinfunction aw9523_pmx[] = {
+	PINCTRL_PINFUNCTION("pwm", gpio_pwm_groups, ARRAY_SIZE(gpio_pwm_groups)),
+	PINCTRL_PINFUNCTION("gpio", gpio_pwm_groups, ARRAY_SIZE(gpio_pwm_groups)),
 };
 
 static int aw9523_pmx_get_funcs_count(struct pinctrl_dev *pctl)
@@ -184,10 +164,10 @@ static const char *aw9523_pmx_get_fname(struct pinctrl_dev *pctl,
 
 static int aw9523_pmx_get_groups(struct pinctrl_dev *pctl, unsigned int sel,
 				 const char * const **groups,
-				 unsigned int * const num_groups)
+				 unsigned int * const ngroups)
 {
-	*groups = aw9523_pmx[sel].grps;
-	*num_groups = aw9523_pmx[sel].num_grps;
+	*groups = aw9523_pmx[sel].groups;
+	*ngroups = aw9523_pmx[sel].ngroups;
 	return 0;
 }
 
-- 
2.44.0


