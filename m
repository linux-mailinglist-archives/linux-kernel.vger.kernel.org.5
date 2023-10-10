Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C22E7BF588
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442751AbjJJITq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442725AbjJJITf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:19:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD03A9;
        Tue, 10 Oct 2023 01:19:33 -0700 (PDT)
Date:   Tue, 10 Oct 2023 08:19:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696925972;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k6rlJO7jKfEeTJGrCffSHZTc4ADy0SMEFm72FV6q9wc=;
        b=phZcPISKaniNp8ieTKzoDHPsF7jAlMnGUkI1Cv3TFhq3ua16NMM7BWYv7OAk3RAfkArO9r
        9DcGKSMra7+CDmHcDsyBrxLMZxYIDIv03Rx1y23EUsVoWt7weAGcX+3oDVxyA6zmY8D34f
        NhSAi1oHF1/3YYYTbfY5Zkb8n5YW7pP990WBRLei4Zvo+oyDXUoIfUzUZ7yk8OSg3eTTQp
        SxHi4um+uIqcc1+GJhYG8QJ1xhFgvHT0l6i0bP+qaurDrKsk6tnnsBmE/2RSK+r3JGwr0R
        JQV3f4kr/jJX5Q4SljewIquxnI91tE9fC7c4X4zYt/3ElVvBnCLO7J8zgurqmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696925972;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k6rlJO7jKfEeTJGrCffSHZTc4ADy0SMEFm72FV6q9wc=;
        b=w4Uqkj93Z/opO6jGRDXWF/WxHGKzxcJRvhuhjx1+g15M2Yd3Nz9ojXc2bUTm3exgPdNKdX
        wmyO9AqGylX7JXAg==
From:   "tip-bot2 for Tero Kristo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/cstate: Allow reading the package
 statistics from local CPU
Cc:     Kan Liang <kan.liang@intel.com>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230912124432.3616761-2-tero.kristo@linux.intel.com>
References: <20230912124432.3616761-2-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169692597189.3135.6821303889491635231.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     05276d4831fe023b6674a72bd6b8c5b39796e690
Gitweb:        https://git.kernel.org/tip/05276d4831fe023b6674a72bd6b8c5b39796e690
Author:        Tero Kristo <tero.kristo@linux.intel.com>
AuthorDate:    Tue, 12 Sep 2023 15:44:31 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Oct 2023 16:12:22 +02:00

perf/x86/cstate: Allow reading the package statistics from local CPU

The MSR registers for reading the package residency counters are
available on every CPU of the package. To avoid doing unnecessary SMP
calls to read the values for these from the various CPUs inside a
package, allow reading them from any CPU of the package.

Suggested-by: Kan Liang <kan.liang@intel.com>
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230912124432.3616761-2-tero.kristo@linux.intel.com
---
 arch/x86/events/intel/cstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 96fffb2..cbeb6d2 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -336,6 +336,9 @@ static int cstate_pmu_event_init(struct perf_event *event)
 		cfg = array_index_nospec((unsigned long)cfg, PERF_CSTATE_PKG_EVENT_MAX);
 		if (!(pkg_msr_mask & (1 << cfg)))
 			return -EINVAL;
+
+		event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
+
 		event->hw.event_base = pkg_msr[cfg].msr;
 		cpu = cpumask_any_and(&cstate_pkg_cpu_mask,
 				      topology_die_cpumask(event->cpu));
