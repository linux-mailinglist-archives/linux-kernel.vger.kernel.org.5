Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4324878DF43
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbjH3Tzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbjH3Tz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 15:55:26 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70C732B5C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:25:12 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a85b9deeb3so4033952b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693423450; x=1694028250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lm34Kk+maPdNp9rFuwAAy5O1fZmlUwsB3d8wqfk31DQ=;
        b=Cc7bzK3foUHBf/0juo6aLEYQziud+YCqD9zbpiHgcs9WHajtePd+NiVSmlR7O7HLX4
         7p0mRwKGDgY6PSAV1gVEr1uL81NYmJqH5w7uDywwEn0S9Ji+2Sl/ZI6QDReUQCxPmoIz
         go+Xia+Ts4nqpfuisedsBsi1VWzoowtS0MhbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693423450; x=1694028250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lm34Kk+maPdNp9rFuwAAy5O1fZmlUwsB3d8wqfk31DQ=;
        b=bmI59HJyTEWXO1hayuAM2NhahyxellGGaCXARh5jNfUjniUJq/PMmF8mxccirA3oev
         Y643ChxV3lEWMn2lZxmlM7LFTQLEueP83yiGkk/58MlXkhjuGaBlYlAf2iaH1KllHzDf
         h7hKROo2UKyZZftsB1/QXMNJOv54ruc3UvD36vYQ+XGVTPinAljFVDsNPblw6WFZJ8Ps
         nVhUZniIzeqJNkzLoSuknGKt18dwqHzMa4MTdYqU9V8u3LYIWqI2h77d2AnTpOEqGvjD
         wfyoQphilwrkEImf/op1EZap11loXRsVrCCSHuCNoJ5BNqXR8jfubrI6chH3bzmC5Pbs
         fa2g==
X-Gm-Message-State: AOJu0Yy0r6FC9kO5I197wEfA63j102E/NOpjtwhskb1oTxsvHkGV7Wis
        UAjVKTXqD4mFOfef/aFG1xLo1LPOnMA/EEjWrvZPWoSe
X-Google-Smtp-Source: AGHT+IEt4V9Q3kKv3ps387mUFelpzuS3AhZ1ooWe7nWHiUV3yMAAUWymDyit8Cg7nWN79LlkVQ4iHQ==
X-Received: by 2002:a17:902:b18d:b0:1b5:1467:c4e8 with SMTP id s13-20020a170902b18d00b001b51467c4e8mr2658054plr.15.1693422833430;
        Wed, 30 Aug 2023 12:13:53 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e315:dec6:467c:83c5])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902d48f00b001bbdf32f011sm11338928plg.269.2023.08.30.12.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:13:52 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>, ito-yuichi@fujitsu.com,
        linux-perf-users@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 7/7] arm64: smp: Mark IPI globals as __ro_after_init
Date:   Wed, 30 Aug 2023 12:11:28 -0700
Message-ID: <20230830121115.v12.7.I625d393afd71e1766ef73d3bfaac0b347a4afd19@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230830191314.1618136-1-dianders@chromium.org>
References: <20230830191314.1618136-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the three IPI-related globals in smp.c as "__ro_after_init" since
they are only ever set in set_smp_ipi_range(), which is marked
"__init". This is a better and more secure marking than the old
"__read_mostly".

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This patch is almost completely unrelated to the rest of the series
other than the fact that it would cause a merge conflict with the
series if sent separately. I tacked it on to this series in response
to Stephen's feedback on v11 of this series [1]. If someone hates it
(not sure why they would), it could be dropped. If someone loves it,
it could be promoted to the start of the series and/or land on its own
(resolving merge conflicts).

[1] https://lore.kernel.org/r/CAE-0n52iVDgZa8XT8KTMj12c_ESSJt7f7A0fuZ_oAMMqpGcSzA@mail.gmail.com

Changes in v12:
- ("arm64: smp: Mark IPI globals as __ro_after_init") new for v12.

 arch/arm64/kernel/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 1a53e57c81d0..814d9aa93b21 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -84,9 +84,9 @@ enum ipi_msg_type {
 	MAX_IPI
 };
 
-static int ipi_irq_base __read_mostly;
-static int nr_ipi __read_mostly = NR_IPI;
-static struct irq_desc *ipi_desc[MAX_IPI] __read_mostly;
+static int ipi_irq_base __ro_after_init;
+static int nr_ipi __ro_after_init = NR_IPI;
+static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
 
 static void ipi_setup(int cpu);
 
-- 
2.42.0.283.g2d96d420d3-goog

