Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E95776CAAE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjHBKVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjHBKVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:21:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C8A2720;
        Wed,  2 Aug 2023 03:21:10 -0700 (PDT)
Message-ID: <20230802101933.104722355@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690971669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=W37gGs0lCrcES4uNg1Zl0+g2c0hE6iWg5mZxC7Tosgc=;
        b=F+C9H0DtgncTnkKKBoGxFVPsR6sHb0qwuu7W+vof+Q/fWU0keEEA+c/rOi4bZSuoDiaiXP
        oYt/1oPQsa8rXyPAUwBncl1m7T/6ut3RVLIuIxsC2nMsxHJdLdMpz9SCzWoBW9I4rJrjt2
        BoBpbBoBA0LSCLnAY+5EX6gNiTiK62C7Drb7EQV+gqf+XYzYr73P6OD1OpTDAygwQBX4cd
        BFxZi2MYFacfwyZuB3UynU1qPO14p72U2rUpWDBwOL5advuWSVgXeIiBt79x23CEHVDjBD
        xdjcA6e7bNRdpjwDfHuSacW44OECgcf35t5mYoDfv1Coh3aMgGVSFKYVUm8rKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690971669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=W37gGs0lCrcES4uNg1Zl0+g2c0hE6iWg5mZxC7Tosgc=;
        b=aR/ClK7pK4d9Nw2NUuBu457SIW7LhYP+u61EVLZ0/hmwVXpsc9Nc7pYCjXgLciQPL8W47x
        UEnwG0GlNyzhmhBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Subject: [patch V3 07/40] hwmon: (fam15h_power) Use topology_core_id()
References: <20230802101635.459108805@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  2 Aug 2023 12:21:08 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

