Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6107A4BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbjIRPVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbjIRPVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:21:50 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB6710EF;
        Mon, 18 Sep 2023 08:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OysIa0QlFFqhGcgz5HXreISGKAcWvCJFkW7VFoK2Z2AHZ1lnt0e4/0+PbFJRhk3UFTkFqIJ1QinHqLtggrwpUu8RIw5Vmn773RUk0hERHPeFB6/ItufPDP+raOvRI27xQxAGyHZ1H3dsO/L/RVUop5jPm03bG366T32xwCmrR1mT/rd597hfSs45NzSsmpQ4MKu/7HJKz0QA3utVtieMYG4joCDnapqIwE9fLYgB/MbmSAVAvh2HyEE620XxRMQhZYzDkC/q4YZ01jXcDJKnAGwA7qIH7PYVKBlcZ4vSLdkGXzYeQ+qtk3bB4lvJchq1TPrvtCbQEwOLfLjGPRTntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewNxRJrCj9dpZmhS5F2XIDiUkK/IT4IzJFBNNZvIkPE=;
 b=BONwUVrwjDxrH2YHUEFCERK7giGlaMOcncx8INNP3RM7oBGGgvCwz8h0ghCWJaV9lMbWe13Q1c3ZZzxBMk+PMY7Qg6pfNf8bt5RHuAQRkM22dvXISSLjCPWHiSXOgPynKmsSR7Shj7DiLVkWiW2hM3Ku/J4NzaJwM3UHojKGIb2xMPpbsn6/Cdsed65MhzT9qdXL8wEzn10jaUGrVcL8GEAI58G3Js2psGIYIcbxaflZhAl8fougjFvKaqIzCd7SWsQIet/QrreBQMLQXTwiPBFX0EBmdFgAUuqBcNAv8SUyCO+oALC9NfkYXatzzuH+TL90QWBuGYDcFT3Hv7M5Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewNxRJrCj9dpZmhS5F2XIDiUkK/IT4IzJFBNNZvIkPE=;
 b=avhhocv6nR4dBXMcbK/m6wUHXEgYngcOuirsCFV/RCXl5Q1/ZiibR459aHhAtS5FCsDTh9i3mkqy4oSTqj7aou7Hd1kcwpaD8o+aXk1VFv527/W6RhFwlWxtU8DnSmSkKACDR7j/JARlU0sX3Ec8DYcJy6AMqDtwbCFmKwp058Nkaof3k+fLR+M0cZvKUXT5IovGLl3wVl4bXT5K+81s/aVilE/Dj+mg/cbiiIsqcbvRgRNTUyzG9geitVA51PzjT80fnIE4pmQ2c/m5uU4S79JdNY0f2qg/zzKVGpQnLoxIC0GrG3XzFcByrPvAnyUiESAhv8JOGgLSKnUZCLf8Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 18 Sep
 2023 14:44:57 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 14:44:57 +0000
Message-ID: <5241ef7b-dfa3-625c-0aa0-4af10a1c1a52@nvidia.com>
Date:   Mon, 18 Sep 2023 15:44:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.5 000/285] 6.5.4-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Sameer Pujar <spujar@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20230917191051.639202302@linuxfoundation.org>
 <dfe78c1a-8322-413b-f1b7-3a6a307a831c@nvidia.com>
 <e5a0e1cc-1360-23fe-408d-03f46dd76c5f@nvidia.com>
 <2023091850-gossip-denatured-ce2b@gregkh>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <2023091850-gossip-denatured-ce2b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0115.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::19) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5ffb1e-0831-4ebf-8e62-08dbb855d401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c462RqGY+RmTjUR5D7c8PW2fFGMFtFg3qoTSiB22H7NiL3XWLPcUE+5T5A86C9NW4sWJgn3LQwmM7hsTfYcEwbtb4mCjxr0CNDqf/CXTFQRtZldbb1yF0p25iMmdn+hRMbmemyBV/E/UJhvhFDjUYDaDiSTqd5nHmSpXAPT8Eaz27iiRlp4Qt+i1IWNmPOeP4LnoDRkgqiFpL2O9aJDQSGzuXcdvdRwJqVlPorWq+nnGwrq3IGtmjrc97bJiSwk1ouDJ4rTsk6g/zEtyyslRqm0wxQ9zcyoNONmV0XzQlqQKDbsVr3UtjbFVNKgPkKblgN6oGz0JqohFOQRDRJAgUqqRNaJqp3RWzZbgmPpB/yIyR+3VvTkxnAIGKgQzihGgwivofhE9n2fkmLPqLQIjCv9b/tMiBDmMokIxERgZNfneC3tMvMAf3ED787JPgwUPcumrq03P5+JMm6C1p0bcnU+3VMxS64jOpWC8wfzMMbA3b3l2eqefRPj041vx/odwTPRxFM3DrZKw3dSh0rk9BUhS6U3kxuZ3iPyhuEJXD3/uBkNmLuxVuBRzSIzfwBXIG0L9rXjO/yH4phs8JZHiFT3uT49aUZ3kCXC7z5Kjb92JsWK/zDUXbhcydqqkAYXT6QF6miscPxKpF9QRUHaPWKaLndZrh+JKUapOdLc9xFTAHpNPVwWvjeI0pruv5k1a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199024)(1800799009)(186009)(53546011)(6506007)(6666004)(6486002)(478600001)(966005)(83380400001)(2616005)(6512007)(41300700001)(7416002)(66476007)(5660300002)(66946007)(66556008)(8676002)(54906003)(316002)(6916009)(8936002)(4326008)(31696002)(36756003)(2906002)(38100700002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1YxekpQUlBiYnFFZ1JNY2g4M0NRUEJQY3I5VVo4NjNMTzRzTGxFQms4Wmwr?=
 =?utf-8?B?dGFoOFQ0S2IwcHl3UFQ2TTB4K0dObkJBRHZqb1Fnb2c2c3NObGswSVdPaWho?=
 =?utf-8?B?dEFuYXFpemNKRHFaSms1Mit4V28wNUl2ZlpUV3Y1dUxpQmIrdStQTU9zb3BJ?=
 =?utf-8?B?L0t6RTFrZDRocm9WME1aMUtjSExjQUFjWUdPNnEwaStyZk9XUlpFczJ0YWhm?=
 =?utf-8?B?N3dQVmhPSVhYTWpwMkNLRlhzcEpLZEZqdkd4Q2ZqMzdsY2pSSEM4anRsNFhp?=
 =?utf-8?B?RDAvMTAyTitlV0paRVVFUnAvKzJNNS94M0Z4ekZsZ3BLWUpPeDVpLzJLUld4?=
 =?utf-8?B?eCt5R2NqR3NESHB2TklPcnpubERxOVdyaFhYeVQzN1U2bzU5K3FPb1JnSlJX?=
 =?utf-8?B?UXAwK0VweWtYYkFObnJQVmg3enJUbHkva2hnYitzZFhQdkZyczc0djh1dDRa?=
 =?utf-8?B?bnErYUxKdDdZMnhPWmQxQ05DWnk4V1NNbXFHbjhHKy9PQUFSY1lMQ1ppcnE1?=
 =?utf-8?B?V29pOHp2QXBrbzlKSHZ3UW1VMDB5enJDaUxqWGlFcW5Xb3ZzQWhtdlRiN1Fi?=
 =?utf-8?B?WU14aU04SFlwZmMxSnUvYU1kL3h6QUxxR3JNWGppWTRMMG1OTFFQMjN0Sm1h?=
 =?utf-8?B?Q3N0WldJRFc4N3pYVnNRZnhrLzFHeFFDSi9DVVV4d1RHZkp5MmdvdVhURGJU?=
 =?utf-8?B?SHNJRms2ZDR4QSt5SmZLYkZBdU41cE1OcktnTE1YOVcybU1PaGlSYk5pYVJM?=
 =?utf-8?B?YWhmZmNIcTFWT1FCRHZ5RCtFczFPS3VVbnFNZ1o5Z0pvOEo2dHN3cnIvazRv?=
 =?utf-8?B?SlU5Mnp0ODFRT0dMMjErbnpJanRPWDdzV0pqbXV6Uk9jWFNRRTZucUY3M3FD?=
 =?utf-8?B?QW9UUloyS2lya1RtTUw3bzBybXVnVzZXUzZIU0YwL2c2K3lIVkhVTEVRL3hs?=
 =?utf-8?B?SisrSkNDYTZQL0NwOUpPQkx0dEE5dkx0bzlhUDBzNnk2aWpMSzFMZ1dJRXZt?=
 =?utf-8?B?bW9ZY3RSeTNiM2xsNngzV1hSRWFEVUxwL3JOb09iSStsVDZ6elR2MWtnK0M1?=
 =?utf-8?B?NHFCQ3N5NnoxemxGSm4wcmlMbUwvVVloWmdnQ0FoM2tyaEJjUW1SS0lWN0NW?=
 =?utf-8?B?ZzYrZkx6MjI5elFqaGJDeGN4bXhLdXJjNFNJMXdYdHJHNGkvL2RESStLdnRw?=
 =?utf-8?B?UlRybThMb2c4NFMvdjdRMDBvYnh2cXdKVDllMzFHYUlUNk5LdWNKaUs1U0l3?=
 =?utf-8?B?aWNuR2VFNnJBekk4ME44dEV4aHZzeTk5UkdrZ1NmVUcrVmVYU2NCa1hMckJK?=
 =?utf-8?B?TWh3ekVYWDFjaENzWWUwU1J6dWV5cm1ET251ajkvRlZweGZMNDFLc3Exdm5O?=
 =?utf-8?B?YXBDZG9TRTdqTXRtMGU0RlRNTUNQcHBDcmFGQXZ3Z1YxWUdBbEYzMzBFMGUx?=
 =?utf-8?B?eG05Vks5RnB1YTJBMm9lbTg4RkNwaHd4MzBTZWhKZE93a0dsWEUyYU51UDNQ?=
 =?utf-8?B?RWcvR2tETjJzMFFTU1gzWk5YVnVud2pmNVEzRDZSOVRiODd5MmpydFdxb2F5?=
 =?utf-8?B?eEM5L2lwaXpMV0tWL1BNaDAyVXM4b0tsc1htV0l0S3N1RTgvZDBWbFpId1JE?=
 =?utf-8?B?eTB3SVJkSk03NXh3V0JmeTJjRm5nMTNudXBMS3hzMFcxL1BiSjNaRXEvR0VM?=
 =?utf-8?B?b2h2ZkRQcEZJbUpUTVoxaGZuckhsRU5leXBzQlFMbkVESGhTRmp5c2NURFNO?=
 =?utf-8?B?TFZSU0Zkc1BSYWhjNFV3S3haMW5QL2N5M3dNeEh3U2FPY0dsYjh2MEpQQ2hM?=
 =?utf-8?B?Tlk3MnlRU1RNMHU4RWxCc3F4eXcrVkM1dXZGaWF3RTE4T3l5bldhTWdvclV3?=
 =?utf-8?B?eFU3UDVIOVpoWDRvRW9zVXptRWhzNjRGaHpnTGF3Y3U3YkgvY1JhQzlqTUFH?=
 =?utf-8?B?TVJ0ck1nUjR2MHdCTE5Ba0hXbVNTZEhWSWNUVXhwM2luOE5pUTByaTlScHRH?=
 =?utf-8?B?ZGFOOXNsazQ1UVNEdmtYUHYyOWFabU5COVB0cFk0Qjl4a0FaSzNER0Q4cTJz?=
 =?utf-8?B?QlBKTnJvWGZ0UEVVWEJBZHNJUlo2ZXA5bnF5dEgwWC8zZkVtVkFWTU52bUIv?=
 =?utf-8?B?bWNxeGtIbENVV3lxd203TEtLWkJGOTl3TWJYa1BUMVZFRUpyNTBGR3lCOG1y?=
 =?utf-8?B?TUx5d3VUM3lNdTB2NTRoRG9WbThRT21KQ0dmSHJJVS8ySE1hOTJIZWtLbWxU?=
 =?utf-8?B?YXl3VElEeW5sMUNYNHRyTlViR3dBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5ffb1e-0831-4ebf-8e62-08dbb855d401
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 14:44:57.2662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/ZKvowajtHjq76vJzAM6Hc3Y95P9M8QtfPtpBffwZhxwQa+hp9qaW/RJMsD9iCFdCP+k6gQH8NC9D1sN4pFzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/09/2023 14:14, Greg Kroah-Hartman wrote:
> On Mon, Sep 18, 2023 at 02:04:27PM +0100, Jon Hunter wrote:
>>
>> On 18/09/2023 13:52, Jon Hunter wrote:
>>> Hi Greg,
>>>
>>> On 17/09/2023 20:10, Greg Kroah-Hartman wrote:
>>>> This is the start of the stable review cycle for the 6.5.4 release.
>>>> There are 285 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
>>>> Anything received after that time might be too late.
>>>>
>>>> The whole patch series can be found in one patch at:
>>>>      https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.4-rc1.gz
>>>> or in the git tree and branch at:
>>>>      git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
>>>> and the diffstat can be found below.
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>>
>>>> -------------
>>>> Pseudo-Shortlog of commits:
>>>
>>> ...
>>>
>>>> Sameer Pujar <spujar@nvidia.com>
>>>>       arm64: tegra: Update AHUB clock parent and rate
>>>
>>>
>>> Unfortunately, the above change is causing a regression in one of our
>>> audio tests and we are looking into why this is.
>>>
>>> Can we drop this from stable for now?
>>
>>
>> An alternative to dropping this change is to pull in the following fixes ...
>>
>> https://lore.kernel.org/linux-tegra/169447691068.2390116.10518505217580469969.b4-ty@kernel.org/T/#t
> 
> they aren't in Linus's tree yet, any plans on when that will happen?


Not clear at the moment, I see Mark has them queued up here ...

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/log/?h=for-6.6 	
  
> And to confirm, what are the git ids of these in linux-next?


In next I see the following git ids ...

e765886249c5 ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates
f101583fa9f8 ASoC: soc-utils: Export snd_soc_dai_is_dummy() symbol


Thanks
Jon

-- 
nvpublic
