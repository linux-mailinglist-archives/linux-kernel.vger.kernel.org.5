Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC917B5505
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbjJBOUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbjJBOUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:20:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684D2D7;
        Mon,  2 Oct 2023 07:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxT6cB+2v4OSpm0uL8tJu1jGu9QVTgaf45bS8iND8jOt4Q751p2kt/Ui6y0Kcs6gVM3ewNumNoYA3k5jqMZvBG6dqnF7ayCH4vpbb5WQoiLGkdjcNFgjzLGZwyot3+6zQ6FHKlYAf4nHlqgOnRLwh1axmw55+hPsQssKtH62OWg2DA6swjLnrF+joMluDnz7i7a3LxwpdQcMzJm1UjNqzlmp8OEluTLT/LQvtdT22CAmUL+m399QJ2WXbyuMKR+kjoww8rfV+nBhNcUXjdid100sarDCrk4Qs0hyvxWclWv8Tb2XWXvcEH+bWxiS543LVt9XOBL471oGKwJF8X8roQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkXCr9AZsn2DSc4zBYdWzj+gL85invJvX3X/qMvK4pk=;
 b=nRuGCND/FGM8nh0iPyws8/d3AY+Hg/XXCCNVNaLRTioIMDWSnHDW65b9+HznPnzGYFz/BqqUS1dZ8LfzxKjrd340xIeEbAyX1BxsDA3qe/EWdHzkFWNa0Carf6DgNCPqC1CA63j0BPKv1E6V++iIb4CsQac+nzMeJ5dSexunZwjHc1Bm1PjU8EErZTnKQRyiGQKNQ9QuSRsCv2vKLyTG1EOj9lmkASSNv6rFgVPR46JLz43SDy/KP86q2sd+1lXV/OBMx6GbtQ9YTDhzlFTi/VDi1tpSWU3p5JGGM9wGIyZYtwNGtosfhH406XR70Dl3ooQtpOoMKQGcJASZ896aWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkXCr9AZsn2DSc4zBYdWzj+gL85invJvX3X/qMvK4pk=;
 b=H20EWCl67uzC4+V45rCOLxp5sfNNpk7KH1E0IK5ydX7JgScV4CkSHtNDexaGq1WFvA8eF9Dy60xklwvPuDIzrb6bWu6/wKFMaB5TIGkgok0tAhx/7m5tlf2gA4Zx6tZfE/DakRJGkPBTFos2zNcDO3xqx272m3X2qonRpYWURF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 14:20:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 14:20:09 +0000
Message-ID: <28e38593-4861-4d61-b27d-994328ea4e82@amd.com>
Date:   Mon, 2 Oct 2023 09:20:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Mark Brown <broonie@kernel.org>
Cc:     Sven Frotscher <sven.frotscher@gmail.com>, git@augustwikerfors.se,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
References: <20230927223758.18870-1-sven.frotscher@gmail.com>
 <46560887-0b6e-42ac-96c3-b4dbc1d7cb61@leemhuis.info>
 <4fa7d39d-dc34-4550-97fa-2b089f364cca@sirena.org.uk>
 <0a3feafc-b843-420a-9b04-c835f8210c1a@amd.com>
 <048d9715-9cb2-4bc0-b8b0-5e30a0db54c7@leemhuis.info>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <048d9715-9cb2-4bc0-b8b0-5e30a0db54c7@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:806:f2::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: ea04ef76-5348-4791-972b-08dbc352aebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKzc4wdOUw6IbpUcYNRqlDNdlHix9FUeUHyEpHW708imwo8tlE7MOWcDkPXwgteAoZ1y4R7awF2Mog3Rdg7tYSTly6NnmPy/J3lc8qn1S6It/g9uCh1n4DIpsEBwC9yu4WwldRMiaQQOgFuLxXnz9KldFmCT0TJrGEff/5J+AJzq9rlp/xLSwIOQrfpzx2fasguwSFvFkiSSfZAIR9EU0EOk9HGm+YbtlxmmQT6W/1NO251F0mdleeKBQiEOKM2lzKyRQb83QiBF8wCTGy6qo4PfpFY0T59BVXa9WWqxDy1g35Uv4W8ciRCbM+x1CT8uBkrjWguHU8EpI9n2AdDdRWOjy01fZDnfFrDedZj96PYnYzLSibGUFzCO+IqlwJrdVQ9yDwTrKjsZHIVQHb1ifg4uh7MASsnRN+Hp5qhAlqMXmLTrWa5tmtgc+411s7ZWk3/HkmvviYm1Lr5kkv/zVri7ZeROKo0WvvUJAfsGD6mcYSmPasUTqHTKSqGJPOfGIium6Su0i9FEwX8lM4lvCJ/GfLOW+v1WQ12Qg17rHjbmC0S9W2W9c7K4HFNzXk4uy4/ahlhYsOAE7mZZsDyMjOKf0c7SVzgNFuX1aVJiLdb3oAg/jrdtDA6RKUbY8Sm5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2616005)(26005)(38100700002)(31696002)(36756003)(86362001)(83380400001)(316002)(54906003)(44832011)(8676002)(5660300002)(4326008)(41300700001)(66476007)(66556008)(8936002)(110136005)(66946007)(2906002)(31686004)(6666004)(6506007)(53546011)(6512007)(478600001)(6486002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0N0QUZrcjlJU2o4cERDQnBpTERVKzZoaWRiTWRYZExQaUJicUxFaDdXNGpy?=
 =?utf-8?B?T25iRWpxSnhDcENCRmVtWnoyWlROczFNVUdGUGVka1FBTE1QaVJKRWxmVEhU?=
 =?utf-8?B?N2ZTR1l4eGRxOUljZHV6QXBpMmcyTDZlUjNPQlcwU2M1SDV2dks2TENJakZD?=
 =?utf-8?B?QXh5cXVpUlNGOXRQc2JaekFUckdkWlRaSFBXV1ZxeUlKM3NjeEJzUjQzRlAx?=
 =?utf-8?B?RVhDRTI5VmtrdTlMK0JaSExBbEcwUzc5SFRaSW1FZUkxWWxFOVRrWHlaUTBm?=
 =?utf-8?B?b0hnSTR1K1JZN0NzNlhWcVhFcFhTdHF2TFZEZjBGS1RaSVJuZjB1TG15KzB0?=
 =?utf-8?B?dEJUVkNKZnMxUDFmYXV5eXBlN1J6SlhrcHZBOEw2NDhkTzhvYlY0ZkdlUW8z?=
 =?utf-8?B?My9pcVVPVkt5cEdnV0hFNk14Y0FMRjJ2RDZucFM4SjhuM0pzOUdpWG1VZnhx?=
 =?utf-8?B?NkJBZzJobEd2NnVOdjJzakRkR3pQU09sdWZaVzE1UXhqbEJOT2dWT05UY28y?=
 =?utf-8?B?Uy9wQnNlSmMwc2Y5cm5xM055Q0Q1WVJMNUR3Q0xVRDNBem5LZm9rVkNnZXcx?=
 =?utf-8?B?QjB6VnplSVIrTm5qbVg2OHozaXl2Uk05YkZhNSszQXJRTXpMRzFsZ2pHMFIz?=
 =?utf-8?B?QnpNSnFZUGZCaWhuZ0g1L1ZJdkpkbldhaG90Vk4vcTBEcU12N0lrV1Y1QUN2?=
 =?utf-8?B?WmtjY3krY1oxcHJBaXMya09zeHRGdXdqNzZRa3VjblhQalBrSE02TTQ1UUJH?=
 =?utf-8?B?bGlMZlU5R0NjNGdqSi9KTUQwdUZUZTZWZWk3SFdRRU1xRDFKUC9TWllqT1Zk?=
 =?utf-8?B?OWV2V052ZVhjMTlsVFlHbEtJNndIY3NLbTJQVDdzZ1JnTis2azRZcXpGN2Rj?=
 =?utf-8?B?MEVRQWhUcHp5OFUrZ2lwR3B4SEdTclpsN29lWk9MSG5MMVZvZnhyVmc4Nk50?=
 =?utf-8?B?Ti9tMmIvUkdmdEZFR2pmbC8xL1VUbWRFTUp5dlpUSUdlMkUwSzVmekw0QmVY?=
 =?utf-8?B?b2VFcTZWTit6NElFZzdTeDhjblhOdldJVGxDZTVDNWV0NlZLVFJSRGk2UmNv?=
 =?utf-8?B?d3lyUENZK0dKOEdINE1DOGtGV3NsTW1Va0M0cXBVTm0xMFhpdTBha3E2dHMx?=
 =?utf-8?B?MkV4cW1VMHNKWG41bFJTWFhQamN1Y2xHSmFHUjhEM3MyNVlvZllxRjVWVW4w?=
 =?utf-8?B?VUxpcFRkL3R2d2ppOTN5Q2pkOXlRL254eWt6R01XYjU1RGhyYXFKVldERERU?=
 =?utf-8?B?bjhCWVRGMldQTDVUWTBidlR4a25XOGtSdXlVcDg1QUpmYWh3RHhaTENndGk2?=
 =?utf-8?B?YUcyRVFOclJOR0twQ3MveW96ZEdhS1NvS1IyZDFvb2kwcGtxWThTcndxUTRB?=
 =?utf-8?B?T3A2NUFCUWVWS1FjbU41cklnbHlNNEt3a2JwSm82QmRyRU9KQTc3Y1Uzc01i?=
 =?utf-8?B?Rk1xdUlOR2lzVnAwNnJpS3hWTTdaNUQrbEV6S2QzTXJFaGk5UDd4YXJUWUVU?=
 =?utf-8?B?OVE0VEtHeEx6NGY5SklaKy9WSHBXYTF3dHROTnk0am91U3VJYk11cnpaWlpm?=
 =?utf-8?B?RHVqbjV6ZkQyUEcvNlo1ajNPNXJDajJnYm1ENjJ6Y1VUT0dYaTRBandCYVhB?=
 =?utf-8?B?RDgvNXB0ZVlKVjZxMjh5WEZkNHFtUURQcklGTkVmZDdIS3lxNGVuOXZmekJS?=
 =?utf-8?B?ZGVYakZ0LzlXUXVHNzRBeHU5SHhQOTQxamRtWTllRmhoZ3RtMGdoUUZsNjMx?=
 =?utf-8?B?STZ1dW1QRXN1NWtsUmFxK3BPZHN0Qnkvd0ZnNGRqS202VnJqdy9YSkUyU1BN?=
 =?utf-8?B?RU9HdDlQY1BqMHpDeVpXV3AyYmluSEs2ZHg4cFRzdmxkc1hoNFBqcExKb0Zm?=
 =?utf-8?B?MVRlS0N3enZEanEzdTZIUGRReTZvWW1DdTRQRW1meEt1d1pqYnREK2pPUms1?=
 =?utf-8?B?elNPZnN5ellvMU9XRHdtL2JXRWxXV21YdnMxMkYwOGZWNU1GUjQ1WkhJSVlK?=
 =?utf-8?B?S0ZScDgvRTJFcnczeGlUZ1lXck9EbnhJb091MnRsKzduYmx4ZWplV3R5WGNP?=
 =?utf-8?B?azkvVlRSRWhSNG05UytObUJpYmFKT2gvalh6NWJZckVUVHFkeU9HWTdwUTFG?=
 =?utf-8?Q?vvMwdhjKyBvbEUbVRdba2NT5L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea04ef76-5348-4791-972b-08dbc352aebd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 14:20:09.1397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zr2rx2c/lh6ZvtjQEyCgHXzll88ClILWEHH1mzM9bd3sxN0Nx06bX62FyNxstpdgG3pFJzCJ2b/J8Nm3ih6Jxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/2023 09:13, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 02.10.23 15:47, Mario Limonciello wrote:
>> On 10/2/2023 06:52, Mark Brown wrote:
>>> On Mon, Oct 02, 2023 at 11:32:48AM +0200, Linux regression tracking
>>> (Thorsten Leemhuis) wrote:
>>>
>>>> Makes me wonder: How many more such quirk entries will be needed? Will
>>>> we have all machines listed soon, or do we expect that future Lenovo
>>>> hardware will need entries as well? If it's the latter: are quirks
>>>> really the right solution here, or do they just hide some bug or then
>>>> need for code that automatically handles things?
>>>
>>> x86 firmware descriptions are terrible, it's just an endless procession
>>> of quirks.  The model for ACPI is not to describe key information in the
>>> kernel and instead on Windows load device specific information from
>>> separately supplied tables.  On Linux that translates into these endless
>>> quirks, on Windows it's platform specific drivers for otherwise generic
>>> audio hardware.
>>
>> I knew there was a TON of "82" prefix systems from Lenovo so it was an
>> educated guess that all of them needed DMIC support.  This was incorrect
>> because one of them didn't have DMIC and that caused a no mic support
>> problem on that system.
>>
>> So in the case of this seemingly endless list of systems being added to
>> enable DMIC support Mark is right, Windows does it differently.
> 
> Now I understand things better, many thx. But please allow me one more
> question from the cheap seats:
> 
> Seems before c008323fe361 things worked for a lot of systems for about
> one year thx to 2232b2dd8cd4 (which added the wide "82" prefix quirk).
> We then made that one machine work with c008323fe361, but broke a lot of
> others with it that now need to be fixed with additional quirks; that
> "TON of 82 prefix systems" sounds like we might not be close to the end
> of that journey.
> 
> So can't we just do it the other way around and assume DMIC support on
> Lenovo 82* machines, except on those where we know it to cause trouble?
> 
> Again: you are the experts here. If you are positive that we soon got
> all machines covered where c008323fe361 causes a regression, then I
> guess it's best to continue the patch we're on.

I don't like lists that enable something for a ton of systems and then 
lists that disable something for a subset of them.  This becomes 
difficult to maintain.

I'm not positive, but the only way we get a full list is from Lenovo.

> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.

