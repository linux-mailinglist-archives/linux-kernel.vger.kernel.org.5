Return-Path: <linux-kernel+bounces-95210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB14C874AB2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE0A1C20E30
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DB0839F6;
	Thu,  7 Mar 2024 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QHh4o7yv"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB46F6350B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803282; cv=none; b=IL5w5gfi5gTyu6d3jKo9mqrW8MOeMSoR6/2mo876jXw9l1agM1mQ62y4IdaOHjH7tFzFywne1yadBGG04K10LEYVwbEoKakc/zE1Wqkh1QJ2IYjdDQ9pG1p0v/wZCiBhdCHOePxKF/0XOZwMW2ED55g+Sc8cpR7GIQ0wvjXWiWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803282; c=relaxed/simple;
	bh=AKXmBNz3WfIztfIt0jar+401py0ewlYTSNth4Z0xnCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ul+MiWWI/PXu/T6SOicULrtHm3JYzRtB8YC+dTeFSrUCkgEeyhLdptMi3Urdd/RY4d83qxf2I9c4xrLe+psJ2hj/Pqsk7lNCn56QpGINeu3c+F5dcO4BUFpONcXcEMlGH79K8nmFvl4TZ5Jj2TZCDuynAimrAA0y+dkn+7r4260=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QHh4o7yv; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28a6cef709so103583666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 01:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709803279; x=1710408079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MSg3oiWFtppc35EPshcXwhJatcffMq34NPA9WcvRkJ4=;
        b=QHh4o7yvUXzKg6fnugF/7+t63KMhr1zE7Snc9478WcRGHjUrZKTWIKjc+tH+qvmL4f
         LGGFFyfY54/LiTQVEetQrp3j7njpNpDo1sqOk9e7RV+efNLeKbC9qg+GBsIcFaoleCOp
         /DFDhKp92Gp3PxSEUryqVEgh09Fkv3ld+DtLOKgC3nPVbwZVEIgqI8JAw9U6arfXJRtl
         f7MJ//2D4oEAX6icDmjn+1upMRjWZ0kcAnmub0qXYKGugRES2n7TgXw3Qi/SEFlfLIhm
         0e9AMUVCeB/PRpgr15atmWDEScBzvIvdckU78U/nWIbTLdBDNVWZ+jCbjA7/C4AJeq0J
         N5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709803279; x=1710408079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MSg3oiWFtppc35EPshcXwhJatcffMq34NPA9WcvRkJ4=;
        b=jtDAB1c77w3EQLzdhgbPbcwei7cga54QUKAkqc9+PRWK3sJ/Rp3LLSsMo5I1hFvqLm
         voHIeTbWAWHt5aqHLFRBAyfahzEwKXEq19wfcib3tN4mn+PZYdLcXwKJekmoSEzTwFNI
         m9lLa9gJp9UU1L5ytQw73tw+We9B42epe7D93/nsWFXmFulFSHKon8hUgyt1YKCtBdmO
         YSrDZvUUS99+DaqzZuax373ObpKZVCIYeCl2bsgp9VW8PGL1xMBxBjnjxo7w2EOX8gHC
         z16Ma9QF1ZQG/a+LzWZYotZQo6nupfb8Whz4g2Ux/3j/aFX+JsyeRiIaPDcHG8hepLFs
         jlOw==
X-Gm-Message-State: AOJu0YwJb3o3kAkrfy4B8iFN29JyVJ8nw+AaBGTI/1mCCPEUqv0ErEyW
	GvKcTdrlrocbLloKoVEAaOm+FIN//Mt1ow30O1+rmoVLpO2Bh/xEIpsQKoyeyNbKf+ycxVMvoOL
	/
X-Google-Smtp-Source: AGHT+IFG49439I8OGhNKMiXoTIiwH2fo7jWvi0IkRLnDND242P5GtEZVZ/wFaS9l7pM8oL8DqWRjqg==
X-Received: by 2002:a17:907:367:b0:a44:1ed2:64a3 with SMTP id rs7-20020a170907036700b00a441ed264a3mr12098018ejb.11.1709803278740;
        Thu, 07 Mar 2024 01:21:18 -0800 (PST)
Received: from localhost.localdomain (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id f26-20020a17090624da00b00a45c2b4f228sm1165342ejb.43.2024.03.07.01.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:21:18 -0800 (PST)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: Marc Bonnici <marc.bonnici@arm.com>,
	Olivier Deprez <Olivier.Deprez@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH] firmware: arm_ffa: fix ffa_notification_info_get()
Date: Thu,  7 Mar 2024 10:21:04 +0100
Message-Id: <20240307092104.937440-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FFA_NOTIFICATION_INFO_GET retries information about pending
notifications. Notifications can be either global or per VCPU. Global
notifications are represented by the VM ID only, or 0 in the absence of
a hypervisor. ffa_notification_info_get() incorrectly expect no ID at all
for global notifications. Fix this by checking for 1 ID instead of 0.

Fixes: 3522be48d82b ("firmware: arm_ffa: Implement the NOTIFICATION_INFO_GET interface")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/firmware/arm_ffa/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index c183c7d39c0f..ff1f37a4b28c 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -790,7 +790,7 @@ static void ffa_notification_info_get(void)
 
 			part_id = packed_id_list[ids_processed++];
 
-			if (!ids_count[list]) { /* Global Notification */
+			if (ids_count[list] == 1) { /* Global Notification */
 				__do_sched_recv_cb(part_id, 0, false);
 				continue;
 			}
-- 
2.34.1


