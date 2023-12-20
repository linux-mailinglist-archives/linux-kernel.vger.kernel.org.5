Return-Path: <linux-kernel+bounces-7659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7270781AB5B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F26628520F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4D54C626;
	Wed, 20 Dec 2023 23:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N1G5a8Pl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD984CDF5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7b7d55d7717so8989839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703116515; x=1703721315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yCVu6I1r+NRnz/AsvfCkzFQXXECY+E6K5qe+5haxTA=;
        b=N1G5a8Pl6WrTyomiUFQijWqyUJclivXFLDPuqXUm1qGjwe+tpjlB3yKLug1SDEc481
         ADx1NDpa75czkVpX3jeLVK/8eqImK6UPIDc2k/8AsjZFtpaB8iT2SZsy6wBWt2rFpCSU
         bciLHt3/DKcpYfASHnvExdxyJRjgqbRah13cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703116515; x=1703721315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yCVu6I1r+NRnz/AsvfCkzFQXXECY+E6K5qe+5haxTA=;
        b=sFSQwkXnIYbmyCZwVX1MDUBNHEvyVJDih978z36DlJtTFAA8Mh7czjR3RNyUpzCjkX
         Qscgti2/Dsd2m9Z+8WVBoy+lUz/bK64YRIrDQvDOLYfpg71brSUWtdvE/valuAwOtWBq
         I3dIitHGQkM/fVeepJMmjZ422qCpr/tgfZw3ScgwZrDBRTp3KnjNfVG3bTnNFoe0QfGu
         Y4rbJjrzeEFnJibmoF9nFqsSciY6F7H8oT/M92PPRpTL27cMozBal5EkQNFL+zHR+Oea
         Nta1OaMdVYaXGmNIdBAZh86GE86SC//JgD8neCdIC6cc+VF4iIAhMP8j0b+cEa9G3BEd
         aYRw==
X-Gm-Message-State: AOJu0YxcYpfN9CTHBTHdrUBXJosAWadvaKrNghwshpMuCBW66egF+wjv
	tapITlzJR/R/a+Ped6uYKSBeCnJQSaforQXuihU=
X-Google-Smtp-Source: AGHT+IGQS9ViCfOP9DV0BcBpVda4PiMnNXFrq7RZGrtBIBlYRUtl6txSB+SASJAG9M8UOIfTNMd85Q==
X-Received: by 2002:a5e:de46:0:b0:7ba:8b76:6f65 with SMTP id e6-20020a5ede46000000b007ba8b766f65mr67557ioq.9.1703116515275;
        Wed, 20 Dec 2023 15:55:15 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bp22-20020a056638441600b0046b39a6f404sm177805jab.17.2023.12.20.15.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:55:14 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Raul Rangel <rrangel@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mark Hasemeyer <markhas@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 08/22] arm64: dts: mediatek: mt8173: Enable cros-ec-spi as wake source
Date: Wed, 20 Dec 2023 16:54:22 -0700
Message-ID: <20231220165423.v2.8.Ic09ebe116c18e83cc1161f4bb073fea8043f03f3@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231220235459.2965548-1-markhas@chromium.org>
References: <20231220235459.2965548-1-markhas@chromium.org>
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

Add the wakeup-source property to all cros-ec-spi compatible device
nodes to match expected behavior.

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

Changes in v2:
-Split by arch/soc

 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index 111495622cacd..190a3ffd81471 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -1163,6 +1163,7 @@ cros_ec: ec@0 {
 		interrupt-parent = <&pio>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		google,cros-ec-spi-msg-delay = <500>;
+		wakeup-source;
 
 		i2c_tunnel: i2c-tunnel0 {
 			compatible = "google,cros-ec-i2c-tunnel";
-- 
2.43.0.472.g3155946c3a-goog


