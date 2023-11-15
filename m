Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7109C7EC771
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjKOPgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOPgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:36:19 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3820D1A1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:36:15 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1f48ad1700aso483284fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700062574; x=1700667374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0JQketASqzwgW5yh7NMNjvO1ZuRMUYpVqc6VBhHaxI=;
        b=FPVrVlhl8YkzgE7Cwmy0jGTKvIEEvSWrlZF4nEjA2vZGJSxmasgx4As00PUvzEcXQH
         Ex2ZK91C49Ag7+uneUtIyDvJDnlts/0VTj03IWTIQBlG+haV3XDIxgq9F/RU73st2dNh
         uptZigAMx98kL/cu7r7TX9q+GiZsb+Lw1IG+k8D/XRhVQz3N4RZ5/D5zVwlup74FkD/u
         P+6BqJiDUmXfzMYgPUoEYKmq7AQzCAT+p2keJId4dj/8XIRrV+DFBvrqadiA+CrDuJgO
         WvGE25Xr8m90MG+qX0Ig0jn07Go0fi44aUJ9rxp2TmL/FDsuZ7tj3XVAVOeJ2IsxqCKH
         LwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062574; x=1700667374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0JQketASqzwgW5yh7NMNjvO1ZuRMUYpVqc6VBhHaxI=;
        b=GAkCIOUDm1zO3XEPmU/WDcossBYAIXxbFEG9RMiPFnu819o4+pny4CqrUl6KabrMtE
         tehQ4TDGdOrH9oa8oeyeoHO/4+eGRRETS44A7dvtFcG81rPmk7GuP1nToMziG+Lku7rC
         vKH8Zh53hU2OldUsPf/2tiS2lnbIz6dwuvpcMAceJTzPkJRyI1j98GVkrPk5DEgidVDZ
         vykrG4ZEQtWhvXGZwheiCFVpfTlX0oneHIHXHOw0Lec754IQ/R9aWDY5Yjds/x+faXmd
         2NEC8ABzkGmmBgymXmytMgma2wP+tx+BBhpPkQlZmEBFqWbc9upNN+4B3dDI4QhnDZan
         yxLQ==
X-Gm-Message-State: AOJu0Ywaim3ioNmFhxl+Dj+eybAp4rCDtDieaWQZ8r6X65wBOJnVhShn
        IdHrlF5d8hsRfUQ2RJMqd3IZ2A==
X-Google-Smtp-Source: AGHT+IFKhMp18lIOImTKiN9BWfXIKUWBbbJ4lD5DPClon4aeCgIp/6eCe2dME1/AeAMZcWKKNb+38A==
X-Received: by 2002:a05:6870:4301:b0:1e9:b50e:26dc with SMTP id w1-20020a056870430100b001e9b50e26dcmr3138752oah.12.1700062574434;
        Wed, 15 Nov 2023 07:36:14 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o187-20020a4a44c4000000b00581daa5c5fdsm721783ooa.29.2023.11.15.07.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 07:36:13 -0800 (PST)
Date:   Wed, 15 Nov 2023 07:36:10 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>, jannh@google.com,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC RFT v2 1/5] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Message-ID: <ZVTlarljj0nvVJVi@debug.ba.rivosinc.com>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-1-b613f8681155@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231114-clone3-shadow-stack-v2-1-b613f8681155@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 08:05:54PM +0000, Mark Brown wrote:
>Since multiple architectures have support for shadow stacks and we need to
>select support for this feature in several places in the generic code
>provide a generic config option that the architectures can select.
>
>Suggested-by: David Hildenbrand <david@redhat.com>
>Signed-off-by: Mark Brown <broonie@kernel.org>
>---
> arch/x86/Kconfig   | 1 +
> fs/proc/task_mmu.c | 2 +-
> include/linux/mm.h | 2 +-
> mm/Kconfig         | 6 ++++++
> 4 files changed, 9 insertions(+), 2 deletions(-)
>
>diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>index 3762f41bb092..14b7703a9a2b 100644
>--- a/arch/x86/Kconfig
>+++ b/arch/x86/Kconfig
>@@ -1952,6 +1952,7 @@ config X86_USER_SHADOW_STACK
> 	depends on AS_WRUSS
> 	depends on X86_64
> 	select ARCH_USES_HIGH_VMA_FLAGS
>+	select ARCH_HAS_USER_SHADOW_STACK
> 	select X86_CET
> 	help
> 	  Shadow stack protection is a hardware feature that detects function
>diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>index ef2eb12906da..f0a904aeee8e 100644
>--- a/fs/proc/task_mmu.c
>+++ b/fs/proc/task_mmu.c
>@@ -699,7 +699,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
> #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
> 		[ilog2(VM_UFFD_MINOR)]	= "ui",
> #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
>-#ifdef CONFIG_X86_USER_SHADOW_STACK
>+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
> 		[ilog2(VM_SHADOW_STACK)] = "ss",
> #endif
> 	};
>diff --git a/include/linux/mm.h b/include/linux/mm.h
>index 418d26608ece..10462f354614 100644
>--- a/include/linux/mm.h
>+++ b/include/linux/mm.h
>@@ -341,7 +341,7 @@ extern unsigned int kobjsize(const void *objp);
> #endif
> #endif /* CONFIG_ARCH_HAS_PKEYS */
>
>-#ifdef CONFIG_X86_USER_SHADOW_STACK
>+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
> /*
>  * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
>  * support core mm.
>diff --git a/mm/Kconfig b/mm/Kconfig
>index 89971a894b60..b8638da636e1 100644
>--- a/mm/Kconfig
>+++ b/mm/Kconfig
>@@ -1270,6 +1270,12 @@ config LOCK_MM_AND_FIND_VMA
> 	bool
> 	depends on !STACK_GROWSUP
>
>+config ARCH_HAS_USER_SHADOW_STACK
>+	bool
>+	help
>+	  The architecture has hardware support for userspace shadow call
>+          stacks (eg, x86 CET, arm64 GCS, RISC-V Zisslpcfi).

Minor correction for future version.RISC-V choose to split extension [1, 2].
It's now:

Zicfiss - CFI using shadow stack
Zicfilp - CFI using landing pad

So for shadow stack purposes, we can start saying "RISC-V Zicfiss"

[1] - https://lists.riscv.org/g/tech-ss-lp-cfi/message/55
[2] - https://github.com/riscv/riscv-cfi/pull/126

>+
> source "mm/damon/Kconfig"
>
> endmenu
>
>-- 
>2.30.2
>
