Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE1F7D8CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 03:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjJ0BRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 21:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjJ0BRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 21:17:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2122.outbound.protection.outlook.com [40.107.220.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A318B1AD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 18:16:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3nu2a/8N3NHwtXGFLFbOmz+0burUocD8hgeEIAgRlfeIK0ZVWdHgGB1Q+Cr1urDUEWcJDJTOauA9+AjeCPYDXyyuR1EMow7WYPSvcbS6PtnGfBs67da3Bn9kHgMOHSYt3R/THGILwVgWqHX4KMP8Zb7WOTHJwBvrIrKQ10zNewgAqDEmHJugrbIthrrvuoLcLcfDLgV1eq9BPwxG5xWvzTCmH1UT0Jy0uI6rAoJRhpK/v3Pvsy9+BhZkqhBOBCoSqwOs882prM4c2t5yyx+7TJHIcHrxCqA6uyR1fff7vbSq8l1Z5YzpjFpM13m6kqTkSleGjiaZmBxxBdCAungVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6wZGzc6fNHnSrNUKoLecXCZSY1gTHT4/UrLzQzJ6Ok=;
 b=X9XvCpXJ9JfILH0iLVbgL2QM4eIkW/ahynrMp7j9wmyQLhAPw+5lXHS1omRQDPg7C+OsiO2vcmh7RSoyGRi0lr1dgINFSYCMqRbECZmcG7ZoGpL5BUASbQFmSYH26IHQxE7sYE93rBrRdXVHW+EUyXkF70QtmbhELuXdy4IrRqqpcAyEi/Rh7wbRbrMIdxThlwx8EWfSIlPNxbnu/ijcw74rysxIcW9byMq69XiFuMJCJsVBdyqv9QhzmzCo9O3TFzt1SMIRGms3PUJa6H1krZQN2f6TKnlS6HVHmVXGq3J83iXMP98Cn9Q1/ui52WT1pFOICCk7izArob4LlHRGdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6wZGzc6fNHnSrNUKoLecXCZSY1gTHT4/UrLzQzJ6Ok=;
 b=RSxpHefJa/sw26KDv0topvF6W7oYUjQVUyJ/O4fMsLmcYmt41NEoy0/kHOz49P+bawqqDcdgsNQAdnPGLfwWKdY+zSn7rcr+DpxvvWkQC0mpMUBdq6VGLFia1aCZNNKzhX8PRg050S+81iRAcWdzm/dswdy9M1Il27PKuGpugEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA1PR01MB6527.prod.exchangelabs.com (2603:10b6:806:187::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.19; Fri, 27 Oct 2023 01:16:55 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 01:16:54 +0000
Date:   Thu, 26 Oct 2023 18:16:41 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Marc Zyngier <maz@kernel.org>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Zaid Al-Bassam <zalbassam@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: perf: Don't disgard upper 32 bits from PMCEID0/1
 registers
In-Reply-To: <86a5s54s0h.wl-maz@kernel.org>
Message-ID: <5dc379a0-9068-8bec-1f28-afa7cb557c32@os.amperecomputing.com>
References: <20231025200815.104017-1-ilkka@os.amperecomputing.com> <86a5s54s0h.wl-maz@kernel.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH2PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:610:54::19) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SA1PR01MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 3637143f-f829-4cbe-21af-08dbd68a6708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5UwAPUfKNSiwUtU/P2MPgtZK4kwMBhs0NaYYcJB7d4ZswD0x9ydBNcSQTu2003tCW79uLzqpyzCF5eO6LhVKrFp1IfmA5TZHq9GCZSGGic0b2EZlVxLfr01t3/cPInRTHsIjgUs0HFbRocpJSNJYmNpf9+0yyfMw8Ux2F18Z4AlYDjd6OCgkm3c9XXgdu2jxdxYiu7Tf8K1Tl01IWxz1tQEgI9djejwhg4ZX0X7iDPlIgInniPVYNdHQd8zLtmawMOanSnlQqccsbIuM4vBYXvowsENlfUpddFekSBBCL3Jp6Kn4VsVGkc+5LLP9+u5hxsImXJPQfMJi48G4NTqd1B1gowO03T0bx6aM99KTmoMpMwBr/2VsFyl14HLMWI/snw8aMbd3QkqSq7EPUgHnah+d/8LQz7+1brqyazJ3udWBBsG//ARvLdYOH82X1B6tPhYhRovNl9MOFLy5PppGE/aomiEty5/E+UdnDQLhaUlrvYTO0imPNH3j/F9ZLL61C3yXW05XqMKvt8KlzlpBKeHwsCy5zvT2LLi3lW14q/9ggHGgz+iSRvqDfjPGEZ+lZdEirhc03razR5I16sApid6Sun5h8ujNcSLPONl0fITzVmtZqGSf+nVYDyoiQVx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(396003)(366004)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6916009)(52116002)(6506007)(478600001)(2616005)(66556008)(66476007)(6512007)(54906003)(6666004)(86362001)(6486002)(66946007)(316002)(31696002)(26005)(38100700002)(8676002)(83380400001)(8936002)(4326008)(5660300002)(31686004)(2906002)(41300700001)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?82c79eNyiBQimPSt3wafRD+iOEAX3DLDjIatCb6wrbQwKBo0QdT02OxWG4I+?=
 =?us-ascii?Q?HwqkHxQGAAI9Xs44c3vCZ/AA6ioaizgO2Hzl1FqDV8hyB+14kVvcc6uhtnsQ?=
 =?us-ascii?Q?FeMqPFL/w1jV0e+jzG3mKmVnD+cmGDvpb8Lg61u1gQPaRfdfIElXRhNiZLpJ?=
 =?us-ascii?Q?E0oScbSNFoMhItruhyWEeANkzI2qiebPa0DsOPth7FYlIepkJD1KaIXDmWyJ?=
 =?us-ascii?Q?zJDo8rVYK7X5QpD2hKYgUGi+qA1ohlaMVjATmmuV3udN8RbqJglbGJV8qtQ0?=
 =?us-ascii?Q?j9mUM9gp9tM43pgnnrL4GUiDeseEfhNAqS/Bz85LZ3MM4JJXwBDWx2X4015m?=
 =?us-ascii?Q?XwhknmQUJRndCicuwco+yo1hvdmd1NGas6oePYL60y8e+M5S2/9d6IGO5AJ1?=
 =?us-ascii?Q?wI5BBoWqKPWfrQbgtk0fOgd2Y2w6RU9iRTTxxJnFkBCNLmZ1SYBUN91ryaIc?=
 =?us-ascii?Q?uc4p2DOSgVc6Cg2MNXxT0DMydpdJ+mvPh0LZ7rqT9DVfilraqIG+g4vXyWbG?=
 =?us-ascii?Q?WNe3NborpWFc4ei63CdK4QZYPtwxDhHeN4ADNxJoGStYjF0iMeWyfXoLV6DM?=
 =?us-ascii?Q?E2vilMEBwLlL+WpUXhCBYxE4fHPkqYeUHRjW2ES07jjWU2FM+ENc2UJ9C8qg?=
 =?us-ascii?Q?7Gb21VB8dbsYCeZeGMdHzIqtKEVLssDvxOWpxiW7lcedCKoa6L45ORvlJST1?=
 =?us-ascii?Q?toVVcJQzEfPewDSVxmJ84EHQSJdQeK5I+JP61cC1tU/5pqGD5Okn35gZgKlK?=
 =?us-ascii?Q?5ul3fDtc3HSBcHrbGVG7TxpPOLZQebwi5pDsyfv4z4WDHrQ+P1D+JZY1p5Hl?=
 =?us-ascii?Q?j9BtigHNvtiRd3TvtEJnImxEp2RU/rmhyEZ7GDPf3gfToFdCbaZmgdZ8hgjT?=
 =?us-ascii?Q?lksd+nIhLiTaKGsr09mcBVzn4xy6ZKsjzs9PZm9EB49y1nnwo9w7ze4BKHYp?=
 =?us-ascii?Q?sxhjYB9gBJXG8+1B5fSt5B0jbGlzvi+G6T944lojfY1p+qdTQViKuV5q/OHC?=
 =?us-ascii?Q?y9Q4eX4AhFsZ/A7phJt0XR4Fdv7kAyyIdHLTZ2po8oqgkgKzxy6hLjNUPrkK?=
 =?us-ascii?Q?wgkq8ok5NwiuJQELYuKvnUnEvlrFEHGE78R0gEUECiigUXrP23O376uM008S?=
 =?us-ascii?Q?AU9G0atv9aTaq3Vib2zii3hL8Ne4YQ5REKu9NccMB19hCmzOvj0fo+ZxaRyb?=
 =?us-ascii?Q?K91drPgEvEkaQeVndEAXJsawJc5mm8wQkxE6WRXpbjL7Z9jLmI6x609Pj3/p?=
 =?us-ascii?Q?HH9OpYtAeNJseXYz2c0MlhgZBQ8FFN79cOZ3/e/PbjDtW7oUtYqDFO6HeIEQ?=
 =?us-ascii?Q?ayz5QMwhwXFob6tJFPHBQ3RdGkEnlPkH6u5Am37/OfaweHsC5BhRSIvldsSg?=
 =?us-ascii?Q?5AfHie9TUfsYgR2cY/fWtoR9QAPHNxbKmKolELVe1hhrKFxXw89UCp6fpcT+?=
 =?us-ascii?Q?vzVgnQiyxmUJNVgf3xXFkoXY9YfeqxC4HO6pmtHTZ+dTGZpQ0rSOQF3hfjdV?=
 =?us-ascii?Q?OQCiKlyzdT7S6KmO0kluvhLFnyV/dJFM+bM5OJqrb+mGk/nvjW98HMhCo64l?=
 =?us-ascii?Q?cZoidKdLdaWCuP54uKoPdZLxon9vdsgBkDv5KeqndNejBi6CY48PSXrhTnTs?=
 =?us-ascii?Q?eQ191nrWLRABXfddr9ldtt4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3637143f-f829-4cbe-21af-08dbd68a6708
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 01:16:53.1673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETDJ4h03AuVbaZjRezqaPiqKnU4nIvLCcy3MKxaBDWFfWWb7wsCG9EE2TVh4RtUFp+Lkzdj5umMCzUAzynizndF0jueN4avUp2Xtiuu0ZrUM/2GM+LGZqhLUmH19AxEr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6527
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marc,

On Thu, 26 Oct 2023, Marc Zyngier wrote:
> On Wed, 25 Oct 2023 21:08:15 +0100,
> Ilkka Koskinen <ilkka@os.amperecomputing.com> wrote:
>>
>> The upper 32 bits of PMCEID[n] registers are used to describe whether
>> architectural and microarchitectural events in range 0x4000-0x401f
>> exist. Due to disgarding the bits, the driver made the events invisible,
>> even if they existed.
>>
>> Fixes: df29ddf4f04b ("arm64: perf: Abstract system register accesses away")
>> Reported-by: Carl Worth <carl@os.amperecomputing.com>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>  arch/arm64/include/asm/arm_pmuv3.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
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
>
> This is necessary, but not sufficient. You also need to update the
> corresponding 32bit accessors to match this behaviour. Something along
> the lines of the patch below
>
> 	M.

Thanks! I'll add your code to the second version.

Cheers, Ilkka


>
> diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
> index 72529f5e2bed..90841cb7ce43 100644
> --- a/arch/arm/include/asm/arm_pmuv3.h
> +++ b/arch/arm/include/asm/arm_pmuv3.h
> @@ -23,6 +23,8 @@
> #define PMUSERENR		__ACCESS_CP15(c9,  0, c14, 0)
> #define PMINTENSET		__ACCESS_CP15(c9,  0, c14, 1)
> #define PMINTENCLR		__ACCESS_CP15(c9,  0, c14, 2)
> +#define PMCEID2			__ACCESS_CP15(c9,  0, c14, 4)
> +#define PMCEID3			__ACCESS_CP15(c9,  0, c14, 5)
> #define PMMIR			__ACCESS_CP15(c9,  0, c14, 6)
> #define PMCCFILTR		__ACCESS_CP15(c14, 0, c15, 7)
>
> @@ -205,16 +207,6 @@ static inline void write_pmuserenr(u32 val)
> 	write_sysreg(val, PMUSERENR);
> }
>
> -static inline u32 read_pmceid0(void)
> -{
> -	return read_sysreg(PMCEID0);
> -}
> -
> -static inline u32 read_pmceid1(void)
> -{
> -	return read_sysreg(PMCEID1);
> -}
> -
> static inline void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr) {}
> static inline void kvm_clr_pmu_events(u32 clr) {}
> static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
> @@ -231,6 +223,7 @@ static inline void kvm_vcpu_pmu_resync_el0(void) {}
>
> /* PMU Version in DFR Register */
> #define ARMV8_PMU_DFR_VER_NI        0
> +#define ARMV8_PMU_DFR_VER_V3P1      0x4
> #define ARMV8_PMU_DFR_VER_V3P4      0x5
> #define ARMV8_PMU_DFR_VER_V3P5      0x6
> #define ARMV8_PMU_DFR_VER_IMP_DEF   0xF
> @@ -251,4 +244,24 @@ static inline bool is_pmuv3p5(int pmuver)
> 	return pmuver >= ARMV8_PMU_DFR_VER_V3P5;
> }
>
> +static inline u64 read_pmceid0(void)
> +{
> +	u64 val = read_sysreg(PMCEID0);
> +
> +	if (read_pmuver() >= ARMV8_PMU_DFR_VER_V3P1)
> +		val |= (u64)read_sysreg(PMCEID2) << 32;
> +
> +	return val;
> +}
> +
> +static inline u64 read_pmceid1(void)
> +{
> +	u64 val = read_sysreg(PMCEID1);
> +
> +	if (read_pmuver() >= ARMV8_PMU_DFR_VER_V3P1)
> +		val |= (u64)read_sysreg(PMCEID3) << 32;
> +
> +	return val;
> +}
> +
> #endif
>
> -- 
> Without deviation from the norm, progress is not possible.
>
