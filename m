Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B1E7E4C96
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344427AbjKGXNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjKGXMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:12:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E998319B4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:10:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82322C433C8;
        Tue,  7 Nov 2023 23:10:54 +0000 (UTC)
Date:   Tue, 7 Nov 2023 18:10:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 03/86] Revert "ftrace: Use preemption model
 accessors for trace header printout"
Message-ID: <20231107181057.334c815f@gandalf.local.home>
In-Reply-To: <20231107215742.363031-4-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107215742.363031-4-ankur.a.arora@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Nov 2023 13:56:49 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> This reverts commit 089c02ae2771a14af2928c59c56abfb9b885a8d7.

I rather not revert this.

If user space can decided between various version of preemption, then the
trace should reflect that. At least state what the preemption model was when
a trace started, or currently is.

That is, the model may not be "static" per boot. Anyway, the real change here should be:

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7b4b1fcd6f93..2553c4efca15 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2208,14 +2208,6 @@ static inline void cond_resched_rcu(void)
 #endif
 }
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-
-extern bool preempt_model_none(void);
-extern bool preempt_model_voluntary(void);
-extern bool preempt_model_full(void);
-
-#else
-
 static inline bool preempt_model_none(void)
 {
 	return IS_ENABLED(CONFIG_PREEMPT_NONE);
@@ -2229,8 +2221,6 @@ static inline bool preempt_model_full(void)
 	return IS_ENABLED(CONFIG_PREEMPT);
 }
 
-#endif
-
 static inline bool preempt_model_rt(void)
 {
 	return IS_ENABLED(CONFIG_PREEMPT_RT);


Then this way we can decided to make it runtime dynamic, we don't need to
fiddle with the tracing code again.

-- Steve
