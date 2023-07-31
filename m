Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709AE7692FF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjGaKU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjGaKUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:20:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C77E5A;
        Mon, 31 Jul 2023 03:19:48 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:19:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690798787;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YrO9hhJgtNLYgb+mpIYPx1bgPRK8x56azMuQtTzFB8c=;
        b=VOGA/bKyhdvuS+Jxbu6rrL/S6CnsjhFYYtrCyZGVa1qwa22ogAMf+Y16sHe+tU4uiNTk5Z
        CYssB2ZgGC0kaEJ+sdDMy0Qqk8qszTpn5kcUeIT1o52DKUfAUaqzPzNVAxd4gMj07OHtKR
        IY86OXb+jsVfMHegXu3QNtP6OXrIF+w8Wd+mhC8z3Cj58S9AuGjkEpt9yEmVXRekIqF0d+
        TiJ4EGR/tryziVzTpSr5t4fpfftI+h7VpimQ4tQzoQYZOrz/cfc1OW9amiD1q3EosisrJu
        rfeFcttXU4iMwN+JEIFNFbo6BExOZRQi9OH89p9le96pYlKYAdQwiUIbe8ZRtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690798787;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YrO9hhJgtNLYgb+mpIYPx1bgPRK8x56azMuQtTzFB8c=;
        b=u/rfeT5P17N6n6SBNX3zsKHUDLziwmSdWlgeG5GasOqnOGeJUkkCJGf+VyRdnCqy9J6se2
        KZBztAi5wz5g7VBg==
From:   "tip-bot2 for Chen Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Align group flags when removing
 degenerate domain
Cc:     Yicong Yang <yangyicong@huawei.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230713013133.2314153-1-yu.c.chen@intel.com>
References: <20230713013133.2314153-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Message-ID: <169079878649.28540.7562287481060360832.tip-bot2@tip-bot2>
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

Commit-ID:     4efcc8bc7e08c09c58a2f5cbc2096fbda5b7cf5e
Gitweb:        https://git.kernel.org/tip/4efcc8bc7e08c09c58a2f5cbc2096fbda5b7cf5e
Author:        Chen Yu <yu.c.chen@intel.com>
AuthorDate:    Thu, 13 Jul 2023 09:31:33 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Jul 2023 12:28:51 +02:00

sched/topology: Align group flags when removing degenerate domain

The flags of the child of a given scheduling domain are used to initialize
the flags of its scheduling groups. When the child of a scheduling domain
is degenerated, the flags of its local scheduling group need to be updated
to align with the flags of its new child domain.

The flag SD_SHARE_CPUCAPACITY was aligned in
Commit bf2dc42d6beb ("sched/topology: Propagate SMT flags when removing degenerate domain").
Further generalize this alignment so other flags can be used later, such as
in cluster-based task wakeup. [1]

Reported-by: Yicong Yang <yangyicong@huawei.com>
Suggested-by: Ricardo Neri <ricardo.neri@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
Link: https://lore.kernel.org/r/20230713013133.2314153-1-yu.c.chen@intel.com
---
 kernel/sched/topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 7cfcfe5..05a5bc6 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -722,8 +722,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 
 			if (parent->parent) {
 				parent->parent->child = tmp;
-				if (tmp->flags & SD_SHARE_CPUCAPACITY)
-					parent->parent->groups->flags |= SD_SHARE_CPUCAPACITY;
+				parent->parent->groups->flags = tmp->flags;
 			}
 
 			/*
