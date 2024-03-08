Return-Path: <linux-kernel+bounces-96431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD95875C08
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F0CB21180
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D498F225CC;
	Fri,  8 Mar 2024 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyXrqq+0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B66210EC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 01:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709861536; cv=none; b=uRdfY0JhVKVbWiuNzsxKFWB6w2dmO05IyXZii5LyhZ+77xHUJ7NAkb3JarFVLBGKNz7CTw3HA7B22+/df75LUMZHt1N42f2eJnuxeZ1bjajoZmo4s9pepHARgP6pHpSgXIupxhojkTp41zmv6Qa/FAiXQ0F5zT5v8iBT++3oTsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709861536; c=relaxed/simple;
	bh=/CDV+2dRV4X6axNFjM+r3jClmsEGO3DjPHzIMX8xf74=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MzscEOlnvrx7nAVq3FEFJ+iXW4NzwA4mKDUinUfVzn3Fa9m4ENUiucRV3dmQY+9zeXXK8cB2C+5tLudAehtWjeBFB52GwZnPZM5PJF31GPXsusjC+gSV7SMNyIv31/V1o+X5SZtA5F72rde41TwrvC+8hCmh1x4qQd9h4Yr7AVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyXrqq+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8D0C433F1;
	Fri,  8 Mar 2024 01:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709861535;
	bh=/CDV+2dRV4X6axNFjM+r3jClmsEGO3DjPHzIMX8xf74=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=HyXrqq+0KpueMRhIj1Qtdj9gAvudVWt9UOp3Jq+R5H6kfeNH38elINv/QnXb6R5No
	 z+1aTdPaEFBtMRGTRX7cTjELGdx/OGx3HVpAAdTzFCqal5UWqTfcfqTU9avWL+BAt8
	 JPvXuxEmDq+wdR0ZUARKksQmfNgN4YkA8CN/TKOJYRN9+4RJjjGoxbixRVIuGhkG5e
	 bW7BleXO9om6mBUjaMnYMi7nu7p9gc9gb5qhG+Av4rabh7C84PSjsOOz4/NAlVpfzy
	 6jJEnk+WsqlH9I/inKC7+XYqMjEKobMrh6SiPXpEV4gKn9Ataok3zsyHSzdGGa2q6f
	 jN16H8g9i9wfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 214DECE0716; Thu,  7 Mar 2024 17:32:15 -0800 (PST)
Date: Thu, 7 Mar 2024 17:32:15 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, leitao@debian.org
Subject: [PATCH x86/nmi] Upgrade NMI backtrace stall checks
Message-ID: <ab4d70c8-c874-42dc-b206-643018922393@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit 344da544f177 ("x86/nmi: Print reasons why backtrace NMIs are
ignored") has shown value, but widespread use has also identified a
few opportunities for improvement.  The systems have (as usual) shown
far more creativity than that commit's author, demonstrating yet again
that failing CPUs can do whatever they want.  In addition, the current
message format is less friendly than one might like to those attempting
to use these messages to identify failing CPUs.

Therefore, separately flag CPUs that, during the full time that the
stack-backtrace request was waiting, were always in an NMI handler,
were never in an NMI handler, or exited one NMI handler.  Also, split
the message identifying the CPU and the time since that CPU's last
NMI-related activity so that a single line identifies the CPU without
any other variable information, greatly reducing the processing overhead
required to identify repeat-offender CPUs.

Co-developed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 6e738ad474dcf..d6c9fe9b20c4a 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -582,7 +582,7 @@ EXPORT_SYMBOL_GPL(asm_exc_nmi_kvm_vmx);
 
 static char *nmi_check_stall_msg[] = {
 /*									*/
-/* +--------- nsp->idt_seq_snap & 0x1: CPU is in NMI handler.		*/
+/* +--------- nmi_seq & 0x1: CPU is currently in NMI handler.		*/
 /* | +------ cpu_is_offline(cpu)					*/
 /* | | +--- nsp->idt_calls_snap != atomic_long_read(&nsp->idt_calls):	*/
 /* | | |	NMI handler has been invoked.				*/
@@ -630,22 +630,26 @@ void nmi_backtrace_stall_check(const struct cpumask *btp)
 		nmi_seq = READ_ONCE(nsp->idt_nmi_seq);
 		if (nsp->idt_nmi_seq_snap + 1 == nmi_seq && (nmi_seq & 0x1)) {
 			msgp = "CPU entered NMI handler function, but has not exited";
-		} else if ((nsp->idt_nmi_seq_snap & 0x1) != (nmi_seq & 0x1)) {
-			msgp = "CPU is handling NMIs";
-		} else {
-			idx = ((nsp->idt_seq_snap & 0x1) << 2) |
+		} else if (nsp->idt_nmi_seq_snap == nmi_seq ||
+			   nsp->idt_nmi_seq_snap + 1 == nmi_seq) {
+			idx = ((nmi_seq & 0x1) << 2) |
 			      (cpu_is_offline(cpu) << 1) |
 			      (nsp->idt_calls_snap != atomic_long_read(&nsp->idt_calls));
 			msgp = nmi_check_stall_msg[idx];
 			if (nsp->idt_ignored_snap != READ_ONCE(nsp->idt_ignored) && (idx & 0x1))
 				modp = ", but OK because ignore_nmis was set";
-			if (nmi_seq & 0x1)
-				msghp = " (CPU currently in NMI handler function)";
-			else if (nsp->idt_nmi_seq_snap + 1 == nmi_seq)
+			if (nsp->idt_nmi_seq_snap + 1 == nmi_seq)
 				msghp = " (CPU exited one NMI handler function)";
+			else if (nmi_seq & 0x1)
+				msghp = " (CPU currently in NMI handler function)";
+			else
+				msghp = " (CPU was never in an NMI handler function)";
+		} else {
+			msgp = "CPU is handling NMIs";
 		}
-		pr_alert("%s: CPU %d: %s%s%s, last activity: %lu jiffies ago.\n",
-			 __func__, cpu, msgp, modp, msghp, j - READ_ONCE(nsp->recv_jiffies));
+		pr_alert("%s: CPU %d: %s%s%s\n", __func__, cpu, msgp, modp, msghp);
+		pr_alert("%s: last activity: %lu jiffies ago.\n",
+			 __func__, j - READ_ONCE(nsp->recv_jiffies));
 	}
 }
 

