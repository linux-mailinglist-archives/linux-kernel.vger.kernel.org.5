Return-Path: <linux-kernel+bounces-61209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0129A850EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914251F26055
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5986411182;
	Mon, 12 Feb 2024 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jgIQN8jt"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB77EED1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726876; cv=none; b=mD6CIxD/QKhlqJZCS+muxR12iiihxPHE9APNN8Zsigo1hv2/RzKtlmPnR3PFJ7uX3O5DiVnNDFaIVyhSa7VnUeKAYgzJEkjFe/UujzEI+/QNbBE+rxvjXJc6JfLAWVqSbVrNqDQwNX7NrtjmB+1TiGALvkexYICim6ywdbww1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726876; c=relaxed/simple;
	bh=5he2EcrlAp+EDXI2Yx8Z0z61Pwfbf0mAZp7xr++6WIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P7kPrEadJq04UBl/3Q1Gd34fubCDsPxU1JvLghl8PGqypzls7KUR841NvA3H2EdyiNA9+CWCehES86a8mFDpalpxHExzgUc1qT6Yvc9fmF8EDkyvecCx2aNGGHhUy8T/IqE78jjFFPhev5BkV3LYkWXH5iUmERzUwaiKN/cRdvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jgIQN8jt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-410fbf07602so833665e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 00:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707726873; x=1708331673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaRSiyy5TB2m6BLeq2URaoRViTwBMQVl47ntDRafb5E=;
        b=jgIQN8jt/IfRLOvtil1c0omjk8dh90l620lKPJ25lrnrWEHhEVVnLelAECn78m9l2+
         asY5kurEqfbbhKFNUMr5wPgkWtUL1/zeOyH7VvtyODtzna7W/pdSJSCLEciijND6izvq
         PJfEuhLIJJiYKWpCTiCI5/UIv6mhAbM19aSctCIgIQ8QH3SsYbpbDKG0uZ4Swb3ZFu+/
         TNSqunF6MzY5IEgF3Y9mavFEGrKgTnEvT5WsxJaIUKDPJIsJijzxkvFkEa/zJ8X1Abc5
         gLRSCv7gxwxKsc1aLNgcV2mQLHEowI8d3m5+aotnuJS1a/XNW+stNV2tZG0BkMy5P6XZ
         mNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707726873; x=1708331673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaRSiyy5TB2m6BLeq2URaoRViTwBMQVl47ntDRafb5E=;
        b=K29A6EdpsQ3h5k2isWrU3Axl5aMPTPKcipgKWK/7sz/9NqHxD41NpZ/Ri9zKIvgX6Y
         5QxAfnMuIKZalJ4VO535wtBhIoM3y4HTJkWrMCN+D0p8hTJN2FuDfn7CYoQGGLTWNhui
         C9S0dM/Elt6ulI1soeo3gWa5lXPgtBi8YxTzbgrCCn9xUZLhnne9ubyFG9K33+GxGWlA
         nVvrKnndZl0XPyA8wzhmWGFr90y8c4u3A5yEmPK89og/gSmPF5GqPgdnadgIIhNTBdrQ
         bsCC48zc4sg/5VWeofeodoF/5oQ+VsdD3w+yRoEPJarpY4KS6aZAE1zNNqDCYQCs3Enn
         nE7w==
X-Forwarded-Encrypted: i=1; AJvYcCVrN4mL8R/jrIblBQUAYmUJt7vX1BApmnXdBfCIJMeqsSsjmcf6NRUCpRuMSGbMrpWiKw0ulRh0afU7anU9svQu8sqhT0yuv2WaQJOC
X-Gm-Message-State: AOJu0YwJygqmKjCZlL8OUM9qjVQpVT3LL5KkjSFCAs/NEhCms1ip94u3
	sAPBFWArGnerJxSAqmDlpgGWsvOH7ck2hNRBYshIDOh3zknfToIQpBPj9bMzHR0=
X-Google-Smtp-Source: AGHT+IGPBu9L4lg3WcVVf8VH00DzgndsX296yopkncy5QsNshuKCqXEtgJ5oCHafEdrVwPTgP48zgQ==
X-Received: by 2002:a05:600c:3b8d:b0:410:e90e:8310 with SMTP id n13-20020a05600c3b8d00b00410e90e8310mr665729wms.3.1707726873047;
        Mon, 12 Feb 2024 00:34:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpQRp156K05li7b4B0pZ2zvIyH2pqJuL4+ekTllcxbiNdlWQFv5dBxJS76V1DQsYjUq+7O9jYWbpaZ4WdtMNfpq71JyHpVm1w8oYjZxouI//JOcPy7h5x3BGLnMcvatzrnTnaTNURw0G4SQX5k5oS35GGH+2+LKjRHaxhaLMSWVrEzEOowllOa3ottfJclvEU1mrC7Wvc44TVl0B8aOjG5cgo9viJNVu52S/eoYVKPujjI2NDsouyn86pN4rdD85xzsSHLwz6k1RUuiONg4t18nlmmbq2K2l1Hom6Fm/hyYxJUMmJNfIjwzIfa1DaGLWZJ711Lfa77lkWAR6u43rfreHQjgoOmfVE8LHHuJFlfQ/Jap+UhdGkanAfLhJlt7n41UnmtjrUPX14XMZQ=
Received: from krzk-bin.. ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id y12-20020a056000108c00b0033b40a3f92asm6111024wrw.25.2024.02.12.00.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 00:34:32 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 3/3] dt-bindings: auxdisplay: hit,hd44780: use defines for GPIO flags
Date: Mon, 12 Feb 2024 09:34:26 +0100
Message-Id: <20240212083426.26757-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve example DTS readability by using known defines for GPIO flags.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/auxdisplay/hit,hd44780.yaml         | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
index 1c7fd29bbcc7..869ae0f6cf5d 100644
--- a/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
+++ b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
@@ -104,12 +104,12 @@ examples:
         compatible = "hit,hd44780";
         display-height-chars = <2>;
         display-width-chars = <16>;
-        data-gpios = <&pcf8574 4 0>,
-                     <&pcf8574 5 0>,
-                     <&pcf8574 6 0>,
-                     <&pcf8574 7 0>;
-        enable-gpios = <&pcf8574 2 0>;
-        rs-gpios = <&pcf8574 0 0>;
-        rw-gpios = <&pcf8574 1 0>;
-        backlight-gpios = <&pcf8574 3 0>;
+        data-gpios = <&pcf8574 4 GPIO_ACTIVE_HIGH>,
+                     <&pcf8574 5 GPIO_ACTIVE_HIGH>,
+                     <&pcf8574 6 GPIO_ACTIVE_HIGH>,
+                     <&pcf8574 7 GPIO_ACTIVE_HIGH>;
+        enable-gpios = <&pcf8574 2 GPIO_ACTIVE_HIGH>;
+        rs-gpios = <&pcf8574 0 GPIO_ACTIVE_HIGH>;
+        rw-gpios = <&pcf8574 1 GPIO_ACTIVE_HIGH>;
+        backlight-gpios = <&pcf8574 3 GPIO_ACTIVE_HIGH>;
     };
-- 
2.34.1


