Return-Path: <linux-kernel+bounces-27818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980C682F656
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322B0282C19
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1120200C3;
	Tue, 16 Jan 2024 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeiduyn4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5B02E3F5;
	Tue, 16 Jan 2024 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434274; cv=none; b=KFEX9aCzAlULFwEFu2B/i+8cTFyMDYbXmgBZggGER2v5ARAHYfF92opiW29KOUe7ey+aY5c8+Sk5kV3pWIFWDHqr8LSCE22VtyweMwRfKjMsGkV6MsomnByhtupRBNeBQW7V/oeOrS8leJ6GVCb6+UimWHk6yLMVCSduSI87XqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434274; c=relaxed/simple;
	bh=HInhuxAfFhc5lXJaCJf0TusmapJy+bd2OP1bhgf/c4s=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=elWM0H3AzAL1kpFj7VvJoYXbwQIg7GWi6HI45+Txf8PZ60jNyefllShWTk8AwvI8FF0YomyM8G9/dMOHjLsVumF2bPKNrLuPokck0ojzaTXgOWtBr7+MUdnqzxBc3GTzBn7D/pw0hyxJuT3KtaRJATClcVwmsMqAWbo/hITaZ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeiduyn4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DFDC433B1;
	Tue, 16 Jan 2024 19:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434274;
	bh=HInhuxAfFhc5lXJaCJf0TusmapJy+bd2OP1bhgf/c4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eeiduyn45+/AqB/6YXazaNKv6Om0aaIDNjoJ1W/FQDMHt4jbZ6rtOeG5DvWPGkkby
	 FXzcC8rWPMcRkqtOXEUWDobgH03MGqHUZ85XFdAvcBzdjIFWutXoykfz6rBAADuTnF
	 TZUvC+QTCv40t4q9fgIiOwtVu8LcfzRFK9s3NSy/C+pBv/dgG8Tv1mjQ1QpjlV5FBw
	 +b55zf0wAIOTQMS6ysgp53dkI7NzILClHHySYBCJ72sQ1jd+ZIW2qxmzpVc+12YAui
	 a6vmePXoof37aHUUPKbX11V9wSjkL6v3wr/L3d8HURPOFqr88QM4x2vnMqUWlbHaWB
	 wMSzDw0hlhkjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nia Espera <nespera@igalia.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 047/108] arm64: dts: qcom: sm8350: Fix remoteproc interrupt type
Date: Tue, 16 Jan 2024 14:39:13 -0500
Message-ID: <20240116194225.250921-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Nia Espera <nespera@igalia.com>

[ Upstream commit 54ee322f845c7f25fbf6e43e11147b6cae8eff56 ]

In a similar vein to
https://lore.kernel.org/lkml/20220530080842.37024-3-manivannan.sadhasivam@linaro.org/,
the remote processors on sm8350 fail to initialize with the 'correct'
(i.e., specified in downstream) IRQ type. Change this to EDGE_RISING.

Signed-off-by: Nia Espera <nespera@igalia.com>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231111-nia-sm8350-for-upstream-v4-4-3a638b02eea5@igalia.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index b46236235b7f..23ee2fb5abcc 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2021,7 +2021,7 @@ mpss: remoteproc@4080000 {
 			compatible = "qcom,sm8350-mpss-pas";
 			reg = <0x0 0x04080000 0x0 0x4040>;
 
-			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 1 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 2 IRQ_TYPE_EDGE_RISING>,
@@ -2063,7 +2063,7 @@ slpi: remoteproc@5c00000 {
 			compatible = "qcom,sm8350-slpi-pas";
 			reg = <0 0x05c00000 0 0x4000>;
 
-			interrupts-extended = <&pdc 9 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&pdc 9 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_slpi_in 0 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_slpi_in 1 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_slpi_in 2 IRQ_TYPE_EDGE_RISING>,
@@ -3207,7 +3207,7 @@ adsp: remoteproc@17300000 {
 			compatible = "qcom,sm8350-adsp-pas";
 			reg = <0 0x17300000 0 0x100>;
 
-			interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
@@ -3512,7 +3512,7 @@ cdsp: remoteproc@98900000 {
 			compatible = "qcom,sm8350-cdsp-pas";
 			reg = <0 0x98900000 0 0x1400000>;
 
-			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
-- 
2.43.0


