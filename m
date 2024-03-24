Return-Path: <linux-kernel+bounces-113063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C12E088812B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D941C21529
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F3C537E3;
	Sun, 24 Mar 2024 22:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkCmBpfz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65D7148300;
	Sun, 24 Mar 2024 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319871; cv=none; b=JZihiHpW6xmybtqOiCzdrJ3UUKmgsKMSq2LrrCEWl3/Tlrq+TFtjZZdmiLQlfkv70oN79dhNYs5pkrfC2gq1vHNMmEN8hSM5oxcRC2/6HsvqXH9pQLDBqwvrXiDAv1WemXUEPyBAwTb4dBmnUEN2FbLq+VfSbLrk+aruMw/9a08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319871; c=relaxed/simple;
	bh=qduKI41qQjAZO3OgB4mRI0vjBVd4E4BI9n6clwtwL78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5OKvBxkORV1Ye6jrHrAkErG6sUsACwQmLQEqXL5X2xGXBCJdy0d6OGz0rnSmCuLh0+vEOjJz2Pq+L0qW0jY+FQ/x5Gm6BqFbF5pNepvK4USbBhHHM5Vzw5N/tBRvQ30qe4IcbqI5KMplRpywvBLr1ucfqQkF2O+vLJ3IBWFCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkCmBpfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A742CC433F1;
	Sun, 24 Mar 2024 22:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319871;
	bh=qduKI41qQjAZO3OgB4mRI0vjBVd4E4BI9n6clwtwL78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qkCmBpfzQuf6HJTieXMPZu5atmZ1magVF1HGJij6Oh6/vEw6Mz2hv+syhRHp3CGth
	 1csu3+jCRzTsbTsBISYKfsQfS5MJvq8cW9tkSYGKC9ctPW+8rHnRiPrLOsPZDh4inV
	 nMICocImhuDmk1GxcwLelR0cUO2KP13LPJkYn5TOHQUzEC7c0gf59ne0GjekWGvWVh
	 BzZ3WeDxJ5Ahr0H5F/KlIJQOuW7fjCmQPrFkh9z7p2ojfsPByqVfxNS/Y3J0zo5szl
	 baL8ubB6VPR31IPsbbA32kKI4bz5Zv0hSG7AwL2iMQkEqaOkZYQoXAKHQtTjwAa3mL
	 soCU3hrOOLH2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Komal Bajaj <quic_kbajaj@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 176/715] arm64: dts: qcom: qcm6490-idp: Correct the voltage setting for vph_pwr
Date: Sun, 24 Mar 2024 18:25:55 -0400
Message-ID: <20240324223455.1342824-177-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Komal Bajaj <quic_kbajaj@quicinc.com>

[ Upstream commit aa56130e88de50773f84de4039c7de81ab783744 ]

Min and max voltages for vph_pwr should be same, otherwise rpmh
will not probe, so correcting the min and max voltages for vph_pwr.

Fixes: 9af6a9f32ad0 ("arm64: dts: qcom: Add base qcm6490 idp board dts")
Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231220110015.25378-2-quic_kbajaj@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 03e97e27d16d4..74f5a43d53db9 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -123,8 +123,8 @@ debug_vm_mem: debug-vm@d0600000 {
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
-		regulator-min-microvolt = <2500000>;
-		regulator-max-microvolt = <4350000>;
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
 	};
 };
 
-- 
2.43.0


