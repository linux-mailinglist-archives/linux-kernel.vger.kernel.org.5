Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81897BD8C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346072AbjJIKgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345885AbjJIKge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:36:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BABCA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:36:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3248ac76acbso3945283f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696847791; x=1697452591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmtdGUvSawQ4q9KDGPlbeId1/iTLhEjjDMVIwSogQm4=;
        b=BoQxuiosFjVPZt8rIcS2jhV7/cOVSW3fBHkNztfizdSO555RdCP+O62fPV2dAzkqy3
         6gRLD5DdtjvXAlT5j5SNvqku6Bk0Y8KRTu3YOoYmj1H0+99gVGSo8YR/kpP1k2uetAOH
         GJEU8vOxXy7MYI0OPlghIoPpyMigXVv9+MyrEuqzAu9C8e/35KffZ03iMcvtsmTIIqGY
         DXz/y9Tg1YzPNZYIHRtPJrVL8QwSH/AbYuU2EvsKfPjFG2IolWIa8VE+KMioqA67CHzR
         sFOohL1SEGzZrUVFI0I3QF0DP0GXG2+c2HM5TNk/HMXxtKfyObT/vhE2Rm+C8mp/c70w
         vPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696847791; x=1697452591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmtdGUvSawQ4q9KDGPlbeId1/iTLhEjjDMVIwSogQm4=;
        b=De9DIygEBMEVh3umj6P05h6wSJV4bCncKFvCDc8HmZ+Ct3jaNHYaPQE/gb3S+wUK2S
         f4sELo3zxE//WOHund/h3/yseG6oGoWmRp9Y/CgHeqbKhtFUlgbCxCY6bNST9DMn+VpF
         +Wl5e+zuEMCIzA1haa3bvw6cFoPAIG8CvAPclpBPQ1Hsxgwinp88hgBQE2Xauy3vJp0Z
         jgWs+3QVpvzU0l0kKZkoNS3e+lBEuYjeFMQ//92s8feBpMeqcT//pkSHodu7wx53vwg1
         rJlk4j301KnsnMFKN/6JBuiMfqt7sRgFMLweVoHvCJm5e99s7HmAorxYOE6YUujRsHfS
         jhKg==
X-Gm-Message-State: AOJu0YwDArDJRZUBaZ4QF6h1hhyqfoBXEDk1GW6X4kfXXBVffEg28FzW
        VKZInDVlh7fs8kkmpYpJ9DdvCw==
X-Google-Smtp-Source: AGHT+IFsDHg/Rs8MQPYQNA1a7DXBKSokGpRKvXSJgz2PNurvi4j34eIaCQtgEUCXe0uK4YQzK2pDKA==
X-Received: by 2002:a05:6000:91:b0:320:67:5580 with SMTP id m17-20020a056000009100b0032000675580mr12443168wrx.5.1696847790816;
        Mon, 09 Oct 2023 03:36:30 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:53f1:24bc:5e47:821d])
        by smtp.gmail.com with ESMTPSA id f16-20020adfdb50000000b0031ff89af0e4sm9226722wrj.99.2023.10.09.03.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:36:30 -0700 (PDT)
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
Subject: [PATCH v2 4/6] cpufreq/schedutil: use a fixed reference frequency
Date:   Mon,  9 Oct 2023 12:36:19 +0200
Message-Id: <20231009103621.374412-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009103621.374412-1-vincent.guittot@linaro.org>
References: <20231009103621.374412-1-vincent.guittot@linaro.org>
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

cpuinfo.max_freq can change at runtime because of boost as an example. This
implies that the value could be different than the one that has been
used when computing the capacity of a CPU.

The new arch_scale_freq_ref() returns a fixed and coherent reference
frequency that can be used when computing a frequency based on utilization.

Use this arch_scale_freq_ref() when available and fallback to
policy otherwise.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4492608b7d7f..1fa7e74add8f 100644
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

