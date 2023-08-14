Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCE677BC78
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjHNPIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjHNPIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:08:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711BB1708;
        Mon, 14 Aug 2023 08:08:09 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:08:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692025688;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pYuA2LAqTIp6HASyk3PwBvTsILwMa5dscav84Qp916o=;
        b=YWAaSmQQaDsfXoAC7utF5142W2lkMKlMpGDN8nui+IYJoilU0ttbV0sRcgpgGS0zqPSPGd
        1VasZOo/scO+L3xv43T/Hv4+Koswz9FaawroVdhBTbF2MhLy/aUhUORZ2UZ4nix3KNsCCB
        qhMHE4O5/44j2nju5CY73aQS/3By+1f7wIaAm0d0785Bqa7o2VFyt0DYsMetvHQNgjTnZi
        1Zd991UChPXIbhinSoAhJ9KpRxz3BJeNdHYzX60iP6zBj5xGlslLmZuB0AJyOjw1ArWiTd
        lqeqExLxyTaX6canx5gSuWigzxlFadbtm9nvlVlIg2jv+y2teJPbzTQiCj/xZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692025688;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pYuA2LAqTIp6HASyk3PwBvTsILwMa5dscav84Qp916o=;
        b=gSzw455zWBWzt//hBZln2EhSEjyqUG4INUm+QqFH6iOubcT0V3ja5bLtxyR56Rhjkaa43x
        VnVVjqWWiVmDzoAQ==
From:   "tip-bot2 for Cyril Hrubis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: sysctl_sched_rr_timeslice show default
 timeslice after reset
Cc:     Cyril Hrubis <chrubis@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Petr Vorel <pvorel@suse.cz>, Mel Gorman <mgorman@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230802151906.25258-3-chrubis@suse.cz>
References: <20230802151906.25258-3-chrubis@suse.cz>
MIME-Version: 1.0
Message-ID: <169202568750.27769.3498187925487799057.tip-bot2@tip-bot2>
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

Commit-ID:     c1fc6484e1fb7cc2481d169bfef129a1b0676abe
Gitweb:        https://git.kernel.org/tip/c1fc6484e1fb7cc2481d169bfef129a1b0676abe
Author:        Cyril Hrubis <chrubis@suse.cz>
AuthorDate:    Wed, 02 Aug 2023 17:19:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Aug 2023 17:01:23 +02:00

sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset

The sched_rr_timeslice can be reset to default by writing value that is
<= 0. However after reading from this file we always got the last value
written, which is not useful at all.

$ echo -1 > /proc/sys/kernel/sched_rr_timeslice_ms
$ cat /proc/sys/kernel/sched_rr_timeslice_ms
-1

Fix this by setting the variable that holds the sysctl file value to the
jiffies_to_msecs(RR_TIMESLICE) in case that <= 0 value was written.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Acked-by: Mel Gorman <mgorman@suse.de>
Tested-by: Petr Vorel <pvorel@suse.cz>
Link: https://lore.kernel.org/r/20230802151906.25258-3-chrubis@suse.cz
---
 kernel/sched/rt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 185d3d7..0597ba0 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -3062,6 +3062,9 @@ static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
 		sched_rr_timeslice =
 			sysctl_sched_rr_timeslice <= 0 ? RR_TIMESLICE :
 			msecs_to_jiffies(sysctl_sched_rr_timeslice);
+
+		if (sysctl_sched_rr_timeslice <= 0)
+			sysctl_sched_rr_timeslice = jiffies_to_msecs(RR_TIMESLICE);
 	}
 	mutex_unlock(&mutex);
 
