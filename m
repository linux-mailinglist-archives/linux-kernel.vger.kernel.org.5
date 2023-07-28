Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD900766CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbjG1MN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbjG1MMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:12:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EB1268B;
        Fri, 28 Jul 2023 05:12:52 -0700 (PDT)
Message-ID: <20230728120930.055388145@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WfNPFKAN9GG2GFdyit2jWhoSZIUriu/Y8Ta0CK3Muoc=;
        b=fmUzRCRg7yR2P9DmPno2iwKqUa/L1iNvs+O7AUmd4kIAmUT4fMakJpdvK0MPA1cVWsXKr8
        AcAa4z8GCuOZuEuYsvXY7kkt70i2xlBdZlSP0q1UUxXbVpHR56wgtqxCIO9JZrp7TbXU48
        paINd20ybEWFgxAHbtD+0DSlQKMZfsIlubSiXlLZuiYVlTSyhhsxR6eq5BElO7R0tv3znI
        jgQu8y2p1U7B4zlJJ6R2Fpj5uHzALuFGq5QAX6gcCRrJOYaGyrgAtwrDstu8c+sI2PFxKc
        oncHCfSY5oQnNO/aRAW0GfDbvmoX8Rc77qxisAnfeddue3K91oMNGu4sQUyEow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WfNPFKAN9GG2GFdyit2jWhoSZIUriu/Y8Ta0CK3Muoc=;
        b=ymtc3pobhOczipG+blBIQKfKln91uF8i+irowFLB4i13KBEAhcn5Fkx+nwjjjbLq2mtD0S
        ATWxtqL4UhsgbTDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch v2 07/38] x86/cpu: Move cu_id into topology info
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:12:51 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h |    4 +++-
 arch/x86/kernel/cpu/amd.c        |    2 +-
 arch/x86/kernel/cpu/common.c     |    2 +-
 arch/x86/kernel/smpboot.c        |    6 +++---
 4 files changed, 8 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -89,6 +89,9 @@ struct cpuinfo_topology {
 	// Physical die ID on AMD, Relative on Intel
 	u32			die_id;
 
+	// Compute unit ID - AMD specific
+	u32			cu_id;
+
 	// Core ID relative to the package
 	u32			core_id;
 };
@@ -109,7 +112,6 @@ struct cpuinfo_x86 {
 	__u8			x86_phys_bits;
 	/* CPUID returned core id bits: */
 	__u8			x86_coreid_bits;
-	__u8			cu_id;
 	/* Max extended CPUID function supported: */
 	__u32			extended_cpuid_level;
 	/* Maximum supported CPUID level, -1=no CPUID: */
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -341,7 +341,7 @@ static void amd_get_topology(struct cpui
 		c->topo.die_id  = ecx & 0xff;
 
 		if (c->x86 == 0x15)
-			c->cu_id = ebx & 0xff;
+			c->topo.cu_id = ebx & 0xff;
 
 		if (c->x86 >= 0x17) {
 			c->topo.core_id = ebx & 0xff;
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1789,7 +1789,7 @@ static void identify_cpu(struct cpuinfo_
 	c->x86_model_id[0] = '\0';  /* Unset */
 	c->x86_max_cores = 1;
 	c->x86_coreid_bits = 0;
-	c->cu_id = 0xff;
+	c->topo.cu_id = 0xff;
 #ifdef CONFIG_X86_64
 	c->x86_clflush_size = 64;
 	c->x86_phys_bits = 36;
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -490,9 +490,9 @@ static bool match_smt(struct cpuinfo_x86
 			if (c->topo.core_id == o->topo.core_id)
 				return topology_sane(c, o, "smt");
 
-			if ((c->cu_id != 0xff) &&
-			    (o->cu_id != 0xff) &&
-			    (c->cu_id == o->cu_id))
+			if ((c->topo.cu_id != 0xff) &&
+			    (o->topo.cu_id != 0xff) &&
+			    (c->topo.cu_id == o->topo.cu_id))
 				return topology_sane(c, o, "smt");
 		}
 

