Return-Path: <linux-kernel+bounces-37117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7EE83ABBB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF65E1C22A66
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C8C7C09D;
	Wed, 24 Jan 2024 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVvUEiSI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C1A7C08D;
	Wed, 24 Jan 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106504; cv=none; b=VGooVF911qeYrgKA3YGR8zZfsfrDp2ukdNRXcbinEGyZKOKDE0oiDNVjnl1sNfZsCSOxRQzRzOBnMvvLAZCeS/muNEK5H16tbjvs8lZSrJYm0ka5BBomoYcqJfK8GHa7HAq5LZ9D7Fm5G3PGte+mdHPQcFZ1crz9k1bWUqD321k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106504; c=relaxed/simple;
	bh=yn0wNLPBUdOJdf2VETHLWfkGVU+MRAK5BYDWXbwCY50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGMCQr5LR2M7kPnbyg1zc0ycQEVJZnd5KB9BxjbQNbLxC4voUUKcaJfcuh7r9Txn2sHfQPIuPsmjG2gl1pEFNdBRq2pkcGdDSRxBC4JqtrWAivZeKrEg4cZrOwm4jVFlJllCvgH2bQ4QLDoTJ+D+KnJT8JuhyYQMN6xwkcCOpp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVvUEiSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D995C433A6;
	Wed, 24 Jan 2024 14:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106503;
	bh=yn0wNLPBUdOJdf2VETHLWfkGVU+MRAK5BYDWXbwCY50=;
	h=From:To:Cc:Subject:Date:From;
	b=uVvUEiSI5AJzJSJxwuXj3kkbPOE3kiDx9aqOxa+30lrYQSlTLF6KX+RRSqZKRWPiY
	 o3Dub9pZOCXoegbvYrtPfxUfZ+JqIrnqvzxZOg/UGmeh5mIeukv0AHewfQ/Ujv4VSL
	 fbEvEbHgU72R1/6Mp/081a/jkjRIQP/9vZ62d2Sqmst5y2lD/ohtCPr0UfAiXJr3Qq
	 gYiAbr1NQgAYRD118UlMS0UYhfcmUr3Kt7uu5EFhxQI3ZvLIh92mg2tZYTZ1rxINrA
	 6Hnum0HAttvJ8EJmn5r78iaUj9joFle7cmiomvmlBcjkfNbdwWJUy2emkcNmB6Xh4d
	 dGCJ0uhC9CFEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andy@kernel.org,
	linus.walleij@linaro.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 01/13] pinctrl: baytrail: Fix types of config value in byt_pin_config_set()
Date: Wed, 24 Jan 2024 09:27:54 -0500
Message-ID: <20240124142820.1283206-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 1a856a22e6036c5f0d6da7568b4550270f989038 ]

When unpacked, the config value is split to two of different types.
Fix the types accordingly.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 3cd0798ee631..f1af21dbd5fb 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -918,13 +918,14 @@ static int byt_pin_config_set(struct pinctrl_dev *pctl_dev,
 			      unsigned int num_configs)
 {
 	struct intel_pinctrl *vg = pinctrl_dev_get_drvdata(pctl_dev);
-	unsigned int param, arg;
 	void __iomem *conf_reg = byt_gpio_reg(vg, offset, BYT_CONF0_REG);
 	void __iomem *val_reg = byt_gpio_reg(vg, offset, BYT_VAL_REG);
 	void __iomem *db_reg = byt_gpio_reg(vg, offset, BYT_DEBOUNCE_REG);
 	u32 conf, val, db_pulse, debounce;
+	enum pin_config_param param;
 	unsigned long flags;
 	int i, ret = 0;
+	u32 arg;
 
 	raw_spin_lock_irqsave(&byt_lock, flags);
 
-- 
2.43.0


