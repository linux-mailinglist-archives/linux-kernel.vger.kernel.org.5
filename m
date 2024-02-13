Return-Path: <linux-kernel+bounces-62948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62D9852844
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9114DB23BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00CB134D8;
	Tue, 13 Feb 2024 05:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkpX0x8j"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D47E125A9;
	Tue, 13 Feb 2024 05:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707802687; cv=none; b=kEmevoPPAuCZbLRZoIdriXhNwqsJNkHhqGSb/kNIqbj7eYz63mDGOq8n9ais/Gx918RtujCdkbRt1Q3tLGCnGjgmOv1axx0JE3IYxuNLRwotG98n97tIUxQ05l8gJiIVq7JADg32tV4C2xInR9DGL4t/tgqw5iYoQCq0ZHUICLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707802687; c=relaxed/simple;
	bh=fej/8StUAfvf9S3XaAd8q1E4cGLeEHodGXp9vucCL4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Db7lkXSlCewtjkV9SSlhLygq/GqCDPv5Wg2K0Plfap0LXxLMRd9lat+NZErfOkPXXaoRHQ/1vKHfPS2TlKaxnV1tGweIczGuiixenCq20n5aiGBlMShdbf1nKztynZZW3r4glBqVxeqIH87/LPivntRPQqhvb4q9e3cqQZ1shq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkpX0x8j; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3d1151b497so3672166b.1;
        Mon, 12 Feb 2024 21:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707802683; x=1708407483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJdBOYmZsXk7rIacYxoRlSXsJMiBHH2ge7UM4axIZqE=;
        b=QkpX0x8jeWJ/g1B6nGV0JZdS1jfaGfU0AGukCzRLf7VCPuHrQOyFydpU4I4Y3Oyso3
         H4p8UrA8aYSQgS5XPHxFz3I7Z30Q4t4kKkJezyRU8bJ1g3lrnhm3sQAXQc4PFPd7YtDz
         sSeCpyd3eVP/GnC23zNZqrCDxozp+2BC/H7wwXe11yEV8mtj7Pfs1LRBBtGpCROqiOMG
         Jq9gY5/EIp2agjJ5lCbZd0M5eVaAK6Ys+9m7BMYYJZJTQ4vPwpvrwpYdcCvkLM0DqiL0
         twwXYILwwEZ6Ws3BdBku2T1CptRK6xdawYKW+REw1bdR7ViI/onoC67fzolwx5k4JN6j
         8QFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707802683; x=1708407483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJdBOYmZsXk7rIacYxoRlSXsJMiBHH2ge7UM4axIZqE=;
        b=hM2E/he+8Ds5XpjI/B8aWiDGC5QV/isEFhk8TRckaBmQUfO6NNvikuBaTmt84Fw7mn
         8XkVaLfNRDFd0zDE2L8bm9D+1H0ADJZXdX23x89EcVJRAg20NRGCcu3HTxn17U2MOt59
         Tnf3zoLt5DQTZlicUtbqabpY+yVJrJH7Mf4uQgL0uzCcjszOTNuRpc0l7vrntG7JPTol
         wYtQVIhx0B4DAJ0Mx3XoeYaEXbrumtKVd2xGvFJCwrRKpte40pd5HQQB67n9Gj+3K6Gb
         xerT++3TIGQT3HKZSpbKZfjbXfzJV06D+qYpxj15YilhnlYHh4aEz03zCvm+WD+hIDFq
         imCA==
X-Gm-Message-State: AOJu0Yxvunt1YOdVdwene9KOr8dGo8jvG4B8IrE3XcTi5gAsCLy9dOIx
	EWPaTK5uygVmxsleRXEdw8rl1KOobjp86nt1ovfOfiMmejDOIUIU
X-Google-Smtp-Source: AGHT+IHj8PDFm9WvfH0oJ9IoTIMd7KXeKjcwCsvHZaL5xYhNGkGHRD+cGv4D2a1Wq9OVPb7T4nwSbw==
X-Received: by 2002:a17:906:80c:b0:a3b:a32e:93c7 with SMTP id e12-20020a170906080c00b00a3ba32e93c7mr6387043ejd.55.1707802683510;
        Mon, 12 Feb 2024 21:38:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUeBCncLLmXxdM4x+qvGhYPF5dNohZQ7BvWWOgtW+ELCVfJwm2MTUADPrkSQBNMn0vSzoJGhSj7xNxw84HrTmHWN3tA1/096OtfW62HnnrhwmGksJ2Th9jbC9+ZcUF0X6wcZpLSWEs1J8/6DyDsma948zAPP7rea0/+XFYuLDbxDI+tI+ce9WbFP4Ki6AeWmWJNslZsxutvyOHd4axLhDIfFN06Ht18xaTI3aKO4ivnWflaCuIsVAtfnmTusBsF2F+73JCzu+PPUQPIsRLXmONqpfkBl1X003PAX/JjVxRfcMYg8S0PSn6272jurvrZpDQ1yFJVa41eaMcNz5L81yAS1wOWryAv1nR4mkG5c9smVAngEyC8zaoeTQKBz6aBU2qpm1lrOEtYNIrGuqZEkvyrTIBIcG356tUBE63GM+9v9XvTcQfK1Pc1yAaeMZTDCwkdkyB3FJExDpnhHO8WBFbI9XX810EgDsMLeZMxUIrO2UKq43pBcWCGhrcsgbD64SrGsOwy1MwX02KXDiMgVXo=
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a3d125b9c0asm16659ejc.81.2024.02.12.21.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 21:38:03 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Sam Shih <sam.shih@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Daniel Golle <daniel@makrotopia.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/3] arm64: dts: mediatek: mt7986: drop "#reset-cells" from Ethernet controller
Date: Tue, 13 Feb 2024 06:37:38 +0100
Message-Id: <20240213053739.14387-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240213053739.14387-1-zajec5@gmail.com>
References: <20240213053739.14387-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Ethernet block doesn't include or act as a reset controller.
Documentation also doesn't document "#reset-cells" for it.

This fixes:
arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: ethernet@15100000: Unevaluated properties are not allowed ('#reset-cells' was unexpected)
        from schema $id: http://devicetree.org/schemas/net/mediatek,net.yaml#

Fixes: 082ff36bd5c0 ("arm64: dts: mediatek: mt7986: introduce ethernet nodes")
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 228e02954e85..f3a2a89fada4 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -554,7 +554,6 @@ eth: ethernet@15100000 {
 					  <&topckgen CLK_TOP_SGM_325M_SEL>;
 			assigned-clock-parents = <&apmixedsys CLK_APMIXED_NET2PLL>,
 						 <&apmixedsys CLK_APMIXED_SGMPLL>;
-			#reset-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			mediatek,ethsys = <&ethsys>;
-- 
2.35.3


