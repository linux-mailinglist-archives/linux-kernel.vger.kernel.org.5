Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC94770271
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjHDOBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjHDOBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:01:20 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113FC19AA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:01:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bc02bd4eafso18107875ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 07:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691157676; x=1691762476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ubpHUCUhhdAc9BVTuBszAKxHoy82Y2oolLi025KUkk=;
        b=lM7VVMYBqLq1WWaKyoy1S9d9QHqyvdoAXmQKdUq1F1mGa1KKnkys7Y3zb0ObUNTO/8
         D6/0MKl7nUQQi1/P2oo6KBdOlRmoYlfhATagj8O3Gy9Ejq7iU1iRTCueBRDQc5+jkufs
         Yg6z7jRxvZTeC6ywXmtCoJEaRAjiFYESD7IkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691157676; x=1691762476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ubpHUCUhhdAc9BVTuBszAKxHoy82Y2oolLi025KUkk=;
        b=AFjF1PhYDqrRqzb4gNavo2MGyzkvIePpBJYvAyD5dErBhroZDn058czly6ykgW42Ty
         XzvIrcCfny/OAf43WwCiKNCjKDKnfi5rPU+gZrSDGK4ElB5Sh8Khk5a0K+9Vo58y3Qox
         H0sc50m8SDOtzzN2SGlKUxhGfSd56OByeAEkD4qzkwDBdhaXXY5UzPWRXUoUap/q77dT
         vnHy7FZ9HdcFnNLMO/VHtqadtU+GPccXBKzcr864ZxrTksVAzHV29ZcLNFksSLbybMTr
         iazwtSt4to57ud5+AYppzGtUu5NSFZbKlDq625iEQJsfbLATiqLUI5tZ5HvoCChc7d24
         wLPA==
X-Gm-Message-State: AOJu0Yz9ldFQrDyez6gSNzLJsTM4tWLTi4ngP6YYAQKcJlti87KOS0iN
        pXXHSSYQnV27jiYsMO2I8z5zCw==
X-Google-Smtp-Source: AGHT+IGwhGDiZDDOTvr8SfWARlNUArui6KJ+5vzkYbiDwdAGDh3J/VVZU3YUGwQOkxkMV0HVD3PsXA==
X-Received: by 2002:a17:902:b68c:b0:1bc:2036:5338 with SMTP id c12-20020a170902b68c00b001bc20365338mr1611384pls.28.1691157676198;
        Fri, 04 Aug 2023 07:01:16 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:7e35:e6d0:7bbf:64])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b001b89536974bsm1792291plg.202.2023.08.04.07.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 07:01:14 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, Michal Hocko <mhocko@suse.com>,
        Douglas Anderson <dianders@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] watchdog/hardlockup: Avoid large stack frames in watchdog_hardlockup_check()
Date:   Fri,  4 Aug 2023 07:00:43 -0700
Message-ID: <20230804065935.v4.2.I501ab68cb926ee33a7c87e063d207abf09b9943c@changeid>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230804065935.v4.1.Ia35521b91fc781368945161d7b28538f9996c182@changeid>
References: <20230804065935.v4.1.Ia35521b91fc781368945161d7b28538f9996c182@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
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
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v3)

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

