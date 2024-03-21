Return-Path: <linux-kernel+bounces-109963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D28D885849
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0973F284791
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DA55A4E9;
	Thu, 21 Mar 2024 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LVtazPpS"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2CF58AA3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020321; cv=none; b=nDm0FPuhzBmr7v32RvVsP3HbfV+kR5Smln2PutWW6Ms/kjPWA/YHe+4po7XG89HoCB3gJaIi1H6/v/q7g0C+UvoW6uPgqC7NCuQOVjFHO5HpWsHc2g8W2NjhIbyN5Sr7P6khzU2qaaMnJorXQIoF10bJdiZ9hkuk7o68HvMvDmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020321; c=relaxed/simple;
	bh=KNeD+vKdGb0VsxLi94lHL3FMc2wc0erCYkHOY9W++kM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYWZ2OKkxW5da/mDpAMCFUcbFtCP49kGiMRg8GVzOVKtmh/QsMA7IZTRdTr7eTEpoMLFZ5/7ISCN8WxABV1FQYe3N1cMahh3x4T4SbJIh5tPvqPIcnyHlh21KhjbbinRQddsAvS934SOkyazRtbljra/OYMNl2DCJSi80GZ62Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LVtazPpS; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-789d0c90cadso56672985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711020319; x=1711625119; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdGCislf8Z9IpFRDf38hi8y6611+4ZWnhEYMybrgvL4=;
        b=LVtazPpSaXV35ontfA2c6y+Z4qJ6XYdPJofI3YpglHZsq1K2z3Qe7O7l7ZAHIZdbe4
         fWZMbVVSsT41499HiG+OFUja8ww+g0eoZXU9qwOZPriuoHC0JekXnvYIAJbCvzDBTUun
         Myn5vtlTz1N/f9oHjoHzPfl0vLY9pAZXTQ/osDOC0YH0kVngqNOTBGzqd6/jdMjXyzBo
         Ei7Ly56FbI6qHoTDUJqYNL/B2ehb75wKjAGlaldwT6j/A5PDh9ydPqqt1rYdfDbjA6nB
         LXRTat8t8gYYOgf6ptDgEj5x5RreG4YvGVoT4z/8WPq2vy4yDxTG9RHjL2oXBIqXXDjU
         QkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711020319; x=1711625119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdGCislf8Z9IpFRDf38hi8y6611+4ZWnhEYMybrgvL4=;
        b=lHzaMTwBGfOCjMw3yZxsZRllZKNSTWcHX7ljfvhPwCui4j2R5kr4/c3C5Ro7UjpoTJ
         NJe1gFrmDXo6kQV9sI6RWYDwYZKM1wsuakkqug1IxjBPYOsU6oo6JDAeOhEHzCjD1B+k
         nQSCdmdDlz405wxhhsK2xRSrVp5pNgtBM2fADV0kUiW1eIHQ+AwklAwWIS4Ed5dJTWcS
         dwZnv6H3z1XK5GBszSehOUyPzjqlbulK6nXMhA42F6ORb5cKn8EtrMZlhkfQGwv3wZSE
         Vx0HS2qqNB02qQifo6dsLM3m26MGPhNGEhds3lPAW5ia5YkexenMdvWNt1ifikzSZTGo
         LMIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzCUCtt/zpsUCNzBt68K2jfNdzr1GxDOlQlem7poLpKgmA50cPf5+7v+XKdOnlExTsCphX4d67bg/cAI4xei2RfxU5M+K50fVNUSQZ
X-Gm-Message-State: AOJu0YztzlA1IY8YGcYYfshvTx1xVwmvFQIaPbthfZ7sOvqyqrBsz0BG
	9ipSgl13tsqSEGbeyKG7CosJ+E0k7WpHR7BLpUHZDzMUPe2tk6kRVHEQCmRKjp+wkCz6b6fa6JY
	=
X-Google-Smtp-Source: AGHT+IF9qzDmCq6Cfjt+O35esUzJjLmKrVk8XAC3uDwrfhYsw0kCjKLisExS/p4pkJ+5NW88EKIt5g==
X-Received: by 2002:a05:6a21:788b:b0:1a3:560c:15d8 with SMTP id bf11-20020a056a21788b00b001a3560c15d8mr10026041pzc.41.1711019885906;
        Thu, 21 Mar 2024 04:18:05 -0700 (PDT)
Received: from [127.0.1.1] ([2409:40f4:102b:a64b:d832:a82a:837c:6d3])
        by smtp.gmail.com with ESMTPSA id ka6-20020a056a00938600b006e7324d32bbsm5531120pfb.122.2024.03.21.04.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:18:05 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 21 Mar 2024 16:46:41 +0530
Subject: [PATCH v2 21/21] arm64: dts: qcom: sm8650: Use "pcie" as the node
 name instead of "pci"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-pcie-qcom-bridge-dts-v2-21-1eb790c53e43@linaro.org>
References: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
In-Reply-To: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=KNeD+vKdGb0VsxLi94lHL3FMc2wc0erCYkHOY9W++kM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl/BcOt5g9OhdxNj7ZCCVnTArwicbr9rHOF6gMC
 qIo2lm7M7GJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfwXDgAKCRBVnxHm/pHO
 9QmaB/0RLvPezplRmiQXA/s6eUVGa8xi/W+sbYaUbH4LZ7tzCSqnYcEF+3BQkLm7Y7NJkX5FHMX
 Va7jaGmDNdL9uVRyxOijf2BKPkQj3OpsKHK2G0NfnhGJd3xTUVw5xb2WYB9oHOtPua6RfcOP/1q
 bu3eywAhZH791vfGn7P78IoY23GhoJAO2GjVUGYiBMi/wK9VQehp+ydNZqYaUfLYXWJFvwNPV3c
 jCEzgpKyz8j41K8ymON5E2zX3YQKF6Co8cvd31rP2/R3LnLtalj/xVJvBOOS1JkfOGpughduZ8a
 0blJ63nQSuQ4/5+jQQ+EH3kLp+GUlJjdK8kQ96ORUh3gMPti
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Qcom SoCs doesn't support legacy PCI, but only PCIe. So use the correct
node name for the controller instances.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 06d2b6432ab1..b25fefd6a786 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2208,7 +2208,7 @@ rng: rng@10c3000 {
 			reg = <0 0x010c3000 0 0x1000>;
 		};
 
-		pcie0: pci@1c00000 {
+		pcie0: pcie@1c00000 {
 			device_type = "pci";
 			compatible = "qcom,pcie-sm8650", "qcom,pcie-sm8550";
 			reg = <0 0x01c00000 0 0x3000>,
@@ -2337,7 +2337,7 @@ pcie0_phy: phy@1c06000 {
 			status = "disabled";
 		};
 
-		pcie1: pci@1c08000 {
+		pcie1: pcie@1c08000 {
 			device_type = "pci";
 			compatible = "qcom,pcie-sm8650", "qcom,pcie-sm8550";
 			reg = <0 0x01c08000 0 0x3000>,

-- 
2.25.1


