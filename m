Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EAC7655AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjG0OOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjG0OOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:14:35 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8FA2D5E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:14:33 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so11085925e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690467271; x=1691072071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eRw/cUGu8fcnPxw+KMMOjGF5bTHqXAR/GW2x87Rw3dw=;
        b=dA/0oC16Y7iRuAHbZ0n7kmQyHW2sbVHip1jppF98hz846ZU9Ac3FhBcMVz1BN7wQAv
         n6rWRQ9Oe/fpRKluovb17FotrSk27Fp/vXu/uvZowB+D0EMCB+ibgu2gj6mF81VA7/WM
         gOikeA2J5GodOO0o83+Kwf2Khyer8Lcz0yHNDW37sBfk+cu+uPKySkuB1yfUjHIcMSPp
         zYGcXq6fQS9j6kK8kEGVng0wnc50QyO+AhyYuqVhXNmu2gZAldWORTGZeta+7HAmUs31
         rNw+GmtcbI9m7Aj0Hz+UixmbpoBVbFTDVaDk00Je86nfD7NR8HYXWQT73Fij3pgc0Eaa
         lVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690467271; x=1691072071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRw/cUGu8fcnPxw+KMMOjGF5bTHqXAR/GW2x87Rw3dw=;
        b=KS33srLRwz15inb8tdM0b25hOOcQzCf5yMz8+NK6zT0CUW5lhRRC8kAoQ7ttoKk8AK
         d/jLfZWm/lU0TzOtRX95nA1/l2rx38G02tILfXYWCMjqLf1mGvpuuUjivf5lCT8htIF8
         WR32CCIq4NFwhAZaGNDf8H0jFn2f4zdcNbbOB40uKZPrUkxnlHvoxO8huDesqQ0FP0jJ
         7BVIunJ73+D5Uz98NpbpID9HkSPKX4vMxIVmzCb/0vVZhrB/BGJFhOrR6KQJn5+YYP3N
         LDtIhkI9gB4BNMWu2qSYJjkxzQpJ7WxGn9Wy8l154JQ6grD5HUCklEGHrLCO6xjf+/XP
         MIGQ==
X-Gm-Message-State: ABy/qLbQd5oxJLVYjC9hT2omTqHyi3gyW010NuHIauRX+k24v+BPOMhY
        traXNVZ7sgHTTvD25hfm1MQ/Rg==
X-Google-Smtp-Source: APBJJlE4sSE0D9stukeJcl06BIhweZAvV/Wivm9L17pK3nhJzWm3GrFSQ3BMSkamty6LskMNEBrLcw==
X-Received: by 2002:adf:de09:0:b0:315:96ca:dcab with SMTP id b9-20020adfde09000000b0031596cadcabmr1607584wrm.35.1690467271509;
        Thu, 27 Jul 2023 07:14:31 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d674f000000b0030ae3a6be4asm2193853wrw.72.2023.07.27.07.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:14:31 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 00/10] riscv: Allow userspace to directly access perf counters
Date:   Thu, 27 Jul 2023 16:14:18 +0200
Message-Id: <20230727141428.962286-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

riscv used to allow direct access to cycle/time/instret counters,
bypassing the perf framework, this patchset intends to allow the user to
mmap any counter when accessed through perf.

**Important**: The default mode is now user access through perf only, not
the legacy so some applications will break. However, we introduce a sysctl
perf_user_access like arm64 does, which will allow to switch to the legacy
mode described above.

This version needs openSBI v1.3 *and* a kernel fix that went upstream lately
(https://lore.kernel.org/lkml/20230616114831.3186980-1-maz@kernel.org/T/).

base-commit-tag: v6.5-rc1

Changes in v5:
- Fix typo from Atish
- Add RB from Atish and Andrew
- Improve cover letter and patch 7 commit log to explain why we made the
  choice to break userspace for security reasons, thanks Atish and Rémi
- Rebase on top of v6.5-rc1

Changes in v4:
- Fixed some nits in riscv_pmu_sbi.c thanks to Andrew
- Fixed the documentation thanks to Andrew
- Added RB from Andrew \o/

Changes in v3:
- patch 1 now contains the ref to the faulty commit (no Fixes tag as it is only a comment), as Andrew suggested
- Removed RISCV_PMU_LEGACY_TIME from patch 3, as Andrew suggested
- Rename RISCV_PMU_PDEV_NAME to "riscv-pmu-sbi", patch4 is just cosmetic now, as Andrew suggested
- Removed a few useless (and wrong) comments, as Andrew suggested
- Simplify arch_perf_update_userpage code, as Andrew suggested
- Documentation now mentions that time CSR is *always* accessible, whatever the mode, as suggested by Andrew
- Removed CYCLEH reference and add TODO for rv32 support, as suggested by Atish
- Do not rename the pmu instance as Atish suggested
- Set pmc_width only if rdpmc is enabled and CONFIG_RISCV_PMU is set and the event is a hw event
- Move arch_perf_update_userpage https://lore.kernel.org/lkml/20230616114831.3186980-1-maz@kernel.org/T/
- **Switch to user mode access by default**

Changes in v2:
- Split into smaller patches, way better!
- Add RB from Conor
- Simplify the way we checked riscv architecture
- Fix race mmap and other thread running on other cpus
- Use hwc when available
- Set all userspace access flags in event_init, too cumbersome to handle sysctl changes
- Fix arch_perf_update_userpage for pmu other than riscv-pmu by renaming pmu driver
- Fixed kernel test robot build error
- Fixed documentation (Andrew and Bagas)
- perf testsuite passes mmap tests in all 3 modes

Alexandre Ghiti (10):
  perf: Fix wrong comment about default event_idx
  include: riscv: Fix wrong include guard in riscv_pmu.h
  riscv: Make legacy counter enum match the HW numbering
  drivers: perf: Rename riscv pmu sbi driver
  riscv: Prepare for user-space perf event mmap support
  drivers: perf: Implement perf event mmap support in the legacy backend
  drivers: perf: Implement perf event mmap support in the SBI backend
  Documentation: admin-guide: Add riscv sysctl_perf_user_access
  tools: lib: perf: Implement riscv mmap support
  perf: tests: Adapt mmap-basic.c for riscv

 Documentation/admin-guide/sysctl/kernel.rst |  27 ++-
 drivers/perf/riscv_pmu.c                    | 113 +++++++++++
 drivers/perf/riscv_pmu_legacy.c             |  28 ++-
 drivers/perf/riscv_pmu_sbi.c                | 196 +++++++++++++++++++-
 include/linux/perf/riscv_pmu.h              |  12 +-
 include/linux/perf_event.h                  |   3 +-
 tools/lib/perf/mmap.c                       |  65 +++++++
 tools/perf/tests/mmap-basic.c               |   4 +-
 8 files changed, 428 insertions(+), 20 deletions(-)

-- 
2.39.2

