Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D4180C721
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjLKKtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjLKKtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:49:02 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B43BEA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:49:07 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3334254cfa3so2342256f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702291746; x=1702896546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19YdKXep2h2XKs9tI+n1uE2b2ri9zL5T7djiTxR5FZs=;
        b=caxgzVPWvGkUC4/QPdofkQlRsb5EcFWebyQalIeP2tPQI7TEDFpFgOIFHE2bL4QdGk
         w/q+KH3lrWW0RdMxQ4eQ79Wh8VrIWWLOiHm+KLYn/zMNNBmbrMMrhH3Z3CZyEAPUhOtm
         H80WTj4mj3crsdN807njsgqWOP2i5e1z33UXPOZ9by2x6/AnLvo3CFoHDg4MjKXWkG5U
         xuqH5LZ5+5r8J9p058PxhoKi+dMN1BgaMgdkTfgFx9s0/Sxn3sqwN+/I11je7OIMnMq8
         GPsbWD1zX42XvWVsYFnvLwLhivPAPt2GzNBB3DQw1arXlSUp2OmXtsLWSoNsI6lSy0cO
         KyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291746; x=1702896546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19YdKXep2h2XKs9tI+n1uE2b2ri9zL5T7djiTxR5FZs=;
        b=syRplrZIDaKMPermPjztxDR+vW8QrUoeIl6tZ+8cfcRjB7SYQ1ajbH6fkra+fUmidD
         YtGvVcChkDVQ47HzFI3YenA0aoTgwxcmF19WNzAbtogf5Ng+RVeixitxydo/6M31qC31
         1lgXmsGdnJQu2NJTIqcu1SV8Ct8Tp6WlXLiPhLDMauk7pR/RcmmhZXsFu6JcIWaKxUzp
         nDdxCvGE8PFxAN8yvSz2+egtAmRxLTS84veqFAr2N/zWDTpoi/Gou7c+t+ZWPBrXuXjy
         NYITKlga2QXe2GoEPvwQXh8CiJEEQM0a5RZZFilv7y7cbVoebWh1vM+edRKAesPJmOYP
         k8Lw==
X-Gm-Message-State: AOJu0YwJOD6edUOkCxr4o4gYgXBfeePYt1+GmyG6V7WUvwfQFRfbyRQ0
        JfTT9BWxL1yYmSMRIWPPAQS/Eg==
X-Google-Smtp-Source: AGHT+IE6XqYGAPzyGfJojSMGYv4TCKNLa8KTkknwn96//z5+sFb+KJ1vbQvECdNkL4zdYu7uN7TYyg==
X-Received: by 2002:adf:f3cf:0:b0:333:3d26:7b01 with SMTP id g15-20020adff3cf000000b003333d267b01mr3106219wrp.13.1702291745981;
        Mon, 11 Dec 2023 02:49:05 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a8d:abc:f0ae:3066])
        by smtp.gmail.com with ESMTPSA id e16-20020adffd10000000b003346db01263sm8232579wrr.104.2023.12.11.02.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:49:05 -0800 (PST)
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
Subject: [PATCH v7 4/7] energy_model: Use a fixed reference frequency
Date:   Mon, 11 Dec 2023 11:48:52 +0100
Message-Id: <20231211104855.558096-5-vincent.guittot@linaro.org>
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

The last item of a performance domain is not always the performance point
that has been used to compute CPU's capacity. This can lead to different
target frequency compared with other part of the system like schedutil and
would result in wrong energy estimation.

A new arch_scale_freq_ref() is available to return a fixed and coherent
frequency reference that can be used when computing the CPU's frequency
for an level of utilization. Use this function to get this reference
frequency.

Energy model is never used without defining arch_scale_freq_ref() but
can be compiled. Define a default arch_scale_freq_ref() returning 0
in such case.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index adec808b371a..88d91e087471 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -224,7 +224,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 				unsigned long max_util, unsigned long sum_util,
 				unsigned long allowed_cpu_cap)
 {
-	unsigned long freq, scale_cpu;
+	unsigned long freq, ref_freq, scale_cpu;
 	struct em_perf_state *ps;
 	int cpu;
 
@@ -241,10 +241,10 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 */
 	cpu = cpumask_first(to_cpumask(pd->cpus));
 	scale_cpu = arch_scale_cpu_capacity(cpu);
-	ps = &pd->table[pd->nr_perf_states - 1];
+	ref_freq = arch_scale_freq_ref(cpu);
 
 	max_util = min(max_util, allowed_cpu_cap);
-	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
+	freq = map_util_freq(max_util, ref_freq, scale_cpu);
 
 	/*
 	 * Find the lowest performance state of the Energy Model above the
-- 
2.34.1

