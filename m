Return-Path: <linux-kernel+bounces-39251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECA683CD8E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A41A1F247A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF58745F9;
	Thu, 25 Jan 2024 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWAWyMCt"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2783A1386BB;
	Thu, 25 Jan 2024 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215044; cv=none; b=KhmzUEtbDI02kF0zkk+v0+YB34wTy2zTW3g0Owiq+sR6DqM+ZWblpFrhULBPasGcZhCmGM3buC/YS03ROy4l67MfwdBpP4Nby2j70t7I0XtMVIbyNjN/X5Iudz0buvl+gzZPEC1SPNZRVY7H175eUdzyT1AZR2kmKWkZ2Ea1qww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215044; c=relaxed/simple;
	bh=6aumA7+O/S9wHmzoCwzvO6hywi/d81q702bNntd9/Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Do7UVnLwJDi4CNrrARHTf4yTRS51rtecn/MGXlKFLnvL18cj5dSHcIByV8wlHOV1Ke7cvpDDdl8u9PiYX5ixzrGzCcAwePq8j4esoY0jHYrW4TsmQWM5kiG+l5KmorrM3sTKHyAwrdDLbu4fQMoz1SP11G6dFi93BoCoCGOojy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWAWyMCt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so78401825e9.1;
        Thu, 25 Jan 2024 12:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706215040; x=1706819840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TK/jzjeKhCUMdn84sRlAxs0YdsDSfP3y0ZAKcUDPB0=;
        b=kWAWyMCtYKAfL6gbiRBlPoe0xmc428Fq5TBguv1wQu1k2Gym/FGfS//sLB92h4IPkH
         4Js+TB6b0Y16Zw8/h9a7m72YLu4Kz3O3qdNq0y5da/AYLyNH7H1Cp2pokyjn/9Y7INcp
         dOlGQ9PrYVHp6oWcfA+i4A3/UPuVF386Ng1Ocy7HfYLOpnD9Ng+jT2YtyQYKdXG+NwFx
         ocRJPC3JUjP9ZjM9zsVDdGmQrjjm+F2B751nc+R4dtsrtK+hn+8S31H8RA8xT+i5I0Mt
         xUCh9jywHwNP0mD0N3gUiPf+1T0YQOzYrg2qb5aKsAS9CL1DZq0d+EnGVNRCoDTRJptv
         bEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706215040; x=1706819840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TK/jzjeKhCUMdn84sRlAxs0YdsDSfP3y0ZAKcUDPB0=;
        b=PoGVi7G0ZU5khMd8D0LouQZKAEM/bMzfsN0VxsTo6eGp/1SVU7pipmDcyQvJbDukb6
         YTh7B8Rykznf7FGLORhZWVhw5Up343dQcrTCira/z6+tQuxyG8QE9J4E/4jTy62i6xf/
         oVIuT8+6efnBgMwKKrwcVjUF3r1FxGIFc2jm4qQl2Z7mgCBahmNGgzbHURVQN0NUTe63
         9hvbPw5yLwWhO3+PnwYY0QYA4JfN0m+0e3HZWMSCmcQMF2pLMjElUc87AAJ+ZtWDYUrC
         4f3YhXTcCabtwgGOYZDTF8HB2DFCDlWrqvEY7m9TlTpob71o7AWA7Hm1MRNWcVoBNGTC
         1CgA==
X-Gm-Message-State: AOJu0Yy0gWa0+ndE5V/C+DLJlBS0+l7UtlHvpjoJi193wVBkcJ1pO72i
	xbJtQtXyX8WH97P+bHxJhypTq63Lr9FfNNpWvnMupdsd1WeppqLn
X-Google-Smtp-Source: AGHT+IGCiq220SzI05Ov5whoR+Ji/qT4+tozqCDUBnT1AN0iy5c4d6zxzxeF9zpwxBfvVyYUXrlBnQ==
X-Received: by 2002:a1c:740b:0:b0:40e:7081:4d78 with SMTP id p11-20020a1c740b000000b0040e70814d78mr178532wmc.140.1706215039905;
        Thu, 25 Jan 2024 12:37:19 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j32-20020a05600c1c2000b0040e813f1f31sm3817700wms.25.2024.01.25.12.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:37:19 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
Subject: [net-next PATCH v10 1/5] dt-bindings: net: phy: Make LED active-low property common
Date: Thu, 25 Jan 2024 21:36:57 +0100
Message-ID: <20240125203702.4552-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125203702.4552-1-ansuelsmth@gmail.com>
References: <20240125203702.4552-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move LED active-low property to common.yaml. This property is currently
defined multiple times by bcm LEDs. This property will now be supported
in a generic way for PHY LEDs with the use of a generic function.

With active-low bool property not defined, active-high is always
assumed.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Lee Jones <lee@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes v10:
- Add Review and Ack tag
Changes v5:
- Make active-low generic
Changes v4:
- Drop support for global active-low
- Rework to polarity option (for marvell10g series support)
Changes v3:
- Out of RFC
Changes v2:
- Add this patch

 Documentation/devicetree/bindings/leds/common.yaml          | 6 ++++++
 Documentation/devicetree/bindings/leds/leds-bcm63138.yaml   | 4 ----
 Documentation/devicetree/bindings/leds/leds-bcm6328.yaml    | 4 ----
 Documentation/devicetree/bindings/leds/leds-bcm6358.txt     | 2 --
 .../devicetree/bindings/leds/leds-pwm-multicolor.yaml       | 4 ----
 Documentation/devicetree/bindings/leds/leds-pwm.yaml        | 5 -----
 6 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index 55a8d1385e21..5633e0aa6bdf 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -200,6 +200,12 @@ properties:
       #trigger-source-cells property in the source node.
     $ref: /schemas/types.yaml#/definitions/phandle-array
 
+  active-low:
+    type: boolean
+    description:
+      Makes LED active low. To turn the LED ON, line needs to be
+      set to low voltage instead of high.
+
   # Required properties for flash LED child nodes:
   flash-max-microamp:
     description:
diff --git a/Documentation/devicetree/bindings/leds/leds-bcm63138.yaml b/Documentation/devicetree/bindings/leds/leds-bcm63138.yaml
index 52252fb6bb32..bb20394fca5c 100644
--- a/Documentation/devicetree/bindings/leds/leds-bcm63138.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-bcm63138.yaml
@@ -52,10 +52,6 @@ patternProperties:
         maxItems: 1
         description: LED pin number
 
-      active-low:
-        type: boolean
-        description: Makes LED active low
-
     required:
       - reg
 
diff --git a/Documentation/devicetree/bindings/leds/leds-bcm6328.yaml b/Documentation/devicetree/bindings/leds/leds-bcm6328.yaml
index 51cc0d82c12e..f3a3ef992929 100644
--- a/Documentation/devicetree/bindings/leds/leds-bcm6328.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-bcm6328.yaml
@@ -78,10 +78,6 @@ patternProperties:
           - maximum: 23
         description: LED pin number (only LEDs 0 to 23 are valid).
 
-      active-low:
-        type: boolean
-        description: Makes LED active low.
-
       brcm,hardware-controlled:
         type: boolean
         description: Makes this LED hardware controlled.
diff --git a/Documentation/devicetree/bindings/leds/leds-bcm6358.txt b/Documentation/devicetree/bindings/leds/leds-bcm6358.txt
index 6e51c6b91ee5..211ffc3c4a20 100644
--- a/Documentation/devicetree/bindings/leds/leds-bcm6358.txt
+++ b/Documentation/devicetree/bindings/leds/leds-bcm6358.txt
@@ -25,8 +25,6 @@ LED sub-node required properties:
 
 LED sub-node optional properties:
   - label : see Documentation/devicetree/bindings/leds/common.txt
-  - active-low : Boolean, makes LED active low.
-    Default : false
   - default-state : see
     Documentation/devicetree/bindings/leds/common.txt
   - linux,default-trigger : see
diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
index bd6ec04a8727..5edfbe347341 100644
--- a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
@@ -41,10 +41,6 @@ properties:
 
           pwm-names: true
 
-          active-low:
-            description: For PWMs where the LED is wired to supply rather than ground.
-            type: boolean
-
           color: true
 
         required:
diff --git a/Documentation/devicetree/bindings/leds/leds-pwm.yaml b/Documentation/devicetree/bindings/leds/leds-pwm.yaml
index 7de6da58be3c..113b7c218303 100644
--- a/Documentation/devicetree/bindings/leds/leds-pwm.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-pwm.yaml
@@ -34,11 +34,6 @@ patternProperties:
           Maximum brightness possible for the LED
         $ref: /schemas/types.yaml#/definitions/uint32
 
-      active-low:
-        description:
-          For PWMs where the LED is wired to supply rather than ground.
-        type: boolean
-
     required:
       - pwms
       - max-brightness
-- 
2.43.0


