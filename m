Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F88D769C1D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjGaQSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjGaQSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:18:44 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB2CA7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:18:43 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686fc0d3c92so2854017b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690820323; x=1691425123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GhiRHD7MGLBXP1VVMZrWj/GEp3TvN2QnfmjjsFZrIfA=;
        b=QroKgH8Fk4/HPx94jc6GG+5dpU56WuWL6YBlRv9nVlWvNBo28U6FVp44VS8MyVuwhO
         rwN55md7D6yc2NTkNCB3o5PWoPw6ChqF8UYDTTOKwAcUglEQl4GcARsVM77asIGGq0iN
         a5u3NkcdThwEhCKf8lZpyP4myIHD2TuYXAqMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690820323; x=1691425123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhiRHD7MGLBXP1VVMZrWj/GEp3TvN2QnfmjjsFZrIfA=;
        b=lc3BZ4uNiLnALtvpX8CTJPv6CdRxMElCAigwUIQSMYZqGmNkfgdC/25+eEPRs8BTCX
         gEDEo0Mu/ZXYTMaSyXyikT1wLC/VzN3wLhaGmohyCsTeTNWGZjYyywSLpPeU2XkAuHAL
         1POmafJ27x3+KEfrdaYpmOCGiduBnYWX+SgSebgm57CqUOkBdABsREDQM+VfwXTjsS6y
         o812KM4iVZ8ghQRZlRC9Psra0Ro52sJsBQowDi6tl0GmMc+FNpWY4dXRV5kz4GkftatB
         WTVWTz3etYysGcUBClxcA15+n+M9p2123PJvk+o3I9Cq1ajnNtG/5P+Yl8qMmk2d55iZ
         a7Dw==
X-Gm-Message-State: ABy/qLb5IEaELQKoGmIuJjBi29l0TOzUio+n4lQIPKTftf/eghYsGdrI
        ooA5ROYmdSUfNBMyMdP7SfP3pNbqlSGsbEEqIh0=
X-Google-Smtp-Source: APBJJlFCrkJWb5iOFGXS401MJ2VzMG+16vEmMtfLstl8VheKuHC90AeOXpK8yLVIe6wxPO2wQpKhcg==
X-Received: by 2002:a05:6a00:8d6:b0:668:711a:7d93 with SMTP id s22-20020a056a0008d600b00668711a7d93mr11051327pfu.19.1690820323375;
        Mon, 31 Jul 2023 09:18:43 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:7a1d:1020:ba0a:6394])
        by smtp.gmail.com with ESMTPSA id q20-20020a62ae14000000b00672ea40b8a9sm7987724pff.170.2023.07.31.09.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 09:18:42 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Douglas Anderson <dianders@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog/hardlockup: Avoid large stack frames in watchdog_hardlockup_check()
Date:   Mon, 31 Jul 2023 09:17:59 -0700
Message-ID: <20230731091754.1.I501ab68cb926ee33a7c87e063d207abf09b9943c@changeid>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
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

Instead of putting this `struct cpumask` on the stack, let's declare
it as `static`. This has the downside of taking up 1K of memory all
the time on systems with `CONFIG_NR_CPUS` to 8192, but on systems with
smaller `CONFIG_NR_CPUS` it's not much emory (with 128 CPUs it's only
16 bytes of memory). Presumably anyone building a system with
`CONFIG_NR_CPUS=8192` can afford the extra 1K of memory.

NOTE: as part of this change, we no longer check the return value of
trigger_single_cpu_backtrace(). While we could do this and only call
cpumask_clear_cpu() if trigger_single_cpu_backtrace() didn't fail,
that's probably not worth it. There's no reason to believe that
trigger_cpumask_backtrace() will succeed at backtracing the CPU when
trigger_single_cpu_backtrace() failed.

Alternatives considered:
- Use kmalloc with GFP_ATOMIC to allocate. I decided against this
  since relying on kmalloc when the system is hard locked up seems
  like a bad idea.
- Change the arch_trigger_cpumask_backtrace() across all architectures
  to take an extra parameter to get the needed behavior. This seems
  like a lot of churn for a small savings.

Fixes: 77c12fc95980 ("watchdog/hardlockup: add a "cpu" param to watchdog_hardlockup_check()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202307310955.pLZDhpnl-lkp@intel.com
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/watchdog.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index be38276a365f..19db2357969a 100644
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
@@ -178,8 +173,13 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 		 * hardlockups generating interleaving traces
 		 */
 		if (sysctl_hardlockup_all_cpu_backtrace &&
-		    !test_and_set_bit(0, &watchdog_hardlockup_all_cpu_dumped))
+		    !test_and_set_bit(0, &watchdog_hardlockup_all_cpu_dumped)) {
+			static struct cpumask backtrace_mask;
+
+			cpumask_copy(&backtrace_mask, cpu_online_mask);
+			cpumask_clear_cpu(cpu, &backtrace_mask);
 			trigger_cpumask_backtrace(&backtrace_mask);
+		}
 
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
-- 
2.41.0.487.g6d72f3e995-goog

