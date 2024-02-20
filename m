Return-Path: <linux-kernel+bounces-73398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C45D85C1FA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982FD1F2426E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC78768F5;
	Tue, 20 Feb 2024 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IlOV3gPe"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C461476419
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448663; cv=none; b=QOWJ4icQDXEfJyAqVyLpEfTPj+WeXKkwsV283fD/1cH3h+xdU6gkJ6Vm64aPjmQJaut3Ay28HKqFPtf2V6ITlE/RRJgeaDmmfSSPRErE5gXumWm7zuk4VSYdwRjfgLnRrObmxc+fE7UO/1gP/8z8dV5m6YhGsO7jSkecZgX19Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448663; c=relaxed/simple;
	bh=53fROjC07Es1bV/FvY+FnQH7fj/iO30rKEmM3IfBlMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=evcPi71zbueif771O09sHWFEJD6nBdTUF2WzvVLL4U2uHzzVvvD6B2FDXG9sXM9I1hG844qonAk9B8Pbg+GZNelGI5I76HK2djRW+YQe0Xpze9+Dq1zFBlcv1SG1ROU5fF+sOD0ash1l1DY0ggN9KUvS6BSkLFToHxvKpxcgmJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IlOV3gPe; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso6201367a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708448660; x=1709053460; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5WvGH+RPjqk3my0TcSeTpwdBfs21Cj9DhcH7xx2upIA=;
        b=IlOV3gPePhJGYRy8+Ko6jIgooJmUUBbnvoQhQ1Nul3C2kyvZ5sHv9lIFQGzRRaCWcS
         nJ3XOQDK/LeLypfNxYskP4Keu/F+Bm8dwsl0rYraa4lqG/oC3NPk5q1KZCtg+vIjYjKS
         gB5tvgXxXZDWjAyS5/nAQURYKev6LXArJ73s09eiuCjyJCgU/MSQDhoakb8H74MxXv6m
         7/O2Yz65IFp+63c+P0Q0vjzKHZsw1O9UT370mwKo70wySLyYtxJbJfC5qNqRUPsBsAUt
         BxkwmfHtBDvZdBoon6C9qvmdhot22EIgYKVxpGzEd/sp6FjupFUb8chWY+7odzCmLqRf
         nFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708448660; x=1709053460;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WvGH+RPjqk3my0TcSeTpwdBfs21Cj9DhcH7xx2upIA=;
        b=BF+5nXhcvkcJAJ9ov7x0Z+Or+4Z/w5a5OOjEyjE4TvOjGjOZXmKsQA9WFo46UuPMq1
         WawrEJ7OEY0JW7+QFTMlBG60fqDMPnFtX1ed0xJv7GWY2ZWBEcnUb2+c73cS633bzyZJ
         GOzRxjj+mziMZ+uVBtF4aPOsNklLMHj95IAMRk8vj9EYiCQUZbj1XgCc5LbicdfXX8ny
         i/EmbEoq5m3B8dDbOKJU6xVZ3rcipnW5vxquZ1cHjODo9ste6HMfG9RLu3miCS5796ii
         mZDeK6ebfNulA54MOMJWPE6FSLWUsRivOtyaz2CfSngkCnJZbh5hqkwoW98X2oHouTqZ
         3pFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJX4vGVOfQn+q3A1/RAsWCR/8Ri2OCX4ttkeIFpOnowbAy34YfEwxkEjn+srIZgOiXWq2qMWSLODrYtFQ9bxe90eDEeCKiUunPl9vm
X-Gm-Message-State: AOJu0YzKA4DJhDBMEBqy244IYU1hbt/ozLpnOmqxzxnNxbSDN7aeEp1f
	8M8c6sWNsdOmShJiFS++rDEKtaN3Tvc1fKZc+EQEckg7ZkIXoLrz6IhIUH5risc=
X-Google-Smtp-Source: AGHT+IHBpj2mpRDQvXqBgHjg8RGnN2fH62Mvf7AxYFr8Pu7d/YBe1tVetlt2TiOkYS1xogseHVul1g==
X-Received: by 2002:a05:6402:507:b0:564:d9d4:c368 with SMTP id m7-20020a056402050700b00564d9d4c368mr1070729edv.6.1708448660104;
        Tue, 20 Feb 2024 09:04:20 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id ee2-20020a056402290200b00564af185ac8sm1114492edb.10.2024.02.20.09.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 09:04:19 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 20 Feb 2024 19:04:07 +0200
Subject: [PATCH] arm64: dts: qcom: sm8[56]50: Fix SPMI channels size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-dts-qcom-sm8550-fix-spmi-chnls-size-v1-1-24e22107a6ac@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIbb1GUC/x2NwQrCQAwFf6Xk7IOYWin+injQNLUBd1s3ImLpv
 7t4HBhmVgorbkGnZqVibw+fc4X9riGdrvlu8KEyCcuBRRjDK/DUOSFS33WM0T+IJTl0yo9A+Nd
 w6+3YSjuaKlMtLcWq9r+cL9v2A9CaMll1AAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1889; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=53fROjC07Es1bV/FvY+FnQH7fj/iO30rKEmM3IfBlMM=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1NuOKd0dpuSH/ix/8aSh9HVF1ZNyuOjykDtsd
 28dEcJjnMaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdTbjgAKCRAbX0TJAJUV
 VjEnD/4i3IptkM3wxA2vd6nGMam/uJi93bm307fhSSdhDmwdPlDkWGP2gRn62SIOcaHbdgfUDU5
 LMYK68rQYLn+MLTxXpsZF9lIoxEZnWBsf9oMmZbgZ7uwn/ahvEKDkijn6VPlY7kLnffVo7DWJE4
 DQcqWkJycmGpZSEy9gPNESIG7vHMwrhCL6kZQ7DWrXa/gXBY6s1H33ijsyJGAxbuosQbd/pp12G
 di9uEqyl46yikyyKmCOHOXH02iyKf1YNeh/r1IU4ZakhPgVYudGqno389P3qbveNvSMHSuygkZL
 9qd3XfU07yj/w5/eNZ0RHcTb419eeHpSltlUb4WiH9KiX5KqObzeRCo3eXDrK7hvqqOnOlc45Wk
 LXY5z1zH9Q4bcTMQ334JyumuwCvp47KOXRoUr4vWWUaFExcDew0xCLwhQy8QKXVkIidAB3w/VKx
 V/9Dl0Qe42jpnBzpfaME9pD9NLginaCJn2jNdU0bj03BbKsTz+rTEuiL28RdDX/zNLF5/BYMpvN
 Bw/1YJftcd4utdV0NZwny/D5fTmUUJpT3YsbqQl/oK5rXTDoJ5x78GlxzvPfQ+eT8VV444G6ySp
 CIBnodeuwUyC/S3P5+p32ZGIOJM2vPSV/VokwsjQ4bhHrRsHJvPNIg1jAgsX+AIAg0UBKf0QLm8
 y+g5hA5g3pqti+Q==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The actual size of the channels registers region is 4MB, according to the
documentation. This issue was not caught until now because the driver was
supposed to allow same regions being mapped multiple times for supporting
multiple buses. Thie driver is using platform_get_resource_byname() and
devm_ioremap() towards that purpose, which intentionally avoids
devm_request_mem_region() altogether.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 7474cddf7ad3..3904348075f6 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3318,7 +3318,7 @@ sram@c3f0000 {
 		spmi_bus: spmi@c400000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0 0x0c400000 0 0x3000>,
-			      <0 0x0c500000 0 0x4000000>,
+			      <0 0x0c500000 0 0x400000>,
 			      <0 0x0c440000 0 0x80000>,
 			      <0 0x0c4c0000 0 0x20000>,
 			      <0 0x0c42d000 0 0x4000>;
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index d488b3b3265e..260eda81b743 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -3747,7 +3747,7 @@ sram@c3f0000 {
 		spmi_bus: spmi@c400000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0 0x0c400000 0 0x3000>,
-			      <0 0x0c500000 0 0x4000000>,
+			      <0 0x0c500000 0 0x400000>,
 			      <0 0x0c440000 0 0x80000>,
 			      <0 0x0c4c0000 0 0x20000>,
 			      <0 0x0c42d000 0 0x4000>;

---
base-commit: 2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e
change-id: 20240220-dts-qcom-sm8550-fix-spmi-chnls-size-b8e6323fecc0

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


