Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795D17C7F78
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjJMIGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjJMIGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:06:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97FCC9;
        Fri, 13 Oct 2023 01:06:14 -0700 (PDT)
Date:   Fri, 13 Oct 2023 08:06:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697184373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OBaUkWG9J3apSizB+NsKQOuu0IKcHSFNhRVgtXFc2Yk=;
        b=e59yyw6+xMgAiFzup1SCDx7Tr3kxwbMhv0r38xQKVSQoE2mESiWBM3USdCiAn7CPEtO32P
        bZS0J6rjdCT2YyhTOstteaA4zW9pyxYDXFAuKvPFiSgCgXGEpWcS/IX8j+fN6vyGculKkZ
        iUbmWvvzdEe7fJZt0vEUGviAJWjJdntttLv5isjZHT82iXAjzioR+ZiEVmkgwAQznoIMK6
        PE2odCSwXMegXwR2xZwVME44J+SYk1gYYc1wgHueTQSCDHm8IJMHyJr+6rRvtVshXHJW65
        SCrtx5g0UOQXG11WrKfNIzRadBtsXUwVXiDeOl7ft3rcXoO2ARwmgW70x5JR8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697184373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OBaUkWG9J3apSizB+NsKQOuu0IKcHSFNhRVgtXFc2Yk=;
        b=EZWI+CC5Ik1bgDyrvw6SehZXmDsOP+elnBTv89uG0m9ZRdZw9rDFUPrmUDMIKMGqcdU1IB
        2x7aUOK/sJg61+Ag==
From:   "tip-bot2 for Haifeng Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/psi: Bail out early from irq time accounting
Cc:     Haifeng Xu <haifeng.xu@shopee.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chengming Zhou <zhouchengming@bytedance.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230926115722.467833-1-haifeng.xu@shopee.com>
References: <20230926115722.467833-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Message-ID: <169718437261.3135.12208635380704050499.tip-bot2@tip-bot2>
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

Commit-ID:     0c2924079f5a83ed715630680e338b3685a0bf7d
Gitweb:        https://git.kernel.org/tip/0c2924079f5a83ed715630680e338b3685a0bf7d
Author:        Haifeng Xu <haifeng.xu@shopee.com>
AuthorDate:    Tue, 26 Sep 2023 11:57:22 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 13 Oct 2023 09:56:29 +02:00

sched/psi: Bail out early from irq time accounting

We could bail out early when psi was disabled.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Link: https://lore.kernel.org/r/20230926115722.467833-1-haifeng.xu@shopee.com
---
 kernel/sched/psi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 44a7877..519bc92 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -998,6 +998,9 @@ void psi_account_irqtime(struct task_struct *task, u32 delta)
 	struct psi_group_cpu *groupc;
 	u64 now;
 
+	if (static_branch_likely(&psi_disabled))
+		return;
+
 	if (!task->pid)
 		return;
 
