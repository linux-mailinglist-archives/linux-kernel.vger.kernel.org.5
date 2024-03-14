Return-Path: <linux-kernel+bounces-103783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221C587C46D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6252818AE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C6D7641D;
	Thu, 14 Mar 2024 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e9xJE9Yn"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE822A1C7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449248; cv=none; b=GbDI/bnJt9QyPgfVQcs4HWdxx7LaDXEK47xMU7iOaQ+68QPzJEDKBWE4mNjWQsUBloL79DIweUqjpdyV1deA29CVzKMgclk4SpQkaJSIyWB6ycJsBD/tOWtYEW0uJiynnOdtr6maFDmZeisCKxZHtG+SUugjFjaru0DPGG5opZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449248; c=relaxed/simple;
	bh=5ovH1aXNUGhwYmg43jcq7wC1/uQK+Bei/R88ECbB4ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTMFbpfgmmutm0lHyRoOKDaBVdCYfTjdqB11f8U90QqHQG35SkGsBOgbIQy/Py+rSJeOu0X0XR6wpG6fRxi5AOnN2YeT5++kUlEGkgSY77lEQgDZRe354XalVsxEXsF+kVy4BHLlsq5PEchRf2Vr6N3f2ClZDmN/dTUwiMzXLyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=e9xJE9Yn; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42e29149883so6084451cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710449245; x=1711054045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTaWihQYnQLfYGaPErRuZAyfnVaDu80XXW0C+HSNw+c=;
        b=e9xJE9Ynic9qalcv5GB+4/azo113BWvQuQ472O6fYl7b7ZoOBE23bvdbe6JnjvBAu6
         QdOkPrUll1F7oUWw1kNYfcWx7uMhMkxkSXxeCtVdLbXKzoIaIR04s25TXAY96eIkgEDD
         u9F4NTneJxHxVTyqO7aNs8Vu629pCdTYELWHsKL8xqTuhBGxxgQ/Oela0ncpyznC/LYi
         SD86TfNQuIgJlQcf54Hyhgnzz65Fxnh7gK3fjBoGDm2HT2DsZa07si9efX/DmAIzvxkL
         Z2r7K/VeatoRrKDj+WpZgJwtj/bC7mICTQAsAplcREkqI5KGP6bO70m1F4sHbQBcqzqs
         jqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710449245; x=1711054045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTaWihQYnQLfYGaPErRuZAyfnVaDu80XXW0C+HSNw+c=;
        b=ef/B7gK9aRoUZl81R7VuOzFhYc5rS2ePEXfgxfa5GBa84Qe72YIo2qcFNbplJFPdty
         u5+ExWCwES/GNOFYRSiorJRqo3gVQh7yEixcY1QuQEjc2K/jN/ZywfsAyOhQVP5ydv6s
         sjfro4J2cqnSbAQ062Fg3CQ+PL2ME+8RbeDo3GJ2kQIdB63nBTzeRH7Rwce0UW7oHR1M
         hykwGD/EV9M3xnr/+1UKJGbbVVkIfFQ9UXLBDKjBl4nsRJ95JN+lbhVi5U+nlRQc2BBY
         HwqWw79I9VRGKiYBos30gg9Xem4UG1iLmkt9d36Ui4t8kGik2Ens4Tp5aVXANTvUqyY4
         6M4g==
X-Gm-Message-State: AOJu0Ywk/wOAPzChULxJ4X2j51VG4bPD3TEvTlOwK75BFm29J52edB2l
	YxAGk4lgwNzXyJTZ/rYRpcnH+zXS91Bj+BEUSB4aUI2EFo6CXsZtKlgmckjJIKU=
X-Google-Smtp-Source: AGHT+IG3B31CPepy9bFtQ+qDplPxFOYN2WIteiiEsns4Hk28VuM3iTWES9zOnszVJDqWo2RdVXnpfA==
X-Received: by 2002:a05:622a:5299:b0:42f:200e:1a61 with SMTP id dr25-20020a05622a529900b0042f200e1a61mr2290329qtb.34.1710449245320;
        Thu, 14 Mar 2024 13:47:25 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id n16-20020ac86750000000b0042eef160b4dsm1165272qtp.76.2024.03.14.13.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 13:47:25 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	tgamblin@baylibre.com,
	dlechner@baylibre.com
Subject: [PATCH 1/2] dt-bindings: pwm: adi,axi-pwmgen: Add compatible for v2 IP
Date: Thu, 14 Mar 2024 16:47:21 -0400
Message-ID: <20240314204722.1291993-2-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240314204722.1291993-1-tgamblin@baylibre.com>
References: <20240314204722.1291993-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a compatible string for the AXI PWMGEN v2 IP block. This is
nearly identical to v1 other than updating the example to use v2.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
index 63461920a362..6b344c0e9a1b 100644
--- a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
+++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
@@ -21,7 +21,9 @@ allOf:
 
 properties:
   compatible:
-    const: adi,axi-pwmgen-1.00.a
+    enum:
+      - adi,axi-pwmgen-1.00.a
+      - adi,axi-pwmgen-2.00.a
 
   reg:
     maxItems: 1
@@ -41,7 +43,7 @@ unevaluatedProperties: false
 examples:
   - |
     pwm@44b00000 {
-       compatible = "adi,axi-pwmgen-1.00.a";
+       compatible = "adi,axi-pwmgen-2.00.a";
        reg = <0x44b00000 0x1000>;
        clocks = <&spi_clk>;
        #pwm-cells = <2>;
-- 
2.44.0


