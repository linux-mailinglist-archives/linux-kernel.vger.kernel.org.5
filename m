Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2BC7CE2B6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjJRQ0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjJRQZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:25:54 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8FD122
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:25:51 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40572aeb673so65348555e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697646350; x=1698251150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nf9NNvnyBz0qVw4ihr1xxMPaiT6voh2eHkh7WwYLcYs=;
        b=CoNnRigizr3IP9cj+U0SDs2SU1FDhpff+aCc1fE6A19iMHqHbp/wqt3EkcSAOxfwV5
         +LNJd7LUtPL2HNJmaBJCHW+XdBG4mB5G21GHR3SPMbPPkgJ3TYI8qrgHg9OHQ7Xv0VWM
         aPCK9w3bJ8nffA7ksPnZ7HD5IK/iS/bwEfoA/XipP6ebW+k/5aEiEJ9P9beVeto3ffsc
         llrgAZbMYavkLi7Nt0dlguAezVoBOFBT5+PRU1roZWrQab7Hin6fg/ZONB9LERi76Qsn
         lZDN/5C350byg4jTZV7uwxDUitI91nwuqsILiYOPw+mgex+d56Iv1c+WviSZA76mRda8
         c7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646350; x=1698251150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nf9NNvnyBz0qVw4ihr1xxMPaiT6voh2eHkh7WwYLcYs=;
        b=AYH1MlfZBoe/4tcM4sXMfymH+p0h1prPXqE6OC3qk0ZjW3tD/yMgPPdhGM30iTLtlQ
         a0TV0iL8ewaja17t1+wFcpvcS7KoL1u2vVeo+8Zfhg0DjrUeafwKbU5H4qQrYg5+8mpa
         NItWdgWG09N5I/9Lqyca22GFsNvgCt22h5K33k4r0dpxzHkKD/uPULCGwWMO8bJh14sy
         rkdTCwhVcmal/xP5G5Pu+rvqBLqnjQL9C3kX0WbqKlIFYeN1LTWA1xAQZdu5mdvumkCz
         xUFqnAbvreMcA2zWNZ/7wxBpmACsXlsjW1NY75WEEmxsUWZ6C0HSWolGL9zuQ1beKuh6
         AVfQ==
X-Gm-Message-State: AOJu0YzovAgzwdRfYT5ofdNvlDrsU0rc+9fqltldvGqOTeXPc6+uBSGH
        7FkqupCsDw1nj55S49Uc4jDPEg==
X-Google-Smtp-Source: AGHT+IFHq6gIgq9/fcdzlz7KWlERZAdzsq5hjSa77y4MZr6K71BH6ckGJqEW3amqmHnP0VNk6KQh3A==
X-Received: by 2002:a05:600c:1990:b0:406:177e:5df7 with SMTP id t16-20020a05600c199000b00406177e5df7mr4970619wmq.29.1697646349667;
        Wed, 18 Oct 2023 09:25:49 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:fcf4:9d83:8d0d:39aa])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c2e4c00b0040648217f4fsm2033503wmf.39.2023.10.18.09.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 09:25:49 -0700 (PDT)
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
Subject: [PATCH v3 3/6] cpufreq/schedutil: use a fixed reference frequency
Date:   Wed, 18 Oct 2023 18:25:37 +0200
Message-Id: <20231018162540.667646-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018162540.667646-1-vincent.guittot@linaro.org>
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpuinfo.max_freq can change at runtime because of boost as an example. This
implies that the value could be different than the one that has been
used when computing the capacity of a CPU.

The new arch_scale_freq_ref() returns a fixed and coherent reference
frequency that can be used when computing a frequency based on utilization.

Use this arch_scale_freq_ref() when available and fallback to
policy otherwise.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>

---
 kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 458d359f5991..6e4030482ae8 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -114,6 +114,28 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
 	}
 }
 
+/**
+ * cpufreq_get_capacity_ref_freq - get the reference frequency of a given CPU that
+ * has been used to correlate frequency and compute capacity.
+ * @policy: the cpufreq policy of the CPU in question.
+ * @use_current: Fallback to current freq instead of policy->cpuinfo.max_freq.
+ *
+ * Return: the reference CPU frequency to compute a capacity.
+ */
+static __always_inline
+unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
+{
+	unsigned int freq = arch_scale_freq_ref(policy->cpu);
+
+	if (freq)
+		return freq;
+
+	if (arch_scale_freq_invariant())
+		return policy->cpuinfo.max_freq;
+
+	return policy->cur;
+}
+
 /**
  * get_next_freq - Compute a new frequency for a given cpufreq policy.
  * @sg_policy: schedutil policy object to compute the new frequency for.
@@ -140,10 +162,10 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 				  unsigned long util, unsigned long max)
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned int freq = arch_scale_freq_invariant() ?
-				policy->cpuinfo.max_freq : policy->cur;
+	unsigned int freq;
 
 	util = map_util_perf(util);
+	freq = get_capacity_ref_freq(policy);
 	freq = map_util_freq(util, freq, max);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
-- 
2.34.1

