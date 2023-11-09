Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7517E6793
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjKIKPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjKIKOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:14:54 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AEF2D77
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:14:52 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507bd64814fso913243e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 02:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699524890; x=1700129690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkZaHixUrwPrJIZcMAT2UI1CVMoJazwhG5L/qYNHDpM=;
        b=xEsaEFtyijZ+lrkgLWdBlKEF9XzHJAYABDemz8qJ7g6trDSydEg+717Paacds7L1RW
         ihBUmwGqLNYnnuwzrQkOYzfE6HJF7T60yL/GSUFpjTDQbtgtRMDtiL3ZxUmm0bvvoJBU
         OdpHItJ2Ab/GnrLM6yLVFTqmrbAMuI3HW+3wvr3jtTDBictXHHbN4XoJM1YoU4xlfowx
         XaUV4s2eD11I4ai+roVkUi8J3w+CdVFlXjm22oKeOKVGdA2Uu6avHXnbHr/1zfc4AvJ9
         zcMWBokvNNn11nxHlT1wSGClBTlsw6J8wfeOOlbTspqKHC1dJMsY+BIOT9V90TryMp29
         5KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524890; x=1700129690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkZaHixUrwPrJIZcMAT2UI1CVMoJazwhG5L/qYNHDpM=;
        b=HveJ18orZJucR10Km+CpIsrD5kp7MDKdbfS7JGA416+J0nWuKEHuJ9EPanj6xxBBhA
         Gn6DHM1ezLzUAgzslTSezH9qLqoYTLu9zuPbU6dazFKdurY/cz5pqwVbRvSl4bmDUf8g
         rdT2tTyA33t1fi3dPa3ZtMyuZZATMFEe5D2e+xX48qxGoyiLqAslwmNdgG45azdIATv8
         66Fzr9Im+EtRprf8y2lvPSADJGBNfXNYOg7aCzZAUSUfOvIGDBXM7SacM20nc57gCOYs
         4bq2W58IzWd20F7I0jo+DOBKPR0FM4f38jsuevPiwNp/o3HNd2s1APEOWfzDZlOFzhvB
         +pcg==
X-Gm-Message-State: AOJu0YzELMQXJ9XtaKOkhid0JGBmGSF9lCophOoBTDgQcCBokWGQVhK6
        WbZx8eV0hSenxxL+FlECztOerA==
X-Google-Smtp-Source: AGHT+IEqILPvUko85d9wgnJYU7Vruxwgnn1FhQ0YwiIKlK4c+JNlTI9/ER4u8xuUQ0y1qhtyeTmH+g==
X-Received: by 2002:a05:6512:70d:b0:509:47b9:63d0 with SMTP id b13-20020a056512070d00b0050947b963d0mr880323lfs.61.1699524890509;
        Thu, 09 Nov 2023 02:14:50 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:26e5:c6da:63bc:dd99])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c4f5100b003fefb94ccc9sm1611816wmq.11.2023.11.09.02.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:14:49 -0800 (PST)
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
Subject: [PATCH v6 2/7] cpufreq: Use the fixed and coherent frequency for scaling capacity
Date:   Thu,  9 Nov 2023 11:14:33 +0100
Message-Id: <20231109101438.1139696-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109101438.1139696-1-vincent.guittot@linaro.org>
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpuinfo.max_freq can change at runtime because of boost as an example. This
implies that the value could be different from the frequency that has been
used to compute the capacity of a CPU.

The new arch_scale_freq_ref() returns a fixed and coherent frequency
that can be used to compute the capacity for a given frequency.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 include/linux/cpufreq.h   | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 60ed89000e82..8c4f9c2f9c44 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -454,7 +454,7 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
 
 	arch_set_freq_scale(policy->related_cpus,
 			    policy->cur,
-			    policy->cpuinfo.max_freq);
+			    arch_scale_freq_ref(policy->cpu));
 
 	spin_lock(&policy->transition_lock);
 	policy->transition_ongoing = false;
@@ -2174,7 +2174,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 
 	policy->cur = freq;
 	arch_set_freq_scale(policy->related_cpus, freq,
-			    policy->cpuinfo.max_freq);
+			    arch_scale_freq_ref(policy->cpu));
 	cpufreq_stats_record_transition(policy, freq);
 
 	if (trace_cpu_frequency_enabled()) {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 71d186d6933a..738dcddf3cfe 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1211,6 +1211,7 @@ void arch_set_freq_scale(const struct cpumask *cpus,
 {
 }
 #endif
+
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
-- 
2.34.1

