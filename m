Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA33811740
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442186AbjLMPgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442739AbjLMPgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:36:04 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E69118F;
        Wed, 13 Dec 2023 07:36:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XunH6vM7tPSdoLa0yHYHcbVUWkBEcDFBTZ3POi6nwVc0znwQjCTQJE7JiTLi8pCCzlcVRzLfl2CJWzayKd+j1oH7HO67LeEZYZUlywsfwci+x5Ssf7elOSMbAkU9oF91XuC8nDj0eeSt3VSMet2JqFotKFDB4bgqI1JTGXJ0MrfZQWtt1qusD87cWQwq8bb+vLCmpoITFGfKD0+rmPOb1AxQr5C1kERfo0MROKHymXgkkB5oGXr0At0Z4VgwVkMFNJux0FcXGhrZ2loQWyJK/A1MkYiGtd5rBHYiZdVDbqoxKPOvikm1KGzaQFMMTmkdMueBtNATEcduh6x66SyH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXvqZBTx51fuatWuxoIpMitVtqmQ35mWBajggSMVEy4=;
 b=UNb5+htHTMew6jr7P04Zvo2QbdT5foQJ/wSf7DqKlYV70xyLb+zfdxNrza0pGkcKENB2YelE6Np9ds2fs9GO1kEd5Y7OqsN7L4UvRir4NDOjLHeIAVvBNyFo21rovbyjypmL8RbAi3Y8pyVYViTpEEGfbvslS67grP79MWuDTzhCb2wzlVgf+i6YPu+Ni9g7K9G79jIRi1zY0fseJ4TSw8EBEbQYvoTB7iZ9neVdgs8976cZdYw9w7DmvbrQMY7Bz6UXVrw3x2mX/83Rtqh1yU/EqOkYv43kbMd8H84UaXxPxpdzPT+EmcHsPPzRkUePn7jH7lIbVnpL898jZO5Fww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXvqZBTx51fuatWuxoIpMitVtqmQ35mWBajggSMVEy4=;
 b=oJ3YchJ26cozXvt9xUrC8HXfBLjM1LQkiE1EZ+qE9XBNTXIXnu1mpMUUfdM4hsyU29DU5ja4Ejr92yq1V1M4wLJtgvpL7QdQc3wdhscIw1Iw5IiBhA5LUHAZuQZ/3EW5VAo+3NqpZCANJNEsPMYrn+t2cGXl3guHi3qFGq4Flqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 15:35:57 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0%3]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:35:57 +0000
Message-ID: <b9beb435-30e4-44a3-b27d-0567a8e873bd@amd.com>
Date:   Wed, 13 Dec 2023 10:35:55 -0500
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        avadhut.naik@amd.com, john.allen@amd.com, william.roche@oracle.com,
        muralidhara.mk@amd.com
Subject: Re: [PATCH v3 1/3] RAS: Introduce AMD Address Translation Library
To:     Borislav Petkov <bp@alien8.de>
References: <20231210194932.43992-1-yazen.ghannam@amd.com>
 <20231210194932.43992-2-yazen.ghannam@amd.com>
 <20231211195739.GIZXdps9DNvOgCR5Xs@fat_crate.local>
 <295f3cc9-6140-4813-b107-8c8b60f8aaa1@amd.com>
 <20231212153449.GEZXh9mSJ5epD13Dp7@fat_crate.local>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20231212153449.GEZXh9mSJ5epD13Dp7@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LV3P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::24) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: e98bbea2-5a27-4633-dfff-08dbfbf1334e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ivo0zcJHi/HCdOVFnXnlX7XjuuBUIvbhCGDgHt/H8jJRU8efujJXtifCONTAdXpUsgNx0yyOt35GRWGN5h5DxDu1sy/sM/k7AUDfq/jt7+h/HtXOde2SAZZ9J6jPlSM/rZ0ANOkvhp30rDDrOolLMY+TW4tEn1LPm5olZOxZKjNRYFLiZ1XGsecM7ApEMGmr5X/9D0mokQKSZtEWZigfvpQBrvOAAy+CaEuNEjlz0IJiUdqJvy09itW0YnMVnZx83smB9TRFKWZw0KwNO5BDjKDtVovrRv+vhfb2G7yIGR2lGYqxCOO4eaNg9a73O6WrFOO+xBMbydjUL1UzVQckpv9OPQ4qj2ohKIoxZLRGTXBt2i2CdtMTDHkw7h5c+Nn6I/XDsM+IwDpODOzh1AtBg2YguPj/U7bNd0zRbA2E9lGvHTP2reufH7TPi8bZunZSlLBt736mnJibHbVe4IEXfZasGC3nMEpkysvmVPd1uxDMMTX8pt05HQW0BIc4wtKXAw5KflqjpG2f9Vr2LSY/Xnk8dl48VBCMWsFbJsUa1G1e5lNkL+zG4fhoWGlEiaYDO5X1sC61mEQj1LkLhbwmtMuZiiRrA+ZqGIMnuLPOeXu8tc3hwszupF6vhqTCDnwSkouqgMHqlM7xcnMTvN68X6C7E/I+P3fUG9gLS1qxhYRCFPCHb4MsE3rCTX+7n96W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(396003)(376002)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(31696002)(86362001)(41300700001)(38100700002)(44832011)(5660300002)(8936002)(8676002)(66946007)(53546011)(316002)(6916009)(66476007)(6512007)(66556008)(4326008)(26005)(2616005)(6486002)(478600001)(6506007)(2906002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eitVME01RllIS2l3QVM3bmJNcmhGand0NWN0eTZmT1NvWk9NKys3Y1JFeEt0?=
 =?utf-8?B?SkZWcERHVitwQ0FsaS8xN0Zic2lUWXNyaUtQckRXMkwvWnJWK2tGd0t4Qzhz?=
 =?utf-8?B?d1QyaXZabjliRGdWYVNmMjN6RjN1MFNqOUk5K3VzMEN3TjhCRmlvM3ZWd244?=
 =?utf-8?B?YytKNGxOcVFRYm5CcWp4V1hIS3hxOEJBNTV1ZTNZVkwwcVY3Y2JHR3h3M1Ix?=
 =?utf-8?B?ME5JY0N2NUVWREtJdlhtUnFzSzVCS1RuVytPelIxeFBvaWtpcmVyMDFvSVNt?=
 =?utf-8?B?TGtMTVYxZ3VsZmlmMzk5RXFVY0MzVlE3c3p4MUhBanRrMjY5dGQvMnBxVVpr?=
 =?utf-8?B?cUk0NDhMVVZhSVZmdUtUSlZNRnZOWml0U1RrRk9NNlNYeTM3WVdwcEZzZ3lL?=
 =?utf-8?B?SWVEdEU0RlFUQjNUdHhrcFR1Z3JDWG9xdG5RM3FZUVFaTmdzYjlNSjhPbDNz?=
 =?utf-8?B?eTlOL2pWWFRjMkZEaktYbDVnQ0IzM3N1d1VJV1l1RWw2UDh2NC9tdnNTek1Z?=
 =?utf-8?B?QmpJYlZ6NWtsQmtsd3RWTjB5UStlcU5MNFN4THJaeUdWSSs3Y0hpZitNZGpY?=
 =?utf-8?B?alJ2MXZPdWtJQVlIeU5lWDBQbUxyV2RuOWlxVitOS1NTcG1oRVVpM29KNm4r?=
 =?utf-8?B?alVyYk9TVjBSTnNoV1NBVE1DV1VRN0l3ZGloTWJlc0lXS3FwYmJXbjJQOXRS?=
 =?utf-8?B?YWFLU2lmOTdBd0FiaHF4MU0yRGFYMFJIUmtwRmdNUk1qdVJWVzlsMnRSK1Qv?=
 =?utf-8?B?ZDlSdFhDUE9zSFdGRncxeWNRd0VaQU9MWHdXc1JxUHpiUWl3bzlRQ0l0S2NU?=
 =?utf-8?B?b1ZpL01kTkpuLzF2TVRLRHBXRk5aSU9WWFBaTmRrNnlrc3hwS1JyL1dNaDFw?=
 =?utf-8?B?MHVNcWpXSjhIQmVOUE9DQ1huNGZRTlI5UlRSZkU2NnpyWWlaWmY5WUpwTTB2?=
 =?utf-8?B?cThjcENUUFBtejFuMHRmZjdxeTMwV293MHp4Q2Zad2hOUXNUcmE2eHJyZk5H?=
 =?utf-8?B?VC9XdzNHcllYWEJNNTkzUVRQSG0vWlUwc0tUcmhJSi96TDRmVmpzdmRxbnFw?=
 =?utf-8?B?ZkNRUzZkODNldGxTL0MxaGtaOVlPMTc5VkVkQXFHRTYyM01aeWN3aDRGUzBD?=
 =?utf-8?B?TUpDSnhQOUgwS2x6Mys1azBMTjRYdGdLRXAvQVVKdUwwRVhiZGRRWkI2NkQr?=
 =?utf-8?B?dlJURmRVbUQrNWpucmk5Z05oWWcwQWJ2Yk5SN2c3b29LZVlwWXMrME80WnZ1?=
 =?utf-8?B?amJWODFrWTJDams5ZXI4NjBKTUJjRjNuOU5Wc1NPa3dPMFJQaGVCYU1zV0dm?=
 =?utf-8?B?Tm41Tll0WGhxRmpCRDhhVFN0ODJiQWxkc201RWlJbWpPRHAxUThJRWdkcDNh?=
 =?utf-8?B?SU8zTU9XcTROOG1wZGlFdytjKzJ4OVRFSUdsU3NoRWFkUmx0dkY2YTJRNzJ6?=
 =?utf-8?B?aDFDOEZMTUk1REd4aHJkY2dPZWhxLzhRK1E4dGFxTVdxRDNndHJYNHEzWkhv?=
 =?utf-8?B?Z2FjNXVmWWZ5eXIydGVUQTFkRXduWGJaSHArd0hoTFZoaVdDczc5Ymh4Zzh4?=
 =?utf-8?B?MjNFbnNxZUt0Q0hacXZ3elNqckVhMm1PcU01SFNwQTIvS1pzejR4QlJUZzFV?=
 =?utf-8?B?RnBNUCtnWjFKNFdYWEVSZ2x5RWpxeS9qb1VncW5PeUFIbjFVb0FtVTNDbEhq?=
 =?utf-8?B?R0xaeDMvME5lV1o5SWY1NzdDbkZIWDEvbkx0b29heUFXdzVCaG0rS1RybTl2?=
 =?utf-8?B?WDZid0ZEU2FhY005TnpXQUtqYmhxaVYrRkRUNFR5Y1NDckxxcW1xcklpK2F2?=
 =?utf-8?B?YTRYUk9GMndmdytVMHNra3BEV3Ewb0V4dkRQamhrSnpOU3oxZlRxOXNtbVVz?=
 =?utf-8?B?cGZRMWxZNzNXWUYzWnFHcTluTkl4S2lyWHZtKzdmem1WRGxZYmtveGVQbkpq?=
 =?utf-8?B?RjAzOWkzUm9WUGk5dWcxTm45eTR5RVpscUZVdzQrY1BGMHhmNktyVFRzRStN?=
 =?utf-8?B?cjVVUmdZSzE3WDlPYXhMdEtDemMvMDZsdS9BRVoydWhzbmU0SWN3OUlMS21a?=
 =?utf-8?B?bSt6NGlUWFYzSmtITFVvWGRJWlcwamxYeXdEY0c4QThHMDRwM2VZM0Y2TVNN?=
 =?utf-8?Q?Ok9NBPQSfHTQoetHC58+IiZk4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98bbea2-5a27-4633-dfff-08dbfbf1334e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:35:57.2236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oh3wQJxzgFPjpOtIDZrD8CtdOQE/V08uB0psAuUdIZocbGgEm5BSKV9qohlHv2oqMcDt0iiHh1i4sC969X1SiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2023 10:34 AM, Borislav Petkov wrote:
> On Tue, Dec 12, 2023 at 09:23:44AM -0500, Yazen Ghannam wrote:
>> I'm thinking that the warning only happens if the "assert" condition above
>> is hit.
> 
> assert usually means "assert - abort the program if assertion is false"
> - from assert(3).
>

Right, agreed. In this context, the program is the translation method. 
But yeah, it doesn't make much sense describing the kernel. I'll change 
the wording if I don't drop the macros completely.

>> In older revisions, I had all these messages as "debug" loglevel. I don't
>> think there's anything a user can do to fix these issues. They're either
>> coding bugs in the library or system configuration.
>>
>> I'd rather go back to the debug messages if you don't mind. It's not
>> difficult to enable dynamic debug messages compared to DEBUG Kconfig
>> options. So I think it'd be okay to work with users on this if they
>> encounter an issue.
> 
> Makes sense.
> 
>>>> +static const struct x86_cpu_id amd_atl_cpuids[] = {
>>>> +	X86_MATCH_FEATURE(X86_FEATURE_SMCA, NULL),
>>>
>>> I'd expect for only this one to be needed, but not those below.
>>>
>>
>> Me too. Those below are to workaround a current module loading issue. I'll
>> add a code comment for that.
> 
> You mean the systemdoofus crap?
> 
> Fget it - we don't fix the kernel because luserspace is nuts.
> 
>>
>>>> +	X86_MATCH_FEATURE(X86_FEATURE_ZEN, NULL),
> 
> ...and those are influx - this is called X86_FEATURE_ZEN1 now and
> X86_FEATURE_ZEN is set on all Zens. So you might as well match on
> X86_FEATURE_ZEN only.
> 
> But you should not need it - if SMCA doesn't match then we have another
> problem. ATL should load on SMCA systems only.
>

I agree in principle. But I don't think it hurts to include an 
additional line to avoid the confusion when the module doesn't load.

Also, the SMCA feature is used here as a short-cut to match on systems 
with a Data Fabric. We could use the Zen feature in the same way.

Thanks,
Yazen


