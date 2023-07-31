Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0B376A382
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjGaV53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjGaV51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:57:27 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518D3E7;
        Mon, 31 Jul 2023 14:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hkm1TGGKBKdWJ7GoRKQZq+kafZafaSoo4fOcCDmz9mV57VUhDSGBydLF6SElpiY1G7HIJ5K/f0eFL4hZjdUEfc743A5JFwS2RLqIn38Wg+hiPOG45mXzO/FbKga204oLJTQQMAwYf2mun7OkBjz2I0ZJ4oxsVLcpzTuPeGYLbeKWsBmGZagBwTZ+lonc/hsQiKcHI7LGnm5A5QBQ4vuSKumyQalZZdsn8VjyJ620oBfHVTTmj596T0tMlSfz2xCzF+7GZRQGlILcz5Zkq74yIIIiKcsy89mMHmH6MTHhd5SlsrhW8g2wrWcAmPiTSizFsN+DLfwmYLQLVokDvQ5w8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgzvx0yfOrEF8cRgYaZxnmXTuYIRw1CwP8WyPahWOOY=;
 b=Y7vOzIvZop4wCOYBPm2UDPDkOH0NABQ+TA2vkaSRboDFBNd+KDUBWpnwCkcfDKv4viYnvKkKlq9+7IhJChzLU/QSQni2Cy9BRSccVvzufZ7+MbZvm/4bzHrah1tGOS/IvXo4aD7zfi0+umPZFc9gdJMDPDB7RMJoB6KBfWv6RcwXuNIXzcOYLQAHQgC2O1mqrIzNnX5nV0D9axhrFoKSmvX2EcNAtKYRl9n9mCQPKRTw3PeSPS/g0d5O8tOxtpJ6SzST58HzoA1Vj+GEfUcZE5cBymM/9TJdv6bCsBI6YbKIYoPJchfxKn4nGEih7lWP+DqfzO2jVXJBJqY7xsvsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgzvx0yfOrEF8cRgYaZxnmXTuYIRw1CwP8WyPahWOOY=;
 b=yzIPqrCNbelSq94UveTRcs74KPREG6ausZdtdj/kC2MPUVFg99B+M9e+9MNx1GP+KF325O5rrI8XqMuiAQ+WD2RFNGsXYUQQDWq54ynO19UYJlcCHmdc8exmFVcSa9JKMopd0F9jJvQIs6aKsHKBV2RZUg6sWCLq3HZbvQRU5fQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB8721.namprd12.prod.outlook.com (2603:10b6:806:38d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 21:57:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 21:57:23 +0000
Message-ID: <fd3cc87a-97ec-00ea-e480-f6597664c13a@amd.com>
Date:   Mon, 31 Jul 2023 16:57:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux@dominikbrodowski.net
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Daniil Stas <daniil.stas@posteo.net>,
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
 <105b9d13-cedd-7d3c-1f29-2c65199f1de7@amd.com>
 <CAHk-=why64j-K4e1VxKwx7o6FiGjcXEnu1Pz+1QnNTBCv9AGyA@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAHk-=why64j-K4e1VxKwx7o6FiGjcXEnu1Pz+1QnNTBCv9AGyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:8:56::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ddb5c9-7d58-4f89-05b4-08db92111f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WA6SyQRRqtnYs0NE2yfGEYlEgkJ0QK6Du5d5XYInr3ED1+ZTnKqx6Zr4QVYVHzE2GVukkOK4i1EsCW97uvnHpM4D8SXqpUMLlorPsI3z5z9aErkz75pZpRaSmOm3GLutXKLeKDljL1oBIgOyKPPi0MNemGutiIkTI/w0jYVrsUNjjjvkw4EEBwwbywirlr5mJiEf3MpqHXB8x5c8JxKjcE6PdYnIFJ3ZYfkfWzNyCOYHbZ/4FNOcn5WmYBl253QxoIaDki5+8gS2LCdtvNU7BY0wjsq4+SYvV7YL3i2I0SdB3dCuLFk5xA4z39sw2uoN4DjPh3ORoNvKgwCm9LtLKWwvWpv4ERRHpTHireoGbRj8i+CvPjg5Q/RNYcyF538Gq1K2aLewjCfFnHqw6zUUSug0scl/YWRGytfZClUaUsGjHDQ0rxYNsEXhXJer/ihMtQbo9wAb8PYce2VrEUWfisKAZLGhY9iUcpskVTgnHWWzJ2RTCvI84Y2ipADBikvchYCRQWvzPWwBXrOwZOqCPit0Ps9D0monenNLdIOb0EOFI52FZYYNZ6UZdZKqHVq0I4PdMvtPPh1UiXG8ows/9XjbeuS3fwfueDSubgSRdH6byAojJajF2cUfDWARA54+pODVNzyp7dyIp83oTg9tLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(6512007)(6486002)(36756003)(2616005)(53546011)(6506007)(26005)(186003)(66946007)(66556008)(7416002)(54906003)(41300700001)(38100700002)(31696002)(66476007)(86362001)(316002)(5660300002)(4326008)(8676002)(8936002)(31686004)(2906002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW83elVPcVpIRm5kcGM0ZUw2bnVWVW4yTWpHZVZ3Vk1YeG5LeEdORWZJSCsw?=
 =?utf-8?B?bXVXSHduNHdjQ1dkUktkdTc1MnNhaUpoQndFaWJYL0dRZEhqZFZTK1ovUk5Q?=
 =?utf-8?B?L1FNdmhVY1dBVzBVckJMM1dHMk9SUGoyUG1HU2p3aXpuM1A4VXUwSVAzbTY0?=
 =?utf-8?B?OVFBQTdKbTdoMEFkZ2lPNGd1b3NwR3RsOFBCMlpvWkhJUjhITkpURlFvMDZv?=
 =?utf-8?B?V0JPcTZMUmJYa1hCaFhoaTF3R3JkSFEwYkhWbndUM3VQYkhIYXdBYTA2ZmpT?=
 =?utf-8?B?RGoza05BMEhXMVVMbWhtMHNXSDM2ZjNkVUoxd2dLZmx0RmVGa25MZUpDbUQv?=
 =?utf-8?B?eXMvbW0ySVRsc21LSHNLcFdXVmxjbWkvZnk4QkdNdzQwWlV2WERtSnRiakJI?=
 =?utf-8?B?Q0twRlhWTDVLbWxxRkFKd0dMeW9pK2hDOXZvMVBXM2t4OUQxVHJHOWx2cjVK?=
 =?utf-8?B?bmloSFo5VU5yOFJEeitvZEkzTWREZEZEYW53NVltZUlRc2FMUS8zOW1NemxO?=
 =?utf-8?B?OElQNUZ1V2c4dFNxVDA0eU9NZUdrUURhQ1kwbFNFcCt4UTFTMGhOek53Zk5O?=
 =?utf-8?B?c0VoOGNialJwcU56VkZHbVNwcDlDNld5cmxkVnNQY1ZTWGVTMXQwczYrTkNw?=
 =?utf-8?B?UnJhZE5ySXM5bXhmVm9aVUdtV1dDL2hrOXo1ZExUK245UVUvWU1qRjJSZi9x?=
 =?utf-8?B?U01xVnhRVXZYdzJmR3ZzbGZNSXNXMFdvbU84bWtMQ2haT3hVV2hXMWNGS05r?=
 =?utf-8?B?bjRqRFc2N2lVcSt2UStlOUw5TEIrNmdEeTcwR2ZiRDBpZUx1c0lJSHJsNVVV?=
 =?utf-8?B?MlFxRmZ3U3dJWitZTzJiaTBJblhIa2EwZUV3Y2VEbXJTM1BpejUyNmhZYm5x?=
 =?utf-8?B?WlZvWFpNbWhuM3dRQzlhUUpZMFZXZ3RPQVk0SlhVOXBOeFJXUFNwUmFGT0xn?=
 =?utf-8?B?dmxBVm93V3JHZ2dGOEdHL2ZYOHlqVWY4dU4xZ2NqYWU4anpMZmx5bnRkbW5F?=
 =?utf-8?B?Zm13WWtEOGNTTUV0L2dxa0NJQUFNMit2SEoybUVNVmVieG5WVHY4S0M0RU5q?=
 =?utf-8?B?Mkp3VUxqVFFXWGhoNldNNVR6TDVtRStXdjUzQkpVTEQxRFcxN0VuZW1HM2U3?=
 =?utf-8?B?ekNOQVhrODNnNkJnZEVKWitOdTJHdzFYVGMzc1hOaEhadHZzSms5UWltQlg3?=
 =?utf-8?B?UjRFMEVjUm12c2VYQldpdzZoRmhzU0lCVmVwZ3l3bXhNMS9tdEVwM29OdktE?=
 =?utf-8?B?MEsxRkxvd2tKL0hUT1NPYVpGZTdpTk0xWXV3bWVxKzlhMC8rZlBoNndrdG9Z?=
 =?utf-8?B?bW1rSExJUGNTWTYzN3pzVUU3ZXVPakZNbDVpUTF4NlJRRnJtVVhjZVlhSmwy?=
 =?utf-8?B?QzJZekpQdG4rQWxrWURpZHpIOS9WYXY5UjVPa211UTQ0RU44bTY5Q1hqdnFT?=
 =?utf-8?B?RkZkaldDUy9CN1pVTUg1bGZQdlZtRnlRbHdhamV5OUFYd0xaeWZ4eE45cUtX?=
 =?utf-8?B?NWtraU1iM0k4Mk1FL3VxeUYvTjJxYVJFZ3VNRjkrejVRTmViOUFRS2UrS0li?=
 =?utf-8?B?dFBGNkNINk9OSUZyeG1icDg4dDZIeTM0OGlWcGphWjF4eHVJRGppNFdGb1A4?=
 =?utf-8?B?eGNOcjVjUHVDN25nUTgvSGtVM1lJTExQMzc0NHZIK0NFeWcxL2EvditvbndY?=
 =?utf-8?B?MnZEK0ozd2N5ckNEalF2ZWtYcFZSd1FkL1dLaFM0VjFaUzNtQ2ZhdUJPZHd4?=
 =?utf-8?B?a2RWaXhCVlczRlBrc0NtckQ3YlkyNzBucmZYT3RpWXFtclNRdVQ2QUtlbEZn?=
 =?utf-8?B?Ykg2YTlYTHRvMTYwVXhKNFMwaVJRVnJvQ0VYeDVLNVREZVMxUWNBcUdhQUt0?=
 =?utf-8?B?QlB2RVgzbUtjWTNqcUpqNWNPeTVIWE50clplVlpZUHlBSkFERXVtNDd4bnpu?=
 =?utf-8?B?WVhwM1RpMisrZ1BYeGtSNHRJd1NkenZHeko2VWNvV0RoRHpIc2NCalJ1bElO?=
 =?utf-8?B?cEFsWm1ESXFqbGZCQ0U0bXcxc29yaTFjdmpEWDFyN2tRUHgyTjYzV2Q3ZVIy?=
 =?utf-8?B?OGlkSEw0ZjRuVzlTQmlPVjRaV0V4MVA3RzhzaE9HeGRWTjZBc0REYmpUeEQ2?=
 =?utf-8?Q?wLNsRvLtERZHl/ws70uY+F+nK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ddb5c9-7d58-4f89-05b4-08db92111f21
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 21:57:23.9236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCwRE1rj0je37wB2xopeA/Ok5uvpJh+LqkHQDxtUHqL3nSn3B+cPG+2p4QP4R2/9VOdxlGWKLL21EoZE3cBrzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8721
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/2023 2:30 PM, Linus Torvalds wrote:
> On Mon, 31 Jul 2023 at 12:18, Limonciello, Mario
> <mario.limonciello@amd.com> wrote:
>>
>>> Is there some way to just see "this is a fTPM"?
>>
>> How many fTPM implementations are there?  We're talking like less than 5
>> right?  Maybe just check against a static list when
>> calling tpm_add_hwrng().
> 
> Sounds sane. But I was hoping for some direct way to just query "are
> you a firmware SMI hook, or real hardware".
> 
> It would be lovely to avoid the list, because maybe AMD does - or in
> the past have done - discrete TPM hardware?  So it might not be as
> easy as just checking against the manufacturer..
> 
> That said, maybe it really doesn't matter. I'm perfectly fine with
> just the "check for AMD as a manufacturer" too.

Jarko's patch seems conceptually fine for now for the fire of the day if 
that's the consensus on the direction for this.

> 
> In fact, I'd be perfectly happy with not using the TPM for run-time
> randomness at all, and purely doing it for the bootup entropy, which
> is where I feel it matters a lot m ore.
> 
>> I've had some discussions today with a variety of people on this problem
>> and there is no advantage to get RNG through the fTPM over RDRAND.
> 
> Ack.
> 
> And that's true even if you _trust_ the fTPM.
> 
> That said, I see no real downside to using the TPM (whether firmware
> or discrete) to just add to the boot-time "we'll gather entropy for
> our random number generator from any source".
> 
> So it's purely the runtime randomness where I feel that the upside
> just isn't there, and the downsides are real.
> 
>                    Linus

Are you thinking then to unregister the tpm hwrng "sometime" after boot?

What would be the right timing/event for this? Maybe rootfs_initcall?
