Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A1378B9C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjH1Ux1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjH1UxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:53:09 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9B911A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:53:06 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34deab8010dso361525ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693255986; x=1693860786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6EHvhYNt+YdRhsmSbNDmpyOVgrF3DogD6lN7EDypwxg=;
        b=fUyGPpig19ciAcQynM5TiTE3a40epaqfni/gNELFb5tc1i1ZByAz4rt/CujuRxITrX
         uEOxX8K4G5OFl2xChFLTHWX/obMq4aUWF77Bp6CWd4plBSLrkymkEEfauakLysTCH1Xn
         vcYGEALttnHeWZhI0/UmxNrXf3IOAeAKlFbn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693255986; x=1693860786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EHvhYNt+YdRhsmSbNDmpyOVgrF3DogD6lN7EDypwxg=;
        b=Ycqt22LGqU1WWQR8sNKqXEAMLLhHy/e96FeZTzA6+MlWMOApFgv5CnIyWyP7qTsp30
         e+4/RDCEh3W9fJLbXhgJFtU1nbdfq8tsHwRTWYTH29AT/KoM7PrEKyPetiCizRjucub4
         GV2rEmo4WdtCGzNQDajrUw/EXA7AyWb71O2ZDuc2OliNJFkevcmsHC5icn7Mq5SF2rJb
         IKBH2/T8OjFXQuwLMzisPx/AYLa9maTfkKtxM0QnBtGZzrnhGFni3wkcC6jxGqIVLyAP
         B+09dRyLmxKJRNnT5bqVZ/Ka9XixxP3hDX6nJvkdivXG9learKE8SPQL20OJyzU20J9K
         fDeQ==
X-Gm-Message-State: AOJu0YyAq7Iyiw6MGruT4/XaKi6f4UfzppmDQ3slzP5at6l7Qo30hmMZ
        GzlriuAn+dKw2OEOTHAsfyjePA==
X-Google-Smtp-Source: AGHT+IFKePN5jQUllnPWZpOthmuFkVluxrH6XoeS0AmoQO9fLpkllywkeTVAIWDXE5M2PoyafqTulA==
X-Received: by 2002:a92:caca:0:b0:34a:c61f:9e99 with SMTP id m10-20020a92caca000000b0034ac61f9e99mr17646978ilq.9.1693255985709;
        Mon, 28 Aug 2023 13:53:05 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (74.120.171.34.bc.googleusercontent.com. [34.171.120.74])
        by smtp.gmail.com with ESMTPSA id i15-20020a02cc4f000000b0039deb26853csm2744432jaq.10.2023.08.28.13.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 13:53:05 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5.10] rcu: Prevent expedited GP from enabling tick on offline CPU
Date:   Mon, 28 Aug 2023 20:53:01 +0000
Message-ID: <20230828205302.1660666-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 147f04b14adde831eb4a0a1e378667429732f9e8 ]

If an RCU expedited grace period starts just when a CPU is in the process
of going offline, so that the outgoing CPU has completed its pass through
stop-machine but has not yet completed its final dive into the idle loop,
RCU will attempt to enable that CPU's scheduling-clock tick via a call
to tick_dep_set_cpu().  For this to happen, that CPU has to have been
online when the expedited grace period completed its CPU-selection phase.

This is pointless:  The outgoing CPU has interrupts disabled, so it cannot
take a scheduling-clock tick anyway.  In addition, the tick_dep_set_cpu()
function's eventual call to irq_work_queue_on() will splat as follows:

smpboot: CPU 1 is now offline
WARNING: CPU: 6 PID: 124 at kernel/irq_work.c:95
+irq_work_queue_on+0x57/0x60
Modules linked in:
CPU: 6 PID: 124 Comm: kworker/6:2 Not tainted 5.15.0-rc1+ #3
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
+rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
Workqueue: rcu_gp wait_rcu_exp_gp
RIP: 0010:irq_work_queue_on+0x57/0x60
Code: 8b 05 1d c7 ea 62 a9 00 00 f0 00 75 21 4c 89 ce 44 89 c7 e8
+9b 37 fa ff ba 01 00 00 00 89 d0 c3 4c 89 cf e8 3b ff ff ff eb ee <0f> 0b eb b7
+0f 0b eb db 90 48 c7 c0 98 2a 02 00 65 48 03 05 91
 6f
RSP: 0000:ffffb12cc038fe48 EFLAGS: 00010282
RAX: 0000000000000001 RBX: 0000000000005208 RCX: 0000000000000020
RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff9ad01f45a680
RBP: 000000000004c990 R08: 0000000000000001 R09: ffff9ad01f45a680
R10: ffffb12cc0317db0 R11: 0000000000000001 R12: 00000000fffecee8
R13: 0000000000000001 R14: 0000000000026980 R15: ffffffff9e53ae00
FS:  0000000000000000(0000) GS:ffff9ad01f580000(0000)
+knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000de0c000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 tick_nohz_dep_set_cpu+0x59/0x70
 rcu_exp_wait_wake+0x54e/0x870
 ? sync_rcu_exp_select_cpus+0x1fc/0x390
 process_one_work+0x1ef/0x3c0
 ? process_one_work+0x3c0/0x3c0
 worker_thread+0x28/0x3c0
 ? process_one_work+0x3c0/0x3c0
 kthread+0x115/0x140
 ? set_kthread_struct+0x40/0x40
 ret_from_fork+0x22/0x30
---[ end trace c5bf75eb6aa80bc6 ]---

This commit therefore avoids invoking tick_dep_set_cpu() on offlined
CPUs to limit both futility and false-positive splats.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_exp.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 401c1f331caf..07a284a18645 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -507,7 +507,10 @@ static void synchronize_rcu_expedited_wait(void)
 				if (rdp->rcu_forced_tick_exp)
 					continue;
 				rdp->rcu_forced_tick_exp = true;
-				tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
+				preempt_disable();
+				if (cpu_online(cpu))
+					tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
+				preempt_enable();
 			}
 		}
 		j = READ_ONCE(jiffies_till_first_fqs);
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

