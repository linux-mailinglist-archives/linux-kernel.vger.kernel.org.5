Return-Path: <linux-kernel+bounces-7436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3839981A7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AD89B23A39
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1966349885;
	Wed, 20 Dec 2023 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MgJD/Z3U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E7C495CE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3dee5f534so9098485ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703107026; x=1703711826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1CDklyqCRANoyYKv7Digk6bbgZ534wMCluTfdczIuw=;
        b=MgJD/Z3UnTeItdFfsGqEyxxSFlGTUtQ6xL2moU4MO/TcdgyUQRXTU+jRyvUDLTaMkP
         sOcjH3DXZ+mc3XTVAK567F5grC4UZufmQNXphmdjfI3OqkoYLys0AnYUC+HvJpQkEbdd
         0wO1G+a1lsQIyhsQnDZCVCXQ7XA3zARvR71Fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703107026; x=1703711826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1CDklyqCRANoyYKv7Digk6bbgZ534wMCluTfdczIuw=;
        b=UZ4lZxiR4d4OieR1I+jLOukEPSOaaWiYYXuWhvnUG6rayLBweyWbAXwS+oYpdlZv4p
         iXy7Ux0ndKNJj/zvN5kIzdXWP2f+xLnG4SW106CxETyJFKNlv3pUMwmslZavpH9IhnIT
         540r+G9yNZKwvWm5fpEsCNAKWzrw1o8HeDwhG1CB+4abwDGjqqD7hHBzkGzQIlvpfO91
         lkEikQxGPKupTIovF2Iow5sCIW3M9OQdmRsKr6tLsp7xT5Qlp9dYptpX5tkE2Ujqs2HE
         2V+2yJCpnFn58gFLdEQIPn/DtDgPbGYvpmseNIhdV73b2Yfpctg4tLSJv89I1X4RQXGh
         w4sA==
X-Gm-Message-State: AOJu0YypVMTZYn7HtEWMfECMoWqOwwedWsDNl+PygCwPGlWHxWK/FwiC
	47y6V7WzmuqNnVhR76Aj1SiFeg==
X-Google-Smtp-Source: AGHT+IG1+hNe6AZ8nrjh+nxE2uTo64+F0hmVK7+/1GxKBw9whzadq/uppDOX7bJc5sb6qxLBe9FLKA==
X-Received: by 2002:a17:902:e543:b0:1d0:bf4c:166c with SMTP id n3-20020a170902e54300b001d0bf4c166cmr4634775plf.1.1703107026411;
        Wed, 20 Dec 2023 13:17:06 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5a22:d46c:eec1:e5d4])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902b28a00b001d3dfebc05esm175023plr.21.2023.12.20.13.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:17:05 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Li Zhe <lizhe.67@bytedance.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Lecopzer Chen <lecopzer.chen@mediatek.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] watchdog/hardlockup: Adopt softlockup logic avoiding double-dumps
Date: Wed, 20 Dec 2023 13:15:34 -0800
Message-ID: <20231220131534.1.I4f35a69fbb124b5f0c71f75c631e11fabbe188ff@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231220211640.2023645-1-dianders@chromium.org>
References: <20231220211640.2023645-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardlockup detector and softlockup detector both have the ability
to dump the stack of all CPUs (`kernel.hardlockup_all_cpu_backtrace`
and `kernel.softlockup_all_cpu_backtrace`). Both detectors also have
some logic to attempt to avoid interleaving printouts if two CPUs were
trying to do dumps of all CPUs at the same time. However:
- The hardlockup detector's logic still allowed interleaving some
  information. Specifically another CPU could print modules and dump
  the stack of the locked CPU at the same time we were dumping all
  CPUs.
- In the case where `kernel.hardlockup_panic` was set in addition to
  `kernel.hardlockup_all_cpu_backtrace`, when two CPUs both detected
  hardlockups at the same time the second CPU could call panic() while
  the first was still dumping stacks. This was especially bad if the
  locked up CPU wasn't responding to the request for a backtrace since
  the function nmi_trigger_cpumask_backtrace() can wait up to 10
  seconds.

Let's resolve this by adopting the softlockup logic in the hardlockup
handler.

NOTES:
- As part of this, one might think that we should make a helper
  function that both the hard and softlockup detectors call. This
  turns out not to be super trivial since it would have to be
  parameterized quite a bit since there are separate global variables
  controlling each lockup detector and they print log messages that
  are just different enough that it would be a pain. We probably don't
  want to change the messages that are printed without good reason to
  avoid throwing log parsers for a loop.
- One might also think that it would be a good idea to have the
  hardlockup and softlockup detector use the same global variable to
  prevent interleaving. This would make sure that softlockups and
  hardlockups can't interleave each other. That _almost_ works but has
  a dangerous flaw if `kernel.hardlockup_panic` is not the same as
  `kernel.softlockup_panic` because we might skip a call to panic() if
  one type of lockup was detected at the same time as another.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/watchdog.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index bf30a6fac665..b4fd2f12137f 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -91,7 +91,7 @@ static DEFINE_PER_CPU(atomic_t, hrtimer_interrupts);
 static DEFINE_PER_CPU(int, hrtimer_interrupts_saved);
 static DEFINE_PER_CPU(bool, watchdog_hardlockup_warned);
 static DEFINE_PER_CPU(bool, watchdog_hardlockup_touched);
-static unsigned long watchdog_hardlockup_all_cpu_dumped;
+static unsigned long hard_lockup_nmi_warn;
 
 notrace void arch_touch_nmi_watchdog(void)
 {
@@ -156,6 +156,15 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 		if (per_cpu(watchdog_hardlockup_warned, cpu))
 			return;
 
+		/*
+		 * Prevent multiple hard-lockup reports if one cpu is already
+		 * engaged in dumping all cpu back traces.
+		 */
+		if (sysctl_hardlockup_all_cpu_backtrace) {
+			if (test_and_set_bit_lock(0, &hard_lockup_nmi_warn))
+				return;
+		}
+
 		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n", cpu);
 		print_modules();
 		print_irqtrace_events(current);
@@ -168,13 +177,10 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 			trigger_single_cpu_backtrace(cpu);
 		}
 
-		/*
-		 * Perform multi-CPU dump only once to avoid multiple
-		 * hardlockups generating interleaving traces
-		 */
-		if (sysctl_hardlockup_all_cpu_backtrace &&
-		    !test_and_set_bit(0, &watchdog_hardlockup_all_cpu_dumped))
+		if (sysctl_hardlockup_all_cpu_backtrace) {
 			trigger_allbutcpu_cpu_backtrace(cpu);
+			clear_bit_unlock(0, &hard_lockup_nmi_warn);
+		}
 
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
-- 
2.43.0.472.g3155946c3a-goog


