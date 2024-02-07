Return-Path: <linux-kernel+bounces-57228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6E184D55A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFEE8283054
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86A11470AF;
	Wed,  7 Feb 2024 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bp4nCrTp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C6A147099;
	Wed,  7 Feb 2024 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341273; cv=none; b=lJRXxf8wgR5RxpQ9Pli9AkifT73c/PN9k3f+ACCGRWwHAflZrUiduq7672gM14Mhi1YjIu/Jc2mUx/uPqM87GukyzmS1D6Ci2aYOE8+PoHRa/hwY4fV9X1OQddvY25UfF9R+9FDIkC/0wQhGCE4nXEg2r5YhG8424+R53XEJi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341273; c=relaxed/simple;
	bh=lEwR17HNRcweBk2ZPPmZFQ+iSQa+4ZtlUzi0I4wAoH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLFdca009w41h3ckZ2PWDZ3ruGSdZw728bGuxgUcreQObPsUd3bKxXU2OmE3/VZJ3Zwd8K2SKjaJ7AiAN+FojM2G9MDi52MpJCkOOar1E+iQdHIYwgVwRbDUnqUiGTejz6vwfWjlIor2d4R0+LQcMr8cAq7yyfE2Y8T6vX2y0mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bp4nCrTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1E7C433C7;
	Wed,  7 Feb 2024 21:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341273;
	bh=lEwR17HNRcweBk2ZPPmZFQ+iSQa+4ZtlUzi0I4wAoH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bp4nCrTplqpLBP8D5fyDVHBMQ4tfEa+q6q6UrFXyu29zXcAyblAuXMjh7verlYl52
	 659tv4dVAaruvKPkms/s+/chgTA0qJdtTQqm/fROHQleclCFlFABDX/atmDcKlVuYQ
	 n0xp+dKqfBEQ3N5kTUY8OAnWva5pP5qyGuibhS/+gZ83uqK1XMbiyKdpk1EHqO96MW
	 DtQ4SQZ7v0zjsvKLIwyuF8x68EZ+41ZWRCQu4Bh7sAL03JX81VS/KlQP42Qvd/1UU9
	 QCpSCtZPbI6Wo7mtowMpLm3408xAkEbxgZIjpKZOHOGgCZSJTcVJPz3PdCNitqh9Bm
	 phKambH4KTi4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 4.19 3/3] regulator: pwm-regulator: Add validity checks in continuous .get_voltage
Date: Wed,  7 Feb 2024 16:27:47 -0500
Message-ID: <20240207212747.4783-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212747.4783-1-sashal@kernel.org>
References: <20240207212747.4783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.306
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
index 34f3b9778ffa..215581dfd333 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -164,6 +164,9 @@ static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
 	pwm_get_state(drvdata->pwm, &pstate);
 
 	voltage = pwm_get_relative_duty_cycle(&pstate, duty_unit);
+	if (voltage < min(max_uV_duty, min_uV_duty) ||
+	    voltage > max(max_uV_duty, min_uV_duty))
+		return -ENOTRECOVERABLE;
 
 	/*
 	 * The dutycycle for min_uV might be greater than the one for max_uV.
-- 
2.43.0


