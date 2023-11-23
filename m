Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC217F626E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346013AbjKWPOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjKWPOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:14:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDC4D48;
        Thu, 23 Nov 2023 07:14:19 -0800 (PST)
Date:   Thu, 23 Nov 2023 15:14:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700752457;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jM1G78Pb55OZs6pBQVdGZGxOr3xM0EcYWgrlIXzPnrQ=;
        b=1JSs4nTzE5LpQ4sPT9zKJHsvx1BJxLLT8pDp8fXuGrIMfwAIX9FDRprd4tEMmaOqSEDvxO
        S62aYPyjzB1lUzGCu7YogXabdAdaXWSKbvMeiJjYKobyBFqVwfOKKAX8bzWEbOBVc/jAoW
        CmzlPA77JzrhlcqK4lnUc27ahZa6OIciFYNy2GAMHFQA0fu0sJZqktBEuQ77LDXbQ4nq3O
        UScslkluHm5wmRTB9tSiM10gCPDBNspsEX5M369lkPKXbYhUL4pm/rk7jwo/P7kvC38N9S
        GaRO4OaaivsvFddpyYfDRNE9yKwWOxOh9KADJL9NRw34gQhVHZoXJedirv7Erw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700752457;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jM1G78Pb55OZs6pBQVdGZGxOr3xM0EcYWgrlIXzPnrQ=;
        b=TLkf1xMyk1ewKsc8YcLU9dH+6gmfXuD7ztoWBPJA2Z64jiUmMWLNaBPbH2JwK4rLVhxM0s
        z3q1R34n48oCyqCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix the nr_addr_filters fix
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231122100756.GP8262@noisy.programming.kicks-ass.net>
References: <20231122100756.GP8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <170075245640.398.10957692681465500006.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     388a1fb7da6aaa1970c7e2a7d7fcd983a87a8484
Gitweb:        https://git.kernel.org/tip/388a1fb7da6aaa1970c7e2a7d7fcd983a87a8484
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 22 Nov 2023 11:07:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 23 Nov 2023 16:08:31 +01:00

perf: Fix the nr_addr_filters fix

Thomas reported that commit 652ffc2104ec ("perf/core: Fix narrow
startup race when creating the perf nr_addr_filters sysfs file") made
the entire attribute group vanish, instead of only the nr_addr_filters
attribute.

Additionally a stray return.

Insufficient coffee was involved with both writing and merging the
patch.

Fixes: 652ffc2104ec ("perf/core: Fix narrow startup race when creating the perf nr_addr_filters sysfs file")
Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Link: https://lkml.kernel.org/r/20231122100756.GP8262@noisy.programming.kicks-ass.net
---
 kernel/events/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4f0c45a..59b332c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11417,12 +11417,10 @@ static umode_t pmu_dev_is_visible(struct kobject *kobj, struct attribute *a, int
 	struct device *dev = kobj_to_dev(kobj);
 	struct pmu *pmu = dev_get_drvdata(dev);
 
-	if (!pmu->nr_addr_filters)
+	if (n == 2 && !pmu->nr_addr_filters)
 		return 0;
 
 	return a->mode;
-
-	return 0;
 }
 
 static struct attribute_group pmu_dev_attr_group = {
