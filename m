Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563B6787454
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242226AbjHXPdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242202AbjHXPdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:33:05 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EEA19BA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:33:03 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a3082c771so21000b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692891183; x=1693495983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8LQV3FZTWxLTg8jNgV7yvfSpimnidUcb0tZukELwI8=;
        b=lNensNrtbZ1/JO69cv/X7s17yyTO9pvyYki4jYqN0gNJwZSYaEv3k4Lrs/SWiERqSR
         MVf/1Ic8euWeBn106GsnAPicEAQZXm8K0jrbF94OgDjO8enkM6T2K63rkyzfF4S+v9HW
         fV2hiAqantxQwPP3J2uQWDI4t+aiqsMaMaFuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692891183; x=1693495983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8LQV3FZTWxLTg8jNgV7yvfSpimnidUcb0tZukELwI8=;
        b=WWiJ1d5nRh/FS0KlgKsv32+KaQr8MRXhyQ+bZmgc6G333VCZHfkMoOekFa5rTaN6FO
         qH0p+RvT9WDZMnQ/PNrb7znhkBmt4xoFeqK7RdzhQuszCsZGP3vtDdlDPy0gdjX8iZ9G
         BkDu+oox66dZVKdI77LHAYKhUqEH0t6lTe0uK6lWMxr2JKedXXR7CLo1W+A5zza/9f/G
         TxyiD28DNIxqlzID+ZimTelIxdmXGuGG8/TSkGaG7s7fgZIYIUhCz6asaSZhovwqPeLU
         Pu4Md89WDplwoXjYWBWEXIHaj2blN4hsR2aWpLcPVLW1WSg6r9acwq8O2mDkGrsT5QF4
         aG1g==
X-Gm-Message-State: AOJu0YyIoBQRucPr/lKO63MMp9+agKfzd3NuXn+FpYcuMsnHqq7wfUwt
        vYBkrpbRZJTHpshmW/mWcTQbLw==
X-Google-Smtp-Source: AGHT+IHtE7/RbB67nJdYB/Ae0mTQ0RJ8uJ9wBeYpGrn270z6LtX1u8780/eo8q0EyT04aZwzQcfYQg==
X-Received: by 2002:a05:6a20:9187:b0:125:4d74:cd6a with SMTP id v7-20020a056a20918700b001254d74cd6amr22207369pzd.3.1692891182940;
        Thu, 24 Aug 2023 08:33:02 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:afa3:fcf5:1b7f:f7e2])
        by smtp.gmail.com with ESMTPSA id m30-20020a63711e000000b0056365ee8603sm11631337pgc.67.2023.08.24.08.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 08:33:02 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kgdb-bugreport@lists.sourceforge.net,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, ito-yuichi@fujitsu.com,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Guo Ren <guoren@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 2/6] arm64: idle: Tag the arm64 idle functions as __cpuidle
Date:   Thu, 24 Aug 2023 08:30:28 -0700
Message-ID: <20230824083012.v11.2.I4baba13e220bdd24d11400c67f137c35f07f82c7@changeid>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824153233.1006420-1-dianders@chromium.org>
References: <20230824153233.1006420-1-dianders@chromium.org>
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

As per the (somewhat recent) comment before the definition of
`__cpuidle`, the tag is like `noinstr` but also marks a function so it
can be identified by cpu_in_idle(). Let's add these markings to arm64
cpuidle functions

With this change we get useful backtraces like:

  NMI backtrace for cpu N skipped: idling at cpu_do_idle+0x94/0x98

instead of useless backtraces when dumping all processors using
nmi_cpu_backtrace().

NOTE: this patch won't make cpu_in_idle() work perfectly for arm64,
but it doesn't hurt and does catch some cases. Specifically an example
that wasn't caught in my testing looked like this:

 gic_cpu_sys_reg_init+0x1f8/0x314
 gic_cpu_pm_notifier+0x40/0x78
 raw_notifier_call_chain+0x5c/0x134
 cpu_pm_notify+0x38/0x64
 cpu_pm_exit+0x20/0x2c
 psci_enter_idle_state+0x48/0x70
 cpuidle_enter_state+0xb8/0x260
 cpuidle_enter+0x44/0x5c
 do_idle+0x188/0x30c

Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v11:
- Updated commit message as per Stephen.

Changes in v9:
- Added to commit message that this doesn't catch all cases.

Changes in v8:
- "Tag the arm64 idle functions as __cpuidle" new for v8

 arch/arm64/kernel/idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/idle.c b/arch/arm64/kernel/idle.c
index c1125753fe9b..05cfb347ec26 100644
--- a/arch/arm64/kernel/idle.c
+++ b/arch/arm64/kernel/idle.c
@@ -20,7 +20,7 @@
  *	ensure that interrupts are not masked at the PMR (because the core will
  *	not wake up if we block the wake up signal in the interrupt controller).
  */
-void noinstr cpu_do_idle(void)
+void __cpuidle cpu_do_idle(void)
 {
 	struct arm_cpuidle_irq_context context;
 
@@ -35,7 +35,7 @@ void noinstr cpu_do_idle(void)
 /*
  * This is our default idle handler.
  */
-void noinstr arch_cpu_idle(void)
+void __cpuidle arch_cpu_idle(void)
 {
 	/*
 	 * This should do all the clock switching and wait for interrupt
-- 
2.42.0.rc1.204.g551eb34607-goog

