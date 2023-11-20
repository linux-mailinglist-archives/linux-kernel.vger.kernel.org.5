Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A1B7F15CE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjKTOfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjKTOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:35:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF65112;
        Mon, 20 Nov 2023 06:35:40 -0800 (PST)
Date:   Mon, 20 Nov 2023 14:35:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700490939;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A7zldWwl7dHHlFIYTKVjKhMwvreh2w4NaLYmY3SinWk=;
        b=fkCp2FPlGxZivFsHHEtrV8dbpDknBljKvECk3nVeTAwJ83yA0wztTBsgd1r2NuYsEZ8rn9
        ngIN3IHDTlnq1zAgkZ/bg4QIPrnFYCOsPan0vt4dZOanzmaNyW5jTcIkhwEjHDfzXKaRKA
        fsQaQuXYJRVW9nmge7Z36HyMBv/ggoR/XHguPMAJxspgd8GFjYn0FBj/GmCmUWfzJoqe2Y
        qT7CL/kqVxH/SE2QNSnkldoHDCMqYNIzyE/I3P7PVo77rd6zs0wh0rRTuv0jh9+w8q+R1X
        QMrBKZNV+3chGYWkMYyNHphD4TkRiHW8x6VICtjfjMZytOj/MaNpf8YLqm646w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700490939;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A7zldWwl7dHHlFIYTKVjKhMwvreh2w4NaLYmY3SinWk=;
        b=D54HCzbVlY2lrVNTpmIfaJRS6YqFvzUoCHLHyeo0c7y2rPRX/ziJDu61+4EblIOlRcEzt3
        HUQbEjeQzaHWUpDQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/cstate: Add Grand Ridge support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231116142245.1233485-4-kan.liang@linux.intel.com>
References: <20231116142245.1233485-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <170049093761.398.5173457505104553782.tip-bot2@tip-bot2>
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

Commit-ID:     bbb968696d0f3442ab823598def3b756cf4735c6
Gitweb:        https://git.kernel.org/tip/bbb968696d0f3442ab823598def3b756cf4735c6
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 16 Nov 2023 06:22:45 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Nov 2023 10:54:53 +01:00

perf/x86/intel/cstate: Add Grand Ridge support

The same as the Sierra Forest, the Grand Ridge supports core C1/C6 and
module C6. But it doesn't support pkg C6 residency counter.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231116142245.1233485-4-kan.liang@linux.intel.com
---
 arch/x86/events/intel/cstate.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 4a46ef3..4b50a3a 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -41,7 +41,7 @@
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
  *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
- *					  MTL,SRF
+ *					  MTL,SRF,GRR
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -52,7 +52,8 @@
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
- *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF
+ *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
+ *						GRR
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
@@ -99,7 +100,7 @@
  *			       Scope: Package (physical package)
  *	MSR_MODULE_C6_RES_MS:  Module C6 Residency Counter.
  *			       perf code: 0x00
- *			       Available model: SRF
+ *			       Available model: SRF,GRR
  *			       Scope: A cluster of cores shared L2 cache
  *
  */
@@ -677,6 +678,13 @@ static const struct cstate_model glm_cstates __initconst = {
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
 
+static const struct cstate_model grr_cstates __initconst = {
+	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
+				  BIT(PERF_CSTATE_CORE_C6_RES),
+
+	.module_events		= BIT(PERF_CSTATE_MODULE_C6_RES),
+};
+
 static const struct cstate_model srf_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES),
@@ -739,6 +747,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&glm_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	&srf_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	&grr_cstates),
 
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_cstates),
