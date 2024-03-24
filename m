Return-Path: <linux-kernel+bounces-114218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E2C888933
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFF34B219DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDF42519BF;
	Sun, 24 Mar 2024 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWOAXrYJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320612092F7;
	Sun, 24 Mar 2024 23:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321559; cv=none; b=p3Yd+CuuO2se08U21L+FQXSquwkLm4KSDOwrq87Ocrf5S+laHL1Yts5X2N993qehd7RCUHY5piZIK4zSh/HSthkRPW6ShY3oI+U1EEgjkseNgFCZKSRHyVGMAjZ+PlnQZeEt5ErdIFct76fzlqpHcX7sHvHUXm4K/bmx9xw+0q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321559; c=relaxed/simple;
	bh=SABHHO5iWkeJQHPBFzdh88YsNhXLEezPk/RzQRrTY9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cr1egLt1rNlLNuJU1oKpGcKukgNTDv7cQEAqojOnXu7UMOIZftx8lYYfxbpAz4NO9+RFsSXNiOFjjprhxh4rPcMYxmtvRI3yZ7ZyAMHVyXHoZdtn2HSN96rjtRtXKoHjExtp9mvsbj7uBiN1ekI9Iq+7Ot/CFcph9F2e3tVVz3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWOAXrYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A91C43394;
	Sun, 24 Mar 2024 23:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321557;
	bh=SABHHO5iWkeJQHPBFzdh88YsNhXLEezPk/RzQRrTY9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWOAXrYJj3vwbdUqNZMBzyy/4m8KDXPdXTAxeou/I8eCCaxTomAR1vHo5q/Nv0GFC
	 3XLdCqM06loEI4SrxxFDDyQLReDyPVKIGshrz0BjbMMupuz/+oochSMfpwKpz0yc/2
	 hKyRWmoA7BOR083Tmznhi6ozMkGXOtlI7cm80XotKUjf9RQa1pEhNaLGU6XV3MMrn5
	 rPBYhqLhgaBT8ulWpbVYb5xxmAJtblg2lEqnFMGCPf8/IAe+OovTSojXBthnyst1Fm
	 U5HxyPE43WqimHXJMwQ+Tx2iKjjRyaEGy7Zs0srrOvwwDsXF8nWCez0KKDjpoZLX5U
	 Hv/K0hsvFz1BQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 286/638] arm64: dts: qcom: sm8550: Fix SPMI channels size
Date: Sun, 24 Mar 2024 18:55:23 -0400
Message-ID: <20240324230116.1348576-287-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Abel Vesa <abel.vesa@linaro.org>

[ Upstream commit 77dd1e50ffcba33c3195ae4fc78f354368ddacb2 ]

The actual size of the channels registers region is 4MB, according to the
documentation. This issue was not caught until now because the driver was
supposed to allow same regions being mapped multiple times for supporting
multiple buses. Thie driver is using platform_get_resource_byname() and
devm_ioremap() towards that purpose, which intentionally avoids
devm_request_mem_region() altogether.

Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Link: https://lore.kernel.org/r/20240221-dts-qcom-sm8550-fix-spmi-chnls-size-v2-1-72b5efd9dc4f@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 076715ef09d56..90e6cd239f569 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3017,7 +3017,7 @@ sram@c3f0000 {
 		spmi_bus: spmi@c400000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0 0x0c400000 0 0x3000>,
-			      <0 0x0c500000 0 0x4000000>,
+			      <0 0x0c500000 0 0x400000>,
 			      <0 0x0c440000 0 0x80000>,
 			      <0 0x0c4c0000 0 0x20000>,
 			      <0 0x0c42d000 0 0x4000>;
-- 
2.43.0


