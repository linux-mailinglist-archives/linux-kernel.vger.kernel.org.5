Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1FF80C719
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjLKKtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbjLKKs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:48:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB801D7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:49:04 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-33330a5617fso4541424f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702291743; x=1702896543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2OL2mfLvFGb56Ql/fhP2tnzudrp50Fv5hQ+16D3uLU=;
        b=fvb05GayUUVODyr7WjVu8NHw+UhnxSiU0YcTPDrt8WjTCEQWcNDuq+jWiO3uXeZflQ
         +Z8CxH1/tzPPQ/wiYuKFvfqVjaZIih8yRnYLsTmYUjcayK1EH/Xk89SmGE21jlbTERt5
         BynNZvcpAVSMDZeDR1cFweDvzj4beYLAp9IGJzRFBPgBugL1DKdrrvsiS0MBGpGrDJDD
         0pMyAtze+fmf6Z1L2bbFtcXHc4JjZf2+EsdS+9EYZr+LuWnddK3IaHYK/jEElUjI3/KG
         cR9v3jadmCPVZxoprzOHyOC7oQWgu4yDlEn2sB+LiHlq29HXd1yJ3zVC7uyFZO3A3wmE
         i1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291743; x=1702896543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2OL2mfLvFGb56Ql/fhP2tnzudrp50Fv5hQ+16D3uLU=;
        b=kQxZcE+sDWV01meZuiAarhXnkww+6nz80K3xJK2jxJqoHlSUtk1Swvj/7UDxNElVjG
         K2sgX+inFm5Z/oR8pM9EP0/WQvq7+Aq9IQxw2Vh1/U+xtr3X0QoHKWBJkLe1Vs9rAvra
         bvRnx+roFFqJYHKHatxo8SkBVauWMXurnnYEIYIu6r1V1uM5MgND+DxPbR4kY6LnPvQ1
         f3QkqldYOnDmgbTEDOJAZGfLuPLtmP+TlMUAS4Znt4WF87LTZC8dMYra1OJl89kjPmOH
         qh2eFxxZlz8PncnWd3aOTKCqGLd18QnSBB704CJ0dUsXZLtvSxcC1qP7tCIpm3Yhkw2e
         WgVA==
X-Gm-Message-State: AOJu0Yw0JwQ5BKYjEhbOjQwAAJQfvuD5iDv0BNKzdBSdRUb07X2ktv6h
        W2iiLjQ3jmEk5X6n6KSm8LParQ==
X-Google-Smtp-Source: AGHT+IFG62g0i8MGKgRKqwDFZc4qwAP2pdIhI1VgTkLwdCILDtRtHj7jr7ZHCbn3cvj3/NVslT5gpQ==
X-Received: by 2002:a5d:49c1:0:b0:333:2fd2:5d1b with SMTP id t1-20020a5d49c1000000b003332fd25d1bmr2313046wrs.77.1702291743253;
        Mon, 11 Dec 2023 02:49:03 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a8d:abc:f0ae:3066])
        by smtp.gmail.com with ESMTPSA id e16-20020adffd10000000b003346db01263sm8232579wrr.104.2023.12.11.02.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:49:02 -0800 (PST)
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
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org, beata.michalska@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v7 2/7] cpufreq: Use the fixed and coherent frequency for scaling capacity
Date:   Mon, 11 Dec 2023 11:48:50 +0100
Message-Id: <20231211104855.558096-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211104855.558096-1-vincent.guittot@linaro.org>
References: <20231211104855.558096-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 934d35f570b7..44db4f59c4cc 100644
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
index 1c5ca92a0555..afda5f24d3dd 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1203,6 +1203,7 @@ void arch_set_freq_scale(const struct cpumask *cpus,
 {
 }
 #endif
+
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
-- 
2.34.1

