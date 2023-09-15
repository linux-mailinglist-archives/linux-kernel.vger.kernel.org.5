Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1087A1A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjIOJWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjIOJVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:21:41 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77991FE0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:25 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso30501101fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769684; x=1695374484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlllPeCqZBCeZ/HSi6m8sJuTceIVvHBkX9Te06oKtDw=;
        b=wsIBXIGSWuwnQa3fFTkkwGYg2dbywjSU+DsmLut7effsEwCJKg2uVKBfaC910Rth+O
         U1RPzFUcltyYbmEPlj89Qytv9cUOnP0EGnFT6f/wHixqhh/cWKXj2kuHKdpeLYVE82YS
         DKs8IeamrDry0TUMIIVqlwf21Ex+HrOGEKo5z1S0KvG7hyOGZApDvZeE4U7OyY0Mn0hH
         e26Ab8rSshKFq/kf286KtXylnT6GdkfYhbM6Zi3odgWUnEOA1DsoeixnNQPG18xvPZ6H
         7uZ0E1S8M+bGZXXfN78YIhxc9v+vws3+C0wagv3n6yQ01Nk3C3hWBb8hXsSCzXTwFyCD
         nx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769684; x=1695374484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlllPeCqZBCeZ/HSi6m8sJuTceIVvHBkX9Te06oKtDw=;
        b=qBApUuOhcU/zmhbQ+F+fePcmdt3m6x7PdxUfZczC8ZdsE8+JJM+mv0zphCCPhbGppQ
         1xRuIdQOrhhyblRxaSPjR2tVnRtalsswXwJ7sGDy3nW0tyENBqgmZHVrnpRmKUoEBTiA
         es2eJgz0yIuJ7Ii5K0Ab/s3N75U6m2ngm9Nx+ikBBUEKH8LwAg4FW6epjAtlKxJPSXja
         hpnaEb+CP2klThz6JwnoomsIsVf4rjH+ochMgeQQhcaz0adP+ouTtS04VjPjTlkn88Lf
         B8/VkKZgEqQozw9f+r9M2+ZENSJgCVnpibCp04KsgQZGUUEkyIVSI2toCsOR3K1D/JTV
         60sw==
X-Gm-Message-State: AOJu0Yz6bIZLqoJjfvztzWq1MLFBJzDhkJAdizCqFNIu5LCpUfQwk9HQ
        sl7Sk42lKfazbPbvMZXI4GFr+A==
X-Google-Smtp-Source: AGHT+IFJOzBhngeSqkEhAWTE2XBVBalsWjDoXj+N6Sl+ZI+MtDDE8yKWXfVhjl23K2P9yiLEg9+MBQ==
X-Received: by 2002:a2e:8784:0:b0:2bc:d993:bdaa with SMTP id n4-20020a2e8784000000b002bcd993bdaamr1084334lji.18.1694769684153;
        Fri, 15 Sep 2023 02:21:24 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e7408000000b002b9ec22d9fasm639376ljc.29.2023.09.15.02.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:21:23 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 09/17] pmdomain: renesas: Move Kconfig options to the pmdomain subsystem
Date:   Fri, 15 Sep 2023 11:19:55 +0200
Message-Id: <20230915092003.658361-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915092003.658361-1-ulf.hansson@linaro.org>
References: <20230915092003.658361-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig options belongs closer to the corresponding implementations,
hence let's move them from the soc subsystem to the pmdomain subsystem.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: <linux-renesas-soc@vger.kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig         |   1 +
 drivers/pmdomain/renesas/Kconfig | 109 +++++++++++++++++++++++++++++++
 drivers/soc/renesas/Kconfig      | 105 -----------------------------
 3 files changed, 110 insertions(+), 105 deletions(-)
 create mode 100644 drivers/pmdomain/renesas/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index c91fdd40163a..0a75a17f2f3a 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -8,5 +8,6 @@ source "drivers/pmdomain/bcm/Kconfig"
 source "drivers/pmdomain/imx/Kconfig"
 source "drivers/pmdomain/mediatek/Kconfig"
 source "drivers/pmdomain/qcom/Kconfig"
+source "drivers/pmdomain/renesas/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/renesas/Kconfig b/drivers/pmdomain/renesas/Kconfig
new file mode 100644
index 000000000000..80bf2cf8b60e
--- /dev/null
+++ b/drivers/pmdomain/renesas/Kconfig
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0
+if SOC_RENESAS
+
+config SYSC_RCAR
+	bool "System Controller support for R-Car" if COMPILE_TEST
+
+config SYSC_RCAR_GEN4
+	bool "System Controller support for R-Car Gen4" if COMPILE_TEST
+
+config SYSC_R8A77995
+	bool "System Controller support for R-Car D3" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7794
+	bool "System Controller support for R-Car E2" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A77990
+	bool "System Controller support for R-Car E3" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7779
+	bool "System Controller support for R-Car H1" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7790
+	bool "System Controller support for R-Car H2" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7795
+	bool "System Controller support for R-Car H3" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7791
+	bool "System Controller support for R-Car M2-W/N" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A77965
+	bool "System Controller support for R-Car M3-N" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A77960
+	bool "System Controller support for R-Car M3-W" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A77961
+	bool "System Controller support for R-Car M3-W+" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A779F0
+	bool "System Controller support for R-Car S4-8" if COMPILE_TEST
+	select SYSC_RCAR_GEN4
+
+config SYSC_R8A7792
+	bool "System Controller support for R-Car V2H" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A77980
+	bool "System Controller support for R-Car V3H" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A77970
+	bool "System Controller support for R-Car V3M" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A779A0
+	bool "System Controller support for R-Car V3U" if COMPILE_TEST
+	select SYSC_RCAR_GEN4
+
+config SYSC_R8A779G0
+	bool "System Controller support for R-Car V4H" if COMPILE_TEST
+	select SYSC_RCAR_GEN4
+
+config SYSC_RMOBILE
+	bool "System Controller support for R-Mobile" if COMPILE_TEST
+
+config SYSC_R8A77470
+	bool "System Controller support for RZ/G1C" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7745
+	bool "System Controller support for RZ/G1E" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7742
+	bool "System Controller support for RZ/G1H" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7743
+	bool "System Controller support for RZ/G1M" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A774C0
+	bool "System Controller support for RZ/G2E" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A774E1
+	bool "System Controller support for RZ/G2H" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A774A1
+	bool "System Controller support for RZ/G2M" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A774B1
+	bool "System Controller support for RZ/G2N" if COMPILE_TEST
+	select SYSC_RCAR
+
+endif
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 5a75ab64d1ed..650f4dd96dec 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -350,109 +350,4 @@ config PWC_RZV2M
 config RST_RCAR
 	bool "Reset Controller support for R-Car" if COMPILE_TEST
 
-config SYSC_RCAR
-	bool "System Controller support for R-Car" if COMPILE_TEST
-
-config SYSC_RCAR_GEN4
-	bool "System Controller support for R-Car Gen4" if COMPILE_TEST
-
-config SYSC_R8A77995
-	bool "System Controller support for R-Car D3" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A7794
-	bool "System Controller support for R-Car E2" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A77990
-	bool "System Controller support for R-Car E3" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A7779
-	bool "System Controller support for R-Car H1" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A7790
-	bool "System Controller support for R-Car H2" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A7795
-	bool "System Controller support for R-Car H3" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A7791
-	bool "System Controller support for R-Car M2-W/N" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A77965
-	bool "System Controller support for R-Car M3-N" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A77960
-	bool "System Controller support for R-Car M3-W" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A77961
-	bool "System Controller support for R-Car M3-W+" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A779F0
-	bool "System Controller support for R-Car S4-8" if COMPILE_TEST
-	select SYSC_RCAR_GEN4
-
-config SYSC_R8A7792
-	bool "System Controller support for R-Car V2H" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A77980
-	bool "System Controller support for R-Car V3H" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A77970
-	bool "System Controller support for R-Car V3M" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A779A0
-	bool "System Controller support for R-Car V3U" if COMPILE_TEST
-	select SYSC_RCAR_GEN4
-
-config SYSC_R8A779G0
-	bool "System Controller support for R-Car V4H" if COMPILE_TEST
-	select SYSC_RCAR_GEN4
-
-config SYSC_RMOBILE
-	bool "System Controller support for R-Mobile" if COMPILE_TEST
-
-config SYSC_R8A77470
-	bool "System Controller support for RZ/G1C" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A7745
-	bool "System Controller support for RZ/G1E" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A7742
-	bool "System Controller support for RZ/G1H" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A7743
-	bool "System Controller support for RZ/G1M" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A774C0
-	bool "System Controller support for RZ/G2E" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A774E1
-	bool "System Controller support for RZ/G2H" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A774A1
-	bool "System Controller support for RZ/G2M" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A774B1
-	bool "System Controller support for RZ/G2N" if COMPILE_TEST
-	select SYSC_RCAR
-
 endif # SOC_RENESAS
-- 
2.34.1

