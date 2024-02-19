Return-Path: <linux-kernel+bounces-71959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4373285AD12
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8AA5B22F04
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0FA5467B;
	Mon, 19 Feb 2024 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bV1JYQCt"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA74535DF
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374212; cv=none; b=fmkIOcrQQJYSnmV5UVtIGC+dFhnMu8H5L8mbhqp1h6QNzWh1IoabcVcsKzsrJRlGutargBA9+6JhiCEDjdHKQXKz9eMNib9dXDX9AMIBe7dbRg8z+oDKwvk6wYuEPaUh2xSUevj6bCmcODFfAYUp7mOrn20NzBSaVh2c+YAtUSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374212; c=relaxed/simple;
	bh=GCN4a3XwyVGjN4FSoVSL7WZNZKmZBWlauyy+D84PGEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHuJCUbW4/2nu/2uaoE/3zDJsQCXA82mMf1QZwRiP0FporovT5LojYLfnk3n8MUg3YP16qMjwx7kY5tt3xaVQykiOPl1fqyGlKV3H8Wf7P0hWz51pk8I+PhW0+yWMxQ4/t5Gg+SxJjITXLT9OJCCHoN5GFX2ttN5BrNi1pLZZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bV1JYQCt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1db51e55023so25477355ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708374211; x=1708979011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUa3JH16Oe5UJV9UEwjr6pY+WpID6lK8xSe+O5n7a8M=;
        b=bV1JYQCtkS9Hy/MCHAsLi2DxYJJUp0KhmL4KmzkBk8aXLh8/3g3U3ugU8E+n1kKV33
         q4RwPzkMJx8ltaijxuXdkCMP6uXEHBZHmxFxmU7oCup1bnCgjhmbgDUay4KJWWANBza6
         U0zd6BPSnOZlRYH+S5CNrFfLgWqajGh0b6nrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708374211; x=1708979011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUa3JH16Oe5UJV9UEwjr6pY+WpID6lK8xSe+O5n7a8M=;
        b=wx/OZK3AU90qsLOTayK1VfTWaUo7PibJp7i5Mbh16CwoSwe5f42dlVGUJQrEYQ57/u
         lA5B7n3pydstNselqCyFCeiS3QgRRtDerPvcL2p6GIc0oozGBKSZsTYVIvtx6ubeDtUk
         eFEuIndkxwfKl9Q7crg3geUn0z5CNhB7ACh9kGca7/YxZANDc/ky4ReRSdhWPPHGIL0T
         ZVfmz7O6Y7JKUXpoLR+bd5zBgzdK3PdoVtvjk8lf31dbzq3nbAeQMjU/FbAK3633uVAm
         wn+tJu1UwBTOFijOyUJOt422opYpjD06aVL2F4T345VBu0yTz2q+9bxubH3p1zeC/rCB
         XqyQ==
X-Gm-Message-State: AOJu0YzWDGK7zHAzPS2kX6OzcLj6IjyC0iY93BkWfZ7YilM6G+sB/tJn
	g/hn8zVaZxdBPgZvbW8fpBP9+uI+6S2o0niHv+VnxILNTG8eNEWdyuRGxyZ3NQ==
X-Google-Smtp-Source: AGHT+IG8LtaETDPpup4Qyvx26INSaCWovgahZdaA0zbKl+GL/t4KUJJLp2AnURqkSJ5Jxmv9EMKmoQ==
X-Received: by 2002:a17:902:da87:b0:1d9:2158:1308 with SMTP id j7-20020a170902da8700b001d921581308mr16281281plx.28.1708374210688;
        Mon, 19 Feb 2024 12:23:30 -0800 (PST)
Received: from localhost (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with UTF8SMTPSA id mf8-20020a170902fc8800b001d9fc6cb5f2sm4818207plb.203.2024.02.19.12.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 12:23:30 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 1/2] dt-bindings: cros-ec: Add properties for GPIO controller
Date: Mon, 19 Feb 2024 12:23:23 -0800
Message-ID: <20240219202325.4095816-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240219202325.4095816-1-swboyd@chromium.org>
References: <20240219202325.4095816-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ChromeOS embedded controller (EC) supports setting the state of
GPIOs when the system is unlocked, and getting the state of GPIOs in all
cases. The GPIOs are on the EC itself, so the EC acts similar to a GPIO
expander. Add the #gpio-cells and gpio-controller properties to the
cros-ec binding so that other devices described in DT can get the GPIOs
on the EC.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: <devicetree@vger.kernel.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index e1ca4f297c6d..aac8819bd00b 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -93,6 +93,11 @@ properties:
   '#size-cells':
     const: 0
 
+  '#gpio-cells':
+    const: 2
+
+  gpio-controller: true
+
   typec:
     $ref: /schemas/chrome/google,cros-ec-typec.yaml#
 
@@ -275,6 +280,8 @@ examples:
             interrupts = <99 0>;
             interrupt-parent = <&gpio7>;
             spi-max-frequency = <5000000>;
+            #gpio-cells = <2>;
+            gpio-controller;
 
             proximity {
                 compatible = "google,cros-ec-mkbp-proximity";
-- 
https://chromeos.dev


