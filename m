Return-Path: <linux-kernel+bounces-11633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ADD81E942
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A704C1F21BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F7F10A0A;
	Tue, 26 Dec 2023 19:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PbeqUeut"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D208F4F8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bb0a93b7c7so5128339f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703618526; x=1704223326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rsZne3Du//Ba4tQVuy5o6whq4EULCeTIrjLPCPwLmw=;
        b=PbeqUeutUGm76q78UEDh2my6snYS1o26/wLzk83OYI0Iq0FYVbRaTFkkWvYmq466A3
         Q3uhC9vIwUyiTIVDAgETxRMaLSUshEhL+1GwSZ5KKGXCGUv+3hFf73iUF20Lqd1wn9ql
         UR9UuiDjOR5fyGCab8ZZ7Y7lq19iJojYsn3E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703618526; x=1704223326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rsZne3Du//Ba4tQVuy5o6whq4EULCeTIrjLPCPwLmw=;
        b=Zaim9JMhELg9aWrWTvJpJk/s048H2AdW0Kj27Ni/wMnTenrSOz4e5sZnSLMZ282bT3
         rdCEN47F+K5WKdjVVoArdwY5zJclIuIpm5FIbI8UgaeKza7YY6VuovtnqAhjP4/6wFH0
         4k9L5pOIImgLnMCNnVYonUXJrD/ZxdhtuYiK4wZxNJIKsproZYNmCiMvEVbSGMkNzvPF
         /9+uZfbY4nJwtCz+vJrYaFxxtpx48gKYcL780ZGukwchLPB5SgnRe1KS1reZRBcCiPFC
         qwX2L0g8hbT8p3kzX/tmE/KGQogOulan4UrXFGubS4RHyZLprq0AsegtmqgCm3L/ri7U
         p6Cw==
X-Gm-Message-State: AOJu0YzVwLn/+rpz4Vcjlz/QTVSetsvMoppzSFmdu3Z4f+oKlfoiAKim
	r2eo/E57b7YesAAshiQPNDPYM8N0Qlm5r19lulbQhaBQgaQ9
X-Google-Smtp-Source: AGHT+IHs1QYIWBfAJ7Y5I9JjqcChVhSW1Ns/FLlrlDgrSy48A7jEaduIJBcEhsZZObOO6KB70LTa+w==
X-Received: by 2002:a5e:8b0c:0:b0:7ba:fcc0:e03e with SMTP id g12-20020a5e8b0c000000b007bafcc0e03emr1029520iok.14.1703618526626;
        Tue, 26 Dec 2023 11:22:06 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id gw3-20020a0566381ee300b0046b692e719esm3207609jab.150.2023.12.26.11.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 11:22:06 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	Alexandre TORGUE <alexandre.torgue@st.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Enric Balletbo i Serra <eballetbo@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Nick Hawkins <nick.hawkins@hpe.com>,
	Rob Herring <robh+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 05/24] ARM: dts: tegra: Enable cros-ec-spi as wake source
Date: Tue, 26 Dec 2023 12:21:09 -0700
Message-ID: <20231226122113.v3.5.Ia598792a1386cca61844068be03c3ccec9e81753@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231226192149.1830592-1-markhas@chromium.org>
References: <20231226192149.1830592-1-markhas@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cros_ec driver currently assumes that cros-ec-spi compatible device
nodes are a wakeup-source even though the wakeup-source property is not
defined.

Some Chromebooks use a separate wake pin, while others overload the
interrupt for wake and IO. With the current assumption, spurious wakes
can occur on systems that use a separate wake pin. It is planned to
update the driver to no longer assume that the EC interrupt pin should
be enabled for wake.

Add the wakeup-source property to all cros-ec-spi compatible device
nodes to signify to the driver that they should still be a valid wakeup
source.

-Commit-changes: 3
-Update commit message to provide details of the motivation behind the
change

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

(no changes since v2)

Changes in v2:
-Split by arch/soc

 arch/arm/boot/dts/nvidia/tegra124-nyan.dtsi   | 1 +
 arch/arm/boot/dts/nvidia/tegra124-venice2.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra124-nyan.dtsi b/arch/arm/boot/dts/nvidia/tegra124-nyan.dtsi
index a2ee371802004..8125c1b3e8d79 100644
--- a/arch/arm/boot/dts/nvidia/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra124-nyan.dtsi
@@ -338,6 +338,7 @@ cros_ec: cros-ec@0 {
 			interrupt-parent = <&gpio>;
 			interrupts = <TEGRA_GPIO(C, 7) IRQ_TYPE_LEVEL_LOW>;
 			reg = <0>;
+			wakeup-source;
 
 			google,cros-ec-spi-msg-delay = <2000>;
 
diff --git a/arch/arm/boot/dts/nvidia/tegra124-venice2.dts b/arch/arm/boot/dts/nvidia/tegra124-venice2.dts
index 3924ee385dee0..df98dc2a67b85 100644
--- a/arch/arm/boot/dts/nvidia/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/nvidia/tegra124-venice2.dts
@@ -857,6 +857,7 @@ cros_ec: cros-ec@0 {
 			interrupt-parent = <&gpio>;
 			interrupts = <TEGRA_GPIO(C, 7) IRQ_TYPE_LEVEL_LOW>;
 			reg = <0>;
+			wakeup-source;
 
 			google,cros-ec-spi-msg-delay = <2000>;
 
-- 
2.43.0.472.g3155946c3a-goog


