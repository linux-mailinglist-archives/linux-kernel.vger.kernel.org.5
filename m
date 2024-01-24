Return-Path: <linux-kernel+bounces-36872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7C683A7F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530CB1C2298B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1D02BAFB;
	Wed, 24 Jan 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WqeNXJxj"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745901B5A0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096028; cv=none; b=tjn73Z5wOhenVzCt3TJazKq08IfXmZNwE326OrwJA6mFt9YVZ+2lrjlEEvJgq43KxbyQFM/y+ThMCao6r0/Pn7efV8MvVH9HkURNuMnMHwvT6lxUL7kCZpA6He2w+qIOxeoamuo8VSpsTaUy6g+z5ArebIrZwV4DAKRwWSJTgfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096028; c=relaxed/simple;
	bh=TrMz+FVqnEFt15pmSJ7C1EniAx32J0Ey1WSwWETsL6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHnv1+jZdJSfhAVbvjNxmgxcfTXAQCTGHsdMAjlU/DhD7hujRq4QYdTWXIJgRUjRiQbdpnBufvVSxw1ZBH1u/lhKCUAT2o/CP5HlYIu5YP16w3JKLuOf71bYp6bPTJu+W2kBxnjxVEewf3JAg5G1M+jD6eBuHN/Mwp9bLRgJvmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=WqeNXJxj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40eb2f392f0so21444115e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1706096024; x=1706700824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WphLFokV77snya9flF2ShSJ6MCXN7QDFds6UuGxFul8=;
        b=WqeNXJxja0z5oh/jUs2Hjp9qL4BVnyX9PSgwBZ2Ra5iL0Kw7jzYpK2QmwRokwFOSKZ
         EuB3PgEGnNe8yDg4KMdm3X0eI5xOCEl4fsxWD1JcA2K+ip0YXcguV3r3xMGOH8EnudaQ
         ODRpzcz1vC1jggnOAkQ/dfU6v685Nxi/MDjvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706096024; x=1706700824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WphLFokV77snya9flF2ShSJ6MCXN7QDFds6UuGxFul8=;
        b=grFoDvBSZcNzk6pDxuEwNTr3G9f5CwEa01wHpIDMF93CweS1CO1g89VdtKkQFabQW+
         yMOrQRIqIZ0jfd8AgwMCTnljEm4PA/offYbFC5Q33PHfuZD83UUi/Z8fSDsv6w7a4TTs
         a8S7ZC5Ni2LFFY7lJD5YUCuL17BCnA0pp2VLirrotE2O7Uo9WDcxuh12oxZrX+GziA0m
         +TJNj0H7ampT+YWJi/ZUsPoYGUxTD9I4Bx8N0Do6VqXlW4ozhbe1onZeUvIEWdhEILsc
         U3iqYJ3gjUw/4+hA5FJGxXNYTB6iTfgbS1+2RHxg8MPqGUxNuXwNG36rPkrPCfaYvEEI
         CPKQ==
X-Gm-Message-State: AOJu0YzQEDTpgeWSgWACZRFWSJqi+kLgZO0EXl/dC7KzqeGmA/v57OO6
	0Erhd2KSyXajUE3o5/iJrKZIXookJDfJbaXcud3pYL/z6PZlJ2BQJ0+VdJCqk3j1M+Nw28R3vWk
	V
X-Google-Smtp-Source: AGHT+IGOUkv5923WUqPQ5SE+T1OnkUB/eAKV+nDxqcTwfy3veeTmgeesBlzUJorJkQ+SmHn5MBZNWw==
X-Received: by 2002:a05:600c:993:b0:40e:4b49:51ab with SMTP id w19-20020a05600c099300b0040e4b4951abmr1002281wmp.158.1706096024345;
        Wed, 24 Jan 2024 03:33:44 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.. (mob-5-90-60-192.net.vodafone.it. [5.90.60.192])
        by smtp.gmail.com with ESMTPSA id i18-20020adffdd2000000b003393249d5dbsm8447950wrs.4.2024.01.24.03.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 03:33:44 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Lee Jones <lee@kernel.org>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v9 2/5] ARM: dts: stm32: add DSI support on stm32f769
Date: Wed, 24 Jan 2024 12:33:11 +0100
Message-ID: <20240124113336.658198-3-dario.binacchi@amarulasolutions.com>
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

Add support for MIPI DSI Host controller. Since MIPI DSI is not
available on stm32f746, the patch adds the "stm32f769.dtsi" file
containing the dsi node inside.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

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


