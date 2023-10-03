Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDAF7B71D6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240922AbjJCTfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240962AbjJCTe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:34:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC05BF;
        Tue,  3 Oct 2023 12:34:56 -0700 (PDT)
Date:   Tue, 03 Oct 2023 19:34:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696361695;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMSuIBX68wCUaN9OMC0iJXW11FBBQZmVSrB0umTnwnA=;
        b=kX+EjTk5lvv2J8+GRWmzKd/T0sTYU/rHd9Il0MzWQH4JCu23KFdZWICShuTXL0c5G4QZgm
        zsgNF1YBEXWHV6JJleulLkOuebXcTScPAnZQVuzyVKeKg593YO8Hh1zySahb8NOsJd1Jjg
        tECnLLlJxnbdrjrBLyE9vZ3HZ0TXNYq4LKtOpnRVsCt/qwOY86H56QSHZGhPa50v4u7E2w
        C/rschhnluYDdDKGUkz2aFZ7DDmGqrRCIpkwPkNmg/MwO3h/mlAoCt+U1Rr/glSnZNbYl0
        o/kbt2UX+LZqHt7an8UIZmj/8qa2x7zjUlQFmpFuHQ48njKHt4RJyZQ00lSTmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696361695;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMSuIBX68wCUaN9OMC0iJXW11FBBQZmVSrB0umTnwnA=;
        b=RU3to7Rf32EWwrVEtaqin8qdVuk7WNTMCDNvlA+e/plT06k+aG8as7ilH0dpgsveP4X01n
        q0mnsScVJoESvNDg==
From:   "tip-bot2 for David Reaver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Fix "Using plain integer as NULL
 pointer" Sparse warning
Cc:     David Reaver <me@davidreaver.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230801155651.108076-1-me@davidreaver.com>
References: <20230801155651.108076-1-me@davidreaver.com>
MIME-Version: 1.0
Message-ID: <169636169438.3135.16959912732564389921.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     618e77d77494bfd6273256d43eafe4368445c745
Gitweb:        https://git.kernel.org/tip/618e77d77494bfd6273256d43eafe4368445c745
Author:        David Reaver <me@davidreaver.com>
AuthorDate:    Tue, 01 Aug 2023 08:56:51 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 21:25:56 +02:00

perf/x86/rapl: Fix "Using plain integer as NULL pointer" Sparse warning

Change 0 to NULL when initializing the test field of perf_msr structs to
avoid the following sparse warnings:

  make C=2 arch/x86/events/rapl.o

  CHECK   arch/x86/events/rapl.c
  ...
  arch/x86/events/rapl.c:540:59: warning: Using plain integer as NULL pointer
  arch/x86/events/rapl.c:542:59: warning: Using plain integer as NULL pointer
  arch/x86/events/rapl.c:543:59: warning: Using plain integer as NULL pointer
  arch/x86/events/rapl.c:544:59: warning: Using plain integer as NULL pointer

Signed-off-by: David Reaver <me@davidreaver.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230801155651.108076-1-me@davidreaver.com
---
 arch/x86/events/rapl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 6d3e738..c2c37fb 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -533,11 +533,11 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
  * - want to use same event codes across both architectures
  */
 static struct perf_msr amd_rapl_msrs[] = {
-	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, 0, false, 0 },
+	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, NULL, false, 0 },
 	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
-	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   0, false, 0 },
-	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   0, false, 0 },
-	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  0, false, 0 },
+	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   NULL, false, 0 },
+	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   NULL, false, 0 },
+	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
 };
 
 static int rapl_cpu_offline(unsigned int cpu)
