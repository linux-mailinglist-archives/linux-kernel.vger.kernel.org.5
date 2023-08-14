Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1398877C1FB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjHNU7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjHNU6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:58:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F85F4;
        Mon, 14 Aug 2023 13:58:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso47947455e9.1;
        Mon, 14 Aug 2023 13:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692046726; x=1692651526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQLIiVxRhbv1KuVaK1dhNf4UzFIBILNWkE7IAI5OtK0=;
        b=jxVGneVTdElRhDZ3u4EIt/CLh8/K3sYbbEz3NcGo41YK2bJ0tKqLJEvu7inB2KO/9D
         gLl7bEEOGgH6RYw1WERG1/hYlGyqVEklVhEoC0sx3Xr6aJfciedn00KVy8gOkmLyJ5yO
         T+GXUWmP0eInDQ6dBPhT5xiMjItdCn3/yEf6RSrIfGZ5EprhFv7Hlk/3G8HZu2ojVsmD
         2h5namiDGu/gIL1U+MrTUUyw3HIRCD+u6jRfFltXqy37klTpD2dsVYtpxroT9reljZKk
         yNdYCz3pY3lUeztb2gpqK+zC9a7DwtV1Eqc4ROU8t/WRNF/nJk17xpQ17pZYBTtL0FwF
         JMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692046726; x=1692651526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQLIiVxRhbv1KuVaK1dhNf4UzFIBILNWkE7IAI5OtK0=;
        b=dr7mcLKbGwzDtBxZ1yNbLSede/v3ZAfpLY1ZPoh+eLAkCB3ZZQfqkRDpIhyvCLf64d
         Mh0n5rqLxO7PY/Fdr0yWPIncCBGKsBq0OISqoyq/WuKin60/RD4BE9VCih+g8GNhDO4p
         OMjXEamxERNEHZVeWtxlKUvDlQ9mS9N4bHb1VnqIRSX4QdsyNYVUTXcTHqvZSLuzwASu
         geJQ15w/2/naqh3TTKLDupLUP8BbFXFNOOpj9eoNlBzrw0VwuAwBbpikvwMHNvHeN0Em
         SY+Xet7qwfyIr1JBjz1m9AFyJPCNyPSiCsVVMXw2Hmm4Wd3UBjnYGwuKTRKOXFT3P1uW
         y3Mg==
X-Gm-Message-State: AOJu0YzvDBCsQxve67fo878LO1frFjo+MdpTQPqYVdc/mcIbWVkLhgn3
        3JjEG32IYjt2DjLU8oO3uUo=
X-Google-Smtp-Source: AGHT+IEQ+Xs/+GJF5RWbUy0orkVcy6CYrZyKDE5YofRDcX4ZqEQ0OX2PIu+E9gPI8OHqMehGN5uO5g==
X-Received: by 2002:a05:600c:253:b0:3fe:1d13:4664 with SMTP id 19-20020a05600c025300b003fe1d134664mr9211797wmj.6.1692046726040;
        Mon, 14 Aug 2023 13:58:46 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:20e9:baea:a4f7:d880])
        by smtp.gmail.com with ESMTPSA id h5-20020adffa85000000b003197efd1e7bsm2161806wrr.114.2023.08.14.13.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 13:58:45 -0700 (PDT)
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
        Christoph Hellwig <hch@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v11 6/6] soc: renesas: Kconfig: Select the required configs for RZ/Five SoC
Date:   Mon, 14 Aug 2023 21:57:19 +0100
Message-Id: <20230814205719.79647-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814205719.79647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230814205719.79647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

