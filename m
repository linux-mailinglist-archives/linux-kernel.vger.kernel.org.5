Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D44679C5FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjILE5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjILE4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:56:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C392D78
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-500b66f8b27so8927422e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494411; x=1695099211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDZgvieS3DFls9ROt2DsYKjwDpTFAGZY0WBf3rdLh5Y=;
        b=VPcMVr+5qYfYSXD7eKvUdZCncSzzre/wPbIFrTGDGTxTa2gpQPXKqo8A+5DX8XujHf
         q3v69brrvUGhVimJDOSmVH9+wGrre8sfJHcgRpsas5XaX+rM113BfwzfXx75eW7af5Q0
         NsNZRx9D7ztOtGptbCNTjkhv1squjtR/iP6uOexDV0Lhd2ojC0qnY62551EzM/ZJSWwE
         J9A07VsDLliOjGg5C6mKdDnhVLzY8S3VTvvfhRpwk6yGrTu0anaFt0hke7wvQ7ZbF0hJ
         +P6nBmLFk3C4efNUiioTvDvWhwOosB364hFzy+6uu/A1OcFO/O/+CtZmG30P97jL4B8Z
         NXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494411; x=1695099211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDZgvieS3DFls9ROt2DsYKjwDpTFAGZY0WBf3rdLh5Y=;
        b=mIBqsmbCzi/mFRLzYY/5e+xFQunRc4xWHAcvnxCKquFIDO421ZzUOULf6dEF7wOmru
         86q1el9pEGPXnQHYoH1lWgWISCUjFBNH4dsWp3V8A0YfwJ17UdNCSlAqYntxI6uogH8d
         cXGk9c4RLKExQkLfoepHi3X7+QFkkhr2Wu1JovfA3l0oDUjlEcfPwqNeTcf2cTR9PlIO
         ra4ttByRlo7Z379PhExNTtzU0Rrfg7CoD+QyoDpWRapto86f8ul9tWsQuRY7o1n6M0yX
         /XnZ0RLSpqg/aCc+1TCmn0aFDYi5fgR+kzpgbbm95/AINpF4ow9GKmFgv5R7qBuLi+VF
         PTUw==
X-Gm-Message-State: AOJu0YyL5Kih9ApqY63U9uxnDF9kaa9+1M3+ZlppjmJ0Oiq0UvPFB8hk
        wXbUhXMAoyn6QsveeGvNS7aYIQ==
X-Google-Smtp-Source: AGHT+IEJdAnhwZFfoKzMi+7bcdcHU3ck5mmfasDJm5FcNV5n0TgMsBENY4JOgjqY6PdcdbPCY36Atw==
X-Received: by 2002:ac2:4bd1:0:b0:4f8:71cc:2b6e with SMTP id o17-20020ac24bd1000000b004f871cc2b6emr9888322lfq.33.1694494410796;
        Mon, 11 Sep 2023 21:53:30 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:53:30 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 36/37] arm64: dts: renesas: r9a08g045s33-smarc: add initial device tree for RZ/G3S SMARC EVK board
Date:   Tue, 12 Sep 2023 07:51:56 +0300
Message-Id: <20230912045157.177966-37-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add initial device tree for RZ/G3S SMARC EVK board.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile            |  2 ++
 .../boot/dts/renesas/r9a08g045s33-smarc.dts     | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 7114cbbd8713..254983ca56a1 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -86,6 +86,8 @@ dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc-cru-csi-ov5645.dtbo
 dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc.dtb
 dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc-cru-csi-ov5645.dtbo
 
+dtb-$(CONFIG_ARCH_R9A08G045) += r9a08g045s33-smarc.dtb
+
 dtb-$(CONFIG_ARCH_R9A09G011) += r9a09g011-v2mevk2.dtb
 
 dtb-$(CONFIG_ARCH_RCAR_GEN3) += draak-ebisu-panel-aa104xd12.dtbo
diff --git a/arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dts b/arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dts
new file mode 100644
index 000000000000..1e68f526f34c
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G3S SMARC EVK board
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+
+#include "r9a08g045s33.dtsi"
+#include "rzg3s-smarc-som.dtsi"
+#include "rzg3s-smarc.dtsi"
+
+/ {
+	model = "Renesas SMARC EVK version 2 based on r9a08g045s33";
+	compatible = "renesas,smarc2-evk", "renesas,r9a08g045s33", "renesas,r9a08g045";
+};
-- 
2.39.2

