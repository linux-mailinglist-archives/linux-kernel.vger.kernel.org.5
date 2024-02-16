Return-Path: <linux-kernel+bounces-69414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADF68588B6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0AF3B26AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9417D14C5A3;
	Fri, 16 Feb 2024 22:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBMVlEig"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9F114A091
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122776; cv=none; b=EdwQZFGVDxSmA70Zi+0085GR+UTKH/DjY4ERHnyFd9940p4e85fnoTn1ZalRcB3akM0Z89XD2TBDjvFXMQRdvLL5tUZxP+2nBqsC8127HyY+nb85g++94/1mNKsqiQc8MqfsHAYmWNEAZBJ62an7PZ+ALWlfEcQdX0vmwwBdVNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122776; c=relaxed/simple;
	bh=5ZoYtRQ2HjiqGEQZUVOcP2ADlsbfU9MvFiIZ1YzKk+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LhJHBQ4Rg1ngJv9OtwUXZZ5LZ7sgjZN+E+VV4A3iLSkXyoj3D0RvhEi0SK6AxhO2+hSSfRCg8obOjUXPWgtoYSejA8bS1YEtywJamOHu/ATD0NHev5jXsdp34bACL4s8nzJ10UV1fPaEMSHbFYt3b+GCdy034nDw/qj2BNd1dxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DBMVlEig; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59d11e0b9e1so1260704eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708122772; x=1708727572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdZ9WPH7Nl2aH1xgLChF6BzPk0ENAzSqqSLTSdJZTwM=;
        b=DBMVlEigKGHihYH4vHTOqa2xGoY5LAu+v3b+3DT+OmFF4Tm7FOSURfukWf8t2pVFAq
         Te2su/ak4htE/Xt8W630Ymmg1WsXrpiXWx8YFkGsgWOCI3W+v7ka8RIWIG8l0zYZc/D3
         6dasOe1n02caAX7Pkli3J3tVwmqq6sV29rBX64ItwYuvsu5rsa3naYF8lwOpQnk8TDTB
         CbOK20I2G9tHRnrt0a+5C36CYSm6J9aVB5NuGYbEFKartO9jv7zKMrw0paHUXxqFH8GS
         Y0D2AKiMbmBJvu/IwrbzMs3La5nYDH0A67czw+d1rYZui+JVTzudWQLBKmQ1UxQz/zoC
         S/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708122772; x=1708727572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdZ9WPH7Nl2aH1xgLChF6BzPk0ENAzSqqSLTSdJZTwM=;
        b=k2ET8tTRQyLZmDv94UHNudn7JkW2ciVfaVWoD3uDUn0GkKAePHGbcmhPIzl1Wul/pO
         I/iqYrhbfr3A3yuPs7TRJ3ZAQdf97bU5YFZ3gKEVx5vfZsYuTB1Ud/L0JeBwVK6t+lF8
         19h3Epoy4uVAiK8KhWZ2H24mJotCKkVPSy0Ln+Pzz1cDKZdsAEaXHb3yhKGO3MaT84sF
         ZI/WvsDjjXsYJurBOLLshOqVFQd53EJfRigmt9frnMpeImTX0hX4IL7Z1hIS9Vc2x0lN
         SYlIed98mmS7hS1Kb6g8rW6LUsw8+WE3ktrKZrTuHgL2pdZz+8FjHFIrl6r96xwyJXzx
         qXfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtLgjuu6xhScfIS0snCNtD65F72SZM8TtIi7P+ro2YzOOWE7917n4z6Fihvqa5RIbVwAOyvSbEjyxUXtusJ2P5Cgb/wvK98o/GbnmX
X-Gm-Message-State: AOJu0Yx1V+fkcKewcesWn+5gOSpDgb5RGmQH7hRAsjtlX9YCZVO3GQSq
	EKSo6uIG+JEXTc8YImaBXkAfmRYOpn8N7iR9hvJaGgLDkpvjcTWJVPaP92GJdtY=
X-Google-Smtp-Source: AGHT+IEMIIixM6tZ8mov4ea8ABTWuLoN2rQ27ib9tS5wc4QS07D1l+RHgpL5ftrUdHkxPlwhEXPf7w==
X-Received: by 2002:a05:6820:2b11:b0:59f:aa2e:ef8b with SMTP id dt17-20020a0568202b1100b0059faa2eef8bmr1528834oob.0.1708122772629;
        Fri, 16 Feb 2024 14:32:52 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id x11-20020a4a9b8b000000b0059d24cfb5e3sm137045ooj.4.2024.02.16.14.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 14:32:52 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/16] clk: samsung: Use clk.h as a single header for Samsung CCF
Date: Fri, 16 Feb 2024 16:32:37 -0600
Message-Id: <20240216223245.12273-9-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216223245.12273-1-semen.protsenko@linaro.org>
References: <20240216223245.12273-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make both CPU and PLL clock headers to be included indirectly via clk.h.
All Samsung clock drivers already include clk.h, which provides API for
Samsung CCF clocks like muxes, gates, etc. Both CPU and PLL Samsung
clock are not that different. It makes sense to only use both clk-cpu.h
and clk-pll.h internally for Samsung CCF framework, and make clk.h the
facade for Samsung CCF. This way all clock drivers only have to include
clk.h.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-cpu.c        | 1 -
 drivers/clk/samsung/clk-exynos3250.c | 2 --
 drivers/clk/samsung/clk-exynos4.c    | 1 -
 drivers/clk/samsung/clk-exynos5250.c | 1 -
 drivers/clk/samsung/clk-exynos5260.c | 1 -
 drivers/clk/samsung/clk-exynos5420.c | 1 -
 drivers/clk/samsung/clk-exynos5433.c | 2 --
 drivers/clk/samsung/clk-pll.c        | 2 +-
 drivers/clk/samsung/clk-s3c64xx.c    | 1 -
 drivers/clk/samsung/clk-s5pv210.c    | 1 -
 drivers/clk/samsung/clk.h            | 1 +
 11 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index a59949990919..4c46416281a3 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -36,7 +36,6 @@
 #include <linux/clk-provider.h>
 
 #include "clk.h"
-#include "clk-cpu.h"
 
 struct exynos_cpuclk;
 
diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index bf149fae04c3..d1b72a75bc5a 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -14,8 +14,6 @@
 #include <dt-bindings/clock/exynos3250.h>
 
 #include "clk.h"
-#include "clk-cpu.h"
-#include "clk-pll.h"
 
 #define SRC_LEFTBUS		0x4200
 #define DIV_LEFTBUS		0x4500
diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index d5b1e9f49d8b..3d57020a620f 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -16,7 +16,6 @@
 #include <linux/of_address.h>
 
 #include "clk.h"
-#include "clk-cpu.h"
 
 /* Exynos4 clock controller register offsets */
 #define SRC_LEFTBUS		0x4200
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 58df80de52ef..4953da754994 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -14,7 +14,6 @@
 #include <linux/of_address.h>
 
 #include "clk.h"
-#include "clk-cpu.h"
 #include "clk-exynos5-subcmu.h"
 
 #define APLL_LOCK		0x0
diff --git a/drivers/clk/samsung/clk-exynos5260.c b/drivers/clk/samsung/clk-exynos5260.c
index 16da6ef5ca0c..280330ded100 100644
--- a/drivers/clk/samsung/clk-exynos5260.c
+++ b/drivers/clk/samsung/clk-exynos5260.c
@@ -11,7 +11,6 @@
 
 #include "clk-exynos5260.h"
 #include "clk.h"
-#include "clk-pll.h"
 
 #include <dt-bindings/clock/exynos5260-clk.h>
 
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index bd7b304d2c00..531ef1c3fa30 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -15,7 +15,6 @@
 #include <linux/clk.h>
 
 #include "clk.h"
-#include "clk-cpu.h"
 #include "clk-exynos5-subcmu.h"
 
 #define APLL_LOCK		0x0
diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index d3779eefb438..379744f0a5b6 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -17,9 +17,7 @@
 #include <dt-bindings/clock/exynos5433.h>
 
 #include "clk.h"
-#include "clk-cpu.h"
 #include "clk-exynos-arm64.h"
-#include "clk-pll.h"
 
 /* NOTE: Must be equal to the last clock ID increased by one */
 #define CLKS_NR_TOP			(CLK_SCLK_HDMI_SPDIF_DISP + 1)
diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 4bbdf5e91650..37aa7beb547a 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -14,8 +14,8 @@
 #include <linux/timekeeping.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+
 #include "clk.h"
-#include "clk-pll.h"
 
 #define PLL_TIMEOUT_US		20000U
 #define PLL_TIMEOUT_LOOPS	1000000U
diff --git a/drivers/clk/samsung/clk-s3c64xx.c b/drivers/clk/samsung/clk-s3c64xx.c
index d27a1f73f077..8ee3ffdf2b8d 100644
--- a/drivers/clk/samsung/clk-s3c64xx.c
+++ b/drivers/clk/samsung/clk-s3c64xx.c
@@ -14,7 +14,6 @@
 #include <dt-bindings/clock/samsung,s3c64xx-clock.h>
 
 #include "clk.h"
-#include "clk-pll.h"
 
 /* S3C64xx clock controller register offsets. */
 #define APLL_LOCK		0x000
diff --git a/drivers/clk/samsung/clk-s5pv210.c b/drivers/clk/samsung/clk-s5pv210.c
index cd85342e4ddb..29f2531fd5d3 100644
--- a/drivers/clk/samsung/clk-s5pv210.c
+++ b/drivers/clk/samsung/clk-s5pv210.c
@@ -13,7 +13,6 @@
 #include <linux/of_address.h>
 
 #include "clk.h"
-#include "clk-pll.h"
 
 #include <dt-bindings/clock/s5pv210.h>
 
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 516b716407e5..8157479f45eb 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -11,6 +11,7 @@
 #define __SAMSUNG_CLK_H
 
 #include <linux/clk-provider.h>
+#include "clk-cpu.h"
 #include "clk-pll.h"
 
 /**
-- 
2.39.2


