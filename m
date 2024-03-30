Return-Path: <linux-kernel+bounces-125639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCD08929ED
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73A3282F2A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7013CF9C1;
	Sat, 30 Mar 2024 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KGQA+6rJ"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDC2BE49
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711790002; cv=none; b=cS4wlgxzcLOzlm6lSkzZXWgTH5CtEQmhaW0dISrOjNBdf28z/gYr3+1keo5OScYxVYxe3c8K6N7dgP2YR2IBt0QHq/hPnb2azdF6mHJ+lZEM58tGNDG7cd5Cgw3/S4cwM8p7K05y/kSTe+TpBGm970lVrM/nYWbQdvCvAWOiFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711790002; c=relaxed/simple;
	bh=hfcuUfuH4Utmln3ZF/NDaG/F8P52KEMNKxEh5L8xc4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c7DzbTHsC/1XCPbCbZ4LdcxsOY1/qyYtgfr8auQJYSa07IHBtPE7R42Cr1N2Syn7Uz08276I9AtGaEMosoc4CLW9hUCUTXEM4fofHYhklww9iw6aa04UIP3ZRlhihC79PxKAF6We5mx/VO2c84RAztEQrHsRrTBtu+pBFJ+CH8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KGQA+6rJ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-515c198e835so2908180e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 02:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711789999; x=1712394799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQNM3EOhi4PJ5pFJ3LXwT3lu91N/5dhMq5qmt2uZFSo=;
        b=KGQA+6rJWA6ilhOR0RcthhWO//jqxh05v/SNDXnVmckNHklKu0k0rULQExjuK+wrVl
         tuGIcbxqvAo3tArAUVL4NuouqE3PN4LP0icVzaCQ/OLO21smW/0vO2h+ubnaX4EoLXW+
         e6Fcr3bZTXsEQcM6FFkHf+dRjxnuHchv/V7neIycJMnK31lyrO4wyRe7KKtVtayJTw7y
         t69V2RIa1mT6bLJyael6PaxSez8dJyaX7n5mCt12kvNEKpHrNyvScNx+7ZzjpuAnQXHi
         I13eBtlT6UUN+PPR6jL9afxD4AjTEEtysJRSiPaqUqdgiqym9SywC3A8Unwq4Nw76tsi
         lCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711789999; x=1712394799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQNM3EOhi4PJ5pFJ3LXwT3lu91N/5dhMq5qmt2uZFSo=;
        b=ee/kBfgBgdWHP8u2UlokxJlJfzQxs97cLSHnkUACLxm0QgeX+PQNZwda0Cakhj3x9d
         2I3Ih4xUmJBgEegeAaBG87/+Yazw//E3Uue2ZSg3FttvVMrd4aR5OYhI1kjnra8L69bj
         5/ahN3Pwo6CMxSZYp1y7YIwHjnYmSUCIHP2R5bteoiYhtEW8jjWA1UlmQeOqaElEGypO
         Qm2XnKTD1P82znxsYTjUCqs0/i9xuASoOJDpIrwFICzosb3TszcGUd/kN60ObA4jPDs6
         B4Aw6y8decPdurnYZwnuD8kUceqMgo3rnJwlyZjRjUyKOZtoncjAMXSNSeMWyh682Xop
         2F8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCqTrDi/sDyC6F+8tRLYJa6WBtzbLzwKputNysD1rUnWic4WUICfhvvkpGPaRmuIgHo8cZgnljgOXbYy5cOhbmz+bG0WEzNkpM1msJ
X-Gm-Message-State: AOJu0YzXZUsDZ+lZphG+1fdFdygvrXdrxuiHLy0xs9G2W2P+FbQz0huK
	sAqykDyqD06aR2VQZysBiWmGfMYDqF79g9xuefgIqXDbzESrTCW56Lg0dQYnFQY=
X-Google-Smtp-Source: AGHT+IEjSpbByfHvSiQJRPu7UNykzpnq8VEXolWuCujs+keoQ6eFxgRPNnyenkikyhKNWhJjtoY3og==
X-Received: by 2002:ac2:4dad:0:b0:516:a148:2f5 with SMTP id h13-20020ac24dad000000b00516a14802f5mr181151lfe.40.1711789998936;
        Sat, 30 Mar 2024 02:13:18 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id az15-20020adfe18f000000b0034335f13570sm3984261wrb.116.2024.03.30.02.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 02:13:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] arm64: dts: qcom: pm6150: correct USB VBUS regulator compatible
Date: Sat, 30 Mar 2024 10:13:11 +0100
Message-Id: <20240330091311.6224-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330091311.6224-1-krzysztof.kozlowski@linaro.org>
References: <20240330091311.6224-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first part of the compatible of USB VBUS node misses ending quote,
thus we have one long compatible consisting of two compatible strings
leading to dtbs_check warnings:

  sc7180-idp.dtb: usb-vbus-regulator@1100: compatible:0: 'qcom,pm6150-vbus-reg,\n qcom,pm8150b-vbus-reg' does not match '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._/]+$'
  sc7180-idp.dtb: /soc@0/spmi@c440000/pmic@0/usb-vbus-regulator@1100: failed to match any schema with compatible: ['qcom,pm6150-vbus-reg,\n          qcom,pm8150b-vbus-reg']

Reported-by: Rob Herring <robh@kernel.org>
Fixes: f81c2f01cad6 ("arm64: dts: qcom: pm6150: define USB-C related blocks")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. New patch, pointed out by: Gabor Juhos
---
 arch/arm64/boot/dts/qcom/pm6150.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index b20a639cddf3..6de6ed562d97 100644
--- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -64,8 +64,8 @@ pm6150_resin: resin {
 		};
 
 		pm6150_vbus: usb-vbus-regulator@1100 {
-			compatible = "qcom,pm6150-vbus-reg,
-				      qcom,pm8150b-vbus-reg";
+			compatible = "qcom,pm6150-vbus-reg",
+				     "qcom,pm8150b-vbus-reg";
 			reg = <0x1100>;
 			status = "disabled";
 		};
-- 
2.34.1


