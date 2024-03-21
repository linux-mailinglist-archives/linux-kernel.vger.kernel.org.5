Return-Path: <linux-kernel+bounces-110169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF9F885B14
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971671C219A1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479108595C;
	Thu, 21 Mar 2024 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="UaOftfse"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777391E53F;
	Thu, 21 Mar 2024 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032285; cv=none; b=iCotV9aeoTOXX39OdIuzftpvzHDGUMRe7u1LVwOY0xdC/wA2QpIqXFrEAmreSBTcHkANYSK7+0wb3t/L/tTPOXpA/ps+MxJBAvopuIPdRxMoeORgB+IF11cWMaYVKaOFzkvWbJ90jjb9tenAvlHZ944snp/6ikgiiwyjMR2Clp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032285; c=relaxed/simple;
	bh=W52VFO6+JoxAJcY1nLZaHrx+1XLbKPfE+RhNuXYMyCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JKE+PxnUt5cYkjqR4CGTI6fNRuV5sDTzrnbWN5leyyY2pNeMHapDfFSpBxDxUCCn/Krj8yVHKyCk7kIC9UOQPs+Cf1DMiILy2bPuosP/PjlAUGNJBX9UA+8pL+c8OA8fuOlsW9z7rezHB4DYV5qlpzbugdld20oU3az7rGScJs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=UaOftfse; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 0FEF7401B8;
	Thu, 21 Mar 2024 19:44:32 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1711032273; bh=W52VFO6+JoxAJcY1nLZaHrx+1XLbKPfE+RhNuXYMyCY=;
	h=From:Date:Subject:To:Cc:From;
	b=UaOftfseQHH5gfPllLsKaUKfRyro7UlsT52/OPWeX5fk+y34RlT8P3ZePCS+CKZRj
	 dVv+WAKoid5anohBTEg5ZQe3MlYZteMBi3j8Pa6l7L7MovwkGJSa7XBUXPnnEzTj9L
	 r1qfuxTB70fScs2vHHL3xR8d9T1Rds1Vm+lky1Hw1UUEpB1nLW205AgUJVs33jcQ1t
	 +6+P5KNXPFgazMjhlQCKy2LVfmBFCN/xJwVKJDi2LjQoKwzvBOaFtQCHWUE0sOUYR0
	 CMo5sZ9VGC72NY6xsNpls8WSI5VW0I7kUFV2ngOVTF1V4VOfhGNLgl/9aJR/k0rJ0J
	 FwlvF5yHXVjvg==
From: Nikita Travkin <nikita@trvn.ru>
Date: Thu, 21 Mar 2024 19:44:13 +0500
Subject: [PATCH] thermal: gov_power_allocator: Allow binding without
 cooling devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-gpa-no-cooling-devs-v1-1-5c9e0ef2062e@trvn.ru>
X-B4-Tracking: v=1; b=H4sIAL1H/GUC/x3MQQqAIBBA0avErBuwsci6SrQInWwgNBQiCO+et
 HyL/1/InIQzzM0LiW/JEkNF1zZgjy14RnHVQIp6palDf20YItoYTwkeHd8Z7TgxazJG0wC1vBL
 v8vzXZS3lA2efe/BlAAAA
To: Lukasz Luba <lukasz.luba@arm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3118; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=W52VFO6+JoxAJcY1nLZaHrx+1XLbKPfE+RhNuXYMyCY=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBl/EfOdmOMHxpTbs4VadDGYduboR6lXbm5aVPLU
 d36f6ZXZs6JAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZfxHzgAKCRBDHOzuKBm/
 dYaiD/9NB6CUpKVlW+cza/WT7F1ywt8KRiuCT8sKxzGPwzwtZcwFdTPx+kvA8UdlQrtxfjAEJ2l
 pVw5trNqTe+mtmp96XCjMmReWz4OkX6yOKlnf4vBFqDjmTHykpXz5uvqWPqK+v/CcAZBk0ZZgYR
 nTbuTwVs+rT9rfvY9a4e8h3QIn1UaUAsJzSCN2tfqTQpZQPxispxYW9dbvrtPVYqxipRWWi7hNo
 nUfWJEhwfK3aofkc9ZU74fsg8PD9JdZYIYoZISBP15SUOpSe+UOSdYqMdD0ibLUDqYXzlFWNDDe
 YA15Bg/iXRoqa54moUovawv/6aMe+g0YTGyruk5ld4Wpek1vWcOBExCpOCha2xyLJ+RNihQKdzE
 tExxd3PCFRbHmtYpGs39n/2Pf6PS9NSdGMRX4pViXz6mtd7CpueDNVvV74WuWmEhHUTcn6WGqR9
 fljGjozsBcYwHFV55Dpm81YQ5MS5ZEmqMJTRgmkGpMS1gNwFrTQD9WSaSwS6PdsZBB8OvGVhEeO
 iGe5wD6wKiE6drdYexIZurbXA2jtJfKZ2eEMgoBu3OtNwZSk9pqqO1jgCBuZUFl3ArU3kpo2c3a
 uegg1OdUmwQiuv9mR8QKhUdWp+McY1N5nbAsSkFI4RfMhtBLElgTadKG+s1ZxwVWgnZ0ouHNjHy
 s2rc6BJQ5AGwyXQ==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75

Commit e83747c2f8e3 ("thermal: gov_power_allocator: Set up trip points earlier")
added a check that would fail binding the governer if there is no
cooling devices bound to the thermal zone. Unfortunately this causes
issues in cases when the TZ is bound to the governer before the cooling
devices are attached to it. (I.e. when the tz is registered using
thermal_zone_device_register_with_trips().)

Additionally, the documentation across gov_power_allocator suggests it's
intended to allow it to be bound to thermal zones without cooling
devices (and thus without passive/active trip points), however the same
change added a check for the trip point to be present, causing those TZ
to fail probing.

Those changes cause all thermal zones to fail on some devices (such as
sc7180-acer-aspire1) and prevent the kernel from controlling the cpu/gpu
frequency based on the temperature, as well as losing all the other
"informational" thermal zones if power_allocator is set as default.

This commit partially reverts the referenced one by dropping the trip
point check and by allowing the TZ to probe even if no actor buffer was
allocated to allow those TZ to probe again.

Fixes: e83747c2f8e3 ("thermal: gov_power_allocator: Set up trip points earlier")
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
I've noticed that all thermal zones fail probing with -EINVAL on my
sc7180 based Acer Aspire 1 since 6.8. This commit allows me to bring
them back.
---
 drivers/thermal/gov_power_allocator.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 1b17dc4c219c..4f2d7f3b7508 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -679,11 +679,6 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 		return -ENOMEM;
 
 	get_governor_trips(tz, params);
-	if (!params->trip_max) {
-		dev_warn(&tz->device, "power_allocator: missing trip_max\n");
-		kfree(params);
-		return -EINVAL;
-	}
 
 	ret = check_power_actors(tz, params);
 	if (ret < 0) {
@@ -693,7 +688,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	}
 
 	ret = allocate_actors_buffer(params, ret);
-	if (ret) {
+	if (ret && ret != -EINVAL) {
 		dev_warn(&tz->device, "power_allocator: allocation failed\n");
 		kfree(params);
 		return ret;
@@ -714,9 +709,10 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	else
 		params->sustainable_power = tz->tzp->sustainable_power;
 
-	estimate_pid_constants(tz, tz->tzp->sustainable_power,
-			       params->trip_switch_on,
-			       params->trip_max->temperature);
+	if (params->trip_max)
+		estimate_pid_constants(tz, tz->tzp->sustainable_power,
+				       params->trip_switch_on,
+				       params->trip_max->temperature);
 
 	reset_pid_controller(params);
 

---
base-commit: e7528c088874326d3060a46f572252be43755a86
change-id: 20240321-gpa-no-cooling-devs-c79ee3288325

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>


