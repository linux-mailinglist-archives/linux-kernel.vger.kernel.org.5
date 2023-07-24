Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4A275FE1E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjGXRo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjGXRoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:44:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71BE19A5;
        Mon, 24 Jul 2023 10:44:03 -0700 (PDT)
Message-ID: <20230724172844.104485850@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690220642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=k2X30la9A+LiFs91Fg8KfkdfnmktWy8AebFx0bnllDY=;
        b=O+9Mg+126PfNlajAwHFFMIPmwUl0//wQCF6vuyW7VQtI3/07w2/0E8nKJUrW2axeITd92i
        KK8cGelopeE2Mo/7kWeQmbKY+q+LnqlALgQ6hMBKl7IKimkszU0OZng45IfXf5iMPeyTgw
        P3PGMt7JGcClA+HZ1ieFtKfbiooVQycW2BESHnnnGBUj7FGCJJTEKNbQiel4F4UlmVInXT
        NeykrY0yey5Kc9JT7fcxa2YVCYZDv433U528W4HKNMATXMzf0RrDPOWX9FG8IhU1Q8X2Wg
        K4e3a87R24RaRpdyVJVrpRsAJR5N14E8qEG+sba1F/KkCEu4LL1Cos1x5WKbsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690220642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=k2X30la9A+LiFs91Fg8KfkdfnmktWy8AebFx0bnllDY=;
        b=/Xgdi50Nxi/RiaqZLbY+/v6LJvpqItsngV9epHy9QJ98YhdBvIpvmcRRAB2DRoOKMaToGM
        iKvL52vd699RwKBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch 07/29] x86/cpu: Move cu_id into topology info
References: <20230724155329.474037902@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 19:44:01 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h |    9 ++++++++-
 arch/x86/kernel/cpu/amd.c        |    2 +-
 arch/x86/kernel/cpu/common.c     |    2 +-
 arch/x86/kernel/smpboot.c        |    6 +++---
 4 files changed, 13 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -78,11 +78,19 @@ extern u16 __read_mostly tlb_lld_1g[NR_I
  */
 
 struct cpuinfo_topology {
+	// Real APIC ID read from the local APIC
 	u16			apicid;
+	// The initial APIC ID provided by CPUID
 	u16			initial_apicid;
 
+	// Physical package ID
 	u16			pkg_id;
+	// Physical die ID on AMD, Relative on Intel
 	u16			die_id;
+	// Compute unit ID - AMD specific
+	u16			cu_id;
+
+	// Core ID relative to the package
 	u16			core_id;
 };
 
@@ -102,7 +110,6 @@ struct cpuinfo_x86 {
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
 

