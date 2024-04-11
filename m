Return-Path: <linux-kernel+bounces-140090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 739518A0B58
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E827283CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F689147C77;
	Thu, 11 Apr 2024 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOg5Nnn0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7A714659E;
	Thu, 11 Apr 2024 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824327; cv=none; b=HHgpWNRAGHHL9eW3d1Lr102Um1g2nobulR/evM+nT2VS3OFFFHY+QARyWL/a6wYQM0HUvINx+x+BsEpj3x33r2K9HpAkrhHbhxbvLy9OqT5x3yZ+eswMkjObMOYGLma+/WFw+33SLaJI0WJjEpwc0rLOqgGcsXPZZsFL8xsvD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824327; c=relaxed/simple;
	bh=4TU/zftz2/VHnWzV3r9cBoeolRMOB6be9XResQyxXNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qcd48NDfXihgrPh09g7jkBUwoKyeZJhZOrl0NIMO/XEODfIaqEVRhzRFyelXKJLAayslbjuuryTZWmeDFIQFYq/HRXWUAZQEJY6zXThiWLvFns8Gz3U8kH8WyqLxM7pyTLYEMq+siy524oOZIuzYu5HO7MozCTcbd61hS8G4EjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOg5Nnn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E00E9C43399;
	Thu, 11 Apr 2024 08:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712824326;
	bh=4TU/zftz2/VHnWzV3r9cBoeolRMOB6be9XResQyxXNw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VOg5Nnn0XLASgyj0MK6huHrdw6waf1y0yuC+oblarqy429PvIdQQhqbC+SnEww80X
	 zVlb30yNyivgdsMwyCu1RW4vXAaIj6MntbyYjoukpPOjacIEGeOJ2b+34KngNZq+km
	 28RbGCvlW4sA970rsoi3pj9RjyjBWvoukrt89hlGOBp50qMnXJ056YkPQ3o+JR+BLv
	 ARP5s5xsYvSA/a3rXtkNkNLEp7TnC98HrvYJhymMLBuEh89myZT1Dohlc5d2YlIBuz
	 6k3hSQhdR18p264tXhayF2jjLw5WrAzlRBHk9WrG99l+qION4XU2aAAH0+40qcrfJG
	 P7lf9k+0gkFgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0309CD1292;
	Thu, 11 Apr 2024 08:32:06 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Date: Thu, 11 Apr 2024 16:30:57 +0800
Subject: [PATCH v9 1/4] input: pm8xxx-vibrator: correct VIB_MAX_LEVELS
 calculation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-pm8xxx-vibrator-new-design-v9-1-7bf56cb92b28@quicinc.com>
References: <20240411-pm8xxx-vibrator-new-design-v9-0-7bf56cb92b28@quicinc.com>
In-Reply-To: <20240411-pm8xxx-vibrator-new-design-v9-0-7bf56cb92b28@quicinc.com>
To: kernel@quicinc.com, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Fenglin Wu <quic_fenglinw@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712824325; l=1231;
 i=quic_fenglinw@quicinc.com; s=20240327; h=from:subject:message-id;
 bh=XkZnFbyEclgfZYkpfzfPCbadhXwXzt48J68H2vEZT+g=;
 b=TT6XRoITbYVVVhdgUixCMPRemA7UdNfcjUqCgfwIwiEaNpsvUjDchxv0aIz4se5E8QC2TGwBS
 44bYehx2zFYA4kyAGQQ9wEQa6hFCWBCfackEp6DGSPjrGRvSWXyI+3C
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for quic_fenglinw@quicinc.com/20240327
 with auth_id=146
X-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Reply-To: quic_fenglinw@quicinc.com

From: Fenglin Wu <quic_fenglinw@quicinc.com>

The output voltage is inclusive hence the max level calculation is
off-by-one-step. Correct it.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/input/misc/pm8xxx-vibrator.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 04cb87efd799..89f0f1c810d8 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -14,7 +14,8 @@
 
 #define VIB_MAX_LEVEL_mV	(3100)
 #define VIB_MIN_LEVEL_mV	(1200)
-#define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV)
+#define VIB_PER_STEP_mV	(100)
+#define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV + VIB_PER_STEP_mV)
 
 #define MAX_FF_SPEED		0xff
 
@@ -118,10 +119,10 @@ static void pm8xxx_work_handler(struct work_struct *work)
 		vib->active = true;
 		vib->level = ((VIB_MAX_LEVELS * vib->speed) / MAX_FF_SPEED) +
 						VIB_MIN_LEVEL_mV;
-		vib->level /= 100;
+		vib->level /= VIB_PER_STEP_mV;
 	} else {
 		vib->active = false;
-		vib->level = VIB_MIN_LEVEL_mV / 100;
+		vib->level = VIB_MIN_LEVEL_mV / VIB_PER_STEP_mV;
 	}
 
 	pm8xxx_vib_set(vib, vib->active);

-- 
2.25.1



