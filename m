Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356437B6298
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjJCHiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjJCHiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:38:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB45290;
        Tue,  3 Oct 2023 00:38:51 -0700 (PDT)
Date:   Tue, 03 Oct 2023 07:38:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696318729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rgSGq3Z6E3846QpBwJ+wxMSZWZxgv5W9g5Ebek0aVvE=;
        b=RdYF3n1z6ztLNQitGrdJUUMuarthGXZKpoYQHQTaRLDwE3fPdIGSz1jUdDx7yyXO0Xaqw8
        yuxhYDNAvfx/4wzZYg2JIIk9Sg5EvQRm/bG/NbWQXdkIaMisIr8KlkjPy1P6jFBFHud71c
        VzsAmbMCL9oNXktSb3kW38q4lg3ROXQJsSDp+c160etF9KC9LV5YGWleSuT+K2XW3h9eWg
        EGtAoawtSnwWCmq0MUpTIyx3CLKq1UM6AE4wIfP/WmCWvaZrdFewHyY0nPQB4gjiuzXOj7
        8gjhLZpYPqCSU/Nx0UfVVDnXnQYOpSh+F9fW3lz+WIPXwJtFEwoJ1Z6HtWQWyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696318729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rgSGq3Z6E3846QpBwJ+wxMSZWZxgv5W9g5Ebek0aVvE=;
        b=KdSWxw6jsHelXvChuerF23cJXNwgH5uUCRXXy6shPNT6KP+kWEpKCLMiGZaw/Qu2oul2nW
        3WcqEMcGCr/GsbAA==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/boot: Move x86_cache_alignment initialization to
 correct spot
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002220045.1014760-1-dave.hansen@linux.intel.com>
References: <20231002220045.1014760-1-dave.hansen@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169631872850.3135.7519973576478959373.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     3e32552652917f10c0aa8ac75cdc8f0b8d257dec
Gitweb:        https://git.kernel.org/tip/3e32552652917f10c0aa8ac75cdc8f0b8d257dec
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Mon, 02 Oct 2023 15:00:45 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 09:27:12 +02:00

x86/boot: Move x86_cache_alignment initialization to correct spot

c->x86_cache_alignment is initialized from c->x86_clflush_size.
However, commit fbf6449f84bf moved c->x86_clflush_size initialization
to later in boot without moving the c->x86_cache_alignment assignment:

  fbf6449f84bf ("x86/sev-es: Set x86_virt_bits to the correct value straight away, instead of a two-phase approach")

This presumably left c->x86_cache_alignment set to zero for longer
than it should be.

The result was an oops on 32-bit kernels while accessing a pointer
at 0x20.  The 0x20 came from accessing a structure member at offset
0x10 (buffer->cpumask) from a ZERO_SIZE_PTR=0x10.  kmalloc() can
evidently return ZERO_SIZE_PTR when it's given 0 as its alignment
requirement.

Move the c->x86_cache_alignment initialization to be after
c->x86_clflush_size has an actual value.

Fixes: fbf6449f84bf ("x86/sev-es: Set x86_virt_bits to the correct value straight away, instead of a two-phase approach")
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20231002220045.1014760-1-dave.hansen@linux.intel.com
---
 arch/x86/kernel/cpu/common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8d7063e..9c51ad5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1141,6 +1141,7 @@ void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 		}
 	}
 	c->x86_cache_bits = c->x86_phys_bits;
+	c->x86_cache_alignment = c->x86_clflush_size;
 }
 
 static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
@@ -1594,8 +1595,6 @@ static void __init cpu_parse_early_param(void)
  */
 static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 {
-	c->x86_cache_alignment = c->x86_clflush_size;
-
 	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
 	c->extended_cpuid_level = 0;
 
