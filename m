Return-Path: <linux-kernel+bounces-33356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF3383690F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4061B2D545
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C95C66B5C;
	Mon, 22 Jan 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM0bH2uq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE066B48;
	Mon, 22 Jan 2024 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935963; cv=none; b=gUCv4pm4jqsOFC6YnJa3SAQCXYINEbXpm2IZ66HERXZdRcltWpqVYxtRvkOBUPC7584qKgC8TgpC7LCyPzR7PNGBdevudwhaddQcRtUBbaGNxX0yKI3ZPI74M1wAq0ovfPFbANDqX1VuRU+nu1UImJEufe/EnkxVWS5UteWhgpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935963; c=relaxed/simple;
	bh=rprisNEsC2uRiF1SxBvUy142ekeuxh+v3vglsrsRGUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLfPYiC2ICa2PBfGATBoeRktovqxzvsF5pNW4Xcd0TqWCl5kvoky6UeVWMYmFlauH+cgtogedNSlMlwCkH7W+ArTuzsRpxfemjplzeqr/DzMvmdl2OTd2Dgi5bdN9wK+5LI62kyh/6Wdhr3jBBLccPEWpOGLICibqEK18KzzDSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM0bH2uq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD20C43390;
	Mon, 22 Jan 2024 15:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935963;
	bh=rprisNEsC2uRiF1SxBvUy142ekeuxh+v3vglsrsRGUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LM0bH2uq0UjNEqwquYSqI0kqgxs5KRN55Ku7Afvy8q42eWZ54Y/7735nXS2yS20ag
	 Bz0BIugAHhZgkuxg6F0tOV6TRQPn/cBYRML3SdtHwBrlKAz7Y50vOk68YjqRnl3rJs
	 CFOaz3mi+zgsmct4FePRrj0IWL5h/PYi7TC4LzBFValVSOLi37G6Cho5/qBGTEU+UB
	 APuf3I0kHCumX8cd3YRTv4CO1XEaKk8c+upjPRbmf1v4Zuw3spWkGP7Kpo47Xvr8Sl
	 TpGRDG+2udkCxwuY4HQi9jhVfEDZVGx6FIKcFEL8NTKjo+3tH/SfSL6Ztrp/ljOxos
	 0+JmWJv58TUMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xing Tong Wu <xingtong.wu@siemens.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 34/73] hwmon: (nct6775) Fix fan speed set failure in automatic mode
Date: Mon, 22 Jan 2024 10:01:48 -0500
Message-ID: <20240122150432.992458-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
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

From: Xing Tong Wu <xingtong.wu@siemens.com>

[ Upstream commit 8b3800256abad20e91c2698607f9b28591407b19 ]

Setting the fan speed is only valid in manual mode; it is not possible
to set the fan's speed in automatic mode.
Return error when attempting to set the fan speed in automatic mode.

Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>
Link: https://lore.kernel.org/r/20231121081604.2499-3-xingtong_wu@163.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index d928eb8ae5a3..92a49fafe2c0 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -2553,6 +2553,13 @@ store_pwm(struct device *dev, struct device_attribute *attr, const char *buf,
 	int err;
 	u16 reg;
 
+	/*
+	 * The fan control mode should be set to manual if the user wants to adjust
+	 * the fan speed. Otherwise, it will fail to set.
+	 */
+	if (index == 0 && data->pwm_enable[nr] > manual)
+		return -EBUSY;
+
 	err = kstrtoul(buf, 10, &val);
 	if (err < 0)
 		return err;
-- 
2.43.0


