Return-Path: <linux-kernel+bounces-36871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8138B83A7F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212971F234B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E963E1B7E5;
	Wed, 24 Jan 2024 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mX5yaz8I"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42C21AAB1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096026; cv=none; b=pQYDse0fEC1r1olDauJXv8HYcAipIv54ddxdDAwoYCJ8Q97UBUHV1ViIAfo7SR5Ip0tPDLrUtejrP0yagjTpNqnkVhTz3zaP7R9RSFL2k1z+06bTRgeSbVKLjOkRkZ88U46gslRE9w4TFX6fkqwqqCwQUK8xR/gtfN0Xg2cg2IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096026; c=relaxed/simple;
	bh=mKwz34BORUmdPjSPJxH7WkuOGdXYEYf5RmYQkE+fz3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pns37pvf/JP6ggRZMzIMoZtqjRnoY5DTWteyA1Ln2e+CeOuEnX0I5txVxr9mjUunHW6Oci+w7rjwB7cyEZdsrAHq9UKxFyvlHjZb+8aSjajZBI+XQ0G6WwcFkaKikNTZWcZKAXvjlfdET/QSw/aXibxQ3ppFnHHJOP670Ktx/k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=mX5yaz8I; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e80046264so67207985e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1706096023; x=1706700823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a87Eb/9UHW4xhpeCgDcrODCTwbLMJ8A3Dzblk+B1akM=;
        b=mX5yaz8I5UCYa/98Z7sOYCmXg/GxuXTKwIrMVDOgFGQIpdz4ne8b4dE4LUUisEZDav
         Bxzg/Lj8PtkXdwodRn2eVJ6p6yFX/MtaixsTZ1lDsmrUDf010Uu5O9LI+B+D6MI8ALLq
         i28YDTcC6XkB7Zjl3O4qS2BK7cS25+OPYUWNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706096023; x=1706700823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a87Eb/9UHW4xhpeCgDcrODCTwbLMJ8A3Dzblk+B1akM=;
        b=B1ADq5pfcUIsKE7f0MjSYJvFR/G85VzfX5YGkqtH9uGEXDJ9NN6dJH5gHMEbuvPEyG
         h3pTIrtj4pwOGxucHZ3s09xS2RR5Y4NhC/DM0jOxqF/L3FlGUMeM5rfXK/Y6Sg4E2Irn
         q3YDMNkTM5Z3+R88NbfYZvARIIFL8IVqByhFECG/3mM5cHMV0ZP/E5KRfWbyz1vC4Z+M
         wt3qsxjcaIlyFBwq3a29ubUQIQ5ahhkw0KF4ViZsqhpiRGMko/cLcGq5QCGEs2VTGEue
         FKJs15RP8EpNZPMkGxjzLzZ3WO/XnfU2uJQ385uK4Lq+Ij5VMYbHx2AfZ9JWRbUFfnlc
         RDEA==
X-Gm-Message-State: AOJu0YwPW0AsbakaNhFJ8ef9uUgLJQCWqDGYrVr1qWOyuumuPCyXGkx/
	6DxgRDESTX5Oh8arLLjitS5ZHvA4PVFG9gMIguvt/cxIFewWzEswwJyeJDHAHNP6nKZfEmQcxN2
	L
X-Google-Smtp-Source: AGHT+IHhC7Xk71DCFuIqvgcVaL/Kb8lFavZF3/EWWYo8FxE3kkEBMz4MmfbX/pgqHTKlP0HESOFPUA==
X-Received: by 2002:a05:600c:300c:b0:40e:66cf:4d96 with SMTP id j12-20020a05600c300c00b0040e66cf4d96mr1225243wmh.130.1706096022667;
        Wed, 24 Jan 2024 03:33:42 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.. (mob-5-90-60-192.net.vodafone.it. [5.90.60.192])
        by smtp.gmail.com with ESMTPSA id i18-20020adffdd2000000b003393249d5dbsm8447950wrs.4.2024.01.24.03.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 03:33:42 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Lee Jones <lee@kernel.org>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
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
Subject: [PATCH v9 1/5] dt-bindings: mfd: stm32f7: Add binding definition for DSI
Date: Wed, 24 Jan 2024 12:33:10 +0100
Message-ID: <20240124113336.658198-2-dario.binacchi@amarulasolutions.com>
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


