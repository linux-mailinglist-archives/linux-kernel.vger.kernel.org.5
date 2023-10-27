Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51CE7D90A3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbjJ0IEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbjJ0IET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:04:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655FF1B3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:04:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso14423105e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698393853; x=1698998653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdB4lDzOqWgKx+jcR+6XZlgYVoJSXQa0m+FGwW4RKJM=;
        b=IzKpjjvZmme+Q2E2K/KLw818QjNRvAaVWMjvBKySUsICuQUL6IkhFw93MJa4p4fWyl
         Hc59EOrKePqLRZE/Ofy++YQZWbd3pz5yKcBu28X3Re123JwtNuJaRRv7A0ULd1ejSXX5
         pMAGwLyvKrdzvOtqrERFEhzTKbe+f0WKNvFCKnWbHdBV9cb3SXt/0+yIb71cDxmHnrDK
         gpzqCRCMQBajZDsIOfsauNBwYMpuZFJIxfr4M8w+wK2fN0VDU6CwJHsvGuuO6hjeWnM+
         XJY030HzckDsG2aW4LbS3wr1CUoZzmD3MfGQyMzADz4TbyjdnKlS9tJF7rbO9Hda8Bez
         r57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698393853; x=1698998653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdB4lDzOqWgKx+jcR+6XZlgYVoJSXQa0m+FGwW4RKJM=;
        b=GGSv8YeBzvs1IAsPFwLka65P74i4XoYHdxo3vtorkA5OnvdmKH83dXIAABCFNttRhH
         QuhH+Kwq80O0/wPnurRSFsYvfGTizAD45s7b93lMWeqfKaMmX7kiQaOa7fV8mw5swkcX
         V4FJkEvM1+JP4hgpZ+f5hcgcAS/dAybqUQJWTDSCy+6PXpBHl/ApiwHodtiXwBEfTaWm
         0bqSo38niQ5d8ZRkKa+lBt8ZlLW+gkomJAI67qFf8MDF8sUQsOYdzaawJIFVFiZvc/ZV
         KLUAyLa2JBffdEneYfxMwNSY1QsKwjEuCGDk/4F0n5gKfK2dGXM4Z4zVjB0hnx+C8rrs
         f4+A==
X-Gm-Message-State: AOJu0Ywag2AkoMO7OrazaPT1CctAbPTOLeqAQvA7vvNhvkZIZvy7P26n
        xNlXzP7muDg6p9sHltxh+tQAyg==
X-Google-Smtp-Source: AGHT+IGrWV8Xk3kn8lNdugKW10Jxvl72LQpr+DY/ZkB+QIZGkVhbRfYWJpxErHANxVy9nJ2+gvLW9g==
X-Received: by 2002:a05:600c:2990:b0:402:ee71:29 with SMTP id r16-20020a05600c299000b00402ee710029mr1624044wmd.10.1698393852695;
        Fri, 27 Oct 2023 01:04:12 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:c5e:e24e:ad0b:58c6])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c025100b004083729fc14sm4397488wmj.20.2023.10.27.01.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:04:12 -0700 (PDT)
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
Subject: [PATCH v4 4/7] energy_model: use a fixed reference frequency
Date:   Fri, 27 Oct 2023 10:03:57 +0200
Message-Id: <20231027080400.56703-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027080400.56703-1-vincent.guittot@linaro.org>
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 include/linux/energy_model.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index b9caa01dfac4..1b0c8490d4bd 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -204,6 +204,14 @@ struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
 	return ps;
 }
 
+#ifndef arch_scale_freq_ref
+static __always_inline
+unsigned int arch_scale_freq_ref(int cpu)
+{
+	return 0;
+}
+#endif
+
 /**
  * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
  *		performance domain
@@ -224,7 +232,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 				unsigned long max_util, unsigned long sum_util,
 				unsigned long allowed_cpu_cap)
 {
-	unsigned long freq, scale_cpu;
+	unsigned long freq, ref_freq, scale_cpu;
 	struct em_perf_state *ps;
 	int cpu;
 
@@ -241,11 +249,11 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 */
 	cpu = cpumask_first(to_cpumask(pd->cpus));
 	scale_cpu = arch_scale_cpu_capacity(cpu);
-	ps = &pd->table[pd->nr_perf_states - 1];
+	ref_freq = arch_scale_freq_ref(cpu);
 
 	max_util = map_util_perf(max_util);
 	max_util = min(max_util, allowed_cpu_cap);
-	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
+	freq = map_util_freq(max_util, ref_freq, scale_cpu);
 
 	/*
 	 * Find the lowest performance state of the Energy Model above the
-- 
2.34.1

