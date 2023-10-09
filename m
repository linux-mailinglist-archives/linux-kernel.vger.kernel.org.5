Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D257BD8C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345910AbjJIKgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345908AbjJIKge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:36:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB549F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:36:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40566f8a093so40290105e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696847789; x=1697452589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNKKT3nz1YObI5oerkbE50Couf3/jlljKZ/fkPRsfb8=;
        b=KKeeHEgwkzQ7bGffr2RggX/J5Aa4SZbzSD22Y5kids44XDdQavj8NZcLWx99fYBZ44
         wIcGSDTNGZfBUNPtXTPGSYvprHajbjEV5o3pkN9iozzacYoFjWK0YowgKFPjbyxhUr/N
         sj9jnBgC4u8sVATjbsjYf0H32w6xoMuBLH4CdlRu4BmmZkHjZvKyjwPmlp+SR6paFCiG
         5vHmH2oc5AFL7ysO68tWlkmkvKm/FlEnSh7vog1EsBd11/nWf5R8L6d903K82pOls5oX
         OByluKj0k3RjPvFjgO9OGw3mKzpAlxhqx6BGxGRs+z2Y0e6+w0Ws8l9y2fI1DXs0KydH
         5S3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696847789; x=1697452589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNKKT3nz1YObI5oerkbE50Couf3/jlljKZ/fkPRsfb8=;
        b=lj8sDb7d71reqkL7KiXT4F0zf7LumGTZoCDr8XzpiedJ2wzPCrCjmaESUsGdByA00f
         J4HbqQHABjQJclGEFmtECddmbofAqNk1XOSQGqD1c27G+9t0AeMuKpQEsC1I6JRnCPlU
         +YXmoVf92S3Tk6wYI71GF8kpnOnFzYjIadtfFKasJ09QVXwmKi8YffV9c2VjdoCN/gWw
         QfwoBrZfbFR1wccOMLz6daWMFTIqdb1eL8MRDFZBUtgXg46zhNfuUz1eC5O0LzXeCbLQ
         tq1nMcQZnwQZvHq/45EkeqNGL17i0Z6PLBzEjQwVx6E8+f2Hoi9mrcMK8QBJcf0mRqOu
         22wQ==
X-Gm-Message-State: AOJu0YwOfLAMsJNjZUOvy9OlvOyrjSjzcUyRJh1Vki9iaQkkk1QUHh0f
        5eIioeVMhslEpGuADYABkjo3zQ==
X-Google-Smtp-Source: AGHT+IG26Qla65j//2waJk5p+C3Wp1IkFGp+wjCfVC7nMqMP8R+PELrHfGujdUavK8O0HgXO8xjo4Q==
X-Received: by 2002:a5d:4586:0:b0:321:5e2f:37e1 with SMTP id p6-20020a5d4586000000b003215e2f37e1mr13248647wrq.19.1696847789459;
        Mon, 09 Oct 2023 03:36:29 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:53f1:24bc:5e47:821d])
        by smtp.gmail.com with ESMTPSA id f16-20020adfdb50000000b0031ff89af0e4sm9226722wrj.99.2023.10.09.03.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:36:28 -0700 (PDT)
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
Subject: [PATCH v2 3/6] cpufreq: use the fixed and coherent frequency for scaling capacity
Date:   Mon,  9 Oct 2023 12:36:18 +0200
Message-Id: <20231009103621.374412-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009103621.374412-1-vincent.guittot@linaro.org>
References: <20231009103621.374412-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 include/linux/cpufreq.h   | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

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
index 71d186d6933a..bbc483b4b6e5 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1211,6 +1211,15 @@ void arch_set_freq_scale(const struct cpumask *cpus,
 {
 }
 #endif
+
+#ifndef arch_scale_freq_ref
+static __always_inline
+unsigned int arch_scale_freq_ref(int cpu)
+{
+	return 0;
+}
+#endif
+
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
-- 
2.34.1

