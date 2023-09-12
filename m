Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A191B79CEAB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbjILKpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbjILKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:44:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DC51987
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:44:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AB6C433C8;
        Tue, 12 Sep 2023 10:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694515464;
        bh=1xq6Mgf32EY2JQOJHQcEgJ3L7Kjn6lb+CzCCKEAz46M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVplCqOXjJormHSlR2bAyrpRlkyfPFfJEe2vJuJn5mL6+u6rPaN61klmUFrLzRuSe
         5Sa1L92QTSATpU1dj8EkdTWjGsnj/WWzmhP8KOGqMIUfVIkFeEKWjk8b2tG0zjp/b9
         xqtgWfjjpOwTfTEbUOLbrKRWtRUcX4PIqv58T7E96oZUUX8ILH8QB9nm8VGAt+Rdkp
         6IWYMbPSlcWUa/MQkDUqeFHp0NISKywyiGYeDJfCXZnVJzCE82s8FW3NxJre0QFigG
         rpIRrVXQIh+eEOB++P+ea8VLh8U/vXk81EPR4mlUeCvn5KRm114kdG83D0MpdSGNOL
         ok5tAtzcqTA7g==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>, vineethrp@gmail.com
Subject: [PATCH 5/5] timers: Tag (hr)timer softirq as hotplug safe
Date:   Tue, 12 Sep 2023 12:44:06 +0200
Message-Id: <20230912104406.312185-6-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912104406.312185-1-frederic@kernel.org>
References: <20230912104406.312185-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specific stress involving frequent CPU-hotplug operations, such as
running rcutorture for example, may trigger the following message:

	"NOHZ tick-stop error: local softirq work is pending, handler #02!!!"

This happens in the CPU-down hotplug process, after
CPUHP_AP_SMPBOOT_THREADS whose teardown callback parks ksoftirqd, and
before the target CPU shuts down through CPUHP_AP_IDLE_DEAD. In this
fragile intermediate state, softirqs waiting for threaded handling may
be forever ignored and eventually reported by the idle task as in the
above example.

However some vectors are known to be safe as long as the corresponding
subsystems have teardown callbacks handling the migration of their
events. The above error message reports pending timers softirq although
this vector can be considered as hotplug safe because the
CPUHP_TIMERS_PREPARE teardown callback performs the necessary migration
of timers after the death of the CPU. Hrtimers also have a similar
hotplug handling.

Therefore this error message, as far as (hr-)timers are concerned, can
be considered spurious and the relevant softirq vectors can be marked as
hotplug safe.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/interrupt.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a92bce40b04b..4a1dc88ddbff 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -569,8 +569,12 @@ enum
  * 	2) rcu_report_dead() reports the final quiescent states.
  *
  * _ IRQ_POLL: irq_poll_cpu_dead() migrates the queue
+ *
+ * _ (HR)TIMER_SOFTIRQ: (hr)timers_dead_cpu() migrates the queue
  */
-#define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(RCU_SOFTIRQ) | BIT(IRQ_POLL_SOFTIRQ))
+#define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(TIMER_SOFTIRQ) | BIT(IRQ_POLL_SOFTIRQ) |\
+				   BIT(HRTIMER_SOFTIRQ) | BIT(RCU_SOFTIRQ))
+
 
 /* map softirq index to softirq name. update 'softirq_to_name' in
  * kernel/softirq.c when adding a new softirq.
-- 
2.34.1

