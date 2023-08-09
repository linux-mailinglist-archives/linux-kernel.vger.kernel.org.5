Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A290E776586
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjHIQuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjHIQtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:49:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC832100;
        Wed,  9 Aug 2023 09:49:37 -0700 (PDT)
Date:   Wed, 09 Aug 2023 16:49:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691599776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/GwX0rszb2x9MA2YppYcgNgbM4zFjweMap2+ZtzhiVw=;
        b=q1kdMC1bTt66vt+IaBU968aO7ZDOvVO3xvKfzvSvzEZb2yREB9queDcih0MKbudAI62135
        zug9vrGIlR3Ex0/zNBiDCEjCq98UD/kx3haHpzRu3UiF+IIG9VuIhk61kd6/6BU088fJCd
        w3Sdxl3l3uWYurCPyzDpR1FsBIqEYC21d3zSmuTmJQExeCR5ZvNwxtzSb+F/rZmNME6TpF
        fMG5vwPxJi1Wzl1y1glkN9dzqJi43KxuhZxprpYqF/uRl4K7S5R9CS95y79sOPok4B1q1R
        isTfJLK0DgowBIux9N99iH1YV9Ikh1o9XlA3RQooxIkt8GGRhcwPGBXPx6V56A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691599776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/GwX0rszb2x9MA2YppYcgNgbM4zFjweMap2+ZtzhiVw=;
        b=K85Zuc6h4XJA920lkzTrjwFjcWRmc4osgDUxDBZvx7R1BIdqoXuE/3uUy0Z+Xg0wDbqpvV
        3/0PcYcNjvi5DICw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Mop up early_per_cpu() abuse
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159977585.27769.18374483975095792643.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     94f775bda55918705399d4e05e868a5cd40e14fe
Gitweb:        https://git.kernel.org/tip/94f775bda55918705399d4e05e868a5cd40e14fe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:54 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:11 -07:00

x86/apic: Mop up early_per_cpu() abuse

UV X2APIC uses the per CPU variable from:

  native_smp_prepare_cpus()
    uv_system_init()
      uv_system_init_hub()

which is long after the per CPU areas have been set up.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
 
