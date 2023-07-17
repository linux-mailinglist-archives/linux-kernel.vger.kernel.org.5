Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA45C756389
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjGQM5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjGQM5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:57:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC52F19BD;
        Mon, 17 Jul 2023 05:56:33 -0700 (PDT)
Date:   Mon, 17 Jul 2023 12:56:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689598572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+Da+PCBm5uQHDgSpgmHzEReWQxyUhleyah1nCTpfSQ=;
        b=PN/Y8Ay0sd5u4srmdhtglgw98u8ZiiDTDJzpK58xZbr08BOrGQ99ybTyHBkB9Tu3UR/3e5
        7asVhdBIbnWRpA3lPAAb23FUUlQC/j4g9P9I+/2szmS8asyBJGmiwut9LE+hLPzZrCl2CO
        3j5sHKcqc7/XJBKPuJ4GGZUYQ1w/Jg79rY2HOIF4X5DQhSp+/iNIs6I2YkfULfhAQyVhpH
        3xZDiATDX1ojECjApnQLz+4wwGf5LzcJs9ZHLGLgdFQ3518N00j0bdpFKjsh+B40oEOPvV
        IOaIujFf91qinZJLmpulj1ixu0DykR/PftJoUb2z8iyNsb6IbJ1IpLOb0fL+sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689598572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+Da+PCBm5uQHDgSpgmHzEReWQxyUhleyah1nCTpfSQ=;
        b=fe4ivS1mwYlixWQK1HpfeJ0Hz047IixWYTIikGr+ZGNSBqo/TEiZPMtpfbajmGAnJH540b
        gL32Df1ytR2Mj5BQ==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Consider the idle state of the whole
 core for load balance
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C807bdd05331378ea3bf5956bda87ded1036ba769=2E16887?=
 =?utf-8?q?70494=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
References: =?utf-8?q?=3C807bdd05331378ea3bf5956bda87ded1036ba769=2E168877?=
 =?utf-8?q?0494=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <168959857191.28540.10639837216341924041.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b1bfeab9b00283f521d2100afb9f5af84ccdae13
Gitweb:        https://git.kernel.org/tip/b1bfeab9b00283f521d2100afb9f5af84cc=
dae13
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Fri, 07 Jul 2023 15:57:03 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 13 Jul 2023 15:21:52 +02:00

sched/fair: Consider the idle state of the whole core for load balance

should_we_balance() traverses the group_balance_mask (AND'ed with lb_env::
cpus) starting from lower numbered CPUs looking for the first idle CPU.

In hybrid x86 systems, the siblings of SMT cores get CPU numbers, before
non-SMT cores:

	[0, 1] [2, 3] [4, 5] 6 7 8 9
         b  i   b  i   b  i  b i i i

In the figure above, CPUs in brackets are siblings of an SMT core. The
rest are non-SMT cores. 'b' indicates a busy CPU, 'i' indicates an
idle CPU.

We should let a CPU on a fully idle core get the first chance to idle
load balance as it has more CPU capacity than a CPU on an idle SMT
CPU with busy sibling.  So for the figure above, if we are running
should_we_balance() to CPU 1, we should return false to let CPU 7 on
idle core to have a chance first to idle load balance.

A partially busy (i.e., of type group_has_spare) local group with SMT=C2=A0
cores will often have only one SMT sibling busy.=C2=A0If the destination CPU
is a non-SMT core, partially busy, lower-numbered, SMT cores should not
be considered when finding the first idle CPU.=C2=A0

However, in should_we_balance(), when we encounter idle SMT first in partially
busy core, we prematurely break the search for the first idle CPU.

Higher-numbered, non-SMT cores is not given the chance to have
idle balance done on their behalf. Those CPUs will only be considered
for idle balancing by chance via CPU_NEWLY_IDLE.

Instead, consider the idle state of the whole SMT core.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Co-developed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/807bdd05331378ea3bf5956bda87ded1036ba769.1688=
770494.git.tim.c.chen@linux.intel.com
---
 kernel/sched/fair.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c6246fb..a879883 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10902,7 +10902,7 @@ static int active_load_balance_cpu_stop(void *data);
 static int should_we_balance(struct lb_env *env)
 {
 	struct sched_group *sg =3D env->sd->groups;
-	int cpu;
+	int cpu, idle_smt =3D -1;
=20
 	/*
 	 * Ensure the balancing environment is consistent; can happen
@@ -10929,10 +10929,24 @@ static int should_we_balance(struct lb_env *env)
 		if (!idle_cpu(cpu))
 			continue;
=20
+		/*
+		 * Don't balance to idle SMT in busy core right away when
+		 * balancing cores, but remember the first idle SMT CPU for
+		 * later consideration.  Find CPU on an idle core first.
+		 */
+		if (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && !is_core_idle(cpu)) {
+			if (idle_smt =3D=3D -1)
+				idle_smt =3D cpu;
+			continue;
+		}
+
 		/* Are we the first idle CPU? */
 		return cpu =3D=3D env->dst_cpu;
 	}
=20
+	if (idle_smt =3D=3D env->dst_cpu)
+		return true;
+
 	/* Are we the first CPU of this group ? */
 	return group_balance_cpu(sg) =3D=3D env->dst_cpu;
 }
