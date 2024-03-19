Return-Path: <linux-kernel+bounces-107407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE21D87FC05
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92692285C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F677F7DE;
	Tue, 19 Mar 2024 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nr/njxoY"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D345A7EEF3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845088; cv=none; b=aCfDEeH63bRi1YxELF9Py7Sg9cPkoXChkMZrT6cwvdTOGt1WASrm2+zIb7Cbh99PwzYVWqe8vf7sotGpvjLenA1Z98p2oBemzXdeZBSxV8xrtXar2qHH8CfjCXIBoefhIGaRPlZBvp76HaRiVxbmdLZiA+WGzLfbnJ9o/u8EW/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845088; c=relaxed/simple;
	bh=7QLKA3QCwIHTu1uCl4Uft63n6NWS0zSd7AfWUoODRBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CehFmqj2p+VSm38dDNND7Fxf33D4hChZfJ0dRgmgLLDv+HdPS5k3zG6h8U3FwMG97FWJfFfXffM0ZbBZzMjcdfr5ABCemWkgiKIvhnTc2G2WM01no4C8mZYAt6ffQfGJwMnJoyMUoRcZXzJOrqbw18APhbIsnpefDggvgwVfgm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nr/njxoY; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5101cd91017so8536413e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710845084; x=1711449884; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8m1FyG5u8GQQEct7h4s3Nz1dXp2hiHWagDMj+Ic2EoY=;
        b=nr/njxoY+tmi9U4/ucBZbi/9dcZQ7fL31pCi69ir5M53rUNKnM4Hu/qyhmyrZbHvg9
         YNdory/A8sITNjRiDfn3RJj8QC/+mqOrvCkmGLJ9BxVk8fMvnuh6LS+48+w4XrUZ+0+m
         Cx+a7Pc6WhL4miz8DFmefyXHlCKmV43SEU+2WvaGuZQKBNnPkYF9sRttRnxJtPIZfyIZ
         gVqZES87lk7oy6aeSzUmixGq4VEUmOHr2ilb/Wa55nFXgzGpkn/orHZ8bVpkW/yzDbHv
         3rBnfqL5/ohCV36qZ0R37aFB7rz1L3818MaDCdAVeip8hhBPbmIovjXXHof6DfTwUkmo
         DKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710845084; x=1711449884;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8m1FyG5u8GQQEct7h4s3Nz1dXp2hiHWagDMj+Ic2EoY=;
        b=eiZ9CZrEaiP5AbnrdXP5ppaHqb74dVAMver7e0P3QU2EpWs5OaT7zDVdH4P836w6kX
         fZ3JieXL34JglS/Rc8R5VhF4+cnre5KCMtAJokhgZ/SRylmkscg/rblYXnfv9wJJCesX
         ezWQLFfN29cLP7Am5bGUKDDkXX0wuIRlk9JBepTL7nGnrrNJizpuaR830VSbJVBZZNTS
         K46Bzw4rcKxgWM9WZGKKIWpxevqQ5nooFAY97AnqCWm8jC6NWVoThqB8S5GND018SGot
         LAP8ov2xxtqPic8O/UB2fgiIasEwFZCyeIyWTdpIdvUnsGDeEMmFlijGpvBK9iDhISml
         sS6w==
X-Forwarded-Encrypted: i=1; AJvYcCVvcuV0GmILcWh3uCiIcptopYswfUWApSc99tLzv+qLXLWPMoILHnqAfT5VcAYDBqhDuyKPCvsyYOdPbgrPBjCFE/y88YFGcKmc6ExJ
X-Gm-Message-State: AOJu0Yy3fXESelGjSRkVC2y9WbmMf4y8g2R808EcPlNmqNlAczweFcHD
	RZP0g3wlp+RhIdJxsDXhQ8yvEys8sFDa+jWQ23wHxG2npKJWYaS161PiVp1D0qM=
X-Google-Smtp-Source: AGHT+IH4qgI06dPYApwodVQ3FTy74M/71xFzY2Rk7TQE3K2QipKLf85i9PNvOV0/4Gk2z5jeC02FQQ==
X-Received: by 2002:a19:4353:0:b0:513:cc91:9ed7 with SMTP id m19-20020a194353000000b00513cc919ed7mr9114318lfj.11.1710845084028;
        Tue, 19 Mar 2024 03:44:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d4d45000000b0033e03a6b1ecsm12029459wru.18.2024.03.19.03.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:44:43 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 Mar 2024 11:44:30 +0100
Subject: [PATCH 4/7] phy: qcom: qmp-pcie: register PHY AUX clock for
 SM8[456]50 4x2 PCIe PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-4-926d7a4ccd80@linaro.org>
References: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org>
In-Reply-To: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=7QLKA3QCwIHTu1uCl4Uft63n6NWS0zSd7AfWUoODRBU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl+WyVAZDzXPG4KQTDQzLaM56V66kA63IMsZinIMaF
 RF3mAvCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZflslQAKCRB33NvayMhJ0YCoD/
 480ztKunFuE+cthxpgF2RoGG+eQevCPiCjSpq6O0B/HkpJWOiFzXAhAg8LU3hUWvPzZA2WPwRQt/tE
 uDH+Jpbi1gFTDqLxDksVgl1r6Lgq5MrXfqOFfXoVhbK4D9Dl32xOzFnfsu1SgUKgyFv+9oUo8jiLJh
 tl8d43+NSrz3WlI5wipy0S7BKgugJ2edl8bM4B7aMZXKwZOuegivHk+UU1LzClaPQfXmz+73szI6Q/
 S9BKQQ2cPupiBymf4mdw7NisbsAPSC19vZ51MYONjXkaVoFVMCMucIFOo5vBd1gGoAX/3+IVrvCnih
 e51bEMEZfcGZi1yZQFsBWs9YY/oktcJTJyXY6GZz+jbmwUWZuhFY8+gsbT46YQKRXaGJBF0EQl/Ttb
 n8Om/JYuYbkT/l7HOszxStDFIGxx2ib0bq4Gz7IDMsXJsJ6ismk1r2xQU5GiLifz9cO7o9/tqJJozz
 iTRALtmM80MY1tyj5hd0rbXgbkt7VV/AK51BjEWkLVcAhwdD5YJVpVpQlmedCMaZ0Qdp/Mf4Aq/N6w
 2RJnfVTjm8dhe8rqKUCBMIHicZPx3XIb8kAAApj69vQz/u/ElHuLi79FS/cF5x9g0a0rabZg70Gbwi
 /e7j8bcwhg7dBHbDwSjSC9kvpefl/9E4vbKmKeNE6xDqUobH8FZ2H1gcZelg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The PCIe Gen4x2 PHY found in the SM8[456]50 SoCs have a second clock,
enable this second clock by setting the proper 20MHz hardware rate in
the Gen4x2 SM8[456]50 aux_clock_rate config fields.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 2d05226ae200..cea5655ddc21 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -3141,6 +3141,9 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
 
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS_4_20,
+
+	/* 20MHz PHY AUX Clock */
+	.aux_clock_rate		= 20000000,
 };
 
 static const struct qmp_phy_cfg sm8550_qmp_gen3x2_pciephy_cfg = {
@@ -3198,6 +3201,9 @@ static const struct qmp_phy_cfg sm8550_qmp_gen4x2_pciephy_cfg = {
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS_4_20,
 	.has_nocsr_reset	= true,
+
+	/* 20MHz PHY AUX Clock */
+	.aux_clock_rate		= 20000000,
 };
 
 static const struct qmp_phy_cfg sm8650_qmp_gen4x2_pciephy_cfg = {
@@ -3228,6 +3234,9 @@ static const struct qmp_phy_cfg sm8650_qmp_gen4x2_pciephy_cfg = {
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS_4_20,
 	.has_nocsr_reset	= true,
+
+	/* 20MHz PHY AUX Clock */
+	.aux_clock_rate		= 20000000,
 };
 
 static const struct qmp_phy_cfg sa8775p_qmp_gen4x2_pciephy_cfg = {

-- 
2.34.1


