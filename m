Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE45C812578
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443058AbjLNCsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbjLNCrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:47:42 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E9C199
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:47:45 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4258e0a0dc1so45301331cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1702522064; x=1703126864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJ8V9wpZFRMaxTJ2Yr+JKkom97NUFELsE8HKkLVd89U=;
        b=tTwcoFrpm1z648NnqZPTYvJRG8qRAP6HhEhissBvfO3WICzlER+W4Tt/oI7kmMIP9f
         cuwJw6erApazvVuJOsmICilQm5tVsJlbPvoBAQY+jE8fhvJ9EEt+aZap7P6j2KrttjT8
         ajUUve1LCghnI3HfHmKzTePg0y6NqTof15pSkJUrVGJfAwkHMmKPcC0ans+73KGvpcm6
         +vIekWNczLtj8PFttljYj4NeVH0bB9j61SwGzwiZr3MnRn4KSJKHnf/9zLNnMWCea1H6
         W5PDTA315RGU9qFRrhFMJ2R7vZiE4BPt4hvi2DwRLOND3Pwhozz5zAjH0glcKaUO+CQn
         3JpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702522064; x=1703126864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJ8V9wpZFRMaxTJ2Yr+JKkom97NUFELsE8HKkLVd89U=;
        b=rqM6SElFgDlutMjfoXuhZfgFLoZwa/4NgQ7ennqGTOawDo0fv+kclxPurXtJ9C/+mz
         BctkTHoWtt744vA0tXKcyRbdfhoSKNtIHJsaoODadIT+2XMXyuw8kzEje6Co+Yc1/iVV
         b3Cram6eg1XjffbLplwHZVGPz7J/gpU8VLFGhkLIPz59kGKpZgQq+dXKqEuiuHIE//hf
         ftqA0G0evydcLQQ20d/p+fAzsOhtA204eZnzxf4/mgMYI8YNFBN2e2jtETCU/FV6rWdP
         x8SD492+UUJHh7bGE7E9N9rHzH4k7Jlzsq5Doa4yEpu2bDEogvMdQd4kL6LNpdjWTz51
         RANA==
X-Gm-Message-State: AOJu0YzY1Dl/8BMyCko7XMX/xuCsk/Mwve1k0Ntx5TFEIsIccvKySe3W
        VMmABZNnhvP/Fe0z7KBp1iupbQ==
X-Google-Smtp-Source: AGHT+IHCsSa54wlj5dnr98DogOBhKgfMGGbDmmsgR6hVaIJ/We5ltJAIKpR8uR1tHmUAsiuMmCDtIg==
X-Received: by 2002:a05:622a:251:b0:418:1088:7d69 with SMTP id c17-20020a05622a025100b0041810887d69mr12636997qtx.18.1702522064725;
        Wed, 13 Dec 2023 18:47:44 -0800 (PST)
Received: from vinp3lin.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id fh3-20020a05622a588300b00425b356b919sm4240208qtb.55.2023.12.13.18.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 18:47:44 -0800 (PST)
From:   "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To:     Ben Segall <bsegall@google.com>, Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>
Cc:     "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Masami Hiramatsu <mhiramat@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [RFC PATCH 8/8] irq: boost/unboost in irq/nmi entry/exit and softirq
Date:   Wed, 13 Dec 2023 21:47:25 -0500
Message-ID: <20231214024727.3503870-9-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214024727.3503870-1-vineeth@bitbyteword.org>
References: <20231214024727.3503870-1-vineeth@bitbyteword.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host proactively boosts the VCPU threads during irq/nmi injection.
However, the host is unaware of posted interrupts, and therefore, the
guest should request a boost if it has not already been boosted.

Similarly, guest should request an unboost on irq/nmi/softirq exit if
the vcpu doesn't need the boost any more.

Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 kernel/entry/common.c | 30 ++++++++++++++++++++++++++++++
 kernel/softirq.c      | 11 +++++++++++
 2 files changed, 41 insertions(+)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index fae56faac0b0..c69912b71725 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -327,6 +327,13 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 		.exit_rcu = false,
 	};
 
+#ifdef CONFIG_PARAVIRT_SCHED
+	instrumentation_begin();
+	if (pv_sched_enabled())
+		pv_sched_boost_vcpu_lazy();
+	instrumentation_end();
+#endif
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 		return ret;
@@ -452,6 +459,18 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		if (state.exit_rcu)
 			ct_irq_exit();
 	}
+
+#ifdef CONFIG_PARAVIRT_SCHED
+	instrumentation_begin();
+	/*
+	 * On irq exit, request a deboost from hypervisor if no softirq pending
+	 * and current task is not RT and !need_resched.
+	 */
+	if (pv_sched_enabled() && !local_softirq_pending() &&
+			!need_resched() && !task_is_realtime(current))
+		pv_sched_unboost_vcpu();
+	instrumentation_end();
+#endif
 }
 
 irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
@@ -469,6 +488,11 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
 	kmsan_unpoison_entry_regs(regs);
 	trace_hardirqs_off_finish();
 	ftrace_nmi_enter();
+
+#ifdef CONFIG_PARAVIRT_SCHED
+	if (pv_sched_enabled())
+		pv_sched_boost_vcpu_lazy();
+#endif
 	instrumentation_end();
 
 	return irq_state;
@@ -482,6 +506,12 @@ void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state)
 		trace_hardirqs_on_prepare();
 		lockdep_hardirqs_on_prepare();
 	}
+
+#ifdef CONFIG_PARAVIRT_SCHED
+	if (pv_sched_enabled() && !in_hardirq() && !local_softirq_pending() &&
+			!need_resched() && !task_is_realtime(current))
+		pv_sched_unboost_vcpu();
+#endif
 	instrumentation_end();
 
 	ct_nmi_exit();
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 807b34ccd797..90a127615e16 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -530,6 +530,11 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	in_hardirq = lockdep_softirq_start();
 	account_softirq_enter(current);
 
+#ifdef CONFIG_PARAVIRT_SCHED
+	if (pv_sched_enabled())
+		pv_sched_boost_vcpu_lazy();
+#endif
+
 restart:
 	/* Reset the pending bitmask before enabling irqs */
 	set_softirq_pending(0);
@@ -577,6 +582,12 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		wakeup_softirqd();
 	}
 
+#ifdef CONFIG_PARAVIRT_SCHED
+	if (pv_sched_enabled() && !need_resched() &&
+			!task_is_realtime(current))
+		pv_sched_unboost_vcpu();
+#endif
+
 	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
 	softirq_handle_end();
-- 
2.43.0

