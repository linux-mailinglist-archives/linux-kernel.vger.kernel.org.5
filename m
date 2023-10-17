Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A836C7CBF6D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343512AbjJQJac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343542AbjJQJSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:18:24 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E078E;
        Tue, 17 Oct 2023 02:18:22 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 501)
        id 703F81000FC; Tue, 17 Oct 2023 10:18:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1697534301; bh=+OpHV9kVT8L30HIUZj/JT63HZUN6AzYfOP0xwc4acZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=majiFL0Tz4qibQ+8YbIrFNBGrqsxzTNC3jaD1RjN/BidSbviuN2a4VwsX48h6WSFx
         WloLHKnqLaCfsL1IztsTRVXy/y3SborH8LL07IlBtEQaLbt55gHcXdbs+XmQ7VEuUd
         4a21ai5HLw9acgT8qx91lsGOKuB6OGDMQhoYY97wNkOZT6fg3cSPlc+x4/Xv599PCQ
         BpoyHpAYizvl4As0+gVW65h5ioU+99k3Og2ELs4vXNXinH73J0eYZsqPaA5xmLBwCS
         IFedkJycfslUmM/Bqy9NoYueYtlELyA5Zql3hPjf6hgDOl1pC1YxpBsj8ydJWLcwbE
         wQkTrK4yqAhiQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from bigcore.mess.org (unknown [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id 116A01000FE;
        Tue, 17 Oct 2023 10:18:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1697534282; bh=+OpHV9kVT8L30HIUZj/JT63HZUN6AzYfOP0xwc4acZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xl3thI+8+BKqaH95Kw10TEewIp+GoYvmI3Or9DES4U/Auo1InBIlRdMkJwfhLM6O8
         WoPP7bFGeyCwdVWqqTy4Q5dLdccSMRRFCmC4YrEbGbSnhT8lc8Clgzoyl6dzGfkzFd
         fobGp3qGtzvWr2fr1+v60YCwxuOeqROLlsih/ykbFdUWnCocSIjTRD6VUCkKX6aPjp
         4sbh3FdNhwR6/pzPXJK/mBHfUJl+mHuZJeIffwUxZeGpDvtE2J6+zGG+Nzr1kRZPhk
         dZsPQzVFR58ubAJxo0wiq/qIPEdyFvyJlRl8eBJiWikno2Ma8PxPs31pNdk0LQo9f+
         mg3a9rVYNDCrg==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] media: pwm-ir-tx: trigger edges from hrtimer interrupt context
Date:   Tue, 17 Oct 2023 10:17:39 +0100
Message-ID: <ebf90ef3c851dad20ca4cfacca8c1a2205833196.1697534024.git.sean@mess.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697534024.git.sean@mess.org>
References: <cover.1697534024.git.sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the driver much more precise.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/pwm-ir-tx.c | 79 ++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index ccb86890adcea..4f9844e6d3fa2 100644
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
+	uint *txbuf;
+	uint txbuf_len;
+	uint txbuf_index;
 };
 
 static const struct of_device_id pwm_ir_of_match[] = {
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
+		pwm_apply(pwm_ir->pwm, pwm_ir->state);
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
 
+	if (pwm_is_atomic(pwm_ir->pwm)) {
+		init_completion(&pwm_ir->tx_done);
+		hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		pwm_ir->timer.function = pwm_ir_timer;
+		rcdev->tx_ir = pwm_ir_tx_atomic;
+	} else {
+		dev_info(&pdev->dev, "tx will not be accurate as pwm device does not support atomic mode");
+		rcdev->tx_ir = pwm_ir_tx;
+	}
+
 	rcdev->priv = pwm_ir;
 	rcdev->driver_name = DRIVER_NAME;
 	rcdev->device_name = DEVICE_NAME;
-	rcdev->tx_ir = pwm_ir_tx;
 	rcdev->s_tx_duty_cycle = pwm_ir_set_duty_cycle;
 	rcdev->s_tx_carrier = pwm_ir_set_carrier;
 
-- 
2.42.0

