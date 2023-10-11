Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396657C5B75
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjJKSkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjJKSkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:40:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CF0B8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:40:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42202C433C7;
        Wed, 11 Oct 2023 18:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697049617;
        bh=xZyKkPaHweujKstNn1GVqnWpFtGjBYlrOF6Krhocg88=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=h83FfLJsePQBW2i6O3H76C4jQYveZALcMJYp5stJOX46IXJIbqztcDyXq1hAmY/24
         8liC8EibD+DFf0mxA74RvIs/mZwPdK+KECja1ghw6qrDmiJxdqjuxzTHwwwcJCJYrJ
         sbrqy2RHm1i8AjNN9rtc7M6HQNuG2g7GPBhsdFFvZqS7XtC8VaKGIM9ltcarlEuMyR
         AVpN7xKsoigCFvVr4Y0Yk4ER8UrU661vGJzDqfHjrGy9a//g0VitYf1nMZfv8HKF2Q
         x+FVfejqjVOasXHwI6MSku1E4iLzUTUfNZ+0Mx3AvbLC19DXw/ASDi+CT7yHuBPBxG
         tCw7knuOUwa4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C9A17CE0367; Wed, 11 Oct 2023 11:40:16 -0700 (PDT)
Date:   Wed, 11 Oct 2023 11:40:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     clm@fb.com, mingo@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Subject: [PATCH RFC x86/nmi] Fix out-of-order nesting checks
Message-ID: <0cbff831-6e3d-431c-9830-ee65ee7787ff@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ->idt_seq and ->recv_jiffies variables added by commit 1a3ea611fc10
("x86/nmi: Accumulate NMI-progress evidence in exc_nmi()") place
the exit-time check of the bottom bit of ->idt_seq after the
this_cpu_dec_return() that re-enables NMI nesting.  This can result in
the following sequence of events on a given CPU in kernels built with
CONFIG_NMI_CHECK_CPU=y:

o       An NMI arrives, and ->idt_seq is incremented to an odd number.
        In addition, nmi_state is set to NMI_EXECUTING==1.

o       The NMI is processed.

o       The this_cpu_dec_return(nmi_state) zeroes nmi_state and returns
        NMI_EXECUTING==1, thus opting out of the "goto nmi_restart".

o       Another NMI arrives and ->idt_seq is incremented to an even
        number, triggering the warning.  But all is just fine, at least
        assuming we don't get so many closely spaced NMIs that the stack
        overflows or some such.

Experience on the fleet indicates that the MTBF of this false positive
is about 70 years.  Or, for those who are not quite that patient, the
MTBF appears to be about one per week per 4,000 systems.

Fix this false-positive warning by moving the "nmi_restart" label before
the initial ->idt_seq increment/check and moving the this_cpu_dec_return()
to follow the final ->idt_seq increment/check.  This way, all nested NMIs
that get past the NMI_NOT_RUNNING check get a clean ->idt_seq slate.
And if they don't get past that check, they will set nmi_state to
NMI_LATCHED, which will cause the this_cpu_dec_return(nmi_state)
to restart.

Reported-by: Chris Mason <clm@fb.com>
Fixes: 1a3ea611fc10 ("x86/nmi: Accumulate NMI-progress evidence in exc_nmi()")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index a0c551846b35..4766b6bed443 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -507,12 +507,13 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 	}
 	this_cpu_write(nmi_state, NMI_EXECUTING);
 	this_cpu_write(nmi_cr2, read_cr2());
+
+nmi_restart:
 	if (IS_ENABLED(CONFIG_NMI_CHECK_CPU)) {
 		WRITE_ONCE(nsp->idt_seq, nsp->idt_seq + 1);
 		WARN_ON_ONCE(!(nsp->idt_seq & 0x1));
 		WRITE_ONCE(nsp->recv_jiffies, jiffies);
 	}
-nmi_restart:
 
 	/*
 	 * Needs to happen before DR7 is accessed, because the hypervisor can
@@ -548,16 +549,16 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 
 	if (unlikely(this_cpu_read(nmi_cr2) != read_cr2()))
 		write_cr2(this_cpu_read(nmi_cr2));
-	if (this_cpu_dec_return(nmi_state))
-		goto nmi_restart;
-
-	if (user_mode(regs))
-		mds_user_clear_cpu_buffers();
 	if (IS_ENABLED(CONFIG_NMI_CHECK_CPU)) {
 		WRITE_ONCE(nsp->idt_seq, nsp->idt_seq + 1);
 		WARN_ON_ONCE(nsp->idt_seq & 0x1);
 		WRITE_ONCE(nsp->recv_jiffies, jiffies);
 	}
+	if (this_cpu_dec_return(nmi_state))
+		goto nmi_restart;
+
+	if (user_mode(regs))
+		mds_user_clear_cpu_buffers();
 }
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
