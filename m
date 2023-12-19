Return-Path: <linux-kernel+bounces-4758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB188181A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3617C1C23434
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E1EC158;
	Tue, 19 Dec 2023 06:44:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC88C123
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFTq9-0008Bm-5y; Tue, 19 Dec 2023 07:44:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFTq7-00Gs4p-P9; Tue, 19 Dec 2023 07:44:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFTq7-005oH1-Fc; Tue, 19 Dec 2023 07:44:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kernel@pengutronix.de,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 1/2] bus: ts-nbus: Convert to atomic pwm API
Date: Tue, 19 Dec 2023 07:44:14 +0100
Message-ID:  <6ae9784dfb98ff63b44735b903e7f4d4e3980222.1702967898.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Y75lwnbkJyYsgOfhDJ0vdUpyY0E8lmiDU57c9pD1TA4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtRG633veybq1ofUuDQebL1oobJQxp8x7kH2zX+PLr0tz 1s3Y0pNJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQAT6RJk/x/EsEiB6bHxDqYw 74z19438vi95d1zx3868JPc76bc0PqSplSrfkQ4V25Vh6FWz9VM8v8j6XiYekZvTJSNceA/5s/2 9LPVjpt4ruQzRY8emzT5ZFXxqKcuUKKf4nM8Hf0y/+eWO4NIAjk/+KeyPkxdOeNYQsffneTl+9s 3r/W/a+h4wjjNcEawu5Hvg8gKetCUPD5+T/RaYrSGaJRVgkas40Y7v0rdwRY/wRKWp1voPlnOtE vCeEWZj9JTDUc39b5xRk46ZQH8zY+AOBbmcJ8c0Tkv3TBDmfNAvWefQ9b31SMX9/TMe1Rorbvu3 hC3c5MnneEFnT6ZsWdfwNs+/qtsu12/fpNFykvce29ptAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

With this change the PWM hardware is only configured once (instead of
three times).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Changes since (implicit) v1
(https://lore.kernel.org/linux-kernel/c3db8ab2bb447f55aa0f2af0aa3cc6e758b6acc9.1702160838.git.u.kleine-koenig@pengutronix.de):

- Add a closing parenthesis to the commit log (xkcd#859)
- Rebase to todays next/master (trivial)

Arnd, there is no dedicated maintainer for drivers/bus. Would you take
these patches? Tell me if you prefer a PR.

Best regards
Uwe

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

base-commit: aa4db8324c4d0e67aa4670356df4e9fae14b4d37
-- 
2.42.0


