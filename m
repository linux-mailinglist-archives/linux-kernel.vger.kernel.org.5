Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5592E7B1878
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjI1Kpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjI1Kpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:45:51 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D084F126;
        Thu, 28 Sep 2023 03:45:49 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32320381a07so8464415f8f.0;
        Thu, 28 Sep 2023 03:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695897948; x=1696502748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VhkKgzeF+Wc46hzctnSH5naMu5wzs0T1BbFDxxyizyE=;
        b=idOXfIEMQxT23rDbNazbI3tCRckahzWg6BKEFakkWtMUEL2yNwlHER76+BrMZwOThj
         sg2I0KEtFj3qKTh1RrBId639yXgqH4M34+xywgsQH5n4BbKY7vA1tN/bGFrZ3u0D/K0A
         GaAHsKQDjSSXAXuGr4yMfTxhXUDHF3x9qccEM9C8hupqgcGCs7Dqh6OGygMO/J0COOHa
         dQ7I81zJsttb45yoMD1kiJpctBWdo/qn2w0Kv3bEoOI1mbnOJf04098KrFbOHAdHtlXY
         lcipjUDEsTGGdG6734D3eaFDG4uB4Og3m45F3OpQtqhgnuoH0m7gUBW2KZth5pAomdBs
         7EfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695897948; x=1696502748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhkKgzeF+Wc46hzctnSH5naMu5wzs0T1BbFDxxyizyE=;
        b=LUmw0yGu0Tc+eQbSCiBVm0Xmce2kqzbmssZUSDXJPG7HALFcrF0xwLU2mJ9uDNCuT+
         JsyiIGK8jyDfQrcD4jHjd8U1EuMKcjOXLabpRTE2YQzyBGHQJE0wi20n+WrSL1u1ktwi
         OUJrJWTZjdg7BV+lHm1qjm2a5l1gbZKuMdiXFD43jTZqAssCHKbolgHdAixtij4VpO63
         NFR12vBfMBwohfPiPOLYHiA3W/VoeLjGbW7ZyErJxqhIWiSVrqtlQEADyZwk1TyujDAz
         k7MwbOaTXcw32v2+xQ+jvvK0SENaj69aNTT3Hy1RotAjrWqtkvpnGcWonDNvmXM8wpJV
         xOng==
X-Gm-Message-State: AOJu0Yx0IJAR8B2M01z2qS+C7NNir7YBBysAziTts/JLZvIDJpHdW+W/
        hsDpXTN5NSm1v/SDN/sAoDU=
X-Google-Smtp-Source: AGHT+IEAWxV3yJ+fenO/6XYiC3Fe00mDOYaWiRYIlW7tjH9MozduQaMk04bQ199omksdGYfidBadgw==
X-Received: by 2002:a5d:49c2:0:b0:322:5251:d798 with SMTP id t2-20020a5d49c2000000b003225251d798mr791432wrs.70.1695897947919;
        Thu, 28 Sep 2023 03:45:47 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:b263:a94d:3c0:fce6])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b00405ee9dc69esm7303522wmj.18.2023.09.28.03.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 03:45:47 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <conor.dooley@microchip.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] clocksource/drivers/riscv: Increase the clock_event rating
Date:   Thu, 28 Sep 2023 11:45:20 +0100
Message-Id: <20230928104520.24768-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
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

Renesas RZ/Five SoC has OSTM blocks which can be used for clock_event and
clocksource [0]. The clock_event rating for the OSTM is set 300 but
whereas the rating for riscv-timer clock_event is set to 100 due to which
the kernel is choosing OSTM for clock_event.

As riscv-timer is much more efficient than MMIO clock_event, increase the
rating to 400 so that the kernel prefers riscv-timer over the MMIO based
clock_event.

[0] drivers/clocksource/renesas-ostm.c

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note, Ive set the rating similar to RISC-V clocksource, on ARM architecture
the rating for clk_event is set to 450.
---
 drivers/clocksource/timer-riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index da3071b387eb..e4fc5da119a2 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -54,7 +54,7 @@ static unsigned int riscv_clock_event_irq;
 static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
 	.name			= "riscv_timer_clockevent",
 	.features		= CLOCK_EVT_FEAT_ONESHOT,
-	.rating			= 100,
+	.rating			= 400,
 	.set_next_event		= riscv_clock_next_event,
 };
 
-- 
2.34.1

