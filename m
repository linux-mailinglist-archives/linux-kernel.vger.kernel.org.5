Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16567D9385
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345627AbjJ0JVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0JVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:21:41 -0400
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27642C0;
        Fri, 27 Oct 2023 02:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1698398498; bh=zBxWi8MQUDX7DBBtEIkwqqmnqFZ1vJcG4pny5YR7se0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pTpPGqSAoDl031doiXKos+ptO7qUwJnPnExj3TsRDZSFXUUGhfCZWsa8GFmgmCqW/
         Mr+SDsfpn5nnKvCONOvKhDXaqGwPgSkqfnRUpoQZsCgRamNFqQ/Y9TGyTO6smGxNeC
         9dRSa89D6dkSRuHl7xxFeosoAS5upawC6yc4iYdr1j9iLUJ5rZFstV22aiR6/MVC4E
         uJIkK7NtQZHm6PeRHed4z8K7aqgiltuJnxZatjppTVaRtRzSiZPDHX5gdkxW5+nZAa
         RW8UrQpzkFCJTIDcvywi/NVtLYaQaIiqgIs8+C2OCK7mtIfLQNn3aSl/f7RskaqHUv
         /PK5915Mxbnkg==
Received: by gofer.mess.org (Postfix, from userid 501)
        id 11381100100; Fri, 27 Oct 2023 10:21:38 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1698398482; bh=zBxWi8MQUDX7DBBtEIkwqqmnqFZ1vJcG4pny5YR7se0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UBH7GUyqOR41CCzW7TW0FgO+DouBYB42qhQOYu1ukcGc6u3Ib/PSuHhSyUOck78wu
         9rqa3EvvJNxCinCmVFzB0DfqV3w9ZvLq3q45K0PptKcLtboiEVRuljqD03mPEG/nQn
         bdW2+zKRknbRwcPvb8qXEMt+fe1aTlm2ApPiDe6mbQKDSDZZhglyoGQUXTn0/iIwFi
         RvKdKViouI1W0JM4yduG/OC6nYxbp/6JTxiTWE8SckZZlYIm5wbooG/Fx2voA8iPjs
         uzp1kvG4+9tcusZQooKCsFiseIN29x/LkdamzQjabHhZwlPOC8bw/uIrhEhulxAvwI
         yo2dt34W1nrpg==
Received: from bigcore.mess.org (unknown [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id A4EA2100103;
        Fri, 27 Oct 2023 10:21:22 +0100 (BST)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] media: pwm-ir-tx: trigger edges from hrtimer interrupt context
Date:   Fri, 27 Oct 2023 10:20:47 +0100
Message-ID: <15e5b0856a9b09b3066591fa0004a0db4e9c66c6.1698398004.git.sean@mess.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698398004.git.sean@mess.org>
References: <cover.1698398004.git.sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the generated IR much more precise. Before this change, the
driver is unreliable and many users opted to use gpio-ir-tx instead.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/pwm-ir-tx.c | 79 ++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index ccb86890adce..5465bd38d941 100644
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

