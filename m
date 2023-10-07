Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F2A7BC93F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 19:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344127AbjJGRLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 13:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344046AbjJGRLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 13:11:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242E99E;
        Sat,  7 Oct 2023 10:11:00 -0700 (PDT)
Date:   Sat, 07 Oct 2023 17:10:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696698658;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gECZZh5iJ02TdAKQPSzRNmE/zibkCxme3Qc20tTwTPs=;
        b=3JyEcrtLPT7xPj2ehM0/gYaq8DDMbwUTGsFtAoLPHnplatdJPypYNGE/PZSsIQM5n2yzmA
        A4zr8vkDXym+qMbNNPcUM9C7sqxOMy4t87gUQvEe/iMC2bY/mBLJ2F/MgKtr3gtJT+Ts/U
        qyb5wVMKghsbvXKc/0+sKvakF/UvHYouRpAoBk5+5DrOXq8zB/lHK8I9EEqwZYZSrGsJVW
        41HssW1+9qLLatpwgI+JZ6d4CDEuLMqfFqrWHUJS5yICls9XtcJbtjC1etRWnPGKpJhq7U
        phZA4q8GVniXnpWS+O9PB663AzhUm+h4vGVmm1wZgMmOKlZsNwlXmPAXZGxupw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696698658;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gECZZh5iJ02TdAKQPSzRNmE/zibkCxme3Qc20tTwTPs=;
        b=cdgrfJrN2bwdLeAJvwQfdGY97CXJwqbWT4dDnZl3hWsFHANCrolMMMDGN3rY/N98zoTcH4
        Z5inQJSbtdCVtDAw==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] intel_idle: Use __update_spec_ctrl() in intel_idle_ibrs()
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230727184600.26768-4-longman@redhat.com>
References: <20230727184600.26768-4-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <169669865810.3135.4637182434325944599.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7506203089dceb1d9e1f35d37ad2e46d44798a6d
Gitweb:        https://git.kernel.org/tip/7506203089dceb1d9e1f35d37ad2e46d44798a6d
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 27 Jul 2023 14:45:59 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 07 Oct 2023 11:33:28 +02:00

intel_idle: Use __update_spec_ctrl() in intel_idle_ibrs()

When intel_idle_ibrs() is called, it modifies the SPEC_CTRL MSR to 0
in order disable IBRS. However, the new MSR value isn't reflected in
x86_spec_ctrl_current which is at odd with the other code that keep track
of its state in that percpu variable.  Use the new __update_spec_ctrl()
to have the x86_spec_ctrl_current percpu value properly updated.

Since spec-ctrl.h includes both msr.h and nospec-branch.h, we can remove
those from the include file list.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20230727184600.26768-4-longman@redhat.com
---
 drivers/idle/intel_idle.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ea5a6a1..86ac9a4 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -53,9 +53,8 @@
 #include <linux/moduleparam.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
-#include <asm/nospec-branch.h>
 #include <asm/mwait.h>
-#include <asm/msr.h>
+#include <asm/spec-ctrl.h>
 #include <asm/fpu/api.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
@@ -182,12 +181,12 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
 	int ret;
 
 	if (smt_active)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		__update_spec_ctrl(0);
 
 	ret = __intel_idle(dev, drv, index);
 
 	if (smt_active)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
+		__update_spec_ctrl(spec_ctrl);
 
 	return ret;
 }
