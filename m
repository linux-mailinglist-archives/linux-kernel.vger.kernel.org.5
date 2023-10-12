Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E4F7C65C3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377412AbjJLGl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343567AbjJLGl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:41:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6FEC4;
        Wed, 11 Oct 2023 23:41:24 -0700 (PDT)
Date:   Thu, 12 Oct 2023 06:41:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697092883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QiQ+QJLnKZUB1+VUZ4jufENKlSDw5YT/ILtFyVL9bPo=;
        b=m7Wx1knVv4OyMdB2KolinwgohWkPE3vUJfBZeiNR5D0sJuNeN51Z5TncWZdMIEV8GJUN7T
        YNRJIpz0g8P0wLfJG+vvSKW3VTqV5KU8Eva+ZGtk9Y7rl8hyyh7USkyWefBCUXwR21DeDT
        DOnzrrqCNeMQb1o8tCsQbMAYYUMMHK1Cg4k/Houk61VmL3Rufts9nxSVrDUNGTQvy/Jr18
        jr8AXap35UkEbCInVXzYpwJJktp0nu9p9kzzoFbCPfCWcWPEsxkiVtsvGfdSmq7vL0AXpn
        bpR2g5AWDWnf4p9u3IW7KppSkdSIAwv+/TBb2sWwQGjKAR390vKTRcwDBHRpvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697092883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QiQ+QJLnKZUB1+VUZ4jufENKlSDw5YT/ILtFyVL9bPo=;
        b=w0WBBOHHKC+g3w3xQ2E9eUtZ9ZUmfDKD4uug0YFVramsZXBsSOdXE8qaYqqSkZuwb2RRC4
        kynG72+UaH27idDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/nmi: Fix out-of-order NMI nesting checks & false
 positive warning
Cc:     Chris Mason <clm@fb.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <0cbff831-6e3d-431c-9830-ee65ee7787ff@paulmck-laptop>
References: <0cbff831-6e3d-431c-9830-ee65ee7787ff@paulmck-laptop>
MIME-Version: 1.0
Message-ID: <169709288266.3135.14961359666670260279.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     f44075ecafb726830e63d33fbca29413149eeeb8
Gitweb:        https://git.kernel.org/tip/f44075ecafb726830e63d33fbca29413149eeeb8
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 11 Oct 2023 11:40:16 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 12 Oct 2023 08:35:15 +02:00

x86/nmi: Fix out-of-order NMI nesting checks & false positive warning

The ->idt_seq and ->recv_jiffies variables added by:

  1a3ea611fc10 ("x86/nmi: Accumulate NMI-progress evidence in exc_nmi()")

... place the exit-time check of the bottom bit of ->idt_seq after the
this_cpu_dec_return() that re-enables NMI nesting.  This can result in
the following sequence of events on a given CPU in kernels built with
CONFIG_NMI_CHECK_CPU=y:

  o   An NMI arrives, and ->idt_seq is incremented to an odd number.
      In addition, nmi_state is set to NMI_EXECUTING==1.

  o   The NMI is processed.

  o   The this_cpu_dec_return(nmi_state) zeroes nmi_state and returns
      NMI_EXECUTING==1, thus opting out of the "goto nmi_restart".

  o   Another NMI arrives and ->idt_seq is incremented to an even
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

Fixes: 1a3ea611fc10 ("x86/nmi: Accumulate NMI-progress evidence in exc_nmi()")
Reported-by: Chris Mason <clm@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/0cbff831-6e3d-431c-9830-ee65ee7787ff@paulmck-laptop
---
 arch/x86/kernel/nmi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index a0c5518..4766b6b 100644
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
@@ -548,16 +549,16 @@ nmi_restart:
 
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
