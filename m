Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3741076CAD5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjHBKZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjHBKYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:24:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763A546AA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:22:40 -0700 (PDT)
Message-ID: <20230802101934.472046549@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690971706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=4pQHURzHcwcFZ9S0vbzPTsi43pbiloyiG3aJ+/xAmII=;
        b=ZPGr7pYOkLkHbHgU9IHgxAm+F05vXEQiHjAIco+FVcRjUPK2HJ/LW98ZCUcuxyAK10UPH+
        vVtO4sRtEuAv0xiJ6cZIKUAwmBJY86yC/KzK0BhtSUAroVZ1f+b4wSQQoSlD9KnrP1SWrN
        Lnzci1i0P0b8SDkzpzRj42FxNJJpp9ApLhJOSkd2Z6shpahsDbjJTIsBciyH0nJIFkLE2z
        4ACOFEctr8v25ODusINbLocH2cjktAtKwz4D7xByY7G3nvOZfnqTxN6s+T7OzoyZqagkYs
        P9fv0RZRQ86z8yWpYVqdct8HrKDmrGEYpQw4lBD8s83wpy5RA7r1oQ/0medWeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690971706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=4pQHURzHcwcFZ9S0vbzPTsi43pbiloyiG3aJ+/xAmII=;
        b=AkvBRaWYKTLKp73ignhKa8jp2GwMNvjpExIfbxsYcQ0qoWATCdR2LFgwoiqp6sC3v4HMUM
        SvvAQ2wxCImd+mAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [patch V3 31/40] x86/smpboot: Teach it about topo.amd_node_id
References: <20230802101635.459108805@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  2 Aug 2023 12:21:46 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching AMD over to the new topology parser then the match functions
need to look for AMD systems with the extended topology feature at the new
topo.amd_node_id member which is then holding the node id information.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/smpboot.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -486,6 +486,7 @@ static bool match_smt(struct cpuinfo_x86
 
 		if (c->topo.pkg_id == o->topo.pkg_id &&
 		    c->topo.die_id == o->topo.die_id &&
+		    c->topo.amd_node_id == o->topo.amd_node_id &&
 		    per_cpu_llc_id(cpu1) == per_cpu_llc_id(cpu2)) {
 			if (c->topo.core_id == o->topo.core_id)
 				return topology_sane(c, o, "smt");
@@ -507,10 +508,13 @@ static bool match_smt(struct cpuinfo_x86
 
 static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
-	if (c->topo.pkg_id == o->topo.pkg_id &&
-	    c->topo.die_id == o->topo.die_id)
-		return true;
-	return false;
+	if (c->topo.pkg_id != o->topo.pkg_id || c->topo.die_id != o->topo.die_id)
+		return false;
+
+	if (boot_cpu_has(X86_FEATURE_TOPOEXT) && topology_amd_nodes_per_pkg() > 1)
+		return c->topo.amd_node_id == o->topo.amd_node_id;
+
+	return true;
 }
 
 static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)

