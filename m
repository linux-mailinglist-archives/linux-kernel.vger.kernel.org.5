Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FBC80C71E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbjLKKtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbjLKKtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:49:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5F3DF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:49:06 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3334a701cbbso4484556f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702291744; x=1702896544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RP/GniFhlk8mpJf3Vw6rSOsMkhpCi/hEV2/F0s2ZGQ=;
        b=UhOLaaMcg0rmnRaLEDJXXeGiigbuJe6gBK2wre5vXd8BjEH0gFa4mV0y8WRWp8fgar
         5S/7lzfGGOoDQ5Ub9q3Yk9sNE+8iOvWoUP6rOzv6rMsKh+aX8RBaNsXRtnkJscZVQpc6
         L3tb+yRuVRXabXk24VNxAY8WK0DpTituLryeqSmIicy/0Tky3vWtd5CWRKZol3I2guJx
         aIH707PW/2IOmmaWhey+Qu1+kLq90mwyLQnTyV6uQX1Q5QzIe4bvm3Qx4VfsUuK+VpDQ
         jkn5lrCHIvik5gTJYbsImgHDD7VPTFK1UVs99Onjw7W+mBQBi8zdob/WLyUQ6+Wd7ZHE
         iD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291744; x=1702896544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RP/GniFhlk8mpJf3Vw6rSOsMkhpCi/hEV2/F0s2ZGQ=;
        b=i5FUoYp5Zfk+NesmtDsj36MqtYG2EmWTA6fm/4AjRkCe7XtTdsJo/HM0O3ewM+LtQK
         bO74Pfaus80J9E3RAUA/mjLOfFxu+AmsPlHax/ETOHMyzmTII5bJthHz2eQMJo5GtyNO
         YcNVi5ilVOm6YmCLQZgdO23uElNbpfRy/dMgKVUS1n5amtMd3u2MddwBgGq4ImcIz8+B
         FMvbDSjRKCpyMrNMYZ4il5Y3/JhPpAITdAIJE3A3b9OwvsZXtydELLrt9aoAxw97EvXv
         Mo2RjPA4CJrHGzxQXxgrFAW02tI41O7p4kIgBMz1fn+gyRA5SMSTawCu/5FO5iBMq1Aw
         kngw==
X-Gm-Message-State: AOJu0YxNT4/azqr5d8GaXVJs9YGavjImmWL5w6Ii5QTPRYYUd5SCAHub
        Cqvk3cQqqSZancCj2UZhCB+5DA==
X-Google-Smtp-Source: AGHT+IF4eR0dSmCOZr8X8sS8Dj4KfNlP6x21UczztX823PG+ip/O5DiWO/XLFap24V6etMilxZ5itA==
X-Received: by 2002:adf:eed1:0:b0:333:2fd2:3bd4 with SMTP id a17-20020adfeed1000000b003332fd23bd4mr1400970wrp.141.1702291744711;
        Mon, 11 Dec 2023 02:49:04 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a8d:abc:f0ae:3066])
        by smtp.gmail.com with ESMTPSA id e16-20020adffd10000000b003346db01263sm8232579wrr.104.2023.12.11.02.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:49:04 -0800 (PST)
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
Subject: [PATCH v7 3/7] cpufreq/schedutil: Use a fixed reference frequency
Date:   Mon, 11 Dec 2023 11:48:51 +0100
Message-Id: <20231211104855.558096-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211104855.558096-1-vincent.guittot@linaro.org>
References: <20231211104855.558096-1-vincent.guittot@linaro.org>
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
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4ee8ad70be99..95c3c097083e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -114,6 +114,28 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
 	}
 }
 
+/**
+ * get_capacity_ref_freq - get the reference frequency that has been used to
+ * correlate frequency and compute capacity for a given cpufreq policy. We use
+ * the CPU managing it for the arch_scale_freq_ref() call in the function.
+ * @policy: the cpufreq policy of the CPU in question.
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
@@ -140,9 +162,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 				  unsigned long util, unsigned long max)
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned int freq = arch_scale_freq_invariant() ?
-				policy->cpuinfo.max_freq : policy->cur;
+	unsigned int freq;
 
+	freq = get_capacity_ref_freq(policy);
 	freq = map_util_freq(util, freq, max);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
-- 
2.34.1

