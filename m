Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987B480EF6C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjLLO4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376769AbjLLO1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:27:32 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F131BAD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:27:37 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bf4f97752so7375520e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702391256; x=1702996056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oi89GvlAHEHZg03UHqAC2QcBZtFXzQljGaUkYEpdYRQ=;
        b=md5jkMNpMSFt0c3//Hc+vHwemgL/u0RoKjbdEOW9c9g9HkXXfDVf25KBq1h9ZttbHI
         vkDq6Z+nLffOYg3cJj5Kb7hCDiXC1H32oLVT482XNQy93E85ylok1FNSfdrDRQlUff95
         rlKB5XLlIDlpuQ9LnW0Hnu0P75HO0LNid3m3AN+TF2EWuIHZeHu/IyX9ic/00lumnlVf
         VHencOhvLRD5KDGeDhrpsSRQH7zbvRBUsD+9Wdy344RnqhCZpv0ZV4W2PTnelSheSTHw
         irCQVNW+61s7TyEIesbvHcSZQyE6I4m7Pv/Hnz441BTHUhOkjKHMLdiI3o5YQ96uaAed
         OFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702391256; x=1702996056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oi89GvlAHEHZg03UHqAC2QcBZtFXzQljGaUkYEpdYRQ=;
        b=PMdIuA2EKt70V8ahSHnbXlnK+VWUXAb6qavRVqQCIORVZuMcWsmq/uW7A0yVtAURcz
         dqGdMeMu7HIGpq2NjUiBkl5vwxKw8L2qX2zuf0iHL5g+4pl+pegsa83OxnvmJ6hMvihd
         YElznn2cVhAm5Mwafv0TepMVAIh43rY7o62219TKxNSO/QOLHUQpYCKaRk7ZZaHnBkvu
         SHogn1rhYdSpBm43rOvA6VkzqsPnTtHr1TV5qMUJvxTYrROUmkCZnbhXFneJmsJa8+IE
         bqyL13iC7L8EYYnGBHTn+5ORBB9NTJcl4UoAOOROzRJ/aVq9dvn2qYvx4cnXimxopXKT
         KKbg==
X-Gm-Message-State: AOJu0YxPVWS/UfLXJw2yWkQyWC/GUd5+p/Rmg7W5zcvONvMxmJYx6PAU
        IzAAodyJnEQy+ZS535Z2l7czTA==
X-Google-Smtp-Source: AGHT+IHyo1axms+ckhodl2KbZ/1My7NcqxxzmO0EEcz3ZK+X3IOJxW78U3l56AhQYBvpEUAbefnwcQ==
X-Received: by 2002:a05:6512:a8c:b0:50b:f84b:9b0f with SMTP id m12-20020a0565120a8c00b0050bf84b9b0fmr4113837lfu.25.1702391256066;
        Tue, 12 Dec 2023 06:27:36 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a004:6e24:43ee:dd81])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b0040c44cb251dsm9078291wmb.46.2023.12.12.06.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:27:35 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        lukasz.luba@arm.com, rui.zhang@intel.com, mhiramat@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/5] Rework system pressure interface to the scheduler
Date:   Tue, 12 Dec 2023 15:27:26 +0100
Message-Id: <20231212142730.998913-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the consolidation and cleanup of CPU capacity in [1], this serie
reworks how the scheduler gets the pressures on CPUs. We need to take into
account all pressures applied by cpufreq on the compute capacity of a CPU
for dozens of ms or more and not only cpufreq cooling device or HW
mitigiations. we split the pressure applied on CPU's capacity in 2 parts:
- one from cpufreq and freq_qos
- one from HW high freq mitigiation.

The next step will be to add a dedicated interface for long standing
capping of the CPU capacity (i.e. for seconds or more) like the
scaling_max_freq of cpufreq sysfs. The latter is already taken into
account by this serie but as a temporary pressure which is not always the
best choice when we know that it will happen for seconds or more.

[1] https://lore.kernel.org/lkml/20231211104855.558096-1-vincent.guittot@linaro.org/

Vincent Guittot (4):
  cpufreq: Add a cpufreq pressure feedback for the scheduler
  sched: Take cpufreq feedback into account
  thermal/cpufreq: Remove arch_update_thermal_pressure()
  sched: Rename arch_update_thermal_pressure into
    arch_update_hw_pressure

 arch/arm/include/asm/topology.h               |  6 +--
 arch/arm64/include/asm/topology.h             |  6 +--
 drivers/base/arch_topology.c                  | 26 ++++-----
 drivers/cpufreq/cpufreq.c                     | 48 +++++++++++++++++
 drivers/cpufreq/qcom-cpufreq-hw.c             |  4 +-
 drivers/thermal/cpufreq_cooling.c             |  3 --
 include/linux/arch_topology.h                 |  8 +--
 include/linux/cpufreq.h                       | 10 ++++
 include/linux/sched/topology.h                |  8 +--
 .../{thermal_pressure.h => hw_pressure.h}     | 14 ++---
 include/trace/events/sched.h                  |  2 +-
 init/Kconfig                                  | 12 ++---
 kernel/sched/core.c                           |  8 +--
 kernel/sched/fair.c                           | 53 ++++++++++---------
 kernel/sched/pelt.c                           | 18 +++----
 kernel/sched/pelt.h                           | 16 +++---
 kernel/sched/sched.h                          |  4 +-
 17 files changed, 152 insertions(+), 94 deletions(-)
 rename include/trace/events/{thermal_pressure.h => hw_pressure.h} (55%)

-- 
2.34.1
 
