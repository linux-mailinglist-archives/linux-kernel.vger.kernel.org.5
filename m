Return-Path: <linux-kernel+bounces-57221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0538584D547
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388161C24F3C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6A9139934;
	Wed,  7 Feb 2024 21:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQYOEYNe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B722143D5D;
	Wed,  7 Feb 2024 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341258; cv=none; b=SFzpEE9jRdyWCoht4Gag8h8QwV1iCmtWj/ivsucjc2lRVcyru+KuPLT8KrVMpH/+0XSsuqNOzbUGa3r6e2fnOX2iotSB897NSM6tdTZr/fIwTVhrp/4x0cReUIWR5AyE9bfjMByZ/CiMdva+k0i+U8mJGDgSzVFJ7+1wc+MsQas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341258; c=relaxed/simple;
	bh=hTt1FWbXF+ROxxbnY5it2KwEQF9kPdnArBqORBJTUA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmjfxqOqGt5Qze83RBlzt3i/RJpqISO4J7sHSXgpIXUSVGxePZ+m1T3cCFulWonAj9ysGKhf2YTb8XaMg11RfhytuRjGPpthE+PRuJKp4mz178ZQTOt7yOEiyr5ysA9lRlb10g0al44enTBnjsKqptC0AQbFFGXqBmi0TW+mFyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQYOEYNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58884C433F1;
	Wed,  7 Feb 2024 21:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341258;
	bh=hTt1FWbXF+ROxxbnY5it2KwEQF9kPdnArBqORBJTUA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQYOEYNeaay9u8zPYC1zzK5KZDK5JOITZRjdN+RiMxjMJRPiBAHQWtIO8iyuUmIAF
	 UFP/s+DebftVaodJUx+A+k9HWr7dXuvIAZUOJp18BOx2d8PRXPUppIv8o9DhfRfR9W
	 VNiC9Z5GIJZVKMEDsOidgXIr3vwwND9c6Hu41BE35QwlD42GIKfgrECy6OxGUoDAJl
	 uCCmeUzpb+N52ctaGk5lC1abdx8YqLCALUB6AyWwgMiOXuoE/U1M4BcD2/ar12FCYM
	 n/XH96PN3tymxSJYemqW9WMdqq63nKJ9aqIP5xnTJ9yJ0oimZUSn7O08beZJ74AIrF
	 vWtYgMzlNt+Tw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 5.4 3/7] regulator: pwm-regulator: Add validity checks in continuous .get_voltage
Date: Wed,  7 Feb 2024 16:27:27 -0500
Message-ID: <20240207212732.4627-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212732.4627-1-sashal@kernel.org>
References: <20240207212732.4627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
Content-Transfer-Encoding: 8bit

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit c92688cac239794e4a1d976afa5203a4d3a2ac0e ]

Continuous regulators can be configured to operate only in a certain
duty cycle range (for example from 0..91%). Add a check to error out if
the duty cycle translates to an unsupported (or out of range) voltage.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Link: https://msgid.link/r/20240113224628.377993-2-martin.blumenstingl@googlemail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/pwm-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 0a9d61a91f43..1b06aaaaf8b8 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -158,6 +158,9 @@ static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
 	pwm_get_state(drvdata->pwm, &pstate);
 
 	voltage = pwm_get_relative_duty_cycle(&pstate, duty_unit);
+	if (voltage < min(max_uV_duty, min_uV_duty) ||
+	    voltage > max(max_uV_duty, min_uV_duty))
+		return -ENOTRECOVERABLE;
 
 	/*
 	 * The dutycycle for min_uV might be greater than the one for max_uV.
-- 
2.43.0


