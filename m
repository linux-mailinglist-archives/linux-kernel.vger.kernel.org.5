Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F24C7CE2AF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjJRQZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjJRQZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:25:49 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA36131
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:25:46 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c50cd16f3bso73389741fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697646345; x=1698251145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aBPvPoGvatc00L33SJsgf3xSxpMurf+haw6UVXLiWPI=;
        b=f86YaXtML514/6hcHcHG494U3VcI39PTNleMOokXtthRJSlhtK+m9+ZWKLuZhxoFam
         S4/WuueLWNQMmZF8PQlGrEBQVj27gTHcuM1YYzw4fUvTE6h1GPa8NDaP7aBP66rzFzsh
         l4Ii8o15m9reNVYYYIXHYJunlKa3MfimluOJAWkpZi9oCAeGNZZXHgYOSkRm6edog/8F
         fHxLWPsjp1Pj8T9jMqFQRFwXRIKAZriuhp9uDPlUVSkLhxZgftsgPtaLFr8vgg2GPzY4
         gSyvcZ/fh+JdFnTmP1+N1NZWmj2hA8eKOsY5UrEsVYGgk299pMiZlAdFHvfEBgqaBV3w
         0q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646345; x=1698251145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBPvPoGvatc00L33SJsgf3xSxpMurf+haw6UVXLiWPI=;
        b=JPoN+i1g1RTvtgcWqdDPmkRU0iqV7eKQgTWT8WN7V1GWC8o+Q/BDfahI84PiZmKY+d
         Oyj0rkJHSrD9a31iP1/BjjgWsZwnAntxZInjF6bYmcClL6ZgWmPlvorcS8M0BOOJrbf7
         YpHdYJ/+SBg1W4A0/BlSScXjlLhjS8nWxFQVpXCsJ4pNwwnVEeI+UnFnnohBSNQTWs4h
         bJY8WOkyEYU2fUSfhXkv9So0t8aIem7SOdryBeKoGItcfN9TGD8TdeGFTHp3ki3GLxhn
         cobVop+KuE3owUMooEhuQu8Z8C3UIdDygFccIQ56vKz5FzQxhU12FP+44OyBGEvJRqRt
         y0DQ==
X-Gm-Message-State: AOJu0YyAxoRBDsOBqhYwu8glQkA1uquVdmEXMlBntDcfj54cNdJYySBC
        sBCyKnul+uA1WpMFJtWl4gnBmg==
X-Google-Smtp-Source: AGHT+IGH+vBGDOxCQ/foE4RgwBOMrvwQGARWZwd5FKiVeXsCBR4rYrmOd1rONRCEvyTJKlIqnP29Cg==
X-Received: by 2002:a2e:800f:0:b0:2c0:a99:68e7 with SMTP id j15-20020a2e800f000000b002c00a9968e7mr4322747ljg.19.1697646344796;
        Wed, 18 Oct 2023 09:25:44 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:fcf4:9d83:8d0d:39aa])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c2e4c00b0040648217f4fsm2033503wmf.39.2023.10.18.09.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 09:25:44 -0700 (PDT)
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
Subject: [PATCH v3 0/6] consolidate and cleanup CPU capacity
Date:   Wed, 18 Oct 2023 18:25:34 +0200
Message-Id: <20231018162540.667646-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Vincent Guittot (6):
  topology: add a new arch_scale_freq_reference
  cpufreq: use the fixed and coherent frequency for scaling capacity
  cpufreq/schedutil: use a fixed reference frequency
  energy_model: use a fixed reference frequency
  cpufreq/cppc: set the frequency used for computing the capacity
  arm64/amu: use capacity_ref_freq to set AMU ratio

 arch/arm/include/asm/topology.h   |   1 +
 arch/arm64/include/asm/topology.h |   1 +
 arch/arm64/kernel/topology.c      |  18 ++--
 arch/riscv/include/asm/topology.h |   1 +
 drivers/acpi/cppc_acpi.c          |  93 ++++++++++++++++++++
 drivers/base/arch_topology.c      |  56 ++++++++----
 drivers/cpufreq/cppc_cpufreq.c    | 141 +++++-------------------------
 drivers/cpufreq/cpufreq.c         |   4 +-
 include/acpi/cppc_acpi.h          |   2 +
 include/linux/arch_topology.h     |   8 ++
 include/linux/cpufreq.h           |   9 ++
 include/linux/energy_model.h      |  14 ++-
 kernel/sched/cpufreq_schedutil.c  |  26 +++++-
 13 files changed, 225 insertions(+), 149 deletions(-)

-- 
2.34.1

