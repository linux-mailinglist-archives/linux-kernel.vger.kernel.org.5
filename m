Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688DC784C05
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjHVVar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjHVVap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:30:45 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD50ACEC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:30:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf62258c4dso21264215ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692739843; x=1693344643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kSHi/syeOYlCBnhJOJQl5cWk2sa2bkZnAfAcQGZrzNU=;
        b=WPVY2tmh/Pe0LvBCNsIytE2xjzJE2pZ3O+oUz0K2jus47YsX6dc/oJlpAvnXL5dabN
         74wjaxbh96qJLKDPIjtFphPFpyNBI7kWCHTpxreULO781eXZpFiSWqcBimBKnwU8ld39
         PlqW6jAdCnzG3hxNvi4UFycvFrmOQCoS1RAdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692739843; x=1693344643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSHi/syeOYlCBnhJOJQl5cWk2sa2bkZnAfAcQGZrzNU=;
        b=QZf8n58oHrPgGpThbcUNTGYqNbfdL9vymZIsuLuxXIyweumiMMaxHyqhJD+l4fQWUT
         z5q2lnB71+c+kPoa3b+wfjMcqhDium0kBIhedtl89/iuMhWvtEJXY7+23l1vepF6iWVz
         5ySSrEn+GRm48E/hwXTYtOBrJfUlOvFyw/c7vU4AAEuDW9gOKUkf9FffG6iapXAeN2mB
         f5A5SkMLJxD7ydZA3PTV6TI0duKq3Z54sZ4Z6i2WegBPyXyVURyCiCrZT+u9sGw88p0z
         nD44tdtsGMlloe6g7fbs1kY8QVjPPAvpCQRpQ/JnY6LJvrjBlDhdwUY5Q6oEaVbIi4Cq
         QrDQ==
X-Gm-Message-State: AOJu0YyCyfKAOSZZEzP6M6gnR9pSDbgVExLLyVyAGo00c444n6ZFw5vc
        GoELEkcje95A9/dN/USJ0IVs6w==
X-Google-Smtp-Source: AGHT+IG4QToJsGC6o9soaVW2sjuvWEefbBSECLVN0cckuPYvuBes5wsi/X233dzMRrArhGLuFsDkXw==
X-Received: by 2002:a17:902:ced1:b0:1be:1fc:8ce0 with SMTP id d17-20020a170902ced100b001be01fc8ce0mr9627176plg.12.1692739843142;
        Tue, 22 Aug 2023 14:30:43 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:83f0:2bc5:38c4:a9de])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b001befac3b3cbsm9451475plg.290.2023.08.22.14.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 14:30:42 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Guo Ren <guoren@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/6] arm64: Add IPI for backtraces / kgdb; try to use NMI for some IPIs
Date:   Tue, 22 Aug 2023 14:26:55 -0700
Message-ID: <20230822212927.249645-1-dianders@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt to resurrect Sumit's old patch series [1] that
allowed us to use the arm64 pseudo-NMI to get backtraces of CPUs and
also to round up CPUs in kdb/kgdb. The last post from Sumit that I
could find was v7, so I started my series at v8. I haven't copied all
of his old changelongs here, but you can find them from the link.

This patch series targets v6.6. Specifically it can't land in v6.5
since it depends on commit 36759e343ff9 ("nmi_backtrace: allow
excluding an arbitrary CPU").

It should be noted that Mark still feels there might be some corner
cases where pseudo-NMI is not production ready [2] [3], but as far as
I'm aware there are no concrete/documented issues. Regardless of
whether this should be enabled for production, though, this series
will be invaluable to anyone trying to debug crashes on arm64
machines.

v10 of this series attempts to address all of Mark's feedback on
v9. As a quick summary:
- It includes his patch to remove IPI_WAKEUP, freeing up an extra IPI.
- It no longer combines the "kgdb" and "backtrace" IPIs. If we need
  another IPI these could always be recombined later.
- It promotes IPI_CPU_STOP and IPI_CPU_CRASH_STOP to NMI.
- It puts nearly all the code directly in smp.c.
- Several of the patches are squashed together.
- Patch #6 ("kgdb: Provide a stub kgdb_nmicallback() if !CONFIG_KGDB")
  was dropped from the series since it landed.

Between v8 and v9, I had cleaned up this patch series by integrating
the 10th patch from v8 [4] into the whole series. As part of this, I
renamed the "NMI IPI" to the "debug IPI" since it could now be backed
by a regular IPI in the case that pseudo NMIs weren't available. With
the fallback, this allowed me to drop some extra patches from the
series. This feels (to me) to be pretty clean and hopefully others
agree. Any patch I touched significantly I removed Masayoshi and
Chen-Yu's tags from.

...also in v8, I reorderd the patches a bit in a way that seemed a
little cleaner to me.

Since v7, I have:
* Addressed the small amount of feedback that was there for v7.
* Rebased.
* Added a new patch that prevents us from spamming the logs with idle
  tasks.
* Added an extra patch to gracefully fall back to regular IPIs if
  pseudo-NMIs aren't there.

It can be noted that this patch series works very well with the recent
"hardlockup" patches that have landed through Andrew Morton's tree and
are currently in linuxnext. It works especially well with the "buddy"
lockup detector.

[1] https://lore.kernel.org/linux-arm-kernel/1604317487-14543-1-git-send-email-sumit.garg@linaro.org/
[2] https://lore.kernel.org/lkml/ZFvGqD%2F%2Fpm%2FlZb+p@FVFF77S0Q05N.cambridge.arm.com/
[3] https://lore.kernel.org/lkml/ZNDKVP2m-iiZCz3v@FVFF77S0Q05N.cambridge.arm.com
[4] https://lore.kernel.org/r/20230419155341.v8.10.Ic3659997d6243139d0522fc3afcdfd88d7a5f030@changeid/

Changes in v10:
- ("IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI") new for v10.
- ("arm64: smp: Remove dedicated wakeup IPI") new for v10.
- Backtrace now directly supported in smp.c
- Don't allocate the cpumask on the stack; just iterate.
- Moved kgdb calls to smp.c to avoid needing to export IPI info.
- Rewrite as needed for 5.11+ as per Mark Rutland and Sumit.
- Squash backtrace into patch adding support for pseudo-NMI IPIs.
- kgdb now has its own IPI.

Changes in v9:
- Added comments that we might not be using NMI always.
- Added to commit message that this doesn't catch all cases.
- Fold in v8 patch #10 ("Fallback to a regular IPI if NMI isn't enabled")
- Moved header file out of "include" since it didn't need to be there.
- Remove arm64_supports_nmi()
- Remove fallback for when debug IPI isn't available.
- Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
- arch_trigger_cpumask_backtrace() no longer returns bool

Changes in v8:
- "Tag the arm64 idle functions as __cpuidle" new for v8
- Removed "#ifdef CONFIG_SMP" since arm64 is always SMP
- debug_ipi_setup() and debug_ipi_teardown() no longer take cpu param

Douglas Anderson (5):
  irqchip/gic-v3: Enable support for SGIs to act as NMIs
  arm64: idle: Tag the arm64 idle functions as __cpuidle
  arm64: smp: Add arch support for backtrace using pseudo-NMI
  arm64: smp: IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI
  arm64: kgdb: Implement kgdb_roundup_cpus() to enable pseudo-NMI
    roundup

Mark Rutland (1):
  arm64: smp: Remove dedicated wakeup IPI

 arch/arm64/include/asm/irq.h              |   3 +
 arch/arm64/include/asm/smp.h              |   4 +-
 arch/arm64/kernel/acpi_parking_protocol.c |   2 +-
 arch/arm64/kernel/idle.c                  |   4 +-
 arch/arm64/kernel/smp.c                   | 135 +++++++++++++++++-----
 drivers/irqchip/irq-gic-v3.c              |  54 ++++++---
 6 files changed, 153 insertions(+), 49 deletions(-)

-- 
2.42.0.rc1.204.g551eb34607-goog

