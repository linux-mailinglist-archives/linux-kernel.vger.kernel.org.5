Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627DE7811BB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378995AbjHRRVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378966AbjHRRVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:21:11 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5FA3C2F;
        Fri, 18 Aug 2023 10:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNM+nOtw+k7Iss/ZM74uCUdaGsbgkTtqSSJYY4WRbEkJ8HrLJvp91VcH1EfnsxHvKeLzOsEUfBGFmaxNVmKL4BLXdCQ7Yp0pFok3dtUwfbkA2ljBbGOV+MsdmdapzA8+QpmrztP6T52wAVVoQ1zMophIW0lyODx35r5iCOwWxCtUkCdUyI3crohliS4RtCEDwFZwApwcDKu/gOWoZ2bukAn5J7vIpNvAfHepqG0qi9aRa/frA5ciddjs7hfCAllm8SjFuUvCeh8XJ+Ze4cIVBklrhbN6f2d4sXFHT51zmPv3dfZFbYkYRVnJwDbj5/7HgVttYGcUWmq0xmSDRmX1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcIn4WjdzY7GDWZm0EKQ+Yb3h848ZIcwSL8CDQAG/sw=;
 b=IzKx+XSdgfz5a66fdzXZcmRG6UzP/udst91BOjizlwdTUb3hk4CxmDwLDO44hmydNKg1fNofovUG3ySPut6dI0Fb+G0Wg9vhuJyVfE6FhC/UkAER+h66U5BF6nUh7lNbuYClaJ7vOppCvJjGrx1pLiC61DjHsdz8+lGNWi2VKHLyp8ldngbAwHHJASgRE5aA36xFWvPhMFNSdMQfk5vzDkGQlizBG2x6dEGhLXXG6gFXj3f0p86FCtuL1eCqiwbNpsYm+bIS19tfw9mgC0yY9JJrEcq8zKOs+PP3ImIaz96K6TjPE7qPvo1V3FAxJ0hTZklykUG3pXhYlzogrvgJ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcIn4WjdzY7GDWZm0EKQ+Yb3h848ZIcwSL8CDQAG/sw=;
 b=tkTHLlCiYofHHHmShcmdUGiVcHYe6roRhFCkmq9k/NfoO2lOFGrUxD9nyQIQ/3FS4MiWCPNHTiUWT1IXUY08O2yHBlCirbXzDd9H7y72V1EmtFJpPF4px5LG6h7POcZBSR9MA7FEQEhnsRy+shWx0x5rf5LQD0uwelMxpbI5Cak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 17:21:06 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 17:21:06 +0000
Message-ID: <92b93b79-14b9-46fe-9d4f-f44ab75fd229@amd.com>
Date:   Fri, 18 Aug 2023 12:21:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: REGRESSION WITH BISECT: v6.5-rc6 TPM patch breaks S3 on some
 Intel systems
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, todd.e.brandt@linux.intel.com,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, len.brown@intel.com,
        charles.d.prestopine@intel.com, rafael.j.wysocki@intel.com
References: <485e8740385239b56753ce01d8995f01f84a68e5.camel@linux.intel.com>
 <CUV5EXGO425W.1RGBLDQJ8GK9W@suppilovahvero>
 <5a344d1ffa66fac828feb3d1c6abce010da94609.camel@linux.intel.com>
 <CUV6EA5WZ2O5.5G3IV9BQITOG@suppilovahvero>
 <bd4890a3-419c-463d-88fe-905946122c9f@amd.com>
 <CUVTY0NCB0N6.VPFM83M83ZUR@suppilovahvero>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CUVTY0NCB0N6.VPFM83M83ZUR@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:5:40::33) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe878e2-e71a-493d-4a3a-08dba00f8164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 86aheSaVS3a9ii9wTCyz1ovVgdzbEjqnTgluvUv5JsS3VEKSDIoIvc0/MQQuqjmhsJ7EZHzGBmTi1wq3Dq6blRpqzAJRboNwdBEMBKqMJh+3HjhZWbFYMm019sg4aQIlsYR2Q6azX6JPK7WIpnrjWZT8jExTYJEERaWrRYf9/NxNa0tZDVQZVNb2KEwrTIeABcBEXuYhbEoXY8ywCoLyplWwrZIXgc2CND9MA41hepc2PFzSLkITKH1tnLJ1Rtce46Ra0MeOf/jHgDDCpsVfYfXshLco8FASMXBtl3ktB7EdIPTbMZQkf7CT0Q2pwY+e0MTF8HzbKOTVagQltQ3Xp5/1mGoYZNlcSlTasvphrt5oZh/wSYzGbiM481O3MPI3w09AsElHLaKfl2L5JnLWhnyX6NL5QGcEQp3Ql6keNawPvRnDlOs2HrouaNwz4CeysgUC018LM5aKOdGwFASh1+kj//T0FpA5we+Pg0oq3sLKFHF6HuBtn0bf0ouL93XUsPngzRjwL5zBSbTkVwcpccXcMGaGOJJJGkJc2w9n9f1lFCm/T7vRI7V9yFQke1mA7XU7vHVUb2Nx6clFLI1N3NMEygJDMagzPlX/a7TX/q9BlhUqHzsOQcR15PtH+QXFC0IbeSJUzJepBmYa9NXY6zbX3VMOWzLwbzJNbWmaY8bvy5+bRe00NNakk48DAu4W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(186009)(1800799009)(451199024)(6486002)(6506007)(38100700002)(6512007)(53546011)(31696002)(26005)(83380400001)(36756003)(86362001)(2616005)(2906002)(66556008)(316002)(66476007)(66946007)(41300700001)(44832011)(5660300002)(8676002)(4326008)(8936002)(478600001)(31686004)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGZlU0FIMFpMU0tDZThVUm9KSElFSGRpdTFtYkxFOHRNNldGdktlZzl5TS9D?=
 =?utf-8?B?TFd5QzlGckFMWHBVaHY2WmhFWmpXaCs2eVA0WXpPMWZqRkIxQjBXeE1VNVho?=
 =?utf-8?B?ZWhUZTdtdStDZm83L0h3T2tLYmwrYVJwemJCekZzcWVJLzJDUGRIb2Z6QUpy?=
 =?utf-8?B?NWNNS3J4L3VQUTBXNDJXdkVESW1vRjZzZUNaVzVlOWZnOGVsVkxSeC8wemc5?=
 =?utf-8?B?U0QvbzlSSWVPa3VENExwbzFjTmRvbnBFNDRQdnY3L3YxSDlNU3hmb3hDR2dY?=
 =?utf-8?B?WFFhMjNVQUkvREFWcHViUGpYZ2hqMG16UHRjTjlvd1pDbzhOV1ZIWkloYVk1?=
 =?utf-8?B?N0hQZFBBZUFpUlBkSUZMZ2paTUo3T1JFVTZGZlRrdUd2S0xaZWkzTkNlcDlj?=
 =?utf-8?B?VWNKM28xeWVMZU8xNjZLemZPc3JtWHJXbFhRc3VReG9WZ0FUcjlxVDQwc1NO?=
 =?utf-8?B?Z2dRekxBWFY5VThYbFFzUCtuc3ZWTGYxZzAvdmRkeXlNWnZORzN2TmJBN3Fp?=
 =?utf-8?B?cWFQZzV2L0sydEI4STBjNXIxQjJYaHpSWWpYbnBid2ZtaGpTYXBQSkR1SVBF?=
 =?utf-8?B?S0xYOTVTSkhjTFVqYUExZkRWYUhUWHBJNnNuQ0NEemQwWTNmdDk3dmVLRnl2?=
 =?utf-8?B?Q1F3V0lzTDlEWWRBbTd2UGU5Z0s3TkNDQlQ3emhXaTNtMHZRZEprTlBCR2Rx?=
 =?utf-8?B?TEd1UTRzRm5XRS8wM0FVeVJkQko2dndBdnVBYWdwUnEvZmlnSHJxcVZTL29r?=
 =?utf-8?B?alM4a0d3ZU1CNGY5SEdTRW1JVytSUXlWTnpOczZPY0M1NlNpYy9NeFBMUGQ3?=
 =?utf-8?B?QXRKVG5CN0pBNHY5MHNyVjNsdzVmclhXdGtibDA2MEpwU2phLzdrdlhHUEtC?=
 =?utf-8?B?Nk1PVGYrWUpRTmhRbDEwdlBzUEVSWW1icHVlRnVhNG5oQ3puSk4wdUloc1Iz?=
 =?utf-8?B?UERBMFdkZ2oxZ0djd1NIRmxTSWJreitsRWs0VEdSVmphNWZRdXQ2dmk5eWow?=
 =?utf-8?B?U3o0UnNGVTJBTEdpV0pBbGhwVjBGRENOd0F6UEliUm9taWNxVWFocmxreGhZ?=
 =?utf-8?B?cVQ5MERMWnhtdCtnY2M2ck5RV2hNVjRTT2pMTzdYTUJTdzF6eURIM2Q4Ylpl?=
 =?utf-8?B?T0ZuQlNNNFVPNUtQUlVRNHl4VHpMWlpVeU9GcTV3c2hyVEE0a056OU92SVZH?=
 =?utf-8?B?WVdSSU9GYVRDb3FYME16YTZzdFV2T1NpNHRPRTRHWmhUUEdyNVVVNFZ2OExQ?=
 =?utf-8?B?Q05KbUo0M0ZxQmFMSG1pVWd0MmZaTTlmOE82NCttNjkrMXhHNXJqNnk4T0dl?=
 =?utf-8?B?ZDZRaUtKa1hmMnJ5Ykl0MGFiUXEwbjRqdmhyNWx3a2RTaWhrcjdtejhVYWZR?=
 =?utf-8?B?L2xXNmFVQ2h3T2NEZUJXN3cxaHk3UUFJTVo0Nis2NGlHODVoelVKWDY2ekNH?=
 =?utf-8?B?RWRCalU3K0xNZTk0MVd4ZDcwbFI1ZHR1VVdsVTUraVlUOE92ZGk3QVFwT09Z?=
 =?utf-8?B?OG9HemtLTDl2WVdlaXREcWdzUEZkRkZyR0p0dzFtRjJmL0gwZHV4bmF4RytG?=
 =?utf-8?B?cUFWeWFuWGRJb0NnOTRsZFBNQzhzTjNDdndvSHY1a0N4UHJUUkFoem1VQUNO?=
 =?utf-8?B?T0RMd29BTzBlN3FTeStjUEowOUR5clNnTGs3cWpyMDdzd3dQVEhXQ3pkNkJa?=
 =?utf-8?B?cU41VHk4VFNxS1N2OTdxYzBvamhmSDd6bW9uV1BXeHEzUDcwV2JsVldQTUN5?=
 =?utf-8?B?VDJHRkxSZitVQnhyTU9uU3hiYzJsS0x2SEVqY25wWVR0SzZiN2JwQUpOanp6?=
 =?utf-8?B?OTl4K21Vbk52bDJXWjVLRjZZQngrYXRBdGxnQTRpa0VncmZwTmRGcjRENG5i?=
 =?utf-8?B?eXc4ZEtnYTlscFd6dHZTeWhHN3hiUG5JdGU3Y2g5TlpxNi96UzQ2SDZmY0No?=
 =?utf-8?B?RXhzMzFvOTZQd05nTk9EcWJxL3V6eHhBdlUwYnBYZUdpNjVaMmFUN2doVGdX?=
 =?utf-8?B?bVV6SlVBa3JxSjdnWnQ5SkFmWHJNLytmOS84SFJ6R09WaWdkMUNWMTAxWllZ?=
 =?utf-8?B?aUJYMlhOVXcwVzZSS2FtR2NsMlY1UWo3QkRpWGpuWEJKZTJId1Jwd2xBL3FB?=
 =?utf-8?Q?/f4OQiqMeXpu72cMzfQ6XmrwF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe878e2-e71a-493d-4a3a-08dba00f8164
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 17:21:06.0019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9ufuoDPTY48Kz+ArASBDf2Q072Gd7r0NdqujwUedHM5lm/tn2Palbr0pm841L46IkiTPlFWg2DPz9NNjHHvsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/2023 12:00, Jarkko Sakkinen wrote:
> On Fri Aug 18, 2023 at 4:58 AM EEST, Limonciello, Mario wrote:
>>
>>
>> On 8/17/2023 5:33 PM, Jarkko Sakkinen wrote:
>>> On Fri Aug 18, 2023 at 1:25 AM EEST, Todd Brandt wrote:
>>>> On Fri, 2023-08-18 at 00:47 +0300, Jarkko Sakkinen wrote:
>>>>> On Fri Aug 18, 2023 at 12:09 AM EEST, Todd Brandt wrote:
>>>>>> While testing S3 on 6.5.0-rc6 we've found that 5 systems are seeing
>>>>>> a
>>>>>> crash and reboot situation when S3 suspend is initiated. To
>>>>>> reproduce
>>>>>> it, this call is all that's required "sudo sleepgraph -m mem
>>>>>> -rtcwake
>>>>>> 15".
>>>>>
>>>>> 1. Are there logs available?
>>>>> 2. Is this the test case: https://pypi.org/project/sleepgraph/ (never
>>>>> used it before).
>>>>
>>>> There are no dmesg logs because the S3 crash wipes them out. Sleepgraph
>>>> isn't actually necessary to activate it, just an S3 suspend "echo mem >
>>>> /sys/power/state".
>>>>
>>>> So far it appears to only have affected test systems, not production
>>>> hardware, and none of them have TPM chips, so I'm beginning to wonder
>>>> if this patch just inadvertently activated a bug somewhere else in the
>>>> kernel that happens to affect test hardware.
>>>>
>>>> I'll continue to debug it, this isn't an emergency as so far I haven't
>>>> seen it in production hardware.
>>>
>>> OK, I'll still see if I could reproduce it just in case.
>>>
>>> BR, Jarkko
>>
>> I'd like to better understand what kind of TPM initialization path has
>> run.  Does the machine have some sort of TPM that failed to fully
>> initialize perhaps?
>>
>> If you can't share a full bootup dmesg, can you at least share
>>
>> # dmesg | grep -i tpm
> 
> It would be more useful perhaps to get full dmesg output after power on
> and before going into suspend.
> 
> Also ftrace filter could be added to the kernel command-line:
> 
> ftrace=function ftrace_filter=tpm*
> 
> After bootup:
> 
> mount -t tracefs nodev /sys/kernel/tracing
> cat /sys/kernel/tracing/trace
> 
> BR, Jarkko

Todd and I have gone back and forth a little bit on the bugzilla 
(https://bugzilla.kernel.org/show_bug.cgi?id=217804), and it seems that 
this isn't an S3 problem - it's a probing problem.

[    1.132521] tpm_crb: probe of INTC6001:00 failed with error 378

That error 378 specifically matches TPM2_CC_GET_CAPABILITY, which is the 
same command that was being requested.  This leads me to believe the TPM 
isn't ready at the time of probing.

In this case one solution is we could potentially ignore failures for 
that tpm2_get_tpm_pt() call, but I think we should first understand why 
it doesn't work at probing time for this TPM to ensure the actual quirk
isn't built on a house of cards.
