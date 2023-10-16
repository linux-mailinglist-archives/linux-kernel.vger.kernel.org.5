Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0941C7CABEA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjJPOrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJPOrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:47:19 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36F3B9;
        Mon, 16 Oct 2023 07:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFxyzv+9XOBDUp5k/BvwdzOkMwiyrOYW7iMN0zPPjTVkPL42dVzliddKrjEr2qUppaAxNL7qYEjDvcGCLQAPi6nVr3xsTaf+ijlKzOYw+K1UjlaQBAIHo5Tk/oLRlGocpsfv9xMRobdWKXOtbWaIqfbFPni4hlLJLxFIS/Byis6Btag9rFDrQxXdhylZ9ym1+z2kGWkP4twDjGTLKJGxF/t5i2UyWaGdBD9VbS9cvWWjxTpIoywngYcajbvD7N5z88NjXITzqwAo/531ldYCVbHI7ryqDQm7weQC9Kx3ITjp3dDbxGh5rK3zjHRVoM2zTlfSLesCN9xEYuCcla9OvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tji08nhN5uQ30eiwaAHUbOXqMzL/ARUXhtFwSMyeAmk=;
 b=Z0+KyOkyj+FJKZkrEkQ7M9tGD5nTB5mghCSoXNpnmMN0GRmC3zU/JF38fIyaHzsLVPCuJOfuzAlCgNbIj05UPuTU8j/O6NONHqY1xm3DGMNFpAiJVZ8UUsVzBVRImC92+/IeHREYs5s+1yVdTSJZnUtJRsyZ0yHlZPt6dGbAvk3zCDrqrVJ1vcHYG4IsBe5F9TBByQPf4/msbI/SNAOSqkMkGMkYiT8gkXgVIU7ga+3kEikXoqkebnQTLaGo1AqWvEtJJfBcLJSyNKNXfJVZhd7zkZPC6SDwwaUMme1zvN45ownqYCIOOsupLoKDYtfVyVCy3glmdoG35Axo01iLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tji08nhN5uQ30eiwaAHUbOXqMzL/ARUXhtFwSMyeAmk=;
 b=wpCVqwBhOvl0pJ6zovZXtEtgjOJanHfgMy8m1kR01uO4CSMtaJ/+/tcesWTgOp4i1sFXgP+rtQiHkfsc57eWf9bIDCDM/4tgFT3Xmadvmr0tFYz1I8Bv9effUS5dsDO/JXgaTU5hHRbmhKGxYg5XKNKEcCLIQHK9t1w3UEOVWwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 14:47:15 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3043:e5d2:42f4:a231]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3043:e5d2:42f4:a231%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 14:47:15 +0000
Message-ID: <dc57436b-8483-4c50-a7a9-0f895a494ada@amd.com>
Date:   Mon, 16 Oct 2023 10:47:11 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Increase the size of the MCE pool from 2 to 8
 pages
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        "Sironi, Filippo" <sironi@amazon.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231011163320.79732-1-sironi@amazon.de>
 <afaef377-25e0-49f6-a99f-3e5bd4b44f87@intel.com>
 <EDD08AA3-C404-4DB6-96BA-2B25519B2496@amazon.de>
 <6591377b-7911-444b-abf9-cfc978472d76@intel.com>
 <1c598798-5b28-4a17-bf86-042781808021@amd.com>
 <dd72296c-def6-4fb3-9984-348641cdb6a4@intel.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <dd72296c-def6-4fb3-9984-348641cdb6a4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0042.namprd04.prod.outlook.com
 (2603:10b6:408:d4::16) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SJ2PR12MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: b90e4125-992d-4b26-a2b6-08dbce56c9c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZE6M2myen1BrRlbrpai34lONbV1jBvoQjesCErJkz/Wx66UtITc61v3Tkd5B32AyhwVQuZNPmWdbDOOApTmbdXq2SGpxlVg0SwFqAAjzTEVWFPadMGH8GPEqToLEE2Mepkghfvw1ue6qMUvIQpXVQAW8N1ZwGLM1Fo9msjYS/5T19unKr3wYofWsZx6uh2oLUbXD+CjULXrRSvN6thziiw+QH+ygR65R5J+Hdd5rIrgqkIhcfIZv6L/lsYUqSWkBmfMgA5iimBlEguKCyat/EmotyEODpRoi3smzVx7R5GxSpe7Ik7y0+uGDLXGDHUAUYp7YUcVfDs87gj9OiygnRvUFC9w91nPQCCXY68lYOtric98vtyqbsyYampJcSaFW8nnimmY0d3zdH+h2gDNdWBHj/Uz39g4eCr/e1gPfTfvQYVWzLilhkYaCzN7Ul8P79vUaX+a5v9RAadSTGW2BUQkfmZAAg+rd+B0Owl6yX/pufWaEdYQauK8EXzvL9qLw8aa6O64VRsxwY3g5K6tvRRgI3c7eiMvJnrM9WDVvr33FqGdRZD2ZtcW57S//1+vh4bY8y8wXaft2xb5c/NHAUdicSEQYLEW3TEmRgYiOSVPZprYYWJuhgMOWFTqDvo/pka90k1Oc8St5a9Tz7ckPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6506007)(53546011)(5660300002)(44832011)(6666004)(2906002)(26005)(36756003)(2616005)(83380400001)(38100700002)(86362001)(31696002)(6512007)(7416002)(6486002)(478600001)(54906003)(66946007)(66476007)(66556008)(110136005)(41300700001)(316002)(8676002)(8936002)(4326008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGJNYkZOQ280UjZHdHdqbUY5cElRbE1yeFE3akRybVB2b1lYVU1iZzIrU0tO?=
 =?utf-8?B?ZEVjRWNkb05xUjJlRTlycjBvVE1sODZ6Ky9DazFNNTZYNEFXK2tDbFZycFpi?=
 =?utf-8?B?WFNqbExjUmhuYlczOEVhOFlxa003YXp2cVFNV3ZWMFdoSHA2QllmY1ZIUFht?=
 =?utf-8?B?ZUVXMURrUzlCQXJaR1d3YTRndnVVVGF2NktJY2FoZnZOaFRhSlVWSVdROSt0?=
 =?utf-8?B?M3FxOWhXNk5UcmE2QUVhTk94NWdTRVBEOTNIU01CTC9qRHk4R2NmdUF3UW5O?=
 =?utf-8?B?MTViTTNOYkVEbVR0UGJzZTJGRzFuM0hQRFZOZTlYSGMvU0I1UHVmSmJZc3Ew?=
 =?utf-8?B?L09rL2FxeWF2SHBndDZxYVFFOEtuOEpVYm8rem4rWXpKdXdrcjJXbGxCdmFk?=
 =?utf-8?B?bi9Lb0xWODhaR1RxMmNFNlhoNWdzbloybHdiRmtneUZ5N0Q3eHd5ZFdTbnh5?=
 =?utf-8?B?dWNsS082Qm9qYTZWNHJyQVR5c3FGNGxTSFVmcGxLU3ZJa0ZHbnJ4VVVBeElB?=
 =?utf-8?B?K2hZQkxHdUNLMElNcTdKcm90VjloUmFVcXFLWm5ibHJ0cTNudVJ3WUVUQjFx?=
 =?utf-8?B?TjVyN1k0S283OS9OTm9LUGxGOVN1SDcxVUpWRlBlOG9zbUhrdlhJVjY1aHV0?=
 =?utf-8?B?NXVyT001c2VlMy9pK3lEd2d4dWg5N1FYUmVVM2czd2hpZy9hVkhQMm01UEpN?=
 =?utf-8?B?cTl3b3JrTXl4Y2lTZ09xSGhEdnBOeHBpUWZMZldQYm5UT0ZXQlNPeDBYZ3F2?=
 =?utf-8?B?eU5VeUFGTmJMako3bTd4STBxWHlYdTJFdlh6Z0s2WkxncFZPQVFNdXo4LytL?=
 =?utf-8?B?RW0xd1lCbVBveFZGLzdkSHhwdDVNRmRnMUwvNGtKR05LaUpTRm9vRWhTM3RU?=
 =?utf-8?B?WWpxYUF1cHBqclQ5Rm83SU9lSDJ5RGFDWXJGTnR3eXBZdTZpYURrQllkY1Jo?=
 =?utf-8?B?TWJkUlJNTUg2eDNPa0psVlZwQXRjY2hkNitKNElDallQcWdaMUV2R3hweVRo?=
 =?utf-8?B?QjZObjQrT0Y2dlJNU0RDeThLZVZ1K3BiWVUrY2xaaGd3cnZxSWxsdUNVYTRy?=
 =?utf-8?B?a21yRE1pU1hUekhYRFAyYW01blg0R3FvNHB3VDRCczJIUSswNFpCK2d5UXpy?=
 =?utf-8?B?SjNnUnVOU0dsS2FuUUVZVGNxOWhNalRCSDIveGpxZUZVRGZSSVMyZ1Zya0Qv?=
 =?utf-8?B?dUU4TCsvb2xEaFVoVzF6N0N4aEYwYnNZR29CM0dEMjRFSm4yaDc1NzJZWnNq?=
 =?utf-8?B?OVE0UnpGUldPR3lRNy9nMWx3amFXWDM3blJmWlA5TVFxcEd2RFJiRWlSR2Jm?=
 =?utf-8?B?aUgybFRTd0RqRm5EZTNTOHdxL3JNNENSdlZ6Y1BRdWQ1dDFNQklyK1hRVWdY?=
 =?utf-8?B?eDhBd093Y1Z2bnJ2aGZqSW1pMG9EdXgrekZkNFI3dDc2ZzROcVpadG5WakRO?=
 =?utf-8?B?dTVPMXZkeUpnd0ZFcGQyKzVaY295b2xsVnJBYy9Gb2pURVY4eTRja0V3YkZI?=
 =?utf-8?B?ZVE5b2V6SU1LOVV4UFlBZzNLT1l6WHBUZllITThZdXRsNCtnVmJNYVpEZEM3?=
 =?utf-8?B?TDAwS1F1MG55OGlSU0d3cGVXenlyNVUzUHl1NExiblV5R2NkS1Z2Z2gzcTIz?=
 =?utf-8?B?K2Y4UG95bVVVVmR0V3haZlk4S2NiVGVUOXo2NzRyTU9MMDVZc214Nk1LZ29r?=
 =?utf-8?B?ZFUxTVV2Qm1kMDR1TGE3RE1SS0RLM0JKbnlWZ0ZqbUphUVdOWjJ6T25tZmJN?=
 =?utf-8?B?ZEU4c08vRXRsVytVYkJOVUNEbXZLenZzRk9GTDB5Qkc1YnY0RCtncmdtYUZm?=
 =?utf-8?B?NlZxK0tBaHZMcDZINERRL3FVMlZzeXFFWW4wNFZ1Q09QZUpTU0JaazEvRE5D?=
 =?utf-8?B?NXBkMFFBVHB4d0FQY1B6cEFFeFM4K3NuSjFrQ3NJUDJQalcwUy81dlE5OU1O?=
 =?utf-8?B?Y0ZIb0d1QzQvVUxyRHh4ekJ4RGJ1cGxXZHI4WUFaa0d3cW8wdERFdU1uVGZT?=
 =?utf-8?B?QzB5VEttMGplQzhpN3pjY09HemZ0bW5kb0pMbXlWVlM4V1YwTjUvb0E5R04z?=
 =?utf-8?B?dXJldlE5QWJEQm5DZGhYN3pmcmphaWhrODdBbDgvemFhT1V4bVNGam85bGkv?=
 =?utf-8?Q?GhV4A0Pkw74Kznn+ljvonPIi1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90e4125-992d-4b26-a2b6-08dbce56c9c9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 14:47:15.2450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUfYBYwEKkTgDs80uWoyx+gKoU5mcFI+nrWsAJk8zdUkvIjrF/EEdodirjnU1NMHcTlwTlltq8lvjVu0VsUvkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 10:24 AM, Dave Hansen wrote:
> On 10/16/23 07:14, Yazen Ghannam wrote:
>> 1) Keep the current config size for boot time. 
>> 2) Add a kernel parameter
>> and/or sysfs file to allow users to request additional genpool capacity.
>> 3) Use gen_pool_add(), or whichever, to add the capacity based on user
>> input. Maybe this can be expanded later to be automatic. But I think it
>> simpler to start with explicit user input.
> 
> I guarantee virtually nobody will ever use an explicit kernel interface
> to bump the size up.  It'll be the same exact folks that recompile their
> kernels.

Right, I agree. My intent was to help avoid a recompile if, for example,
the config size was not enough. Meaning even if a fleet has a custom
kernel with 8 pages of size, it may happen that more is needed. But "may
happen" isn't a strong reason to make a change here. :)

> 
> An automatic resizing one doesn't have to be fancy and only has to
> expand once:
>

Why once?

> static bool expanded = false;
> 
> ...
> 
> 	if (full && !expanded) {
> 		expand();
> 		expanded = true;
> 	}
> 
> It might be a _wee_ bit worse than that because you might have to queue
> some work outside of #MC context but seriously we're talking 10-ish
> lines of code.  It'd probably be even smaller than doing it when poked
> by userspace and wouldn't involve new ABI.

Okay, I'm with you here.

Thanks,
Yazen
