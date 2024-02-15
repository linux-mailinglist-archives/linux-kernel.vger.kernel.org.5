Return-Path: <linux-kernel+bounces-67058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7830856581
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D041C24547
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588E41332A4;
	Thu, 15 Feb 2024 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="b7BmtPHD"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317D13340E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006155; cv=none; b=dZ3jccUUquVnl3rS2i6HfrrrUvqZLUqPa4RrXfjCDwO1gX73tKEkMydewltVRpB/juppUOz7Gb3SRLYwfxw90juiIxCFsEU8lMvseeBd4Av1dtvw5N4Gy0x6Rv6QjjoFf04mV61K7MVJs1QkHNv24jJiIvimHWRRklVcmwQjtD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006155; c=relaxed/simple;
	bh=2C2IVa4viiNlUGmLOxJLTFOjDptgPpUuxtWwnvfEGIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iNuPUbtwwmVxHBXhyxM7XJHgRTDbvtB9u4c4lrmmbfwqKiNL0ktmaKvthI9n6GIZdZwT7lucioXe07fcCwA3EY0hwDGO+hdbnnRWCp4n24cG43ql7eZuGsq1PQmsTSNTHjWoo1NGY/s0d+EemRogjp20gkyLBOsJT4Lr9ByGejU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=b7BmtPHD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4122acb7e69so1979255e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708006152; x=1708610952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rijbwvHcSAy25b/Tneh/0DG0Xorpu1pIj5rjNv2eY/w=;
        b=b7BmtPHDrwRBmIFvsaHyY67L3XK7LLc2QkaSykgvNG1mrH/KxPwMA3Lg50yx3F54KB
         F4YLr2QT1F36G3PQ78FdZiT9+xfoA7M/UENCf77pxcQBso3CgFKOoNr4Hud3uhjK+FGU
         /lgggoT5X5V9x0GI9dU1+tWip45QkhZYpAsKUm8awe6RjQGNVcFDh0kZEAux4cJXdsQQ
         PzourC3eMqQTJ7z1ia+yMA72XCqrJCPQawPH1msEpvThc0885D4zEDkikky2mRo5GDyE
         zDqSDMlK4V9+ApDP6WtiTKMOkqx1n25bGB/bHmUZUzc/n/zk5vdZ8jFHAUuTVT2a5iFd
         MDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708006152; x=1708610952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rijbwvHcSAy25b/Tneh/0DG0Xorpu1pIj5rjNv2eY/w=;
        b=AYGZCsizmfmL8A2br21OVECkttmRRXeLnhwoCC5c7E3X6Nn+sGpkTWYpggy5Ly8si4
         6ZLgMg2SQzMJ6+GQOy7L+RxZRoFNaQQqDHGTCzQSm64l1aIbaZ80PH/8BSBVbGaMYKqh
         JwOZfAvoRzvh5j2hueBUsYgUWAEK6oVUFrNZFWAo14KNIudCAjw+iJa1hNYGhnpdTb78
         Bg4L7gDNFU6lSSoYoGSP+qUNu7/2fdmXXYZkYeLL7McUSmJQdVB+lwUXkPn36/BFEoXL
         4nc7C/qIRhUs3EtDLJQJzUkXDb7UbYEaP8Fjp21TN51zRAVK/zUje/cNebgakmkKhC9w
         XlDA==
X-Forwarded-Encrypted: i=1; AJvYcCUS3rGpCi+hSF+o8q2f9sobuyfhlUfaDG9an14g8vncP+hCgvvIimAvUT2X37Ccs9ssvWdwg5JphbTpB/aZrohFscLp4B6G2rKKuKO7
X-Gm-Message-State: AOJu0Yz1NrzWmcmiV/MfF/SHdDucAse1bjEcRSu82qxgmb/9rJLF+L3W
	QsXqI+QxuFpIAJ2SqItl3HQa+uImIa3RhXhHRfqAhDA4eopvfKniUwqt6+hFjiY=
X-Google-Smtp-Source: AGHT+IFO4kixRtEYXDlu3mbSKifqhuSVYxtsIbsqSj/Di6B6cs7A9YuUvATjjzuvOpQ53ZC9zpVw8A==
X-Received: by 2002:a05:600c:4507:b0:410:71e8:4921 with SMTP id t7-20020a05600c450700b0041071e84921mr1683519wmo.24.1708006152465;
        Thu, 15 Feb 2024 06:09:12 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c261100b0040fe4b733f4sm5120950wma.26.2024.02.15.06.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:09:11 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 9/9] dt-bindings: watchdog: renesas,wdt: Document RZ/G3S support
Date: Thu, 15 Feb 2024 16:08:41 +0200
Message-Id: <20240215140841.2278657-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215140841.2278657-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240215140841.2278657-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Document the support for the watchdog IP available on RZ/G3S SoC. The
watchdog IP available on RZ/G3S SoC is identical to the one found on
RZ/G2L SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- re-arranged the tags as my b4 am/shazam placed previously the
  Ab, Rb tags before the author's Sob

Changes in v2:
- collected tags
- s/G2UL/G2L in patch description

 Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
index 951a7d54135a..220763838df0 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
@@ -29,6 +29,7 @@ properties:
               - renesas,r9a07g043-wdt    # RZ/G2UL and RZ/Five
               - renesas,r9a07g044-wdt    # RZ/G2{L,LC}
               - renesas,r9a07g054-wdt    # RZ/V2L
+              - renesas,r9a08g045-wdt    # RZ/G3S
           - const: renesas,rzg2l-wdt
 
       - items:
-- 
2.39.2


