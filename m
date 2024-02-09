Return-Path: <linux-kernel+bounces-59123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8E584F193
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B8FFB251C6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACFB664AB;
	Fri,  9 Feb 2024 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X29U9gWW"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579B42EB14;
	Fri,  9 Feb 2024 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468419; cv=none; b=kiuD0ce4D4C5RQW2n5hD4gb7qnRrZw8C2nzfQWsCbw8wHc+KVrx1e90Cm3D/giIam9i+DX7s5AFwv4M9Bpm+tu4bA4909/Ru+u5GLclHHbWq/gnLto4n+sAEN8Wi0/9HeIuKbXlYCwjl4lk5958C1vL2lpWJ91slohmX8/e+75Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468419; c=relaxed/simple;
	bh=t0Yp1kY6qtM37V8D5tGl8e+xZzRSxjruApL0YIVR4Cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ivat/Uq+yN7HlKrYKnELoOW7jYZX7sXHx9Uqh529HQdJB2ZcGjS54oe3kHY5U+7tKOzJmwBDqfN1a2DAfJMcJYF280MRjWxyMNIo0Lr8mWnD8GjPbjnZJGZLYhB1Xokc7EpC3xtM842zsA5gp2FwqPnoLcRia3xQw9A2bw8Lqhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X29U9gWW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-410475afeddso5600925e9.2;
        Fri, 09 Feb 2024 00:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707468415; x=1708073215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZwRK1DevWHs7TSy/8l1VCGmE7RT9MSmuvvOPNO04ZE=;
        b=X29U9gWWLn2orGThnWfo+UrF6OMVffIXUBvkC/UGiwxKavmej+ris6RrYMxbiq9BAM
         65BnwveUQqcpMFBp6FFM9UagPS/fOOKg1g8dhjVS48la5qX0GrACqZwcDst5mDv/i+as
         x7XNzSyF+iGKqmhlpDfehnh2vhMV2iqOl2HWM+t4BQiBD1oZyo7a+GlB660s/jwHwIeo
         ++1YXzoQn3hnun7LBQ+B3kXPB8meCyAWxhzE1P/GFgkWWnNmzdh0fTLLxBChWB8oNpAr
         z/CiDokxez3vBo0dax9m105bKKMOM/OljIv2AXKLopDP4mvc9/+WxpRLp6IEsILlxcAi
         7SGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707468415; x=1708073215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZwRK1DevWHs7TSy/8l1VCGmE7RT9MSmuvvOPNO04ZE=;
        b=sHv/67BQkFe9i+6gmbe7kKX3icb1lN3urtOOgUC4nt9VlXL4Ma3c6gZO0AQ5+15xQW
         g4q2e7UtuYp+ZpsfwT4WAq5b94GjzxBDRsAgWazvAbap3QYgI8vPKKw2QxEPlAzmot2t
         rs9kyP5JgjyIflulO+qBLUVxT4/BUoEUZig3TZQfSDd7GGXWUkaqKAysUnF1ktERb2aE
         hnRsTnOJ5oWsqVg/7f7tNX/F8wCH+zvbLMoK6j9o/YjNowY0e9/izBzuFF1rLhtw7BZn
         F8G9zHs3OvEmN4s7kdV6wiisMyZStHd6wDnIJdRWpRkLx10Ky9WD0j+lqtlaq9Trqakq
         X/DQ==
X-Gm-Message-State: AOJu0YzT/8T/UywGe7tLu45ICvQX6ZA3dlmaMvc5mrBapeWdVaIiIt5t
	A7mCQZwGlHvwkwlC0bgMHjHlgtdv8yUZp0A8tsD02nglD52PcJQe
X-Google-Smtp-Source: AGHT+IG6ikGOM0+y1lKrtnzXUToQ3aaz7wu2SFc4d/jW8z2QjNHbwXPT9alpt+r7RAQlQ4i/3SKawQ==
X-Received: by 2002:a5d:5228:0:b0:33b:3b89:8d14 with SMTP id i8-20020a5d5228000000b0033b3b898d14mr581050wra.25.1707468415289;
        Fri, 09 Feb 2024 00:46:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXxTSxu/ibSAf6MK8BKw2R4lYZ3VbtkfpeAI+hSXAARmY98rCaubF3pJN7kgShEFp2iEZ4ENk/IpO0PnMQsTHy0vhcGuxX+rcQrtjav2h3a3yOrPfnSkmbzIJIijatZkq95L4I26q/evTKtCGQximYErEbbzXa+tcSr9y1MKBwGC6/hOS16LcAH8ZWspvnX9ANg0MiX7KuOR83BzttLzlECiY5xuDmuvqkUc+KcsgyLJLUqddN0Bol5E35XOPPCM17pfo6e6UkgOqkUYhMJ0IxwPJxTS0fHQUe1hQ7mhiiLFAPQ1qMK5yN1OL1F16vwIqdnTexgdZt0flYYOyM3w2rgekbgRyJ2+HCjSopLOSc3ZzQxAZYOMhj9BQ54xEniJyRtoh2OPpwNrcKJGvYFLkQrMEfTAO3XbcJikaDP4CP90HZavXlBL7yjNORIQonJj7uJhUVL2RzEhvr2Xwnl7emCdmuMFpkapg1tG1S5sE1djmIFUUURshF3KSbhyUMYXrHMjAomPkvUifTImH2fSGUlCSCNfMItCc3tvf7arqCicvlCieTZYoihn+Kd8OuQq8jEka5Z14WSgu5qVFBlR+vbXkHfYk=
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:765:2268:762e:2748])
        by smtp.gmail.com with ESMTPSA id y6-20020adfee06000000b0033b3cf1ff09sm1236689wrn.29.2024.02.09.00.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 00:46:55 -0800 (PST)
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
Subject: [PATCH v3 1/2] dt-bindings: input: atmel,maxtouch: add poweroff-sleep property
Date: Fri,  9 Feb 2024 09:45:42 +0100
Message-Id: <20240209084543.14726-2-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240209084543.14726-1-eichest@gmail.com>
References: <20240209084543.14726-1-eichest@gmail.com>
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


