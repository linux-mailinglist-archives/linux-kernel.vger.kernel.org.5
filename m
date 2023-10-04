Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC327B840B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjJDPrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbjJDPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:47:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC09A6;
        Wed,  4 Oct 2023 08:47:14 -0700 (PDT)
Date:   Wed, 04 Oct 2023 15:47:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696434433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9p0kvYM/s+7hGqHL3CU0GH8fKoncUpQiZRjlNYQ5v3w=;
        b=hJErgrjdlW02ex/ltsUeRy5xOK9TVzm4/yYHgKSZOYKOh+oOCV5t+0InhGRBeuqmuMbyii
        dyjC2+nzIXxK+tgjwrO+/tzhtKjz3eiKLywPtDHgq0ApWcTJc5WLX0vvUgUXOM6lJpxEIj
        hyJTjUHya9x1y/v+xXlJR6xkrXhP8HqbcjLAu6NZRMZvpfjG8RH2JFpK6SRWHrJbe/fldP
        YSdf4yUzmTOL2ZeYAwWDDtUbP808cJ4m22oFytDpDlG86YORc5PQCSUAx9vTSmVnBZvKIB
        JPkRJNQIQcDMm4uQZBwLfVJJ9GKP2EMd94Osined6DtXDO3R1L60iOPsyAgX4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696434433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9p0kvYM/s+7hGqHL3CU0GH8fKoncUpQiZRjlNYQ5v3w=;
        b=vFoKHdtdMvfuuBteac19v+C+77tqYOlzAzefeF3A/ntsi5u/7EPHmJiboD1wHH8Y9OHhkL
        aWQspAaM3XpwJMCQ==
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
Message-ID: <169643443236.3135.5722494336369164207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1fe96fb4d0f2df207c906a7b1bba70154900ebd1
Gitweb:        https://git.kernel.org/tip/1fe96fb4d0f2df207c906a7b1bba70154900ebd1
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 27 Jul 2023 14:45:59 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 04 Oct 2023 13:48:48 +02:00

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
