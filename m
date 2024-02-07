Return-Path: <linux-kernel+bounces-57207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 046CC84D521
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1F81F23894
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E896F534;
	Wed,  7 Feb 2024 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUBYzops"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E16F521;
	Wed,  7 Feb 2024 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341230; cv=none; b=cz68IMSeBr9b2kjDHr8Gvkax3c6oqimDe1rZypN2OHY8e4H3SgybR6yN8dCfI2Z+eLgXMeap3usOI6qcXS8qyA7DJiu07xFNWHc6t0ztrfX1tj30mpUspdGcCWsRcCEy+d6APifGtluN1px3xZUjEPWDJgb18vmqTJWSPyyPtWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341230; c=relaxed/simple;
	bh=l2IreYI/O8e/GFVsy7OaZom34ewPRj/EXqsT3hg9ITQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhALSclm6zp+ISArzIVa9ZxGvAUt83qZ2PptKi/wUsIK7UnleDa0zHx9PrvOZcXRMlQNmYsz4WngZVX5Tj5miTuN8OwLJnhjhdoEJVyajT0pZMkAisS2g1YAuuGdymkeJuFjwYC9OzOsephaOy4fpOknbps4IFK7TX51HcY22lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUBYzops; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D47C43394;
	Wed,  7 Feb 2024 21:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341229;
	bh=l2IreYI/O8e/GFVsy7OaZom34ewPRj/EXqsT3hg9ITQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LUBYzopskUSRGf5xn7MkP6BmpdzUdyuAtGCDOlcrFRMNtvmxx6GHxvlzxtJYTHiqT
	 BGC7wKfJTovI4OXNsGZdprDutpKCDPgDeUXdUzOVFI2NVBfYPl5czvjCy7ElADQvPi
	 Fpjl70WrHJvEfKO8ofl/WkvV9HitXT5kb2HPCTv+mkNQVPAJHQaEFg/Y76i9towIT9
	 gHwVxVY8sArOedrFd/QPv29GL9985sLZMGGzlr0RWui7lY/9gs4xdVn+vm+/uhwjvc
	 Dsh9BAVgs7QdDigHjIPpIZnOKcud5oAKKCy4+D8e0dR2Z87jkkNprPW/WWH2MZy72J
	 pp0mQjpCUHl1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 5.10 05/16] regulator: pwm-regulator: Add validity checks in continuous .get_voltage
Date: Wed,  7 Feb 2024 16:26:45 -0500
Message-ID: <20240207212700.4287-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212700.4287-1-sashal@kernel.org>
References: <20240207212700.4287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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


