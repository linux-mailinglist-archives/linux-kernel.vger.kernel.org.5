Return-Path: <linux-kernel+bounces-11642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F8E81E95A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35791C21675
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28474171CB;
	Tue, 26 Dec 2023 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lwH5ozb3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36001156C1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bade847536so84621239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703618534; x=1704223334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJeII5b51gSKYdx0OFHNNgnpr2euSDHg7QynlWWpDkw=;
        b=lwH5ozb3yLiy84322iyB6vejF0bjEUAPClt0LjlK6D6YdaOZrGoKWVHUMzvDHKr9kl
         SEhhJjGRTK+9DBvFoc7Isvpqi9dBtkN7aNTJzJteuu9H5/tSKRCAXheBHY6zwcNDbKRB
         FurQCAX0Nfbhc8OpEPUMpj4s9W/ATfdVSeNjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703618534; x=1704223334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJeII5b51gSKYdx0OFHNNgnpr2euSDHg7QynlWWpDkw=;
        b=wG0WE2fiFI1uEFQOUUvUYaw4VL2GmieOAjU4/qY3KlZh1BRjnerKqJW63beSLx8csz
         0MsL/UO85zkHRJi8bwaHyXH3JIfiVnEnJjTHX8tK31lA7DaYJRpYe8rUcSSffgXEs7lc
         4rm3eqBCE74j5Mdhp93WWM4QLi8GCdsiTNTPZ0cKq/KgLS7SPnnfn/CzRyTFR0pek303
         kV2oEotXHkmQVBvVzU2hfrB9I3nHwRcEbV+Vtrw/bGqn/KJ99vnFk0OafSqCNt0eIyYQ
         avA3d1ygY3wQy1meHYljwO0RQSmqQrn7S6w2RuW/R0E0N0F+7nTuBR5rk6DMSJPDVRxH
         NuOA==
X-Gm-Message-State: AOJu0Yy+VSw2zm1yJQVJzrQJwybYphfEnoai0D/87vsDXcKwumFf4pAH
	xBNzOuZ919w1QWyZStQtsWN+Xhn1sqcDoQBOk1Hav7TC9FJG
X-Google-Smtp-Source: AGHT+IFW+l6vYtJ1wQeOu4xfaiQEthQFJVyQR2YUwsgACernOoQnKZ0+YPBF19sE1clzCmB/C9/JQw==
X-Received: by 2002:a5d:974b:0:b0:7b7:4b32:7986 with SMTP id c11-20020a5d974b000000b007b74b327986mr10235601ioo.27.1703618534234;
        Tue, 26 Dec 2023 11:22:14 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id gw3-20020a0566381ee300b0046b692e719esm3207609jab.150.2023.12.26.11.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 11:22:14 -0800 (PST)
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
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 14/24] arm64: dts: qcom: sc7180: Enable cros-ec-spi as wake source
Date: Tue, 26 Dec 2023 12:21:18 -0700
Message-ID: <20231226122113.v3.14.I2ee94aede9e25932f656c2bdb832be3199fa1291@changeid>
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

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 46aaeba286047..f3a6da8b28901 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -649,6 +649,7 @@ cros_ec: ec@0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&ap_ec_int_l>;
 		spi-max-frequency = <3000000>;
+		wakeup-source;
 
 		cros_ec_pwm: pwm {
 			compatible = "google,cros-ec-pwm";
-- 
2.43.0.472.g3155946c3a-goog


