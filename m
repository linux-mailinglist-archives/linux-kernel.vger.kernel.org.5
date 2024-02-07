Return-Path: <linux-kernel+bounces-57118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A3084D434
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8981C22599
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD9A1474A2;
	Wed,  7 Feb 2024 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmz6NPvt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73591482E1;
	Wed,  7 Feb 2024 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341033; cv=none; b=tw17iZb1Yz1FwhEOEioFVxE9FdSE+q0OI2COeHCPc3HtJvFBYGjzY6Ykdyn7CUrK8LIHXG/c+ElSUEUaeHjxKQxCRO0qOODEIOS8r6sor1EXOuvMtXY2gypzy+acAduBex6/4aT0oZAMGYWIcDZCRF/bWRkMZFbjCCwVZxytUvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341033; c=relaxed/simple;
	bh=Mm3e95LkaV2hy4cIxnxWGZtSOC8VaDRa3rPB5PdYfco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=miAxJFXKAC0gd/gtQEAERm8ic+km6V5XJH0GO+jhRIGUvYcXh6C0WpCmI/e7TSJUssyATlRezDVxJMsoAWVLRSemcq0D1AWPHP9HmsOf+fQbd/AYxwpcViiX1N2N0vi8f80onoFybYu21ai5DVmdlabalAQyZa1n6f9Ctn8XDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmz6NPvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1CBC43399;
	Wed,  7 Feb 2024 21:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341032;
	bh=Mm3e95LkaV2hy4cIxnxWGZtSOC8VaDRa3rPB5PdYfco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tmz6NPvtPPEHoOJG8iVI8JDHyl6UsyM8+zjH9JPaXIm3wlKAcPeViKbFYlDss7pxG
	 9BgaozA1VfYlUn2ZyWTFaA440j+kSVGSrjHk5gDiHkc95Nsz+mBSl9emeNvmr+G9cw
	 YPRSyGsZdLWyCqK90RrljlgABZuDxvFxtiMtAm8ZzhMYaljibd1POqTw5nhNcniNQK
	 7qGNrjw/eD3hlzUeq+mZV6dsyU3bTE4pqal2358jgaXumIQkTqa7YQpVtMh9ZSfpYN
	 5iEKWQKWjrg1d6mZjZO/ersKb23bESC3e8HMWnPhLV+Chv+lgXzegFHrpFCiNTGWLr
	 CIKu0Xadx2HWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 6.6 08/38] regulator: pwm-regulator: Add validity checks in continuous .get_voltage
Date: Wed,  7 Feb 2024 16:22:54 -0500
Message-ID: <20240207212337.2351-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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
index 2aff6db748e2..e33d10df7a76 100644
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


