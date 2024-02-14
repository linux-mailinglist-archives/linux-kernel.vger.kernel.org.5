Return-Path: <linux-kernel+bounces-65465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC84A854D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F11B2643D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1E05F865;
	Wed, 14 Feb 2024 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VoaW9A8K"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69DD5D910
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926096; cv=none; b=pv7DToOTtLHh2+/EifG3OK+q2wPkK/yv+gdT0HYN5UCYnpwwg9sk8W1nDag0aFp0hcHa29hrnSr6vG9HzDnLo3iojn0nX+6gukz2TCZ7DBZB8jeEfRmGh/AmkfGegVZIIqDJkDoXUvnk+RirxahrhxH/30dY/VjDPIhDNmpCZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926096; c=relaxed/simple;
	bh=RjcmJ1gtFBwueafmepL5eB2KnvoD8u/S+qST208fcb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PG/MP03ljuLuGKS8M4q2tw1pR6GFF6RhQLNT8K2koFjsclVBpNn1y2u/E6PXYNjVBl7wdxOHzfMRxfuMzBju+BNKGLsB6XLnI/kVG8s+Wvlrwy3m6I6d9IE/UaDUU4mZ20F59lZkxnPDQVAF58Ssub2F3wY1+4czsGnHlxAzPh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VoaW9A8K; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5620f15c3e5so1952969a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 07:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707926093; x=1708530893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CNcwNle4UYKgFa0WYPpjXQkq/UHsVG8FTTKT9Pm9pw=;
        b=VoaW9A8KRuOUCwuqTJ3hpVm8yUf0Y7wr1mTmpyqMbMzRcnY5g4HKN0a7dvpT7n9hhM
         oAnHoSP3MHh5z8rtujc53IHppzzR86qpyv52tvEoigC6CEIbWNIZzArJC4HVHweYf/2Z
         9oGC5qaXaI3PD4J91vRxS3Mc+hUMLpT9vBng5u9bvLUEW9xqRGmSQtVdGOQWFiuUjOLH
         leSrV9s9ngLPXl4zkp7lczAKs6fcvAf79QxHU4YQKaO7c9FIntSMJqRWkOFXyJ08lFVl
         0lgl77wldIVbwx4tiFSVIY5Y0yhn91/yWVHIYhhi+6Xh/EVJPO9c8agWpE1M0Gzkk2//
         iR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707926093; x=1708530893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CNcwNle4UYKgFa0WYPpjXQkq/UHsVG8FTTKT9Pm9pw=;
        b=FAKlxs2bYKR5woEXzUvTWj+2/9vozvFPrLWjuRGjJQ6+DkMs2nVZZDeC0H7Tcdj8q2
         IXqgs3ihiN9cJ9kSxaoldZjtu7YPFbnlnC5sajTfDxSnFKBq/ErFI26DQtomIxA5Hnpp
         ecTzpvsoZWJlNMCo2PvvzyIGlgiyfB42O/CWIW6nTKPRCqYk/D/FzUk9Glh6lDIxYRYE
         2KrzJxZQlQ49LG1RDdQDbdZXNoTVRFacOdlaow2/V05BrZtyH8iM2tVgO2QiVEzT7rna
         AXysFVzT/hqegC13flkW8exjg89i6LzW0wmisR7Eqe4nLF7hYbVFTMN5IrmBEQeh48yK
         bPug==
X-Forwarded-Encrypted: i=1; AJvYcCXNgpnEmsY0m+/iEt8eslQ+YB3XDqO2I7nWLWLmdS2bWb13u+7n+mOwTJBR++DXoh0DjwJ8tqxc7Bimxp44GZpYaBXZm9VMp6MR0hHG
X-Gm-Message-State: AOJu0Yw6vuIKzNaER9XeBiG/Kvib/vzEgbyYV087LAVm0HG005zOeVEl
	s04RehON8E6mifqZya+kyVlrEiTauEWJw43/O1d7Lj5FSkKhdNvpDT9EN4m4pEA=
X-Google-Smtp-Source: AGHT+IGCX7VWtHcvocr9D1LSJYAAIIZpWbFoN8ZtrgKxnkmbTSIbJoUMp2I5qHo0SUqLg4lKWWH0SA==
X-Received: by 2002:a17:906:f851:b0:a3d:303d:c6c1 with SMTP id ks17-20020a170906f85100b00a3d303dc6c1mr2110897ejb.62.1707926092979;
        Wed, 14 Feb 2024 07:54:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXTLMPJkqU+hvLTZTGoGdsmX+MhjOWm/jj8EcBDIUF8FHE6mDlweGOARuz/QvAFxn4tv6Cln/5v2wI1CkdcPn1/2qrGGLI6MXknF4K6NTGyghLc6DFiUl8VwRG7tSLqN+vIIcGQA++j+U0aM7XxsGBEBgCoRjXKUYrCJOIqYI+o0JFhA/1F8NhxAPo/lxwml2rmIb0Qcbb0rS4nw0mbyzqKhB4DsogUZyS3KO6SACrKijel2CKM3zSrFRVKHqIUJ0CeVbGUdnn8mOAZLRJVubcAHUo9HKcb5Bnvcg6qyhSOBwah5TljpC+khzCYrQWYDxUeEcXGSqOLra8C/8yXA45F73NGzX9OuMBD0AoXXl/2QRI4gU7uJsJKDBOphLsWbBJTwVvvskGRvX4=
Received: from krzk-bin.. ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id tk6-20020a170907c28600b00a38936aa08dsm2431332ejc.32.2024.02.14.07.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:54:52 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v2 2/2] dt-bindings: auxdisplay: hit,hd44780: use defines for GPIO flags
Date: Wed, 14 Feb 2024 16:54:38 +0100
Message-Id: <20240214155438.155139-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214155438.155139-1-krzysztof.kozlowski@linaro.org>
References: <20240214155438.155139-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve example DTS readability by using known defines for GPIO flags.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v2:
1. None
---
 .../bindings/auxdisplay/hit,hd44780.yaml         | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
index e26d61af9011..3ca0e9863d83 100644
--- a/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
+++ b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
@@ -116,12 +116,12 @@ examples:
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


