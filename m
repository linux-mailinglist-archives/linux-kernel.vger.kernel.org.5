Return-Path: <linux-kernel+bounces-62088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2866D851B47
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F801F253C9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07B83F8D0;
	Mon, 12 Feb 2024 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dfETFR82"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AEF3E485
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758623; cv=none; b=p9HDyhIoao7P5bloLspkFm5ubGaDknxBk1AHpCvlsoyqrFK94QJH+NMY3gyzabiXiNfZa1vAb3x/uh/hdbv8x/K+uGeoMB1a0bh8ONzYMH4VfQ8JPL+4oKzwrTO9x0F0NmSIRPmo72aJsXTVA82Can+fHu7XYOl6AVdQ+gmQsfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758623; c=relaxed/simple;
	bh=aQiO6TViORvksnJ4/cRjQEVEAwjBFbg0IYXg9nX8TfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mzY9dYgqaEhG/DRGdut5/XcKPLzuo4P8pz/QZc7zGPUr+9mnQ80b0X8FINUraQqgfKeuFifA3XBbnceijC4DXr1u5OFSBo8O2/tuvEDMY+hWS9ejQkMmw5h6VM6KBmLd+Ol+7oOY0jluUPu0Dt0ciVl4ABwjprfcDgwDoxlCk2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dfETFR82; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-410c59a3e46so9945065e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707758619; x=1708363419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJY24x6Q2RaGAeMPHndoSEy56nZeIufaRn4dX3Rf0qY=;
        b=dfETFR82DeW40plkjIPtHg7NQjKKq99HrpQuZX+7dqsljYD2VmTuq6y8BsDKJyjg4m
         y9UPNXiubXUGRj9kbsO230K48kRaz8jMyvCcoIVCyC79dBdRWTmbYBBj17CpsHAcBtha
         b94RRRiX+xvGIIzNVwWhmRpidOfvJnNgJMgijQnRz8SKYxURamsSwFwRSgs81RW9A0la
         a2zv4JnrEYlLFcM3dNhnQ9MjtP/QjMP/7ZjM68c8PU7jz31i8aAwzVMxNnhRkYf+4MzJ
         OONkknw4pAVyLMjTP9b/+lBj7ro2+fCiTPgnGDyPFPbezB8m/SgWbWkXaJfBr84TR/s5
         sn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707758619; x=1708363419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJY24x6Q2RaGAeMPHndoSEy56nZeIufaRn4dX3Rf0qY=;
        b=rcNKNRv3uBhjBCxF7KjHopfE3kvpL78ezNP8y/Hs+es1dNWphUAm2U8ykas6L0bIoo
         Mub3+9QSn20y++n0i4w29wM9liVHLpRv5p7+UCh10l4pKQZqe8kSTC9RIwjHPWNo2RGv
         lPyElHbzIIAIDN7TR2iuF4BxqmcG3MK8V0MeWKbr1Q/pBIE/kGcRAANZZ0oC2o7g+jMs
         ffm+2a/4XOdgKFYQvkDjkg+Qsk6fgxyqP5YuL/7FRJLdCDrq6H7zWcSxrtAqd5DR3j3U
         a2g4Vg8Qk7LvzjjxF37WOWf6eoNZbYvL6yWV6AfxBM3fauh7YhIyyf0C1B6PlJRFSDB4
         AeUg==
X-Forwarded-Encrypted: i=1; AJvYcCX7iVeWA1vYexD98C68MaNjodOQQOLYBUgyFLi2tFXEZ2f/rhus99bDOE0DLWm0exFFWWt8aiuGw13Qaeu4Im1ZXBxINhF2NpbhWi1B
X-Gm-Message-State: AOJu0YwQPD7AVVumAG6+o6tRauZeM1Jg7rWDeXo661mf2FL5eSZGo2D3
	qDtrRLx1a+uhVLJs9bO4AVemJRF3BZTApngvU+kvls9XNEl2kkri+rwu0BEfQ8s=
X-Google-Smtp-Source: AGHT+IF0kH8dnKq6o2dwxYdVK8Bo7f2HBF1UZ2uKALLrvIdzoyfRnplQCQ7LeFy3NVr+NHx7gvBnLQ==
X-Received: by 2002:a05:600c:5250:b0:40f:f069:8d13 with SMTP id fc16-20020a05600c525000b0040ff0698d13mr5564675wmb.9.1707758619661;
        Mon, 12 Feb 2024 09:23:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEzzz4ZkuB4CaXGAmqLGUymgYZhZ2PwDx5Sw4t6fjAbFSheZFgXiPfBajFMHR2Z5pnd/13tIdH+5f6tu+uCdg8ywklJ1SfgiICv7TNu0feuEZMefrJ+XA+WCTOjZ3B0mUtZ8i9eIhX4CdHUG8goudy1+7WXazK6sl+sj3uM7oCUCpckzq7YwYZSwdni6AT/sklLb4a3XvK253xdu6w0taNKBiSlAJJDv5vmt+uAAMRr3Z921agpmH9f6XPJdN4aLFtrq6NcjmngV6V
Received: from krzk-bin.. ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id p31-20020a05600c1d9f00b00411a595d56bsm954051wms.14.2024.02.12.09.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:23:39 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/5] arm64: dts: sm8450: correct DMIC2 and DMIC3 pin config node names
Date: Mon, 12 Feb 2024 18:23:32 +0100
Message-Id: <20240212172335.124845-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212172335.124845-1-krzysztof.kozlowski@linaro.org>
References: <20240212172335.124845-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the TLMM pin configuration and muxing node names used for DMIC2
and DMIC3 (dmic01 -> dmic23).  This has no functional impact, but
improves code readability and avoids any confusion when reading the DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 2 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index a20d5d76af35..5a6e0b34934c 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -1147,7 +1147,7 @@ &usb_1_qmpphy_usb_ss_in {
 };
 
 &vamacro {
-	pinctrl-0 = <&dmic01_default>, <&dmic02_default>;
+	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";
 	vdd-micb-supply = <&vreg_s10b_1p8>;
 	qcom,dmic-sample-rate = <600000>;
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 01e4dfc4babd..0a802c9a3c8f 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3934,7 +3934,7 @@ data-pins {
 				};
 			};
 
-			dmic02_default: dmic02-default-state {
+			dmic23_default: dmic23-default-state {
 				clk-pins {
 					pins = "gpio8";
 					function = "dmic2_clk";
-- 
2.34.1


