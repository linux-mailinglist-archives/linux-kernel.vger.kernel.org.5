Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1427BD8BC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345872AbjJIKg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345831AbjJIKg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:36:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1499199
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:36:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-317c3ac7339so3962995f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696847785; x=1697452585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mzXAWoLrB1CkCF7mnZtizIq1zJhQkfdilgU0TBelMuw=;
        b=Us6e6PWGj6XlNK2Skz7LUZpzXHWEvVO6m827u9HDVicCO8OTiEiaa3tI+SBFrmARRp
         rU+ij6pb5kGZlT5gIkn/AErlaHQLhoythYScwTyKiBwGh0IM/qPVdvzxcqAi2QnKPxyN
         JU7/Ud+7kLeamG3VEnZdlLNn+V9tzD2V9jePQHarXKTlGtICncZSmqrongmbmaTxFg0V
         vWtzZITqN2iPQ/beFypp+4uFi4VjAlWkO9V46z/6j/5HTDr0Y9FKU2TqZJSEmWbi/FA6
         BPVg3y24tQA9ym8b51/F5RnNW4UxRwG3S73xIK2qmabFhZWK71wFYzV1XNUzRDn7WuiY
         KjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696847785; x=1697452585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzXAWoLrB1CkCF7mnZtizIq1zJhQkfdilgU0TBelMuw=;
        b=ckL+SBATCnpoU3QuwCN6JynKNdCgAkAujPFS5RojJfkXp+WaoouEdfyh7SrX77y7s/
         dFULQgd1t6u+jsSmKJ9TpAl0xWBjF4+wUSt9Qdw1urmGfgg/5p2r0qehRgfvxjaucLFm
         5sD53eonK2J6ffUPGIAYOCHGd8LJDnB4o3qH+BhGiRR/Upgcm+Zd5e737qE7TvDPQ20q
         ONxqi3eJc9dcJmlrCu5RCIQh6IGQW6Jdk03q7nB0/tnTH7AJ+rtFLERQnfH0ZXYF/4y7
         Zt9uQ2WuUFmlXKN39y2Tx0WaW10urO1U48ORwSjFq/pQI0kRHllR2RZgAFnpjoyAVbdq
         VOfg==
X-Gm-Message-State: AOJu0YzshwB6ub4dICADoNwx9O869EoUU43VOR4tAJ18KuDMkoUPrrnB
        IGnRazovkpjuzKhidA038/YymA==
X-Google-Smtp-Source: AGHT+IEt52pH56UVIExYbvyXxteaZw3b7eTLevs8DuSQX1Vs9f8YnvubABJjGN5j4jCclR3s+K07Pw==
X-Received: by 2002:adf:e689:0:b0:319:8bb3:ab83 with SMTP id r9-20020adfe689000000b003198bb3ab83mr12316323wrm.66.1696847785473;
        Mon, 09 Oct 2023 03:36:25 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:53f1:24bc:5e47:821d])
        by smtp.gmail.com with ESMTPSA id f16-20020adfdb50000000b0031ff89af0e4sm9226722wrj.99.2023.10.09.03.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:36:24 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 0/6] consolidate and cleanup CPU capacity
Date:   Mon,  9 Oct 2023 12:36:15 +0200
Message-Id: <20231009103621.374412-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
  sched: consolidate and cleanup access to CPU's max compute capacity
  topology: add a new arch_scale_freq_reference
  cpufreq: use the fixed and coherent frequency for scaling capacity
  cpufreq/schedutil: use a fixed reference frequency
  energy_model: use a fixed reference frequency
  cpufreq/cppc: set the frequency used for capacity computation

 Documentation/scheduler/sched-capacity.rst | 13 +++++-----
 arch/arm/include/asm/topology.h            |  1 +
 arch/arm64/include/asm/topology.h          |  1 +
 arch/riscv/include/asm/topology.h          |  1 +
 drivers/base/arch_topology.c               | 29 +++++++++++-----------
 drivers/cpufreq/cppc_cpufreq.c             | 18 ++++++++++++++
 drivers/cpufreq/cpufreq.c                  |  4 +--
 include/linux/arch_topology.h              |  7 ++++++
 include/linux/cpufreq.h                    |  9 +++++++
 include/linux/energy_model.h               | 14 ++++++++---
 kernel/sched/core.c                        |  2 +-
 kernel/sched/cpudeadline.c                 |  2 +-
 kernel/sched/cpufreq_schedutil.c           | 26 +++++++++++++++++--
 kernel/sched/deadline.c                    |  4 +--
 kernel/sched/fair.c                        | 18 ++++++--------
 kernel/sched/rt.c                          |  2 +-
 kernel/sched/sched.h                       |  6 -----
 kernel/sched/topology.c                    |  7 ++++--
 18 files changed, 113 insertions(+), 51 deletions(-)

-- 
2.34.1

