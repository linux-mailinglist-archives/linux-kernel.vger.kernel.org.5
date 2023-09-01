Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E1978FDF9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349661AbjIAND3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349610AbjIAND0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:03:26 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47205E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:03:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3ff7d73a6feso18807685e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 06:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693573402; x=1694178202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBj2auLlUAXmJtm0JLBXBgA7sNg7bnkhJEMz0GdiTZI=;
        b=OpK4JaCciL5TRL2pawG/VmQ8Jdds1w2k8OeopaJ/tilLw+/YIJqEoh7PyKYrzSHBNP
         1ed2IdIpZ/eI5oFahFSwshrTxJNvovEjUUrrFbHBWg+HoXHettVV5zZ44DMlcyabng8M
         39ZqV5TYraxwOsvPuqUMnicMoXvIPAjseghcabVIw+f5UA3fOBa9ynuLukGnDp6BYEO5
         RdG4gBzPb+hYTs5jz+5Ec5RmrcX/9Olow8iVhxp4NhW2KxOumnlUMLKD1KG6MCnsd2fk
         XceG41egOaQIT7RTvxmyXM/aZBGf99nJUzsxu9Ff1BcFRESd3Hw4VVcjCJ9eb+WMEjnG
         4NYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693573402; x=1694178202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBj2auLlUAXmJtm0JLBXBgA7sNg7bnkhJEMz0GdiTZI=;
        b=b5q4ghJimWZ/w2Mq384IeIJ/EQX5GmtaPf+HaHPGR1D5cHDK3RpVmRubY5Fr62+mtT
         mbBEK2P+FgPczhOKcM1utSl2Mj2ysmVJxbOvje4SmoNw7nEA7cqrVl2YgpQWxvF9nrDC
         45LVbzaglvVMNAzhgMRmVzxcKXCtMpJdpV00kMYiaMZGqxRbrc60kOhE1ckkdJhqEioq
         4nE9Btm35Gpnvf7M3vEj/wM7Nb+XxzTMM2JZ3IvNi7ZVSalw/aqOPAuJx44EmjZYcGt/
         PJoF59yW9byq+Bvme2tTwL5nN5Fb9SkYqQW+0/yy8L2zEb059zsMRspYqqnIlsmu1JSn
         27+g==
X-Gm-Message-State: AOJu0YzC+i5k2n3IY4IhQUaGdXGrYynJZ2vMpmomRstWVl1Wyupyw4Lh
        8BS2M6xU5ns5kJizbDffaxKnUg==
X-Google-Smtp-Source: AGHT+IEQD39cpHWbAVr3Bfe0Bk2YZV7G5Wbn5InEVXtG214GUwMtcEYoELLPBmdXYyGWOssaBv1Vxw==
X-Received: by 2002:a05:600c:234a:b0:401:bd95:2e02 with SMTP id 10-20020a05600c234a00b00401bd952e02mr1551706wmq.39.1693573401777;
        Fri, 01 Sep 2023 06:03:21 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:e9bd:add1:d9ac:7b3e])
        by smtp.gmail.com with ESMTPSA id i14-20020adfdece000000b003142e438e8csm5167452wrn.26.2023.09.01.06.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 06:03:21 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/4] cpufreq/schedutil: use a fixed reference frequency
Date:   Fri,  1 Sep 2023 15:03:11 +0200
Message-Id: <20230901130312.247719-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901130312.247719-1-vincent.guittot@linaro.org>
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
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

cpuinfo_max_freq can change at runtime because of boost as example. This
implies that the value could not be the same than the one that has been
used when computing the capacity of a CPU.

The new arch_scale_freq_ref() returns a fixed and coherent frequency
reference that can be used when computing a frequency based on utilization.

Use this arch_scale_freq_ref() when available and fallback to
cpuinfo.max_freq otherwise.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4492608b7d7f..9996ef429e2b 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -114,6 +114,31 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
 	}
 }
 
+#ifdef arch_scale_freq_ref
+/**
+ * arch_scale_freq_ref_policy - get the reference frequency of a given CPU that
+ * has been used to correlate frequency and compute capacity.
+ * @cpu: the CPU in question.
+ *
+ * Return: the reference CPU frequency.
+ */
+static __always_inline
+unsigned long  arch_scale_freq_ref_policy(struct cpufreq_policy *policy)
+{
+	return arch_scale_freq_ref(policy->cpu);
+}
+#else
+static __always_inline
+unsigned long  arch_scale_freq_ref_policy(struct cpufreq_policy *policy)
+{
+	if (arch_scale_freq_invariant())
+		return policy->cpuinfo.max_freq;
+
+
+	return policy->cur;
+}
+#endif
+
 /**
  * get_next_freq - Compute a new frequency for a given cpufreq policy.
  * @sg_policy: schedutil policy object to compute the new frequency for.
@@ -139,11 +164,11 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
 static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 				  unsigned long util, unsigned long max)
 {
+	unsigned int freq;
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned int freq = arch_scale_freq_invariant() ?
-				policy->cpuinfo.max_freq : policy->cur;
 
 	util = map_util_perf(util);
+	freq = arch_scale_freq_ref_policy(policy);
 	freq = map_util_freq(util, freq, max);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
-- 
2.34.1

