Return-Path: <linux-kernel+bounces-11638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6CC81E94F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BE77B21ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A412E13AEA;
	Tue, 26 Dec 2023 19:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FcVKVBsB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5512B6B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7baa8097064so145754639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703618530; x=1704223330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7Ja8Mbk0Dn0paAcqtccJazS/+ZwMfvgkX5xOL8nKJI=;
        b=FcVKVBsBIzjgccnZnc3m9lv2bIKNpYvewrs/E69Du2Mn8jDtSWs5y7MHDy7NHjXOeb
         WGu6Jsm1uHbU1jwDHz6RzKPXq4EdtnKBYt8AJQLXzVrc5PmqMQbAITfwY0q1/2X6qO5D
         6clq1Db/55aeiKwQAvlEzmpmNKuFzcSV3V0Tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703618530; x=1704223330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7Ja8Mbk0Dn0paAcqtccJazS/+ZwMfvgkX5xOL8nKJI=;
        b=s+fzfL1w5gWgAwdw1wLo86Lhq7nkZGg+Zx2UcvY3Eq6/smbzmPTEsqmkUD91fmAkjF
         pyd7gNRO0yE2d5ftV2ytDBsKLSAEDrMDtfHI/aA3oicoJcv132t8ygFud+vcwFYkni8p
         OlzY9nnFTpV8rLhj7oox04FbEQZBqqD+IFBO4/0N4FTCtfOa2Tg9UDhMZY2MD15NUMPI
         g7pCal6nuIRe/cRPE5a1YGB32PPs6rrHJfn+0r9PJI+r1kV4ruwj4rOEnVxeKsnrGJ3g
         NsSA52Kmn2YgWnuU6yZ5f6SyDwMGu4a0PO+NN0RY0l9CaEfSS+1gJsj5l6p+ihpRhRwn
         LePA==
X-Gm-Message-State: AOJu0YzIcMwwEuhiM8zwx+fR81eqcmQndfmBjdrGfsUhmDUYixlR8916
	l/cco/qYI1FKAUmxmgD2HKMDpnkxjxuBJGNlUc1bFxzKjYgh
X-Google-Smtp-Source: AGHT+IG8helE4u9r3GeIgnMcwM3YERloc3FZd47BOCTyom2igtFIusFh5HNKk7KvOaUbVJAxoSn/Dw==
X-Received: by 2002:a05:6602:3e8b:b0:7ba:a650:13d1 with SMTP id el11-20020a0566023e8b00b007baa65013d1mr9133258iob.10.1703618530770;
        Tue, 26 Dec 2023 11:22:10 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id gw3-20020a0566381ee300b0046b692e719esm3207609jab.150.2023.12.26.11.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 11:22:10 -0800 (PST)
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
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 10/24] arm64: dts: mediatek: mt8183: Enable cros-ec-spi as wake source
Date: Tue, 26 Dec 2023 12:21:14 -0700
Message-ID: <20231226122113.v3.10.Iba4a8b7e908989e57f7838a80013a4062be5e614@changeid>
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


