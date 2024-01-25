Return-Path: <linux-kernel+bounces-38973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F57483C93A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46951C22335
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB70214078D;
	Thu, 25 Jan 2024 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vOf1aFCA"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92EC141985
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201709; cv=none; b=lSrr/mpJsNchrBjv1PrYi9nzVBEWQe7/jYgQwIYwACl9iPKbTeCCP7JWHwovDMLYxrYCKUCNsDTipsQ6k4l1aPkDTEhZu/m+MabygBpLYInmPPDSzgAggVi+OSAqWIn3XRNF9KIvKIoAwWZ+pe8gOsQ6v+ZVojExO2/XCQKiENg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201709; c=relaxed/simple;
	bh=Rw+Oj/BjNcnqfn7QvDWzv7ZoteAVYbGdEhGHUSoxplQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ecFzClszLR5XHzPQED10q66ukHkdsiGWUDGz0EYcN7fv90Rhu8czPo5iCb2TeqlKHCYAEyCNoZjWphLWixFHI3hqtsfcEwv+zPxqjwmEySXLXU7EmXIOhsdaeKy+cadQIOxiTOokIjghtQwvkuYEEGxXaFuRfPYWjdXdoOZshN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vOf1aFCA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40ed4690ee4so3305545e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706201706; x=1706806506; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yB4jfE0/XJsodASjO1q01zoyOa02tPYQ2u4yeHlxV2k=;
        b=vOf1aFCAGVFyR9bUCGRhcsSv9TWFF6y1INiJR7odljiQVtUoZ8+nr/UQvyj+0z6iqo
         9mpBaOiTzZUEwdW8awz478UNCwQaAypiSk92MoSrak10skQGvJBdfu2HRvjE1yzSqbmQ
         bdDcyoqGf13wIJd8l7R59QrSMPmE1oF4kgWH+w++g2okxNzCOv9VFDEfqMzPfwPDrqUV
         t8LNjgsQY4KzBnG+Qk49bJ9AE4on1Y3gBMz22eLDiCjgx7MrdakUYs9LwtsOvROV0zLn
         +LpWhpbD2xu06502tpGBsdYq21Fyt3bsgVfVxD06fIVSgvB3UxSI9WxMXIsK0LwvDRXU
         5swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706201706; x=1706806506;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yB4jfE0/XJsodASjO1q01zoyOa02tPYQ2u4yeHlxV2k=;
        b=o7CscoaHcl+9UHsijNoQwtqysTv7FuiRmPJ8s6xXCIznXCiN4CXF2cl2WRJ7HqovnE
         wH3denUkm6v06Tr9j89LcG7W67gnxwcLgpyvN2FS5lkjBxZ6FpqZadvx61XaJlBpGRiW
         Duo6xae6xrehgMgn10QLKGj0Cja66VVyxOL4s6zLFm6GPTSqYIXQggsc5IBBuLX5qu+S
         jisG22lsUWBwcn+Dv5mc3ZcFxS4KXs9iIjOtPxeKmMmQFjOs8MMBmO7lpu42OcheUQzf
         Vqnai0SyJ4eNQgpcjYal2aujbqymwVKdrfpnvtjFL9HoyqFROQD+c44bXu5oBuO5yqDV
         6pKw==
X-Gm-Message-State: AOJu0Yx1t/eMt12BOuMqdY/RS6O5TYIGhahCTqO71xSxDSAY7YAZof9L
	BHfR2ocXXoW+cGuqKPPuBlhYee8u0ASItpEGTnl7BOeO63l2N5ptPu0L+6x05WQ=
X-Google-Smtp-Source: AGHT+IHleA7Y4H0hQ5T4pCCE6WJ098hqFPCRZ9zv/Lp/YDzqnFQIDqHIGMPuwk9ZPkjXATQtn6dqeQ==
X-Received: by 2002:a05:600c:4ecd:b0:40e:622e:7449 with SMTP id g13-20020a05600c4ecd00b0040e622e7449mr23392wmq.22.1706201705917;
        Thu, 25 Jan 2024 08:55:05 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id bs8-20020a056000070800b0033959354b59sm1940271wrb.13.2024.01.25.08.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 08:55:05 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 25 Jan 2024 17:55:04 +0100
Subject: [PATCH] arm64: dts: qcom: sm8650: Use GIC-ITS for PCIe0 and PCIe1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-topic-sm8650-upstream-pcie-its-v1-1-cb506deeb43e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGeSsmUC/x2NQQqDMBAAvyJ7diFJTaN+RXoIcbV7SAzZWAri3
 xt6HBhmLhAqTAJzd0GhDwsfqYHuOwhvn3ZCXhuDUWZQ2lisR+aAEsenVXhmqYV8xBy4mVVwGqw
 zwW3auwe0SC608fc/WF73/QNTQahTcAAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3857;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Rw+Oj/BjNcnqfn7QvDWzv7ZoteAVYbGdEhGHUSoxplQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlspJoGGRyEvcAaOXkVwtzoVk7+NYQoHE5INxRMVDO
 VjxpyiiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZbKSaAAKCRB33NvayMhJ0VcQD/
 43v9OgaZf/HPPogg7KXWahD0LDbAHVRbH++55dePgGF/NJkvVdtTbebcV3LlLUEvf04VFAcaD+NPhH
 uycaYzUqc161NRy2KavibircNqQF9fKrX3ay4z/l1db1MJxK2WgPZjzhAptZG/AbA87sQVf2mfAsnz
 UHMMhrM9dom8uQHTUk7mAbjfYeJeVgfadCB9/4hKXrF5RTgfebhm8JbI1RSsNrWmOy+qQxPGwNv6VB
 p3ORPIT4g5LVGtPq1cTg7fhLFidF+fr/D9GZTNip2oZDO8CtUEjcfC5SV+Zf2PQ21lJNrUR7j2wTNl
 2k712xezO0lkO2aLG7Q2dNRbQ46Q8zaRvV0q5T6JkO6ijm7JYMp+yO/9VHjXaQSr2e0vJPLFuvEl+b
 vDUWDxsrFvuf1ihfW5avhzqLBiAH6i81Bh0D0KtXLzN4/Ge12j/44HAAG12fBwt0mMCtXEWYjgWEGH
 61lkForwMQVDyYvmEyZEuF/vQ+hAed08l4sCG21Ml5OJwIqXhUPOtnxWOUDDrLVMKBH2AHbVO5YARN
 5UjMOFht24QoxsIXnbkqPFe5yc1S8Xamh0sbVyA16a6UHCXfncZ/bJNuFil90FkqFoIcqKtn/t7lIv
 yU4IIgnK84R8rEZ7yEot9Fifwl0QUFrRUoIJ2UjHyTpUH0ADPvOFlZyt7ulw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Both PCIe0 and PCIe1 controllers are capable of signalling the MSIs
received from endpoint devices to the CPU using GIC-ITS MSI controller.
Add support for it.

The GIC-ITS MSI implementation provides an advantage over internal MSI
implementation using Locality-specific Peripheral Interrupts (LPI) that
would allow MSIs to be targeted for each CPU core.

Like SM8450 & SM8550, the IDs are swapped, but works fine on PCIe0 and PCIe1.

WiFi PCIe Device on SM8650-QRD using GIC-ITS:
159:          0          0          0          0          0          0          0          0   ITS-MSI   0 Edge      PCIe PME, aerdrv
167:          0          4          0          0          0          0          0          0   ITS-MSI 524288 Edge      bhi
168:          0          0          4          0          0          0          0          0   ITS-MSI 524289 Edge      mhi
169:          0          0          0         34          0          0          0          0   ITS-MSI 524290 Edge      mhi
170:          0          0          0          0          3          0          0          0   ITS-MSI 524291 Edge      ce0
171:          0          0          0          0          0          2          0          0   ITS-MSI 524292 Edge      ce1
172:          0          0          0          0          0          0        806          0   ITS-MSI 524293 Edge      ce2
173:          0          0          0          0          0          0          0         76   ITS-MSI 524294 Edge      ce3
174:          0          0          0          0          0          0          0          0   ITS-MSI 524295 Edge      ce5
175:          0         13          0          0          0          0          0          0   ITS-MSI 524296 Edge      DP_EXT_IRQ
176:          0          0          0          0          0          0          0          0   ITS-MSI 524297 Edge      DP_EXT_IRQ
177:          0          0          0       5493          0          0          0          0   ITS-MSI 524298 Edge      DP_EXT_IRQ
178:          0          0          0          0         82          0          0          0   ITS-MSI 524299 Edge      DP_EXT_IRQ
179:          0          0          0          0          0       7204          0          0   ITS-MSI 524300 Edge      DP_EXT_IRQ
180:          0          0          0          0          0          0        672          0   ITS-MSI 524301 Edge      DP_EXT_IRQ
181:          0          0          0          0          0          0          0         30   ITS-MSI 524302 Edge      DP_EXT_IRQ

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 2df77123a8c7..7b3dfcb9a57b 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2255,6 +2255,10 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			interrupt-map-mask = <0 0 0 0x7>;
 			#interrupt-cells = <1>;
 
+			/* Entries are reversed due to the unusual ITS DeviceID encoding */
+			msi-map = <0x0 &gic_its 0x1401 0x1>,
+				  <0x100 &gic_its 0x1400 0x1>;
+
 			linux,pci-domain = <0>;
 			num-lanes = <2>;
 			bus-range = <0 0xff>;
@@ -2364,6 +2368,10 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			interrupt-map-mask = <0 0 0 0x7>;
 			#interrupt-cells = <1>;
 
+			/* Entries are reversed due to the unusual ITS DeviceID encoding */
+			msi-map = <0x0 &gic_its 0x1481 0x1>,
+				  <0x100 &gic_its 0x1480 0x1>;
+
 			linux,pci-domain = <1>;
 			num-lanes = <2>;
 			bus-range = <0 0xff>;

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240125-topic-sm8650-upstream-pcie-its-94572c7f1a73

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


