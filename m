Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2656C776831
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjHITM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjHITMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:12:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136D62718;
        Wed,  9 Aug 2023 12:12:25 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ePpxdb54UK1w0dW/aOACxgPueYpJk/5MQbAXokeoOik=;
        b=IpgwJJIZbEC5wSbbiRbn/KNdZhihTac2Yba+t5gaOwpJa4ZcN/ez/lri/i6wPfubh8kd+t
        qHKdiEOjQZcLDRNF9s7ArsKKvK0+5RnsQaleLPWNc07EnB+v2s3Jw5NErp7ViSZhn7HHiT
        dK2zt93RF0dpy0dIn3ekjOvhIx6sMK+l0mwTzqiQ4tNhccrvZKzwYVgFz2LrxLzcfnzwpX
        W9VlKFg3hQqxXQQEPxJkvTjFMFfNxUczuNEMsYg+3O/WUIHF4hX9z1CQAMlJaYmVXf4TBq
        6qX5XZBgVSgU0ldUEhpD3erkcz38zr9geZxLnn1nPJ0vBNooawhgIYp26gn0HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ePpxdb54UK1w0dW/aOACxgPueYpJk/5MQbAXokeoOik=;
        b=E5h8WbS6BmrP1KupnMEWHiruGuAewEsq1N4R9g15wU+3ovKy4xN8F6o+I/PBlqFPyK6Y5x
        5xBqn42mhgU33pDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Mop up early_per_cpu() abuse
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834035.27769.6808573188622126756.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     e3243ed0142bb438bbd284c8c04f4c8e0c2ff498
Gitweb:        https://git.kernel.org/tip/e3243ed0142bb438bbd284c8c04f4c8e0c2ff498
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:54 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:24 -07:00

x86/apic: Mop up early_per_cpu() abuse

UV X2APIC uses the per CPU variable from:

  native_smp_prepare_cpus()
    uv_system_init()
      uv_system_init_hub()

which is long after the per CPU areas have been set up.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 0d812fd..8b14451 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1843,7 +1843,7 @@ static void __init uv_system_init_hub(void)
 
 	/* Initialize per CPU info: */
 	for_each_possible_cpu(cpu) {
-		int apicid = early_per_cpu(x86_cpu_to_apicid, cpu);
+		int apicid = per_cpu(x86_cpu_to_apicid, cpu);
 		unsigned short bid;
 		unsigned short pnode;
 
