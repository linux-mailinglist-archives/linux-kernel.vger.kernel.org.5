Return-Path: <linux-kernel+bounces-30275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28E5831C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A6F1F2B445
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443412CCA2;
	Thu, 18 Jan 2024 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Co777sOq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EE92C857
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591542; cv=none; b=YDFP+ljsBil2PwL+nEHoGEVesSm52Q8zI6oQl+S0TleTc+m+jUPs6GKLI6UA/wKu3RVZaP0qPIsnIWWd5EaUqJJOHnsWSVWn3MeI9vWdR9LfKWFLH7vL1/uCShWAhvDNNdgs2RzxZSgZYnEPRCsgQLy6gyNAOBQf/WJK2+lBGN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591542; c=relaxed/simple;
	bh=wxONOmmGxUyWJ69hdYeGotk0425jRRxLbiWGsew7DL0=;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To; b=EkjsDJhKVu4hwIti+Zk/PMYQ1csNwlLyAf80XNyLNVcrZt61e3rThW3beEeiP87kXZIxSrfnFjsr/FQl1uVmBLNPoVRUAKVBNV9Is1irlK1tQ/hegNCU3NISlBmaayrlHE+4QUQe7uXna3YJrmXDJG2e/R914vTftWyX9i9BmDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Co777sOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26C18C43394;
	Thu, 18 Jan 2024 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705591542;
	bh=wxONOmmGxUyWJ69hdYeGotk0425jRRxLbiWGsew7DL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Co777sOqdXYLbF4D/uUekrfeKydKPAYpWDwgdsbWcZrKxetnwr9Skr3xawuDApwE2
	 q9YFhS/xB5rtfva4cnu6WgHDTOS7jZYJxSgP4LJZgxW5t651ioZVqKSy20KVuGDYrC
	 e2XXAn5iNNr2M55Rq9+rKsXf+tPg03YeYRwHEl/QVJ0fiCjUq7Xs5ZNsLfdFEXn3z3
	 nRBy0d5OHU37UlLPJAvNNdLZg1IiW3cajkdTP9mOyhpwdUO7dTRE5W3UPrym2deH7D
	 equfvmap+1N0uOVFqSk1tMhP6ANCLEGJd0qjpFgjSGr+It6Zb0dAbLSwfGr9nQSe6V
	 Ykgc0dU+6z0JA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1EEC47DB3;
	Thu, 18 Jan 2024 15:25:42 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathanl.linux.ibm.com@kernel.org>
Date: Thu, 18 Jan 2024 09:25:14 -0600
Subject: [PATCH RFC 3/5] powerpc/prom: Add CPU info to hardware description
 string later
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240118-update-dump-stack-arch-str-v1-3-5c0f98d017b5@linux.ibm.com>
References:
 <20240118-update-dump-stack-arch-str-v1-0-5c0f98d017b5@linux.ibm.com>
In-Reply-To:
 <20240118-update-dump-stack-arch-str-v1-0-5c0f98d017b5@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Brian King <brking@linux.ibm.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 John Ogness <john.ogness@linutronix.de>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Petr Mladek <pmladek@suse.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Nathan Lynch <nathanl@linux.ibm.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705591541; l=2684;
 i=nathanl@linux.ibm.com; s=20230817; h=from:subject:message-id;
 bh=+lv6CvMHBPkIkCIUDp5N0D4IvkHpdstqrvDIpsi8Zi8=;
 b=PKyW2FF7XVFeI0IyJdhUDwL62a2rUyi5fyEX8m3gJZgmgZ3WcsbUSP/o9+T10oPnzRZVM8VvP
 2hrKH0MUx0OBEC+PmXWCS8VJVFn0XBFnUMsWj6hQ3D8YcH7rBl4TGF2
X-Developer-Key: i=nathanl@linux.ibm.com; a=ed25519;
 pk=jPDF44RvT+9DGFOH3NGoIu1xN9dF+82pjdpnKjXfoJ0=
X-Endpoint-Received:
 by B4 Relay for nathanl@linux.ibm.com/20230817 with auth_id=78
X-Original-From: Nathan Lynch <nathanl@linux.ibm.com>
Reply-To: <nathanl@linux.ibm.com>

From: Nathan Lynch <nathanl@linux.ibm.com>

cur_cpu_spec->cpu_name is appended to ppc_hw_desc before cur_cpu_spec
has taken on its final value. This is illustrated on pseries by
comparing the CPU name as reported at boot ("POWER8E (raw)") to the
contents of /proc/cpuinfo ("POWER8 (architected)"):

  $ dmesg | grep Hardware
  Hardware name: IBM,8408-E8E POWER8E (raw) 0x4b0201 0xf000004 \
    of:IBM,FW860.50 (SV860_146) hv:phyp pSeries

  $ grep -m 1 ^cpu /proc/cpuinfo
  cpu             : POWER8 (architected), altivec supported

Some 44x models would appear to be affected as well; see
identical_pvr_fixup().

This results in incorrect CPU information in stack dumps --
ppc_hw_desc is an input to dump_stack_set_arch_desc().

Delay gathering the CPU name until after all potential calls to
identify_cpu().

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
Fixes: bd649d40e0f2 ("powerpc: Add PVR & CPU name to hardware description")
---
 arch/powerpc/kernel/prom.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 0b5878c3125b..c12b4434336f 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -327,6 +327,7 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 					  void *data)
 {
 	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
+	const __be32 *cpu_version = NULL;
 	const __be32 *prop;
 	const __be32 *intserv;
 	int i, nthreads;
@@ -398,7 +399,7 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 		prop = of_get_flat_dt_prop(node, "cpu-version", NULL);
 		if (prop && (be32_to_cpup(prop) & 0xff000000) == 0x0f000000) {
 			identify_cpu(0, be32_to_cpup(prop));
-			seq_buf_printf(&ppc_hw_desc, "0x%04x ", be32_to_cpup(prop));
+			cpu_version = prop;
 		}
 
 		check_cpu_feature_properties(node);
@@ -409,6 +410,12 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	}
 
 	identical_pvr_fixup(node);
+
+	// We can now add the CPU name & PVR to the hardware description
+	seq_buf_printf(&ppc_hw_desc, "%s 0x%04lx ", cur_cpu_spec->cpu_name, mfspr(SPRN_PVR));
+	if (cpu_version)
+		seq_buf_printf(&ppc_hw_desc, "0x%04x ", be32_to_cpup(cpu_version));
+
 	init_mmu_slb_size(node);
 
 #ifdef CONFIG_PPC64
@@ -846,9 +853,6 @@ void __init early_init_devtree(void *params)
 
 	dt_cpu_ftrs_scan();
 
-	// We can now add the CPU name & PVR to the hardware description
-	seq_buf_printf(&ppc_hw_desc, "%s 0x%04lx ", cur_cpu_spec->cpu_name, mfspr(SPRN_PVR));
-
 	/* Retrieve CPU related informations from the flat tree
 	 * (altivec support, boot CPU ID, ...)
 	 */

-- 
2.43.0


