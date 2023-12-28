Return-Path: <linux-kernel+bounces-12721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C388C81F950
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB0D285B75
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BC3D521;
	Thu, 28 Dec 2023 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Spwhd9EY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D011D526;
	Thu, 28 Dec 2023 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 66BC140E01A1;
	Thu, 28 Dec 2023 14:54:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ng2B1LZRXrFL; Thu, 28 Dec 2023 14:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1703775268; bh=jcyDiPI487B6t/5OUI/W6GwQkhmDmtuv3TJj+zdWb2c=;
	h=Date:From:To:Cc:Subject:From;
	b=Spwhd9EYHOOjpPmVPBFMW1p7OvIGjZHMzE5re9j+NS083HAxWSuaULrkF2O/p96np
	 g/+UB+yjwCCtM0ZRXfslJNnNYku5hUNRlfe/l0E+2ecZYw6t8ruvGyH3AwmMZAwmyF
	 Jorqe8Jez7HaqToDpefqGR+VdgB9ZOfmhTFLWyYCb+EAmR30uCvyw0G9s9siOjWCqP
	 Y/Cg1I9pkGldj9lOusmR+JY10kVg0qAH3li2Ib6B1Pnn1I0BnXKdP/f2SlcjDWv+UH
	 8EHI9iI7MdQZRmzvdu1aHBVoqyqY6+RC66XnHpT56suQ6fd+1rkkPCgJxvbvGcqQJI
	 7QFx7UAAqnPg9IBubEpjYejrPTlZKBDP2ahzWT2Z9PQ+9TVxbl0TTAUOMMhVYk2+xr
	 0ssAyea+WQQjLHDeXQh2IDCM4nH20A3evPBFYzLZPRApN5b6BpaL6VGtLHedZOs3Tg
	 EnR4YAbF7X9/+5tiKVNDq1yeAYoka82tMVbZNub6KpN4bS03+zRjSz/9T6YEYGSG3s
	 p1xxOQH2dUE4vPSoeRAYiW+G6Lc4gduGXHG4R8gcn24f6f3am7lPsAYNwTmfUb6ziM
	 IdTFbeGpUFbmgVptQo2qezc78mGoU4j16SLzqnGpjGVQTNXlQ3vbKEE0SvSSJ7Dk8e
	 XTPABiVW1FDiDcsYUFEzgkOw=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5BEEB40E00CB;
	Thu, 28 Dec 2023 14:54:23 +0000 (UTC)
Date: Thu, 28 Dec 2023 15:54:16 +0100
From: "Borislav Petkov (AMD)" <bp@alien8.de>
To: linux-pm@vger.kernel.org, forza@tnonline.net
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpuidle: haltpoll: Do not enable interrupts when entering
 idle
Message-ID: <20231228145416.GAZY2MGLY6THMkAZ2W@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

I think PeterZ's massaging from

  https://lore.kernel.org/all/20230112194314.845371875@infradead.org/

missed one.

@Forza, if you want to have your real name in the patch tags below and
thus be part of git history, lemme know. If you don't want them there,
either.

Thx.

---
From: Borislav Petkov (AMD) <bp@alien8.de>

The cpuidle governors' ->enter() methods are supposed to be IRQ
invariant:

  5e26aa933911 ("cpuidle/poll: Ensure IRQs stay disabled after cpuidle_state::enter() calls")
  bb7b11258561 ("cpuidle: Move IRQ state validation")

Do that in the haltpoll governor too.

Fixes: 5e26aa933911 ("cpuidle/poll: Ensure IRQs stay disabled after cpuidle_state::enter() calls")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218245
Reported-by: <forza@tnonline.net>
Tested-by: <forza@tnonline.net>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 drivers/cpuidle/cpuidle-haltpoll.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
index e66df22f9695..d8515d5c0853 100644
--- a/drivers/cpuidle/cpuidle-haltpoll.c
+++ b/drivers/cpuidle/cpuidle-haltpoll.c
@@ -25,13 +25,12 @@ MODULE_PARM_DESC(force, "Load unconditionally");
 static struct cpuidle_device __percpu *haltpoll_cpuidle_devices;
 static enum cpuhp_state haltpoll_hp_state;
 
-static int default_enter_idle(struct cpuidle_device *dev,
-			      struct cpuidle_driver *drv, int index)
+static __cpuidle int default_enter_idle(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int index)
 {
-	if (current_clr_polling_and_test()) {
-		local_irq_enable();
+	if (current_clr_polling_and_test())
 		return index;
-	}
+
 	arch_cpu_idle();
 	return index;
 }
-- 
2.42.0.rc0.25.ga82fb66fed25


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

