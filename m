Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F7575FE19
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjGXRoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjGXRoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:44:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5FC199F;
        Mon, 24 Jul 2023 10:44:00 -0700 (PDT)
Message-ID: <20230724172843.988600888@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690220638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CslJ+Xs2tAisZ7a4ZqDrI1gRhP1PqFVCqCsoM4wylLI=;
        b=R2wnfNQmqunLRY9XPRWZg+VJw3KkrEOy42EITG+7Nz9+T0sJ6IwMAswXMV+NJYWPf9MyMd
        QTE6xm1vDiMz7ZXLx7/ISd32xcTS3GKMjMp+MQqqJ3FSXOmRRtm8MaceBKqbPnQJQ4UAub
        RQX/v14hTjdZI4A41NwNuoClA0M4y9P0QLX8HsXM18Eg4KAviW2gmcZba34D7rvSe9C7nM
        iXobfegv5hhHmpGMdwtnm4ndfMNUdVMgGU9dXE81ogAm2vGQ12lQEA71H4PMGIJOF57LDX
        w6pT2xtPTP0WfAe9tSP9yV0y2BbQAGFT3CL2IedsbcUnIEFzOIvFZO/IrW9b3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690220638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CslJ+Xs2tAisZ7a4ZqDrI1gRhP1PqFVCqCsoM4wylLI=;
        b=7QbHM3qHvKAKOdgO+brAqUON4uCmq5hCWTk4SrwJ50NA5zPUME/eAvnAQTCjC6+RhSXwFH
        m9OpPsbrFwyslvAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch 05/29] hwmon: (fam15h_power) Use topology_core_id()
References: <20230724155329.474037902@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 19:43:58 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the provided topology helper function instead of fiddling in cpu_data.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-hwmon@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/fam15h_power.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -17,6 +17,7 @@
 #include <linux/cpumask.h>
 #include <linux/time.h>
 #include <linux/sched.h>
+#include <linux/topology.h>
 #include <asm/processor.h>
 #include <asm/msr.h>
 
@@ -134,15 +135,13 @@ static DEVICE_ATTR_RO(power1_crit);
 static void do_read_registers_on_cu(void *_data)
 {
 	struct fam15h_power_data *data = _data;
-	int cpu, cu;
-
-	cpu = smp_processor_id();
+	int cu;
 
 	/*
 	 * With the new x86 topology modelling, cpu core id actually
 	 * is compute unit id.
 	 */
-	cu = cpu_data(cpu).cpu_core_id;
+	cu = topology_core_id(smp_processor_id());
 
 	rdmsrl_safe(MSR_F15H_CU_PWR_ACCUMULATOR, &data->cu_acc_power[cu]);
 	rdmsrl_safe(MSR_F15H_PTSC, &data->cpu_sw_pwr_ptsc[cu]);

