Return-Path: <linux-kernel+bounces-21815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5775E8294C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075A92883D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2111C3E472;
	Wed, 10 Jan 2024 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kxl4oAX/"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3303C47B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2b6593ae10so144562766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 00:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704874067; x=1705478867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZHp7o9P6sSCcRzfgnf9GmPoPPKRvORDv/jTzo46w2U=;
        b=kxl4oAX/0k/qGIPkIPKRORgTGkjwdaQMjKFzGebEGy0uOAtKB9jH8m1E1pgihCjniQ
         Z6tTLSFipcvZ1PurYyNBNAkZ9IqKzYeUK2XQX1V/AL22Ojo02cWSu+2xmOsvr70+NwPc
         YKxDnQhrM96j/uQEKU3cTpSI9SmYmec1WETgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704874067; x=1705478867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZHp7o9P6sSCcRzfgnf9GmPoPPKRvORDv/jTzo46w2U=;
        b=r7Ihnz93ifBDBKXhCCLVxUiJMS4YfAQSx/t+Z37lWaxuwI+LsmNXvIr3ZIIT3/fbvT
         KZycajbiToXiYr0Sy2uS63zpzH2WCfxjNiUXafeY48x3gxFwlD9MW443cH+kp7TxZOzK
         VqAFVGKlOgRHIP5qzhg6CJc63Jjd5Rnk0Kkkhz4iYXYesZAG5IYb9dGJZNHEvyl/tPwt
         yNf1nYB8BB/zrTXOYAgJXOEC4gIprj5jQib2yOkrX8NkbjOTbpPY68uf56/lWV1RccfN
         9OoQTAOJOI2VHybaTg609QlqScRoqqCmw1OzYEIhdqr3q87UKHyiO39gsEIJ1M3uadme
         j2nQ==
X-Gm-Message-State: AOJu0YxLrfcYO9bAQwOz599r5nUM7LY/8M0yBQ3r+WPyV/o9xawMaiHM
	NJ9RrJjmQlNgg0BHSX2zXlp/Mtdz1XpfqdNr3jFIYCvdpNo=
X-Google-Smtp-Source: AGHT+IF2mo/XSHzmHfD6hrmUdmCjlqIZ8t+jrt7bNQznSy4JNUxYPWmRI8Z1BhshFIl1WHCrNea2LQ==
X-Received: by 2002:a17:906:1145:b0:a23:6c74:52cd with SMTP id i5-20020a170906114500b00a236c7452cdmr387092eja.3.1704874066963;
        Wed, 10 Jan 2024 00:07:46 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-2-38-81.retail.telecomitalia.it. [87.2.38.81])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709061dcc00b00a2af672cdd8sm1833341ejh.161.2024.01.10.00.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 00:07:46 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v6 1/5] dt-bindings: mfd: stm32f7: Add binding definition for DSI
Date: Wed, 10 Jan 2024 09:05:47 +0100
Message-ID: <20240110080729.3238251-2-dario.binacchi@amarulasolutions.com>
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

Add binding definition for MIPI DSI Host controller.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---

(no changes since v2)

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


