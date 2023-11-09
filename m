Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B1E7E6791
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjKIKOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjKIKOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:14:50 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A7A2D6A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:14:48 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4094301d505so4322995e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 02:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699524887; x=1700129687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4oi3jXI7vrHdw4Az1EYDzA4Gdmd91pOzyx51udMAAeQ=;
        b=wjI3aL7we4IRiPtB+26llD3AWM9EwxK8+G400/9pCEgdB3JPQy8H00AwqmEAxoOIKK
         Z2sDS04rPIhcCGhWv2hPfq2jkeju0TDQ6KifZ8djti/MqKpv5cFoDPfilLUNA/cpyasq
         hJH/ahUO8qRSkMr44NrogArcgqDGvCsqWLgcpBn0vmcKSKHML1VV8kIg57qB/MhASOJD
         UEMWj1saPS/kcBz5u4w/noU0CRVqIIkp/6kjrbUF4XRkW4uL+DAuOlPTfGeEzz1kNY3N
         XqwiNCnQ28TphdYd7533kBS30gyC8PJeJ/t5TtAfPrRXY7GXylqUvGQdR19Dwd5a7R66
         DbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524887; x=1700129687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oi3jXI7vrHdw4Az1EYDzA4Gdmd91pOzyx51udMAAeQ=;
        b=YQHBeIVEcgWgG8lHRmxz469oE/YGPypqYuQ74nR8QhIbGgQVlB/uGUl+3reIgo7lES
         PfjAFlglNslYxQ62deVLit9H5B7yvXFGubJygD1Z1OmiUDjen+6FmbksCt6KFWwdq+2O
         1ORSugoVIJqCEMfy1r3mw596PdlKqVwsLiq5SHATBYl7IZL5sRdNOXo63YRdvc4aTPB9
         Zn4c3IR3XOek/e0Xi9U6DwLOYnt421BvTuwrwJp9nsoLmKwlaHImp6pePpKW8jWsJBYJ
         WFNfNEaNbSPPpi26Tey1HVa3MOO83gQMBeCoyV7hf1pXyJZdemaNQrbyXsWYjTNk189X
         wIGQ==
X-Gm-Message-State: AOJu0Yyrb3A6TKNYUdKj9BbLXue4gKGIfhSRksCSVnImkqs1B5VNc5jT
        DXuqmy9PbAbO79+HBZTLRUE6dg==
X-Google-Smtp-Source: AGHT+IGLiZmuTGbMYyyqS0Ud9k4f2BHvLpElKnJiu++mYwxV1ds6E0Yux6gLdmYe3xpB+kvAcq0ZeA==
X-Received: by 2002:a05:600c:20d:b0:408:fba2:f4bc with SMTP id 13-20020a05600c020d00b00408fba2f4bcmr4093547wmi.24.1699524886779;
        Thu, 09 Nov 2023 02:14:46 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:26e5:c6da:63bc:dd99])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c4f5100b003fefb94ccc9sm1611816wmq.11.2023.11.09.02.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:14:46 -0800 (PST)
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
        pierre.gondois@arm.com, beata.michalska@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v6 0/7] consolidate and cleanup CPU capacity
Date:   Thu,  9 Nov 2023 11:14:31 +0100
Message-Id: <20231109101438.1139696-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Changes since v5:
- remove useless return in freq_inv_set_max_ratio()
- Add tags

Changes since v4:
- Capitalize the verb in subject
- Remove usless parentheses in cppc_get_dmi_max_khz()
- Use freq_ref pattern everywhere
- Fix MHz / kHz units conversion for cppc_cpufreq
- Move default definition of arch_scale_freq_ref() in
  include/linux/sched/topology.h beside arch_scale_cpu_capacity
  which faces similar default declaration behavior. This location covers
  all cases with arch and CONFIG_* which was not the case with previous
  attempts.

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
  topology: Add a new arch_scale_freq_reference
  cpufreq: Use the fixed and coherent frequency for scaling capacity
  cpufreq/schedutil: Use a fixed reference frequency
  energy_model: Use a fixed reference frequency
  cpufreq/cppc: Move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}
  cpufreq/cppc: Set the frequency used for computing the capacity
  arm64/amu: Use capacity_ref_freq to set AMU ratio

 arch/arm/include/asm/topology.h   |   1 +
 arch/arm64/include/asm/topology.h |   1 +
 arch/arm64/kernel/topology.c      |  26 +++---
 arch/riscv/include/asm/topology.h |   1 +
 drivers/acpi/cppc_acpi.c          | 104 ++++++++++++++++++++++
 drivers/base/arch_topology.c      |  56 ++++++++----
 drivers/cpufreq/cppc_cpufreq.c    | 139 ++++--------------------------
 drivers/cpufreq/cpufreq.c         |   4 +-
 include/acpi/cppc_acpi.h          |   2 +
 include/linux/arch_topology.h     |   8 ++
 include/linux/cpufreq.h           |   1 +
 include/linux/energy_model.h      |   6 +-
 include/linux/sched/topology.h    |   8 ++
 kernel/sched/cpufreq_schedutil.c  |  26 +++++-
 14 files changed, 224 insertions(+), 159 deletions(-)

-- 
2.34.1

