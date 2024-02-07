Return-Path: <linux-kernel+bounces-57155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDA084D490
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00F3284AB1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61795155F32;
	Wed,  7 Feb 2024 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cC8ohyaQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BCC155F45;
	Wed,  7 Feb 2024 21:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341117; cv=none; b=YIH2hJIF+/9p6NmXAf84Oayj1pij7zsRtGoVSn7atlr6g4EezJnC6I7eRlrdmXob4uoArHbfRRZWJsQyZgLB2Ccrgt6eVQdu28m0OiYKYQWottH992ZDjQcmblcQI95vCIWrMt0NVadQ13WEtRh7FQqLuz4HfMe0kCquis3nmZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341117; c=relaxed/simple;
	bh=D1KYnJLJF+31IeXJl/PpB98ycwzw71ZV77DuaAWY/Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZrwgWlaRLtihqoUdmw+Y5BuaTqYk9fNwLewy+HAEWDuLdBtpjjIl2B4IeWoi1rHAzGN/rmRylndXEGq55GACU7EKnMfEtnybymNFD+LWMcSv6q/bfNn4RoFirpuH1yhI5LqTKBbc/Rh2KCmVa0821Fs2FNo+gJUUgNzNy4QHzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cC8ohyaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A9AC433F1;
	Wed,  7 Feb 2024 21:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341117;
	bh=D1KYnJLJF+31IeXJl/PpB98ycwzw71ZV77DuaAWY/Kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cC8ohyaQ2jeU0bx2xHOMDao3BxWTtzdoqe+UcOdL4XL1JDRK9YJqATZdyK8dQlvE4
	 FAQbVKE5HLdqGj1RNaBFgbBgd8/794IDykDabhkdszd8yM1zZy6rLvvOnBcr4slbPQ
	 uP8A89W+oNuDQEZixicVO7KLxDobnKcEpxdGxzhV6gtpSpmkgLCVq+27l/EhOa8zen
	 CNO9X7EvhyoGuva2XWronG6U7sp3sImLTxOuzWnQdIN6r/VCgFcyb4+tk3mNITcaHL
	 ykftzBzbiUGwVidX07lTkn262CXjLctSdHYLbDouRTr8BhCa3nIYQ5mlVxO+WN3840
	 5qzDIVEmn8WGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 6.1 07/29] regulator: pwm-regulator: Add validity checks in continuous .get_voltage
Date: Wed,  7 Feb 2024 16:24:32 -0500
Message-ID: <20240207212505.3169-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
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
index b9eeaff1c661..925e486f73a6 100644
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


