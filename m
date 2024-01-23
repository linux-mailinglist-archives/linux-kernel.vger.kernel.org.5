Return-Path: <linux-kernel+bounces-35536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F588392D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161271C235EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40426025B;
	Tue, 23 Jan 2024 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1RlvM5o"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5015B5FEED
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024069; cv=none; b=S+s6ZCGYFun46Hc0nqK8YtJaQpOesfYBxPDtxwxVfzP8VTmVyL+Uv2Y9wv82S3Bv6qgem65/2Kx3qcaDVGfhPPX1h+8lNYpk9OwWqFlt5J4yjQFpew27/LR9t0lS4cO80Ut5fflU2Q9Kpt1kEMLvgK9XijlpaAva+rfo7x2Fayk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024069; c=relaxed/simple;
	bh=uoqIziOYe4QOe66kMTI7DN3VeKJax6+qP/nGQ6cKH+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cm6HqcxtR7ds198qtVshiDYLB7usYknIZ7GHCjdMVJTIOrXsYKVAfSCTtVCsl9aNdjkJSiKO9fHAA6xEp034xMeF25uzq7XBUr2S6Np4MyqOw7WQdKfyr+eb3vQcTWJQnEixTyNRgksPlyTCJk4d38nAp5qXNxAnVxRDZf8sl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L1RlvM5o; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40ec2594544so4093445e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706024066; x=1706628866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjipWcrbNy/QID8T6cAOMZwyasQD1NXUWSbF3OJYF5I=;
        b=L1RlvM5oE0Oj1RrDBTSBpU+1U3MdF8SqeYR1ZU9HUn77CTtbXhHOj3Af41WBYv5nWT
         aMKEDw2ZDUCFSmGY1IPx4IqF3S67VYbQkEbGA2Kt4m4bGZVLvj2UYGfWlANbNe1fitwO
         pPiE/TvXjug1hdgITiQ/DD6LhV2WF4E7I++nkoyyreqrlA4iFUhhEtRNURDzOPii1oB0
         Sxsq91N71uF8qkhcUsKzKkF3f3FXny+RTuFD7Jvr37ZtLba1PmTv80AthUxnbfAkOJKI
         BTP4ZjwqVu2bGM9kNYj7GnhP9XP4b3oX36SZ4oqtlG9vCOsO4g/3z6s1Pk3nNKtj9DNW
         QCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024066; x=1706628866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjipWcrbNy/QID8T6cAOMZwyasQD1NXUWSbF3OJYF5I=;
        b=unBTeY4T+V1RGCXjr2pueCyu/0jBNxO00UJIq5sX+Tkt+oQTVe5SqJok7JtQvrowfB
         LUldKn40MpssOwZXFbSxIM64KZS4SAps+uryFTdmerdzd2UAtZ5x/XZl1crmFxmhDAIL
         IhyaGpHD8Ng0JGbRUo2rYWdl393f2exGt2Kiji4hUvK0fcWMRhsphbZwlYmSXPf4vBnj
         Diy0BsoMd3J+J23c1b+Kenb/c/kBIzCo5flfOmz5Mhcsa0NwXI/VVudzTcvGjU1nJKkg
         2qqxWXbc9pqnt9CMfzTspPYeKfJyx9V7Jihwi2L1ctamTsJZ9cidgoYmfm4+UrVY/zqq
         NNyw==
X-Gm-Message-State: AOJu0YwvIHgn+RF9ZDXptjLNs3I7d2Kyd+FAsx6t8wCpSTYmxOFaCFY1
	fhxSQNpLdE76ZB8DiHuGg7HGnnnXIcJn7ntpGAOwEaNYqF/4TVreCscNIrpf6r8=
X-Google-Smtp-Source: AGHT+IHosPR7aXkGESXR19H32liyG2yCDhVCsytyJRVKkzbH8iGrmrZbLr9K8ewIBbwBtT6UmR9VcQ==
X-Received: by 2002:a05:600c:9a2:b0:40e:4694:38a6 with SMTP id w34-20020a05600c09a200b0040e469438a6mr248582wmp.157.1706024066574;
        Tue, 23 Jan 2024 07:34:26 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm42457536wmq.12.2024.01.23.07.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:34:26 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 01/21] spi: dt-bindings: samsung: add google,gs101-spi compatible
Date: Tue, 23 Jan 2024 15:34:00 +0000
Message-ID: <20240123153421.715951-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240123153421.715951-1-tudor.ambarus@linaro.org>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "google,gs101-spi" dedicated compatible for representing SPI of
Google GS101 SoC.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index 79da99ca0e53..386ea8b23993 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - google,gs101-spi
           - samsung,s3c2443-spi # for S3C2443, S3C2416 and S3C2450
           - samsung,s3c6410-spi
           - samsung,s5pv210-spi # for S5PV210 and S5PC110
-- 
2.43.0.429.g432eaa2c6b-goog


