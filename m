Return-Path: <linux-kernel+bounces-55696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854F684C026
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6191F24065
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E6E1CD2C;
	Tue,  6 Feb 2024 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5LxyzAO"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13F51CD23
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 22:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707259010; cv=none; b=EhbPB0TRkX/rWN34Nx1vHZQRClAYNvVtVJ9TBtP6CPZIfiHzfR/hWmYGUFGMJ0PN5bJRIaS9rt+fisnNuMCUjmJw3SmH5XgBkb9KlbjhNtG47Ohx66GUWLbu9PxHzwOPGDDpGzWLkJYO+tB5HsFqgI7dr2eIAF+sLrmDx/sQiDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707259010; c=relaxed/simple;
	bh=N6KTTGVlioPgR9j+o8pygtYiTQpajG3elp7P2BRhHJ4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hVpOrXczGgyEXAfNTcYjviOe1gWrroMzPn44yEHYm5CoWXZ4z9uxNjynuvSelSMPqoQQsq6+o3TxXjP0OKiAyAbyOYJIAz2vW1mmzdcfhqMH2bQbG5kmtnBPguQ2/aPqhhF65E4wys67gtEbuOpzgPGEpPrpTBlynCFJUEAuBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--acdunlap.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5LxyzAO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--acdunlap.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604833eb9c3so230047b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 14:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707259007; x=1707863807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S9KktXhbpCP9EKhC0dGFOyn7FIX3yfw9fFagtMfvzvU=;
        b=G5LxyzAO+ayBNRBm0069VkDnn7tWoSqNRp4l92H/aVhLoI/DkPKbdM69tW/Fu2QPI2
         rhfsXF/soqYDh07e9TWooiKYsyOcyfHNB251QWlH4v67Pyz69bYy8uiN5haXKbC64uI2
         lx77BlPY/e89QCLrArwxUd5NW515iTIMttNE+PgwHq3tealykgze1QNCGAVwmE6rZZ1A
         u3IlBwSzSii0AZyfU3iTE6bl+jLiDLAiOHoKov/85sqeBXqKaZZUQRMrBB9ReHilwygL
         TtisyvfXDx0Rcb5Sm7kEzgA5EsuTUc3IgVm/zpix9FgEas4u1g1Aoh4bDxlahOFLRB9V
         KGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707259007; x=1707863807;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S9KktXhbpCP9EKhC0dGFOyn7FIX3yfw9fFagtMfvzvU=;
        b=GNHk3DZsFFBMYS9idGF9RwE8WAeSDhbPpFTUzWhwMUu5yMbhUrtgwjYDPLjFSWhhem
         iLmcTpLaSKPmVc9fD397aybQ6V5PinEMEiziyJ1OlAz5RdNnUicl8Khmlbqo6r8UyF/1
         YZnRv9VNRtbU3F+2ZyxdSH37CoaCaAzlnuqGgtdt3HB7z/psR12BcQ71GAS+dkECIitF
         wU6nWaKJ9qN9fM0K2xoUdy7YAOADEe9i2r8PUMzeaGHl11gxXtCVeCOO19HvRORkGKX7
         i5cMBcnC54ZKVC4BbK9OLsv9oSgKNV+lYCOxyU1UEXaG5i0XgzOHnsrrQ6WQACo/szMY
         seaw==
X-Gm-Message-State: AOJu0Yzm3gk8AG7edMUDU35bYy8629XbE9qP4zI/j6WFz5mZiY3p3T4b
	q84PSJsFpon+dmq0DM4/ybkqF+P7QBVfuXw+wGwzmko/driQ6UC0sRVwqKmE9GYXfg+pBMXPD93
	INHD+fEBxbA==
X-Google-Smtp-Source: AGHT+IG7gLSaa9jMCT9d0NEPqxvKadBuDEXuteGmsRb0eeA7aKaH3TsZ4sN4MtvnolZG6mfBKokO9qJycTAqRA==
X-Received: from anticipation.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4517])
 (user=acdunlap job=sendgmr) by 2002:a05:690c:fd0:b0:604:1eea:a39e with SMTP
 id dg16-20020a05690c0fd000b006041eeaa39emr435630ywb.3.1707259007638; Tue, 06
 Feb 2024 14:36:47 -0800 (PST)
Date: Tue,  6 Feb 2024 14:36:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206223620.1833276-1-acdunlap@google.com>
Subject: [PATCH v3] x86/asm: Force native_apic_mem_read to use mov
From: Adam Dunlap <acdunlap@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Arjan van de Ven <arjan@linux.intel.com>, Wei Liu <wei.liu@kernel.org>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Jacob Xu <jacobhxu@google.com>, Alper Gun <alpergun@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Peter Gonda <pgonda@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>
Cc: Adam Dunlap <acdunlap@google.com>
Content-Type: text/plain; charset="UTF-8"

When done from a virtual machine, instructions that touch APIC memory
must be emulated. By convention, MMIO access are typically performed via
io.h helpers such as 'readl()' or 'writeq()' to simplify instruction
emulation/decoding (ex: in KVM hosts and SEV guests) [0].

Currently, native_apic_mem_read does not follow this convention,
allowing the compiler to emit instructions other than the mov generated
by readl(). In particular, when compiled with clang and run as a SEV-ES
or SEV-SNP guest, the compiler would emit a testl instruction which is
not supported by the SEV-ES emulator, causing a boot failure in that
environment. It is likely the same problem would happen in a TDX guest
as that uses the same instruction emulator as SEV-ES.

To make sure all emulators can emulate APIC memory reads via mov, use
the readl function in native_apic_mem_read. It is expected that any
emulator would support mov in any addressing mode it is the most generic
and is what is ususally emitted currently.

The testl instruction is emitted when native_apic_mem_read
is inlined into __xapic_wait_icr_idle. The emulator comes from
insn_decode_mmio in arch/x86/lib/insn-eval.c. It would not be worth it
to extend insn_decode_mmio to support more instructions since, in
theory, the compiler could choose to output nearly any instruction for
such reads which would bloat the emulator beyond reason.

An alterative to this approach would be to use inline assembly instead
of the readl helper, as that is what native_apic_mem_write does. I
consider using readl to be cleaner since it is documented to be a simple
wrapper and inline assembly is less readable. native_apic_mem_write
cannot be trivially updated to use writel since it appears to use custom
asm to workaround for a processor-specific bug.

[0] https://lore.kernel.org/all/20220405232939.73860-12-kirill.shutemov@linux.intel.com/

Signed-off-by: Adam Dunlap <acdunlap@google.com>
Tested-by: Kevin Loughlin <kevinloughlin@google.com>
---

Patch changelog:
V1 -> V2: Replaced asm with readl function which does the same thing
V2 -> V3: Updated commit message to show more motivation and
justification

Link to v2 discussion: https://lore.kernel.org/all/20220908170456.3177635-1-acdunlap@google.com/

 arch/x86/include/asm/apic.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9d159b771dc8..dddd3fc195ef 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -13,6 +13,7 @@
 #include <asm/mpspec.h>
 #include <asm/msr.h>
 #include <asm/hardirq.h>
+#include <asm/io.h>
 
 #define ARCH_APICTIMER_STOPS_ON_C3	1
 
@@ -96,7 +97,7 @@ static inline void native_apic_mem_write(u32 reg, u32 v)
 
 static inline u32 native_apic_mem_read(u32 reg)
 {
-	return *((volatile u32 *)(APIC_BASE + reg));
+	return readl((void __iomem *)(APIC_BASE + reg));
 }
 
 static inline void native_apic_mem_eoi(void)
-- 
2.43.0.594.gd9cf4e227d-goog


