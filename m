Return-Path: <linux-kernel+bounces-148836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20208A87ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFF21C220E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8BB150995;
	Wed, 17 Apr 2024 15:39:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E662B1494AE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368349; cv=none; b=uQ1IKvbvNxeAgB0LOkkQ9l5Sf1fmYe07j3vvR4Dhjd7t62IRVCvuZoKohfS4UPtfdo5yo11NktP79IhYK6NFTYtN3gQ/XoJ1c2pV1z3iB6txfxrO5AbPaSn5ihJLxq0U6zFp87Cr+na0Mtj+77WcSu2uZt5KuMtFHunTmahBwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368349; c=relaxed/simple;
	bh=qyfmY3tuy2fDo/5DK9wtBA0/okqOTXICerBpuVZMPmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AT7BlWB+9TW3Vrt45BNJkivwKWc/hfTDorWfxs7yW2pnsQ3PIch1vB/URBUCX32y+bnvM5ZzeR86P9VWcOhEmGAQwge+7iFnYSRgqAuzdroZDmMAAonpc+bhDXMIxTyp8McP85DtGSdaP2j+/CU+zpqDm7E4qmExWOGMrIYxQgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx7NB-00075N-33; Wed, 17 Apr 2024 17:38:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx7NA-00CokT-Gw; Wed, 17 Apr 2024 17:38:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx7NA-002v0k-1O;
	Wed, 17 Apr 2024 17:38:56 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Lee Jones <lee@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-leds@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	kernel@pengutronix.de
Subject: [PATCH] leds: pwm: Disable PWM when going to suspend
Date: Wed, 17 Apr 2024 17:38:47 +0200
Message-ID: <20240417153846.271751-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240417144943.GA2399047@google.com>
References: <20240417144943.GA2399047@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1658; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=qyfmY3tuy2fDo/5DK9wtBA0/okqOTXICerBpuVZMPmM=; b=owGbwMvMwMXY3/A7olbonx/jabUkhjT5t2x2gSvWxT6OUPWVELcyTMg/+5I1mz9ks+LOhwayE TXf2Ys6GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZjIui3s/2yeL68wc2r//tA0 21x3348vmWnzdy88wOpqPynQkV2ouU/x6ZYlDDV5Nhvlv19JF/h6LP3EmpzzQofyTqz9KqCQ4up RfunmknwxjbKzHPYB5dcDoi6vtGDUrz0fk1ZscFt8UpXtu19lHCtaolnsrZadZ3OdfERtdUJ8qI t5h2fq7PIcw6N8z+YHX+r7eHE7d+2u21YNC9+xT0nOOfJAe+UpKZsDh4rLr3xiY77tE3ZIpLwoa WOc34fLgbknVduDNs5ZtG5W4Olzkxbu2TLpafuOulj5L4vWK/BOrtSJ/rsylLGjZELpgnWJDTrs odZdlfblbfxRZkcVw9QeOkSZi2V5TzzQrlluNOlC7pEAAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On stm32mp1xx based machines (and others) a PWM consumer has to disable
the PWM because an enabled PWM refuses to suspend. So check the
LED_SUSPENDED flag and depending on that set the .enabled property.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218559
Fixes: 76fe464c8e64 ("leds: pwm: Don't disable the PWM when the LED should be off")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

On Wed, Apr 17, 2024 at 03:49:43PM +0100, Lee Jones wrote:
> On Tue, 16 Apr 2024, Uwe Kleine-König wrote:
> > If you don't consider that suitable, I can create a patch that is easier
> > to pick up.
> 
> Yes, please submit it properly.

Here it comes.

Best regards
Uwe

 drivers/leds/leds-pwm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 4e3936a39d0e..e1b414b40353 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -53,7 +53,13 @@ static int led_pwm_set(struct led_classdev *led_cdev,
 		duty = led_dat->pwmstate.period - duty;
 
 	led_dat->pwmstate.duty_cycle = duty;
-	led_dat->pwmstate.enabled = true;
+	/*
+	 * Disabling a PWM doesn't guarantee that it emits the inactive level.
+	 * So keep it on. Only for suspending the PWM should be disabled because
+	 * otherwise it refuses to suspend. The possible downside is that the
+	 * LED might stay (or even go) on.
+	 */
+	led_dat->pwmstate.enabled = !(led_cdev->flags & LED_SUSPENDED);
 	return pwm_apply_might_sleep(led_dat->pwm, &led_dat->pwmstate);
 }
 

base-commit: 4eab358930711bbeb85bf5ee267d0d42d3394c2c
-- 
2.43.0


