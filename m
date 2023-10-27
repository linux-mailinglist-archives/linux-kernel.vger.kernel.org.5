Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072C77D909B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbjJ0IEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjJ0IEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:04:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC60D1B9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:04:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso13804805e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698393845; x=1698998645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=boXAGtuda+Qb9m4tektze7XbzOBCPPY4QNhYroPvhtw=;
        b=zl3P/gHpDw0RPFvixqZOSnOTWc94wvoSnLV5QwtVI0dzs9bDhV0MtGjCNcEH1MUgqz
         uV7T8Sr0/odz/xFTVsIK8ulhrNDaad6kxHlG4m86itcPb3NxuPFie0aFC7XDolTDDEPD
         RTUDWaRxybH9ik7xHI+3ASPuyV6z7LDT3xt5t40UP7ZoN7EUNfji3/X/Wad2KQ6igHCs
         uWm+8eJBuof3rht+Bvs6lNpvkbSXYWZ5A2U+6TYpR08GFI2bLKPmE1BBZCqXqQ3PS4DT
         3/HkKLj1NiwawMkRpD2O6nHCprEvoDko0e1dXJ4Zd5s4I8W7MLxFnGswa7T8oofj+FkA
         w9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698393845; x=1698998645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=boXAGtuda+Qb9m4tektze7XbzOBCPPY4QNhYroPvhtw=;
        b=vh5hnvp9IjAEjoRaa/49IFDUGJxOs0NuLI4YLmEnxPTdM3YNLH/vNn2YxS4zQsx58I
         3ETh6pEdntlmMX0kbNcxuTRxuEA4brFQNmVLt++I2z+MWqoyPAT1MGWkQgrUiXEWL4vh
         mf6DB84W8wT66Ijjj9kD6Uv8uW0SY/dj3OjSTFgiZs6bibaiybEpUzbUtmos37mssHUE
         AM3YsrozZKpQf9P3BtlDBTnU391/60av4h9NP3LVLBaJMwU6nGem4DvVomFhpjrxb9Xx
         2c47Ap242e1Fe4M20TcbGDzpouxUlaEiG8W4YNRTHOPgrvxRETWMJ34Q/9eKa3IjOvz/
         A+4g==
X-Gm-Message-State: AOJu0YzVUMdNws8KGCu2ZazRouLRt9Nzs88YZJkaEoOXy5YHfnEG6AWN
        2tu8orCM2dfGyO1/yHGmo1P08w==
X-Google-Smtp-Source: AGHT+IH55gRvNIIGzxY2wtfBzfKIjKSV3fYf5Htk7gWA3H0RGtGe6nmb/WOdKqFqMmC7RaRaxT+LWQ==
X-Received: by 2002:a05:600c:a44:b0:3fc:dd9:91fd with SMTP id c4-20020a05600c0a4400b003fc0dd991fdmr1629085wmq.40.1698393845086;
        Fri, 27 Oct 2023 01:04:05 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:c5e:e24e:ad0b:58c6])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c025100b004083729fc14sm4397488wmj.20.2023.10.27.01.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:04:04 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 0/7] consolidate and cleanup CPU capacity
Date:   Fri, 27 Oct 2023 10:03:53 +0200
Message-Id: <20231027080400.56703-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 1st part of consolidating how the max compute capacity is
used in the scheduler and how we calculate the frequency for a level of
utilization.

Fix some unconsistancy when computing frequency for an utilization. There
can be a mismatch between energy model and schedutil.

Next step will be to make a difference between the original
max compute capacity of a CPU and what is currently available when
there is a capping applying forever (i.e. seconds or more).


Changes since v3:
- Split patch 5 cpufreq/cppc
- Fix topology_init_cpu_capacity_cppc() 
- Fix init if AMU ratio
- Added some tags

Changes since v2:
- Remove the 1st patch which has been queued in tip
- Rework how to initialize the reference frequency for cppc_cpufreq and
  change topology_init_cpu_capacity_cppc() to also set capacity_ref_freq
- Add a RFC to convert AMU to use arch_scale_freq_ref and move the config
  of the AMU ratio to be done when intializing cpu capacity and
  capacity_ref_freq
- Added some tags

Changes since v1:
- Fix typos
- Added changes in cpufreq to use arch_scale_freq_ref() when calling
  arch_set_freq_scale (patch 3).
- arch_scale_freq_ref() is always defined and returns 0 (as proposed
  by Ionela) when not defined by the arch. This simplifies the code with
  the addition of patch 3.
- Simplify Energy Model which always uses arch_scale_freq_ref(). The
  latter returns 0 when not defined by arch instead of last item of the 
  perf domain. This is not a problem because the function is only defined
  for compilation purpose in this case and we don't care about the
  returned value. (patch 5)
- Added changes in cppc cpufreq to set capacity_ref_freq (patch 6)
- Added reviewed tag for patch 1 which got a minor change but not for
  others as I did some changes which could make previous reviewed tag
  no more relevant.

Vincent Guittot (7):
  topology: add a new arch_scale_freq_reference
  cpufreq: use the fixed and coherent frequency for scaling capacity
  cpufreq/schedutil: use a fixed reference frequency
  energy_model: use a fixed reference frequency
  cpufreq/cppc: move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}
  cpufreq/cppc: set the frequency used for computing the capacity
  arm64/amu: use capacity_ref_freq to set AMU ratio

 arch/arm/include/asm/topology.h   |   1 +
 arch/arm64/include/asm/topology.h |   1 +
 arch/arm64/kernel/topology.c      |  26 +++---
 arch/riscv/include/asm/topology.h |   1 +
 drivers/acpi/cppc_acpi.c          |  93 +++++++++++++++++++++
 drivers/base/arch_topology.c      |  55 ++++++++----
 drivers/cpufreq/cppc_cpufreq.c    | 134 ++++--------------------------
 drivers/cpufreq/cpufreq.c         |   4 +-
 include/acpi/cppc_acpi.h          |   2 +
 include/linux/arch_topology.h     |   8 ++
 include/linux/cpufreq.h           |   9 ++
 include/linux/energy_model.h      |  14 +++-
 kernel/sched/cpufreq_schedutil.c  |  26 +++++-
 13 files changed, 221 insertions(+), 153 deletions(-)

-- 
2.34.1

