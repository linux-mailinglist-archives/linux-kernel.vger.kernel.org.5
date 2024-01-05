Return-Path: <linux-kernel+bounces-17704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EF1825160
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E498F28A1DC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB8324B59;
	Fri,  5 Jan 2024 09:59:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8303C24B33
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35980FEC;
	Fri,  5 Jan 2024 02:00:38 -0800 (PST)
Received: from [192.168.32.22] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FEAC3F64C;
	Fri,  5 Jan 2024 01:59:45 -0800 (PST)
Message-ID: <ec84c396-41a5-29fe-8635-28011847d8ac@arm.com>
Date: Fri, 5 Jan 2024 09:59:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 3/7] arm64/sysreg/tools: Move TRFCR definitions to
 sysreg
Content-Language: en-US
To: Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 broonie@kernel.org, maz@kernel.org, acme@kernel.org
Cc: Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Rob Herring
 <robh@kernel.org>, Miguel Luis <miguel.luis@oracle.com>,
 Jintack Lim <jintack.lim@linaro.org>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Quentin Perret <qperret@google.com>,
 Arnd Bergmann <arnd@arndb.de>, Vincent Donnefort <vdonnefort@google.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Fuad Tabba <tabba@google.com>,
 Joey Gouly <joey.gouly@arm.com>, Jing Zhang <jingzhangos@google.com>,
 linux-kernel@vger.kernel.org
References: <20240104162714.1062610-1-james.clark@arm.com>
 <20240104162714.1062610-4-james.clark@arm.com>
 <5b6ee045-b726-44ec-924e-4797d3ff4c13@arm.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <5b6ee045-b726-44ec-924e-4797d3ff4c13@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/01/2024 09:18, Suzuki K Poulose wrote:
> Hi James
> 
> On 04/01/2024 16:27, James Clark wrote:
>> Add separate definitions for ELx and EL2 as TRFCR_EL1 doesn't have CX.
>> This also mirrors the previous definition so no code change is required.
>>
>> Also add TRFCR_EL12 which will start to be used in a later commit.
>>
>> Unfortunately, to avoid breaking the Perf build with duplicate
>> definition errors, the tools copy of the sysreg.h header needs to be
>> updated at the same time rather than the usual second commit. This is
>> because the generated version of sysreg
>> (arch/arm64/include/generated/asm/sysreg-defs.h), is currently shared
>> between the kernel and tools and not copied.
>>
>> Because the new version of sysreg.h includes kasan-tags.h, that file
>> also now needs to be copied into tools.
> 
> Is it possible to split the patch such that, tools/sysreg is updated to
> match the existing kernel headers first and then add the TRFCR changes ?
> This looks like a lot of unrelated changes.
> 
> Suzuki
> 
> 

Yes that's not a bad idea I can split it into two.

>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   arch/arm64/include/asm/sysreg.h       |  12 -
>>   arch/arm64/tools/sysreg               |  41 +++
>>   tools/arch/arm64/include/asm/sysreg.h | 345 ++++++++++++++++++++++++--
>>   tools/include/linux/kasan-tags.h      |  15 ++
>>   4 files changed, 387 insertions(+), 26 deletions(-)
>>   create mode 100644 tools/include/linux/kasan-tags.h
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h
>> b/arch/arm64/include/asm/sysreg.h
>> index 5e65f51c10d2..92dfb41af018 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -280,8 +280,6 @@
>>   #define SYS_RGSR_EL1            sys_reg(3, 0, 1, 0, 5)
>>   #define SYS_GCR_EL1            sys_reg(3, 0, 1, 0, 6)
>>   -#define SYS_TRFCR_EL1            sys_reg(3, 0, 1, 2, 1)
>> -
>>   #define SYS_TCR_EL1            sys_reg(3, 0, 2, 0, 2)
>>     #define SYS_APIAKEYLO_EL1        sys_reg(3, 0, 2, 1, 0)
>> @@ -499,7 +497,6 @@
>>   #define SYS_VTTBR_EL2            sys_reg(3, 4, 2, 1, 0)
>>   #define SYS_VTCR_EL2            sys_reg(3, 4, 2, 1, 2)
>>   -#define SYS_TRFCR_EL2            sys_reg(3, 4, 1, 2, 1)
>>   #define SYS_VNCR_EL2            sys_reg(3, 4, 2, 2, 0)
>>   #define SYS_HAFGRTR_EL2            sys_reg(3, 4, 3, 1, 6)
>>   #define SYS_SPSR_EL2            sys_reg(3, 4, 4, 0, 0)
>> @@ -949,15 +946,6 @@
>>   /* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
>>   #define SYS_MPIDR_SAFE_VAL    (BIT(31))
>>   -#define TRFCR_ELx_TS_SHIFT        5
>> -#define TRFCR_ELx_TS_MASK        ((0x3UL) << TRFCR_ELx_TS_SHIFT)
>> -#define TRFCR_ELx_TS_VIRTUAL        ((0x1UL) << TRFCR_ELx_TS_SHIFT)
>> -#define TRFCR_ELx_TS_GUEST_PHYSICAL    ((0x2UL) << TRFCR_ELx_TS_SHIFT)
>> -#define TRFCR_ELx_TS_PHYSICAL        ((0x3UL) << TRFCR_ELx_TS_SHIFT)
>> -#define TRFCR_EL2_CX            BIT(3)
>> -#define TRFCR_ELx_ExTRE            BIT(1)
>> -#define TRFCR_ELx_E0TRE            BIT(0)
>> -
>>   /* GIC Hypervisor interface registers */
>>   /* ICH_MISR_EL2 bit definitions */
>>   #define ICH_MISR_EOI        (1 << 0)
>> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
>> index 96cbeeab4eec..8fe23eac910f 100644
>> --- a/arch/arm64/tools/sysreg
>> +++ b/arch/arm64/tools/sysreg
>> @@ -2634,3 +2634,44 @@ Field    5    F
>>   Field    4    P
>>   Field    3:0    Align
>>   EndSysreg
>> +
>> +SysregFields TRFCR_EL2
>> +Res0    63:7
>> +UnsignedEnum    6:5    TS
>> +    0b0000    USE_TRFCR_EL1_TS
>> +    0b0001    VIRTUAL
>> +    0b0010    GUEST_PHYSICAL
>> +    0b0011    PHYSICAL
>> +EndEnum
>> +Res0    4
>> +Field    3    CX
>> +Res0    2
>> +Field    1    E2TRE
>> +Field    0    E0HTRE
>> +EndSysregFields
>> +
>> +# TRFCR_EL1 doesn't have the CX bit so redefine it without CX instead of
>> +# using a shared definition between TRFCR_EL2 and TRFCR_EL1
>> +SysregFields TRFCR_ELx
>> +Res0    63:7
>> +UnsignedEnum    6:5    TS
>> +    0b0001    VIRTUAL
>> +    0b0010    GUEST_PHYSICAL
>> +    0b0011    PHYSICAL
>> +EndEnum
>> +Res0    4:2
>> +Field    1    ExTRE
>> +Field    0    E0TRE
>> +EndSysregFields
>> +
>> +Sysreg    TRFCR_EL1    3    0    1    2    1
>> +Fields    TRFCR_ELx
>> +EndSysreg
>> +
>> +Sysreg    TRFCR_EL2    3    4    1    2    1
>> +Fields    TRFCR_EL2
>> +EndSysreg
>> +
>> +Sysreg    TRFCR_EL12    3    5    1    2    1
>> +Fields    TRFCR_ELx
>> +EndSysreg
>> diff --git a/tools/arch/arm64/include/asm/sysreg.h
>> b/tools/arch/arm64/include/asm/sysreg.h
>> index ccc13e991376..92dfb41af018 100644
>> --- a/tools/arch/arm64/include/asm/sysreg.h
>> +++ b/tools/arch/arm64/include/asm/sysreg.h
>> @@ -11,6 +11,7 @@
>>     #include <linux/bits.h>
>>   #include <linux/stringify.h>
>> +#include <linux/kasan-tags.h>
>>     #include <asm/gpr-num.h>
>>   @@ -123,6 +124,37 @@
>>   #define SYS_DC_CIGSW            sys_insn(1, 0, 7, 14, 4)
>>   #define SYS_DC_CIGDSW            sys_insn(1, 0, 7, 14, 6)
>>   +#define SYS_IC_IALLUIS            sys_insn(1, 0, 7, 1, 0)
>> +#define SYS_IC_IALLU            sys_insn(1, 0, 7, 5, 0)
>> +#define SYS_IC_IVAU            sys_insn(1, 3, 7, 5, 1)
>> +
>> +#define SYS_DC_IVAC            sys_insn(1, 0, 7, 6, 1)
>> +#define SYS_DC_IGVAC            sys_insn(1, 0, 7, 6, 3)
>> +#define SYS_DC_IGDVAC            sys_insn(1, 0, 7, 6, 5)
>> +
>> +#define SYS_DC_CVAC            sys_insn(1, 3, 7, 10, 1)
>> +#define SYS_DC_CGVAC            sys_insn(1, 3, 7, 10, 3)
>> +#define SYS_DC_CGDVAC            sys_insn(1, 3, 7, 10, 5)
>> +
>> +#define SYS_DC_CVAU            sys_insn(1, 3, 7, 11, 1)
>> +
>> +#define SYS_DC_CVAP            sys_insn(1, 3, 7, 12, 1)
>> +#define SYS_DC_CGVAP            sys_insn(1, 3, 7, 12, 3)
>> +#define SYS_DC_CGDVAP            sys_insn(1, 3, 7, 12, 5)
>> +
>> +#define SYS_DC_CVADP            sys_insn(1, 3, 7, 13, 1)
>> +#define SYS_DC_CGVADP            sys_insn(1, 3, 7, 13, 3)
>> +#define SYS_DC_CGDVADP            sys_insn(1, 3, 7, 13, 5)
>> +
>> +#define SYS_DC_CIVAC            sys_insn(1, 3, 7, 14, 1)
>> +#define SYS_DC_CIGVAC            sys_insn(1, 3, 7, 14, 3)
>> +#define SYS_DC_CIGDVAC            sys_insn(1, 3, 7, 14, 5)
>> +
>> +/* Data cache zero operations */
>> +#define SYS_DC_ZVA            sys_insn(1, 3, 7, 4, 1)
>> +#define SYS_DC_GVA            sys_insn(1, 3, 7, 4, 3)
>> +#define SYS_DC_GZVA            sys_insn(1, 3, 7, 4, 4)
>> +
>>   /*
>>    * Automatically generated definitions for system registers, the
>>    * manual encodings below are in the process of being converted to
>> @@ -162,6 +194,84 @@
>>   #define SYS_DBGDTRTX_EL0        sys_reg(2, 3, 0, 5, 0)
>>   #define SYS_DBGVCR32_EL2        sys_reg(2, 4, 0, 7, 0)
>>   +#define SYS_BRBINF_EL1(n)        sys_reg(2, 1, 8, (n & 15), (((n &
>> 16) >> 2) | 0))
>> +#define SYS_BRBINFINJ_EL1        sys_reg(2, 1, 9, 1, 0)
>> +#define SYS_BRBSRC_EL1(n)        sys_reg(2, 1, 8, (n & 15), (((n &
>> 16) >> 2) | 1))
>> +#define SYS_BRBSRCINJ_EL1        sys_reg(2, 1, 9, 1, 1)
>> +#define SYS_BRBTGT_EL1(n)        sys_reg(2, 1, 8, (n & 15), (((n &
>> 16) >> 2) | 2))
>> +#define SYS_BRBTGTINJ_EL1        sys_reg(2, 1, 9, 1, 2)
>> +#define SYS_BRBTS_EL1            sys_reg(2, 1, 9, 0, 2)
>> +
>> +#define SYS_BRBCR_EL1            sys_reg(2, 1, 9, 0, 0)
>> +#define SYS_BRBFCR_EL1            sys_reg(2, 1, 9, 0, 1)
>> +#define SYS_BRBIDR0_EL1            sys_reg(2, 1, 9, 2, 0)
>> +
>> +#define SYS_TRCITECR_EL1        sys_reg(3, 0, 1, 2, 3)
>> +#define SYS_TRCACATR(m)            sys_reg(2, 1, 2, ((m & 7) << 1),
>> (2 | (m >> 3)))
>> +#define SYS_TRCACVR(m)            sys_reg(2, 1, 2, ((m & 7) << 1), (0
>> | (m >> 3)))
>> +#define SYS_TRCAUTHSTATUS        sys_reg(2, 1, 7, 14, 6)
>> +#define SYS_TRCAUXCTLR            sys_reg(2, 1, 0, 6, 0)
>> +#define SYS_TRCBBCTLR            sys_reg(2, 1, 0, 15, 0)
>> +#define SYS_TRCCCCTLR            sys_reg(2, 1, 0, 14, 0)
>> +#define SYS_TRCCIDCCTLR0        sys_reg(2, 1, 3, 0, 2)
>> +#define SYS_TRCCIDCCTLR1        sys_reg(2, 1, 3, 1, 2)
>> +#define SYS_TRCCIDCVR(m)        sys_reg(2, 1, 3, ((m & 7) << 1), 0)
>> +#define SYS_TRCCLAIMCLR            sys_reg(2, 1, 7, 9, 6)
>> +#define SYS_TRCCLAIMSET            sys_reg(2, 1, 7, 8, 6)
>> +#define SYS_TRCCNTCTLR(m)        sys_reg(2, 1, 0, (4 | (m & 3)), 5)
>> +#define SYS_TRCCNTRLDVR(m)        sys_reg(2, 1, 0, (0 | (m & 3)), 5)
>> +#define SYS_TRCCNTVR(m)            sys_reg(2, 1, 0, (8 | (m & 3)), 5)
>> +#define SYS_TRCCONFIGR            sys_reg(2, 1, 0, 4, 0)
>> +#define SYS_TRCDEVARCH            sys_reg(2, 1, 7, 15, 6)
>> +#define SYS_TRCDEVID            sys_reg(2, 1, 7, 2, 7)
>> +#define SYS_TRCEVENTCTL0R        sys_reg(2, 1, 0, 8, 0)
>> +#define SYS_TRCEVENTCTL1R        sys_reg(2, 1, 0, 9, 0)
>> +#define SYS_TRCEXTINSELR(m)        sys_reg(2, 1, 0, (8 | (m & 3)), 4)
>> +#define SYS_TRCIDR0            sys_reg(2, 1, 0, 8, 7)
>> +#define SYS_TRCIDR10            sys_reg(2, 1, 0, 2, 6)
>> +#define SYS_TRCIDR11            sys_reg(2, 1, 0, 3, 6)
>> +#define SYS_TRCIDR12            sys_reg(2, 1, 0, 4, 6)
>> +#define SYS_TRCIDR13            sys_reg(2, 1, 0, 5, 6)
>> +#define SYS_TRCIDR1            sys_reg(2, 1, 0, 9, 7)
>> +#define SYS_TRCIDR2            sys_reg(2, 1, 0, 10, 7)
>> +#define SYS_TRCIDR3            sys_reg(2, 1, 0, 11, 7)
>> +#define SYS_TRCIDR4            sys_reg(2, 1, 0, 12, 7)
>> +#define SYS_TRCIDR5            sys_reg(2, 1, 0, 13, 7)
>> +#define SYS_TRCIDR6            sys_reg(2, 1, 0, 14, 7)
>> +#define SYS_TRCIDR7            sys_reg(2, 1, 0, 15, 7)
>> +#define SYS_TRCIDR8            sys_reg(2, 1, 0, 0, 6)
>> +#define SYS_TRCIDR9            sys_reg(2, 1, 0, 1, 6)
>> +#define SYS_TRCIMSPEC(m)        sys_reg(2, 1, 0, (m & 7), 7)
>> +#define SYS_TRCITEEDCR            sys_reg(2, 1, 0, 2, 1)
>> +#define SYS_TRCOSLSR            sys_reg(2, 1, 1, 1, 4)
>> +#define SYS_TRCPRGCTLR            sys_reg(2, 1, 0, 1, 0)
>> +#define SYS_TRCQCTLR            sys_reg(2, 1, 0, 1, 1)
>> +#define SYS_TRCRSCTLR(m)        sys_reg(2, 1, 1, (m & 15), (0 | (m >>
>> 4)))
>> +#define SYS_TRCRSR            sys_reg(2, 1, 0, 10, 0)
>> +#define SYS_TRCSEQEVR(m)        sys_reg(2, 1, 0, (m & 3), 4)
>> +#define SYS_TRCSEQRSTEVR        sys_reg(2, 1, 0, 6, 4)
>> +#define SYS_TRCSEQSTR            sys_reg(2, 1, 0, 7, 4)
>> +#define SYS_TRCSSCCR(m)            sys_reg(2, 1, 1, (m & 7), 2)
>> +#define SYS_TRCSSCSR(m)            sys_reg(2, 1, 1, (8 | (m & 7)), 2)
>> +#define SYS_TRCSSPCICR(m)        sys_reg(2, 1, 1, (m & 7), 3)
>> +#define SYS_TRCSTALLCTLR        sys_reg(2, 1, 0, 11, 0)
>> +#define SYS_TRCSTATR            sys_reg(2, 1, 0, 3, 0)
>> +#define SYS_TRCSYNCPR            sys_reg(2, 1, 0, 13, 0)
>> +#define SYS_TRCTRACEIDR            sys_reg(2, 1, 0, 0, 1)
>> +#define SYS_TRCTSCTLR            sys_reg(2, 1, 0, 12, 0)
>> +#define SYS_TRCVICTLR            sys_reg(2, 1, 0, 0, 2)
>> +#define SYS_TRCVIIECTLR            sys_reg(2, 1, 0, 1, 2)
>> +#define SYS_TRCVIPCSSCTLR        sys_reg(2, 1, 0, 3, 2)
>> +#define SYS_TRCVISSCTLR            sys_reg(2, 1, 0, 2, 2)
>> +#define SYS_TRCVMIDCCTLR0        sys_reg(2, 1, 3, 2, 2)
>> +#define SYS_TRCVMIDCCTLR1        sys_reg(2, 1, 3, 3, 2)
>> +#define SYS_TRCVMIDCVR(m)        sys_reg(2, 1, 3, ((m & 7) << 1), 1)
>> +
>> +/* ETM */
>> +#define SYS_TRCOSLAR            sys_reg(2, 1, 1, 0, 4)
>> +
>> +#define SYS_BRBCR_EL2            sys_reg(2, 4, 9, 0, 0)
>> +
>>   #define SYS_MIDR_EL1            sys_reg(3, 0, 0, 0, 0)
>>   #define SYS_MPIDR_EL1            sys_reg(3, 0, 0, 0, 5)
>>   #define SYS_REVIDR_EL1            sys_reg(3, 0, 0, 0, 6)
>> @@ -170,8 +280,6 @@
>>   #define SYS_RGSR_EL1            sys_reg(3, 0, 1, 0, 5)
>>   #define SYS_GCR_EL1            sys_reg(3, 0, 1, 0, 6)
>>   -#define SYS_TRFCR_EL1            sys_reg(3, 0, 1, 2, 1)
>> -
>>   #define SYS_TCR_EL1            sys_reg(3, 0, 2, 0, 2)
>>     #define SYS_APIAKEYLO_EL1        sys_reg(3, 0, 2, 1, 0)
>> @@ -202,8 +310,13 @@
>>   #define SYS_ERXCTLR_EL1            sys_reg(3, 0, 5, 4, 1)
>>   #define SYS_ERXSTATUS_EL1        sys_reg(3, 0, 5, 4, 2)
>>   #define SYS_ERXADDR_EL1            sys_reg(3, 0, 5, 4, 3)
>> +#define SYS_ERXPFGF_EL1            sys_reg(3, 0, 5, 4, 4)
>> +#define SYS_ERXPFGCTL_EL1        sys_reg(3, 0, 5, 4, 5)
>> +#define SYS_ERXPFGCDN_EL1        sys_reg(3, 0, 5, 4, 6)
>>   #define SYS_ERXMISC0_EL1        sys_reg(3, 0, 5, 5, 0)
>>   #define SYS_ERXMISC1_EL1        sys_reg(3, 0, 5, 5, 1)
>> +#define SYS_ERXMISC2_EL1        sys_reg(3, 0, 5, 5, 2)
>> +#define SYS_ERXMISC3_EL1        sys_reg(3, 0, 5, 5, 3)
>>   #define SYS_TFSR_EL1            sys_reg(3, 0, 5, 6, 0)
>>   #define SYS_TFSRE0_EL1            sys_reg(3, 0, 5, 6, 1)
>>   @@ -274,6 +387,8 @@
>>   #define SYS_ICC_IGRPEN0_EL1        sys_reg(3, 0, 12, 12, 6)
>>   #define SYS_ICC_IGRPEN1_EL1        sys_reg(3, 0, 12, 12, 7)
>>   +#define SYS_ACCDATA_EL1            sys_reg(3, 0, 13, 0, 5)
>> +
>>   #define SYS_CNTKCTL_EL1            sys_reg(3, 0, 14, 1, 0)
>>     #define SYS_AIDR_EL1            sys_reg(3, 1, 0, 0, 7)
>> @@ -369,6 +484,7 @@
>>     #define SYS_SCTLR_EL2            sys_reg(3, 4, 1, 0, 0)
>>   #define SYS_ACTLR_EL2            sys_reg(3, 4, 1, 0, 1)
>> +#define SYS_SCTLR2_EL2            sys_reg(3, 4, 1, 0, 3)
>>   #define SYS_HCR_EL2            sys_reg(3, 4, 1, 1, 0)
>>   #define SYS_MDCR_EL2            sys_reg(3, 4, 1, 1, 1)
>>   #define SYS_CPTR_EL2            sys_reg(3, 4, 1, 1, 2)
>> @@ -381,13 +497,15 @@
>>   #define SYS_VTTBR_EL2            sys_reg(3, 4, 2, 1, 0)
>>   #define SYS_VTCR_EL2            sys_reg(3, 4, 2, 1, 2)
>>   -#define SYS_TRFCR_EL2            sys_reg(3, 4, 1, 2, 1)
>> -#define SYS_HDFGRTR_EL2            sys_reg(3, 4, 3, 1, 4)
>> -#define SYS_HDFGWTR_EL2            sys_reg(3, 4, 3, 1, 5)
>> +#define SYS_VNCR_EL2            sys_reg(3, 4, 2, 2, 0)
>>   #define SYS_HAFGRTR_EL2            sys_reg(3, 4, 3, 1, 6)
>>   #define SYS_SPSR_EL2            sys_reg(3, 4, 4, 0, 0)
>>   #define SYS_ELR_EL2            sys_reg(3, 4, 4, 0, 1)
>>   #define SYS_SP_EL1            sys_reg(3, 4, 4, 1, 0)
>> +#define SYS_SPSR_irq            sys_reg(3, 4, 4, 3, 0)
>> +#define SYS_SPSR_abt            sys_reg(3, 4, 4, 3, 1)
>> +#define SYS_SPSR_und            sys_reg(3, 4, 4, 3, 2)
>> +#define SYS_SPSR_fiq            sys_reg(3, 4, 4, 3, 3)
>>   #define SYS_IFSR32_EL2            sys_reg(3, 4, 5, 0, 1)
>>   #define SYS_AFSR0_EL2            sys_reg(3, 4, 5, 1, 0)
>>   #define SYS_AFSR1_EL2            sys_reg(3, 4, 5, 1, 1)
>> @@ -401,6 +519,18 @@
>>     #define SYS_MAIR_EL2            sys_reg(3, 4, 10, 2, 0)
>>   #define SYS_AMAIR_EL2            sys_reg(3, 4, 10, 3, 0)
>> +#define SYS_MPAMHCR_EL2            sys_reg(3, 4, 10, 4, 0)
>> +#define SYS_MPAMVPMV_EL2        sys_reg(3, 4, 10, 4, 1)
>> +#define SYS_MPAM2_EL2            sys_reg(3, 4, 10, 5, 0)
>> +#define __SYS__MPAMVPMx_EL2(x)        sys_reg(3, 4, 10, 6, x)
>> +#define SYS_MPAMVPM0_EL2        __SYS__MPAMVPMx_EL2(0)
>> +#define SYS_MPAMVPM1_EL2        __SYS__MPAMVPMx_EL2(1)
>> +#define SYS_MPAMVPM2_EL2        __SYS__MPAMVPMx_EL2(2)
>> +#define SYS_MPAMVPM3_EL2        __SYS__MPAMVPMx_EL2(3)
>> +#define SYS_MPAMVPM4_EL2        __SYS__MPAMVPMx_EL2(4)
>> +#define SYS_MPAMVPM5_EL2        __SYS__MPAMVPMx_EL2(5)
>> +#define SYS_MPAMVPM6_EL2        __SYS__MPAMVPMx_EL2(6)
>> +#define SYS_MPAMVPM7_EL2        __SYS__MPAMVPMx_EL2(7)
>>     #define SYS_VBAR_EL2            sys_reg(3, 4, 12, 0, 0)
>>   #define SYS_RVBAR_EL2            sys_reg(3, 4, 12, 0, 1)
>> @@ -449,24 +579,49 @@
>>     #define SYS_CONTEXTIDR_EL2        sys_reg(3, 4, 13, 0, 1)
>>   #define SYS_TPIDR_EL2            sys_reg(3, 4, 13, 0, 2)
>> +#define SYS_SCXTNUM_EL2            sys_reg(3, 4, 13, 0, 7)
>> +
>> +#define __AMEV_op2(m)            (m & 0x7)
>> +#define __AMEV_CRm(n, m)        (n | ((m & 0x8) >> 3))
>> +#define __SYS__AMEVCNTVOFF0n_EL2(m)    sys_reg(3, 4, 13,
>> __AMEV_CRm(0x8, m), __AMEV_op2(m))
>> +#define SYS_AMEVCNTVOFF0n_EL2(m)    __SYS__AMEVCNTVOFF0n_EL2(m)
>> +#define __SYS__AMEVCNTVOFF1n_EL2(m)    sys_reg(3, 4, 13,
>> __AMEV_CRm(0xA, m), __AMEV_op2(m))
>> +#define SYS_AMEVCNTVOFF1n_EL2(m)    __SYS__AMEVCNTVOFF1n_EL2(m)
>>     #define SYS_CNTVOFF_EL2            sys_reg(3, 4, 14, 0, 3)
>>   #define SYS_CNTHCTL_EL2            sys_reg(3, 4, 14, 1, 0)
>> +#define SYS_CNTHP_TVAL_EL2        sys_reg(3, 4, 14, 2, 0)
>> +#define SYS_CNTHP_CTL_EL2        sys_reg(3, 4, 14, 2, 1)
>> +#define SYS_CNTHP_CVAL_EL2        sys_reg(3, 4, 14, 2, 2)
>> +#define SYS_CNTHV_TVAL_EL2        sys_reg(3, 4, 14, 3, 0)
>> +#define SYS_CNTHV_CTL_EL2        sys_reg(3, 4, 14, 3, 1)
>> +#define SYS_CNTHV_CVAL_EL2        sys_reg(3, 4, 14, 3, 2)
>>     /* VHE encodings for architectural EL0/1 system registers */
>> +#define SYS_BRBCR_EL12            sys_reg(2, 5, 9, 0, 0)
>>   #define SYS_SCTLR_EL12            sys_reg(3, 5, 1, 0, 0)
>> +#define SYS_CPACR_EL12            sys_reg(3, 5, 1, 0, 2)
>> +#define SYS_SCTLR2_EL12            sys_reg(3, 5, 1, 0, 3)
>> +#define SYS_ZCR_EL12            sys_reg(3, 5, 1, 2, 0)
>> +#define SYS_TRFCR_EL12            sys_reg(3, 5, 1, 2, 1)
>> +#define SYS_SMCR_EL12            sys_reg(3, 5, 1, 2, 6)
>>   #define SYS_TTBR0_EL12            sys_reg(3, 5, 2, 0, 0)
>>   #define SYS_TTBR1_EL12            sys_reg(3, 5, 2, 0, 1)
>>   #define SYS_TCR_EL12            sys_reg(3, 5, 2, 0, 2)
>> +#define SYS_TCR2_EL12            sys_reg(3, 5, 2, 0, 3)
>>   #define SYS_SPSR_EL12            sys_reg(3, 5, 4, 0, 0)
>>   #define SYS_ELR_EL12            sys_reg(3, 5, 4, 0, 1)
>>   #define SYS_AFSR0_EL12            sys_reg(3, 5, 5, 1, 0)
>>   #define SYS_AFSR1_EL12            sys_reg(3, 5, 5, 1, 1)
>>   #define SYS_ESR_EL12            sys_reg(3, 5, 5, 2, 0)
>>   #define SYS_TFSR_EL12            sys_reg(3, 5, 5, 6, 0)
>> +#define SYS_FAR_EL12            sys_reg(3, 5, 6, 0, 0)
>> +#define SYS_PMSCR_EL12            sys_reg(3, 5, 9, 9, 0)
>>   #define SYS_MAIR_EL12            sys_reg(3, 5, 10, 2, 0)
>>   #define SYS_AMAIR_EL12            sys_reg(3, 5, 10, 3, 0)
>>   #define SYS_VBAR_EL12            sys_reg(3, 5, 12, 0, 0)
>> +#define SYS_CONTEXTIDR_EL12        sys_reg(3, 5, 13, 0, 1)
>> +#define SYS_SCXTNUM_EL12        sys_reg(3, 5, 13, 0, 7)
>>   #define SYS_CNTKCTL_EL12        sys_reg(3, 5, 14, 1, 0)
>>   #define SYS_CNTP_TVAL_EL02        sys_reg(3, 5, 14, 2, 0)
>>   #define SYS_CNTP_CTL_EL02        sys_reg(3, 5, 14, 2, 1)
>> @@ -477,6 +632,158 @@
>>     #define SYS_SP_EL2            sys_reg(3, 6,  4, 1, 0)
>>   +/* AT instructions */
>> +#define AT_Op0 1
>> +#define AT_CRn 7
>> +
>> +#define OP_AT_S1E1R    sys_insn(AT_Op0, 0, AT_CRn, 8, 0)
>> +#define OP_AT_S1E1W    sys_insn(AT_Op0, 0, AT_CRn, 8, 1)
>> +#define OP_AT_S1E0R    sys_insn(AT_Op0, 0, AT_CRn, 8, 2)
>> +#define OP_AT_S1E0W    sys_insn(AT_Op0, 0, AT_CRn, 8, 3)
>> +#define OP_AT_S1E1RP    sys_insn(AT_Op0, 0, AT_CRn, 9, 0)
>> +#define OP_AT_S1E1WP    sys_insn(AT_Op0, 0, AT_CRn, 9, 1)
>> +#define OP_AT_S1E2R    sys_insn(AT_Op0, 4, AT_CRn, 8, 0)
>> +#define OP_AT_S1E2W    sys_insn(AT_Op0, 4, AT_CRn, 8, 1)
>> +#define OP_AT_S12E1R    sys_insn(AT_Op0, 4, AT_CRn, 8, 4)
>> +#define OP_AT_S12E1W    sys_insn(AT_Op0, 4, AT_CRn, 8, 5)
>> +#define OP_AT_S12E0R    sys_insn(AT_Op0, 4, AT_CRn, 8, 6)
>> +#define OP_AT_S12E0W    sys_insn(AT_Op0, 4, AT_CRn, 8, 7)
>> +
>> +/* TLBI instructions */
>> +#define OP_TLBI_VMALLE1OS        sys_insn(1, 0, 8, 1, 0)
>> +#define OP_TLBI_VAE1OS            sys_insn(1, 0, 8, 1, 1)
>> +#define OP_TLBI_ASIDE1OS        sys_insn(1, 0, 8, 1, 2)
>> +#define OP_TLBI_VAAE1OS            sys_insn(1, 0, 8, 1, 3)
>> +#define OP_TLBI_VALE1OS            sys_insn(1, 0, 8, 1, 5)
>> +#define OP_TLBI_VAALE1OS        sys_insn(1, 0, 8, 1, 7)
>> +#define OP_TLBI_RVAE1IS            sys_insn(1, 0, 8, 2, 1)
>> +#define OP_TLBI_RVAAE1IS        sys_insn(1, 0, 8, 2, 3)
>> +#define OP_TLBI_RVALE1IS        sys_insn(1, 0, 8, 2, 5)
>> +#define OP_TLBI_RVAALE1IS        sys_insn(1, 0, 8, 2, 7)
>> +#define OP_TLBI_VMALLE1IS        sys_insn(1, 0, 8, 3, 0)
>> +#define OP_TLBI_VAE1IS            sys_insn(1, 0, 8, 3, 1)
>> +#define OP_TLBI_ASIDE1IS        sys_insn(1, 0, 8, 3, 2)
>> +#define OP_TLBI_VAAE1IS            sys_insn(1, 0, 8, 3, 3)
>> +#define OP_TLBI_VALE1IS            sys_insn(1, 0, 8, 3, 5)
>> +#define OP_TLBI_VAALE1IS        sys_insn(1, 0, 8, 3, 7)
>> +#define OP_TLBI_RVAE1OS            sys_insn(1, 0, 8, 5, 1)
>> +#define OP_TLBI_RVAAE1OS        sys_insn(1, 0, 8, 5, 3)
>> +#define OP_TLBI_RVALE1OS        sys_insn(1, 0, 8, 5, 5)
>> +#define OP_TLBI_RVAALE1OS        sys_insn(1, 0, 8, 5, 7)
>> +#define OP_TLBI_RVAE1            sys_insn(1, 0, 8, 6, 1)
>> +#define OP_TLBI_RVAAE1            sys_insn(1, 0, 8, 6, 3)
>> +#define OP_TLBI_RVALE1            sys_insn(1, 0, 8, 6, 5)
>> +#define OP_TLBI_RVAALE1            sys_insn(1, 0, 8, 6, 7)
>> +#define OP_TLBI_VMALLE1            sys_insn(1, 0, 8, 7, 0)
>> +#define OP_TLBI_VAE1            sys_insn(1, 0, 8, 7, 1)
>> +#define OP_TLBI_ASIDE1            sys_insn(1, 0, 8, 7, 2)
>> +#define OP_TLBI_VAAE1            sys_insn(1, 0, 8, 7, 3)
>> +#define OP_TLBI_VALE1            sys_insn(1, 0, 8, 7, 5)
>> +#define OP_TLBI_VAALE1            sys_insn(1, 0, 8, 7, 7)
>> +#define OP_TLBI_VMALLE1OSNXS        sys_insn(1, 0, 9, 1, 0)
>> +#define OP_TLBI_VAE1OSNXS        sys_insn(1, 0, 9, 1, 1)
>> +#define OP_TLBI_ASIDE1OSNXS        sys_insn(1, 0, 9, 1, 2)
>> +#define OP_TLBI_VAAE1OSNXS        sys_insn(1, 0, 9, 1, 3)
>> +#define OP_TLBI_VALE1OSNXS        sys_insn(1, 0, 9, 1, 5)
>> +#define OP_TLBI_VAALE1OSNXS        sys_insn(1, 0, 9, 1, 7)
>> +#define OP_TLBI_RVAE1ISNXS        sys_insn(1, 0, 9, 2, 1)
>> +#define OP_TLBI_RVAAE1ISNXS        sys_insn(1, 0, 9, 2, 3)
>> +#define OP_TLBI_RVALE1ISNXS        sys_insn(1, 0, 9, 2, 5)
>> +#define OP_TLBI_RVAALE1ISNXS        sys_insn(1, 0, 9, 2, 7)
>> +#define OP_TLBI_VMALLE1ISNXS        sys_insn(1, 0, 9, 3, 0)
>> +#define OP_TLBI_VAE1ISNXS        sys_insn(1, 0, 9, 3, 1)
>> +#define OP_TLBI_ASIDE1ISNXS        sys_insn(1, 0, 9, 3, 2)
>> +#define OP_TLBI_VAAE1ISNXS        sys_insn(1, 0, 9, 3, 3)
>> +#define OP_TLBI_VALE1ISNXS        sys_insn(1, 0, 9, 3, 5)
>> +#define OP_TLBI_VAALE1ISNXS        sys_insn(1, 0, 9, 3, 7)
>> +#define OP_TLBI_RVAE1OSNXS        sys_insn(1, 0, 9, 5, 1)
>> +#define OP_TLBI_RVAAE1OSNXS        sys_insn(1, 0, 9, 5, 3)
>> +#define OP_TLBI_RVALE1OSNXS        sys_insn(1, 0, 9, 5, 5)
>> +#define OP_TLBI_RVAALE1OSNXS        sys_insn(1, 0, 9, 5, 7)
>> +#define OP_TLBI_RVAE1NXS        sys_insn(1, 0, 9, 6, 1)
>> +#define OP_TLBI_RVAAE1NXS        sys_insn(1, 0, 9, 6, 3)
>> +#define OP_TLBI_RVALE1NXS        sys_insn(1, 0, 9, 6, 5)
>> +#define OP_TLBI_RVAALE1NXS        sys_insn(1, 0, 9, 6, 7)
>> +#define OP_TLBI_VMALLE1NXS        sys_insn(1, 0, 9, 7, 0)
>> +#define OP_TLBI_VAE1NXS            sys_insn(1, 0, 9, 7, 1)
>> +#define OP_TLBI_ASIDE1NXS        sys_insn(1, 0, 9, 7, 2)
>> +#define OP_TLBI_VAAE1NXS        sys_insn(1, 0, 9, 7, 3)
>> +#define OP_TLBI_VALE1NXS        sys_insn(1, 0, 9, 7, 5)
>> +#define OP_TLBI_VAALE1NXS        sys_insn(1, 0, 9, 7, 7)
>> +#define OP_TLBI_IPAS2E1IS        sys_insn(1, 4, 8, 0, 1)
>> +#define OP_TLBI_RIPAS2E1IS        sys_insn(1, 4, 8, 0, 2)
>> +#define OP_TLBI_IPAS2LE1IS        sys_insn(1, 4, 8, 0, 5)
>> +#define OP_TLBI_RIPAS2LE1IS        sys_insn(1, 4, 8, 0, 6)
>> +#define OP_TLBI_ALLE2OS            sys_insn(1, 4, 8, 1, 0)
>> +#define OP_TLBI_VAE2OS            sys_insn(1, 4, 8, 1, 1)
>> +#define OP_TLBI_ALLE1OS            sys_insn(1, 4, 8, 1, 4)
>> +#define OP_TLBI_VALE2OS            sys_insn(1, 4, 8, 1, 5)
>> +#define OP_TLBI_VMALLS12E1OS        sys_insn(1, 4, 8, 1, 6)
>> +#define OP_TLBI_RVAE2IS            sys_insn(1, 4, 8, 2, 1)
>> +#define OP_TLBI_RVALE2IS        sys_insn(1, 4, 8, 2, 5)
>> +#define OP_TLBI_ALLE2IS            sys_insn(1, 4, 8, 3, 0)
>> +#define OP_TLBI_VAE2IS            sys_insn(1, 4, 8, 3, 1)
>> +#define OP_TLBI_ALLE1IS            sys_insn(1, 4, 8, 3, 4)
>> +#define OP_TLBI_VALE2IS            sys_insn(1, 4, 8, 3, 5)
>> +#define OP_TLBI_VMALLS12E1IS        sys_insn(1, 4, 8, 3, 6)
>> +#define OP_TLBI_IPAS2E1OS        sys_insn(1, 4, 8, 4, 0)
>> +#define OP_TLBI_IPAS2E1            sys_insn(1, 4, 8, 4, 1)
>> +#define OP_TLBI_RIPAS2E1        sys_insn(1, 4, 8, 4, 2)
>> +#define OP_TLBI_RIPAS2E1OS        sys_insn(1, 4, 8, 4, 3)
>> +#define OP_TLBI_IPAS2LE1OS        sys_insn(1, 4, 8, 4, 4)
>> +#define OP_TLBI_IPAS2LE1        sys_insn(1, 4, 8, 4, 5)
>> +#define OP_TLBI_RIPAS2LE1        sys_insn(1, 4, 8, 4, 6)
>> +#define OP_TLBI_RIPAS2LE1OS        sys_insn(1, 4, 8, 4, 7)
>> +#define OP_TLBI_RVAE2OS            sys_insn(1, 4, 8, 5, 1)
>> +#define OP_TLBI_RVALE2OS        sys_insn(1, 4, 8, 5, 5)
>> +#define OP_TLBI_RVAE2            sys_insn(1, 4, 8, 6, 1)
>> +#define OP_TLBI_RVALE2            sys_insn(1, 4, 8, 6, 5)
>> +#define OP_TLBI_ALLE2            sys_insn(1, 4, 8, 7, 0)
>> +#define OP_TLBI_VAE2            sys_insn(1, 4, 8, 7, 1)
>> +#define OP_TLBI_ALLE1            sys_insn(1, 4, 8, 7, 4)
>> +#define OP_TLBI_VALE2            sys_insn(1, 4, 8, 7, 5)
>> +#define OP_TLBI_VMALLS12E1        sys_insn(1, 4, 8, 7, 6)
>> +#define OP_TLBI_IPAS2E1ISNXS        sys_insn(1, 4, 9, 0, 1)
>> +#define OP_TLBI_RIPAS2E1ISNXS        sys_insn(1, 4, 9, 0, 2)
>> +#define OP_TLBI_IPAS2LE1ISNXS        sys_insn(1, 4, 9, 0, 5)
>> +#define OP_TLBI_RIPAS2LE1ISNXS        sys_insn(1, 4, 9, 0, 6)
>> +#define OP_TLBI_ALLE2OSNXS        sys_insn(1, 4, 9, 1, 0)
>> +#define OP_TLBI_VAE2OSNXS        sys_insn(1, 4, 9, 1, 1)
>> +#define OP_TLBI_ALLE1OSNXS        sys_insn(1, 4, 9, 1, 4)
>> +#define OP_TLBI_VALE2OSNXS        sys_insn(1, 4, 9, 1, 5)
>> +#define OP_TLBI_VMALLS12E1OSNXS        sys_insn(1, 4, 9, 1, 6)
>> +#define OP_TLBI_RVAE2ISNXS        sys_insn(1, 4, 9, 2, 1)
>> +#define OP_TLBI_RVALE2ISNXS        sys_insn(1, 4, 9, 2, 5)
>> +#define OP_TLBI_ALLE2ISNXS        sys_insn(1, 4, 9, 3, 0)
>> +#define OP_TLBI_VAE2ISNXS        sys_insn(1, 4, 9, 3, 1)
>> +#define OP_TLBI_ALLE1ISNXS        sys_insn(1, 4, 9, 3, 4)
>> +#define OP_TLBI_VALE2ISNXS        sys_insn(1, 4, 9, 3, 5)
>> +#define OP_TLBI_VMALLS12E1ISNXS        sys_insn(1, 4, 9, 3, 6)
>> +#define OP_TLBI_IPAS2E1OSNXS        sys_insn(1, 4, 9, 4, 0)
>> +#define OP_TLBI_IPAS2E1NXS        sys_insn(1, 4, 9, 4, 1)
>> +#define OP_TLBI_RIPAS2E1NXS        sys_insn(1, 4, 9, 4, 2)
>> +#define OP_TLBI_RIPAS2E1OSNXS        sys_insn(1, 4, 9, 4, 3)
>> +#define OP_TLBI_IPAS2LE1OSNXS        sys_insn(1, 4, 9, 4, 4)
>> +#define OP_TLBI_IPAS2LE1NXS        sys_insn(1, 4, 9, 4, 5)
>> +#define OP_TLBI_RIPAS2LE1NXS        sys_insn(1, 4, 9, 4, 6)
>> +#define OP_TLBI_RIPAS2LE1OSNXS        sys_insn(1, 4, 9, 4, 7)
>> +#define OP_TLBI_RVAE2OSNXS        sys_insn(1, 4, 9, 5, 1)
>> +#define OP_TLBI_RVALE2OSNXS        sys_insn(1, 4, 9, 5, 5)
>> +#define OP_TLBI_RVAE2NXS        sys_insn(1, 4, 9, 6, 1)
>> +#define OP_TLBI_RVALE2NXS        sys_insn(1, 4, 9, 6, 5)
>> +#define OP_TLBI_ALLE2NXS        sys_insn(1, 4, 9, 7, 0)
>> +#define OP_TLBI_VAE2NXS            sys_insn(1, 4, 9, 7, 1)
>> +#define OP_TLBI_ALLE1NXS        sys_insn(1, 4, 9, 7, 4)
>> +#define OP_TLBI_VALE2NXS        sys_insn(1, 4, 9, 7, 5)
>> +#define OP_TLBI_VMALLS12E1NXS        sys_insn(1, 4, 9, 7, 6)
>> +
>> +/* Misc instructions */
>> +#define OP_BRB_IALL            sys_insn(1, 1, 7, 2, 4)
>> +#define OP_BRB_INJ            sys_insn(1, 1, 7, 2, 5)
>> +#define OP_CFP_RCTX            sys_insn(1, 3, 7, 3, 4)
>> +#define OP_DVP_RCTX            sys_insn(1, 3, 7, 3, 5)
>> +#define OP_CPP_RCTX            sys_insn(1, 3, 7, 3, 7)
>> +
>>   /* Common SCTLR_ELx flags. */
>>   #define SCTLR_ELx_ENTP2    (BIT(60))
>>   #define SCTLR_ELx_DSSBS    (BIT(44))
>> @@ -610,6 +917,19 @@
>>   #define SYS_GCR_EL1_RRND    (BIT(16))
>>   #define SYS_GCR_EL1_EXCL_MASK    0xffffUL
>>   +#ifdef CONFIG_KASAN_HW_TAGS
>> +/*
>> + * KASAN always uses a whole byte for its tags. With
>> CONFIG_KASAN_HW_TAGS it
>> + * only uses tags in the range 0xF0-0xFF, which we map to MTE tags
>> 0x0-0xF.
>> + */
>> +#define __MTE_TAG_MIN        (KASAN_TAG_MIN & 0xf)
>> +#define __MTE_TAG_MAX        (KASAN_TAG_MAX & 0xf)
>> +#define __MTE_TAG_INCL        GENMASK(__MTE_TAG_MAX, __MTE_TAG_MIN)
>> +#define KERNEL_GCR_EL1_EXCL    (SYS_GCR_EL1_EXCL_MASK & ~__MTE_TAG_INCL)
>> +#else
>> +#define KERNEL_GCR_EL1_EXCL    SYS_GCR_EL1_EXCL_MASK
>> +#endif
>> +
>>   #define KERNEL_GCR_EL1        (SYS_GCR_EL1_RRND | KERNEL_GCR_EL1_EXCL)
>>     /* RGSR_EL1 Definitions */
>> @@ -626,15 +946,6 @@
>>   /* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
>>   #define SYS_MPIDR_SAFE_VAL    (BIT(31))
>>   -#define TRFCR_ELx_TS_SHIFT        5
>> -#define TRFCR_ELx_TS_MASK        ((0x3UL) << TRFCR_ELx_TS_SHIFT)
>> -#define TRFCR_ELx_TS_VIRTUAL        ((0x1UL) << TRFCR_ELx_TS_SHIFT)
>> -#define TRFCR_ELx_TS_GUEST_PHYSICAL    ((0x2UL) << TRFCR_ELx_TS_SHIFT)
>> -#define TRFCR_ELx_TS_PHYSICAL        ((0x3UL) << TRFCR_ELx_TS_SHIFT)
>> -#define TRFCR_EL2_CX            BIT(3)
>> -#define TRFCR_ELx_ExTRE            BIT(1)
>> -#define TRFCR_ELx_E0TRE            BIT(0)
>> -
>>   /* GIC Hypervisor interface registers */
>>   /* ICH_MISR_EL2 bit definitions */
>>   #define ICH_MISR_EOI        (1 << 0)
>> @@ -789,15 +1100,21 @@
>>   /*
>>    * For registers without architectural names, or simply unsupported by
>>    * GAS.
>> + *
>> + * __check_r forces warnings to be generated by the compiler when
>> + * evaluating r which wouldn't normally happen due to being passed to
>> + * the assembler via __stringify(r).
>>    */
>>   #define read_sysreg_s(r) ({                        \
>>       u64 __val;                            \
>> +    u32 __maybe_unused __check_r = (u32)(r);            \
>>       asm volatile(__mrs_s("%0", r) : "=r" (__val));            \
>>       __val;                                \
>>   })
>>     #define write_sysreg_s(v, r) do {                    \
>>       u64 __val = (u64)(v);                        \
>> +    u32 __maybe_unused __check_r = (u32)(r);            \
>>       asm volatile(__msr_s(r, "%x0") : : "rZ" (__val));        \
>>   } while (0)
>>   diff --git a/tools/include/linux/kasan-tags.h
>> b/tools/include/linux/kasan-tags.h
>> new file mode 100644
>> index 000000000000..4f85f562512c
>> --- /dev/null
>> +++ b/tools/include/linux/kasan-tags.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_KASAN_TAGS_H
>> +#define _LINUX_KASAN_TAGS_H
>> +
>> +#define KASAN_TAG_KERNEL    0xFF /* native kernel pointers tag */
>> +#define KASAN_TAG_INVALID    0xFE /* inaccessible memory tag */
>> +#define KASAN_TAG_MAX        0xFD /* maximum value for random tags */
>> +
>> +#ifdef CONFIG_KASAN_HW_TAGS
>> +#define KASAN_TAG_MIN        0xF0 /* minimum value for random tags */
>> +#else
>> +#define KASAN_TAG_MIN        0x00 /* minimum value for random tags */
>> +#endif
>> +
>> +#endif /* LINUX_KASAN_TAGS_H */
> 
> 

