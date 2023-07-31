Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0A376A0FF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjGaTSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGaTS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:18:27 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D83DE7A;
        Mon, 31 Jul 2023 12:18:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqyCoNFr4Jiv9/cc99wVH7aUNqypgikUkcYpg072hFtGdj8CH+N3+gZONwGLr7/3XL40FCXbyV3/dlNfyqTKEoL0Oofr0pWG2PRYdMM66ELDyFq4+oNN6K1SnBqzxmMHu4ew0cVJg6p6WOacyljgrGr1aqf6kmGQVYimsgc5gpigttfJZm8CI+3xy64KEtmAYvGx7hK9AMScPFQMUmLyl+qZLItUUP0E5hVxILh0UretWvnRfnCUbuaCPpf/sVH8AJju3LSu2MNVUjgaeTdn04v7L0SPmvGaScpUs1ztpdICVGwHHW+QM/KGDcx+bTSKj5V+4DMn/lC9TgiJJJRBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJfUtVIiwx4DwPYzsIztyYGBjK/JLDGo7VPn1EHsQCs=;
 b=FzGMQDtE5hRbZfGUlephv/wry2+57pebQ42+B1rPLJ+N0X5fRNPKBz+dU5e6RS6mI0XeSt5KSeYZNaGmiBIydMyHDWTX27Xt6Trd7Shq4iPvTcjw7hBmHdXnADceIymTCZqIWdzaKc/rM2R7NncDlPfZNhSRKqFAmO02jXdoYRTmLVZKtWdvTAYCX9pGYvcNVkbNXQ/87nLFvsafxTzCxnQtIR5ok01O3+VYlH/JRlb8X/NI2qwi6rgGXvO7d2rtUqD9eknHedxtATO+1w5cAaMDQjfYxIOQzFSBaRrf12H4sNWprKXiOAkzh9HQrAUeujhDCQaNU70LpKD/SbImUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJfUtVIiwx4DwPYzsIztyYGBjK/JLDGo7VPn1EHsQCs=;
 b=JS4qGeDer8KGZWiU0ixtEXunPtkpSIbl3OR7+jXNY4WfG5CTd0/Sl+h77QQpIACuDi+in9e3jWDLDwQojOuPf0Q97LfrEaKvC0FC+uWVLNlnkpkvn0IcQhBKkZnbHAOB6SGzjuVnRzFEwjB/GPTAs50vprVx8/9McSxnLu6t6pM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 19:18:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 19:18:24 +0000
Message-ID: <105b9d13-cedd-7d3c-1f29-2c65199f1de7@amd.com>
Date:   Mon, 31 Jul 2023 14:18:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Daniil Stas <daniil.stas@posteo.net>,
        James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, stable@vger.kernel.org
References: <20230727183805.69c36d6e@g14>
 <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com> <20230727193949.55c18805@g14>
 <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com> <20230727195019.41abb48d@g14>
 <67eefe98-e6df-e152-3169-44329e22478d@amd.com> <20230727200527.4080c595@g14>
 <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki>
 <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0086.namprd11.prod.outlook.com
 (2603:10b6:806:d2::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: a830ce77-57ec-4b7a-cc6f-08db91fae8e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z85lRoKe7FshV3Isa3Vdipua+WmPXMRibOv59mpFfM5mrApFw+5huzJDdOjr1seVJhI7OPrJu83ntD1mwYGaTQI80feYzzSenzmHrmFYOgfUGMoZq7OI8eWwVORBayl40XmL3+ErTU+X5Tw1S3umrKggj+9kYn8FJtdvuslEYnFDsSm8M9B9QIj1AOhk2eiOpeYw88uCuTlIYHspPb6r/roBSRk3y17gd+M97+JoEJQis71rnkB+EdUT6xMw7eRgVuX81eAVebjcf3yNS89Owj73Ib88wY7ZoJG3SjbdDl7bSvGZ4t3k9/+8n/9aHF/LNYxlmr1tlVws5RbVhELrgbV7P1khKqY+o80YJQ5ZvzaolVrVR1/t5JQXo5N7J1eaCxWKxd2gEQNoPgGFlL0b39dfpAkYjJIBRs5VUPVGtcNWdR287eAU9ebnRTF6Q/LX6A4y/VAmGCtQngaLV7sDs/I/73YMGmb7SNL8+MmqImOgrui4RAyPihKytLHvM2DRtzQEHSk/utLRkdxE7qml5muOKbCGJbfcFHspkA5VsdD94j+FA4pRaKBbeEH6281gbeWS1ar+1eTGcdcKTpDe5x6Gi7A9lFMJoIKwLUV/abkYkX3/f27AJPQS1oJgRTNJbX9P7EXKxPHyT5KbcJXn1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199021)(5660300002)(8936002)(8676002)(316002)(66476007)(66556008)(41300700001)(4326008)(2906002)(66946007)(36756003)(2616005)(6506007)(53546011)(26005)(38100700002)(186003)(83380400001)(31686004)(110136005)(31696002)(6512007)(6666004)(6486002)(478600001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3M3ekt1VU84MFl4bVEydlZUR1FCTDFqZE9iWFZ3V25UQ2NpNCtmY0lwMW5R?=
 =?utf-8?B?TFBtVUtobHF6WFduOWNMeWxZSzFVSnMyOEtMcThmejF0dGVzVFowanVUc0xl?=
 =?utf-8?B?S1JmaDhsNWJJcnJycnJDUE1FRVQ5N1dqbjV5Znpta2MyYVQzTEdNQnJwakY2?=
 =?utf-8?B?dEZKemJnMmhyUFVOamdQaEJIWDd3NnlWTmNEL1l6STJldHUzMEQvV3hXWFVZ?=
 =?utf-8?B?dXk0SkFoY2d6c1JNcGxvbzJxU0lJcVhhWTg0V1ZvaEJQK2J6NGpScGlsK2Vj?=
 =?utf-8?B?TVhBZUozTDhDVm91SFNqZDZPNURxc3BUOSs4Zmh4aXJQaE8zZnZrMVE0NGY0?=
 =?utf-8?B?eGVucEhjR2F2NEhUL2pTMWRvc1F3cEhjS0hzclk1NXM5d2VScDQ3SzlSc1Nx?=
 =?utf-8?B?Rnp2bVIwaCtWK0UrV3JRemVYOHB5QWpvSityMElXK3Q0aVpYVG9MQzVlSWg5?=
 =?utf-8?B?dlFUYVJpaHRDNnhyL1hZM2JoblNZWDN5ckUrUGMyZWtrOG1EbzJ5RUNQRGc3?=
 =?utf-8?B?aWlaZ1o4OVJwQmVTQmVSV2VabFB5OXlsOFlXNnBKQlhwVEk3UmFlTHZiTmg3?=
 =?utf-8?B?T01CZXc2cnVRWDVKV0pMaGlOOXhPbWFuNjAvV0c4SitnNmttajUrRk0zakEv?=
 =?utf-8?B?R2pmcENVODMwNlVra3dZTEN5Nkg5aWlGcDJNQURQREdmRGk3VDlneWd1bFpu?=
 =?utf-8?B?RnpxUUhaVXBCL2d6Zlc5RVZWNFhVU2FLKzdUeW0wb2o3RXN0SGpRekpyT3B2?=
 =?utf-8?B?WndWRUdVNjVPMnNKc2hTVTlCd3phZFIzOTVvcy93dGFsT01pVGFlTUFkQ2xO?=
 =?utf-8?B?cHVuZmpSV0xzd2E2OGUrY0VUUmV5S2MweTVtdXN5NUk0THdPV1lsZXkyT3BW?=
 =?utf-8?B?c1Jmd3VleFpvMG03R0FmN1U5WDlSQWtkMmZxSTJmeVdkRUFGUlVqUE9ycFZS?=
 =?utf-8?B?U0lSNVlqM1hCcVEwMzlYTitSdHpVanJoa2RwRjNjd3pxcVhNQ0twbUZYYW5t?=
 =?utf-8?B?VWl2RXlQSXF3TjRHU3NuWDJMYWdTb3BzT3BlMXdTYjdlYkNXcEg5aUxCSlAx?=
 =?utf-8?B?QWI4SUZhYVVTREdvL3JlQUd5SFZOaUk5dUZibDhSang2SUFKMm1UdGZqVUFv?=
 =?utf-8?B?L05BanhXQ3pGb3hDdG0wbTQvd2hIYVVOUUlSYThNTHR6YVBLWnN6NzhWQXdB?=
 =?utf-8?B?VFZxclFGOHlOQ1hhUlkra280c2YwL2ppcHVvaTBrbTJDb09wWVNCOXRyNTdx?=
 =?utf-8?B?eSsyMmwrYU04V3I0REdBL0VhZHd6QVhHZEpZZ05EK3NZN1hjQjJFd3JyaFFZ?=
 =?utf-8?B?OXBRNy80VWZ0QkxqMFg1eUdIb1I2MndDTUdlZGo1c0hpdTFXQWk1bDNuZldL?=
 =?utf-8?B?SGJHMnNtSjNpZ0xhQ0ZIc3lEU2hIeGRnY1ErZnBZSXhMcHBLZGtFTXFXRUg1?=
 =?utf-8?B?MU1zM3JDbzVKS2Q0RTZKNFpqSTZtb2lxMmw0bk15WGxqYnFid1hkOUZqYXlB?=
 =?utf-8?B?dE5jUEhINkpoR3plMmlDdGFEalpUM1ZNSDZ2dzNJK3VEa0JyZllGWkVHeEpP?=
 =?utf-8?B?amUyY0JmNTcxcE1sTkJRTGhVVUdEVGdRRHZKMXBCcUVDVmZGWmRYZW1CVkU2?=
 =?utf-8?B?UDJWblNSSS9GUkFiKzZmLzdFOGdIdHJEV1M0K1lxQVZlZkhGaUtwMnJEeUlo?=
 =?utf-8?B?QnpIdHQrSURRZjE2czdvaWlBc2ZlZk4xV21UaitNajlVemg5NW5nUWh5ZHZr?=
 =?utf-8?B?OFp4MzdLM2lUdEZWb0FTN1J2UW9UZjJJZ2pkWHllQU5ITlhsWEJTUllYZFhG?=
 =?utf-8?B?Zkd3RnF5cXA5ZXZ5TmdSZXg3ZlBpQ21ncnUwdDhaUUtMb09PeGZqdWNxdS9y?=
 =?utf-8?B?U2toVzlOOElZbFVYRzZmMmt1Rm9FejJscWZCSk56SWpMNzNKRnBuVllTVXhz?=
 =?utf-8?B?VmNVYWhPR09ZS1N4N2NoVkkvc2VEOEpZK3A5S2JoUW1KU1NETDNrZlJybVhI?=
 =?utf-8?B?SHRia1d4VlNFcTdtZWRzdmhBaFZaMGxvNUhHT253dkFtK0RSS1pOWGxXYXNN?=
 =?utf-8?B?T0FpQzRmeXY3dVJGall3ZzdMdjUvRTgyblgxQmlUQWFJekxUdjUwcUE0Y05B?=
 =?utf-8?Q?WNRUbsFg/tywiYzFBSh+s6NDN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a830ce77-57ec-4b7a-cc6f-08db91fae8e4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 19:18:23.9577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KGRHktfbXZGxSJjVi431lklxyIJ7NVB+pRQ0SRps07IqsooCB4YLiZJ7MYiKJi7PwNlBXM1UQuK3zS0MQWlUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/2023 2:05 PM, Linus Torvalds wrote:
> On Mon, 31 Jul 2023 at 03:53, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>
>> I quickly carved up a patch (attached), which is only compile tested
>> because I do not have any AMD hardware at hand.
> 
> Is there some way to just see "this is a fTPM"?
> 

How many fTPM implementations are there?  We're talking like less than 5 
right?  Maybe just check against a static list when
calling tpm_add_hwrng().

> Because honestly, even if AMD is the one that has had stuttering
> issues, the bigger argument is that there is simply no _point_ in
> supporting randomness from a firmware source.
> 

I've had some discussions today with a variety of people on this problem
and there is no advantage to get RNG through the fTPM over RDRAND.

They both source the exact same hardware IP, but RDRAND is a *lot* more 
direct.

> There is no way anybody should believe that a firmware TPM generates
> better randomness than we do natively.
> 
> And there are many reasons to _not_ believe it. The AMD problem is
> just the most user-visible one.
> 
> Now, I'm not saying that a fTPM needs to be disabled in general - but
> I really feel like we should just do
> 
>   static int tpm_add_hwrng(struct tpm_chip *chip)
>   {
>          if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
>                  return 0;
>          // If it's not hardware, don't treat it as such
>          if (tpm_is_fTPM(chip))
>                  return 0;
>          [...]
> 
> and be done with it.
> 
> But hey, if we have no way to see that whole "this is firmware
> emulation", then just blocking AMD might be the only way.
> 
>                 Linus
