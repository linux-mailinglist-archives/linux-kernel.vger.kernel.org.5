Return-Path: <linux-kernel+bounces-57895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB6C84DEBF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B461C24C69
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E596F07B;
	Thu,  8 Feb 2024 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m6N97i8q"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7AB6EB40
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389497; cv=none; b=oWQS6GBvRPFz3nQig+igARvFDVtgGf4OVGPR3C8x55VE1i1xAvmpKH2Z6JKkWW+QHSRpXnW1xlsOg32uS3bPdGInFFSuCNOfwxN7Z5EI5QarxL02e4pbFo+S6b1tCJoqRfSysLU/Bn7j11kmT+hQovhxxW9KLkaWKDsIYsbzBIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389497; c=relaxed/simple;
	bh=9ZGZAniVojBPAzZnK7VRxQ6KyiPK4LjtRgqlXHoCmlk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BiYoP2eo8821Bqey6Yy3LS33AvL6tsOzan6bsAltv9AqOY3K4HIKYroPmQkBvVODZI4RfLDK3rmf6+xf59YEhb+YJLCBfIdW7bLz17VzX6riQLxjgGyY4tHhGoDEaahfHkLQWQXzLbI2KFQtXoyhwbENiKfrVgYWBK4mGB9AFY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m6N97i8q; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33b535c5d0fso722648f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 02:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707389493; x=1707994293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QRtcBLpg2UJfwrDcTIbV2QdDaYWh1k1w6J6l7NGdAhQ=;
        b=m6N97i8qyDpPjlH11HegArK+bnHhGDB/ASRyaxDCAbf/AgdJ9zgoJc4nOIbKs2JKn4
         ZHwyOkw0YquGrrq9vEvtz6I+qkt91lY0pWZFnxuVROaFsc8gQV0NPfz0Zaxd35Ghlb/N
         1vDr8QnHKCjoe07gZYY2+rPrX7Ug+b3Sm7WEjKKi2cvgkX8yQCvgynB67seBQqNf49Kk
         kTx6UsCg1X7QWx11dk98HpN+iaG1/Vd1QEMU4BcKCgrWsRMIvF5XuNfpVCO06CZf3qbP
         nj7YDXYo7Ew57qxYujAICos4AanpC6H/2aA8snLOVj45XBC1uVmy3KwU0NywYQ1ELqk9
         vtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389493; x=1707994293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRtcBLpg2UJfwrDcTIbV2QdDaYWh1k1w6J6l7NGdAhQ=;
        b=svyGOdddK11FubpfvJs+s6rTLG8ETvOaYVVKY4YT8szs0JVx8r0GFaKiO8yrnqJioa
         tIjAGIGErsq452WAgWmVLSsDgWSaxibr1rYt1dEHB3mgEXw7Iz1VgqDX+JABsbMhCski
         cs/+cRQrQfJ7NcUsOfBS37Ef6TEjNWPtu0Vh01wnD6FAqw9CERfAFvc88gPdNO9QEIHI
         c2rqVvxSjWJKiwiW5LZfWsGVJfbeoYM7BCYO5g/ePNPIj7uLKHw3mqCvweT2YSvJdn7n
         L8KhA4a/TVjnZND2IRBMSfy5XjqSLJotwR724bqFkBWTwxWfCEHJzjHWRDyHjW3y16/m
         91+Q==
X-Gm-Message-State: AOJu0YzfrNWBwvvGfeqbOuVeBaT24Wux6XuyS6JzoibvgvGDV4eF2r0L
	0U/gVLw3DO9jgRKg5UJox34Hs8C2nt+ynVct2dirUynCl/CbTtVUzkKRbtDxBe8=
X-Google-Smtp-Source: AGHT+IEtk56T9/G7HFmIhKoOQe4FP+rsV9tK+gzIAjo/IBHXLpz2jJSe8DMq+PkYA15lBnbprZ9bDg==
X-Received: by 2002:adf:ce92:0:b0:33b:136b:557a with SMTP id r18-20020adfce92000000b0033b136b557amr5602663wrn.70.1707389493618;
        Thu, 08 Feb 2024 02:51:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBOKH+RkujrQ0JyPkA08iduNE7ajI11rqzMjvPGYZTYJnh6LqlrbAvDIDMtq2qKT5YWuD912t05UCIqoDs2E5U4G1+VHA9kCq1m90hpODt/9T64d3t7W6iWmxCcoK4UwqeWuuFgyDmqxZQ/lmGAbrI7G6sHnToD+woifi3wYSXgpvbirjOzFPB213qWVBifJaOy0XuT8VpZ0B149UpZ98T3Dbdbbk+sHKwR6bCus2sF4VChK4GeOwdT23f99diptXQM6VFpL8YF421xy33OVQzfSUjNhuqBlg=
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d484a000000b0033b43d7394bsm3340824wrs.55.2024.02.08.02.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:51:33 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: rk3588: minor whitespace cleanup
Date: Thu,  8 Feb 2024 11:51:29 +0100
Message-Id: <20240208105129.128561-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space before '{'
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
index 3d0ea9e34049..ad8e36a339dc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
@@ -212,19 +212,19 @@ &cpu_l3 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
 };
 
-&cpu_b0{
+&cpu_b0 {
 	cpu-supply = <&vdd_cpu_big0_s0>;
 };
 
-&cpu_b1{
+&cpu_b1 {
 	cpu-supply = <&vdd_cpu_big0_s0>;
 };
 
-&cpu_b2{
+&cpu_b2 {
 	cpu-supply = <&vdd_cpu_big1_s0>;
 };
 
-&cpu_b3{
+&cpu_b3 {
 	cpu-supply = <&vdd_cpu_big1_s0>;
 };
 
-- 
2.34.1


