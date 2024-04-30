Return-Path: <linux-kernel+bounces-164119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BB18B7943
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9B72816DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6DD1C0DE0;
	Tue, 30 Apr 2024 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="smgkMnUZ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6195E1BF6E2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486495; cv=none; b=emlmh9umkoMCxCHW064yeLLJOtAopzOi+2BRzyMCVfYOqZSRCazH5txuZf8x1qPpMVu+cenk1Em5iVBqjbzLO1mHtalNcU5xX9g2k0kRnSOwXWJkasVCixjLY61L5z4J6tgHhuUeS5ATGZ2+kjBaH3Cd3Nx23tIyjYaYQmkxzI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486495; c=relaxed/simple;
	bh=V93d3WSQViDZ9tXG7HhzJyV15JnJh1dilCD+DNoBZfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XkkTJnhG/sVAvhNhCFMP9vknUUPjKhtmRc83xdp8rlKnqp5potGjXNnK75P/yG9GWhJIRh23DUhPwT+tTGsE8SqtYWAzp6ftE5Hb36QHUh4hmw751J+jyY85yTFJldc+4hwvpU9H8sPcYEJa7GMfEP0lfyefq+Lb45SAbmMdhIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=smgkMnUZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41b9dff6be8so29479465e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714486493; x=1715091293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okmxHGGdUMGilynu2+6miKMjxCF2jE9qtaG3v5cgljw=;
        b=smgkMnUZsGRTahifki2ADIDqCmgLFU1xf0gRvXPJUjUlQAm3HgW4yvMQRdZ6Gtj7IU
         dONwdT8ec+RtAad4JUXCO5mwPe1pZJopgIyyV/ZOZZRtEUQZITQpa9HN9j5rNtORooVA
         eeccx0F5h836sagm3euq6Wpbb1t6qww8vESo+PdvHQCYdTokjHD2JPPVTKRds3+e48pQ
         lynSrzXzNJEwZZ2WY9/2kBUMbacEfhKGq6UxTKmQTmmVlq5a6BGX2PPpJk1U2wp1w3Xe
         OS9qeeHnxUPKx2Ub9YKgcW67Z0vdCKdnBMFx+ssUjNi2cHcMdjzRnZ6biuqreYRikcSd
         NDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714486493; x=1715091293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okmxHGGdUMGilynu2+6miKMjxCF2jE9qtaG3v5cgljw=;
        b=VF3f8K9IrB7RnheyxlntkLQs6rnc3KTAjL/uEhwsospe7k4hw7hzh17wzM1BT6t6v2
         cRvYVYe7x7fut5GUXSBSYsz44BmTUSE0oIBkT098olaSc0kb6id0dnHapNkJu3G9xzKv
         wAL6/SSlbDOAAzuM1XqsgD9tcMLDXTAlhaB/svjh6t6KbuGTol1kaOmHeu5S7poLrxuS
         WdLkRoU7pw2Y71Xa+lbSXuU68udE90ipCwAwV1e9ITAj1XSMNdbOcJnKcVfxSraWuPpY
         YVxWKIs4K22qXuo4RE1kIG1r5gIB1rJOCBUzvKgAn8pmzEkxUPRjpJ4l+RUnaZ8tHtI9
         ONiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrp5u4chW50Zj6pnb9g60RzbYc3Yjhv8C4Ize1LRiUk72qupKKqnJpUrJt08oMJXTUt13IMtAH21+R7O0CdNX8ejVMRJSIk3LwysmE
X-Gm-Message-State: AOJu0Yxeuer/IUEaP5TfvIIHh/ZeMjiUVChfZFRKd096pyLkdXt3NukO
	w2iyL1f7Rm8x0/SbY/A77peJTIaKpKxG1cKA8TII6Y4CDTVDjk8SsRSMEGb9d70=
X-Google-Smtp-Source: AGHT+IFOV6Boiua6vxtgJwU/ckgGydalUeT2SdoUtWSqR0XQEJrQaX1crPbKpSVki5bjWuWmiiGApQ==
X-Received: by 2002:a05:600c:1988:b0:418:f826:58c3 with SMTP id t8-20020a05600c198800b00418f82658c3mr11554553wmq.15.1714486492681;
        Tue, 30 Apr 2024 07:14:52 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:f162:7aca:a805:2c2f])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b0041bf3a716b9sm11593517wmo.34.2024.04.30.07.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:14:52 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v5 1/3] arm64: dts: exynos: gs101: Add the hsi2 sysreg node
Date: Tue, 30 Apr 2024 15:14:43 +0100
Message-ID: <20240430141445.2688499-2-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
In-Reply-To: <20240430141445.2688499-1-peter.griffin@linaro.org>
References: <20240430141445.2688499-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This has some configuration bits such as sharability that
are required by UFS.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index e3b068c1a2c1..9f7635a7928e 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1320,6 +1320,12 @@ cmu_hsi2: clock-controller@14400000 {
 			clock-names = "oscclk", "bus", "pcie", "ufs", "mmc";
 		};
 
+		sysreg_hsi2: syscon@14420000 {
+			compatible = "google,gs101-hsi2-sysreg", "syscon";
+			reg = <0x14420000 0x10000>;
+			clocks = <&cmu_hsi2 CLK_GOUT_HSI2_SYSREG_HSI2_PCLK>;
+		};
+
 		pinctrl_hsi2: pinctrl@14440000 {
 			compatible = "google,gs101-pinctrl";
 			reg = <0x14440000 0x00001000>;
-- 
2.45.0.rc0.197.gbae5840b3b-goog


