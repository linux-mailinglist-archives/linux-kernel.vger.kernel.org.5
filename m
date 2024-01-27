Return-Path: <linux-kernel+bounces-41246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F1583EDF4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2CCCB20F47
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762EB2C1B1;
	Sat, 27 Jan 2024 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Q9vqVDeD"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E4328E23
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706369342; cv=none; b=qSCxPv7Is4Sb7P6bZ4rBTxBXzw1+g+pheda/hLYbhjTZ/JSWykMQP3JcHVWzNgGoP7LlJHI4WywXJhhiPV9ur3tVLJ01X+JZ9ok2oMTIQ7aJ9uS36jwwzL9GB3EYTEZ1IYV2P1mPedxZ6vglRr343fltY1KGnqec73cUMl5yfVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706369342; c=relaxed/simple;
	bh=BNljMDJC9qq78LNjNNRvP7DZ6KpCM61Cbml959I/oI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQEdHFKpIZnQfGlFf06HBC3oaJvn7L4RVCABLFn3gNF6C8y7VAp/x8PSoNuwH3T3oisGn8ZEi4iGQluguU8Mjxl492FlyJqERffE1PdkRCOsxZyztGblKfKQ3v9ANmVoPCGma1gXdru0EVy7kcv1VfIrPEdJONk/hqx51yGPMUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Q9vqVDeD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40eac352733so22822315e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 07:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1706369339; x=1706974139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWGir7ANRRzan3PNYs2175lzxrtc4JGbJP3xn7orKtg=;
        b=Q9vqVDeD3Tkvp9Dv3APsu7MDlFKkNXVQc4tV5NlmsjZSnzEinxnKv+yxbPL69ucIFa
         g8DijGIMTTzckVjZ1qzdsCaOitrm23h2lHqFB+3nKRoYpzy5C1f+LphIo77epfqbYiNj
         i6Wrs9xB/dNcz/OaBa7it2FhSH8F1mbICo+60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706369339; x=1706974139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWGir7ANRRzan3PNYs2175lzxrtc4JGbJP3xn7orKtg=;
        b=OmaoV02d42CPf7kFn5ZK2NNb5GpmIfi64Hl/mj7kVfFTIJdDl7ayX4IFnxpaWuv3ar
         M3zEd6iEypq5zYfqzONNWBfVR9qu/RXUvXOHj9aEJ8E/hmYHOr+bPyH/TIWrVzb5r5IT
         AFsCmzzpBve5bNzoci9uG9/43hqkIiDQqOfc5RD8xpVdFMeSPDlmqYZuI+uR9dE+OQjD
         5eigl+l/zm41OeCD3NxhiNOfToADLHxSFcf5tu3kgLt98S4txmb1TTE0vpB6XCG7lQ2x
         hBM/MK8Rga/cbMqvzzKLevuaIFlRURT6M+Qc35bZSBN/nW1nXLtLqiCMkb9GbI9gJP1r
         4Izg==
X-Gm-Message-State: AOJu0YySzTZRJZ5TJYRrUUoGu2XIbIVedD27dvGNF47Sx6ZbTE4zAIUL
	V9ij9hSzOs9jMW879hEUIMquJwEsY8iq+79PfCXQq6X5PByuPpslxWLwRVowYzwSvgWYRwfmI91
	P
X-Google-Smtp-Source: AGHT+IFC372BKheBeXMj863trBVVfHb/6SG4pMxYK1ABLSugVKm+fNOV5q7r0Ots4+TbgYP++AxqIQ==
X-Received: by 2002:adf:f1cf:0:b0:337:c845:aae9 with SMTP id z15-20020adff1cf000000b00337c845aae9mr1143677wro.62.1706369338825;
        Sat, 27 Jan 2024 07:28:58 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-21-103-141.retail.telecomitalia.it. [79.21.103.141])
        by smtp.gmail.com with ESMTPSA id l5-20020a056402344500b0055974a2a2d4sm1745220edc.39.2024.01.27.07.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 07:28:58 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Lee Jones <lee@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v10 2/5] ARM: dts: stm32: add DSI support on stm32f769
Date: Sat, 27 Jan 2024 16:28:46 +0100
Message-ID: <20240127152853.65937-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127152853.65937-1-dario.binacchi@amarulasolutions.com>
References: <20240127152853.65937-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for MIPI DSI Host controller. Since MIPI DSI is not
available on stm32f746, the patch adds the "stm32f769.dtsi" file
containing the dsi node inside.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v9)

Changes in v9:
- Drop 'interrupts' property to fix yaml checks

 arch/arm/boot/dts/st/stm32f769.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 arch/arm/boot/dts/st/stm32f769.dtsi

diff --git a/arch/arm/boot/dts/st/stm32f769.dtsi b/arch/arm/boot/dts/st/stm32f769.dtsi
new file mode 100644
index 000000000000..4e7d9032149c
--- /dev/null
+++ b/arch/arm/boot/dts/st/stm32f769.dtsi
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+#include "stm32f746.dtsi"
+
+/ {
+	soc {
+		dsi: dsi@40016c00 {
+			compatible = "st,stm32-dsi";
+			reg = <0x40016c00 0x800>;
+			clocks = <&rcc 1 CLK_F769_DSI>, <&clk_hse>;
+			clock-names = "pclk", "ref";
+			resets = <&rcc STM32F7_APB2_RESET(DSI)>;
+			reset-names = "apb";
+			status = "disabled";
+		};
+	};
+};
-- 
2.43.0


