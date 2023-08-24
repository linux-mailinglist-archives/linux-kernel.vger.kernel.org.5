Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40053786B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbjHXJLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbjHXJLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:11:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1B91987;
        Thu, 24 Aug 2023 02:11:17 -0700 (PDT)
Date:   Thu, 24 Aug 2023 09:11:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692868275;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsQmzRZcUhhjr7gynNHjs8c+DmyFh6gWGhToPlng6lA=;
        b=WMSDkt5ISqnK55yL9RhO0kRLbobYgpcn6YVzBjK5I9OtunbI+ZzCynI6TYtEsBln6AIVRP
        5Fkivr4fBIMwRjT8jJjkZYCZefcAPluIfs9VzSx5+pKEPPUpjpYd5u5+ODWlZHTarCa8Av
        wODhWavU1bsKtUPzuDVe/LLD6+iP+VPGHJKxpbg8sWt0ATCYHUKGDvpkyxiK3amnkQ8r+p
        gq7t6mSvoOomgsbcc4tLg0qZ+yBs/vOzff8ilxFITC62OjkvvN2mfKAF98NkX4IE5kWv8C
        SsRsOQEAAk/LfIU+oORXl2opoZ3GjFjQOB0QHULKEgg8/jr2Hoy0q9BwBmlg0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692868275;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsQmzRZcUhhjr7gynNHjs8c+DmyFh6gWGhToPlng6lA=;
        b=yQp6cWF0VI8mxJ9eBCfV9maSFVYL5slYsPminj5+4uEQOd5Fns+TnbSB0WoDcZR1L2WCtk
        ehOx54nuN/zczbDw==
From:   "tip-bot2 for Feng Tang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Set X86_FEATURE_OSXSAVE feature after
 enabling OSXSAVE in CR4
Cc:     kernel test robot <oliver.sang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <202307192135.203ac24e-oliver.sang@intel.com>
References: <202307192135.203ac24e-oliver.sang@intel.com>
MIME-Version: 1.0
Message-ID: <169286827486.27769.994183123873151501.tip-bot2@tip-bot2>
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

Commit-ID:     2c66ca3949dc701da7f4c9407f2140ae425683a5
Gitweb:        https://git.kernel.org/tip/2c66ca3949dc701da7f4c9407f2140ae425683a5
Author:        Feng Tang <feng.tang@intel.com>
AuthorDate:    Wed, 23 Aug 2023 14:57:47 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Aug 2023 11:01:45 +02:00

x86/fpu: Set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR4

0-Day found a 34.6% regression in stress-ng's 'af-alg' test case, and
bisected it to commit b81fac906a8f ("x86/fpu: Move FPU initialization into
arch_cpu_finalize_init()"), which optimizes the FPU init order, and moves
the CR4_OSXSAVE enabling into a later place:

   arch_cpu_finalize_init
       identify_boot_cpu
	   identify_cpu
	       generic_identify
                   get_cpu_cap --> setup cpu capability
       ...
       fpu__init_cpu
           fpu__init_cpu_xstate
               cr4_set_bits(X86_CR4_OSXSAVE);

As the FPU is not yet initialized the CPU capability setup fails to set
X86_FEATURE_OSXSAVE. Many security module like 'camellia_aesni_avx_x86_64'
depend on this feature and therefore fail to load, causing the regression.

Cure this by setting X86_FEATURE_OSXSAVE feature right after OSXSAVE
enabling.

[ tglx: Moved it into the actual BSP FPU initialization code and added a comment ]

Fixes: b81fac906a8f ("x86/fpu: Move FPU initialization into arch_cpu_finalize_init()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/lkml/202307192135.203ac24e-oliver.sang@intel.com
Link: https://lore.kernel.org/lkml/20230823065747.92257-1-feng.tang@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0bab497..1afbc48 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -882,6 +882,13 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		goto out_disable;
 	}
 
+	/*
+	 * CPU capabilities initialization runs before FPU init. So
+	 * X86_FEATURE_OSXSAVE is not set. Now that XSAVE is completely
+	 * functional, set the feature bit so depending code works.
+	 */
+	setup_force_cpu_cap(X86_FEATURE_OSXSAVE);
+
 	print_xstate_offset_size();
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
 		fpu_kernel_cfg.max_features,
