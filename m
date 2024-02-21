Return-Path: <linux-kernel+bounces-74826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5B685DC65
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1463B26481
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C3B7A715;
	Wed, 21 Feb 2024 13:52:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7437855E5E;
	Wed, 21 Feb 2024 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523569; cv=none; b=g/f0qIlnYuHb1465rjicU1DgEWacNclh1oat7Wro05g7sSJvK7R1yUpLcA3hMmI2MRTTppscQ8/Ijkseb5W45Pa0uBjKSSy1rmcRyIZhdGSxecMQupsaBBSpHahIaSiu0Y5yItucN9eR+LisGYQCukoB6tw7IHhf+mgIIyhBJto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523569; c=relaxed/simple;
	bh=E0Azop+oWngR3crdMwSCqRZfbFxta8aFiAPTZHq5gI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcFAaeH4S/vurq5dim5f1+0yXG1aec8UMtMFUFTmK+Vh05RsIsB2W427gars+AeCbpiQq5i4GwxOY7LoeXmoNg5DCtf/xtGqYVzgo62ElhfN5fdOCRSSnUVOk8DtnXIrNRFIUXeqKSF9qIDPq47p5unx1sfkOnmiifH+G8OPX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DAB2FEC;
	Wed, 21 Feb 2024 05:53:24 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E8F73F762;
	Wed, 21 Feb 2024 05:52:43 -0800 (PST)
Date: Wed, 21 Feb 2024 13:52:38 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com,
	Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
	Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V16 1/8] arm64/sysreg: Add BRBE registers and fields
Message-ID: <ZdYAJvZf4Ut5f5Rf@FVFF77S0Q05N>
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
 <20240125094119.2542332-2-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125094119.2542332-2-anshuman.khandual@arm.com>

On Thu, Jan 25, 2024 at 03:11:12PM +0530, Anshuman Khandual wrote:
> This adds BRBE related register definitions and various other related field
> macros there in. These will be used subsequently in a BRBE driver, which is
> being added later on.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in V16:
> 
> - Updated BRBINFx_EL1.TYPE = 0b110000 as field IMPDEF_TRAP_EL3
> - Updated BRBCR_ELx[9] as field FZPSS
> - Updated BRBINFINJ_EL1 to use sysreg field BRBINFx_EL1
> 
>  arch/arm64/include/asm/sysreg.h | 109 ++++++++++++++++++++++++++
>  arch/arm64/tools/sysreg         | 131 ++++++++++++++++++++++++++++++++
>  2 files changed, 240 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index c3b19b376c86..72544b5c4951 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -272,6 +272,109 @@
>  
>  #define SYS_BRBCR_EL2			sys_reg(2, 4, 9, 0, 0)
>  
> +#define __SYS_BRBINF(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10) >> 2) + 0))
> +#define __SYS_BRBSRC(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10) >> 2) + 1))
> +#define __SYS_BRBTGT(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10) >> 2) + 2))

We already have definitions for these since v6.5, added in commit:

  57596c8f991c9aac ("arm64: Add debug registers affected by HDFGxTR_EL2:)

That commit also added register encoding definitions:

| #define SYS_BRBINF_EL1(n)              sys_reg(2, 1, 8, (n & 15), (((n & 16) >> 2) | 0))
| #define SYS_BRBINFINJ_EL1              sys_reg(2, 1, 9, 1, 0)
| #define SYS_BRBSRC_EL1(n)              sys_reg(2, 1, 8, (n & 15), (((n & 16) >> 2) | 1))
| #define SYS_BRBSRCINJ_EL1              sys_reg(2, 1, 9, 1, 1)
| #define SYS_BRBTGT_EL1(n)              sys_reg(2, 1, 8, (n & 15), (((n & 16) >> 2) | 2))
| #define SYS_BRBTGTINJ_EL1              sys_reg(2, 1, 9, 1, 2)
| #define SYS_BRBTS_EL1                  sys_reg(2, 1, 9, 0, 2)

I don't think we need to add new encoding definitions for BRBINF<n>_EL1,
BRBSRC<n>_EL1, or BRBTGT<n>_EL1; we can just use those existing defintions
directly. That also means we don't need to add all of the expanded 0..31
definitions; the driver can use SYS_BRBINF_EL1(n) and friends directly.

[...]

> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 4c9b67934367..caf851ba5dc0 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1023,6 +1023,137 @@ UnsignedEnum	3:0	MTEPERM
>  EndEnum
>  EndSysreg
>  
> +
> +SysregFields BRBINFx_EL1
> +Res0	63:47
> +Field	46	CCU
> +Field	45:32	CC
> +Res0	31:18
> +Field	17	LASTFAILED
> +Field	16	T
> +Res0	15:14
> +Enum	13:8		TYPE
> +	0b000000	UNCOND_DIRECT
> +	0b000001	INDIRECT
> +	0b000010	DIRECT_LINK
> +	0b000011	INDIRECT_LINK
> +	0b000101	RET
> +	0b000111	ERET
> +	0b001000	COND_DIRECT

Minor nit, but for consistency with DIRECT_LINK, could we please use
DIRECT_UNCOND and DIRECT_COND?

> +	0b100001	DEBUG_HALT
> +	0b100010	CALL
> +	0b100011	TRAP
> +	0b100100	SERROR
> +	0b100110	INSN_DEBUG
> +	0b100111	DATA_DEBUG
> +	0b101010	ALIGN_FAULT
> +	0b101011	INSN_FAULT
> +	0b101100	DATA_FAULT
> +	0b101110	IRQ
> +	0b101111	FIQ
> +	0b110000	IMPDEF_TRAP_EL3
> +	0b111001	DEBUG_EXIT

That IMPDEF_TRAP_EL3 encoding doesn't seem to exist in the latest ARM ARM (ARM
DDI 0487J.a), and I see Mark Brown checked against the "Arm A-profile
Architecture Registers" document (ARM DDI 0601 ID121123, AKA 2023-12).

Could you please mention that in the commit message, and link to that version
of the document (https://developer.arm.com/documentation/ddi0601/2023-12/) ?
That'll make it easier for anyone else to review this, and it'll be good in
case anyone needs to figure out where this came from in future.

> +EndEnum
> +Enum	7:6	EL
> +	0b00	EL0
> +	0b01	EL1
> +	0b10	EL2
> +	0b11	EL3
> +EndEnum
> +Field	5	MPRED
> +Res0	4:2
> +Enum	1:0	VALID
> +	0b00	NONE
> +	0b01	TARGET
> +	0b10	SOURCE
> +	0b11	FULL
> +EndEnum
> +EndSysregFields

The other fields here all look good per the ARM ARM and sysreg document.

> +SysregFields	BRBCR_ELx
> +Res0	63:24
> +Field	23 	EXCEPTION
> +Field	22 	ERTN
> +Res0	21:10
> +Field	9	FZPSS
> +Field	8 	FZP
> +Res0	7
> +Enum	6:5	TS
> +	0b01	VIRTUAL
> +	0b10	GUEST_PHYSICAL
> +	0b11	PHYSICAL
> +EndEnum
> +Field	4	MPRED
> +Field	3	CC
> +Res0	2
> +Field	1	ExBRE
> +Field	0	E0BRE
> +EndSysregFields

This looks good per the ARM ARM and sysreg document.

> +Sysreg	BRBCR_EL2	2	4	9	0	0
> +Fields	BRBCR_ELx
> +EndSysreg
> +
> +Sysreg	BRBCR_EL1	2	1	9	0	0
> +Fields	BRBCR_ELx
> +EndSysreg
> +
> +Sysreg	BRBCR_EL12	2	5	9	0	0
> +Fields	BRBCR_ELx
> +EndSysreg

These all look good per the ARM ARM and sysreg document.

Minor nit, but could we please list thse in order:

	BRBCR_EL1
	BRBCR_EL12
	BRBCR_EL2

.. since that way the names are ordered alphnumerically, which is what we've
done for other groups (e.g. PIR_EL{1,12,2}), and it's the way the ARM ARM
happens to be ordered.

> +Sysreg	BRBFCR_EL1	2	1	9	0	1
> +Res0	63:30
> +Enum	29:28	BANK
> +	0b0	FIRST
> +	0b1	SECOND

Nit: since this is a 2-bit field, please pad these as '0b00' and '0b01'.

Could we please use BANK_0 and BANK_1 rather than FIRST and SECOND?

That'd also be easier to use behind macros.

> +EndEnum
> +Res0	27:23
> +Field	22	CONDDIR
> +Field	21	DIRCALL
> +Field	20	INDCALL
> +Field	19	RTN
> +Field	18	INDIRECT
> +Field	17	DIRECT
> +Field	16	EnI
> +Res0	15:8
> +Field	7	PAUSED
> +Field	6	LASTFAILED
> +Res0	5:0
> +EndSysreg

Other than the nit, this looks good per the ARM ARM and sysreg document.

[...]

> +Sysreg	BRBIDR0_EL1	2	1	9	2	0
> +Res0	63:16
> +Enum	15:12	CC
> +	0b101	20_BIT
> +EndEnum
> +Enum	11:8	FORMAT
> +	0b0	0
> +EndEnum
> +Enum	7:0		NUMREC
> +	0b0001000	8
> +	0b0010000	16
> +	0b0100000	32
> +	0b1000000	64

This is an 8-bit field; please pad these to 8 bits (they all need a leading
'0').

> +EndEnum
> +EndSysreg

Aside from the comments above, this looks good to me.

Mark.

