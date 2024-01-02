Return-Path: <linux-kernel+bounces-14835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E4F822309
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F4F2845BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF74418653;
	Tue,  2 Jan 2024 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KkhdR48g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16037182A7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-35fe9a6609eso73631245ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 13:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704229733; x=1704834533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kv/aa+b9yoEdKvBahkqrw433Fqiy1xO+ioSsYaTJvb4=;
        b=KkhdR48gDfOnK0JzFjr9dKqzquQEnAWkct5MJKxXTVUYMsVdlUwo5iSD+vN7NzaVQa
         jetjvii6Fno+XkzfzFS/H1THp689jd0nzmp9/pCLWh616Sa0EGBDt+JmupEyUi/76F/2
         Re4a0iKMXdCcCSwVDy1s5HI2HojH4odrxmZGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229733; x=1704834533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kv/aa+b9yoEdKvBahkqrw433Fqiy1xO+ioSsYaTJvb4=;
        b=QhLoPEaXPldUuxyJGLLzWlJ+HR42T0g4v/4Mi7jRBsBR/1NGTITUPMhuimaeXJVxRf
         ZxrUoF8VkcEd/BGEK2kACmCAkqGgjWg74KhUIMv6kUacDsp4TsFMqv02Kzxdp74EU2Me
         oGJeh8JRP1hLzC2BXveKwveIH1iQffHzGuPLanGbKu2HokWylAs8vnlRD4ogvLeTqbRR
         q74HwTMVe7hCD4Nhsgm5cQm89PN7gm1Kq4PWtWnjKbZaXKtiSnK01LNJkAdSVAXBKQUu
         s6hFqBt8jGFfiIpc7uxHzreBWE/ZMhnT8iHrRIFULN48r+f0juqyRDohemsv1y271Zd7
         xGdw==
X-Gm-Message-State: AOJu0YwcphmTuviG0GuQoCArfTXCdlpW7AqjMknqu2g1EBNcA/YeQZM2
	Bp+bIM/iDaWzKj0vbL61Cy7QONSBlnmjWmGRJwwlFFwoDQLr
X-Google-Smtp-Source: AGHT+IHHN3TbtDEmyfVNFzxMQSipzvaGMekbOIDXc3JT0zP9D5s4Ute8SBzjxYwpVjI4JooHeisxkw==
X-Received: by 2002:a05:6e02:1a88:b0:35f:a4b2:7018 with SMTP id k8-20020a056e021a8800b0035fa4b27018mr27509779ilv.29.1704229733266;
        Tue, 02 Jan 2024 13:08:53 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bo18-20020a056638439200b0046993034c91sm6956978jab.77.2024.01.02.13.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 13:08:53 -0800 (PST)
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
Subject: [PATCH v4 11/24] arm64: dts: mediatek: mt8192: Enable cros-ec-spi as wake source
Date: Tue,  2 Jan 2024 14:07:35 -0700
Message-ID: <20240102140734.v4.11.Ibd330d26a00f5e219a7e448452769124833a9762@changeid>
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

 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index f2281250ac35d..ab44d382f757e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -1332,6 +1332,7 @@ cros_ec: ec@0 {
 		spi-max-frequency = <3000000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&cros_ec_int>;
+		wakeup-source;
 
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.43.0.472.g3155946c3a-goog


