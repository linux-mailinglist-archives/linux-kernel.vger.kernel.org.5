Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612C47DC581
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 05:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbjJaEne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 00:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjJaEnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 00:43:32 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2116.outbound.protection.outlook.com [40.107.237.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140EBAB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yn7Uz/+/QgmxdNFLXXDoB4b6LZ6+A7DIraHTvkQvnSVXcSp0PPyrcPe8pUe0ooyPv6udfNk5BYeIi1TpPOlp2/Kut1hvZBtFb5WkZA0bC7hrw+nfcGU67gZY9Gg9nG5iiRix+H2c2+HzWrAwLnMm8lxP554wOTA1WzVZoJDV+5f020SCmxi1QZ34EZB4oh2LAlOM8C1CM//jRF0gLrxXG5+jmq4eUxgSbxvRNt92vKE9L4Ndyq+MNhUmKOBzeFJlXNZcEfcHrmsOrxSxxeQGoTyNtN6GsWaRuQDsp6bY2dWhYq4Z1BgnwNFMo55wWg49jNjG2t/UfG7V51ZBAtqOYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FCo75nzb9xj7+I4bOo+vdLR6H+vsSQZZ7CdTH1Fz1c=;
 b=AMqFi1qftFwkJxMOytuIjzYCTTR3xbqRraR/jSnveOU4bTnO1kRqfgHgXFCtJgCF4CChViXLvnZbaD44NWtond+qiIduUgiNIi97+k1ltyYivfXA0YeaFdxOjG/3F8JiWuq4rfE3m7kGfuoICxo7PX5KHqrJ3V/UyB/JcgV3HxzSshBEvSzMFpKDOuhen6GjV81pUDkPI63zr2qG4XtQ/WbrBNb7yu0JtLV8gk9cQhmsEceRwZioaZWxjgIXifNCUlP9TCn7Hh+8/j/Pe5e3GSS0sZz9WtWaa7DS2SlvLfha2Kx8m6VSScHzDjuHkoFanvQXN8VMeJCeDFVWRJOi+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FCo75nzb9xj7+I4bOo+vdLR6H+vsSQZZ7CdTH1Fz1c=;
 b=GUMnDJi1928vs4hBApOmAE80I+myc1beUZy3oouBJi2Ol3SNMuHGKHZcwR/qJ5xas5D7Lo8jDiDmsMrRMC8sSZv+mLa+4MjLJD7PWD5DqZ+ZYJAXuMNZZ+2FteOmoV5WEnpIWuwp5qLhTJZ2iC3ZuaJYHiPblNdXkihKIONsfuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SJ2PR01MB8507.prod.exchangelabs.com (2603:10b6:a03:55e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Tue, 31 Oct 2023 04:43:23 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f%4]) with mapi id 15.20.6933.024; Tue, 31 Oct 2023
 04:43:22 +0000
Date:   Mon, 30 Oct 2023 21:43:10 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Mark Rutland <mark.rutland@arm.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Zaid Al-Bassam <zalbassam@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/arm: perf: Don't discard upper 32 bits from
 PMCEID0/1 registers
In-Reply-To: <ZTuVEXnvqfIPMtmF@FVFF77S0Q05N>
Message-ID: <29b2ffc-82f2-bfce-d44a-c3363f4af83@os.amperecomputing.com>
References: <20231027012243.111070-1-ilkka@os.amperecomputing.com> <ZTuVEXnvqfIPMtmF@FVFF77S0Q05N>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH2PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:610:57::19) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SJ2PR01MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 325ceb28-a4c4-47c4-1c82-08dbd9cbe9b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vppj2YXiFfd7TqUgFXzWKvZG+aTriIqJ1JymB++UT/Z7Pv8YIr03SUn+l+RuMQ+MCKl2UAMr6EInip48UfcuRVUtTeoZJevliQ4CkOlopwQWCPCKqVYAlliYSykHVCmNOoRRxx4M1uMg1Fe0v+7N9NMBt8R6N+9sRWGwX215Fdlk5bg02/pPUj/kuwKnNwdmbw7AHg83TYeuIaii8oqAkNANBJG0sEvDF55dsH+g5UOs6S87z/L5Cwv5aajRlIJ1pcDXShq0UBBfGYEXJ39eTE1ain4879gaQpfu1eS3blOcfCQFLNrHIhugQVM5S1rqd6OIrL6SfPN+B1F2OivwiTRCOsnZLg45GqR8ykkdB7KLs7fR7PkMl+/4Z18v2FttN590ZsHtmD5mZU+7mOnt7V9mBw4wJWiLW72cmCEpJtuLDaKpUgqH5ag61nGgc2iHF6SKn1ZJBELSRLm0L2u9EW7env7iEZgwflqRJqXc4c8nM9GHjkOri/c/HKTYJIGXEu1XPJr3n6/ALRI/PGLAiRKrELCPqLzlqHqM9EDVIftcsD2v+jUpYsObZ1RcJBe8LOJGsGAyCcRJuNwvt4jP0Bf1ENHz0l6MzDiMMG/l9GN2nC8ggmc+7IhPLeR6AiE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39850400004)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6666004)(83380400001)(6506007)(52116002)(26005)(8676002)(5660300002)(2616005)(4326008)(8936002)(38350700005)(41300700001)(6486002)(2906002)(6512007)(966005)(6916009)(478600001)(66556008)(86362001)(316002)(38100700002)(66476007)(54906003)(66946007)(277424003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BBsxDaIdumCyheqUbpMd7gHh2eYj0XB+Y5Zh/F56uqa7y+ZF+nifB4KQc7i6?=
 =?us-ascii?Q?uSFEPTfHzqqHJtm4Q0DzvbxFtNb54RfnO60MAqZ/0E3TE8Gklc96xxLDiaLJ?=
 =?us-ascii?Q?OprzNi3i3GDhxg/xvP/RKhmutBTe564rQ98VwTCCQ5ERUz6RRH4pjl96Io0n?=
 =?us-ascii?Q?AGYk9NG6wGkrhKDzD+zvlGgsJY19mJp9gWr8eCAwlvoVDqjmKJsunUFVM3gE?=
 =?us-ascii?Q?qGhoigiyKWUsWMiDNIccj5IwCYtRmwULX/7zlGCNw5VIQSmKYrLxN9W8kc9c?=
 =?us-ascii?Q?cb7WTP5N6p5P5jBMPRO9EEssd4mWxLaaz+/tPRc2r3EXO+cPL+hx6berZcoC?=
 =?us-ascii?Q?CwCgQDIaos/AIbSjfoHTpXJuenUpLGE2G/UB6cKbLphhYhBtHdRLGHTamAX+?=
 =?us-ascii?Q?lLX1TcVGsuxD+ApTa4VJBxdEEvNoe4x55IcMVWbdR50EAESlLDwMuyjW+DNc?=
 =?us-ascii?Q?7hQkk5LGir1qV7QFYIiW/CW32zXBvmaOH0+NvaUAJecGgTdmCkFAk6re1tnc?=
 =?us-ascii?Q?If+z4D5QZH3st1CKRMXY8NzOw/ZiQ1KqDN2bOJNdUIqfZadXrV3QE8XvA9EZ?=
 =?us-ascii?Q?zDJM95dHrBvcgzFE3LMYk17vqEq3RRBmNalxUhMpttbqqIMhcHqSVo1NyieL?=
 =?us-ascii?Q?qiemsgD51pZMFNdEeyvS2uPZI2cZR+yur/CrlpiDV3hL1SxHETIytzhyKsku?=
 =?us-ascii?Q?oMO0QO0tqu8KQVg3lJpozQQnZyK/+mVTsdtmydfV7MIayrZ2TGnODy9mS/6U?=
 =?us-ascii?Q?AYD7sCU1O5yQ+44cK0XhUAhy/XjnRXeYWbwit3yARW8vZRrlRw7WMFJlzBxC?=
 =?us-ascii?Q?rzv6uZRUPeUBScjheIbuknubXIwaSDYFzSGnLkwQkjFiZOpI5rha2znQrVEm?=
 =?us-ascii?Q?GSltMkBVNR6MNz36PSu13qj115eWahoypCPR1RNKJFpcNxo8YSIGf68xeQll?=
 =?us-ascii?Q?wc4avsuz6Aa2dvoqWw1mufIyBmcvwG09G1R6mhLRSDCUBmXi9uy8IzU9mgFv?=
 =?us-ascii?Q?d1ehALi9gzK1RtUKvBo+qe9+hL8LLNK1/0BYuAn1Ar4ySB6VMcDu/RzZ72mj?=
 =?us-ascii?Q?F8EwaA1eF0J6jS4fxLIkdBiKDpAbjYWuBgn/gnjTZtZ2nvhM1rffU2fRAnoM?=
 =?us-ascii?Q?qTppvwkJlXdRrB6x/0WpczkRDYqaH5xTg5yQ9pmr9cBN85bl9Gxl9rWIIzYo?=
 =?us-ascii?Q?zfcS4jutGIse6rklKWb55zU/XKQ5ZchxaP/NO8dERfTni++F0PwBszH1uxip?=
 =?us-ascii?Q?rlmu+whF6NfOq3nozE72klpoam+MzO+Porl4prcTmYNITPFxDbhwGRVWEf0v?=
 =?us-ascii?Q?A6mt9yqP+djqZ0BPP9hG26eFZQr2JMNz26lDliMBeuNDc1Y5rF5Kd86aCUq4?=
 =?us-ascii?Q?pArypasJIqtcj2Xg1bG9zXhz5IIFup8mkqIYuTOBC1+luB/yUbT35QJncE/X?=
 =?us-ascii?Q?sBDNcFtvMGHIu+LNbDt9GfRCEc1QiwSGHyGwE41pXuSUrRFkNU1pXdrf5Ncd?=
 =?us-ascii?Q?klSxOJ+izoWnczC5YcmsXbj70Vg1M0PEAnovIScdUQDXwkGjXraChliM7DXe?=
 =?us-ascii?Q?2z840Po7rlOr1jxeESkjKyGs5i+cVR2OZidPsFICjLY6doC6OAspqRy3GD4h?=
 =?us-ascii?Q?VN+NqLH6mU3pQlWDCknxVRE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325ceb28-a4c4-47c4-1c82-08dbd9cbe9b1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 04:43:22.7917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zheE0ZaHfKmYkGQy69DflZW1ygokBb5d15JqMIVSTCHlLGoY3xkw7H7LrVXtW4mNP/QP81mNXs8CM1yMfm6bDTqG3Wg7aXS2iGi1javc9M6JOadDBVxfeocJZQWXvO+I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8507
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mark,

On Fri, 27 Oct 2023, Mark Rutland wrote:
> On Thu, Oct 26, 2023 at 06:22:43PM -0700, Ilkka Koskinen wrote:
>> The upper 32 bits of PMCEID[n] registers are used to describe whether
>> architectural and microarchitectural events in range 0x4000-0x401f
>> exist. Due to discarding the bits, the driver made the events invisible,
>> even if they existed.
>>
>> Fixes: df29ddf4f04b ("arm64: perf: Abstract system register accesses away")
>
> Hmm... are we silently truncating anything else?
>
> I see that read_pmxevcntr() and write_pmxevcntr() treat PMXEVCNTR_EL0 as 32-bit
> despite it being 64-bit with PMUv3.5, but it doesn't matter as those functions
> are never used, and should just be deleted.
>
> Similarly PMCR_EL0 is 64-bit, with bit 32 bit FZS when FEAT_SPEv1p2 is
> implemented. That doesn't matter to us right now as we don't use FZS, but it's
> something that could catch us out in future if new bitss get added.
>
> Could we please go check all the accessors added in df29ddf4f04b, and fix those
> in one go?

I quickly look at the registers and unless I'm mistaken there's just one 
more register, PMCCFILTR_EL0, that needs to be taken care. It seems to 
have VS bits [57:56], if FEAT_PMUv3_SME is implemented.

I'll try to submit a new patch that handles all of them tomorrow.

Cheers, Ilkka

>
>> Reported-by: Carl Worth <carl@os.amperecomputing.com>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>
>> Changes since v1:
>>
>>   * Took arm32 specific code from Marc Zyngier's review comment
>>   * Fixed a couple of typos in the commit message
>>
>> I have tested the patch on Arm64. However, what comes to Arm32 part, I have
>> only compared the code with Arm32 specification and cross compiled it.
>>
>> v1: https://lore.kernel.org/all/20231025200815.104017-1-ilkka@os.amperecomputing.com/
>>
>> ---
>>
>>  arch/arm/include/asm/arm_pmuv3.h   | 33 +++++++++++++++++++++---------
>>  arch/arm64/include/asm/arm_pmuv3.h |  4 ++--
>>  2 files changed, 25 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
>> index 72529f5e2bed..90841cb7ce43 100644
>> --- a/arch/arm/include/asm/arm_pmuv3.h
>> +++ b/arch/arm/include/asm/arm_pmuv3.h
>> @@ -23,6 +23,8 @@
>>  #define PMUSERENR		__ACCESS_CP15(c9,  0, c14, 0)
>>  #define PMINTENSET		__ACCESS_CP15(c9,  0, c14, 1)
>>  #define PMINTENCLR		__ACCESS_CP15(c9,  0, c14, 2)
>> +#define PMCEID2			__ACCESS_CP15(c9,  0, c14, 4)
>> +#define PMCEID3			__ACCESS_CP15(c9,  0, c14, 5)
>>  #define PMMIR			__ACCESS_CP15(c9,  0, c14, 6)
>>  #define PMCCFILTR		__ACCESS_CP15(c14, 0, c15, 7)
>>
>> @@ -205,16 +207,6 @@ static inline void write_pmuserenr(u32 val)
>>  	write_sysreg(val, PMUSERENR);
>>  }
>>
>> -static inline u32 read_pmceid0(void)
>> -{
>> -	return read_sysreg(PMCEID0);
>> -}
>> -
>> -static inline u32 read_pmceid1(void)
>> -{
>> -	return read_sysreg(PMCEID1);
>> -}
>> -
>>  static inline void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr) {}
>>  static inline void kvm_clr_pmu_events(u32 clr) {}
>>  static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
>> @@ -231,6 +223,7 @@ static inline void kvm_vcpu_pmu_resync_el0(void) {}
>>
>>  /* PMU Version in DFR Register */
>>  #define ARMV8_PMU_DFR_VER_NI        0
>> +#define ARMV8_PMU_DFR_VER_V3P1      0x4
>>  #define ARMV8_PMU_DFR_VER_V3P4      0x5
>>  #define ARMV8_PMU_DFR_VER_V3P5      0x6
>>  #define ARMV8_PMU_DFR_VER_IMP_DEF   0xF
>> @@ -251,4 +244,24 @@ static inline bool is_pmuv3p5(int pmuver)
>>  	return pmuver >= ARMV8_PMU_DFR_VER_V3P5;
>>  }
>>
>> +static inline u64 read_pmceid0(void)
>> +{
>> +	u64 val = read_sysreg(PMCEID0);
>> +
>> +	if (read_pmuver() >= ARMV8_PMU_DFR_VER_V3P1)
>> +		val |= (u64)read_sysreg(PMCEID2) << 32;
>> +
>> +	return val;
>> +}
>> +
>> +static inline u64 read_pmceid1(void)
>> +{
>> +	u64 val = read_sysreg(PMCEID1);
>> +
>> +	if (read_pmuver() >= ARMV8_PMU_DFR_VER_V3P1)
>> +		val |= (u64)read_sysreg(PMCEID3) << 32;
>> +
>> +	return val;
>> +}
>> +
>>  #endif
>> diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
>> index 18dc2fb3d7b7..3e92b7cb57a4 100644
>> --- a/arch/arm64/include/asm/arm_pmuv3.h
>> +++ b/arch/arm64/include/asm/arm_pmuv3.h
>> @@ -126,12 +126,12 @@ static inline void write_pmuserenr(u32 val)
>>  	write_sysreg(val, pmuserenr_el0);
>>  }
>>
>> -static inline u32 read_pmceid0(void)
>> +static inline u64 read_pmceid0(void)
>>  {
>>  	return read_sysreg(pmceid0_el0);
>>  }
>>
>> -static inline u32 read_pmceid1(void)
>> +static inline u64 read_pmceid1(void)
>>  {
>>  	return read_sysreg(pmceid1_el0);
>>  }
>> --
>> 2.41.0
>>
>
