Return-Path: <linux-kernel+bounces-70367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A038596A6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 12:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046EF282550
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 11:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D0B6167E;
	Sun, 18 Feb 2024 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WgUNPNSj"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E11860DE1;
	Sun, 18 Feb 2024 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708255216; cv=none; b=i17GGRrb+lq5b3ipe6oiCDJV2F/qadUaor2KKhGfy8y8u3hyDKKRdKpj7JsKpp/BVCl3O3w1IZQAgEWoLHxYIFqtCO4de/SR9C7TC4cyT/O2a+j3ksGCl8YkDpV226YvfM6JdmMsOKLu2MLKyuYlLccYRWReBcamTGc02SxKgaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708255216; c=relaxed/simple;
	bh=bRNOhu4ivre1FJArT8QljjJylAtESKC9dBpMWNdomnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zxtzw9xJ9aQCon16VRRIgv2GFr6BG7+O/E4wqB/DVUt8m5gvvgFeLpnMM4kCKz9EMtbZYTxfWchv8Kqxg16dLKf1s3Hu28vrqDFDbQHQRDylak8UU5Xri1woKspfM6y0P9EBAzS7FrQyje2Lpy/BbYQuaq6VSuhTNFEKgJ5L/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WgUNPNSj; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so2688133a12.1;
        Sun, 18 Feb 2024 03:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708255213; x=1708860013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qArjC4Ky4exLBEcNK5vZ2gL5oSFxtsS+JdimaikhP4=;
        b=WgUNPNSjhD+oLgb19Zs7uH+0TTzjbVp7UoLZ42fjDbn5ZYxPBrtBQ76pWgPGVnlW2L
         scMCA2rc43tey6GuluylmVQoY0Q1Zo4bIcLyhThLsjDJIrXWHV7XtNbcToT78+08dxfP
         8dBHF3e7zIBtHgkRJH4K5ICNWPRw6JnyU4RxstbXDrba5kmP5RbHG0VNmwCt3h708HRz
         d8UmVJ0+WteEnV6rnf89FSdrsQ55N2JcZGvNU5PJqMiw4hXefSuPE7g3/VNAZgCR44ol
         MJcl/PAcTKCMiNRJG9LNI9mef8OhEYmOLQZ9CLS1dXj6prBTejfb9BhiQrBeBXGiy2LX
         HWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708255213; x=1708860013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qArjC4Ky4exLBEcNK5vZ2gL5oSFxtsS+JdimaikhP4=;
        b=Mnw5HJxR0l0BbAplxvvBlc8dALmyfMHcJwMVqWudAL/va6gYEkOvLyjYVxO989RTqO
         infp/b04FMsfy1kSDb/wJcWFAuz8gX4i7H/GnQakJi9MUOfMqXh28dgGi2umPep7J7jy
         I4nrG5BJC3KlKz9TrK+6I4AvSmkePfQiAIjcZCVdmsSSmTl0ErAqvuQJgYoILGtFcADg
         cM6kX0WaqV+rt9dXZn3UsmsAW9AqbM4Apvq1oUCjotyloJRlwvYZ6TLis3J03cCJxubR
         vrVQyAm22bM98EsGsUwV01hZ28O54YJvKDSxkwgEJL1QZcWWGWN9hjtbnp4nVoOzx/+3
         o3nA==
X-Forwarded-Encrypted: i=1; AJvYcCUt6AEANtL+tRvYDsKhA5g/7e08gryVGm5rHg4UcAT+FjUp3/ID/YSdpvgbOQ9vErhNE/rBMZ11RSbV+8R9sWsGT2J5flfJDegk38Wd
X-Gm-Message-State: AOJu0YwkGjhtkyMqxI9X7tVJp1X/6juEOxfQ4orAJvOU58aTiH91KEX3
	3Uem3Y6H6KFy1+AXwEIZkC2HBe8HDqluCHK+eeoHLdduVaaGSrw/
X-Google-Smtp-Source: AGHT+IHpZ2UWggBRaRs/E4ts3NOL50QSRYc5Yf0JtrkCA3HM3XaOSc+EzToK6ohI1W3o6UkrFQtntg==
X-Received: by 2002:aa7:d441:0:b0:564:50e6:93f8 with SMTP id q1-20020aa7d441000000b0056450e693f8mr826732edr.15.1708255212649;
        Sun, 18 Feb 2024 03:20:12 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-7b37-4900-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7b37:4900::e63])
        by smtp.googlemail.com with ESMTPSA id di25-20020a056402319900b0056401eb3766sm1675190edb.29.2024.02.18.03.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 03:20:11 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	neil.armstrong@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 2/3] ARM: dts: meson8: fix &hwrng node compatible string
Date: Sun, 18 Feb 2024 12:19:58 +0100
Message-ID: <20240218111959.1811676-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218111959.1811676-1-martin.blumenstingl@googlemail.com>
References: <20240218111959.1811676-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no documentation for a "amlogic,meson8-rng" compatible string.
Keep the default compatible string from meson.dtsi which is
"amlogic,meson-rng" (which is also documented).

This fixes a binding check error.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/amlogic/meson8.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/amlogic/meson8.dtsi b/arch/arm/boot/dts/amlogic/meson8.dtsi
index 59932fbfd5d5..f57be9ae150f 100644
--- a/arch/arm/boot/dts/amlogic/meson8.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson8.dtsi
@@ -645,7 +645,6 @@ pwrc: power-controller {
 };
 
 &hwrng {
-	compatible = "amlogic,meson8-rng", "amlogic,meson-rng";
 	clocks = <&clkc CLKID_RNG0>;
 	clock-names = "core";
 };
-- 
2.43.2


