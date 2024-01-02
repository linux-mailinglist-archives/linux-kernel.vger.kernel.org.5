Return-Path: <linux-kernel+bounces-14834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F50A822306
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04CAF1F2104F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B4F18628;
	Tue,  2 Jan 2024 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OUJsj7U4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261B718041
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7b7fdde8b98so496499039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 13:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704229732; x=1704834532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bEDuGxV/dPJIqZg1w0wl3qVgLyOuLBrt1YTH4lJcK4=;
        b=OUJsj7U4B/Wkgmd/AEzsPthDKbgyGX+3iugDar/5gA7ccoYTJ6wxikYoAtPZTOREmK
         UJ2mnqV+1gAUnr0GnKfLOhhpqJ/7zGJiUupAXFKyjhdkm8b3y1gJCpMPYQiqaPPvfz6H
         patHhOOm4j4GiWVlxD8AODicg2PmeldUrdKfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229732; x=1704834532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bEDuGxV/dPJIqZg1w0wl3qVgLyOuLBrt1YTH4lJcK4=;
        b=qG56ww6gYtnYpyj0sYOoFsyGK0UPHdp0s1MeMToCl3ASB5m8xRY1t6yH1ifeAfte64
         UZmnmEtmRwGJq0VvnKLIX+T4+c0YuXCRA3g3nqcYY41HEs7xKCdFcYqbLzq++k27OkCJ
         /9HEX8fcGNS+OLS2J00gQ1XEey4rAMXXWZ5clRoOuvHUQ0W5P1tWWTaNYmaSo+mcnDJu
         GfdWRzA2Fd8z+hIhqhHYeOSkeX7KxRT6XJHFWWFF90qUjFIKj6UR08XbuUn7/yfVXviU
         5XVW2gul4diDgi/26VDWnb/Oq/rmLrtsT4FD49jsTDmDx+QTJK1pyyEvR5MczU2AahWt
         mesA==
X-Gm-Message-State: AOJu0Yz1e9i+d4PAgECuTkzCeAuwGA3yfJmYx7yVHvVha+nh0wVJZhsd
	b8MsRtDM75q6M8nkanPS2ESm6OuTfvYTnFnTa5x3cUwy/nl3
X-Google-Smtp-Source: AGHT+IEepz+cz572l3C4gGDpkRMfzMAxMxz3DhHQT6lcFpZI37i5Utc7APQrtUv4nIj51c+vjo/kRw==
X-Received: by 2002:a05:6602:147:b0:7bb:cd42:ed8e with SMTP id v7-20020a056602014700b007bbcd42ed8emr301320iot.28.1704229732361;
        Tue, 02 Jan 2024 13:08:52 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bo18-20020a056638439200b0046993034c91sm6956978jab.77.2024.01.02.13.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 13:08:52 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v4 10/24] arm64: dts: mediatek: mt8183: Enable cros-ec-spi as wake source
Date: Tue,  2 Jan 2024 14:07:34 -0700
Message-ID: <20240102140734.v4.10.Iba4a8b7e908989e57f7838a80013a4062be5e614@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240102210820.2604667-1-markhas@chromium.org>
References: <20240102210820.2604667-1-markhas@chromium.org>
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

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

(no changes since v3)

Changes in v3:
-Update commit message to provide details of the motivation behind the
change

Changes in v2:
-Split by arch/soc

 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 5506de83f61d4..08261164ab18d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -924,6 +924,7 @@ cros_ec: cros-ec@0 {
 		interrupts-extended = <&pio 151 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&ec_ap_int_odl>;
+		wakeup-source;
 
 		i2c_tunnel: i2c-tunnel {
 			compatible = "google,cros-ec-i2c-tunnel";
-- 
2.43.0.472.g3155946c3a-goog


