Return-Path: <linux-kernel+bounces-7438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B5C81A7EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F690286953
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D754AF6B;
	Wed, 20 Dec 2023 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rm/li2ew"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDA34A9B3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3aa0321b5so1291455ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703107031; x=1703711831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqMAcmRjFD5lYv9eaz6Li/2mY5/nRWhBk3z0a51JdoE=;
        b=Rm/li2ewUQ2jK1rUJEjKu5kv4mMWZiKi+s0VsGzL71uSuDmezamhntuxbQUmlSoHCQ
         q6kPeX2kxU8+X4UF1/rg9Hi3nUpMPDGzMk1lfG5D8h1BIXxw17Uu166+p5aXFxkBQfmm
         ktpEbQicnMv5ns1or4ClMoLB/uaGq3beS9jcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703107031; x=1703711831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqMAcmRjFD5lYv9eaz6Li/2mY5/nRWhBk3z0a51JdoE=;
        b=YUWmzYnxHLVFRV/EAoYhA5329UD9Ju5Pin4CDFnvAL7DgJheQGjwqWTUoYyCe4vCIq
         EeuKL6JR5K3BjtoHQr1MQbzv1XOtqgIWsQMiOOj9MvsC7b1w+6hl6rpec2mKuyLY7M+6
         ev3CpE9CkLLaPkmVKS/4CfkXsHKpIH7sQh2EiEFs2UWmDW62c3UTtN+5RpnLurz80egc
         rSRbgnKoIi/k8CLWJ4leUpKDUBqGIGJF/OelPFtBA4Cdjuu+LZlmkqRxIwQOBm0GzCQ0
         fZZ+zuA/T+vvnJ8o9Tj9sNGId8u2vQFBQGsCW46qTh/5WQNbq7Y8wdswQuEWWkVoiWjA
         Jzsw==
X-Gm-Message-State: AOJu0YzXHFZeHHEcsYYIbX9JpylXhCm/l4y20u2kB8e3p1JB/HhzCsOO
	f3LKU53JDPlnYZnitsGQpTBs0VY2ulpxUweYi34=
X-Google-Smtp-Source: AGHT+IHiT2pM/zIM7SEA7jKcjzR0uskgBKayIOmSJ+RyhBRQQ2xNi/wESLtEkm0sR2Q1jxnvPlu0Fw==
X-Received: by 2002:a17:903:496:b0:1d4:445:ba7b with SMTP id jj22-20020a170903049600b001d40445ba7bmr24892plb.36.1703107031029;
        Wed, 20 Dec 2023 13:17:11 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5a22:d46c:eec1:e5d4])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902b28a00b001d3dfebc05esm175023plr.21.2023.12.20.13.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:17:10 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Li Zhe <lizhe.67@bytedance.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Lecopzer Chen <lecopzer.chen@mediatek.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] watchdog/hardlockup: Use printk_cpu_sync_get_irqsave() to serialize reporting
Date: Wed, 20 Dec 2023 13:15:36 -0800
Message-ID: <20231220131534.3.I6ff691b3b40f0379bc860f80c6e729a0485b5247@changeid>
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

If two CPUs end up reporting a hardlockup at the same time then their
logs could get interleaved which is hard to read.

The interleaving problem was especially bad with the "perf" hardlockup
detector where the locked up CPU is always the same as the running CPU
and we end up in show_regs(). show_regs() has no inherent
serialization so we could mix together two crawls if two hardlockups
happened at the same time (and if we didn't have
`sysctl_hardlockup_all_cpu_backtrace` set). With this change we'll
fully serialize hardlockups when using the "perf" hardlockup detector.

The interleaving problem was less bad with the "buddy" hardlockup
detector. With "buddy" we always end up calling
`trigger_single_cpu_backtrace(cpu)` on some CPU other than the running
one. trigger_single_cpu_backtrace() always at least serializes the
individual stack crawls because it eventually uses
printk_cpu_sync_get_irqsave(). Unfortunately the fact that
trigger_single_cpu_backtrace() eventually calls
printk_cpu_sync_get_irqsave() (on a different CPU) means that we have
to drop the "lock" before calling it and we can't fully serialize all
printouts associated with a given hardlockup. However, we still do get
the advantage of serializing the output of print_modules() and
print_irqtrace_events().

Aside from serializing hardlockups from each other, this change also
has the advantage of serializing hardlockups and softlockups from each
other if they happen to happen at the same time since they are both
using the same "lock".

Even though nobody is expected to hang while holding the lock
associated with printk_cpu_sync_get_irqsave(), out of an abundance of
caution, we don't call printk_cpu_sync_get_irqsave() until after we
print out about the hardlockup. This makes extra sure that, even if
printk_cpu_sync_get_irqsave() somehow never runs we at least print
that we saw the hardlockup. This is different than the choice made for
softlockup because hardlockup is really our last resort.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/watchdog.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 526041a1100a..11f9577accca 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -151,6 +151,7 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 	 */
 	if (is_hardlockup(cpu)) {
 		unsigned int this_cpu = smp_processor_id();
+		unsigned long flags;
 
 		/* Only print hardlockups once. */
 		if (per_cpu(watchdog_hardlockup_warned, cpu))
@@ -165,7 +166,17 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 				return;
 		}
 
+		/*
+		 * NOTE: we call printk_cpu_sync_get_irqsave() after printing
+		 * the lockup message. While it would be nice to serialize
+		 * that printout, we really want to make sure that if some
+		 * other CPU somehow locked up while holding the lock associated
+		 * with printk_cpu_sync_get_irqsave() that we can still at least
+		 * get the message about the lockup out.
+		 */
 		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n", cpu);
+		printk_cpu_sync_get_irqsave(flags);
+
 		print_modules();
 		print_irqtrace_events(current);
 		if (cpu == this_cpu) {
@@ -173,7 +184,9 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 				show_regs(regs);
 			else
 				dump_stack();
+			printk_cpu_sync_put_irqrestore(flags);
 		} else {
+			printk_cpu_sync_put_irqrestore(flags);
 			trigger_single_cpu_backtrace(cpu);
 		}
 
-- 
2.43.0.472.g3155946c3a-goog


