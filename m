Return-Path: <linux-kernel+bounces-134721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7971589B5FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C181F212E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10498460;
	Mon,  8 Apr 2024 02:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiQQN8UI"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E005244
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 02:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712543650; cv=none; b=Iet4rPXS1l+CDy+PCXepd40DyG7kSopHQWcG9JWswNdz7ulOFaNLRGLn3X5WdggTKsQjCldVyAihrmV3P/WJqWTVzhGnUwwKpEC2hhy7qlljw4Uu0c8wU98LB58eByCOSLzj5fI5N6gAoyEPNl8ANYGQNi+88Dp7SMKXRHcj5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712543650; c=relaxed/simple;
	bh=HK+pQGlyEMASzaLMUZhoZ4LQ1b2xuwD3oB+E8BsoQRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QSPemDHM8cCth/YxBqdtsi3U2kzFFRLBCgDJEfO3V00BQFh0VZEMvIRxlqI4pOTgp54AS9ztKKEgQE5U+bBq/1oJHO5/y2kmoO7ETxISZOErAaqfUTtg4pcGrX/E6aju4ecuGejIovjPrDEKjHeZszJH5LmVOC3gVBkrnPBdiJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MiQQN8UI; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516f2e0edb7so961212e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 19:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712543646; x=1713148446; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBs+x784L93t5mpvshVcosruv/wnrHW9FZoVJjVQz+U=;
        b=MiQQN8UIx7E2c2bvpfnGqBKPQS27SLdozmHcwDm4mQkg4FFaBXIMLNo7877amfXATW
         nUuevsUmu3xMCwAWiBLBwdTxtLiv+7w+gz8mVm13orVnMh1TihkUrAEcjWT1yOfbItKV
         if/ui3yBBc0OnReTEv4c46ifCcjxkesNU/YdI8IYRjpBr/EFzyhFTN0godZYw9D3h2HJ
         XJXFK3SjcH2eA2ZLDwbI/JyTuTamMHKOJgD6ixiBtOlLPOgOiq0qdzS4+8Jsx2uwMytH
         THaJMUJRvQG91oD00w0pKVWnXn3zRPj9Kg5Qr+XtOOTfMrqddVnEjuARMr5M8vdirvwU
         2VYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712543646; x=1713148446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBs+x784L93t5mpvshVcosruv/wnrHW9FZoVJjVQz+U=;
        b=s3gQJqydIEKOqNdiOIVvY3lpS2vodbSWePRWsAHijvSLp6XlgP6LMmnVeMWm6M0O6B
         CdJAcuoidvjlBTWjpPr/PMt4DL5UyTZlV1KCRHu2vpF6pXVS0n47prcpvN/yCCdUJ22d
         uBtEj/IOKZQGp7i3vOcZ8EYkkgrhXbvhIbRQ2s5k0tU0PihHX5fnhW2WRY3Uj1dYlS1z
         2h65fceEpgw384P7J9YMcdiSgzw9NatRiVKjvOjctUSxMdcJNnUcshlVMT4dK9asyZzk
         gRq0NpUVqWsZHt0lQTU21imZsx710wdDvgdvlvQiilLbpkqMsYjX0pOlCMXpA/2mIh26
         eR0A==
X-Forwarded-Encrypted: i=1; AJvYcCWtwvkQrEh2mtWGPRvdqHFx/0DnH7MakfB05cvSlHVW3lrX23RTIyuU60VYFhWFpYtrZ62inPrULI08OPc8Mg4AV3VzUzvhTBKP8S52
X-Gm-Message-State: AOJu0YyACBRJeCmDypH/GlTdDzrDNUuuIP0j9V7cJrRvt8mpuKqRz7b2
	s8vdc46cZxneG8hSEoLmo3wAGM56KiM6QV8zDIvSWdS4Qk1oxxNlei8Tw3ouUvM=
X-Google-Smtp-Source: AGHT+IF273No/DR0tZe/NTluGkCrXKX17/405defJ+ZsgcEbWZqOdPptI4fSBPwN6qMNQeds2rFJbQ==
X-Received: by 2002:ac2:5592:0:b0:516:c5b0:c5ce with SMTP id v18-20020ac25592000000b00516c5b0c5cemr4538598lfg.45.1712543646645;
        Sun, 07 Apr 2024 19:34:06 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id h5-20020a0565123c8500b00516d58590e1sm943673lfv.250.2024.04.07.19.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 19:34:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 08 Apr 2024 05:34:01 +0300
Subject: [PATCH 3/4] arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: add
 USB-C orientation GPIOs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-hdk-orientation-gpios-v1-3-8064ba43e52a@linaro.org>
References: <20240408-hdk-orientation-gpios-v1-0-8064ba43e52a@linaro.org>
In-Reply-To: <20240408-hdk-orientation-gpios-v1-0-8064ba43e52a@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=870;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=HK+pQGlyEMASzaLMUZhoZ4LQ1b2xuwD3oB+E8BsoQRA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmE1ebUhDBlydO8D1zI2fM/6uEO0Q5rw7D5nTG1
 wnQFoifBwuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZhNXmwAKCRCLPIo+Aiko
 1esUB/wN6zESnknR6RsbV/tQreEyqFoWmKdTs3tw8WrO+TFp0birsh5c9JqftXJXlfnPPQ/6c57
 8w6qwFMFXNvSLV2RDY0TGO/EQF/NrMNIvRi7C8Sdm4u9G5qdoachIXeeo33s4JD1inuQlmzYg3G
 LcYr8WQVxsGvF1uqVxEsqXpZ7kvVT5Gfa7VdZhXUM2u6J+xAhbrx7Mv4VpbRteNRTB9d30ToBBF
 0lmQoGuXBPjE10NCkQQK57Xli0tAleXjinYikb+oAr1YxBBF8itg+qAu59ft5tGOqtOB4HKs40C
 +bsA8+ouwTERTZqHRjbuFxLzS4ABnX9PBvBNfsY9iIPDau6B
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Define the USB-C orientation GPIOs so that the USB-C ports orientation
is known without having to resort to the altmode notifications.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 15ae94c1602d..2806aa8ec497 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -100,6 +100,8 @@ pmic-glink {
 
 		#address-cells = <1>;
 		#size-cells = <0>;
+		orientation-gpios = <&tlmm 166 GPIO_ACTIVE_HIGH>,
+				    <&tlmm 49 GPIO_ACTIVE_HIGH>;
 
 		connector@0 {
 			compatible = "usb-c-connector";

-- 
2.39.2


