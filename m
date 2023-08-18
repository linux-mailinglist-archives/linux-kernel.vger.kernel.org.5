Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788AE780D47
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377563AbjHRN6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377477AbjHRN5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:57:47 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999553C2D;
        Fri, 18 Aug 2023 06:57:46 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bb99fbaebdso14998611fa.0;
        Fri, 18 Aug 2023 06:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692367065; x=1692971865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YWWR1nS6vb2OHIsahOY5Qls7LOXPtQs7I7ZgEhlX1g=;
        b=CznlxsSftDnKiCJU+W3lkFf52eMZ8aYWBA7JchxklP0oWEoWuXsXvGudx/m3EEZLGk
         nwMfAcTuCIzwToovGL/7/e56dXAWUAM8J/VQSj8Z3HBUV7jEdinC6dKtnb1VV37mQXz2
         p1L3DMxMaZWW89n+FPGnoxO8zVLcp3Ahfbj86N6csa9fTKTLHmpjRe+4Rd3U/9mGI/8v
         NfwgEAinGkj8VwLKwCBxUi/ZKOmgmxsX0w2oprTTlaTF3j5ucg9UOZ1lMxb0J1/wv5N0
         GG8mNaFl3th7bfYonMlx6KBB8PpamaO8XEnn3mcOggTjEX7CBVRrb14E+iVck261f1BD
         cvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692367065; x=1692971865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YWWR1nS6vb2OHIsahOY5Qls7LOXPtQs7I7ZgEhlX1g=;
        b=cp4dn7J2tveNB+eyARZZI8Mn6p1TVuHudsZNPNruIZHESDaXb0c1dsb562BE07ETk5
         XLpoIPPmOu4U2jucGZULjU3ZvcgaNNPm4gSlSERchtgOqjKfSNrqCQVGnGVyBvrLBQXY
         sMmyvDjTbyNFHJKrO5dHkBNwpxaPeoNEWzYCSt/qO42aSAae2Lpmp5NVhxbq9g0LDyII
         r+0J9HfwLUN/NWbGxgZSnciB621wifc0yk3qQnqGVOaO+MT+lgrsKZDiswZM9a2hpyYd
         ZLl4fz/tQOoQCjU35ue8/px38YC1eUIZgxkfOY51cOcv+/n4Zef95eair58CNBL1Z55N
         kYvg==
X-Gm-Message-State: AOJu0YwvGl1+pliGORVF6msQF5P0ZGX5G5hYNWeJEyqiQmpBFGxSkfpV
        ro79OXLGWpMrN8dBdztxcDo=
X-Google-Smtp-Source: AGHT+IEL69oFLf3nqw2LLZ/AVS7OWP11M44RmEWTICV+XBU/q9SReVOt6vvBx/Ezdw0LpLTugUP3pA==
X-Received: by 2002:a05:651c:145:b0:2bb:94e4:490 with SMTP id c5-20020a05651c014500b002bb94e40490mr1867517ljd.23.1692367064754;
        Fri, 18 Aug 2023 06:57:44 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:4b30:13e8:1d57:42fb])
        by smtp.gmail.com with ESMTPSA id s14-20020a05600c044e00b003fa96fe2bd9sm6444055wmb.22.2023.08.18.06.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 06:57:44 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v12 6/6] soc: renesas: Kconfig: Select the required configs for RZ/Five SoC
Date:   Fri, 18 Aug 2023 14:57:23 +0100
Message-Id: <20230818135723.80612-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818135723.80612-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230818135723.80612-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Explicitly select the required Cache management and Errata configs
required for the RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-kicking on a d1
---
v11 -> v12
* No change

v10 -> v11
* No change

v9 -> v10
* No change

v8 -> v9
* No change

v7 -> v8
* Included RB tag from Geert

v6 -> v7
* Included RB tag from Conor

v5 -> v6
* New patch
---
 drivers/soc/renesas/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index de31589ed054..67604f24973e 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -334,6 +334,10 @@ if RISCV
 config ARCH_R9A07G043
 	bool "RISC-V Platform support for RZ/Five"
 	select ARCH_RZG2L
+	select AX45MP_L2_CACHE
+	select DMA_GLOBAL_POOL
+	select ERRATA_ANDES
+	select ERRATA_ANDES_CMO
 	help
 	  This enables support for the Renesas RZ/Five SoC.
 
-- 
2.34.1

