Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5005B7726B1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjHGNyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbjHGNxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AF01730
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:15 -0700 (PDT)
Message-ID: <20230807135027.796685292@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8e5qBi4unbK4L9kV01zqCd39sEuWF2ZwMPDC4Zm+oQs=;
        b=Is6BpuQgQgj9xzGXJxqihTeaMeVw8uEILDbIHbeElhwkCzwWmpo/8LYQofgt/TOawXtJ0G
        EeoUXs4J5UD7JuuSjkeK0lc/58+35RjlW4XREky0zjiTFe/JcXU7hWyCUTehB+3NRBrm7O
        89Jvaxxv3VcqbDBLVrOO522hqfCTWIKErctq39DniQPTgLVcIiRXQfWl47tu2bSPEPU+GC
        UCDlQsOU2Z9MRAV4VxvVSxoTH2Lyf9hesO64BvEovW33KanWUSfb7BgMqrsK6DKciMnDF+
        qqzA7pyRUSyo5Y8vv9amX4X4J/IK83+UvzntsajQNyyC/vi+VAtzHk3h+ZorPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8e5qBi4unbK4L9kV01zqCd39sEuWF2ZwMPDC4Zm+oQs=;
        b=ey+nGSKuhNoQUjZQeNNDsLjkZN7xbQMRrS8kscyyAcKgy4BRjwR4DF4xkX8z0+Joc7kL4u
        ab7Nt8aToFkDpbDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: [patch 26/53] x86/jailhouse: Use new APIC registration function
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:14 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/jailhouse.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -102,7 +102,7 @@ static void __init jailhouse_parse_smp_c
 	register_lapic_address(0xfee00000);
 
 	for (cpu = 0; cpu < setup_data.v1.num_cpus; cpu++)
-		generic_processor_info(setup_data.v1.cpu_ids[cpu]);
+		topology_register_apic(setup_data.v1.cpu_ids[cpu], CPU_ACPIID_INVALID, true);
 
 	smp_found_config = 1;
 

