Return-Path: <linux-kernel+bounces-152052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AEE8AB806
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DDB1C209D0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B1E33F2;
	Sat, 20 Apr 2024 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pUufDVQF"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456877FD
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 00:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713571565; cv=none; b=c/FE9GFD55GeFDsR4wO/Uy4Ngq0nrE83xXPQbmUp1I9SRsHKmCzt4gtRfhYSEFqS2g+wLYIl4kcFoh2oeehTf/ndrepme1/PvxktKxVUD+B4ve7cTnoJGjiwAdLevIICnOjivOLYTopN3qj6iAvnx+h1x0LFMY/eQGtViqpnyyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713571565; c=relaxed/simple;
	bh=AbrNMuShjoqU+z+XVkR+06IatKvC9MN5XA8xptC1D9E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VCDC12BCTpU8NpFOEamMGGLDTC6fPmPHo7/3gw1i+MQEcS6HoQUKC0urVBpb8MLQDdhaNtpcwxryUrjNpcXTwr2bCry2FRCspdOx4AzgQbJe9zD+QJou7r50hdZGKMcP66y2TaFz242ejPdWE/HFCjBYf69MGjPRycWnZsfaMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pUufDVQF; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cfc2041cdfso2417148a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713571563; x=1714176363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rPXhQd6B8lAQb9khLVf8qww1T68yj7WoIM319n91vX8=;
        b=pUufDVQF/Tj0B2Z2ICzAhyNuScWiNOko4kH6Wv3iEZZKyShU7RnVqefrx78WVG4EJc
         BgEqMrOLxXwgKqaG5QWQuyM7h3x7LTvLNOA9/viKScBTwTL9c/0QLJXJTlYihPGu++GU
         9IBNl1i965CIdNec2zfZ+RyhKnqyhpE2mvzZypBvt3mdQMQejRuRy3B5AnlOnmmkcNdC
         F1U8L8B9knYqC12XgleuyBwwk7KfKQf0F6kj4FJIM+r73/t2wXorH9N0TeEOxWR4/PRi
         8nEdh6RMjDtstc7LRSVc66MxLA52f11FwamFSMoSTaP9pR10yIsAuJP4BR58bCoDLArB
         qbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713571563; x=1714176363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPXhQd6B8lAQb9khLVf8qww1T68yj7WoIM319n91vX8=;
        b=pvrFS4Upic6Z8owi8p2E2VkbF8DFumeIHC1EMUkwxIAMZs6IKMHXmSmHupkgGflBN4
         eZpMFGYPB007t+lcgOBRhHf0dwIL2v3WNBYx2RVpQ3JobQy0sH1U3jok22UsC2eKdI68
         +fwU5PybUk7yOq1Hd5mJLaZUBWLA9rCxLYJOLxJXx1q7YWB3C5lviF2HaLqYekEsUR3S
         ritVFPixB3ixI0EzaQ3Jd1wvRN5KMsW/IXGfNSjDb95oOYm5tSotdmSI40SvRa7qE2yB
         BuVZdEa2AFcmZHstojkhDJjxYpxDe+aKyVNzempZQdn5rcUgavtggAyZx0so22JsePIf
         BSYQ==
X-Gm-Message-State: AOJu0Yze7narFhKrM9G7X4HzrUua2hT1OZeo7aBWFLyrsIlGoRgr/Md+
	MjgouEcs6j0ZDvhgaYOT3ROO+rwJlGW1HOz62ARUMW6xWovyzQCRcXeTHFz1Qji75aZV8E/O21O
	cRg==
X-Google-Smtp-Source: AGHT+IEmMmSUVgXU1tSXZ/MTXIV0RNptco5i3YMLAwQBt8RryWMQ+OH62EnrBkUaDrNS8iqLBb2QODocG/I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:7782:0:b0:5d8:be91:930d with SMTP id
 s124-20020a637782000000b005d8be91930dmr10125pgc.0.1713571563532; Fri, 19 Apr
 2024 17:06:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Apr 2024 17:05:54 -0700
In-Reply-To: <20240420000556.2645001-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240420000556.2645001-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240420000556.2645001-2-seanjc@google.com>
Subject: [PATCH v2 1/2] cpu: Re-enable CPU mitigations by default for !X86 architectures
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Will Deacon <will@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename x86's to CPU_MITIGATIONS, define it in generic code, and force it
on for all architectures exception x86.  A recent commit to turn
mitigations off by default if SPECULATION_MITIGATIONS=n kinda sorta missed
that "cpu_mitigations" is completely generic, whereas
SPECULATION_MITIGATIONS is x86 specific.

Rename x86's SPECULATIVE_MITIGATIONS instead of keeping both and have it
select CPU_MITIGATIONS, as having two configs for the same thing is
unnecessary and confusing.  This will also allow x86 to use the knob to
manage mitigations that aren't strictly related to speculative execution.

Use another Kconfig to communicate to common code that CPU_MITIGATIONS is
already defined instead of having x86's menu depend on the common
CPU_MITIGATIONS.  This allows keeping a single point of contact for all of
x86's mitigations, and it's not clear that other architectures *want* to
allow disabling mitigations at compile-time.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lkml.kernel.org/r/20240413115324.53303a68%40canb.auug.org.au
Fixes: f337a6a21e2f ("x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n")
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/Kconfig     |  8 ++++++++
 arch/x86/Kconfig | 11 ++++++-----
 kernel/cpu.c     |  4 ++--
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 65afb1de48b3..30f7930275d8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -9,6 +9,14 @@
 #
 source "arch/$(SRCARCH)/Kconfig"
 
+config ARCH_CONFIGURES_CPU_MITIGATIONS
+	bool
+
+if !ARCH_CONFIGURES_CPU_MITIGATIONS
+config CPU_MITIGATIONS
+	def_bool y
+endif
+
 menu "General architecture-dependent options"
 
 config ARCH_HAS_SUBPAGE_FAULTS
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4474bf32d0a4..619a04d5c131 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -62,6 +62,7 @@ config X86
 	select ACPI_HOTPLUG_CPU			if ACPI_PROCESSOR && HOTPLUG_CPU
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
+	select ARCH_CONFIGURES_CPU_MITIGATIONS
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if X86_64 && HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG if X86_64
@@ -2488,17 +2489,17 @@ config PREFIX_SYMBOLS
 	def_bool y
 	depends on CALL_PADDING && !CFI_CLANG
 
-menuconfig SPECULATION_MITIGATIONS
-	bool "Mitigations for speculative execution vulnerabilities"
+menuconfig CPU_MITIGATIONS
+	bool "Mitigations for CPU vulnerabilities"
 	default y
 	help
-	  Say Y here to enable options which enable mitigations for
-	  speculative execution hardware vulnerabilities.
+	  Say Y here to enable options which enable mitigations for hardware
+	  vulnerabilities (usually related to speculative execution).
 
 	  If you say N, all mitigations will be disabled. You really
 	  should know what you are doing to say so.
 
-if SPECULATION_MITIGATIONS
+if CPU_MITIGATIONS
 
 config MITIGATION_PAGE_TABLE_ISOLATION
 	bool "Remove the kernel mapping in user mode"
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 07ad53b7f119..bb0ff275fb46 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3207,8 +3207,8 @@ enum cpu_mitigations {
 };
 
 static enum cpu_mitigations cpu_mitigations __ro_after_init =
-	IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
-						     CPU_MITIGATIONS_OFF;
+	IS_ENABLED(CONFIG_CPU_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
+					     CPU_MITIGATIONS_OFF;
 
 static int __init mitigations_parse_cmdline(char *arg)
 {
-- 
2.44.0.769.g3c40516874-goog


