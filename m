Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BFE7F15D0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjKTOft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjKTOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:35:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5724ECA;
        Mon, 20 Nov 2023 06:35:41 -0800 (PST)
Date:   Mon, 20 Nov 2023 14:35:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700490940;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TXBWR29QKiVuMOe/5cddg5Sksdh/jRTbLXljeI6tL3g=;
        b=eQezzV3IoLtM/KGep9aOlVbLbj11+BXuqPZJyTNaZGR66te8k3WiXEhs+vmzH02LY7tDQF
        xzfrU7GumnmKzG0g0rs3/jDX48Zn/5rNWU/uohk51ZiTb0TYibUcDA0z//cXMXTwcNWdiT
        jmwjZ2nJHN48pYduYPwojVA82XiVQhGV4RkQyhTomSynmzm7IdWFBhJsn5MGX1tmEcVb3r
        Z1cdQpzio7kYxE1l3KZYbOmlr/Av4ZVO0e5ookIlB2ILJY2J95d94ZbUjgAaXsqhXfsO3v
        61A3gp8ipr2AHBm2hsP/b3kXdhwb5g/tJPtwZ2qofOhjvjAKFOe75ytGd4ZBNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700490940;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TXBWR29QKiVuMOe/5cddg5Sksdh/jRTbLXljeI6tL3g=;
        b=9Zhfl/0WUyr8mmChJzsKiIPjgu5rKoClPEsXhUQa4V6FkomOqchQSfdNKtNG+mRWaC+2Hk
        4gY/I3KTAZm1A8Dw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/smp: Export symbol cpu_clustergroup_mask()
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231116142245.1233485-2-kan.liang@linux.intel.com>
References: <20231116142245.1233485-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <170049093932.398.7671603015835084715.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c3dd1995620cdcd65cf4944c4164b0dbc16e557c
Gitweb:        https://git.kernel.org/tip/c3dd1995620cdcd65cf4944c4164b0dbc16e557c
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 16 Nov 2023 06:22:43 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Nov 2023 10:54:52 +01:00

x86/smp: Export symbol cpu_clustergroup_mask()

Intel cstate PMU driver will invoke the topology_cluster_cpumask() to
retrieve the CPU mask of a cluster. A modpost error is triggered since
the symbol cpu_clustergroup_mask is not exported.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231116142245.1233485-2-kan.liang@linux.intel.com
---
 arch/x86/kernel/smpboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 2cc2aa1..3f57ce6 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -757,6 +757,7 @@ const struct cpumask *cpu_clustergroup_mask(int cpu)
 {
 	return cpu_l2c_shared_mask(cpu);
 }
+EXPORT_SYMBOL_GPL(cpu_clustergroup_mask);
 
 static void impress_friends(void)
 {
