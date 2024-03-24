Return-Path: <linux-kernel+bounces-114787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275B0889131
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCDE1F2CC89
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324471B6334;
	Mon, 25 Mar 2024 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKqI4NBD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63562197BB;
	Sun, 24 Mar 2024 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323393; cv=none; b=qnEZBNb7TmXsOHIDU7u/D89ZgpJwhyJ7jcPTRjt2Ftrg2ZcGUjjJPYkg1M3mqTxFFSnZ1lK72DUyC1kd69EZ3XN8HMiQpeHBl5EtLyX2hXxqDOOPBdPx1dWnxcZflrAt6r73XAfDMLaTDX4DtSxZ6Nz3+VHdVgYdch2jWsRNS6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323393; c=relaxed/simple;
	bh=ZO85aW3zlGqioP9YJ8rjMRMntZODEzmJfm/4JlKC8Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5HXvmYlzN1sbErNLF2kLNuA6cBOHDdCMcU425NDSd3G5tylyVIBE4cjoIofXAcxG0XWDroRwou82CuRA/o9gpcI4cbmOOMCr57d63Y5SmUMdqy2uStSZgazgGPcRXLDaVWXvbYRMN0MwBn+t1FjnqkGVafkYuQa4K5gYE8evfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKqI4NBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B62C43390;
	Sun, 24 Mar 2024 23:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323391;
	bh=ZO85aW3zlGqioP9YJ8rjMRMntZODEzmJfm/4JlKC8Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKqI4NBDf5FfV2AWmOkrBvrrQRwFP8jy0dGPvkSu3SdOUpkPhC14lzFwTR6LaPHzM
	 jlTiK7Ibl8OTCuva4q2YAhl5HbMFIrnH339rJ8CFZdjTmZcGoHimA0o6nxq38L882N
	 BNmWjr2r4B7Xf/QtwHesM5LAPEu98fTKvoGgBx/xpUm2cMtrGDis1geTiOfYys5h8+
	 OJ5cDh1GpFBd65kYcXUMkkftWCKDTs7NJkLcvwhQAv1j9c9DVRC3+zRU5IwT82plEn
	 oyj3PW5FRr06lQnh9tJ3OotRS1lr6qCJvQw/JfLfTCj2+D275Hljzcb+gpc4OAs6mm
	 xQe6h/6Kt6Iew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 092/317] pwm: sti: Implement .apply() callback
Date: Sun, 24 Mar 2024 19:31:12 -0400
Message-ID: <20240324233458.1352854-93-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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

[ Upstream commit b2e60b32b4fe5da4cf7fedd976416b5f47f62332 ]

To eventually get rid of all legacy drivers convert this driver to the
modern world implementing .apply().
This just pushed a variant of pwm_apply_legacy() into the driver that was
slightly simplified because the driver doesn't provide a .set_polarity()
callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Stable-dep-of: 5f623835584f ("pwm: sti: Fix capture for st,pwm-num-chan < st,capture-num-chan")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-sti.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index f8a3f30e54dd5..652fdb8dc7bfa 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -392,11 +392,34 @@ static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
+static int sti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	int err;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			sti_pwm_disable(chip, pwm);
+
+		return 0;
+	}
+
+	err = sti_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!pwm->state.enabled)
+		err = sti_pwm_enable(chip, pwm);
+
+	return err;
+}
+
 static const struct pwm_ops sti_pwm_ops = {
 	.capture = sti_pwm_capture,
-	.config = sti_pwm_config,
-	.enable = sti_pwm_enable,
-	.disable = sti_pwm_disable,
+	.apply = sti_pwm_apply,
 	.free = sti_pwm_free,
 	.owner = THIS_MODULE,
 };
-- 
2.43.0


