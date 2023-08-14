Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEA277B4BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjHNIya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbjHNIxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:53:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540E591
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:53:48 -0700 (PDT)
Message-ID: <20230814085112.506988471@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692003227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8+6vOcIueVcOIj2konXv5XCSnSsK5weDJeCrayvpOfg=;
        b=fPzk2+J4fdut/Xv+4xRxKIHbg5QOGgBxAwmk+dsyGmjQ7b4HTZSWBG5ZTMnmBqgIXEZAPp
        bWPBnoXrjdSQUDs+WcusTiN7AFQUuR1NJIGogDsUfoM5bwSyo2GPtN8Q/rqpm6g/o6lTpZ
        fu/5OmGKqCKvzaf7jzICYs6puoAqb8ucUL/5bSSwAYrdLARUuDcflK47UMNJyEnLB13uUn
        oi+inRUOvwLEndabC5Lvv50XW5ewdWDH2vJeH4Y2UdqnsOzclcQfIqlk05H5cIFuomqrWH
        qNv8YR5xMMlM/lRuiA56PxJXA2cl7X34lXoMT+rk1w6RrEaS5dXN1tfkv7p4Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692003227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8+6vOcIueVcOIj2konXv5XCSnSsK5weDJeCrayvpOfg=;
        b=4oA3sMpg/OV8OMkmWdqy/4PuV2Mtdyv+g+ukz9FM2HO0WdJYqfg80p5wtnKtSQ6n1Joq8q
        1b1fyLljTosEmzDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [patch V4 08/41] hwmon: (fam15h_power) Use topology_core_id()
References: <20230814085006.593997112@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 10:53:46 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the provided topology helper function instead of fiddling in cpu_data.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>

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



