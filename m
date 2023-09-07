Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FC0797DA7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240463AbjIGVAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjIGVAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:00:38 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2E81BCB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:00:34 -0700 (PDT)
Received: from [134.238.52.102] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qeHcf-004U1Q-Gf; Thu, 07 Sep 2023 17:12:49 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qeHcd-000HV4-2m;
        Thu, 07 Sep 2023 17:12:47 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.dooks@codethink.co.uk, u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: [PATCH v9 4/6] pwm: dwc: use clock rate in hz to avoid rounding issues
Date:   Thu,  7 Sep 2023 17:12:40 +0100
Message-Id: <20230907161242.67190-5-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230907161242.67190-1-ben.dooks@codethink.co.uk>
References: <20230907161242.67190-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As noted, the clock-rate when not a nice multiple of ns is probably
going to end up with inacurate calculations, as well as on a non pci
system the rate may change (although we've not put a clock rate
change notifier in this code yet) so we also add some quick checks
of the rate when we do any calculations with it.

Signed-off-by; Ben Dooks <ben.dooks@codethink.co.uk>
Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
v9:
 - fixed commit spelling
 - changed to use codethink email instead of sifive
v8:
 - fixup post rename
 - move to earlier in series
---
 drivers/pwm/pwm-dwc-core.c | 24 +++++++++++++++---------
 drivers/pwm/pwm-dwc.h      |  2 +-
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
index 3fc281a78c9a..3b856685029d 100644
--- a/drivers/pwm/pwm-dwc-core.c
+++ b/drivers/pwm/pwm-dwc-core.c
@@ -49,13 +49,14 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
 	 * periods and check are the result within HW limits between 1 and
 	 * 2^32 periods.
 	 */
-	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
+	tmp = state->duty_cycle * dwc->clk_rate;
+	tmp = DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	low = tmp - 1;
 
-	tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
-				    dwc->clk_ns);
+	tmp = (state->period - state->duty_cycle) * dwc->clk_rate;
+	tmp = DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	high = tmp - 1;
@@ -121,11 +122,14 @@ static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 			     struct pwm_state *state)
 {
 	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+	unsigned long clk_rate;
 	u64 duty, period;
 	u32 ctrl, ld, ld2;
 
 	pm_runtime_get_sync(chip->dev);
 
+	clk_rate = dwc->clk_rate;
+
 	ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(pwm->hwpwm));
 	ld = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
 	ld2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
@@ -137,17 +141,19 @@ static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * based on the timer load-count only.
 	 */
 	if (ctrl & DWC_TIM_CTRL_PWM) {
-		duty = (ld + 1) * dwc->clk_ns;
-		period = (ld2 + 1)  * dwc->clk_ns;
+		duty = ld + 1;
+		period = ld2 + 1;
 		period += duty;
 	} else {
-		duty = (ld + 1) * dwc->clk_ns;
+		duty = ld + 1;
 		period = duty * 2;
 	}
 
+	duty *= NSEC_PER_SEC;
+	period *= NSEC_PER_SEC;
+	state->period = DIV_ROUND_CLOSEST_ULL(period, clk_rate);
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(duty, clk_rate);
 	state->polarity = PWM_POLARITY_INVERSED;
-	state->period = period;
-	state->duty_cycle = duty;
 
 	pm_runtime_put_sync(chip->dev);
 
@@ -168,7 +174,7 @@ struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
 	if (!dwc)
 		return NULL;
 
-	dwc->clk_ns = 10;
+	dwc->clk_rate = NSEC_PER_SEC / 10;
 	dwc->chip.dev = dev;
 	dwc->chip.ops = &dwc_pwm_ops;
 	dwc->chip.npwm = DWC_TIMERS_TOTAL;
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
index 64795247c54c..e0a940fd6e87 100644
--- a/drivers/pwm/pwm-dwc.h
+++ b/drivers/pwm/pwm-dwc.h
@@ -42,7 +42,7 @@ struct dwc_pwm_ctx {
 struct dwc_pwm {
 	struct pwm_chip chip;
 	void __iomem *base;
-	unsigned int clk_ns;
+	unsigned long clk_rate;
 	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
 };
 #define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
-- 
2.40.1

