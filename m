Return-Path: <linux-kernel+bounces-116834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7678888A3C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16FB01F3DBA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD6815575B;
	Mon, 25 Mar 2024 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mz7qdrOV"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE93136E2A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362570; cv=none; b=IXveDZRm8NLeNiswwowqVnccknUhs31XKCcnc+DXmM42DJNUkBf3i1zdiZHgV9mMWJKDg5fg6Y3OYmKb350bzvbxAY5ZP3DxOivuUgZsRws++PQ/9XxfE7rvSkoAYhyQ+XqjXPVxFRbmOpuLvTPQhdStG/FE9oWAqDg/06bbyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362570; c=relaxed/simple;
	bh=xv2J0Wx0wzB68T5mS5mCvWaPbdcarSVviDqgaUDVsLM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=haYX5dl1qHxuK7tIohoA92THx6AemCAzSpdz7V0QaCmzPWlzDG1pFwP6f674Fb0ifSYf43+w4WBe9l1fbW+7ivSVKtzhRmYyCZj+WmbccnogTpSR+EYZhX2RcO5Cyo4tIpGXmg90nvBfGR7L0d90ttLTsbZ/flcfTre0AW/yKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mz7qdrOV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56c1364ff79so847338a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711362567; x=1711967367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6TcKE6+dC1f3eAz4BNo+BlfsIlcWLTS4Ihl0QMKVXN0=;
        b=Mz7qdrOVxHvbWYB3BfHXlrx32rBM7fhcs4qe6VM6MUW5XrZ0SDim9oKXxlo80zlii2
         2/ZzBkHSCidX37YLhwriLttTFuIASqT6qlQUv0kurlyN0b1q/jLdHlq5zuIXeEh3ho1m
         DUFTvj8JT1Rv1clM2HIvjp/DHCf4xYiu/uDYxFmRreCbqmYSaGxKx7xSxdmKKR47oYpy
         LiMBbEPjTLAh5j2ehTu8ix1p+GEAb/Krtn5KTY7Oy9tH+Kr1ZAjtGLM9yjRqH/qPAHsN
         cFv5W/7eBI0rFy5YtrdQeaWePHgKV+DbvpKevg1ijhg2QoEBjD2dq1khukwlEgyj+YhR
         sswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711362567; x=1711967367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TcKE6+dC1f3eAz4BNo+BlfsIlcWLTS4Ihl0QMKVXN0=;
        b=TwJrHPi4goG/EZYuXEfnoeC9G9aRBnqkmQ8FvsMbLadjrHMoSRVEZkGZVfP98WMKV7
         h3ccTcJzE6SY0HqX+tyg3MqsSGW7vfQxoDMZv1XlwG+4ALYOcKHmxjf3PffZyg+sr4UH
         SSafAyFVzjjdtJ5DfTqyHM8v/Pj3bVvaJwkKggYV+nCC5+jh1fBFoOW6kEBunmwGMz/x
         /ekdFAcHWvxoJidizJkcSZxNrXRWk1pYsSF1l53bPo/Tw1/ibut/6ZjJoN9yh9bwNGMp
         QY0CrakvytPI6MoBzmxmAJFLvoXbjbHEO97JlDuEuwSwYv4e3ylxcA0SMP8W3yRc+q/1
         IFnw==
X-Forwarded-Encrypted: i=1; AJvYcCWtpLMIgodmtNySJNP2tViPRed9HqnTKduUu1urODjBWXA8sVkjIoOldexLYyp2R1G43Z3phXmMHDsq5aqZ/lVwVWkLZWLRxOhPfg94
X-Gm-Message-State: AOJu0YxdJ13GhLC5mhTc7Vd7yowKqqM4/d4y27bVRzwZJNv5m/Yx4ccp
	YlNgBU3RKwPCBFUeY1TTdE87OwKYR4bGY12vCiA7JSu8Qutywo6qPo3AJWeKxDk=
X-Google-Smtp-Source: AGHT+IHJwcp/nYlKZf4FVuIV3akoOxI9ayiT4CShSuqZh++R2kE6qmOBDp0F94QP8O6lMQt04Hy1NA==
X-Received: by 2002:a17:906:a15a:b0:a47:3c9b:bd84 with SMTP id bu26-20020a170906a15a00b00a473c9bbd84mr4684802ejb.8.1711362566889;
        Mon, 25 Mar 2024 03:29:26 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id kv20-20020a17090778d400b00a46cc48ab07sm2902617ejc.221.2024.03.25.03.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:29:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sdx75: add unit address to soc node
Date: Mon, 25 Mar 2024 11:29:24 +0100
Message-Id: <20240325102924.26820-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Soc node has ranges, thus it must have an unit address. This fixes W=1
dtc warning:

  sdx75.dtsi:399.11-736.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdx75.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index 7dbdf8ca6de6..f58da999a72d 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -411,7 +411,7 @@ smem: qcom,smem {
 		hwlocks = <&tcsr_mutex 3>;
 	};
 
-	soc: soc {
+	soc: soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.34.1


