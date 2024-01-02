Return-Path: <linux-kernel+bounces-14833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130B3822305
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E089B22AB8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41022182B5;
	Tue,  2 Jan 2024 21:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PyeXmrBb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5F918023
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bb97d5ee3aso99555739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 13:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704229731; x=1704834531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeATnxPiO37XaEtB4eQZXrEcgW0prfgDBCAc6VotlMc=;
        b=PyeXmrBbvHD0JEpLy/toV24mUPQXkcKEsrP2CPsbMBEuvug9xWLv23V0nsM8kdoo+w
         WiNM0e8Bz8Vhbweqg+l3plE1Jsa2Bm2ria9NHeYlnAevYO58QE8mLuVCm0bs77KA8ZOq
         W+IkdzfVuDsf48UFKrOG1IaC5HM+92ztPIzww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229731; x=1704834531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeATnxPiO37XaEtB4eQZXrEcgW0prfgDBCAc6VotlMc=;
        b=mplvHwXNZuKG2lbWlcpskO3OLAatvlJ216qtmpV4w8labGd6akny+pL2lrjsfCz7gE
         3rl4EWB+IHOM8/mzaCjZjlit2DD1DmuikDpSyp3N688yrYl53F3TjV13W+ZJLnq/C1gs
         AUMg1zLqeWeGLKsjog/vx1IDON+qWRuJEMad82yo1Xsr8mi+wK361tkvS1Ecye/izvgW
         t5ILpJOsgIEjdcLvTyTjzpzIXfm65TIsLKQzj7EHM0n6C6ac3kGKd5peBvapYpA/l3tF
         2lzkQdGOnQpoy6lMk/+a0ACTfVJvn0dQ6PSbpxjvQiD4xGM1YNMjZat7TNgxVHMsqmn3
         3gkQ==
X-Gm-Message-State: AOJu0YznOc5wKeRyZaZbgzxLOVpEqpskrdJqxxprUle/KRmGjvMS2vog
	0EytO5erh50nlAkOa3KEqqLAw945euj4FBoJa3JT4MEZD728
X-Google-Smtp-Source: AGHT+IEq/nXkNhcxVKQTcs7pZQy/wi+fDhhMJ7dsO0o+UvKjnInsDMjSKm1DUuQtSSG5kZZEdWWxwA==
X-Received: by 2002:a6b:f008:0:b0:7b7:4c36:f295 with SMTP id w8-20020a6bf008000000b007b74c36f295mr20729710ioc.40.1704229731497;
        Tue, 02 Jan 2024 13:08:51 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bo18-20020a056638439200b0046993034c91sm6956978jab.77.2024.01.02.13.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 13:08:51 -0800 (PST)
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
Subject: [PATCH v4 09/24] arm64: dts: mediatek: mt8173: Enable cros-ec-spi as wake source
Date: Tue,  2 Jan 2024 14:07:33 -0700
Message-ID: <20240102140734.v4.9.Ic09ebe116c18e83cc1161f4bb073fea8043f03f3@changeid>
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

 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index 8d614ac2c58ed..335aed42dc9e3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -1155,6 +1155,7 @@ cros_ec: ec@0 {
 		spi-max-frequency = <12000000>;
 		interrupts-extended = <&pio 0 IRQ_TYPE_LEVEL_LOW>;
 		google,cros-ec-spi-msg-delay = <500>;
+		wakeup-source;
 
 		i2c_tunnel: i2c-tunnel0 {
 			compatible = "google,cros-ec-i2c-tunnel";
-- 
2.43.0.472.g3155946c3a-goog


