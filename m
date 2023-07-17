Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82172757050
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjGQXPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjGQXOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:14:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F1213D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:14:46 -0700 (PDT)
Message-ID: <20230717223223.499996154@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=809REvyTd02dVym8hZUdnfHZr/NK3BOiIohksfQj1oM=;
        b=OSPy2UhFd09/ntzkIYSXS6s/mbRnTChHppEUB/1L2PXKotrU23qCWkP8rxGdbPNv02bis+
        a3VCnrvCQZPqGUmclFr74+BQHp9hdtpLRFY7zP36qb4OjntldkSH8WFQ5b0ADcfT+ig4LF
        eodtB48BkmezgzqNwbtnP17fFMJR448pc8MEA0r6+T+7ly8pKiDaFwuF8n3F0cnIAz0Mc0
        xyu+Ma0s7h2rS+J5rRTiPPbqBZw2H9d61TYrZwzO1nnnvxnr4WPVs8iiOItqVIaMHA79th
        f1kiVjK9qaWpdmb3IH0SVvyhkWHNKuJAaaL6FDyF6uUP9hTmct+e4Xg6WjONyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=809REvyTd02dVym8hZUdnfHZr/NK3BOiIohksfQj1oM=;
        b=ADoR2blho6PKngC8a52eEUoeHgo7A+4lZEFer0P0ADyyZzbXHXrPAP/lkqekL+1+GQLbtY
        lfMOU4x36OYNRbDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 07/58] x86/apic: Remove unused max_physical_apicid
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:14:44 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic.c |    8 --------
 1 file changed, 8 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -74,11 +74,6 @@ EXPORT_SYMBOL_GPL(boot_cpu_physical_apic
 u8 boot_cpu_apic_version __ro_after_init;
 
 /*
- * The highest APIC ID seen during enumeration.
- */
-static unsigned int max_physical_apicid;
-
-/*
  * Bitmask of physically existing CPUs:
  */
 physid_mask_t phys_cpu_present_map;
@@ -2541,9 +2536,6 @@ int generic_processor_info(int apicid, i
 			boot_cpu_apic_version, cpu, version);
 	}
 
-	if (apicid > max_physical_apicid)
-		max_physical_apicid = apicid;
-
 #if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
 #endif

