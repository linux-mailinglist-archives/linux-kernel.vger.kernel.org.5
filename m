Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661FA7E0ED5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjKDK7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 06:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjKDK7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 06:59:24 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D057D59
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 03:59:20 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c50906f941so40985351fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 03:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699095559; x=1699700359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aduCSyHEYIhu+IO52anhhUtjmJcDS68d0TTkBLTxAgE=;
        b=NYAXZEUDPWjiusNBkZ9H9ZywJSGk5TsqkMxvoizsjXl3+eSUBeQFbTgvUVVzxSM4nz
         32dLYfmE20s6/jFNw6Jiuov+MkfGHdmXknmJAjkARtbzAOWI9UE4RZCqP15IAppqfAqX
         dg3jHHHLYiH84U0rN25nrd5cJaGpceKqOTPe3ClOFM7621MQH+A4xH75WhYQUgehGvlo
         cRAPWrFfSYRvWVklHa+3H+sv/NPygojeuWMEISAoNZh0NeZsk5az6bdacjSbDRcNrIsE
         TRG77Pjb9txDtMflGbkj/0DOtXCQKUXj2B5gTJqaogXXCvnZLeC1cBhWK6yQ59OSF+KU
         IFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699095559; x=1699700359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aduCSyHEYIhu+IO52anhhUtjmJcDS68d0TTkBLTxAgE=;
        b=Rq8sOaiwyz6fOHzf/ppJgy7fmIUM2XHJCLM8UVb8gH1t02rJ1TY2k9cOttUND1zOGd
         84bAG/OF2NCF7WbgZJCsm4xspG/73ahQnBGhUmL0QgBl6VSrsrsEbfH288+q/T6xtrIz
         e88glXwNrxxNUhcHQVls0Rh6P9ADtr1EX8SiaxX2yoS+F1/sN4D26A4cH9Kj8bloYFk5
         Wq6wIXA2lZyhIjnusUtFt/Ca9X6MVMZ+pKcxZqgYhsG7hR3yA6ok64Kjs/LvuyXzOfXg
         iQrTJAofo7a+vumYrjyxgHz0iWyOWEym8VflpEA066ODMbSZff8ABgrgEAFuXzk0GREd
         W5xQ==
X-Gm-Message-State: AOJu0Yyzqjcz8kdRQvoHCTqiczvDO4ruUNcOkD+vPkJEOk188VHgzsNi
        AptN7fw5hA2q9N+VeH4AsxpQ6A==
X-Google-Smtp-Source: AGHT+IEKPOs60LYQNjgCF6O3RJzRkpTLUhSiH7KaHbkzBZx3/tQp4+sLFyShZ9/I8RYwzr2SsuMl7w==
X-Received: by 2002:a05:651c:1052:b0:2c5:1045:71cb with SMTP id x18-20020a05651c105200b002c5104571cbmr17415933ljm.32.1699095558043;
        Sat, 04 Nov 2023 03:59:18 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:3172:eb13:5bac:126a])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b004053a6b8c41sm5315809wmq.12.2023.11.04.03.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 03:59:17 -0700 (PDT)
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
Subject: [PATCH v5 4/7] energy_model: Use a fixed reference frequency
Date:   Sat,  4 Nov 2023 11:59:04 +0100
Message-Id: <20231104105907.1365392-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104105907.1365392-1-vincent.guittot@linaro.org>
References: <20231104105907.1365392-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

