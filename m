Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BDB756381
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjGQM5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjGQM46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:56:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE7F172E;
        Mon, 17 Jul 2023 05:56:26 -0700 (PDT)
Date:   Mon, 17 Jul 2023 12:56:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689598572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Mhe5ES5whgtkOTR4E5hxUtbSDZVzln4/4eHipoIvoVU=;
        b=NCtk3/OFFobB3/3UrgHq8T1Eeb00+EzlGnZOns3XnptovFqwDpldNnLce43NcAS6Gjzdr1
        P878cM7A1HDxCwEQLS2oD2oB77cBAf6TKwy4L/6luS5TWGTc4Fy61cd6CR2q1DQj/JFP9m
        P3P3GfLI/tCxurJtxx+rvWjicndfH89G7eGJ5L6i1/qfcUrBHBOdfJ2aIfWAyJlHbBKw/M
        QrWv2iFiMbfXD6umQ/BZE/wJ1JVxTj/yQTCqzcCl3VzgNTXfT+g3+bO6qnTIL0+hk2Z39a
        JIHXwJDz1qKeQ6iO7G+UQU2cyGDBbsmt+InyZgWIlgZEOTfhOo07m0eh74Z+0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689598572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Mhe5ES5whgtkOTR4E5hxUtbSDZVzln4/4eHipoIvoVU=;
        b=uLf2oNpPVNaUSZKJIwkk1Btuvscwf7/yiELtwukr75q8C+8w+biO06Jy5KBbyidt5IDbjy
        lBfMStO0+4rkzHCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/sched: Enable cluster scheduling on Hybrid
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168959857149.28540.1815236085673081260.tip-bot2@tip-bot2>
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

Commit-ID:     17953249bf02448efaed75b097aa2e9086ca7685
Gitweb:        https://git.kernel.org/tip/17953249bf02448efaed75b097aa2e9086ca7685
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 08 Jul 2023 14:43:45 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 13 Jul 2023 15:21:53 +02:00

x86/sched: Enable cluster scheduling on Hybrid

With the SMT vs non-SMT balancing issues sorted, also enable the
cluster domain for Hybrid machines.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/smpboot.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index e1aa2cd..4c31447 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -632,14 +632,9 @@ static void __init build_sched_topology(void)
 	};
 #endif
 #ifdef CONFIG_SCHED_CLUSTER
-	/*
-	 * For now, skip the cluster domain on Hybrid.
-	 */
-	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)) {
-		x86_topology[i++] = (struct sched_domain_topology_level){
-			cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS)
-		};
-	}
+	x86_topology[i++] = (struct sched_domain_topology_level){
+		cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS)
+	};
 #endif
 #ifdef CONFIG_SCHED_MC
 	x86_topology[i++] = (struct sched_domain_topology_level){
