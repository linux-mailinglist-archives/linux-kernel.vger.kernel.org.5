Return-Path: <linux-kernel+bounces-57073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE6884D3BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B3EB27B48
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACB112F585;
	Wed,  7 Feb 2024 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AISr2C8q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07FA12F371;
	Wed,  7 Feb 2024 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340917; cv=none; b=WDCx6Uvv9eZ58q1LQKqGo+DBAh2EeOwdPeRd5thQKq8rdAv/oeRXZZ6/3YMyz4IMdiqodK4DK6mgvWRUN0QZ9jpFo+ZFEQ1QYAcuEi5xBzB+AfaRkbeQE3mwWGVVOqpSvUCnFiO8SpsAd0I8uSzqvGmypTLqTl1zHSS/xvYtAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340917; c=relaxed/simple;
	bh=Mm3e95LkaV2hy4cIxnxWGZtSOC8VaDRa3rPB5PdYfco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTT9VZLPkK8mCHOTy/S30fqqfipo/OhSGrIatlPQPc+CQnAAH2gJX0HD2vXRo3onHlukzNW4T9LpBBEljXGwi2bnVOrhjd5ZJEiyepHWPftynWw0H9jj2zcFyNcuIrzutU+qUTaJn9BrqxM91xTTjkiZ5JpTcGPCWhLTbCDc/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AISr2C8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D54C433F1;
	Wed,  7 Feb 2024 21:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340917;
	bh=Mm3e95LkaV2hy4cIxnxWGZtSOC8VaDRa3rPB5PdYfco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AISr2C8qLoytRIZUN7tXG5KTR4Id2XcU7TQ5aGePpvOfhZwn6YFeJENIVKZA4HjqV
	 8qN0wmOtDdt5JdsxsRPI3SelweWch/KPj0giI3vpqAl1VP8LI3cECWBo6IKs/Oa7FK
	 kVyhgjQUMx8C1OWGdBj8bfxNu6ICNBVC1WBsfzL+JG0QL33VRqF6aShXcjjbHsHClw
	 D1vS6ro4a2KkmKPJPmtwthjpWibO7SnRuVfSRRPO8FbN8KOiGq+h3zjlfuZa7Jr7NJ
	 +4AuHcv+XxfdJYfOWFnkMFB3gPpw3Qo9wlDJOc/eaGaAwmhhdkoznyH29VeDZ5BTL7
	 xikVUujs4bkKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 6.7 08/44] regulator: pwm-regulator: Add validity checks in continuous .get_voltage
Date: Wed,  7 Feb 2024 16:20:35 -0500
Message-ID: <20240207212142.1399-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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


