Return-Path: <linux-kernel+bounces-59246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA83284F3C5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A971C20F45
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1AF2D602;
	Fri,  9 Feb 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyYiqGwI"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C62128E0F;
	Fri,  9 Feb 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475820; cv=none; b=HdL+endDNxXo6Qv2EtPAQ6OnUvgbcvspqwr5wAEii1rGNNSMDii9V1kxSLCgjd5Uo4mb6+2XBaYA28dhpSIO4fZxe6wYgDAvNzlrJvpJzZGN5qU1+5uyeSr3kXwTUlzWEXN9NS0lkygkLvZ2BeyGig/csGytRUvHfJyDqPZQzmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475820; c=relaxed/simple;
	bh=t0Yp1kY6qtM37V8D5tGl8e+xZzRSxjruApL0YIVR4Cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NTuaRw8CQaFCuF6FwpOzKa4780R13qFN8vxxV4/fTgj42pJ4DyFPfdXDCbFC/xGZVRjVBzEqlxm1ZWGmRJRd3FBWH9HqYa22SYJFuvDr2gijyDdGZen80zd0+5Wr4hmqbhYnPrZFFbxrf1yJGakaK6aRLNDBNdjA4Xx5esXx7Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyYiqGwI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4101eb5a115so7122995e9.1;
        Fri, 09 Feb 2024 02:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707475817; x=1708080617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZwRK1DevWHs7TSy/8l1VCGmE7RT9MSmuvvOPNO04ZE=;
        b=eyYiqGwI5cmqFg9fzF037ul0/+W/YghJJCgHldBH5KJG87wrLZFxkeydt8dgplmy62
         mkFHpOOoi6u7zKpmHdC9PLpcRihX7xn5EtGNwGZDG4l9SbfaRXIxqGMVCkuuCqP/9s9h
         E+vQP5QQ7IGp0Hqe6OUcHtqpgcBu7CEFmTl5ixAvPaprRQI07tfLZS6ffBVxL1mWdZL5
         TOgdgvp88m9w8ytQoDW3BHENxc7t0F1BPPn3RdmxHHE3zvV94Y3DhVaREoxrQJzw5fsH
         QTFB25F1XFtW/YM8oDAd7QmjL93Bfx5AzKjl0bwJ27HItJr9zrkuwn6g/lmxWj35eEl9
         gwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707475817; x=1708080617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZwRK1DevWHs7TSy/8l1VCGmE7RT9MSmuvvOPNO04ZE=;
        b=fVdozm/iYMENsbW5sAjjgl1aImPrxYPMFcwQGoDCxPDqU0DUK3rry8OzlboGmWb4GP
         GoXg005OAVp46WTcvhVORE4pfWbLXY2+uwSchWEf3Zrz9GCHyOiDuKVbBQoqvGbNCy/8
         uMUaaVNYdChcSY1E9K3hvw4T59xNskr8cHU33bwpt23toupFQLYgOUcVFMRKej545f8p
         zd0omOJotSKeJ68zy3LcFqkFGVFlD63sYvKg/JJxkvzB6czFsol+YKQxKadFhkyCUn0C
         RHST3pJPYCh0zrnvKzWW206phIisXuZEaRaXhAuX6BxMAa2kKdDO1iwMKLvU8qNF/oZ2
         Z1Wg==
X-Gm-Message-State: AOJu0Yynjg6XdBpNGzJxCrsBBKSmPzksoIgd/mF+mxIaLoGIlSBseIcw
	tBZ1rpyK9PIyqckr+eowwQ1UpfzL+Odre5j0vLkKpwtzNYY7a32X
X-Google-Smtp-Source: AGHT+IFLvTHLX8Ab5kv6hCZYjklTGqUjMudeOyyOj57sb/u9OZKz6XTkP90ITEfQG3yjl+mZG4Zqnw==
X-Received: by 2002:a05:600c:3596:b0:410:6506:68c2 with SMTP id p22-20020a05600c359600b00410650668c2mr760796wmq.14.1707475817104;
        Fri, 09 Feb 2024 02:50:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTJFCYzflemGUHHiGpmSJ3L4fd/0g+ziBN0wzI9pf89I5j691ofb14mCig7J21SNfrnQ2SfNXEl/990+T7tDJ5KLytUAnv2fCQ0xz8y5Gedr8A6PP6WAQmM/o7OpnJ88gYCHFIHmkaVR8tKkt0obhRtOP1bKAdv0H0NYFBcZFX7zvrMsNsj86M8o6Ong7PcG61ULuJg5Fr4OBromd71W0ZpOPn4LIwDdxYwxaAxH1FLhhFO6Jz2KX810tnLulakx3XRdtmB41q1D7aQYnKPHPguIXTubp5LL1B5Qavf4U80mEBUslVxB1BBo22DcDh6UMI7wzeAi3nXl0pIrjiiLx9reUZat/IIHJtkctFSu2XS1HYVYFSBC488bgoS6H0EmnkTGSg9HB6FcCQJUcPwmux5O2eV6zNtO7Y+hv/8dGc+YEpFEA2f3Fty/BNvtfPDkrHfsoyE7LOBhM4I2VOBhrPOGB3awEhX/2rsmEz6HpK8xetYluvjEgydRw4YrIQwhhJWu7nm4Xn7Sqm/Z3c41Alh3uu9odVm1HbXgNo+o1vP1ViVzIImFwAE3+IZTEm4FRMvG6PezfnspnE1UcQisrLnd5wyYI=
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:765:2268:762e:2748])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b0040fc26183e8sm253627wmq.8.2024.02.09.02.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 02:50:16 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: nick@shmanahar.org,
	dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linus.walleij@linaro.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	francesco.dolcini@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND v3 1/2] dt-bindings: input: atmel,maxtouch: add poweroff-sleep property
Date: Fri,  9 Feb 2024 11:50:11 +0100
Message-Id: <20240209105012.22470-2-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240209105012.22470-1-eichest@gmail.com>
References: <20240209105012.22470-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add a new property to indicate that the device should power off rather
than use deep sleep. Deep sleep is a feature of the controller that
expects the controller to remain powered in suspend. However, if a
display shares its regulator with the touch controller, we may want to
do a power off so that the display and touch controller do not use any
power.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/input/atmel,maxtouch.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml b/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
index c40799355ed7..8de5f539b30e 100644
--- a/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
+++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
@@ -87,6 +87,12 @@ properties:
       - 2 # ATMEL_MXT_WAKEUP_GPIO
     default: 0
 
+  atmel,poweroff-sleep:
+    description: |
+      Instead of using the deep sleep feature of the maXTouch controller,
+      poweroff the regulators.
+    type: boolean
+
   wakeup-source:
     type: boolean
 
-- 
2.40.1


