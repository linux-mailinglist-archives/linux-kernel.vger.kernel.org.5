Return-Path: <linux-kernel+bounces-41245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE1E83EDF1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AAE1C21468
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E3D29429;
	Sat, 27 Jan 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oN1qDEuG"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A812941C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706369341; cv=none; b=Cq7aDegUUleGGktvBJOxm6jvrrXXSVGZ8PwgXR97a1MA/Q9OwkjYGqLmYH/7I0q7CALmoU/QYBuLVgjVcmsYHvfM1pEEOvTcP5UBDc5ATVJG9EgiewSJEC2p18mX4kQlJcfWXX86SVNlD3je0o2NuSkMkUxvML+J9nFIQQr3dyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706369341; c=relaxed/simple;
	bh=mKwz34BORUmdPjSPJxH7WkuOGdXYEYf5RmYQkE+fz3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuGpRekiQmaqD8NES0cFgkQZl94IOdqV1qqKuksijO8W52QuyM2OsoQsc/PTyl9jDclQxGLF7+aOaz6hh5M20jPzljXSKAKbvGEz+lkYqiiAhUgHJChheGvs+YOZqWdgUWgfbUXXcgmXV3T+Qk76YPBQO/pYDWHN38ftTwYBEZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=oN1qDEuG; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55c33773c0aso995802a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 07:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1706369337; x=1706974137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a87Eb/9UHW4xhpeCgDcrODCTwbLMJ8A3Dzblk+B1akM=;
        b=oN1qDEuG3LoGoHCfOA2weJKTs8ZkI2iw4YMMJH5IejGisBRSwGevOgK3HEd7CAlbeg
         V5TkZzyXdUCM8qHn2DfPEuLyaq+4meyR1a6di0ePQqj0UXBJ8WU6XO7WFC/FfjIFSPW/
         xArv7yEPjBUYotYbexKtQeWmVo6HoJ0pLdHas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706369337; x=1706974137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a87Eb/9UHW4xhpeCgDcrODCTwbLMJ8A3Dzblk+B1akM=;
        b=IEaYu5rsKPEdCxmZjEsKqpRBJqHoT60bwDQ2Sx5YvEzMO1N4tCSfO7G8gQAs7g3QF5
         mzOPZ3b2G8Ec+1HD+2vp5jwpvj3WGUtS1qsD+No74loog3YFZ/e1Gntq9o1JFyB6NuJj
         UF9RfoFG43SLE876DvqMoHiLJinr569fq1V78K2IDuxQqmP/cJjApPSFQpuiBU9QDN5u
         3KI55RXtBhK02J04UZ+3yePpMSO5JpscByVrqhm4v3qVd9eiECwmttocrXfI9IfYv440
         s06kNAodPhOGMpCIZAOQfSVlyqoC2WFzYY5cF73rzgV931/r3/qAVESt4Ss3iSAOb3lB
         Z8/A==
X-Gm-Message-State: AOJu0Yxpg1uHrrHhNGlItvqGtncfquXRnha3IA58lN5Pzm+fiDdD4Y4e
	KVLbgUWXPl6D4xY8Bbszeq1fm6yqBUvfCSRiqKij1A+uyfqoFHYuEW9NXRa38NUi39S9JfR/p08
	o
X-Google-Smtp-Source: AGHT+IFok2DS1I2uZ0WZjZt30o3ToZii3URXONkgx9zDXYEfhMksN5xbCHBviWnSywDeom/HxchUmA==
X-Received: by 2002:a05:6402:26ce:b0:55d:eaaf:847d with SMTP id x14-20020a05640226ce00b0055deaaf847dmr1292495edd.6.1706369337636;
        Sat, 27 Jan 2024 07:28:57 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-21-103-141.retail.telecomitalia.it. [79.21.103.141])
        by smtp.gmail.com with ESMTPSA id l5-20020a056402344500b0055974a2a2d4sm1745220edc.39.2024.01.27.07.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 07:28:57 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Lee Jones <lee@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v10 1/5] dt-bindings: mfd: stm32f7: Add binding definition for DSI
Date: Sat, 27 Jan 2024 16:28:45 +0100
Message-ID: <20240127152853.65937-2-dario.binacchi@amarulasolutions.com>
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

Add binding definition for MIPI DSI Host controller.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Lee Jones <lee@kernel.org>
Reviewed-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

---

(no changes since v8)

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


