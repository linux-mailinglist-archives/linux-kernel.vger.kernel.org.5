Return-Path: <linux-kernel+bounces-11641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF47D81E956
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A814281CC6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386A0171C1;
	Tue, 26 Dec 2023 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PKFO3HT0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462EA1427B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-35fd902c6b5so39598655ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703618533; x=1704223333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kerU/WuqEcwbTh86F2qAMXgt8ltGJijA7xaRw4oFoNg=;
        b=PKFO3HT0npEb4BSRVzV0OXAQW/gBQ9NXVu60MjBgwz07ICB5jvLu7sWmWkWZr9cMw2
         x9qnIFhv9e4PI+U9amLbSyosSshLZ7cBXGiR8SzymKt5lXCiH/02cAeotp26IvPJaTnf
         vHSR4yYonNbaR+YkfKmDwQLYO0IagD2ehChe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703618533; x=1704223333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kerU/WuqEcwbTh86F2qAMXgt8ltGJijA7xaRw4oFoNg=;
        b=kIdedhaOtuJDS71KEUK4RoWk8VVh2sbPDG+cWryeDfpk4pv0n5At/S/Qjc+45hmJi/
         rAogJtfX2Let913D05lNGrMPJFN4+4L5PH4ubEYFn9vKqSzaRi9cdTJi1DQzc8I2fLaC
         XguX/fg5n1obTM541j/9oCsKE2gAPyC9/KnJsOPvR0nb5GXj0MU4PXJ8YJfiaADR27oU
         a7R+1EIlhxFNUUx+xXghodRCT/RvywcUHjCqqJAzFGjdTFnrtY+aNPaDeckG7WrxjsEq
         X+cb6BR9b7CNZj24ebO1X9mnvCs8QB22vMHBFx05KW4FWyAAkLJ5iyrUflcca8aRMnNA
         R01Q==
X-Gm-Message-State: AOJu0YwtKrGm7QtcxN2L8LVdZmU2EztfZA51rdNxyABS7cu2cF0x56Hk
	M3zMmM4RT1xaY4yQSA3cWVP3GdPY7FLKXoK5/6TQ/nXYnY3G
X-Google-Smtp-Source: AGHT+IGWPoS9hNB+cORRQA5bdZchS+AQ/9yExQ/zNcqX1Gy8dNr1XcWwi3k5mwg/23JTM3VYG90PnQ==
X-Received: by 2002:a05:6e02:160a:b0:35d:6a77:64c9 with SMTP id t10-20020a056e02160a00b0035d6a7764c9mr14636626ilu.37.1703618533422;
        Tue, 26 Dec 2023 11:22:13 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id gw3-20020a0566381ee300b0046b692e719esm3207609jab.150.2023.12.26.11.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 11:22:13 -0800 (PST)
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
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 13/24] arm64: dts: tegra: Enable cros-ec-spi as wake source
Date: Tue, 26 Dec 2023 12:21:17 -0700
Message-ID: <20231226122113.v3.13.Ic12bf13efe60f9ffaa444126c55a35fbf6c521cc@changeid>
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

 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
index bbc2e9bef08da..14d58859bb55c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
@@ -762,6 +762,7 @@ ec: cros-ec@0 {
 			interrupt-parent = <&gpio>;
 			interrupts = <TEGRA_GPIO(C, 7) IRQ_TYPE_LEVEL_LOW>;
 			reg = <0>;
+			wakeup-source;
 
 			google,cros-ec-spi-msg-delay = <2000>;
 
-- 
2.43.0.472.g3155946c3a-goog


