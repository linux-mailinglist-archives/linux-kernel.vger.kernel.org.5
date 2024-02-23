Return-Path: <linux-kernel+bounces-77840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A1D860ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B1CB2254A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DDA12B98;
	Fri, 23 Feb 2024 06:37:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7EB12B6A;
	Fri, 23 Feb 2024 06:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670225; cv=none; b=er1F0VmgdDKrP2l4qXIRJ/1R2UL1Rl1UWPan+AsmrnDIh1ayPHCUFW4H1zOAbCTO9DBJu07sPNxnhBtG82unfcPfhHv5lzwNz5XD8YySpLK9+kMzBg//dNtKRFn90WZd/+yYzv9dWO/XSG50z/27hQNRemIdgn4A435SNHXjX1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670225; c=relaxed/simple;
	bh=zS2EaFw8+d9PcNi0yXywHVn87r3cIrAx3HMdbv+Fs6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4sIOlitfpM+Owsp/k63buP0FZI0NfQBw42CcUcaQL31NhIspuJC6poq59HJ+rlItrqXkfWIxosNTg6gc0eukfJR75RIhmJ+nLZBfDcyCXF6NgfHXx0/Y8bkAYwWazefvsvoM9alsDihpfM/vPtP4CiSFeEy9o131GlmlWbnnzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53A9015DB;
	Thu, 22 Feb 2024 22:37:39 -0800 (PST)
Received: from [10.163.46.223] (unknown [10.163.46.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B5223F73F;
	Thu, 22 Feb 2024 22:36:56 -0800 (PST)
Message-ID: <008e381b-52cd-44c5-8a18-ece90db8bba8@arm.com>
Date: Fri, 23 Feb 2024 12:06:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V16 1/8] arm64/sysreg: Add BRBE registers and fields
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 will@kernel.org, catalin.marinas@arm.com, Mark Brown <broonie@kernel.org>,
 James Clark <james.clark@arm.com>, Rob Herring <robh@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Suzuki Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
 <20240125094119.2542332-2-anshuman.khandual@arm.com>
 <ZdYAJvZf4Ut5f5Rf@FVFF77S0Q05N>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZdYAJvZf4Ut5f5Rf@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/24 19:22, Mark Rutland wrote:
> On Thu, Jan 25, 2024 at 03:11:12PM +0530, Anshuman Khandual wrote:
>> This adds BRBE related register definitions and various other related field
>> macros there in. These will be used subsequently in a BRBE driver, which is
>> being added later on.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V16:
>>
>> - Updated BRBINFx_EL1.TYPE = 0b110000 as field IMPDEF_TRAP_EL3
>> - Updated BRBCR_ELx[9] as field FZPSS
>> - Updated BRBINFINJ_EL1 to use sysreg field BRBINFx_EL1
>>
>>  arch/arm64/include/asm/sysreg.h | 109 ++++++++++++++++++++++++++
>>  arch/arm64/tools/sysreg         | 131 ++++++++++++++++++++++++++++++++
>>  2 files changed, 240 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index c3b19b376c86..72544b5c4951 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -272,6 +272,109 @@
>>  
>>  #define SYS_BRBCR_EL2			sys_reg(2, 4, 9, 0, 0)
>>  
>> +#define __SYS_BRBINF(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10) >> 2) + 0))
>> +#define __SYS_BRBSRC(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10) >> 2) + 1))
>> +#define __SYS_BRBTGT(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10) >> 2) + 2))
> 
> We already have definitions for these since v6.5, added in commit:
> 
>   57596c8f991c9aac ("arm64: Add debug registers affected by HDFGxTR_EL2:)
> 
> That commit also added register encoding definitions:
> 
> | #define SYS_BRBINF_EL1(n)              sys_reg(2, 1, 8, (n & 15), (((n & 16) >> 2) | 0))
> | #define SYS_BRBINFINJ_EL1              sys_reg(2, 1, 9, 1, 0)
> | #define SYS_BRBSRC_EL1(n)              sys_reg(2, 1, 8, (n & 15), (((n & 16) >> 2) | 1))
> | #define SYS_BRBSRCINJ_EL1              sys_reg(2, 1, 9, 1, 1)
> | #define SYS_BRBTGT_EL1(n)              sys_reg(2, 1, 8, (n & 15), (((n & 16) >> 2) | 2))
> | #define SYS_BRBTGTINJ_EL1              sys_reg(2, 1, 9, 1, 2)
> | #define SYS_BRBTS_EL1                  sys_reg(2, 1, 9, 0, 2)
> 
> I don't think we need to add new encoding definitions for BRBINF<n>_EL1,
> BRBSRC<n>_EL1, or BRBTGT<n>_EL1; we can just use those existing defintions
> directly. That also means we don't need to add all of the expanded 0..31
> definitions; the driver can use SYS_BRBINF_EL1(n) and friends directly.

Right, that seems feasible. Hence with the following change to the BRBE driver
and arm64 KVM, we can convert using existing SYS_BRBXXX_EL1(n) format.

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 6a06dc2f0c06..739d861b9ef3 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1304,10 +1304,10 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
        return 0;
 }
 
-#define BRB_INF_SRC_TGT_EL1(n)                                 \
-       { SYS_DESC(SYS_BRBINF##n##_EL1), undef_access },        \
-       { SYS_DESC(SYS_BRBSRC##n##_EL1), undef_access },        \
-       { SYS_DESC(SYS_BRBTGT##n##_EL1), undef_access }         \
+#define BRB_INF_SRC_TGT_EL1(n)                         \
+       { SYS_DESC(SYS_BRBINF_EL1(n)), undef_access },  \
+       { SYS_DESC(SYS_BRBSRC_EL1(n)), undef_access },  \
+       { SYS_DESC(SYS_BRBTGT_EL1(n)), undef_access }   \
 
 /* Silly macro to expand the DBG{BCR,BVR,WVR,WCR}n_EL1 registers in one go */
 #define DBG_BCR_BVR_WCR_WVR_EL1(n)                                     \
diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
index 22924023e0f1..dfaf098432ff 100644
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -104,13 +104,13 @@ enum brbe_bank_idx {
 };
 
 #define RETURN_READ_BRBSRCN(n) \
-       read_sysreg_s(SYS_BRBSRC##n##_EL1)
+       read_sysreg_s(SYS_BRBSRC_EL1(n))
 
 #define RETURN_READ_BRBTGTN(n) \
-       read_sysreg_s(SYS_BRBTGT##n##_EL1)
+       read_sysreg_s(SYS_BRBTGT_EL1(n))
 
 #define RETURN_READ_BRBINFN(n) \
-       read_sysreg_s(SYS_BRBINF##n##_EL1)
+       read_sysreg_s(SYS_BRBINF_EL1(n))
 
 #define BRBE_REGN_CASE(n, case_macro) \
        case n: return case_macro(n); break

But while here, will also drop previously added other BRBE registers
from (arch/arm64/include/asm/sysreg.h), as they are now being added
via (arch/arm64/tools/sysreg) instead which is the right place.

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9a919a102cf1..481c7d186dfa 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -195,16 +195,8 @@
 #define SYS_DBGVCR32_EL2               sys_reg(2, 4, 0, 7, 0)
 
 #define SYS_BRBINF_EL1(n)              sys_reg(2, 1, 8, (n & 15), (((n & 16) >> 2) | 0))
-#define SYS_BRBINFINJ_EL1              sys_reg(2, 1, 9, 1, 0)
 #define SYS_BRBSRC_EL1(n)              sys_reg(2, 1, 8, (n & 15), (((n & 16) >> 2) | 1))
-#define SYS_BRBSRCINJ_EL1              sys_reg(2, 1, 9, 1, 1)
 #define SYS_BRBTGT_EL1(n)              sys_reg(2, 1, 8, (n & 15), (((n & 16) >> 2) | 2))
-#define SYS_BRBTGTINJ_EL1              sys_reg(2, 1, 9, 1, 2)
-#define SYS_BRBTS_EL1                  sys_reg(2, 1, 9, 0, 2)
-
-#define SYS_BRBCR_EL1                  sys_reg(2, 1, 9, 0, 0)
-#define SYS_BRBFCR_EL1                 sys_reg(2, 1, 9, 0, 1)
-#define SYS_BRBIDR0_EL1                        sys_reg(2, 1, 9, 2, 0)
 
 #define SYS_TRCITECR_EL1               sys_reg(3, 0, 1, 2, 3)
 #define SYS_TRCACATR(m)                        sys_reg(2, 1, 2, ((m & 7) << 1), (2 | (m >> 3)))
@@ -270,8 +262,6 @@
 /* ETM */
 #define SYS_TRCOSLAR                   sys_reg(2, 1, 1, 0, 4)
 
-#define SYS_BRBCR_EL2                  sys_reg(2, 4, 9, 0, 0)
-
 #define SYS_MIDR_EL1                   sys_reg(3, 0, 0, 0, 0)
 #define SYS_MPIDR_EL1                  sys_reg(3, 0, 0, 0, 5)
 #define SYS_REVIDR_EL1                 sys_reg(3, 0, 0, 0, 6)
@@ -601,7 +591,6 @@
 #define SYS_CNTHV_CVAL_EL2             sys_reg(3, 4, 14, 3, 2)
 
 /* VHE encodings for architectural EL0/1 system registers */
-#define SYS_BRBCR_EL12                 sys_reg(2, 5, 9, 0, 0)
 #define SYS_SCTLR_EL12                 sys_reg(3, 5, 1, 0, 0)
 #define SYS_CPACR_EL12                 sys_reg(3, 5, 1, 0, 2)
 #define SYS_SCTLR2_EL12                        sys_reg(3, 5, 1, 0, 3)


> 
> [...]
> 
>> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
>> index 4c9b67934367..caf851ba5dc0 100644
>> --- a/arch/arm64/tools/sysreg
>> +++ b/arch/arm64/tools/sysreg
>> @@ -1023,6 +1023,137 @@ UnsignedEnum	3:0	MTEPERM
>>  EndEnum
>>  EndSysreg
>>  
>> +
>> +SysregFields BRBINFx_EL1
>> +Res0	63:47
>> +Field	46	CCU
>> +Field	45:32	CC
>> +Res0	31:18
>> +Field	17	LASTFAILED
>> +Field	16	T
>> +Res0	15:14
>> +Enum	13:8		TYPE
>> +	0b000000	UNCOND_DIRECT
>> +	0b000001	INDIRECT
>> +	0b000010	DIRECT_LINK
>> +	0b000011	INDIRECT_LINK
>> +	0b000101	RET
>> +	0b000111	ERET
>> +	0b001000	COND_DIRECT
> 
> Minor nit, but for consistency with DIRECT_LINK, could we please use
> DIRECT_UNCOND and DIRECT_COND?

Sure, will change as above.

> 
>> +	0b100001	DEBUG_HALT
>> +	0b100010	CALL
>> +	0b100011	TRAP
>> +	0b100100	SERROR
>> +	0b100110	INSN_DEBUG
>> +	0b100111	DATA_DEBUG
>> +	0b101010	ALIGN_FAULT
>> +	0b101011	INSN_FAULT
>> +	0b101100	DATA_FAULT
>> +	0b101110	IRQ
>> +	0b101111	FIQ
>> +	0b110000	IMPDEF_TRAP_EL3
>> +	0b111001	DEBUG_EXIT
> 
> That IMPDEF_TRAP_EL3 encoding doesn't seem to exist in the latest ARM ARM (ARM
> DDI 0487J.a), and I see Mark Brown checked against the "Arm A-profile
> Architecture Registers" document (ARM DDI 0601 ID121123, AKA 2023-12).

That's correct.

> 
> Could you please mention that in the commihttps://developer.arm.com/documentation/ddi0601/2023-12/) ?
> That'll make it easier for anyone else to review this, and it'll be good it message, and link to that version
> of the document (n
> case anyone needs to figure out where this came from in future.
> 

Sure, will do that.

>> +EndEnum
>> +Enum	7:6	EL
>> +	0b00	EL0
>> +	0b01	EL1
>> +	0b10	EL2
>> +	0b11	EL3
>> +EndEnum
>> +Field	5	MPRED
>> +Res0	4:2
>> +Enum	1:0	VALID
>> +	0b00	NONE
>> +	0b01	TARGET
>> +	0b10	SOURCE
>> +	0b11	FULL
>> +EndEnum
>> +EndSysregFields
> 
> The other fields here all look good per the ARM ARM and sysreg document.
> 
>> +SysregFields	BRBCR_ELx
>> +Res0	63:24
>> +Field	23 	EXCEPTION
>> +Field	22 	ERTN
>> +Res0	21:10
>> +Field	9	FZPSS
>> +Field	8 	FZP
>> +Res0	7
>> +Enum	6:5	TS
>> +	0b01	VIRTUAL
>> +	0b10	GUEST_PHYSICAL
>> +	0b11	PHYSICAL
>> +EndEnum
>> +Field	4	MPRED
>> +Field	3	CC
>> +Res0	2
>> +Field	1	ExBRE
>> +Field	0	E0BRE
>> +EndSysregFields
> 
> This looks good per the ARM ARM and sysreg document.
> 
>> +Sysreg	BRBCR_EL2	2	4	9	0	0
>> +Fields	BRBCR_ELx
>> +EndSysreg
>> +
>> +Sysreg	BRBCR_EL1	2	1	9	0	0
>> +Fields	BRBCR_ELx
>> +EndSysreg
>> +
>> +Sysreg	BRBCR_EL12	2	5	9	0	0
>> +Fields	BRBCR_ELx
>> +EndSysreg
> 
> These all look good per the ARM ARM and sysreg document.
> 
> Minor nit, but could we please list thse in order:
> 
> 	BRBCR_EL1
> 	BRBCR_EL12
> 	BRBCR_EL2
> 
> ... since that way the names are ordered alphnumerically, which is what we've
> done for other groups (e.g. PIR_EL{1,12,2}), and it's the way the ARM ARM
> happens to be ordered.
> 
>> +Sysreg	BRBFCR_EL1	2	1	9	0	1
>> +Res0	63:30
>> +Enum	29:28	BANK
>> +	0b0	FIRST
>> +	0b1	SECOND
> 
> Nit: since this is a 2-bit field, please pad these as '0b00' and '0b01'.
> 
> Could we please use BANK_0 and BANK_1 rather than FIRST and SECOND?
> 
> That'd also be easier to use behind macros.

Sure, will change as above.

> 
>> +EndEnum
>> +Res0	27:23
>> +Field	22	CONDDIR
>> +Field	21	DIRCALL
>> +Field	20	INDCALL
>> +Field	19	RTN
>> +Field	18	INDIRECT
>> +Field	17	DIRECT
>> +Field	16	EnI
>> +Res0	15:8
>> +Field	7	PAUSED
>> +Field	6	LASTFAILED
>> +Res0	5:0
>> +EndSysreg
> 
> Other than the nit, this looks good per the ARM ARM and sysreg document.

Okay

> 
> [...]
> 
>> +Sysreg	BRBIDR0_EL1	2	1	9	2	0
>> +Res0	63:16
>> +Enum	15:12	CC
>> +	0b101	20_BIT
>> +EndEnum
>> +Enum	11:8	FORMAT
>> +	0b0	0
>> +EndEnum
>> +Enum	7:0		NUMREC
>> +	0b0001000	8
>> +	0b0010000	16
>> +	0b0100000	32
>> +	0b1000000	64
> 
> This is an 8-bit field; please pad these to 8 bits (they all need a leading
> '0').

Sure, will change as above.

> 
>> +EndEnum
>> +EndSysreg
> 
> Aside from the comments above, this looks good to me.
> 
> Mark.

