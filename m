Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83041797DA5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbjIGVAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjIGVAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:00:34 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E751990
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:00:31 -0700 (PDT)
Received: from [134.238.52.102] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qeHcf-004U1P-DW; Thu, 07 Sep 2023 17:12:49 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qeHcd-000HUz-2h;
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
Subject: [PATCH v9 3/6] pwm: dwc: add PWM bit unset in get_state call
Date:   Thu,  7 Sep 2023 17:12:39 +0100
Message-Id: <20230907161242.67190-4-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230907161242.67190-1-ben.dooks@codethink.co.uk>
References: <20230907161242.67190-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we are not in PWM mode, then the output is technically a 50%
output based on a single timer instead of the high-low based on
the two counters. Add a check for the PWM mode in dwc_pwm_get_state()
and if DWC_TIM_CTRL_PWM is not set, then return a 50% cycle.

This may only be an issue on initialisation, as the rest of the
code currently assumes we're always going to have the extended
PWM mode using two counters.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
v9:
 - fixed multi-line comment
 - put authour back to codethink email from sifive
v8:
 - fixed rename issues
v4:
 - fixed review comment on mulit-line calculations
---
 drivers/pwm/pwm-dwc-core.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
index 4b4b7b9e1d82..3fc281a78c9a 100644
--- a/drivers/pwm/pwm-dwc-core.c
+++ b/drivers/pwm/pwm-dwc-core.c
@@ -122,24 +122,32 @@ static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct dwc_pwm *dwc = to_dwc_pwm(chip);
 	u64 duty, period;
+	u32 ctrl, ld, ld2;
 
 	pm_runtime_get_sync(chip->dev);
 
-	state->enabled = !!(dwc_pwm_readl(dwc,
-				DWC_TIM_CTRL(pwm->hwpwm)) & DWC_TIM_CTRL_EN);
+	ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(pwm->hwpwm));
+	ld = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
+	ld2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
 
-	duty = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
-	duty += 1;
-	duty *= dwc->clk_ns;
-	state->duty_cycle = duty;
+	state->enabled = !!(ctrl & DWC_TIM_CTRL_EN);
 
-	period = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
-	period += 1;
-	period *= dwc->clk_ns;
-	period += duty;
-	state->period = period;
+	/*
+	 * If we're not in PWM, technically the output is a 50-50
+	 * based on the timer load-count only.
+	 */
+	if (ctrl & DWC_TIM_CTRL_PWM) {
+		duty = (ld + 1) * dwc->clk_ns;
+		period = (ld2 + 1)  * dwc->clk_ns;
+		period += duty;
+	} else {
+		duty = (ld + 1) * dwc->clk_ns;
+		period = duty * 2;
+	}
 
 	state->polarity = PWM_POLARITY_INVERSED;
+	state->period = period;
+	state->duty_cycle = duty;
 
 	pm_runtime_put_sync(chip->dev);
 
-- 
2.40.1

