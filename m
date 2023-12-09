Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEA180B6DD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 23:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjLIWfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 17:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjLIWf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 17:35:28 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4AE10B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 14:35:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rC5uw-00032N-Ox; Sat, 09 Dec 2023 23:35:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rC5uw-00EjdL-0E; Sat, 09 Dec 2023 23:35:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rC5uv-00HPIS-NE; Sat, 09 Dec 2023 23:35:25 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 1/2] bus: ts-nbus: Convert to atomic pwm API
Date:   Sat,  9 Dec 2023 23:35:08 +0100
Message-ID:  <c3db8ab2bb447f55aa0f2af0aa3cc6e758b6acc9.1702160838.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702160838.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702160838.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1440; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=NUJ1Gt6VwGMftKvVqxYgxzXSxQDiBB4zUBEKnts2wfE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBldOuh5BIaA5FJtvLH/lJXrJ/5Lo1Ru8696ozS1 uDV9Fu4XxmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXTroQAKCRCPgPtYfRL+ TvN/B/9PVKXEOogbv4Dji0ItazpVzG1TDX860dC8abRXAuPfby0Y6TAUwzJlfiXfBVmADU8t7Ds CDhEcgrxm8UlVwFMugLmIH3Sf5QZu8vflDtV5SHBJsofWO4t9mEBPMDkddf+hudqL6UEJH9Zd1P h1zeTP5fghvDDtcWyRVhFFt1qXFyLTB64ufI9yd8fp1qf7EiA0oAP7VbfWvl2us8YGUWWlw5UQg 68q15YURS0Z2yfOUw+/zkqsuIpUy0KzR4w23ClTRl7JpCR820gE7dBydgruMemvnWJt0QJLeMp3 SBWklQdJw0c1AOZJeowQRoJcOluYvlHxUwSSQHt3yEJ7ycsw
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this change the PWM hardware is only configured once (instead of
three times.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/bus/ts-nbus.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index 4fa932cb0915..19c5d1f4e4d7 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -273,7 +273,7 @@ EXPORT_SYMBOL_GPL(ts_nbus_write);
 static int ts_nbus_probe(struct platform_device *pdev)
 {
 	struct pwm_device *pwm;
-	struct pwm_args pargs;
+	struct pwm_state state;
 	struct device *dev = &pdev->dev;
 	struct ts_nbus *ts_nbus;
 	int ret;
@@ -296,25 +296,22 @@ static int ts_nbus_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pwm_get_args(pwm, &pargs);
-	if (!pargs.period) {
+	pwm_init_state(pwm, &state);
+	if (!state.period) {
 		dev_err(&pdev->dev, "invalid PWM period\n");
 		return -EINVAL;
 	}
 
-	/*
-	 * FIXME: pwm_apply_args() should be removed when switching to
-	 * the atomic PWM API.
-	 */
-	pwm_apply_args(pwm);
-	ret = pwm_config(pwm, pargs.period, pargs.period);
+	state.duty_cycle = state.period;
+	state.enabled = true;
+
+	ret = pwm_apply_state(pwm, &state);
 	if (ret < 0)
 		return ret;
 
 	/*
 	 * we can now start the FPGA and populate the peripherals.
 	 */
-	pwm_enable(pwm);
 	ts_nbus->pwm = pwm;
 
 	/*
-- 
2.42.0

