Return-Path: <linux-kernel+bounces-57185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E7284D4DB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C17028679F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F250C16D557;
	Wed,  7 Feb 2024 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiIuvEFG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAEC16D543;
	Wed,  7 Feb 2024 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341182; cv=none; b=Tl8s9zCLIJDJKAqoZf5GeV0Txg4qFeWekuC6qGBflMrcp32vcJVILxAJROAoi4I/BbUfOXLB7gNu5d/1smGTcGnta7pRntRU9swxFPODXKM8FEBx6h3B4/6dY7E09Qx4oHW4Ul0/rL7+vwiysw58NN/LYeJEc1l+STaNBkGMOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341182; c=relaxed/simple;
	bh=l2IreYI/O8e/GFVsy7OaZom34ewPRj/EXqsT3hg9ITQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVV/thDJ0PJubp3W6uPIEElAu3kWtWeriLHdBXy5owrqsc2rl+nOMRgg+o0ccM8F72Dp7n6eCusWEgk8v8g/gX7wRZ8rrSa2bsjQclgf6NMl/zfRAkGT0am7dZx29afF1CR+p9Qu5JqM2s6rwbC+YsOzsDtJD3O9ucjGUbUecLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiIuvEFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0177C433B2;
	Wed,  7 Feb 2024 21:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341181;
	bh=l2IreYI/O8e/GFVsy7OaZom34ewPRj/EXqsT3hg9ITQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hiIuvEFGobVCRuZEmGMtEd4MFJfBXwLNTj4n9RNMjyz4dalgGA/AZAzTAenS8bxS1
	 BLtBCvKCJL1L8Rj1kNY9kFXHXwayqQkL+uS6az6Q9pgVlIH71yDoV9g1/sP4Rl2kR3
	 0r3g3MGdmwO6XrKf1U/51RtbAPHFrnLQMnOsF6lkd9Hp1jAq+xssf8b2wVqOaUUiEX
	 1OsJ2QXX4KXe+NZwmruxpeGUUEwqwzvEWM6VXvKSMWzjN6fZlPpTRfy9yzyXf37s4C
	 04yOMnQn1ewQV1eqL4nVuNRaI7XccBqk3ulevqvgm22qcNp7jdEWz3A1jHeM3W6EIm
	 6oLX1dnJFdSMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 5.15 06/23] regulator: pwm-regulator: Add validity checks in continuous .get_voltage
Date: Wed,  7 Feb 2024 16:25:47 -0500
Message-ID: <20240207212611.3793-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index 7629476d94ae..f4d9d9455dea 100644
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


