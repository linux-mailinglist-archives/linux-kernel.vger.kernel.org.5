Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3667BD8C8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346085AbjJIKgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345916AbjJIKgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:36:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3B2DB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:36:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-325e9cd483eso4181121f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696847792; x=1697452592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXD0QUw+ffX/G//mljsP8uVRxSPaNtugfzKgqO7nW9U=;
        b=hnyiZ8kx7BATKD47TcsSy9fXoBlQiTLbElApM1luHBCfrVTchy3UUaK2iIBYlMQgFU
         k/TqLI7PtsnQNeNUPMZdf9ESFq8DoMy/mhlSehvtVc/NUYLTt6gehjOPQjYX3+jXGhzY
         PnF9eMW5fHW7eTxgrzlJ2CQ3ppyzfISqPHzJUW1KyrMLooc04n+SQb0nyRp9r+Ysc3fO
         1Tn6QhMDa578reGzRaW71apGOiFvc5X4+yUooK6TtrsqKHzb2okpmj5Jx+qrplm7Hepg
         JfixR2uoI842zbNcRRV+7RWaXNoI6UO+UubLfm7feyxF5d8XOPj3iydEjojuDMvNxfFd
         BF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696847792; x=1697452592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXD0QUw+ffX/G//mljsP8uVRxSPaNtugfzKgqO7nW9U=;
        b=eR3YtwBXLzdpcIeacPvRHp/QbA3JmCAEiSALQCULQQT0pFtOZ7oZoxiZPlwzz95BZA
         ELQpbFxjddPup1GGo13UhWh5TB6G6jUvrxka2MEqPKLatOc2Fr/FST3pygbI7ySXLuK/
         EVVBdH41tHT4jiGO/rsYAqWbLenUHwTxonVozYPguiQzK38Vy+GtRMnOVMb7xfTuloUq
         DqdPSx077tjvsCoYbg1NtvwJiIFUfqX+ZD6N0bXf4NVhH5tqCKi0q1YyC3/h9dxBEM7G
         dHMV7fQ9heWdrW60kZjZ6U3Mqi/TCtj9zCcy43YMG/yVDMAZNQUFaV6bXwpPGce/anrw
         2gpg==
X-Gm-Message-State: AOJu0YwqWeYmJ3DERiC21KhEjVzqjBB3pzbrzNdmKk3qOFG6Alx5vqID
        9MLhePvnSGukBwqLJ0w3Q1+mXA==
X-Google-Smtp-Source: AGHT+IHr3aX+9E7V3PEwqGZuQkX9W7nIP+EyPQGbKJ+lRYHFakcvBtj79RtXlZzvZ8DwRc3af55fNw==
X-Received: by 2002:adf:ed10:0:b0:320:933:4524 with SMTP id a16-20020adfed10000000b0032009334524mr13404865wro.2.1696847792183;
        Mon, 09 Oct 2023 03:36:32 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:53f1:24bc:5e47:821d])
        by smtp.gmail.com with ESMTPSA id f16-20020adfdb50000000b0031ff89af0e4sm9226722wrj.99.2023.10.09.03.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:36:31 -0700 (PDT)
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
Subject: [PATCH v2 5/6] energy_model: use a fixed reference frequency
Date:   Mon,  9 Oct 2023 12:36:20 +0200
Message-Id: <20231009103621.374412-6-vincent.guittot@linaro.org>
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

