Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49EB7CAC59
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjJPOxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjJPOxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:53:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FA4E1;
        Mon, 16 Oct 2023 07:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyzPdD0lHALjQc8CJNndq8YFq2Csb/tIIEFd+9D/jpX5rpeBJjr6/jQNv/Z9C3/HUEx+hi0ROlw1PC13gMgAxVWibtyNTjiaaGtcIo9w+4lzD4QpPUgN0xrVeAfX4QvbrZAbyWwpmhZMkDl7toag3pVT5wo3p93LguSfEhqGgoB5nt6MnEWjXYcfI5rcwwZg1NgiiuU5kdg0VYjxb0raZibflE2uW2Fn5GApV3afgFTmmrzqir5VqhsxzWuWLRQqLBmhmd26p4x8C2StAw9imF5H1Xvg0aVYUa6KQjbcqvxyECl6KUfUcN7v5h16IhDNU8QYyFwei6hpG+8mNeC1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJx5ww4lOou6tnY78sZRuvS9IWiKa6o5ifIEutEN70o=;
 b=fcqe04HqQf+6FloK483Xw0Wg4axNgSVzrQdeTsvTHlWwALN3R7Kus4sZgw5+21dLmyXV56bO0klLi2VQUBwZXieqyIpW2zXTCyVpZ0KQMmKlBczNBRvlGdEpPNdn4c8qGhYSGKD3RLaybucan2unvZemRPhT+bDfVvZaBOgwncEUTHLuyCEHCtTgyfbTbTYnpujXB7caKJPofoLbpIIls8WR4gGlkNz3tEJMbpsXzy4rense/PWf1y1o4Rvz3bAQGRtttB70eyeuZrpSQ8qo1x1I3w3uz2yw2HGvLIG/SDhOOxqvpJlQalt+UD3VMvFg2oXVM2lVJANXhz0+4QZSmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJx5ww4lOou6tnY78sZRuvS9IWiKa6o5ifIEutEN70o=;
 b=lr2xPqirt4RZHPdAvXXR27vGtOVDTcEZccleeiAiFZsYx1bl5fjI4V+9SufdUZO4OWlALWbuY0gDiPHJeYCU7D9ePz2AUYxx6LShrIT7Gn2GIPIViD2nC6kBHiHC5c+dDuCTBMmLa/nTttE/gMNy0TcCdEk5rAutPq2pCV+bq9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 14:53:12 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9620:780c:562e:33a1]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9620:780c:562e:33a1%4]) with mapi id 15.20.6838.033; Mon, 16 Oct 2023
 14:53:11 +0000
Message-ID: <111ce50e-f445-4018-8d10-c1f7908b3198@amd.com>
Date:   Mon, 16 Oct 2023 08:53:05 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the amdgpu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Lei, Jun" <jun.lei@amd.com>,
        "Dhere, Chaitanya" <Chaitanya.Dhere@amd.com>,
        "Zhuo, Qingqing" <qingqing.zhuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Roman Li <roman.li@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231010124357.5251e100@canb.auug.org.au>
 <cc75c480-5359-465e-adab-46b418ec5d97@amd.com>
 <20231016113946.698ac2da@canb.auug.org.au>
Content-Language: en-US
From:   Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20231016113946.698ac2da@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0809.namprd03.prod.outlook.com
 (2603:10b6:408:13f::34) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b71f2d-c78b-4853-b5cf-08dbce579e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LbHDQrhM+10URp8uGqZolKaRIM/dq4hmQmzZwImdXD6e8jfXSi2qV3nfkbYE4oK02OYGNSTniPiF4rTiVGFJ+mjuwvtQFI+SCIfUSNviQql0wobWfC26qBg/t+TK/nOut61s+hwQrqXhdIwP19yjiPLqyff9f+bii2q/rTh4Hp/oC1HY2/lOlzhGSm7l+hXpBKKJUfGS2rM6tlkS/0KIZ3eEVisBFopmsRTuHbf+Ih/u50NAX+LjqI+1QJvzgWOYl4uTjF0gALUhV9tUWC2sOsNVmctTprhe6/nY62UDJcA2J1K9dZa1Uuh5BgD1VuDgEL+8NUNP5sP7izqtUrNIkDCYy7xCgVmjFaRfp6vW5BfldkAAZuLOiQ3o6NHOaIZVLmpq/fx/bVFYsQZpR4HiR1eCpwA6ZvWmfKML++eucqwGdnglfUYcmMRCYtA2bXVIM2wG+bS7jeEiDC1SopfbU2z2N3sHj5GeSwls5kB2XlAYdg7XQFS8lsWxGRi2fLEkkhZO5gTd4WAsHSuksURZ5jFW/A+MUxiruXCZBVhO12lQBREV9qK8ch3kUjeEkqOu/4b4C43aSaRS+PEIDsQ+R408Rx65qlCrGJy1phYbdM0pm+EkyVJDkmIHOf1uI0CI8dAPMhdUoSFeDSFuVF9Vuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB2941.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(346002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(66946007)(2906002)(41300700001)(86362001)(6486002)(966005)(478600001)(31696002)(66556008)(36756003)(66476007)(54906003)(53546011)(6916009)(6666004)(6512007)(6506007)(316002)(8676002)(8936002)(26005)(2616005)(31686004)(4326008)(5660300002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3NjT2RjVWZjMk1xa1Jla2tvZURjOEVOclRYeGk2WjJIUmliWWI4M1FHS2NR?=
 =?utf-8?B?VUpjaGZSK3U2d2pkc0d0U0NLazhZeFRwSTVFZlBzeVNWV2MxZDd1bVlobVdQ?=
 =?utf-8?B?ODFkQkZnKzdGdHRDaU93ZllxeW9HaXZtdU1QT21lNU9MUEpTTVAxQ1RBWmRP?=
 =?utf-8?B?dWhjeDhaZlU3NTBiY3o5VDJhb2M5ai92RDdYeFNkcGZuYTdjbEZST1FqWjJ3?=
 =?utf-8?B?WnZKSGFDMFZUSG9KaXlWNjlNdWRQdFpvSEkraGM4WHB5cjRIdVFML0twUytr?=
 =?utf-8?B?OWhvcHllSCtPSGRNNWNTT08vV28zT2tuZ0d2K2N3VHA4d3VVeGFIcjJUTzkx?=
 =?utf-8?B?RDJ6dDl3emFia1JQYnBydVg3OWw0ZUl0QngvaE5WMjBiRWRMMzlRWFdtb3ds?=
 =?utf-8?B?UTJJREx1OCtJYVRISWhSbkU1a0ZOL0JaamxpVTlmV1lPeE9qVVpvcGVJdkg5?=
 =?utf-8?B?MHpHaTRaR3lkMWRaYXdHOUltYkVSQUN4RU11TEtRaFlHS3hjUlhKYjdWUWVC?=
 =?utf-8?B?bEp6bDdmbCtzV0FPQ0wwUVFLSWc5RzhtREg3WmlUVkx4TXVwaGw3MCtqMm45?=
 =?utf-8?B?WmRKZ0dXaklxYWVwV0FOOHAwZXJMakUrZWpsRkIva3VybjZOd2gvTDR5dkw2?=
 =?utf-8?B?MXRXVnI2WCs2VWNlYXRQdThKS29YbDFrTkdDRkJNVk9FQlFEaVhybE1ESDlz?=
 =?utf-8?B?N1R2TXZsR2xMRTJIc2d5NVRNQVQ1UHp1TjJOVFBMWFpkSjlPcGEyMUVQRURk?=
 =?utf-8?B?QXpTNkNSWE1odDBNSXV1UnpDZnRJVjRueHlpWmhiNFlNbGhONzd0elVOSlVy?=
 =?utf-8?B?SkhpUDYycmJpamdCenppbWRIM2lyS3hEUzhHZ1p3ZjAvMW56K0tKOTJYS2o1?=
 =?utf-8?B?MDNWdk1TZzFNTnIvOGVwNTRKMmsrdmpicnBMRmVjUFFNOGNzL3dHT0JCcGpC?=
 =?utf-8?B?UFN6Y29VTjFwU1lqVC9oY0hxQ2VKN3dMeWwvQStUdm0zQ09pRmJTVDgzWDNT?=
 =?utf-8?B?S1p1ekZhMWQwamdKS1R0U1BGQnN0Z2JMdVMrMkRlSTd3SUkrQUJoK0xjNWp4?=
 =?utf-8?B?Y2NtNEx6MmVPNjVrUk5CTWpobWVxN3FTUU9Db0lNZWpuc3lnbjBCRkErd3RN?=
 =?utf-8?B?RWdYUTBtU2VSdTFRYm5wWDFzK0xVRWJBZEhXT2pLNkYvb0JxVjJSbUdrclJQ?=
 =?utf-8?B?WEtOUnhBM0RzVlZRNUJMeW44M1lFMXJhR09Ub1JNekc2RXJPZGVTWExRWEIw?=
 =?utf-8?B?Q1RwZ0JtWENpWlpsSU9oWkUzSVpKK21ZZVprSG9TajhsWTlzRktIZUMvUlZF?=
 =?utf-8?B?K1ZFaVJ6WUpIUStBNlhuVmVqMmFGYW4yQ1NGWjBPSEI4cTRCK1BMdVRIajF1?=
 =?utf-8?B?SXUvUVA1YmlKVHNlUUdsSCt3TGMyT3lKaWVIa2YzOWtpRHRqcnFQcHlqcUIv?=
 =?utf-8?B?R2IrdTZaaXhxeWJQcGpkS3hhVWRjbXdGTWkySGoyTFUxZDl1Z3p5TkRQR2dB?=
 =?utf-8?B?TFQ2QTgyU291UTNOV24vWkNMREdMQXFXRVlzK1A0a251RXdlMWpXWUpTZzRM?=
 =?utf-8?B?WnhmdzdYeFUzb29YQmU0TnBDN3U3UUVlQTJYcGhjTE5TQTBCL3pNd2l4NW0y?=
 =?utf-8?B?N2h5NnlpRjZvMnJUbGl6RHFSRERPV0lJU3g3dVVBNi85cUZnUWhLUy9jYW1s?=
 =?utf-8?B?eXlhbWkrTWNXS1NSc1JHclRnRGo3dXc2T1lQM3NtakdDb1JuR1RFTGl6Si9B?=
 =?utf-8?B?dXkzQkN0Ynd2MUhLem8wVFBxOEhUV0dBRmIrcTc0SVFQYk9CS2ZUZmY5bVph?=
 =?utf-8?B?eDRTZ3REVnhqRXNCcU5rWmozUnFjZlBMWGRUT0VmTy9lQXQ1MHNlb1FTalEx?=
 =?utf-8?B?SzI3dU51NDRrQ0dxVHZMTW8vL2pMd3BTVG95S1ZxTnZTbVdpcU1BSHdBTEFr?=
 =?utf-8?B?RndGWEhpTjMrUElCc3BRcjRVOGorcHRVVmR1VWQremNCUTFjTUpsNHAxK1hX?=
 =?utf-8?B?R3g5Z21qQWVvOEk3SktrN3FJWlZOM0pLa00vcW5JZkhpM2lCY0NLeHRHYU82?=
 =?utf-8?B?aFBYVjFHR2RVMEd4Uno3WFdZSWdEVVN4QW5Tck5TeTJsWHRzemV0YzdzRER5?=
 =?utf-8?Q?zgUGUxAZCdxk8KgdN7oXV8bi0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b71f2d-c78b-4853-b5cf-08dbce579e33
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 14:53:11.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbjijH3LREHFrSVLsOAskTBKayu4Wx9q0kacdqSUNabI9u9qTDEFa49IuFwWCKaaTkaqUUdOJVuCAEdH8jjwUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/23 18:39, Stephen Rothwell wrote:
> Hi Rodrigo,
> 
> On Tue, 10 Oct 2023 15:14:46 -0600 Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com> wrote:
>>
>> I think I have a fix for that, but some things are unclear to me. I'm
>> only able to see this issue when using allmodconfig. Additionally,
>> when I inspected the function, it had a few local variables, not
>> enough to explode the stack size fwiu. Is there any option in the
>> allmodconfig that makes it easy to see this issue? Maybe something
>> that I'm missing in my custom config file? Is it possible that
>> allmodconfig enables some option that might increase the stack size?
>> Perhaps the FPU flags from GCC include something else in the stack?
>>
>> Also, for investigating this issue, I'm considering the local
>> variables, but as you can see from dml_core_mode_support, it has a
>> few pointers. Am I missing something?
> 
> This could possibly be caused by inlining of other functions that are
> static within the same file.
> 
> Other than that, I am also at a loss.

Hi Stephen,

Could you try this patchset?

https://lore.kernel.org/amd-gfx/20231016142031.241912-1-Rodrigo.Siqueira@amd.com/T/#t

Thanks
Siqueira
