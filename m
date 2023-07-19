Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F108758F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGSHgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGSHga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:36:30 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9894CE60;
        Wed, 19 Jul 2023 00:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/ywzUUEEnbFV/xpbEyr1TboHqisrn+QZrySIl7wJ+HcnmXblZX9HBjCLijngXp/W/HmjhdBgHsEIQy6FqTjALzafIaVcXtV5u2Xxa1fS/egsf+e9gd6uOG65LVyBCtqrRZGbK8e1T7pieBIlvkEqK6HW05qTMiY4paJACx0of2Ig4aw5WctuO7s532/PmC6A+nvORULSetKFOqJTAQGUc6Hkm6T+mYD1r6ktQdyO5kIQeNFkwBBCdtlf7GMySiziHIEsLptSjInEUuY3iuFf6NgqG/lYERW0nWSAqyJM0YO825HSjMNKWidlb/fY3KmkwT/XBG+QSseGfSyEbSYBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX1Mo6ejoRXRk5XIrhwUpzhYEBYeOIbkcFy2m3MyTeA=;
 b=Ww4PdeM6hpUC5Q3Lwgay4q24+xjtzMg7G8BMZlzSypSvroNRg7v0X6s+0nOFSv0g7Y8I1Uf1Yf3Cor24aJoiHxvi73sK9SpfsH0J2wVnmmHY4jrFnhwEVFgzBQcFn415+2hhV7Uj5Sos40YhmBeYtCLXIN1HtywZl4Q7/HW22yZhSjMQGguI5smnhXUk0JWicp9rSVBOkReHggVbEtAArHwEfUedk/TVYEvfxYE9G4+EoceV4eDMIvO2QmslCpsP5pemIT+mj9fqSRsum5WgSd+V1HDUJXjQiIEsOA40CleLG76yAwe099WjKgeKgBbTH17WHk6qcKJESzbmbPe+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX1Mo6ejoRXRk5XIrhwUpzhYEBYeOIbkcFy2m3MyTeA=;
 b=5DFy60IhCaNr8KM0dosfJA3dzk7/ckyrxWTCOVloXrEhdB17oBu6Gbfb60AIu1alpPRTq84Wfhv9VGwNx4hDvb9yvqtst6LHGmyFxfYaC7H40zAYK7RGAcab6wuVlOo9ox3nn5O8WEq+uO2/YWZKySH7IjE1PifxYuX/V8bIBIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 07:36:26 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::f535:4eb5:f7a0:ebac]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::f535:4eb5:f7a0:ebac%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 07:36:25 +0000
Message-ID: <b42e64dd-a404-7118-798b-f63c0a725962@amd.com>
Date:   Wed, 19 Jul 2023 13:05:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] x86/cpuid: Add smp helper
To:     Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org
Cc:     x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, eranian@google.com, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com
References: <cover.1689748843.git.sandipan.das@amd.com>
 <827723d8f506411700c68bccc5072ec8d918d2de.1689748843.git.sandipan.das@amd.com>
 <87v8egwe9l.ffs@tglx>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <87v8egwe9l.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0206.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::17) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b96af9-061b-41b7-5e6c-08db882adb2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkMcDbe3sOkcac2EOcjrLqPkj41ZKAzgbFOB5y3U2Ahm3kOvO2kr/DL03Rg9ooe2f5YTPawfXmRopioPAOYVF3/wR3vKsVPz8fB4tVefqOYK8n4ZKvs6Znxp4RneCJ/6iaA8wpm1MUwmn13orNGzbYVcAOyWLRXNIBFcaKvp/Msd8YVgtz4NG80Orhta9NHLuRIid4Kwbvpq/saA4UDkkjUI49W4pru1psF/sWUFBBUHzYZWgUSkd+SauyNRRQx0f1tnJ4BVyaLgVunrff07DqQeuooiEOPCp1gTnjHQTBroGV3Yoa68pxOh0Z5NvDC+eKaW/g5797rTeO4Uq9N1dp270svdJo4vYjqkVOpfWQXrrA3mc4ORs9ZkgsdpYfDNo496bH1QJK/N+zK3EqMyMnkFE5lQbZ9lx9m7esFbocR8iHxjmht4hVyQCjaKUI46EmuWRhWTSiUWRhOI7oKgxi1arcTzjMvHm7Rt4D0GMx6pUV0+WBvYvgKoYS7Osr0cttb4wwa09ECpsRpt73whjoDJwMT/dLlUYwFihBXxa5/Sp/At6B288EP1tJNjPjJ4vi7hyEBUdHSCCQ+4FCkomBeUgQkHooz1fpm7+Njjw5HotC8tzOtOldLGuaLOz4ZW3c4/uCJFfLSQvBRxK7HZfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(86362001)(2616005)(31686004)(36756003)(316002)(4326008)(31696002)(6486002)(6512007)(966005)(83380400001)(38100700002)(6506007)(53546011)(186003)(26005)(478600001)(2906002)(66476007)(5660300002)(66556008)(66946007)(8936002)(7416002)(8676002)(44832011)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3orTTRpb3U2MHVUeHVkQkkxZTcwL1BENU1lRCtVV2dya2dsTG4wVGkyRE5C?=
 =?utf-8?B?RExnVEVMaFNyRGtWZGtHWnlja1ZnMkQrQzdUS0xUb000RCtjV3RjbWRBd2tR?=
 =?utf-8?B?Mzk0OHJIZ0tHOGhkbkdWRjFuRFJ5MGhqUWZESkNIOW5Yeldza1VzeG9TL0Vl?=
 =?utf-8?B?ZnZnNE5RN2dabFBaalZwUTVEYUR6UHluWnRnb0NOd3NaQXRVV08rRkhnanJY?=
 =?utf-8?B?ZUdFaVN1NEkvRzl0UlY3aXNVbnhMK2tJM1RHSlFpRll6ajgrK2FpZE0rTUEz?=
 =?utf-8?B?K25mUERLSjJPRkhKc3VDTGRjMlY1cnJIb05BNDlBZXBNMVU4aDE3TjAvVUcy?=
 =?utf-8?B?Zm5SVkl5elZlRWNUNkdjS0VaQTdzL013UnY1anZKUUlZd2dMTUFnZ1p3aXpL?=
 =?utf-8?B?RWVDKzYxRS9YUHJZVTVLa3RQWjhNbEdoUlBXbFRUZGd3VkppUk1NMk5EYnBO?=
 =?utf-8?B?L1JyemQyYUxrMzJwTVh5WXk2aGdnQ29EVUxOWHFLWkFVck0wN3JJcmF4T09K?=
 =?utf-8?B?RFFYc1ZXRE5FVXdUNUVHS0ZvTm1ONDRCeVkyME5DNmZkSjRJZVFwemFPR3ZI?=
 =?utf-8?B?czJIWjcvdXF2TzlxdHhaUFRRMVBvb05mTngvazNrNDZPZWREWVNhc0JLaEJB?=
 =?utf-8?B?RmxReVU2ZnhXczJkSXZuM1FONjNEUyt0QmIvbXpyeVQ0Qk44ZmVNQnVRS01Q?=
 =?utf-8?B?Q0xLREJDeCt2MUNScUNncUZGSjVqRjNDT3Vsdi9UVmZpUXdDcUZMWFU3ZXhy?=
 =?utf-8?B?eWxscytSL3VocDZSRmZ6aEdwYUtIV3kxL0RtaEg2WU1WUzJURldCaFVDeVBk?=
 =?utf-8?B?OGMzNGY0VEN4VFJFbUM4WmJXWnFWVkdyQks1TzZaWDFsUkRqcU5uUmtKRG5s?=
 =?utf-8?B?UXhOME9TMEhMMTVUS1ArVnlDeVRweVo5TDBzVzd4Vmlac3JsK0NScnkzR29I?=
 =?utf-8?B?NExXOUF3ZExkV3ZZMUNuQmxwY29KWUFabis3VUhzbngwUVZ1cXJHZjhjZjVx?=
 =?utf-8?B?YWxONEQ2VXhsaEllZFBRblMxWFhpd2o4RkRZL1A3czljQk15VlBOUFk1UUo2?=
 =?utf-8?B?Q1pjWXhzWXRoVUlOSlNvVXdQSWpPeFVZV2FqVFRBeEh0ZnZqYTdGWWZjTmoy?=
 =?utf-8?B?R2lvVGVTVDJxNTZSMitMSi9Wb0xhcjVrTnBwOGZBdFdEaHhKY3ljZ0l1UTVv?=
 =?utf-8?B?TXFPVFJFTEMyRlNHZElNTFdmakh5S2E0Y3FST1FOVWJEZkRDTnZheGZST0E2?=
 =?utf-8?B?NjlITTFiZzhlSGJyV09RUUJjcVQ0bTlmN2xhNXlTS0EyQURPampuRXRNa29h?=
 =?utf-8?B?WGhmTnFKSHhZMVI2WXBlZmRVUFZPR0UvNjNCOHlhQlFLdnFUbkV2a1V0NUJp?=
 =?utf-8?B?K2JDRW85UjdEVmp4OGxWc2NrRVNnMTJmOFhVeUxsK2dGcUp3U2xaMFhvM0Np?=
 =?utf-8?B?blh0UGEraWhzV2NoeXBGUVNHMFRXTDZlMVBPS3l0M1RqNFBoK096eFdINGsx?=
 =?utf-8?B?S3VKYkVvTHBrUVlPQmVucDdld05KVDY1dGxVZVYxaGRmZjBsTCtpS3NrejRr?=
 =?utf-8?B?WVpkcjJXZllIS2tMY1JMYU1OSzZ3a1pZaitzOVE4MzBIZVlMakt4czE2Y1lC?=
 =?utf-8?B?ZVRjOEgreTlUcCt2R0F4bTBqRCtxbTc1UE56dXdOWDFoYlp5U3VVblFHR1ZR?=
 =?utf-8?B?S0Nuc1NabmIxTnMzNFhweWJWSlpZdWpQbE9UcDZDUHYzdHd5RUJRWTBwYXBH?=
 =?utf-8?B?YnpNTFh6aHE1L0JsbmJnOFNUQ1JsQTNUaVhJdXFUYUxnSjMrYVhTVks0cGFT?=
 =?utf-8?B?QnpaZ3hGc3hFVE0yUzRLRTdwRnNlWEs3R3YrMkxEY0U4Z0xGQTlqL2d1emFj?=
 =?utf-8?B?TCtrNzdvRnRQTStrQi8zb2duVitseFRCRHMxaU5Bb0JjcWNEb2taQUZOcmVw?=
 =?utf-8?B?TjFyay9CQkl3cUFHOUVteXdScVR4TWZBTW16OGoyV1c3TkE1d3BzWG8rd0pM?=
 =?utf-8?B?OENjakVRQkRGY2pEQzVFRUdIdmU5bnVVVWxsRTMxWHluc2l3R2lIa1VxRWw0?=
 =?utf-8?B?SkE2K3gxL1pkZVA0SzJmNUZTSzNTY3E2YmF5QUhMZXl2SE5yM0Q1cTBDSDVv?=
 =?utf-8?Q?9CsSCOapL2MOcrD0ln8H6oSYp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b96af9-061b-41b7-5e6c-08db882adb2e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 07:36:25.4857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZgsk6tnfFnsGIqymROKEe70nqpomDHy6sndno8TGLiUiRUaOZJG5DUu47eI2Mek5Woitdg91Yxh5RcKplFNEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/2023 12:59 PM, Thomas Gleixner wrote:
> On Wed, Jul 19 2023 at 12:25, Sandipan Das wrote:
>> Depending on which CPU the CPUID instruction is executed, some leaves
>> can report different values. There are cases where it may be required
>> to know all possible values.
>>
>> E.g. for AMD Zen 4 processors, the ActiveUmcMask field from leaf
>> 0x80000022 ECX, which provides a way to determine the active memory
>> controllers, can have different masks on CPUs belonging to different
>> sockets as each socket can follow a different DIMM population scheme.
>> Each memory channel is assigned a memory controller (UMC) and if no
>> DIMMs are attached to a channel, the corresponding memory controller
>> is inactive. There are performance monitoring counters exclusive to
>> each memory controller which need to be represented under separate
>> PMUs. So, it will be necessary to know the active memory controllers
>> on each socket during the initialization of the UMC PMUs irrespective
>> of where the uncore driver's module init runs.
>>
>> Add a new helper that executes CPUID on a particular CPU and returns
>> the EAX, EBX, ECX and EDX values.
> 
> NAK.
> 
> This madness has to stop. The correct thing is to parse the information
> in CPUID at the point where the CPU comes online and store it for easy
> consumption.
> 
> I'm in the process of reworking the CPUID and topology evaluation and
> that's where these things need to be stored. I'm still fighting some
> nightmares with the already existing mess.
> 
> Look at the mess people created over time here:
> 
>      https://lore.kernel.org/lkml/20230717223049.327865981@linutronix.de
> 
> No need to add more insanities to it. IOW, this has to wait for a week
> or two until I settled the remaining issues.
> 

Agreed. I'll rework the patches and remove this.

- Sandipan

