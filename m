Return-Path: <linux-kernel+bounces-113676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 997218885F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C2D2859C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB0E1D8DE4;
	Sun, 24 Mar 2024 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehmytc8g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12904144312;
	Sun, 24 Mar 2024 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320661; cv=none; b=bTo+3VZhGwrvLBbvKL3dujk3N1ddXKUzFPb8oUznreyJ3F/vUw/TirK+PFoPFMOnfZGuLpPnScc0GgQgopoDT+cj4MOfAs/aIR7Lc3cYb2A7VVA4hknbKQg7/NAJ1zxEphaeKjurM26A3O+z7pl6cqF7689YDhJjjuuyLbpt5wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320661; c=relaxed/simple;
	bh=mpRsqp7HLYd8NsSfz98OwcTH6gubGY+4gDkzwWb31n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N10rLCvNEDFH+PbRsttPDnda97Ef17TfbwpOvjxfYpk8vbOnLAoZ2Z4nHaBTwzhsB47yT+Rr03ge1eSJZS6pAJocBInDdFu9Iefobpddww+6rkiN/r0jQpR7nU7mzdK7T2LpMVcmP/QMdqy6nIaD+EOL+2h/ih0D9Nb4u4Ek/BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehmytc8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CFAC433C7;
	Sun, 24 Mar 2024 22:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320660;
	bh=mpRsqp7HLYd8NsSfz98OwcTH6gubGY+4gDkzwWb31n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ehmytc8gT45kxEGbJtQO/vISRk4kWwZWG7Uo0l7ARYHSnWzIKOGLw+pb2wLq0F7My
	 W/LIhYfGiH6cpI2fiAkEAZz1CKhfemdpsFthU2hCB53FxYxY9Y9KXUYCsqIT/zKPNb
	 1U2//+kx7ktuEkZY/3dn2LAZk1wVjQK4sDJ+lHsKy3LY9kL1GHAgvtcPU4CQVgNaZg
	 rqM4gqNviUaoIsLAxSGNyVnUDqdacl4J6xv2G6Cy2LRPScGCr8xIZN+84QBaBxOF5T
	 zCgh7lxKCZHc5YBHp/X6oR8KYI6FtHGHnyft10YkEVXPheOB8wppzoMpxA4VrN+Cvx
	 8tez9cFIbSVYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 223/713] pwm: sti: Fix capture for st,pwm-num-chan < st,capture-num-chan
Date: Sun, 24 Mar 2024 18:39:09 -0400
Message-ID: <20240324224720.1345309-224-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 5f623835584f1c8d1030666796f40c47a448ce0b ]

The driver only used the number of pwm channels to set the pwm_chip's
npwm member. The result is that if there are more capture channels than
PWM channels specified in the device tree, only a part of the capture
channel is usable. Fix that by passing the bigger channel count to the
pwm framework. This makes it possible that the .apply() callback is
called with .hwpwm >= pwm_num_devs, catch that case and return an error
code.

Fixes: c97267ae831d ("pwm: sti: Add PWM capture callback")
Link: https://lore.kernel.org/r/20240204212043.2951852-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-sti.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index dc92cea31cd07..d885b30a147dc 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -395,8 +395,17 @@ static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 static int sti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
 {
+	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
+	struct sti_pwm_compat_data *cdata = pc->cdata;
+	struct device *dev = pc->dev;
 	int err;
 
+	if (pwm->hwpwm >= cdata->pwm_num_devs) {
+		dev_err(dev, "device %u is not valid for pwm mode\n",
+			pwm->hwpwm);
+		return -EINVAL;
+	}
+
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
@@ -646,7 +655,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
-	pc->chip.npwm = pc->cdata->pwm_num_devs;
+	pc->chip.npwm = max(cdata->pwm_num_devs, cdata->cpt_num_devs);
 
 	for (i = 0; i < cdata->cpt_num_devs; i++) {
 		struct sti_cpt_ddata *ddata = &cdata->ddata[i];
-- 
2.43.0


