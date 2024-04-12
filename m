Return-Path: <linux-kernel+bounces-142656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B272A8A2E77
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50BCF1F222CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD845C909;
	Fri, 12 Apr 2024 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8Jv7tYM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA4B54F87;
	Fri, 12 Apr 2024 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712925406; cv=none; b=t+/ngFnUoxZxrP/3x5cFh9WKbEl2Kr+5DnT5u1YQglGLQLylptPRsmgnxDVZdE7UoncYHNvBZn3MH1YV6zTFH2Sm+bVF+cv/dNEtSqVYtS0IJJnE2A3aepwzWbA6ZEED+XeSEtDiBzzebIRGReK9vTPqM/xuWMULKfDZCdHHGFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712925406; c=relaxed/simple;
	bh=G0GWDtrUka0cfT9mQcWpAahixZ8YB0wM3L0wDhlXIfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pmbVJC0TOUe+g0fCgBAaOxZTbSn0FA1cCQ5L2o23oApiX9Wckn0DQicW9r8E/gcbd04bxZd1ffF/2bXVQ2smBfRduDALrTjZPUVYDd6TGObCpcaxyAEeOUmNwCScO29202SROpKEwXS+pF8WWLSgRZiEY4nL+I8RrIn6/7Fo6vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8Jv7tYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25763C113CD;
	Fri, 12 Apr 2024 12:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712925406;
	bh=G0GWDtrUka0cfT9mQcWpAahixZ8YB0wM3L0wDhlXIfM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T8Jv7tYMh4XmHvYCk3Ef3dBLhf9ol6d6T0ZmoocOLPYNtIlYuya9wazvPzrIv0smN
	 WXXQgLR7gEYghgkHoa14096z1pg5nfxDStr443t5AQas3eJKeG9/x5Jn2t0Fx4F5fD
	 1xRHplyNihOltsAFeAfGvijfNzYovUIAmNsdnbrV5yyZsYD2fFiTejnFtEnDWN83wK
	 07svlSPhrr5Ad/HQAMtXFxtfU2xDmqNJ3lZC2qccaAD2rlLp5BmbCEBYde2jPG7aQ9
	 KrR2u6tN+b3ErRh48UphRCk00FwGII67mBDQdB5H37SJJO5Qp2cXW4E7mAodv/YDgQ
	 Q2DxbhiclIZSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B41C04FF6;
	Fri, 12 Apr 2024 12:36:46 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Date: Fri, 12 Apr 2024 20:36:25 +0800
Subject: [PATCH v10 1/4] input: pm8xxx-vibrator: correct VIB_MAX_LEVELS
 calculation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-pm8xxx-vibrator-new-design-v10-1-0ec0ad133866@quicinc.com>
References: <20240412-pm8xxx-vibrator-new-design-v10-0-0ec0ad133866@quicinc.com>
In-Reply-To: <20240412-pm8xxx-vibrator-new-design-v10-0-0ec0ad133866@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712925404; l=1309;
 i=quic_fenglinw@quicinc.com; s=20240327; h=from:subject:message-id;
 bh=t75pzebWYsBpS9YipaE4zw2bQKsUcZAihoKdmtGp74A=;
 b=YtCTA1CmZN2cm3NtM2xXw4EX1VXMqT/MDV3Qn2DTUJ+AzruJdiuW3rieHUdYCU81qymp2/gIA
 5QWFyJYudKOAsl78E36sVwaZaLJD/Hmv4W3TLR9I9Gc0at5cfVhC+Dr
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for quic_fenglinw@quicinc.com/20240327
 with auth_id=146
X-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Reply-To: quic_fenglinw@quicinc.com

From: Fenglin Wu <quic_fenglinw@quicinc.com>

The output voltage is inclusive hence the max level calculation is
off-by-one-step. Correct it.

Fixes: 11205bb63e5c ("Input: add support for pm8xxx based vibrator driver")
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/input/misc/pm8xxx-vibrator.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 04cb87efd799..844ca7e1f59f 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -14,7 +14,8 @@
 
 #define VIB_MAX_LEVEL_mV	(3100)
 #define VIB_MIN_LEVEL_mV	(1200)
-#define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV)
+#define VIB_PER_STEP_mV		(100)
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



