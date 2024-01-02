Return-Path: <linux-kernel+bounces-14837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1520082230E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087A21C22AFC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5280F1864A;
	Tue,  2 Jan 2024 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JXIgDXon"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5441818632
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bb5fda069bso168111439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 13:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704229734; x=1704834534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3q5bAzQikGEaFLCjfRt4Z8nKD+aA0c3SnrfHNcWXEY=;
        b=JXIgDXonyYNTm//xOUZbqvGEUrcO/uNkN4iZlt5SKgdAoy2vIhCqJ8k3ilv1Qyju9n
         sqEoOwLdDWLnZ5BHEI3SEUOUyYRBKWtMGCPbadhqosOiYy2D0oupIDf7vv0ygYDSO2F6
         Z92VWWV+mmFZk/gLa7p6FtRIY8D2fo6aJ2Mm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229734; x=1704834534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3q5bAzQikGEaFLCjfRt4Z8nKD+aA0c3SnrfHNcWXEY=;
        b=AwCIba5QWgWYIF8Tga2Krr4zgfP7rJbM3Cx/IkvYT5kobZO1lmnin1WXWVlx1FvhiA
         e8T7zHK04Zs5D1mUDynQv4+MY6n/L6G5iafNH/JgKSolrtCCyYWnP+UpxvdDTeRnVslH
         bvLFIgMQbUphlhFGocgnnu93hnsX4sBBsxCWy3SaMiYV0YDOtD74qvgdXC7Tp8PkI3wV
         37kbSFeW9R6h8hbSB/GaXd/ECsmnoaOJaEzuVPbmDfH4zC694BRRtP2GQOeaZrYPwGah
         mGPL7YY5BZyZrcikUgS7Mw8a/wfN/fSlKvdyET8l1Tpv4Ao4JGK+FSqUYbPuCN74Mudj
         pClA==
X-Gm-Message-State: AOJu0YxtMrdJVMFjdPDUzHDs0GSRJny2jOZrpT+xmM8kLTNYlk9t5Vfe
	Fn7E9jDC8AI+i5p2PVoPHMtccWorIsbaC4kwUdRUZer8oHkK
X-Google-Smtp-Source: AGHT+IFyaB/cl9XINtwxzc8FyOfrkFwShCGVt+Q6OLCTlAP9Elw0gWl88LBFhGGJGmWTzbBD05MnBA==
X-Received: by 2002:a6b:5905:0:b0:7bb:bca0:7670 with SMTP id n5-20020a6b5905000000b007bbbca07670mr1472284iob.23.1704229734077;
        Tue, 02 Jan 2024 13:08:54 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bo18-20020a056638439200b0046993034c91sm6956978jab.77.2024.01.02.13.08.53
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
Subject: [PATCH v4 12/24] arm64: dts: mediatek: mt8195: Enable cros-ec-spi as wake source
Date: Tue,  2 Jan 2024 14:07:36 -0700
Message-ID: <20240102140734.v4.12.Iee33a7f1f991408cef372744199026f936bf54e2@changeid>
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

 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index bbdcd441c049d..2edb270d0bc2f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -1149,6 +1149,7 @@ cros_ec: ec@0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&cros_ec_int>;
 		spi-max-frequency = <3000000>;
+		wakeup-source;
 
 		keyboard-backlight {
 			compatible = "google,cros-kbd-led-backlight";
-- 
2.43.0.472.g3155946c3a-goog


