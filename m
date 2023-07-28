Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F86766CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbjG1MO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbjG1MNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:13:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30224488;
        Fri, 28 Jul 2023 05:13:14 -0700 (PDT)
Message-ID: <20230728120931.007571739@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=R30kgmHCGWHq0zLlNoJY82eQjQTUWAtGppL/g8UfpDM=;
        b=OcdeD+K47LagVHhbUTFW0HWmbg527ioHizlrWIVtWMqemkNmU3bRC93QSvXZ2JjPBBdwj9
        id63sOY/cGprDxAnyG8/ISXkVIFXtBvwCzjpuy5I0VQbpT2fXfhU4P9aveuse3FpN211CO
        LeWDBdUWoShLYSdhOMPzabZZEzQUmmS4SEYGjbrxcSDeVYvnZNor9QELm038SbNJxepEKV
        rDsgwy6fHsjJaIF9hHti39/rd0/0L0mnAK6Ba9sQ03fdc0PGv5ZnMxw7I2eGlQF38D1CzS
        A/wZQouOdrS3WuqPORQmpu7fyPBqsjCNFKSnxQDhuxuyQJZ//ImfpIg2J9KKKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=R30kgmHCGWHq0zLlNoJY82eQjQTUWAtGppL/g8UfpDM=;
        b=TauKNaxNPwe9knjpTLPHgNWEc4opHe/7dKLdhEmMnhnGx4oqcCCuwdI8liKC33xubJtsD4
        sntrcMNHQHUdn3Bw==
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
Subject: [patch v2 24/38] x86/cpu: Move __max_die_per_package to common.c
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:13:12 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of a complete replacement for the topology leaf 0xb/0x1f
evaluation, move __max_die_per_package into the common code.

Will be removed once everything is converted over.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/common.c   |    3 +++
 arch/x86/kernel/cpu/topology.c |    3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -75,6 +75,9 @@ u32 elf_hwcap2 __read_mostly;
 int smp_num_siblings = 1;
 EXPORT_SYMBOL(smp_num_siblings);
 
+unsigned int __max_die_per_package __read_mostly = 1;
+EXPORT_SYMBOL(__max_die_per_package);
+
 static struct ppin_info {
 	int	feature;
 	int	msr_ppin_ctl;
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -25,9 +25,6 @@
 #define BITS_SHIFT_NEXT_LEVEL(eax)	((eax) & 0x1f)
 #define LEVEL_MAX_SIBLINGS(ebx)		((ebx) & 0xffff)
 
-unsigned int __max_die_per_package __read_mostly = 1;
-EXPORT_SYMBOL(__max_die_per_package);
-
 #ifdef CONFIG_SMP
 /*
  * Check if given CPUID extended topology "leaf" is implemented

