Return-Path: <linux-kernel+bounces-30325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DBF831D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799F528512C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AE428DDA;
	Thu, 18 Jan 2024 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GFhHCI6L";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GFhHCI6L"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E7B24B40
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593684; cv=none; b=dXCteRLK//Lsg/RJm6bD7fpuGUd4vYx7W4AAB8PYNkhIY34uxKeYLWy9b1eoqEtlbDkPmZdVtDtd+zRmddo0c5TIcRhDAmqQvTV1Ww0nNOXJq7RQ0DEdTTRxS4SAKJ5+ape+1nC2XTNJnyV6TNdR108eeBu8NpY9dhKvvzFVLok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593684; c=relaxed/simple;
	bh=/bFitulnKeMD7nL6DUK9UTmNnjFHo6afAaFJr8rlhh8=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Level:X-Spam-Score:
	 X-Spam-Flag; b=DPUfY1DOGXtmOP2TBEpNS/vxXXtGTecMucPqc1E70FvuDU98VuyvrjWGZ1Ry9ZcuDBb0gnwRehhFPavbmJ3Gd56goXI6qh9noeEQ2xJaU+M8HpOKi3VbyBPX5g3Lnm5RAakezcxU+puw8eHQ37RuE4JJNvoy7gljJmrHIiuWwr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GFhHCI6L; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GFhHCI6L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C1AC1F78C;
	Thu, 18 Jan 2024 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705593681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yqxe6RmDElHAsoN8dM0gFQuxWNqNWQehMUdGnSfMDbQ=;
	b=GFhHCI6LVB4uh/keNp8qXLftsxLtPNTvriewBj9rql/Fqf4J/g31CCV4IEDqDEot0dZTAn
	V6NDmKL7ljVneEWZmAyT1GBdvBJqSiLI60a/hbTVp4ZVn+fXKkC+CR4gAj5MfNVFR113tW
	Z1tqaddjVbY5e+6UgwKA4NRYnXFRW6E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705593681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yqxe6RmDElHAsoN8dM0gFQuxWNqNWQehMUdGnSfMDbQ=;
	b=GFhHCI6LVB4uh/keNp8qXLftsxLtPNTvriewBj9rql/Fqf4J/g31CCV4IEDqDEot0dZTAn
	V6NDmKL7ljVneEWZmAyT1GBdvBJqSiLI60a/hbTVp4ZVn+fXKkC+CR4gAj5MfNVFR113tW
	Z1tqaddjVbY5e+6UgwKA4NRYnXFRW6E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2221013874;
	Thu, 18 Jan 2024 16:01:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g5ZJBVFLqWV9OgAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Thu, 18 Jan 2024 16:01:21 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	dave.hansen@linux.intel.com,
	linux-coco@lists.linux.dev,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [RFC PATCH] x86/virt/tdx: Disable KEXEC in the presence of TDX
Date: Thu, 18 Jan 2024 18:01:18 +0200
Message-Id: <20240118160118.1899299-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

TDX doesn't currently support kexec so disable the latter when TDX
is detected at boot time. If kexec must absolutely be supported then
TDX can be disabled from the bios.

Making this decision at run time rather than as a compile time option
allows distribution kernels to have both enabled and delegate to the
user whether they want to use TDX/Kexec.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---

Sending as RFC as I don't know the reason why initially it was decided to
enforce the incompaibility between kexec/tdx at build time rather than runtime.

 arch/x86/Kconfig            | 1 -
 arch/x86/virt/vmx/tdx/tdx.c | 6 ++++++
 include/linux/kexec.h       | 1 +
 kernel/kexec_core.c         | 5 +++++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 92c03cb99b3e..6c2b620b40d8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1973,7 +1973,6 @@ config INTEL_TDX_HOST
 	depends on X86_X2APIC
 	select ARCH_KEEP_MEMBLOCK
 	depends on CONTIG_ALLOC
-	depends on !KEXEC_CORE
 	depends on X86_MCE
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4d6826a76f78..270090bd7b5e 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -20,6 +20,7 @@
 #include <linux/memblock.h>
 #include <linux/memory.h>
 #include <linux/minmax.h>
+#include <linux/kexec.h>
 #include <linux/sizes.h>
 #include <linux/pfn.h>
 #include <linux/align.h>
@@ -1473,6 +1474,11 @@ void __init tdx_init(void)
 		return;
 	}

+#ifdef CONFIG_KEXEC_CORE
+	kexec_disable();
+	pr_info("Disable Kexec. Turn off TDX in the BIOS to use KEXEC.\n");
+#endif
+
 #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
 	pr_info("Disable ACPI S3. Turn off TDX in the BIOS to use ACPI S3.\n");
 	acpi_suspend_lowlevel = NULL;
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 8227455192b7..c434c8569242 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -500,6 +500,7 @@ static inline int crash_hotplug_memory_support(void) { return 0; }
 static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
 #endif

+extern void kexec_disable(void);
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index be5642a4ec49..8d3a2a04ff4d 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -927,6 +927,11 @@ struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
 static int kexec_load_disabled;

+void kexec_disable(void)
+{
+	kexec_load_disabled = 1;
+}
+
 #ifdef CONFIG_SYSCTL
 static int kexec_limit_handler(struct ctl_table *table, int write,
 			       void *buffer, size_t *lenp, loff_t *ppos)
--
2.34.1


