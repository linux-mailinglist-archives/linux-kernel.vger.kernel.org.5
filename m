Return-Path: <linux-kernel+bounces-105574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B700087E09B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E40A1F2117D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAE32557A;
	Sun, 17 Mar 2024 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSYzbwQD"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B8D22F11;
	Sun, 17 Mar 2024 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710713504; cv=none; b=m8bMuM6SqPKaXZkqxNArYar7gZ/NcYv9GMed04LqvyFbqDQPcciveeroz8K9UiEUYz9W2ThYaxebQnykPWzC+dp8hzAACvl0SIutotbVRG2bd4QzMxW5CXkDxZV91XTONmQ3SKruJykz7Hatx4potGBNTop7UnVdovBKGXyRug0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710713504; c=relaxed/simple;
	bh=rA96/nspktoNNPtsNQNV0mE1u3PyrWtLRI4fge9NXZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvYsNCK5PUn5L59ZWA2I0jbE+DHWirzlppEOuyU0WKnTtiCM23VKLvdwxgWI/I1pq6Ao+I+57w5h0ZMSOzT7W2o66d+qJEhlrW9sZ6TA2Kl3f9iaHVce6O5fORuzYF7qu93ryOHYVjsR3kElw/BGHbhhrn5t013NvIDhHGdDqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSYzbwQD; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512b3b04995so3359380e87.3;
        Sun, 17 Mar 2024 15:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710713501; x=1711318301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqwAYXgZcepvHlePhp28/MtjgzY7DKHyuuJEXxpcBH4=;
        b=hSYzbwQDr8rVgLGpEjjnYeBoc0Y7d7GeE9Lq3YnMGCIVT1k2/1wT8PtZcWNHTRN8wu
         cscgAppcPmpRn/xpQfi8LenYE41VQ0WPvL9QDz69CFuQqHAUndPtd9n5GadVKopSQTjK
         nVgEVISI8S5XdCcWe2Lpk954pU6HOV+Qi4wfjolRuhrsAztEFuI2AxBYwufwVKL7M/e4
         Wox3uVP3gcniJlmFE9oVZSOmuvVKXc1mIw7mpAEofn8a+GSmlh4Lx1t3Bz9EDH55aADV
         TUVJUc6w4uopvl7zFPRJtfCPGROF2CfD8tM1TR2SmnYevXEk9iuyztRbMa+0/RZslR6a
         IOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710713501; x=1711318301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqwAYXgZcepvHlePhp28/MtjgzY7DKHyuuJEXxpcBH4=;
        b=lV+we30zx0zsywhnLLiKcUEvQWy8V2Nu5oPi6roP2ypD4TJ7piE75yUokONu+rVhrY
         2oS8EmCZeoElVaaUVO9Cl3Z7Zfm4rZ6dCRBT1cjPNKPpcASY6URw8D7y+P2SNaEXG2BA
         8AL0PJfUUL61y9E1nfdQUJS2gkz6TyGnwJ9mcEpkCyGozCwy2mB8uRfd6IoF8/OYmKi2
         LdqqVu8+p5bTRys5gcfhI9BvcAOnlgyKF5404wLTKEnnS320+uAIRASPkZmXIIVZADqo
         am3shVCNaAa+kn6yDfwYThssR5EiiUp4oerk8cWHZ3IqZbiVHCw4HHAoNEWjy9bG/1UN
         kGsA==
X-Forwarded-Encrypted: i=1; AJvYcCXXS16MYuKB95KlgGwGi/CFfTPiJRFxr7yjqEct7gb0HiSMhnibD8NdDgA23H2jt7zruVUrbtxZalFxqJni7mi51U1ogpCWaJHNP8nlocQcJlhCyRxfxVgeLny7lqXgKXiYbbS/6JGBOA==
X-Gm-Message-State: AOJu0Yw/JViQTb5lpTAZ+34TZv8jxHJlEM32e2W+DBTknwdbWd3nWIu0
	98dYH5Fx7IDRErNZRKz71YbMI5HjheVl/Pa7xlURjk+CxP3vZ/t8
X-Google-Smtp-Source: AGHT+IHPS5hTFALXlpvYUPk63ag5W1eoin3JPAlIpLno70ePcqta80cRb8eG7XXorItWH+2r4mheVQ==
X-Received: by 2002:a05:6512:3134:b0:513:ca36:83a6 with SMTP id p20-20020a056512313400b00513ca3683a6mr6323979lfd.23.1710713500673;
        Sun, 17 Mar 2024 15:11:40 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id y16-20020a197510000000b00513d8e5a088sm973049lfe.140.2024.03.17.15.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 15:11:40 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	"David S . Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 4/4] arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block
Date: Sun, 17 Mar 2024 23:10:50 +0100
Message-Id: <20240317221050.18595-5-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240317221050.18595-1-zajec5@gmail.com>
References: <20240317221050.18595-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Binding doesn't specify "reset-names" property and Linux driver also
doesn't use it.

Fix following validation error:
arch/arm64/boot/dts/mediatek/mt7622-rfb1.dtb: thermal@1100b000: Unevaluated properties are not allowed ('reset-names' was unexpected)
        from schema $id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#

Fixes: ae457b7679c4 ("arm64: dts: mt7622: add SoC and peripheral related device nodes")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 8e46480b5364..917fa39a74f8 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -513,7 +513,6 @@ thermal: thermal@1100b000 {
 			 <&pericfg CLK_PERI_AUXADC_PD>;
 		clock-names = "therm", "auxadc";
 		resets = <&pericfg MT7622_PERI_THERM_SW_RST>;
-		reset-names = "therm";
 		mediatek,auxadc = <&auxadc>;
 		mediatek,apmixedsys = <&apmixedsys>;
 		nvmem-cells = <&thermal_calibration>;
-- 
2.35.3


