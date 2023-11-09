Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835637E6797
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjKIKPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjKIKPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:15:08 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BB130C5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:14:55 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4083f613275so4555865e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 02:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699524894; x=1700129694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aduCSyHEYIhu+IO52anhhUtjmJcDS68d0TTkBLTxAgE=;
        b=B2XoNOc/UvEkRo9hxP5p1Y+/rylqTlP3mpJpsnqcRVhqXeUBHOrpDAr/QbiG4v0gac
         KbITUVpfPRbT7B2PCPJpKJ44jFCcIwxQr6IiwXs2MLAScSMyildYvBopvyezCP1E0q9m
         BGDj7nYrYa+dWF7na8dtTgGOBic5lJpmdxpY2oDmjYv7l7W4GYLUMZ0nd6mqII+t7GZi
         yIzwyAnQHmLIqZ88AuJvLuyknLFegie3phbl4pVTE7JKnCIqhFUZ0y3hb+ckUwyzt1h8
         Ip6Fwb5153oFvDGCmBa03thse64naSSLLxF2YV5nZdxlcK+vOqBZNZKAvAMgXK4a2JyP
         xNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524894; x=1700129694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aduCSyHEYIhu+IO52anhhUtjmJcDS68d0TTkBLTxAgE=;
        b=CyeaD/tSed5ULDuOPMxr9DYTezgKrig00P/dTNNrxLINaSYyZF+yv7+nK7p77EMvJq
         k41tjIY30Yb2TWvzQ2iiWbfbrBX4wjl+6UQjVlCPacfnNcf6Ecw0Rs+R82QnTYA5ebYf
         yx48gZjfbJwFyps+1LSQyqVhorOqSbr0RlaiUzsEgRJs4ScaDJV9m723xZ6RWyV/q1Mf
         5owYD5a2tvI2FIB5CWLCB8HtMQSlNcXEKlR4S5ajUV1N3tIwI5EtzxbtOtPtXCr6tB+G
         tQ3Ey+4rC+7SOjz5x0Q5+VFQ0AA5PxEIG4RF0WF1+b0E7RVDUKC2NpMmOnALz8p1Ha1f
         hv3A==
X-Gm-Message-State: AOJu0YwhqmH55W0m9oSdKh6lNg4IfUuup4r5fXwiJWZH4yH88j2jPsiL
        rchNw3EZicB2dP+EHMepukOhCQ==
X-Google-Smtp-Source: AGHT+IEYIB6ScZWDEgpcZ/S2cHjVchJEeCFHQxgRNVNplqpr7l/I6Xe67qLyHn6zzj6QW+TyS8tvqg==
X-Received: by 2002:a1c:7516:0:b0:40a:28b1:70f8 with SMTP id o22-20020a1c7516000000b0040a28b170f8mr3876852wmc.21.1699524893988;
        Thu, 09 Nov 2023 02:14:53 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:26e5:c6da:63bc:dd99])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c4f5100b003fefb94ccc9sm1611816wmq.11.2023.11.09.02.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:14:53 -0800 (PST)
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
Subject: [PATCH v6 4/7] energy_model: Use a fixed reference frequency
Date:   Thu,  9 Nov 2023 11:14:35 +0100
Message-Id: <20231109101438.1139696-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109101438.1139696-1-vincent.guittot@linaro.org>
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index b9caa01dfac4..c19e7effe764 100644
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
 
@@ -241,11 +241,11 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
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

