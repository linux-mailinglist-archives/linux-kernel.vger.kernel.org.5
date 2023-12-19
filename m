Return-Path: <linux-kernel+bounces-5566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FEA818C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111B4287AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D0132C9F;
	Tue, 19 Dec 2023 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="NYfu6jWK";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="blkhsLd0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E3622331;
	Tue, 19 Dec 2023 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703003468; bh=hUUyx2Ra/j0PfiviV+OXUA5B+Rr5c5IfU2vtPHgn40o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NYfu6jWKFgj9mC3ee/nZq7ODltMtE9iQU5keKKmA+PGIHhF1oFMXX08UunGXfJU60
	 +YEdnVlG/tKBb7HpXA7iq68T83Hs17eygkJcyBeDOtMHvG9FAxQZzqgH7wlIv772PX
	 oeTrxH6APT5WkRi71pL7t0eqcjInM1v+HoGN+YhZiVOwZSUPm+ooOUvyjS58j4quNt
	 sTUXD6t/z29XaNqGRIzQW1Wb1Dr3VeUmucCSZGdtVj+qxPPGedGFsFiS2vGuAyWJga
	 gaqpCKMyIxL+o2QVFsw0OzqmidSRhiEiCWff4TJ7DuiR0fnn/cGzdO+cQHjizKvyL5
	 csiqF/k8KFg+g==
Received: by gofer.mess.org (Postfix, from userid 501)
	id C019010029E; Tue, 19 Dec 2023 16:31:08 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703003449; bh=hUUyx2Ra/j0PfiviV+OXUA5B+Rr5c5IfU2vtPHgn40o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=blkhsLd0GFn35E4dfO2DkD3V2fcGTIjuMIvfsWsX/UuDFkNgoaHlERe4GJE1v/b8r
	 yT3XrpVFzaHEUhrmfzj9fBRmTBO4944oiniOix5V+6Y7vmYpZ5fyCKKS1PR+tD/rVL
	 dDx+GS+JdhPR+9zcTFviaaUCOHnQZJoUqLtLxbKcm7iDE6ttXpxDyjanX5DGJWZ6J5
	 bjw6fvYW3wYn5O3szjShT6yul4oYeAYvrmEV1SxhjrxbP8RkysqwwN9A97bX5sQvSF
	 cxzzLAPrVPcITAEJZmiFxivO+SFoHVX5yZYMYmJ4r6psC0nuc0ktR/YUNzkKJDU0ju
	 mHX7oGDUUpP2A==
Received: from localhost.localdomain (bigcore.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id C18ED1009FF;
	Tue, 19 Dec 2023 16:30:49 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v10 6/6] media: pwm-ir-tx: Trigger edges from hrtimer interrupt context
Date: Tue, 19 Dec 2023 16:30:29 +0000
Message-ID: <1a5750d4eb3e4f777a123b094fdd66d3b16d2b9d.1703003288.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703003288.git.sean@mess.org>
References: <cover.1703003288.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes the generated IR much more precise. Before this change, the
driver is unreliable and many users opted to use gpio-ir-tx instead.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/pwm-ir-tx.c | 83 +++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 5 deletions(-)

diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index cf51e2760975..fe368aebbc13 100644
--- a/drivers/media/rc/pwm-ir-tx.c
+++ b/drivers/media/rc/pwm-ir-tx.c
@@ -10,6 +10,8 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/hrtimer.h>
+#include <linux/completion.h>
 #include <media/rc-core.h>
 
 #define DRIVER_NAME	"pwm-ir-tx"
@@ -17,8 +19,14 @@
 
 struct pwm_ir {
 	struct pwm_device *pwm;
-	unsigned int carrier;
-	unsigned int duty_cycle;
+	struct hrtimer timer;
+	struct completion tx_done;
+	struct pwm_state *state;
+	u32 carrier;
+	u32 duty_cycle;
+	const unsigned int *txbuf;
+	unsigned int txbuf_len;
+	unsigned int txbuf_index;
 };
 
 static const struct of_device_id pwm_ir_of_match[] = {
@@ -49,8 +57,8 @@ static int pwm_ir_set_carrier(struct rc_dev *dev, u32 carrier)
 	return 0;
 }
 
-static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
-		     unsigned int count)
+static int pwm_ir_tx_sleep(struct rc_dev *dev, unsigned int *txbuf,
+			   unsigned int count)
 {
 	struct pwm_ir *pwm_ir = dev->priv;
 	struct pwm_device *pwm = pwm_ir->pwm;
@@ -82,6 +90,62 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
 	return count;
 }
 
+static int pwm_ir_tx_atomic(struct rc_dev *dev, unsigned int *txbuf,
+			    unsigned int count)
+{
+	struct pwm_ir *pwm_ir = dev->priv;
+	struct pwm_device *pwm = pwm_ir->pwm;
+	struct pwm_state state;
+
+	pwm_init_state(pwm, &state);
+
+	state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
+	pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);
+
+	pwm_ir->txbuf = txbuf;
+	pwm_ir->txbuf_len = count;
+	pwm_ir->txbuf_index = 0;
+	pwm_ir->state = &state;
+
+	hrtimer_start(&pwm_ir->timer, 0, HRTIMER_MODE_REL);
+
+	wait_for_completion(&pwm_ir->tx_done);
+
+	return count;
+}
+
+static enum hrtimer_restart pwm_ir_timer(struct hrtimer *timer)
+{
+	struct pwm_ir *pwm_ir = container_of(timer, struct pwm_ir, timer);
+	ktime_t now;
+
+	/*
+	 * If we happen to hit an odd latency spike, loop through the
+	 * pulses until we catch up.
+	 */
+	do {
+		u64 ns;
+
+		pwm_ir->state->enabled = !(pwm_ir->txbuf_index % 2);
+		pwm_apply_atomic(pwm_ir->pwm, pwm_ir->state);
+
+		if (pwm_ir->txbuf_index >= pwm_ir->txbuf_len) {
+			complete(&pwm_ir->tx_done);
+
+			return HRTIMER_NORESTART;
+		}
+
+		ns = US_TO_NS(pwm_ir->txbuf[pwm_ir->txbuf_index]);
+		hrtimer_add_expires_ns(timer, ns);
+
+		pwm_ir->txbuf_index++;
+
+		now = timer->base->get_time();
+	} while (hrtimer_get_expires_tv64(timer) < now);
+
+	return HRTIMER_RESTART;
+}
+
 static int pwm_ir_probe(struct platform_device *pdev)
 {
 	struct pwm_ir *pwm_ir;
@@ -103,10 +167,19 @@ static int pwm_ir_probe(struct platform_device *pdev)
 	if (!rcdev)
 		return -ENOMEM;
 
+	if (pwm_might_sleep(pwm_ir->pwm)) {
+		dev_info(&pdev->dev, "TX will not be accurate as PWM device might sleep\n");
+		rcdev->tx_ir = pwm_ir_tx_sleep;
+	} else {
+		init_completion(&pwm_ir->tx_done);
+		hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		pwm_ir->timer.function = pwm_ir_timer;
+		rcdev->tx_ir = pwm_ir_tx_atomic;
+	}
+
 	rcdev->priv = pwm_ir;
 	rcdev->driver_name = DRIVER_NAME;
 	rcdev->device_name = DEVICE_NAME;
-	rcdev->tx_ir = pwm_ir_tx;
 	rcdev->s_tx_duty_cycle = pwm_ir_set_duty_cycle;
 	rcdev->s_tx_carrier = pwm_ir_set_carrier;
 
-- 
2.43.0


