Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6745B766C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbjG1MNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjG1MMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:12:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFD526BC;
        Fri, 28 Jul 2023 05:12:50 -0700 (PDT)
Message-ID: <20230728120929.944578301@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=W37gGs0lCrcES4uNg1Zl0+g2c0hE6iWg5mZxC7Tosgc=;
        b=LOYZuo50rp6pzKVY1Fnas4hlljh8Dcx+O7JxDpCZVwY11odiab00Z6zUTMe+C4rORSDShX
        Av7wImZZKDcpWsxz3EkDneqXmmnUZ9Iejm33NVM0rAFEtQyelifeUwUha2v7ye+T4FRXfs
        LfsXr5/faRsUZXuIId3JcEZtF4HkhhQQBnomZe4DKT/Lab0wyfg90a+uu2pJxO7/lp8tL1
        dkSoME+zzHBeiccBod+V90gGSV8C3Tp/3MIDMBFioEm9MkDrSvpqQm575nG+ajbIrf18TA
        EUnfcb1aaj4cWghdBfukHif7u9I4JsSNY8MP1z8ybxlEhaOp/FRIJCrdsMPNXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=W37gGs0lCrcES4uNg1Zl0+g2c0hE6iWg5mZxC7Tosgc=;
        b=a6l8K8mqvplkdOJM9DVMpMo/hwRXJORjx2hRIi6zSgLhEApv/7A8+HtV7z6NdaPzjKqpot
        V/O2k2hBSmH97IDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch v2 05/38] hwmon: (fam15h_power) Use topology_core_id()
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:12:48 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the provided topology helper function instead of fiddling in cpu_data.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Huang Rui <ray.huang@amd.com>
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

