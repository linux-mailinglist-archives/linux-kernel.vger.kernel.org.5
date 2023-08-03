Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E64376F5FF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 01:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjHCXJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 19:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHCXJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 19:09:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B7C26B6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 16:08:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2680a031283so810629a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 16:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691104139; x=1691708939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNXiG+6EV8OwXnhRrPQdCNjbnNILQMj2o240bCG6ptk=;
        b=kE8ymP5/t/LTG1xHHvSAofN+tDFULfBEx3M3ofCKikfVLnGH1FAhLwDGl0v0CXsAkd
         oN6riZmLZlSi/QuLJLNiq+gQzr5mixqu79b3K9cPLA4wkoGPvgKF+Pj5LFV614M6XLlC
         NByup9/KNhLPnSiAxRGI27E/8NKAkCczqBoGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691104139; x=1691708939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNXiG+6EV8OwXnhRrPQdCNjbnNILQMj2o240bCG6ptk=;
        b=QYUHOzpwCps8SS1yWznthABpHXOW8OB3uzPBcAUTU7C781kpsRTfUj2ocigfZLe4vK
         Aluf0OZhd3ouObHq3Zvj6uLNB74NcKycf1ne/xaGpo+r8WkzcrCCJ5ZOCml34Ufjb86u
         ncepRWzImTF0LVeBH0EVktLHt2ryss8+GMR2gfn0S+9lZEBQfGl9cwYqcj1TX3k/YKKp
         F3PnGcur4nAMx/WB0DtWh3umnPDHiYqY90MOaScwwW0gzhmxL8eWNJqQbAj4k73y0ceq
         vSLmmOh3KbPA5Q162EXBZNrfmlcVIo8nCSZ1WOKO+FpCP3EYCul1Vtx8cSvcp8452rfl
         ix9w==
X-Gm-Message-State: AOJu0YybYmPeYCJJasijHZ0WX/lGFQZ3rcWnFwKyCuLYeI2DVY3gXeQM
        TFKw9iXZ7WhuU+Z1erqgYDFEBQ==
X-Google-Smtp-Source: AGHT+IGhJa4Uf73Wyf/maEyF7MKoqqejaCHP+u5PI78a4OR5GSfFS74Uc+Ykewi+MAoMnWug+xjHfw==
X-Received: by 2002:a17:90a:ac2:b0:268:b8e:d202 with SMTP id r2-20020a17090a0ac200b002680b8ed202mr118210pje.18.1691104139160;
        Thu, 03 Aug 2023 16:08:59 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:7e35:e6d0:7bbf:64])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001adf6b21c77sm369405plx.107.2023.08.03.16.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 16:08:58 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, Michal Hocko <mhocko@suse.com>,
        Douglas Anderson <dianders@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] watchdog/hardlockup: Avoid large stack frames in watchdog_hardlockup_check()
Date:   Thu,  3 Aug 2023 16:07:58 -0700
Message-ID: <20230803160649.v3.2.I501ab68cb926ee33a7c87e063d207abf09b9943c@changeid>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230803160649.v3.1.Ia35521b91fc781368945161d7b28538f9996c182@changeid>
References: <20230803160649.v3.1.Ia35521b91fc781368945161d7b28538f9996c182@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 77c12fc95980 ("watchdog/hardlockup: add a "cpu" param to
watchdog_hardlockup_check()") we started storing a `struct cpumask` on
the stack in watchdog_hardlockup_check(). On systems with
CONFIG_NR_CPUS set to 8192 this takes up 1K on the stack. That
triggers warnings with `CONFIG_FRAME_WARN` set to 1024.

We'll use the new trigger_allbutcpu_cpu_backtrace() to avoid needing
to use a CPU mask at all.

Fixes: 77c12fc95980 ("watchdog/hardlockup: add a "cpu" param to watchdog_hardlockup_check()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202307310955.pLZDhpnl-lkp@intel.com
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Rebase on change introducing trigger_allbutcpu_cpu_backtrace().

Changes in v2:
- Allocate space when userspace requests all cpus be backtraced.

 kernel/watchdog.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 085d7a78f62f..d145305d95fe 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -151,9 +151,6 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 	 */
 	if (is_hardlockup(cpu)) {
 		unsigned int this_cpu = smp_processor_id();
-		struct cpumask backtrace_mask;
-
-		cpumask_copy(&backtrace_mask, cpu_online_mask);
 
 		/* Only print hardlockups once. */
 		if (per_cpu(watchdog_hardlockup_warned, cpu))
@@ -167,10 +164,8 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 				show_regs(regs);
 			else
 				dump_stack();
-			cpumask_clear_cpu(cpu, &backtrace_mask);
 		} else {
-			if (trigger_single_cpu_backtrace(cpu))
-				cpumask_clear_cpu(cpu, &backtrace_mask);
+			trigger_single_cpu_backtrace(cpu);
 		}
 
 		/*
@@ -179,7 +174,7 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 		 */
 		if (sysctl_hardlockup_all_cpu_backtrace &&
 		    !test_and_set_bit(0, &watchdog_hardlockup_all_cpu_dumped))
-			trigger_cpumask_backtrace(&backtrace_mask);
+			trigger_allbutcpu_cpu_backtrace(cpu);
 
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
-- 
2.41.0.585.gd2178a4bd4-goog

