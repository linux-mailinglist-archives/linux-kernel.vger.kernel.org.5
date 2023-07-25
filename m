Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1837603AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 02:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjGYAOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 20:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGYAOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:14:17 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C46A115
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:14:16 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3517323a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1690244056; x=1690848856;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HXCdkgf7SAEt55PoPjve0NuVJWNgzHzNEzNEpVtcDy8=;
        b=Xkk3+DitHCobWhmL7FgLnVUVf+4ri2nDizSxVAnxlAGu/beEIriveW3rHd1jvntGbY
         J6qSmU7ajAB0k+tAIjHg+ted4HDVD9PELirtHsGs+6VATp0NIitVzDGbxiIlyXUR32rA
         pbSnND1wq6RHJ95U11bcGlGqLBT9CX5SUtPJ9vHoJPVqXSv+CW0MCDSKUHclVBsrjHxZ
         XrbovZpLF2RNQ0yiG2pNZ2R3XhsoAQXIQpVP2Sk5diL1F0Kw21urZK9sB8/W6vD06J6j
         ZbB+Zw+40yK9GW+d0c8MszAb5ofiHShklduaEB9eKBnLY4MDeTSn8ZFChYz0gK4K0UR3
         PU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690244056; x=1690848856;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HXCdkgf7SAEt55PoPjve0NuVJWNgzHzNEzNEpVtcDy8=;
        b=eSyTc/aRM5Tej5LdVnzHRbYB1SaPX60nJckmmT5VoF/ojlD6ilt4OqHRruzR6j1HrU
         2YKrzKaynAj2uq2k2CX8I6EbE+QLv7g6IiWS3kbg06mGK+4Z5V5YwJhlfJVgQHJw0wob
         NfAu+Pif6vsLDVBrtNX6q+Llq5bPJY7H/g3SBNo+sG98sIc2PgRKmEWUYMidxZwnnjIz
         lGinB4//kPGIw6fCWmGoJHc9QyPE1kT7QKsLP3SiL5Sa3FIV/kQSVrCfEUtZzHf2dje5
         9p4Y0QABNI51Dm2Knx4i8c+ljCcsyKTPag8IYFcME3fKUKCHjkA8i+kF1BEA5N5r/vic
         WDJQ==
X-Gm-Message-State: ABy/qLbmyffkmCw+C8/IPKGqHqQnVpjR8VWQH3Ttyq05cyiXDQbeX2u8
        duB9v1oXfGtv9PlJlr9FWsBBZA==
X-Google-Smtp-Source: APBJJlEVptL23R2j0SrhkJJL3rtIDwu1LW19+FYgUbd2ZdMFguGVo/Qo3MaIHr1ySrkVH8bgVJYPMw==
X-Received: by 2002:a17:90a:2a4b:b0:267:f2b4:8ac4 with SMTP id d11-20020a17090a2a4b00b00267f2b48ac4mr9094176pjg.31.1690244055778;
        Mon, 24 Jul 2023 17:14:15 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090a828100b0025c2c398d33sm6955023pjn.39.2023.07.24.17.14.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jul 2023 17:14:15 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Thomas Gleixner'" <tglx@linutronix.de>,
        <linux-pm@vger.kernel.org>,
        "'the arch/x86 maintainers'" <x86@kernel.org>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     "Doug Smythies" <dsmythies@telus.net>, <yang.jie@linux.intel.com>,
        <linux-kernel@vger.kernel.org>,
        "'Eric Dumazet'" <edumazet@google.com>,
        "'Paul E. McKenney'" <paulmck@kernel.org>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>
Subject: [PATCH] x86/aperfmperf: Make stale CPU frequency response within limits.
Date:   Mon, 24 Jul 2023 17:14:18 -0700
Message-ID: <006901d9be8c$f4439930$dccacb90$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: Adm+i9OXa49HoOhhSw21FXVBGCqHEA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when the CPU frequency is stale the nominal clock frequency
is returned by calls to arch_freq_get_on_cpu(). Some users are
confused by the high reported frequency when their system is idle
and/or it is above a reduced maximum they set.

This patch will return the policy minimum as the stale frequency reply
from arch_freq_get_on_cpu().

Reported-by: Yang Jie <yang.jie@linux.intel.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=217597
Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 arch/x86/kernel/cpu/aperfmperf.c | 13 +++++--------
 drivers/cpufreq/cpufreq.c        | 18 ++++++++++++++++++
 include/linux/cpufreq.h          |  5 +++++
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index fdbb5f07448f..44cc96864d94 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -418,9 +418,10 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	unsigned long last;
 	u64 acnt, mcnt;
 
-	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
-		goto fallback;
-
+	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF)){
+		freq = cpufreq_quick_get(cpu);
+		return freq ? freq : cpufreq_quick_get_min(cpu);
+	}
 	do {
 		seq = raw_read_seqcount_begin(&s->seq);
 		last = s->last_update;
@@ -433,13 +434,9 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	 * which covers idle and NOHZ full CPUs.
 	 */
 	if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE)
-		goto fallback;
+		return cpufreq_quick_get_min(cpu);
 
 	return div64_u64((cpu_khz * acnt), mcnt);
-
-fallback:
-	freq = cpufreq_quick_get(cpu);
-	return freq ? freq : cpu_khz;
 }
 
 static int __init bp_init_aperfmperf(void)
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 50bbc969ffe5..a0b24f61a5b0 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1796,6 +1796,24 @@ unsigned int cpufreq_quick_get_max(unsigned int cpu)
 }
 EXPORT_SYMBOL(cpufreq_quick_get_max);
 
+/**
+ * cpufreq_quick_get_min - return the min frequency for a given CPU
+ * @cpu: CPU number
+ */
+unsigned int cpufreq_quick_get_min(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	unsigned int ret_freq = 0;
+
+	if (policy) {
+		ret_freq = policy->min;
+		cpufreq_cpu_put(policy);
+	}
+
+	return ret_freq;
+}
+EXPORT_SYMBOL(cpufreq_quick_get_min);
+
 /**
  * cpufreq_get_hw_max_freq - get the max hardware frequency of the CPU
  * @cpu: CPU number
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 172ff51c1b2a..c74dcb5f9263 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -220,6 +220,7 @@ static inline bool policy_is_shared(struct cpufreq_policy *policy)
 unsigned int cpufreq_get(unsigned int cpu);
 unsigned int cpufreq_quick_get(unsigned int cpu);
 unsigned int cpufreq_quick_get_max(unsigned int cpu);
+unsigned int cpufreq_quick_get_min(unsigned int cpu);
 unsigned int cpufreq_get_hw_max_freq(unsigned int cpu);
 void disable_cpufreq(void);
 
@@ -250,6 +251,10 @@ static inline unsigned int cpufreq_quick_get_max(unsigned int cpu)
 {
 	return 0;
 }
+static inline unsigned int cpufreq_quick_get_min(unsigned int cpu)
+{
+	return 0;
+}
 static inline unsigned int cpufreq_get_hw_max_freq(unsigned int cpu)
 {
 	return 0;
-- 
2.25.1


