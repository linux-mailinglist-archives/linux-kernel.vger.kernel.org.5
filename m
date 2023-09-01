Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A414978FDFA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349663AbjIANDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349641AbjIAND1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:03:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73D1E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:03:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31c3726cc45so1663331f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693573403; x=1694178203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5aYZdSdgznaVi+JliScjcxNZSCQD8Th20BQ7P8lBSs=;
        b=hO6xfBmPKBgbuknFzUx9djhsOZtlMuq9HbhytH/CkX7n1a7K7Ppwgg3wSN8ElMwOn2
         /FbUOQZdqcKdECl5sdrAJI50ai9l6fgV6X9+FiZXQyJ9rsO9k6M/q12SFwK/pS8XIg/I
         GY84P/+ugAHDXz5ZaSIiIpSCw0QOVMAm53MtNAfq+M4RvOHwwBOmhHB7L/21qrLWvheL
         ZqyCNDs+JcbhHxBeihuDCzU80XVQd74n5BJ1oblot4ZlKMW78OjjrsvGHwGMhixwGV5t
         VaPNz6qJyPgUbWrPKTDhNdOt1QsHiTXPMVxU9Ks/PqAYsLhu/NHB4i9cpjEjULOMufsa
         j2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693573403; x=1694178203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5aYZdSdgznaVi+JliScjcxNZSCQD8Th20BQ7P8lBSs=;
        b=fwefldzF6Tjk+z30Y40zFEQRokI49eTQGtOVUfx4l8vn7Po0XA/hoejJl9LeQSDzBg
         lO07Bph/vu6NkISN1vFVQ8nCziYg25G3ptz1hGIMN8GYK8DXCTHUvmSH8+FfpKALB2jY
         NrKUtOBGgX90dNJ+ZCMLO+yOzTAWNImwK8/bNOXqF+IflfiEZddIFB3JDxZOdMA9NmTA
         I4/NKyrDkZCGahx6fgWgIDYjCP9mBWWzXGBpRJY8EQo52JSro7mS8iybIyN4XUvPojZL
         ENNBz4kRnaBa8Raf3LRCGvOTgMvnk4VK8abxZo7uYWF4h9RA1Xf1VZk+HmPJnTfNZ2YW
         Zkog==
X-Gm-Message-State: AOJu0YwX3MTnoR4SIOqYtK1onMTv0q1fhmy+PYdzN0meWty2mBSI/wN5
        XWOe0D4nsZWl/XZYP7zWMybtgg==
X-Google-Smtp-Source: AGHT+IHWuDsPZBVeKEf+XTy2vPIdFmCGwE/gsGA3pylPfmUXuPXSa8EeuGjxUHsZSClfbNuuKWlS8Q==
X-Received: by 2002:adf:e544:0:b0:31d:db92:31ae with SMTP id z4-20020adfe544000000b0031ddb9231aemr1715345wrm.44.1693573403268;
        Fri, 01 Sep 2023 06:03:23 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:e9bd:add1:d9ac:7b3e])
        by smtp.gmail.com with ESMTPSA id i14-20020adfdece000000b003142e438e8csm5167452wrn.26.2023.09.01.06.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 06:03:22 -0700 (PDT)
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
Subject: [PATCH 4/4] energy_model: use a fixed reference frequency
Date:   Fri,  1 Sep 2023 15:03:12 +0200
Message-Id: <20230901130312.247719-5-vincent.guittot@linaro.org>
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

The last item of a performance domain is not always the performance point
that has been used to compute CPU's capacity. This can lead to different
target frequency compared with other part of the system like schedutil and
would result in wrong energy estimation.

a new arch_scale_freq_ref() is available to return a fixed and coherent
frequency reference that can be used when computing the CPU's frequency
for an level of utilization. Use this function when available or fallback
to the last performance domain item otherwise.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/energy_model.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index b9caa01dfac4..7ee07be6928e 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -204,6 +204,20 @@ struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
 	return ps;
 }
 
+#ifdef arch_scale_freq_ref
+static __always_inline
+unsigned long  arch_scale_freq_ref_em(int cpu, struct em_perf_domain *pd)
+{
+	return arch_scale_freq_ref(cpu);
+}
+#else
+static __always_inline
+unsigned long  arch_scale_freq_ref_em(int cpu, struct em_perf_domain *pd)
+{
+	return pd->table[pd->nr_perf_states - 1].frequency;
+}
+#endif
+
 /**
  * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
  *		performance domain
@@ -224,7 +238,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 				unsigned long max_util, unsigned long sum_util,
 				unsigned long allowed_cpu_cap)
 {
-	unsigned long freq, scale_cpu;
+	unsigned long freq, ref_freq, scale_cpu;
 	struct em_perf_state *ps;
 	int cpu;
 
@@ -241,11 +255,11 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 */
 	cpu = cpumask_first(to_cpumask(pd->cpus));
 	scale_cpu = arch_scale_cpu_capacity(cpu);
-	ps = &pd->table[pd->nr_perf_states - 1];
+	ref_freq = arch_scale_freq_ref_em(cpu, pd);
 
 	max_util = map_util_perf(max_util);
 	max_util = min(max_util, allowed_cpu_cap);
-	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
+	freq = map_util_freq(max_util, ref_freq, scale_cpu);
 
 	/*
 	 * Find the lowest performance state of the Energy Model above the
-- 
2.34.1

