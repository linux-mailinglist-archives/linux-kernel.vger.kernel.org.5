Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAE57A1A5E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjIOJWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjIOJVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:21:52 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF421FD4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:26 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bceca8a41aso30792511fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769685; x=1695374485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKisBqk8Z2ap1nSKbct53Lj3iZDRshdX+0gS7XeCa7I=;
        b=cBAxrWMImUdlcroirPosqGC/rKOEGd/g+yMgI1Y7OYLmZzy+8JkKHF8i3OrT9fBPBd
         AX8bHqdoFEkrhiwgIF8PqRVVnJf2+YjQ2kGVBdMsJJIm/b3muUx1PX1QyWZGouIdkWGx
         z/1nFXZJ/v7QLq3Do7yR5vABMhqNwSSAmE7RMx44gaI0FW8r2CT5ujAqK555O2uyIufH
         q8iaqQTnraBEbfZI8EgS/a/Ng/bNXRXnjN60JrPMvrkr2Dbu+TZbPDF6Pg8mLd1ZGrvU
         16QX6LGraVKvprjmMihEMoJ9GAyBY+hvxMbAprcydthgRkZNljEehDRgIR0R0OKCmy32
         jtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769685; x=1695374485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKisBqk8Z2ap1nSKbct53Lj3iZDRshdX+0gS7XeCa7I=;
        b=bSRch651VU8zdkyMg9f6TIgWQmvLnJ6hzOeY4t6LmiIQD/BuHghBjimfzygwoZTLoP
         IwHrg/8jBZesbqGJ7EDyxW0OGMtPbA3hgA5mRllxBAz4NJ0pHV2k8pGz7treAuGGep4u
         jfVUtEEftpZJl1EoPnNnk40QMfYr/j068tgpBOGiW1WHIDqdjUf1eBs3zdpULhZivtJz
         c/0UtSxyA4S4gRmmpFkojKEc2tNoyYHiVDlLqfmpUOTkPVO79ayO6tIZZfchFHOSZ8MN
         Lsx2nx5tdgZ7J2n8J67QG+xe188voaJLJ/vVWvtLyzzb/m7toHgf2ROLX3tK5TzzYbWd
         1/Ng==
X-Gm-Message-State: AOJu0Yx0gTXkHaNCikxVKWWiqZ0wTK5TA6mVUzvjAwBE4h1ZsddUyDmu
        BlblM3cellN5BqccXFGg5UaZvg==
X-Google-Smtp-Source: AGHT+IGwwqHwyBASzYObjimxH00Ydcl+lAjOoi91ePvVUL0yYYiPtovN11NZd4EAB/QxxEpm7+DHfg==
X-Received: by 2002:a2e:8055:0:b0:2bc:39f5:ecb4 with SMTP id p21-20020a2e8055000000b002bc39f5ecb4mr1074596ljg.25.1694769685101;
        Fri, 15 Sep 2023 02:21:25 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e7408000000b002b9ec22d9fasm639376ljc.29.2023.09.15.02.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:21:24 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 10/17] pmdomain: rockchip: Move Kconfig option to the pmdomain subsystem
Date:   Fri, 15 Sep 2023 11:19:56 +0200
Message-Id: <20230915092003.658361-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915092003.658361-1-ulf.hansson@linaro.org>
References: <20230915092003.658361-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig option belongs closer to the corresponding implementation,
hence let's move it from the soc subsystem to the pmdomain subsystem.

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: <linux-rockchip@lists.infradead.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig          |  1 +
 drivers/pmdomain/rockchip/Kconfig | 16 ++++++++++++++++
 drivers/soc/rockchip/Kconfig      | 12 ------------
 3 files changed, 17 insertions(+), 12 deletions(-)
 create mode 100644 drivers/pmdomain/rockchip/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 0a75a17f2f3a..8afe69251dd2 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -9,5 +9,6 @@ source "drivers/pmdomain/imx/Kconfig"
 source "drivers/pmdomain/mediatek/Kconfig"
 source "drivers/pmdomain/qcom/Kconfig"
 source "drivers/pmdomain/renesas/Kconfig"
+source "drivers/pmdomain/rockchip/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/rockchip/Kconfig b/drivers/pmdomain/rockchip/Kconfig
new file mode 100644
index 000000000000..b0d70f1a8439
--- /dev/null
+++ b/drivers/pmdomain/rockchip/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+if ARCH_ROCKCHIP || COMPILE_TEST
+
+config ROCKCHIP_PM_DOMAINS
+	bool "Rockchip generic power domain"
+	depends on PM
+	select PM_GENERIC_DOMAINS
+	help
+	  Say y here to enable power domain support.
+	  In order to meet high performance and low power requirements, a power
+	  management unit is designed or saving power when RK3288 in low power
+	  mode. The RK3288 PMU is dedicated for managing the power of the whole chip.
+
+	  If unsure, say N.
+
+endif
diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
index aff2f7e95237..785f60c6f3ad 100644
--- a/drivers/soc/rockchip/Kconfig
+++ b/drivers/soc/rockchip/Kconfig
@@ -22,18 +22,6 @@ config ROCKCHIP_IODOMAIN
 	  necessary for the io domain setting of the SoC to match the
 	  voltage supplied by the regulators.
 
-config ROCKCHIP_PM_DOMAINS
-	bool "Rockchip generic power domain"
-	depends on PM
-	select PM_GENERIC_DOMAINS
-	help
-	  Say y here to enable power domain support.
-	  In order to meet high performance and low power requirements, a power
-	  management unit is designed or saving power when RK3288 in low power
-	  mode. The RK3288 PMU is dedicated for managing the power of the whole chip.
-
-	  If unsure, say N.
-
 config ROCKCHIP_DTPM
 	tristate "Rockchip DTPM hierarchy"
 	depends on DTPM && m
-- 
2.34.1

