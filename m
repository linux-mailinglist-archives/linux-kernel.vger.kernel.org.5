Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BCC7CC0FF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343722AbjJQKsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343729AbjJQKr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:47:57 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED91F7;
        Tue, 17 Oct 2023 03:47:55 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so57048041fa.2;
        Tue, 17 Oct 2023 03:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697539674; x=1698144474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wW4HxCYnatcP/vztbzCLoFkbFaiPGRf9h2XT9nzoMiE=;
        b=CynsTPeQEQK67WoxN72IjGbqAHduA51cTbMmWOD5RNKCAXov6uZ1F7zS72x96Gzsxs
         BycsS7CubhgVJzOQz0DbwRm0xwICUmwnsGpMLjngFrorzSf16HZZltd+dGhtbYtcuo2H
         MlU55rFMDjn9tkmKavYepHOEEQhwtURsiUmc6WFUJkydYS/UJ20ISY0iG9lsFSuAw8pR
         bo2BpzmtbmGAJi4JOm51iRLObba1Jl6AFamVbRmgLxlMOwj4Ji9YFpzn/LPcGbgMGrAd
         qMPlgcjsslkrTQJhGHhTmTMYYFM2I4WFhHi+9JuPJhRI2QW709UV/He+f4tRe0zVMSIl
         Yhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697539674; x=1698144474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wW4HxCYnatcP/vztbzCLoFkbFaiPGRf9h2XT9nzoMiE=;
        b=g5DD6n6hr0GwDTJk7uOlS+lSnz5s879jmWKNvfu+MqzAfu0XwWgWmKquEQ5+Fh4wzz
         6INve+KRqF8fRbkiDXn6RDmfTUiZwCO4dv3/MeYNsvX6oEDKg19J5cbb6LYRDtfyKNlo
         Duqnd9AOpcmlmyGXNblW+AKTc4Mtt/IGpXsxPKhVKGPMk0e8w9qVHnwyn9wqZYnfbh6k
         eXUTb4y4LdnLoe/XMcE3Caz6zU4J6d2aze/yIhvm525aS+6w1H1NL30BBN/BvQ7n8nPm
         ptPX7ccmOdgOCCeOy5JVALrNG3E7KhFn5H0xCvE/p8Ghg+95flzBjshdId+UfDzLN8ed
         5RLw==
X-Gm-Message-State: AOJu0YxkiWQtx1FLKvg7dLCPRp3iybZ5J3m4YELdtBFQrf50edYfSocK
        N1lKFZAHV9S7uBtfrAVEV7w=
X-Google-Smtp-Source: AGHT+IEJPTcRkmP/L+efxr/73vVSzCydhcAMii3FSFXDwAm/r+Qq/fG4Jwxl694rQJqlTaV0diobhw==
X-Received: by 2002:a2e:a98a:0:b0:2c5:72e:6ff9 with SMTP id x10-20020a2ea98a000000b002c5072e6ff9mr1913088ljq.6.1697539673656;
        Tue, 17 Oct 2023 03:47:53 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e26d:77db:3f90:862b])
        by smtp.gmail.com with ESMTPSA id a6-20020a05600c348600b0040652e8ca13sm9582037wmq.43.2023.10.17.03.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 03:47:52 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 3/3] riscv: dts: renesas: r9a07g043f: Update gpio-ranges property
Date:   Tue, 17 Oct 2023 11:46:38 +0100
Message-Id: <20231017104638.201260-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017104638.201260-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231017104638.201260-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

On RZ/Five we have additional pins compared to the RZ/G2UL SoC so update
the gpio-ranges property in RZ/Five SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
index b0796015e36b..e68a91c9fe77 100644
--- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
+++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
@@ -42,6 +42,10 @@ cpu0_intc: interrupt-controller {
 	};
 };
 
+&pinctrl {
+	gpio-ranges = <&pinctrl 0 0 232>;
+};
+
 &soc {
 	dma-noncoherent;
 	interrupt-parent = <&plic>;
-- 
2.34.1

