Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DE477B4E5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbjHNI4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbjHNIyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:54:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB8610B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:54:38 -0700 (PDT)
Message-ID: <20230814085114.422748199@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692003277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=DKDeifQNE2gzfZT0qDOAFL1F6DNu3u0Ktu+/JKbdS38=;
        b=TYxBIHZkonVHLLx5Ica8jZF8hPJkiGu6nOwHuvcTV02nnbSacsa77jMhhbEUoiyurrWJK8
        j4IKNVELYN90/ZcloktkeGNLslegl4wmiNGio7xwH5nnS1UL2IvQcmheLK9E9GS03UrOML
        SdzCbiHyvoeG8YkenYQ6zDKasg8DBhwjFUAz7Lqmp1Lt7QvaSIsQ1WLsykaadsRos2VJg6
        +mvpxkdOljE5/vT2UGKok50TMqUEP+E/bzvMbPYXNFa/5Leu5Jeu6895Q7t3im2F4lDjKZ
        xyaR4Y9BvoEN/6bdZYvuMcjx/KX6iamAj9nQZmTueNzKrNuHkpIk/YQdrzMVGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692003277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=DKDeifQNE2gzfZT0qDOAFL1F6DNu3u0Ktu+/JKbdS38=;
        b=kusI9gzoglLVpvJc/LiUKOYcTlzdvhUeXFlIWHGapRktAY7UnVOXqv2GUZPj8K17UfiBMt
        ujln9XXjJawqrXDw==
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
        Sohil Mehta <sohil.mehta@intel.com>
Subject: [patch V4 40/41] x86/xen/smp_pv: Remove cpudata fiddling
References: <20230814085006.593997112@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 10:54:36 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new topology CPUID parser installs already fake topology for XEN/PV,
which ends up with cpuinfo::max_cores = 1.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>

---
V2: New patch
---
 arch/x86/xen/smp_pv.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -73,7 +73,6 @@ static void cpu_bringup(void)
 	}
 	cpu = smp_processor_id();
 	smp_store_cpu_info(cpu);
-	cpu_data(cpu).x86_max_cores = 1;
 	set_cpu_sibling_map(cpu);
 
 	speculative_store_bypass_ht_init();
@@ -223,8 +222,6 @@ static void __init xen_pv_smp_prepare_cp
 
 	smp_prepare_cpus_common();
 
-	cpu_data(0).x86_max_cores = 1;
-
 	speculative_store_bypass_ht_init();
 
 	xen_pmu_init(0);



