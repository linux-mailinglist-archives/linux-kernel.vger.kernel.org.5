Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7EA7DD18C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345149AbjJaQ1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjJaQ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:27:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B33AFDF;
        Tue, 31 Oct 2023 09:27:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 371A92F4;
        Tue, 31 Oct 2023 09:28:25 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.36.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 155193F67D;
        Tue, 31 Oct 2023 09:27:40 -0700 (PDT)
Date:   Tue, 31 Oct 2023 16:27:35 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        LTP List <ltp@lists.linux.it>, Petr Vorel <pvorel@suse.cz>
Subject: Re: qemu-arm64: handle_futex_death - kernel/futex/core.c:661 -
 Unable to handle kernel unknown 43 at virtual address
Message-ID: <ZUEq9_0vJzmnW5ed@FVFF77S0Q05N>
References: <CA+G9fYsCskpn_TNpSwLq9HGUgtT=aZpDzs7SVrqpa9WmyYFaxQ@mail.gmail.com>
 <ZTqGBzOQd4Oi3e9j@FVFF77S0Q05N.cambridge.arm.com>
 <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
 <CA+G9fYuQxUhsrL_=uYSAdotU1_Wx7iu5PxFuG9EzWgBE2nMjcw@mail.gmail.com>
 <CAMj1kXESknQ40SZRMFv6Vv32x-2mSuMyOxoURQwwO1apQ+m=jA@mail.gmail.com>
 <CA+G9fYv3Ph6UDpW1uhoXD5QBE4tAZKpUkVy-Oo9NNrghChL_+A@mail.gmail.com>
 <CAMj1kXE9c3YVbiuwB6cQnWsmUu_kh=vnipJgitYcUh_HWeS=OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE9c3YVbiuwB6cQnWsmUu_kh=vnipJgitYcUh_HWeS=OA@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 09:14:56AM +0100, Ard Biesheuvel wrote:
> From 97dea432bceadfcece84484609374c277afc2c81 Mon Sep 17 00:00:00 2001
> From: Ard Biesheuvel <ardb@kernel.org>
> Date: Sat, 28 Oct 2023 09:40:29 +0200
> Subject: [PATCH v2] Add missing ESR decoding for level -1 translation faults
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

As a heads-up, looking at this some more we'll also need to rework the usage of
of ESR_ELx_FSC_TYPE and ESR_ELx_FSC_LEVEL, since those no longer work correctly
Level -1 xFSC value. ESR_ELx_FSC_TYPE is 0x3c and ESR_ELx_FSC_LEVEL is 0x3, and
work on the basis that the xFSC fault types are encoded as xxxxyy, where the
xxxx is the type and the yy is the level (0 to 3).

That didn't expand naturally to level -1. For example, Level {0,1,2,3}
translation faults get reported as 0b0001xx, where the xx encodes the level,
while Level -1 translation faults get reported as 0b101011.

That ends up affecting:

* All the is_${FOO}_fault() predicat functions, e.g. is_translation_fault(),
  is_el1_permission_fault() and is_spurious_el1_translation_fault().

* Places where we synthesize an xFSC value, e.g. set_thread_esr()

* A bunch of KVM due to the use of kvm_vcpu_trap_get_fault_type()

... and we probably need to remove ESR_ELx_FSC_TYPE and ESR_ELx_FSC_LEVEL
entirely to avoid the possiblity of misuse.

Mark.

> ---
>  arch/arm64/mm/fault.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 2e5d1e238af9..13f192691060 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -780,18 +780,18 @@ static const struct fault_info fault_info[] = {
>  	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"level 1 translation fault"	},
>  	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"level 2 translation fault"	},
>  	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"level 3 translation fault"	},
> -	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 8"			},
> +	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 0 access flag fault"	},
>  	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 1 access flag fault"	},
>  	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 access flag fault"	},
>  	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 access flag fault"	},
> -	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 12"			},
> +	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 0 permission fault"	},
>  	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 1 permission fault"	},
>  	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 permission fault"	},
>  	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 permission fault"	},
>  	{ do_sea,		SIGBUS,  BUS_OBJERR,	"synchronous external abort"	},
>  	{ do_tag_check_fault,	SIGSEGV, SEGV_MTESERR,	"synchronous tag check fault"	},
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 18"			},
> -	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 19"			},
> +	{ do_sea,		SIGKILL, SI_KERNEL,	"level -1 (translation table walk)"	},
>  	{ do_sea,		SIGKILL, SI_KERNEL,	"level 0 (translation table walk)"	},
>  	{ do_sea,		SIGKILL, SI_KERNEL,	"level 1 (translation table walk)"	},
>  	{ do_sea,		SIGKILL, SI_KERNEL,	"level 2 (translation table walk)"	},
> @@ -799,7 +799,7 @@ static const struct fault_info fault_info[] = {
>  	{ do_sea,		SIGBUS,  BUS_OBJERR,	"synchronous parity or ECC error" },	// Reserved when RAS is implemented
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 25"			},
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 26"			},
> -	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 27"			},
> +	{ do_sea,		SIGKILL, SI_KERNEL,	"level -1 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
>  	{ do_sea,		SIGKILL, SI_KERNEL,	"level 0 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
>  	{ do_sea,		SIGKILL, SI_KERNEL,	"level 1 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
>  	{ do_sea,		SIGKILL, SI_KERNEL,	"level 2 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
> @@ -813,9 +813,9 @@ static const struct fault_info fault_info[] = {
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 38"			},
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 39"			},
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 40"			},
> -	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 41"			},
> +	{ do_bad,		SIGKILL, SI_KERNEL,	"level -1 address size fault"	},
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 42"			},
> -	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 43"			},
> +	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"level -1 translation fault"	},
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 44"			},
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 45"			},
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 46"			},
> -- 
> 2.42.0.820.g83a721a137-goog
> 

