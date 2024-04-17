Return-Path: <linux-kernel+bounces-147791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C578A79B7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACAC1F21E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E805184F;
	Wed, 17 Apr 2024 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RNyrZRwk"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AE7364
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312914; cv=none; b=gf5ma6O9dRXaT809uWRcKzsj1XIDxBoWA7sidXANZoCsK1d8lgNWX2yvqPg+0lERtQ4ZL/RQV6e+lLw8B4YFzvTnB0ZsEOmq6Bl+45aESWiVNVQgJ904gBmuCATvT3yGtnbTYl9XSdC58SjInHu/Mp+E0kiNUjbqG1jjSCw/vvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312914; c=relaxed/simple;
	bh=AacvfWgUXUIENBNEnwfPiB1vP9BLM+sOUlSbsxnKkKE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IAujqP4xPm9p7hww4SYCNkkoYCPqEh8rRHmpfmufBtRPuLsg0cEGbMI+N6A/QT+M4tA+pafu29Ld81LEaIQQnc2OTBxQDweI+buzSpEunQlHruDEwyOvvhfJTqzR/TV1k6BSEwoCzEDkRG3goO8z3DPmSBKomq/9eDFuD3e2lgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RNyrZRwk; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so7219211276.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713312912; x=1713917712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=m9VfputrxLnVngbwQFKyRzwQMY5dHXwAcsvKFnPKLMI=;
        b=RNyrZRwkUL+bfRFbIaog45oNyBmvXY3r9tAP82PtSnGv1o7cu6uOm1rnyRxlYgCvEw
         r8mxybDZ+LAEnL2cMMy36DsjgfVCDgZQhihVTamO764/oj3XTHWddAkDNQ4w64h63e2n
         4CHjF5NeA3P1t+vfUNY8gTBBlxUxf9MBmgv6n1rYzrfDF74tEw9V/Mz5fIuPLx8Qeyop
         J4oWITpf1Sr3a2vWqgjvUgu0HVURLPje0W8dQf9I49N0pPExSSPItdF7H2XgmBvjzyg7
         5OCahzws77hAgo5IQMOo6Xxdcnm8S+Xaz4XZl9G51ATHhZuuGf4cc6pm8eDMvu+MrvZb
         T6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713312912; x=1713917712;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9VfputrxLnVngbwQFKyRzwQMY5dHXwAcsvKFnPKLMI=;
        b=EhlSVdL5tl4GSkpdDfFiHNA8JXIcKnvwNA7N6Nywa9SOoXHr3zZfgkOg3ShI4GSq7g
         fC6rDMUZQ8P8ilxAW8IGhi9hPHSoQ+N751L0BsCP2tRy2NBydaM/fpzboFdsR7rARyj5
         G+1MD3dN6eMBdQ88uzLVIOdFxFstLRfuByV0XAscoLXk/cSDHXjeAoumxXUkATA8vxjU
         VHQJPxlQDr80I/Cl0aXy8LQLBF+Oe6Iq6BVLMoF0em/NhlYzbF17/eP27OGOmv3DeNAR
         9WoVO9JEckFVPwBk6L2L0o0AuzuuTzyO2zxyvrWx4t5CTrKR72Rl2NkYj3DLHzGY8Kgl
         asGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPQAEtgSbGT0Ntlzjz85QbT63AgI+92v4LuiSxuhOzfjlX+20TLuI85MSB99KVwfvqT5kv0znP7yIOogSCWRZH7SjAYr4Ly5T6go02
X-Gm-Message-State: AOJu0YysTBoKgxVC2rw3kvpZD4HMBW9m9d7mvpopn9TQOnMs+wiP+mQM
	dymZOD0PH6rqSmBTpE09Q5t2uEvsp/8QDAcO+PisRs+AnjTicpLnUh/Zl4HjmrB/1IMsLpxonf9
	6mA==
X-Google-Smtp-Source: AGHT+IEsD1OB0gpWHFEKLasEXYUSKqQne4naFc8D53c4PKnQiTM/HxL97vSCDZ0CgKo+9+oF+XItMkUdtiU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:c0c:b0:de1:d49:7ff6 with SMTP id
 fs12-20020a0569020c0c00b00de10d497ff6mr1198221ybb.7.1713312912168; Tue, 16
 Apr 2024 17:15:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 16 Apr 2024 17:15:06 -0700
In-Reply-To: <20240417001507.2264512-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240417001507.2264512-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240417001507.2264512-2-seanjc@google.com>
Subject: [PATCH 1/2] cpu: Re-enable CPU mitigations by default for !X86 architectures
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Michael Ellerman <mpe@ellerman.id.au>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a generic Kconfig, CPU_MITIGATIONS, to control whether or not CPU
mitigations are enabled by default, and force it on for all architectures
except x86.  A recent commit to turn mitigations off by default if
SPECULATION_MITIGATIONS=n kinda sorta missed that "cpu_mitigations" is
completely generic, where as SPECULATION_MITIGATIONS is x86 specific.

Alternatively, SPECULATION_MITIGATIONS could simply be defined in common
code, but that creates weirdness for x86 because SPECULATION_MITIGATIONS
ends up being defined twice, and the default behavior would likely depend
on the arbitrary include order (if the two definitions diverged).

Ideally, CPU_MITIGATIONS would be unconditionally on by default for all
architectures, and manually turned off, but there is no way to unselect a
Kconfig.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lkml.kernel.org/r/20240413115324.53303a68%40canb.auug.org.au
Fixes: f337a6a21e2f ("x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/Kconfig     | 1 +
 drivers/base/Kconfig | 3 +++
 kernel/cpu.c         | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4474bf32d0a4..a0eca6313276 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2490,6 +2490,7 @@ config PREFIX_SYMBOLS
 
 menuconfig SPECULATION_MITIGATIONS
 	bool "Mitigations for speculative execution vulnerabilities"
+	select CPU_MITIGATIONS
 	default y
 	help
 	  Say Y here to enable options which enable mitigations for
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 2b8fd6bb7da0..dab19f15fa57 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -191,6 +191,9 @@ config GENERIC_CPU_AUTOPROBE
 config GENERIC_CPU_VULNERABILITIES
 	bool
 
+config CPU_MITIGATIONS
+	def_bool !X86
+
 config SOC_BUS
 	bool
 	select GLOB
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
2.44.0.683.g7961c838ac-goog


