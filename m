Return-Path: <linux-kernel+bounces-51261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F179B84886D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3013D1C221DC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4CB60EDE;
	Sat,  3 Feb 2024 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="qkXcRaT3"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E75860247
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706987553; cv=none; b=hS2mIzTKRGAhb2N/0JnWNC14TEOjtRWqp110BKfnvx5UfIQB/r3ecp82YWRQFGmPAttc817EUTjWtTYZP40W7PNdBvyB9jEK+0a6M16U6G7DiFhyigIH8mCS5LEdshnWZNGNuOLwMkuJqvlCQfO1zz8OfLCuQUv05wpRir/1Zkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706987553; c=relaxed/simple;
	bh=TdNOj56gRwLjQaHS89k0AnOJ05DtbA6b9MJxjIDYlIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddj6RKVJzhhGL/15qNGdv4R/EULpjHgax1Vo8wKmyzkYxS5Ji64wtm5ekvtBoSidlwAhq2f3QgMvUE4dOv2Xey5iDC8PoUNZd4ikDz5UuqBum80ehhq10Pdo99o8pT57dihJCxPSuTebEssPZJuy5Umh2kruhiAsRQJO/AUyc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=qkXcRaT3; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1706987549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IWrCDsFafWqQwP/SgCzI7FzJHbtr/YwtyR/hwDdPlkY=;
	b=qkXcRaT3gXjv7MJuG6M0Ta3E04bYGrYAV8QVhfA3YMLMk6BSeQH77LBgcizpvwsAZTgKUg
	+UIT/nJGoxaOIY873ozy5oYQ9JLIm4eLmwenCI3uI9R0wiX0QnqIHHnLk2aL4eBLEndqQl
	m+8sILMc+FSrJAloR7kVU2ahca2/oH/910RsR8OLEQ7uBqet1M0eiitlduUd+pFehWpqaf
	Iw9/Op7kO1H2SXOWvARiRu6aNSwzgRvNZ1WQq5YRM676I2R/Qsfpftlc1E+oTou+MS3EyT
	huzoCGBibmFYDA3Ox+U87miZ9ALdNu+GRMBNg/4RXXxMS4z5+0/vX0j74LiMCQ==
From: Anton Bambura <jenneron@postmarketos.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] arm64: dts: qcom: sc8180x-lenovo-flex-5g: Allow UFS regulators load/mode setting
Date: Sat,  3 Feb 2024 21:12:00 +0200
Message-ID: <20240203191200.99185-7-jenneron@postmarketos.org>
In-Reply-To: <20240203191200.99185-1-jenneron@postmarketos.org>
References: <20240203191200.99185-1-jenneron@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The UFS driver expects to be able to set load (and by extension, mode)
on the supplied regulators. Add the necessary properties to make that
possible.

Based on https://lore.kernel.org/r/20231214-topic-sc8180_fixes-v1-6-421904863006@linaro.org

Signed-off-by: Anton Bambura <jenneron@postmarketos.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
index 0bfc655e9a31..a41958f9ef2b 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
@@ -335,12 +335,18 @@ vreg_l7e_1p8: ldo7 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
 		};
 
 		vreg_l10e_2p9: ldo10 {
 			regulator-min-microvolt = <2904000>;
 			regulator-max-microvolt = <2904000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
 		};
 
 		vreg_l12e_1p8: ldo12 {
-- 
2.42.0


