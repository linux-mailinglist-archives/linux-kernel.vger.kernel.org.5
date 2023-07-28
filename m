Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7291176775C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 23:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjG1VCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 17:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjG1VB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:01:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD9A448A;
        Fri, 28 Jul 2023 14:01:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdWrNfnY3mlBxBYN70bJyZQNzGre7MMYDpYGhWGBEjOLQNchUrfGebQmItGiDEfQavOtAM1/i+w+4t5lmAgDDKzgbvzwiFRkwGQ0e154yUpYE7ZKwAl95eyNbnnmJwbXpwyhvQAlqWqjXF/WrYIuj4KEemF8x4kyGDgswjP0CIhDRFpA8WMfiIPoJExGgyBJ/I9OgRNrbLyDtyA2AbEv12rGcWCZEo1AIPuvoSCjw02gYBdprzXQJYpa0dPhSy1oCgJ8tvEK5vempnv/mtZoJEeRLdk7Pa4pXaE0yFur7cMNWFa62PEVWNxbC3VItNQMULYIAxZBM/nM7IgKB8yhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04nvIfPhUAiSITqzGKjpe1LkAVHKObQ2rAOoiDepCwg=;
 b=jsebFw2uaBvdvx+yaRH6g+eQ9LF5v0qYAgZliCgEgfy0g1jGlpwMp3ZX99l8mDgKjFLikbItDyfENVVXDz04mi3NW/FKXwfhAE5VJl4F3hPllhs3+nlbNCzJJ9Jed5MKHYX+91JdXAFZ01J2HFCJ7ZSvUMU0vxYSDXy/Ub3KpnRdf4Q6Y/zSeG6+E9xmnBp2RdH66J5m4qMUq8mNk2+xo1+qTbWjtGc+Cl8C5fvmJKCZRYZa9dD6AEI2gZrHRsGw9uKxnOlx6KKABzWmUUNuwxSW2is4ThlNbcOWxiwAYPx5hzUYSwX9RDqoLUbhicfHaZZc1YaHzkLIK1IXQmTuEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04nvIfPhUAiSITqzGKjpe1LkAVHKObQ2rAOoiDepCwg=;
 b=WNa4oyeOv0zW85U/NSQ71Sga8s2qO5icEVCyplmvF9g5INBplhPUiaL8aHiZGpg3Bi1Xm7ruYqOdzWVZglfWece3x6GykvRaT54pR9Cxz3x9DoAPDMEUiTQn14vtjb5IpRSNLiP8pxladwTnyzdTh2kXc/Tw0eO0UnynYHtO/y0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7628.namprd12.prod.outlook.com (2603:10b6:208:436::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 21:01:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 21:01:48 +0000
Message-ID: <5235ab4c-a49b-0679-1bef-c3f02346168c@amd.com>
Date:   Fri, 28 Jul 2023 16:01:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniil Stas <daniil.stas@posteo.net>
Cc:     James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        jarkko@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        stable@vger.kernel.org
References: <20230727183805.69c36d6e@g14>
 <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com> <20230727193949.55c18805@g14>
 <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com> <20230727195019.41abb48d@g14>
 <67eefe98-e6df-e152-3169-44329e22478d@amd.com> <20230727200527.4080c595@g14>
 <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0057.namprd02.prod.outlook.com
 (2603:10b6:5:177::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba98e7a-ff7b-4bd5-ea71-08db8faddbda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o94KdeJ/B0dSTZgGEaVL/+Cg/uJ07GlO7tw7A9BfC2KKVkPcs3oVLCF7JEyuzPfyldUB+oX+VRc63ryqJFLfRTvfFNT5osXn1lTjNZHvLU0EgQKyNNIKF+pumUMIy4mOvTgzxxDvA8qX71MMJH5Mal9B4iLYT2kBdHkL7Z8g/o4ifHULTluBEOwmTLywjeX5y2S7tyO46VD4hr6GNMCxrb1C4sljbCL4Wsist5OCLmSyEopeRyQONvK5fKYhfeVW8NTJIkFVFSpRQKlYUTv7cVVaxborhgu3wJw14a0csYOgFJkofiBFdqZJdMmbaNO5htVFJSHrv6AML8pyWtTA7jXkxJNGgg+qxOfxwQyEognxcJsfH/WJ/mdd9Q+Wpr1Q2LD46HLtuz/1qLNRxPJzFrpFp0SqowIF8TbA+ZJGL4+2pXTCmYdFaCoyCQNVYlR9tOlrUKMq9cRGwyX8uSilemNwen7tfntfD7JUJj9Wl6d+jtiTvJsNHLRriGuY9ELUjI81WO8Jg0rnYCVjdCzmZU+Rbkq25Pb8L5Q0895JrXp5xZ2ylCC1nHuqAQ7TeSJ8sXLuMHl1HnOv1cfc8eP00lBbYAstCW9JXZCNDYXTYICo7DP9besnBLvyqICaGpRG+BVgFxQbeJXxpw6WVpIedA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(2906002)(31696002)(86362001)(36756003)(31686004)(26005)(53546011)(186003)(6506007)(966005)(38100700002)(6666004)(6512007)(6486002)(478600001)(316002)(110136005)(66946007)(8676002)(66476007)(2616005)(4326008)(8936002)(41300700001)(5660300002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dldhenB5TVBaWHl5Wk5NOUlHOHVuMkZMY2ZBZk1TNWx4bUUvK250OGdTYWVS?=
 =?utf-8?B?aG8vQU9VVnJyZW01S0h3aDVZSTRmWjNGek1NUHoyYW5PYlNaNU5vRXNpRGRZ?=
 =?utf-8?B?c0dhdjdJTnYwTTM2d3RCanZ3VldNdFdDSGhwQVZxNXQvaFFmTkVJQzloSUFN?=
 =?utf-8?B?OWNzanM1QTV3Zm5xYlQ2QzNKT2w1VmR2WllST3NCa3dncjkvSzBHMXdzR0Uz?=
 =?utf-8?B?YVA5UjlPVHJyNHVtc1BHeXFjbTNUWFpmTzc5TG5YWjVvSHZmUDZDc2ptZUVv?=
 =?utf-8?B?YklWVC8wQmdOczdGVjQ1THlVZ254dlBZdnBHVWpiQXlha0tocnRQSFRMdWN2?=
 =?utf-8?B?eXloY2ZOOS9rbzNDUHRLMjBQRjNjdUd0ME9BRmlqWEpISWZDNUZ2M3BXczRZ?=
 =?utf-8?B?enVpa0RRdlV0aVlYbGRxMDgya3FpNzFkcE0xa3IzdkJlbkdTY1JTeDJ1YXo1?=
 =?utf-8?B?M2hzdHZWVXF4aHgxeGd6UUtmTEduU2UzTytSc0xtSWVVRFh3M1N5Sm1ZaXVh?=
 =?utf-8?B?OThZNGk0SmJKY1M5eWRBcnJmdkQvU2N6aW1URDh2Vmx2RzV0ekZaaXBTcHYr?=
 =?utf-8?B?eEpDejl6bit2QmlCclY2ZjdnTXpaVEU0RTRBcmk1RmdiNmM0TUtnY2NwZUxM?=
 =?utf-8?B?OVpGWUs0SnJSd2J5YVhuOE1IVk00bDl0QzQ5RXNkN1lXa3NiOWNxakl0Q0ha?=
 =?utf-8?B?K0txSjBmUGIvVXBnMVYzaGxhVytwS3VlV2NlSmNqbFBNdUt4endUWFF0U0I2?=
 =?utf-8?B?MVo1N3lyZDZGU2RTTmZlYzZ6cTVmWDcydG5MWUV0ejR4T00waGxkcUJqOXVP?=
 =?utf-8?B?N0xKZ3Rmai92dVJXclFOMkVJdm5CNDVNcmdvNXZ1NWxVdEVBZHQ5VVNBbDk4?=
 =?utf-8?B?YWozTUQ1bk85cmx2Y2JaUlRJOHZZRU5BVFRhUkxXZFlLRWV4a3ZGKzlZeFZj?=
 =?utf-8?B?MDMxZkg5UlBsbmpXaFRqU1BlbTF5R0hNZk5ORWV3ZzJpZERadzdHbHJtc0lQ?=
 =?utf-8?B?cGdzRGRRamR2OVFQQ1M3L3BFcWZ0TzRmNExLOFFqS3NsUm1iN1VLemlSaklF?=
 =?utf-8?B?c3BJdVZQemExOThRTGNVR2ZuNElXR3dHb2JkYWttQm9pSTJGYnVEemVHTVlZ?=
 =?utf-8?B?SVFxbnBETnE0dXg3eDFpdWRpTkZuRWE5bzdVUmR0WnJoMXhOL2l2SEtmTlJE?=
 =?utf-8?B?NjFBSHZKZ1RFR0xweTk2T2tic0JXdmJqRU4vUFVBdm9rMEwvK3BESEtZWElK?=
 =?utf-8?B?SXZMQStmSEUrYzlNM0RCd3czVi9sOTlKOTBLaU95aVRQN2JKYU1VMVlyQS9F?=
 =?utf-8?B?SDI2S3JoVXFLblVRaVFSVVpvSTFCMFRSb0pMNjhSdWgzZnkxVllNU1EvaEtY?=
 =?utf-8?B?ZVlyYnhoZExHQUwyUkRvQWhiTjFjT3F2bGtZSlQ5MDJVZDRhUHRFOWhpUHE4?=
 =?utf-8?B?dTN4VzNhblc1ZGhybDBNR1JpamFkaUUrL042U2xaRkhEWFRacGxwdmQ0cjg2?=
 =?utf-8?B?TEpHUDJPV2w3djNBM2Q0TnBaYlBWbFZ4dkw1OXlQc3Q2K2w4dmE0MUJoMEJW?=
 =?utf-8?B?Z21UR2hmMk83bnFTS1pjOVg2aXFPTnIyVHEyaEtaKy96N2xCN0MwS3p6L0Vu?=
 =?utf-8?B?NDVRTUNKN3drOWFuR0UyNndYa2ZvRGZ1WlRKeE5kT2pKYXpjaGRtcHIxcW1p?=
 =?utf-8?B?R21nRUVtRTJWdkdmWG1ZN2hjd2hLWVdtODlXMGlQbWN4ZEFOTUhxcGcraUs1?=
 =?utf-8?B?b0l1aWNmVzRQSkwyTm9LS1lrS2YraFVFTkpPQTluRVF5S0pYZXIvUm9LNzdW?=
 =?utf-8?B?aTFUcDRaR0dIelpWUjROYWcxdllVb2twSUJpSzlOcUNvU1Y3WVdlRmdTZEdW?=
 =?utf-8?B?cGZRS3JXaVBNYTVqWWhFRXBFMnQ3WGM2NXFtSks5R29MZy9EbStycTdvWmtt?=
 =?utf-8?B?M1VHb1c3RkhHbzlPMWtRaWxkSUlEL1hZMU5yYjRpQkpxbzZ1SHVNSlg2VFlj?=
 =?utf-8?B?OVJocDRrUE8xL1dZb1luYkMvZFQwRlVHS0pqdk1JcWxCMjVOZ2N2UjA5UEZH?=
 =?utf-8?B?K3NVbjNuT0EvRjFjR0FYc3ZUUno2ejRZQUhxeWZTSDE4a0FLU0VoWE5vTEti?=
 =?utf-8?Q?na4EvCUS/QokcaI39GM+tNGkP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba98e7a-ff7b-4bd5-ea71-08db8faddbda
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 21:01:48.7766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlPk3XcgbXckvoI3jL6Dm61/mQTuxAMK1edbdwCtojZ/6Hj78un2fLC90DAGGhuX1tyPQRycKEhWnuY3gF9sOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7628
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



On 7/28/2023 3:41 PM, Linus Torvalds wrote:
> On Thu, 27 Jul 2023 at 10:05, Daniil Stas <daniil.stas@posteo.net> wrote:
>>
>> Here is the bug report I created:
>> https://bugzilla.kernel.org/show_bug.cgi?id=217719
> 
> Let's just disable the stupid fTPM hwrnd thing.
> 
> Maybe use it for the boot-time "gather entropy from different
> sources", but clearly it should *not* be used at runtime.
> 
> Why would anybody use that crud when any machine that has it
> supposedly fixed (which apparently didn't turn out to be true after
> all) would also have the CPU rdrand instruction that doesn't have the
> problem?

It /seems/ to be a separate problem, but yes I agree with your point.

> 
> If you don't trust the CPU rdrand implementation (and that has had
> bugs too - see clear_rdrand_cpuid_bit() and x86_init_rdrand()), why
> would you trust the fTPM version that has caused even *more* problems?

That's exactly why I was asking in the kernel bugzilla if something 
similar gets tripped up by RDRAND.

I've got a patch that tears it out entirely for AMD fTPMs in the 
bugzilla, but I would prefer to discuss this with BIOS people before 
going that direction.

> 
> So I don't see any downside to just saying "that fTPM thing is not
> working". Even if it ends up working in the future, there are
> alternatives that aren't any worse.
> 
>                   Linus
