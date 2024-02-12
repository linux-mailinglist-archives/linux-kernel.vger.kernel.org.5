Return-Path: <linux-kernel+bounces-62090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4478B851B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F376D28C4E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415F13F9EF;
	Mon, 12 Feb 2024 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kw7XseNO"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466DE3E474
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758624; cv=none; b=is2ShUv4CtOuyuLuR5tV8eleC/NFs+mE1jxflgS+9ktmxKajDiITqRTiE6VAfRyw/o9CBPeVIy7elr5PqTukEILWEIlmW38zUwrn66wpnGUz+bNR47zUR++xpN+PB5SZ6kYhTbqDFWb6jJPN/j9Y4S04dBBr/V2uooR234NpR5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758624; c=relaxed/simple;
	bh=sofmcUHFrSsRqgPeeSwX11oZTqFd4uStpGltcl3i2K8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z6JA7aA8Mr1h1Q/P1UIo8QiCuRywgGda9rDh7tCOd4Bk0Z1RLVdiRKcCcWw00yo6KwQxHnYjynvhipWQU1ItREgI1EoHQsTrpKxBMMFrcPWh6lk4yLq2/QeytP0B5tALjajaS+ZpkrMq2UtcgLSPU3zvTbSRRbrKgrxo3fQOAvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kw7XseNO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41102f140b4so5723655e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707758618; x=1708363418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/eslJc6t8FgQCK9mas7bDa4yNb2WxlkjcF3wqq624pU=;
        b=kw7XseNOMt3b6KhLGvox+JJWt5N8u+wumV5QwXi4kiKGtp9sjJTIRx162wmM0WntoY
         JLEWF9t9+GCYmteYjt88C1mdn2Gz7a/piBdZRjYEhUF7xUZ2PEzzCAN+tkQekCE/s3x4
         NhKnZI0wrqJMZtOyb58h8wYHR4okyI4mBLythZtMwIOq7cRhrzwEyr/YzmBNsnqcWrnR
         i9VjhR2FKBF4iOg0hHwHKcKRJrBy6Bi+FlHwpjDFopJsgqU8+yiAW+okevYcxUjeXsNk
         P60yo+xxDfpxxPaqJOi6Vcq5/QCKXcBN1db+VqErHJU+ZbKVnkUs/K06k3+WorXNcvYj
         b1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707758618; x=1708363418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/eslJc6t8FgQCK9mas7bDa4yNb2WxlkjcF3wqq624pU=;
        b=Kbh7a+AlWpEzm8zMxy3B4S9MblPuG7UCXe8yJNQHKBoJmKMnzFuJIxF3mYSytwidnt
         g4DB/cPEbg9xqSxNYm8KsNNsebut1FYhn6SQJdZR1h96203N/O6eOFe5xaE797EirE2l
         yqkYWbKIgj9BD054k0h/THWJgeBnNDeijej+teTjrasfEZ2BOKTZepED4SYR6NQRnIxo
         nYLRRQgvt40+1R0sUCfY2/KTO5+wL/kLVWd0vKSEYveqOqRhCvds/o+AXNeB2h2/tThr
         E5D6V/dj81JzASwhDuC3KzddvEB3zdF9Hyet0zQgE6Dp2QjLEeJNzQdtfK5h5lArA7eE
         lFfg==
X-Forwarded-Encrypted: i=1; AJvYcCWknC2A8UaHDHH5isypdXIvDHvPaHQokHDhXsTiCsaGYCXLuI2MK4qX0qwUV2AlDoc+7rYqQtzk25NeDQ7mf+WKKn3rBJ4FPdlsrRtg
X-Gm-Message-State: AOJu0YyAffUVv6v4J0kb9J3IlcWGPrrPNJzb3R9prKmVu9DXMdwNXmVK
	ldta8w5ZqOFW5zdTnnrqZwUqqA6IpOHYHJ73LXdTj4qBC4sIW42lKLfzlrEV0Wg=
X-Google-Smtp-Source: AGHT+IFVxtbsb2WQ+jwZa008fgojeqgjRlYlMaM2ykmzx1woC1CO/XtBUKH3eNCXodCmTZTCDEnyxA==
X-Received: by 2002:a05:600c:600e:b0:410:be25:12bf with SMTP id az14-20020a05600c600e00b00410be2512bfmr3387465wmb.38.1707758618482;
        Mon, 12 Feb 2024 09:23:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/glzWdQmMgcXw+DGQBL6Oi3Zv6d4XaYB9wXHL5YREvDIvCp2n0m1uLq5wKpIVvDMKD6QUp0lw2J2XJGQs3s2EwQf5cDtTMtIH09WBOHJpKmKxB6UlQO77/ujjSGKmYb4rYKCb5NLMQiVlcrnDXzJUlg3bkhkdqh4rrlicTEnV6TBSTnlZJ3p263yC12hBqvVATFx+/mFkQuKit0HebMD0LyJfzi1o5E4zwIX3p3MOlgOPrWEjNcT6d8DbjTAtPoiZBs2o/lc14t7P
Received: from krzk-bin.. ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id p31-20020a05600c1d9f00b00411a595d56bsm954051wms.14.2024.02.12.09.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:23:38 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/5] arm64: dts: sc8280xp: correct DMIC2 and DMIC3 pin config node names
Date: Mon, 12 Feb 2024 18:23:31 +0100
Message-Id: <20240212172335.124845-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the TLMM pin configuration and muxing node names used for DMIC2
and DMIC3 (dmic01 -> dmic23).  This has no functional impact, but
improves code readability and avoids any confusion when reading the DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index def3976bd5bb..8f2e9bed0679 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -1202,7 +1202,7 @@ &usb_1_role_switch {
 };
 
 &vamacro {
-	pinctrl-0 = <&dmic01_default>, <&dmic02_default>;
+	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";
 
 	vdd-micb-supply = <&vreg_s10b>;
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index febf28356ff8..38351e8ea8b3 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -2978,7 +2978,7 @@ data-pins {
 				};
 			};
 
-			dmic02_default: dmic02-default-state {
+			dmic23_default: dmic23-default-state {
 				clk-pins {
 					pins = "gpio8";
 					function = "dmic2_clk";
@@ -2994,7 +2994,7 @@ data-pins {
 				};
 			};
 
-			dmic02_sleep: dmic02-sleep-state {
+			dmic23_sleep: dmic23-sleep-state {
 				clk-pins {
 					pins = "gpio8";
 					function = "dmic2_clk";
-- 
2.34.1


