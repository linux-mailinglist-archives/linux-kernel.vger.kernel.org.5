Return-Path: <linux-kernel+bounces-36875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B088683A7FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7F8295879
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A834879E;
	Wed, 24 Jan 2024 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Z9r59h8G"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BE83B19D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096033; cv=none; b=sitSTo2LcNhyQwASBPGrogM8j6ZKIj0sGiYf4EBLnnrc6OY5hIcYq9VBxVWC2fNC6EJJajqJ2cl2bR1NRh0RX3X1keBhu9V/N34b4KBgLm2JY6KykZM9OmS/PGm7T5QuhGDIuOcj3OVIdYKIVr6JGfjkxE1cVxRf/m5Qd4pHT3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096033; c=relaxed/simple;
	bh=dsaLXM6d6VoM5fds1fg66U6p8ESQSb1n2t/G/QC0das=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvOiKT4Dl/w5Vdjt6x4aA4cLT87JvQYpLd2b5qXpgbhpnXq1TZSK3jVoonnu6S1HTWw0R9T9+tjp9OhcUl3yG4LWcjD+NMYILrZlTHLNxbsNUztkuIfaY8kRHzSLogngUbqtE148H4N8ntoXPKTWKjVDrreck7jdv/yEv1cFqDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Z9r59h8G; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so66996895e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1706096030; x=1706700830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOQZaSpXnX8V6pHXUpEolZJOMPm1LbqrSXgyPId9gEI=;
        b=Z9r59h8Ga+z9CDZbjQBV7X95CDbpZ7dMcIwH+BsRYMI8jCkIZWHFvQMAZ5QgdUbWYJ
         1bc45sRoQsi+c+dAwSv91ue7TOZMPEgnIo54FVoi3GYb7J33slSF+ZEtzatrVG05ay3R
         Rnne3b8bkspZGItsHuz1+pAdm9xBVwdQmjMbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706096030; x=1706700830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOQZaSpXnX8V6pHXUpEolZJOMPm1LbqrSXgyPId9gEI=;
        b=LvRmwi+SVNd/FFQNKBbWqooAmeb2ChoQwMR1r3W54oP0O/hO1S4POVAqbpscbL2uS0
         52lJYIvXdq36Tdw1LSF7ue1w2GC7DVLpXHI9Rlqi2uc2XJvK8P9u672l2t9reA1zFy3X
         0P2UcpuzUSEOR+ywGAfQqQxCGzxzf4t8DFClc8Xvrdr1R9xvemV6pJeY3Dk+9kgVuZpl
         10qFfKrv+n6ZP+ltkUDqBdL9A/Jm5ePZ2ESIRTfyA6dfF+UC6WOT0Lu+Ha5kAg6b4k5q
         MFhmhTxJkqH+OW2NI8CiSjfgu2CmfxPofqr8VWA2GAuwR2S2EM/E2/1C2lEU2C9cPTFR
         sfLw==
X-Gm-Message-State: AOJu0YwBWx22BFvixQxSk3uLzjjXLK/XyyYiQzJDOmeXqUt8aZYo6e6w
	cUGCRUbcW8rw1Dy9Uq8PwjbXWl3xUpKphmonELDODmh0tDdAtHz/7psO+YY8QRNmp6GMk0k9KrJ
	+
X-Google-Smtp-Source: AGHT+IEc2/t24TiypZzLOtZozXe9B31TgvFV2ZIB41NCVDDfBJgbU2Gbg0Bp9YpYhOwZIUcySoBkeQ==
X-Received: by 2002:a05:600c:22cf:b0:40d:6c97:edde with SMTP id 15-20020a05600c22cf00b0040d6c97eddemr1061615wmg.156.1706096029843;
        Wed, 24 Jan 2024 03:33:49 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.. (mob-5-90-60-192.net.vodafone.it. [5.90.60.192])
        by smtp.gmail.com with ESMTPSA id i18-20020adffdd2000000b003393249d5dbsm8447950wrs.4.2024.01.24.03.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 03:33:49 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Lee Jones <lee@kernel.org>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sean Nyekjaer <sean@geanix.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v9 5/5] ARM: dts: add stm32f769-disco-mb1166-reva09
Date: Wed, 24 Jan 2024 12:33:14 +0100
Message-ID: <20240124113336.658198-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124113336.658198-1-dario.binacchi@amarulasolutions.com>
References: <20240124113336.658198-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported in the section 8.3 (i. e. Board revision history) of document
UM2033 (i. e. Discovery kit with STM32F769NI MCU) these are the changes
related to the board revision addressed by the patch:
- Board MB1166 revision A-09:
  - LCD FRIDA FRD397B25009-D-CTK replaced by FRIDA FRD400B25025-A-CTK

The patch adds the DTS support for the new display which belongs to the
the Novatek NT35510-based panel family.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

---

Changes in v9:
- Change commit message
- Rename stm32f769-disco-mb1225-revb03-mb1166-reva09 to
  stm32f769-disco-mb1166-reva09

Changes in v8:
- Add Reviewed-by tag of Linus Walleij
- Add Reviewed-by tag of Raphael Gallais-Pou

Changes in v7:
- Replace .dts with .dtb in the Makefile

Changes in v6:
- Drop patches
  - [5/8] dt-bindings: nt35510: add compatible for FRIDA FRD400B25025-A-CTK
  - [7/8] drm/panel: nt35510: move hardwired parameters to configuration
  - [8/8] drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK
  because applied by the maintainer Linus Walleij

Changes in v5:
- Replace GPIOD_ASIS with GPIOD_OUT_HIGH in the call to devm_gpiod_get_optional().

Changes in v2:
- Change the status of panel_backlight node to "disabled"
- Delete backlight property from panel0 node.
- Re-write the patch [8/8] "drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK"
  in the same style as the original driver.

 arch/arm/boot/dts/st/Makefile                  |  1 +
 .../dts/st/stm32f769-disco-mb1166-reva09.dts   | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 arch/arm/boot/dts/st/stm32f769-disco-mb1166-reva09.dts

diff --git a/arch/arm/boot/dts/st/Makefile b/arch/arm/boot/dts/st/Makefile
index 7892ad69b441..9fedd6776208 100644
--- a/arch/arm/boot/dts/st/Makefile
+++ b/arch/arm/boot/dts/st/Makefile
@@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32f469-disco.dtb \
 	stm32f746-disco.dtb \
 	stm32f769-disco.dtb \
+	stm32f769-disco-mb1166-reva09.dtb \
 	stm32429i-eval.dtb \
 	stm32746g-eval.dtb \
 	stm32h743i-eval.dtb \
diff --git a/arch/arm/boot/dts/st/stm32f769-disco-mb1166-reva09.dts b/arch/arm/boot/dts/st/stm32f769-disco-mb1166-reva09.dts
new file mode 100644
index 000000000000..014cac192375
--- /dev/null
+++ b/arch/arm/boot/dts/st/stm32f769-disco-mb1166-reva09.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+#include "stm32f769-disco.dts"
+
+&panel_backlight {
+	status = "disabled";
+};
+
+&panel0 {
+	compatible = "frida,frd400b25025", "novatek,nt35510";
+	vddi-supply = <&vcc_3v3>;
+	vdd-supply = <&vcc_3v3>;
+	/delete-property/backlight;
+	/delete-property/power-supply;
+};
-- 
2.43.0


