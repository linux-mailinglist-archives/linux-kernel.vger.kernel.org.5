Return-Path: <linux-kernel+bounces-24764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC3382C215
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE6F1F2536D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371366E2BA;
	Fri, 12 Jan 2024 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IAyPh8XH"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F04F6DD19
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50edf4f478eso2860706e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 06:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1705070949; x=1705675749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBytSUC/4Scw/6M7MDSEKF2OisRATxG4/2WDOpsmueA=;
        b=IAyPh8XH29doz03CWnm90tk/0fkCsc9S6BrGPCKLLkSSETxLSl/NrfboTqCddcI5JG
         9TcXDl8MyiGhTLao0Bo4UL7rZ2GOWbvdohe6BOxvIJChSEEsINgQbJd2t6HeNcnPx2wb
         PhaBfcKYjTMefg/FhKRPFhhj+1lvhEts1jpfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705070949; x=1705675749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBytSUC/4Scw/6M7MDSEKF2OisRATxG4/2WDOpsmueA=;
        b=V2wXBHysHbINKLkJ4IZzxRfs2ltN5T0SruTtqil1TFqhMiMpe0t4927jqMuMYWYgs6
         8iLpZPsFMPDCC/QjG4pUVGb4TkFy+6Yzztnf7/ndJaozH4mwE8t7ilu9TAc81Sd6jBFK
         ZDs74D8v3ntmh8P5poak8AwnmOS+EulnCIyI3aErm66BW+t8xwog+X9hfO/9BUc/4qTe
         t4nvQEX4VQ5wRSdtoxmy/T7fK93H1g4qnrla29agMA87Q8hQjGzzx2l/siSs7Wi7UimO
         P/XOcR9cQ2ZypKOybBWL4BABq7RdvJjLO84oa55aWypIgLK7q3ZaOayiys70TtqLvaeJ
         Q0EQ==
X-Gm-Message-State: AOJu0YwE7klnODUICROSYshM5nUIYqpH7/QBLgp2eExaObHnmp2nn0bD
	z9Ym2DHNGKhlHwZ3BW0JGcGWPMTW7nqFuybrotliFNg5my4=
X-Google-Smtp-Source: AGHT+IHvD0o4uSsKQg/JFN33shK9eCTUk71p6NdviePAGeTDnD9r/WlHm8g9/EXSqnfgkxKsztjN4Q==
X-Received: by 2002:ac2:4a7c:0:b0:50e:76d1:f02b with SMTP id q28-20020ac24a7c000000b0050e76d1f02bmr688423lfp.39.1705070948808;
        Fri, 12 Jan 2024 06:49:08 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it ([95.236.91.90])
        by smtp.gmail.com with ESMTPSA id y11-20020a170906524b00b00a233515c39esm1869372ejm.67.2024.01.12.06.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 06:49:08 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Lee Jones <lee@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v8 1/5] dt-bindings: mfd: stm32f7: Add binding definition for DSI
Date: Fri, 12 Jan 2024 15:48:21 +0100
Message-ID: <20240112144902.40044-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112144902.40044-1-dario.binacchi@amarulasolutions.com>
References: <20240112144902.40044-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding definition for MIPI DSI Host controller.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Lee Jones <lee@kernel.org>
Reviewed-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

---

Changes in v8:
- Add Acked-by tag of Lee Jones
- Add Reviewed-by tag of Raphael Gallais-Pou

Changes in v2:
- Add Acked-by tag of Conor Dooley

 include/dt-bindings/mfd/stm32f7-rcc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/mfd/stm32f7-rcc.h b/include/dt-bindings/mfd/stm32f7-rcc.h
index 8d73a9c51e2b..a4e4f9271395 100644
--- a/include/dt-bindings/mfd/stm32f7-rcc.h
+++ b/include/dt-bindings/mfd/stm32f7-rcc.h
@@ -108,6 +108,7 @@
 #define STM32F7_RCC_APB2_SAI1		22
 #define STM32F7_RCC_APB2_SAI2		23
 #define STM32F7_RCC_APB2_LTDC		26
+#define STM32F7_RCC_APB2_DSI		27
 
 #define STM32F7_APB2_RESET(bit)	(STM32F7_RCC_APB2_##bit + (0x24 * 8))
 #define STM32F7_APB2_CLOCK(bit)	(STM32F7_RCC_APB2_##bit + 0xA0)
-- 
2.43.0


