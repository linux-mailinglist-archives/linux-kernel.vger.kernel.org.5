Return-Path: <linux-kernel+bounces-122537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B9488F924
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824C91C2502F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784E5D8FD;
	Thu, 28 Mar 2024 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VefAOzEl"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D15B1E3;
	Thu, 28 Mar 2024 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612278; cv=none; b=sRETaakQfKJa8DOUHEnU1gu2jed4bzVCEWhwb6VcwY0XeGCgjdcUBQ/IlR8xwBERxftYEBDUVrGsw0FDMpbee1ReXAdNhoR2lLjXW3KDoRXS6DNr7UJqN2REYwfAqbtpQY3ESdnFEmJyopd48gG6pvmL97xuRGORWQIvtPVdmdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612278; c=relaxed/simple;
	bh=N3g/1gJrg9TfDFHDhZDcoAnyjd3OaQOWBx3iO3g+BTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NUBRrT/N/EVtpxVrQgWH3RR/ogUz7wY0EEng1rwHYJVoz0rll5gzjpMasMoKeN10GnqXxzxK/eKtoZHrezgn9FHb4oNC1ugkWvez6RW4RVXff5Tz8Zfn0DCwNVnw72hc8VeLtaoeF5PCQnenleM06rhmfh7hUp9q/AWHKfG25qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VefAOzEl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6eac64f2205so598209b3a.2;
        Thu, 28 Mar 2024 00:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711612276; x=1712217076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZNpgupDg2bfZqoYSY4w9xqU9rN1cJ0j5BbUJd8co30=;
        b=VefAOzElDp++U70u98m1ge/rw+6oF+FFgwC/63cnPNFC/f3dlCHMI5IR3wVsOJNGzS
         j8zrfeJHWdVtLAwS9tRxsCd6Mb8CVnH2vJTNg67F6q89OatooniDd2onJJ95/Gh/OapN
         mgw0j1xuPqNwqnEICD/dwc/DNUoiJVVYPsAWMqJQfCd27vHxngKeMPCLtKOSB/UUAcLG
         3Wn0JMnKatgLOCrz4DPzjM7rLw75lEM8Zg8rNSvpCW0EJ39UbQATNp7OFCgzvrHKcKMX
         xgmILeEGhcyf3bwoOfsU/zFeEQqgaynjloof6DPj5dB/JQsXwd3zX9vbYc7uEJr/tOnW
         px3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612276; x=1712217076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZNpgupDg2bfZqoYSY4w9xqU9rN1cJ0j5BbUJd8co30=;
        b=G/ke1aEPOu/YkNZjSjTOt1jrQkhIrN5oKBT6D6XqIzfg50Y//XmBTJj2UOGh77zGlm
         n1WTDoJrpg7y6gzxPsNaNCTEpuq1k5q76XtMp8L8M3RFlPCJlPjANyhWQ08yft/c5rd7
         5YHwW1i0jU9OkiXkimjf3lYfsr5tKAkf8yNcUD5G/zptJHAvk1txAnf+Z56ug8z7oG9a
         SUO5xjgWv8RefpnVcpXIXOfxcENf4TPNA2aE969xPtIplHrB+QOvGJxC/VqeaAozHDfa
         wCYyrLDHpC51gsRERDTdqQ/IcDsacbqUQn/Li1M0he8kCcsqa6/k/Tlesw/f24WDfh4N
         /hlw==
X-Gm-Message-State: AOJu0YwUQY9AsFevOtdgDM2PFA+kax3p7KxqHaFHX/DB1EO4NHX2ndom
	HvE+mEilaivn1INzEmCwz+rKAA1yLfIVA/tQFnK0s8W30hAseS1GgVCtYXSO
X-Google-Smtp-Source: AGHT+IEIaoWEFLOj5YGQX0oavQNxsIj6yrF25pRpP3Mp20xsQmW90Qs/s+goFqivAkIitJ0zpE6Mdw==
X-Received: by 2002:a05:6a00:1d08:b0:6ea:df40:8a18 with SMTP id a8-20020a056a001d0800b006eadf408a18mr93965pfx.16.1711612275673;
        Thu, 28 Mar 2024 00:51:15 -0700 (PDT)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79f05000000b006eac4d7b2e1sm746500pfr.113.2024.03.28.00.51.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2024 00:51:15 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 07/10] sched/core: Add rcu_preempt_switch()
Date: Thu, 28 Mar 2024 15:53:15 +0800
Message-Id: <20240328075318.83039-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240328075318.83039-1-jiangshanlai@gmail.com>
References: <20240328075318.83039-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

When the per-cpu rcu_preempt_count is used, it has to be switched too
on context-switching.  And the instructions to switch the per-cpu
rcu_preempt_count are meager, so it is inlined to avoid the overhead
in the scheduler.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/rcu/rcu.h    | 5 +++++
 kernel/sched/core.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index b17b2ed657fc..ea5ae957c687 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -668,4 +668,9 @@ int rcu_stall_notifier_call_chain(unsigned long val, void *v);
 static inline int rcu_stall_notifier_call_chain(unsigned long val, void *v) { return NOTIFY_DONE; }
 #endif // #else // #if defined(CONFIG_RCU_STALL_COMMON) && defined(CONFIG_RCU_CPU_STALL_NOTIFIER)
 
+static inline void
+rcu_preempt_switch(struct task_struct *prev, struct task_struct *next)
+{
+}
+
 #endif /* __KERNEL_RCU_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d44efa0d0611..7c3fedd9180c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -95,6 +95,7 @@
 #include "../workqueue_internal.h"
 #include "../../io_uring/io-wq.h"
 #include "../smpboot.h"
+#include "../rcu/rcu.h"
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpu);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpumask);
@@ -6727,6 +6728,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		 */
 		++*switch_count;
 
+		rcu_preempt_switch(prev, next);
 		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
-- 
2.19.1.6.gb485710b


