Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516E7756382
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjGQM5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjGQM47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:56:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18417172C;
        Mon, 17 Jul 2023 05:56:25 -0700 (PDT)
Date:   Mon, 17 Jul 2023 12:56:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689598571;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QRwIIAu6SKfQwuKHc8Rqk9eOFOdTrr4UqMtZzl4/z8=;
        b=4isY0zU3c5Ul6iPccQlZm04q4iLXfT72llvfxngdvmvd0DvjYosDt97r/KFwvlhMYBP4um
        gwwWmk+Ojquj4unIWFAoKbNayoRZljBDSpEx9UkMyFEQahjlNYQSjc2gxUM3Qn4R57IMwd
        ZUwxbkRCETzKONaRlu9j0rxYW2hbQLC7tY61XmZ8nWNUOePS6IJ4YaH/R5wLFdpPgpP6Pz
        /yDA1LFITlqc91SwM8ua4SPR4kx9c0ynoexamOt4SYVXWsZA4SPmsSlvgIe0MRrWTUIC3W
        2JMenDhrSEheMDADuYzaG5ixrHV7j5G0oTptvNQyju6pMZbfI5orukc4k09SPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689598571;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QRwIIAu6SKfQwuKHc8Rqk9eOFOdTrr4UqMtZzl4/z8=;
        b=/UdhrTwC/SAzR0x716buR9G//O7jVf5c3f1+BkCjSkPcK1KkU/IEbJlfwApzceKGB+fxLm
        gVeBDoRj2ro5UKDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Dump domains' sched group flags
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ced1749262d94d95a8296c86a415999eda90bcfe3=2E16887?=
 =?utf-8?q?70494=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
References: =?utf-8?q?=3Ced1749262d94d95a8296c86a415999eda90bcfe3=2E168877?=
 =?utf-8?q?0494=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <168959857109.28540.8257126646779538127.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Commit-ID:     ed74cc4995d314ea6cbf406caf978c442f451fa5
Gitweb:        https://git.kernel.org/tip/ed74cc4995d314ea6cbf406caf978c442f451fa5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Jul 2023 15:57:05 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 13 Jul 2023 15:21:53 +02:00

sched/debug: Dump domains' sched group flags

There have been a case where the SD_SHARE_CPUCAPACITY sched group flag
in a parent domain were not set and propagated properly when a degenerate
domain is removed.

Add dump of domain sched group flags of a CPU to make debug easier
in the future.

Usage:
cat /debug/sched/domains/cpu0/domain1/groups_flags
to dump cpu0 domain1's sched group flags.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/ed1749262d94d95a8296c86a415999eda90bcfe3.1688770494.git.tim.c.chen@linux.intel.com
---
 kernel/sched/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 066ff1c..aeeba46 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -427,6 +427,7 @@ static void register_sd(struct sched_domain *sd, struct dentry *parent)
 #undef SDM
 
 	debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
+	debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
 }
 
 void update_sched_domain_debugfs(void)
