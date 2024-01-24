Return-Path: <linux-kernel+bounces-37130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF9783ABDF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDE2285EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED8B7A732;
	Wed, 24 Jan 2024 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDrggQHy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC447A717;
	Wed, 24 Jan 2024 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106551; cv=none; b=WeVqnNG+1VnLJepryJZzRChf+cmxugQcy6q5fnF8DVZNemnM0+ejP3jq65859aPc+IsYJi/U1NOSFyExLAtW2jMZs5NMx6uv9qqwR9XjN9VR8ihTaepnnLW1brwFCCJloApEKHX4Nt2ACQSFYiKuVtygknl7LM2Y/VSNOhNJREg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106551; c=relaxed/simple;
	bh=XV9pei4sE7cTqfNoEaMudqOSg0EaZC8c20uqBk8PJYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JYYDJ2OMY2H/Yi0cE+iG1e2ptlSE1hMURfrQtc7bnBkllmkv0+e1yzsg8PB0QizuY0tefY7rSxZD7HiqdkoOo2mkwcjrqyEKH0iQkGDGqWowKltdV6Q80dfWdNGltzelHpQRxozl2tAmEGXdsBaCG2JNiyVoYhmQO335rwheql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDrggQHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C18C433C7;
	Wed, 24 Jan 2024 14:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106551;
	bh=XV9pei4sE7cTqfNoEaMudqOSg0EaZC8c20uqBk8PJYY=;
	h=From:To:Cc:Subject:Date:From;
	b=lDrggQHyAZ2NMIXSl9E6R2BsTFM1cbyVlY/80lWNiFmSKP+/1r4VPCr2K4EdyAmlC
	 l3q8EXWBQ67bMMSDiLHtkLFfV0GQgiryitn6TenGogkfnQnhn7kHB30ELeIsA3s6MC
	 7BkyXiYz405sl6cZIpU3yoBnPwsZLH1qVneY9l+Uj18P2RE6eva7hWvb9veKyXX7Wd
	 dxIKvWEEUAQnY6OyYxfJDYFbWB2v7Myaiun+R8q9iRKnSfWiAYB56FsPOq9XA+BoFH
	 6fbrl9BwOcOXUXxzOph1NWqgOsmKkjSKaFhRMjCtNJ2e3zbcR/54DD2UAXhZMTpi+l
	 RGY7rNuPR0Pdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andy@kernel.org,
	linus.walleij@linaro.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/11] pinctrl: baytrail: Fix types of config value in byt_pin_config_set()
Date: Wed, 24 Jan 2024 09:28:44 -0500
Message-ID: <20240124142907.1283546-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index ec76e43527c5..95a8a3a22b2b 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -921,13 +921,14 @@ static int byt_pin_config_set(struct pinctrl_dev *pctl_dev,
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


