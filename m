Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D3477B4B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjHNIxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbjHNIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:53:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6132E10C;
        Mon, 14 Aug 2023 01:53:37 -0700 (PDT)
Message-ID: <20230814085112.089607918@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692003216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Y9F9yeUeXRQvv+8dtwJvn71MCeSGQXeJdooQjtDdUX4=;
        b=2AtO09Ke4+/nJKkcI0sgENvQf5F3G5miUPawzn/yBKF1usSUeX/9HNxrs0fT4wjG6GzMC2
        88T8A1mecbgdFIx6RE4NAd63+lSNjO5ETjDogddz6pDkKtNjaElv/yqD0L3gCg0f8b7eXg
        pFlozKVgV/3zRpwzOCZmxhkhur6QHq59D2A/zW01OGqQKy/4w3el7qSEnV8fwPEtqOjIH9
        u5/1ZNHIPI20cWNDBTWV7ko+ZKzkK/26D9f1F8XDCH5dpuiKLuumGal9v9CxugOuJCTNQd
        5EoUHzHdJvi+9C9PGYCYsFUcPhyJpAeB7Zf4P8m5EhBpp0t6/RKxEiPRySJXzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692003216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Y9F9yeUeXRQvv+8dtwJvn71MCeSGQXeJdooQjtDdUX4=;
        b=50DmVM3PmmqCp5//BMBetP3zy9RVpPF/qLqA4C19BsIfm0xgcn6HZEoiqjj8SlPHsI+5Zv
        VKE8dzw5OjnPpRBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, <stable@vger.kernel.org>
Subject: [patch V4 01/41] x86/cpu/hygon: Fix the CPU topology evaluation for
 real
References: <20230814085006.593997112@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 10:53:35 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pu Wen <puwen@hygon.cn>

Hygon updated processors have CPUID leaf 0xB correctly populated and don't
need the fixed package ID shift workaround. The fixup is also incorrect
when running in a guest.

Fixes: e0ceeae708ce ("x86/CPU/hygon: Fix phys_proc_id calculation logic for multi-die processors")
Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/tencent_594804A808BD93A4EBF50A994F228E3A7F07@qq.com

---
 arch/x86/kernel/cpu/hygon.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -87,8 +87,12 @@ static void hygon_get_topology(struct cp
 		if (!err)
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
-		/* Socket ID is ApicId[6] for these processors. */
-		c->phys_proc_id = c->apicid >> APICID_SOCKET_ID_BIT;
+		/*
+		 * Socket ID is ApicId[6] for the processors with model <= 0x3
+		 * when running on host.
+		 */
+		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) && c->x86_model <= 0x3)
+			c->phys_proc_id = c->apicid >> APICID_SOCKET_ID_BIT;
 
 		cacheinfo_hygon_init_llc_id(c, cpu);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {



