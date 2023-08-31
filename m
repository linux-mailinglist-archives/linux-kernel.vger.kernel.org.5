Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0EC78F29A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345408AbjHaS3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244704AbjHaS3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:29:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F05BE69;
        Thu, 31 Aug 2023 11:29:37 -0700 (PDT)
Date:   Thu, 31 Aug 2023 18:29:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693506575;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CxxkCCKN7zkzoUmSJWbQ/w3K6kG8rTUbbFDU2aM6cCA=;
        b=GGutSrbND0NZF379PiLyMiK2amiKt6/jshQZm87GM6HBqfz8zpivcxRSCMZuIuKKIfAbDV
        NTTjyPmHIU+FijKLqvj7kxbi9cGZLuMsyrjXHLx1LohZAOsi5Q0atRsZ8Vdu1sVNlEBkWO
        c9aWxesGmYrU7SwLL1q5FNJfhNuxDyY+8na/R+eTvoCqAbLRU0a643sFuuSGaJzyDxirv7
        1ZwBD1gqrp+KIHKUrdVTKqj757q0kmdllWZdm3EPsuLJYifshc/N/TbH/ANpqCpDPgJOZk
        NyfqfTuG1r+uIJnkx4hXBScpztvuoaRVU/zsOHVZ4rsbvxaxykrolwr1fGO90w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693506575;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CxxkCCKN7zkzoUmSJWbQ/w3K6kG8rTUbbFDU2aM6cCA=;
        b=4+kgQahPqwfKsnd2ASEYMIuK5b11qxHacgr/LPKQ9hhMobyuvzY2LktfYbBpvBACK/sT7A
        uhg5gxsdyyxZ+VBQ==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/speculation: Mark all Skylake CPUs as vulnerable to GDS
Cc:     Michael Zhivich <mzhivich@akamai.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169350657484.27769.4550404713182382438.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c9f4c45c8ec3f07f4f083f9750032a1ec3eab6b2
Gitweb:        https://git.kernel.org/tip/c9f4c45c8ec3f07f4f083f9750032a1ec3eab6b2
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Tue, 29 Aug 2023 08:07:25 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 31 Aug 2023 20:20:31 +02:00

x86/speculation: Mark all Skylake CPUs as vulnerable to GDS

The Gather Data Sampling (GDS) vulnerability is common to all Skylake
processors.  However, the "client" Skylakes* are now in this list:

	https://www.intel.com/content/www/us/en/support/articles/000022396/processors.html

which means they are no longer included for new vulnerabilities here:

	https://www.intel.com/content/www/us/en/developer/topic-technology/software-security-guidance/processors-affected-consolidated-product-cpu-model.html

or in other GDS documentation.  Thus, they were not included in the
original GDS mitigation patches.

Mark SKYLAKE and SKYLAKE_L as vulnerable to GDS to match all the
other Skylake CPUs (which include Kaby Lake).  Also group the CPUs
so that the ones that share the exact same vulnerabilities are next
to each other.

Last, move SRBDS to the end of each line.  This makes it clear at a
glance that SKYLAKE_X is unique.  Of the five Skylakes, it is the
only "server" CPU and has a different implementation from the
clients of the "special register" hardware, making it immune to SRBDS.

This makes the diff much harder to read, but the resulting table is
worth it.

I very much appreciate the report from Michael Zhivich about this
issue.  Despite what level of support a hardware vendor is providing,
the kernel very much needs an accurate and up-to-date list of
vulnerable CPUs.  More reports like this are very welcome.

* Client Skylakes are CPUID 406E3/506E3 which is family 6, models
  0x4E and 0x5E, aka INTEL_FAM6_SKYLAKE and INTEL_FAM6_SKYLAKE_L.

Reported-by: Michael Zhivich <mzhivich@akamai.com>
Fixes: 8974eb588283 ("x86/speculation: Add Gather Data Sampling mitigation")
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/kernel/cpu/common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index e3a65e9..00f043a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1265,11 +1265,11 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(BROADWELL_G,	X86_STEPPING_ANY,		SRBDS),
 	VULNBL_INTEL_STEPPINGS(BROADWELL_X,	X86_STEPPING_ANY,		MMIO),
 	VULNBL_INTEL_STEPPINGS(BROADWELL,	X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(SKYLAKE_L,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED),
 	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(SKYLAKE,		X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
 	VULNBL_INTEL_STEPPINGS(CANNONLAKE_L,	X86_STEPPING_ANY,		RETBLEED),
 	VULNBL_INTEL_STEPPINGS(ICELAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
 	VULNBL_INTEL_STEPPINGS(ICELAKE_D,	X86_STEPPING_ANY,		MMIO | GDS),
