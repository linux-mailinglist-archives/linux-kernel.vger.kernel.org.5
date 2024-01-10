Return-Path: <linux-kernel+bounces-21816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2FE8294C3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2C61C25B50
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E133EA7D;
	Wed, 10 Jan 2024 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Vmvsmk8c"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250F83D967
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28f66dc7ffso855896766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 00:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704874068; x=1705478868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmQnQzOW0HVCglZmRdERbSkiK/7LfpA/GFNr/QR6hMQ=;
        b=Vmvsmk8ca33uolsoF9eBwwNRGsxYH4reah+ZBTOGCY0iHhgT05BQelzkQ63AFx87xq
         QqftPj8OgFwS3WnW9gXwTzHCVe0eCC+aGiCGZFPaG4Mo6VSGH5MaP4y4ca4NyxeD0whp
         2oR4EvQYbQl9GBKinpmrjD2Vav2VkXDbTUUIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704874068; x=1705478868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmQnQzOW0HVCglZmRdERbSkiK/7LfpA/GFNr/QR6hMQ=;
        b=ARe69cjIqGhVBDY46q1j/39YvIQO5JvpCtpiMh5yqIkeTdASqpim0Fn5jEZlvjOAPA
         G4sqlExifUdh4DixULFNA/NVPRgZ67EP9D/CPHjOaXPd7j/jNyMFjfqEQOsQyEgds0fe
         BiCF5GPkYUSu0R8ONPqrHxD2rMRPOJvVGQMDb6DdbgbQ8CDC7YFZVz5TGtwls43qL7SA
         EJlWSIUIHbg+2jarA9E6dhPOl8W8kzd3uAz7lVT9xrjlFxuDWzA7+9GROpENiPAsJMcw
         gsPRCaqgLS3hzlfBJNyFTgBQLEJUFnZws8RRJwsv+jZYTVuQ/McTTUl/l8quz0deBw9m
         vzhA==
X-Gm-Message-State: AOJu0YwICyjDIwSUE3vQVlfqXgmOA2aws+I1uSD9giIz1fsW/Bsz4DrE
	kD7/8GxYgf5btyFPS9OLop45FKA7XD1jLXdl+O0jUFK/GdY=
X-Google-Smtp-Source: AGHT+IHakONTvxlOlGWYkwBCq3122M58Sq1eIRqDaFbZ4S8+1qtPJZCssB1FfT53d7/wvY8lO2dxGA==
X-Received: by 2002:a17:906:c346:b0:a28:b34d:8694 with SMTP id ci6-20020a170906c34600b00a28b34d8694mr684643ejb.62.1704874068185;
        Wed, 10 Jan 2024 00:07:48 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-2-38-81.retail.telecomitalia.it. [87.2.38.81])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709061dcc00b00a2af672cdd8sm1833341ejh.161.2024.01.10.00.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 00:07:47 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v6 2/5] ARM: dts: stm32: add DSI support on stm32f769
Date: Wed, 10 Jan 2024 09:05:48 +0100
Message-ID: <20240110080729.3238251-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110080729.3238251-1-dario.binacchi@amarulasolutions.com>
References: <20240110080729.3238251-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v1)

 arch/arm/boot/dts/st/stm32f769.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 arch/arm/boot/dts/st/stm32f769.dtsi

diff --git a/arch/arm/boot/dts/st/stm32f769.dtsi b/arch/arm/boot/dts/st/stm32f769.dtsi
new file mode 100644
index 000000000000..e09184f7079c
--- /dev/null
+++ b/arch/arm/boot/dts/st/stm32f769.dtsi
@@ -0,0 +1,21 @@
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
+			interrupts = <98>;
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


