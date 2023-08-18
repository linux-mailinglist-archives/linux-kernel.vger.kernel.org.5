Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BB9780398
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357156AbjHRB7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357152AbjHRB6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:58:49 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C659FE;
        Thu, 17 Aug 2023 18:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g40pXMFsQsN6BgOUYLJNfCgOOO30RzkKkb1hwn3Gm1M28i7EFlr0RPaExbK7tMxFmXZg3YmiZMOvucAVTaSitK7zUz2ixBcPLKej4Px5jg/KNXsuGvYjaLK/eWVCfC7QvVyVf4Eui5uYtUw3wBM9WStCoq9xODktDND9MkWpEzYhn13DqoV/MF5AKhoHThL7+K/QRzjyF2OnoGBuV6ZdV69jd10yfYV3gao/ARmf6OsMT8qwzshVjERO4dvEuDgFZ9jm2FTZu8TG9cTBPqec3Ynfldx4m3SLXz5TJVQrqCSRdUD79xwfNsGMvNsq1C+1yZERPqNOSSxPWIM/IzQsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KjCxg71uJ/xF2fQiTOBcG2xZVuCybYhGDeTGJ9K+pI=;
 b=G0wh9ptzCMIpom5rGgo/58tl4Y0QYklKGeYNcW+bBvyhLFoddYN2aVKWTKMsgj5uCyZ5VQoGkwvXLDZfFHF8DCkYG8+7wzD76NxRcrDgjiwAZzXH0WZ/AmITla5Jbpr7vNqNdNkFIftry/rlP3U+d5HhZo0mSrM1nMk2v/AckJ5EX2gjJsDXaCA0aiPfjVQuvK6Dtoez69psQ8sqFAknacr73k8GJKOyd4vI5lVU03oZIaNYW4ODDraQi700uWNRmq9MUHS8SJh9Whzx3hjU1itJ8ow7zeAQum/oxUVk4yAtaG8VitifrjzA3szop39yMgyBnqfo4rxrTpS+/3YdRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KjCxg71uJ/xF2fQiTOBcG2xZVuCybYhGDeTGJ9K+pI=;
 b=qIq6S8/48eG3/Awh06bKXFbzo6cEoPAX8l0tvlaGBSPA6ShI/AH+jY2NT8oE7u7uAUfQ31RP9AmbYxBcHTpf38ttGJURL0LjgpVbI0zihjakY0+hxM72GeBclOub2YdElW8GpFOLvwyEMBFHtPfnDlm96x+gX63mpxutNCCq4vY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 01:58:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.029; Fri, 18 Aug 2023
 01:58:45 +0000
Message-ID: <bd4890a3-419c-463d-88fe-905946122c9f@amd.com>
Date:   Thu, 17 Aug 2023 20:58:42 -0500
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
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CUV6EA5WZ2O5.5G3IV9BQITOG@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:806:a7::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b03a53a-0d16-43e6-7dca-08db9f8ea7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kn+6+vILSjX47O0qBR32uP2jCzTGGEn7b3kXZJ3+EVfMsg5C6v41vFg/4fWWDRsJLyfvyf2e32fv8uzUUqsW8Uuamm/9XypdtSZ7dCRNqD84n3jptJmH+1YcbwISv9G8WZdESmBWHZXPEkaKD7zW54QW76NvynHG/9yAVVNZF8oE/DCWCDwVSon0FP5aV1iJPw+Rnsa+2sLXrWyYpdUO/PbNU3QQhhernEvnn3gJ5NJVXIuG5y7hL6qkNk8ZXybXXRM+A8J53jjZqwcpstIJxYk4hDmPCKAnBuInR9s4EIBFJJ7llhltNADWzja2oq2waz2QZuK1U2HJmezCMqvcBU8P+WwPhCUOWkjZkqN7guAjP7ZNt5p5bwq3ywtKBuDZeBp8Lol57Us3dQMh50iZfcdew/rn5fRkbNgrZc+vVldTefD1YnxI6QT+YVJ2+OuvVxDPOi/jcp7Kfulp4ZUwVqUvL7hYPTLJM6nMoRYk8YG0cqXDmGFNH/ZHRAy0MXSQ7AYbeK1CHwSn5U49zTSBQOSQo5YF81c7/tqd7v0NDdjpnUA73DqPCGa66CsLcEQY5PKL4HOYEm+eW2+gY/a9r2sOtEh+lB0qAkL+HM/8ZkEEEsSMMfbM3YySCHsDolUeWoUGDSeM22TQlzSI0poJYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199024)(1800799009)(186009)(31686004)(86362001)(31696002)(36756003)(38100700002)(966005)(2616005)(5660300002)(66556008)(478600001)(6506007)(66946007)(66476007)(6666004)(53546011)(6486002)(316002)(26005)(6512007)(4326008)(8676002)(8936002)(41300700001)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ektydXR6Tk4xbklVcEtPcmZNdWlOQ2dqaTltNytEYnNPMGlxS1VDdmpDM0lG?=
 =?utf-8?B?TUw3RUZpYy8rZDJSV013ZndVTUx0Yk5QYnEzdDVud1NVMTRiYkVnMFVnelpH?=
 =?utf-8?B?TDJ2Ri8zbFZnZGZaR0ZRTlppZkZpQmRmT0tPNTZzbzFJeGJHV2hneG1ZNnRm?=
 =?utf-8?B?V0RoclRTZ256dThFTy9GVVA5dFhwdE80VnlCT00xc2lZeUNkUGlBWmhkcE5C?=
 =?utf-8?B?ZWxYMmtxOHZvbXB0K0cyN2lwUUhRZVptTDZvdDdJbGxsQzEwVnpOZUtHTytQ?=
 =?utf-8?B?QlVRazUyZFc2b0cyNDNCQUwveVBiRmpRQjBobFlTSWNKcDQyd0hiTENvVHJP?=
 =?utf-8?B?aW02UExyUVlSN1hmSlpTZVJvcGVFUDBqVXRUSnVpbnBOdjVFb2tkOFJVUkFJ?=
 =?utf-8?B?WUQ1Vm9aQ1BhVkc0M05rZjJZK0RNUmNWMkZnd1o0Ly9TUDZ1NjZua2JTSlor?=
 =?utf-8?B?MUlBaFM0d2lkelpVZGJ0TjRKMlVjWWlHOFNENWhOZGFFTWd3RkRPbGphUkhi?=
 =?utf-8?B?UHhKR3hVUFQ1UG0rMThKQi90d1pTK0ttYzhFNnFwSkF4UmJicDZpNnpoVDN2?=
 =?utf-8?B?RFpQL3dnUkdJYSt6MXY0L1F6TEtHUkxQM2dUczdBQ01ZLzZTSGFuaUoxSjJX?=
 =?utf-8?B?ZGNacmM2YUdjRVBMbGV3ZXJRbmhjTjZTZHZyRTJEYzZTd1J0SUlZa1dKUCtp?=
 =?utf-8?B?OTlERy9yUUtpdGtHd2g1RnpmNVI4OXNyYldtRjR0eGU5SVUvWXAyaWwvemlt?=
 =?utf-8?B?R2tDZ3FpQXZGRUlsdm9qSU8zcDdIMEZiSnNGeVhGZ0NRL2JNM0JEb21Ld2xa?=
 =?utf-8?B?TDFjTTZ5N2RaV21PSlQxNmdGSXFoY0YxbHljNUY3OUUzd2Y2dnBQRFVPcXdx?=
 =?utf-8?B?OFExbmZRWkp6VHloczcwYWNmVGxQcVdpUUZoMXNINGxMQUV3cGFJL0ZHTUlR?=
 =?utf-8?B?M05xS0I3MjJlMzdBSHdlRmdLeWp1SENaa1JNRExYUVEzTURYNFpoRzVpQkU5?=
 =?utf-8?B?VzdhZlpyNmE3Ry9HZXFSYS92bWEyelhxOWlVTmdOaGdmUnFrZndkclhnWldS?=
 =?utf-8?B?NXFuRmcvaEs1RFRoUVV5TDZPV09ITmNtUk84bzdEREJLVUxJbFJaUE1QNVV1?=
 =?utf-8?B?ZFBXV1I3K2d4citZRmt6cFN1YkFzOWw5WXRkS2NOUlpPUStXaXNMZEtyajQw?=
 =?utf-8?B?RHRXWW1HOGJkRGZXTXNDeTJwUEx4SitIYXIwc3J6MGpNcU5lT0xwNlAxUjVQ?=
 =?utf-8?B?VWRnR1o1OXlpREYyaGp5ajdPYUNpUm11azJDanU3NUxtanB5M0hGK1Y5ZXFV?=
 =?utf-8?B?RCtCczU0aDdsdytqTkFWS1Nzbm5jSnVpdDZVUS9vZlZrSXBCaWhxT0ROT29N?=
 =?utf-8?B?aW5YbCs5ZE9PaFd4a0hiZGt1d2lWWk40Z1BPNXQ4QjFYTnk4RCt3VWN3QXZ3?=
 =?utf-8?B?N0pVL3pIdUN2WVFxaHVWYnM3aHNxQk5VR3JrRlc1QThLcHpTQUEycDFXQzlG?=
 =?utf-8?B?VEZKeEdYRjJaUTFEalVibFdnaDdGRWJIRE5YUWI1ZUlvZzNROFlGeHJSbXZ2?=
 =?utf-8?B?SVM3UWtKWmtpWU1HSkdjTkNhNjIxUVQwZGJ3WWxVZlFoZWhJemN5T0NmUEM0?=
 =?utf-8?B?aGNCR0Y2ZTdldnlzKzZhLzhMTk1SUk14UTRvR1VQajRzZkV3OUFENFUwUXd0?=
 =?utf-8?B?VnluMkp6MkM1Qkh5WkFlZDZCNDUrM3pXVTJiSXZIQjVwc0RBSzEvNFJJRG45?=
 =?utf-8?B?eGZBS09nazB0dlk2M3R6WmlwdTlhRGhDR0pSbFErbmN6cGFiL3BMSTVmTFBG?=
 =?utf-8?B?NUxCV2JPUTVFKzNVdXQwUWpHT1ZYMHF1aWRZWS9FU0VZdTRiY3pnNXdXakFD?=
 =?utf-8?B?Nk04bTZJWGNhcXBaTUJ4dWtDNEZVcm5CLzRsZUVpaVplNUlhbkYvZnM3djI3?=
 =?utf-8?B?ZjFKSTZwQjZMWDhGNFd1T3RDODdxeVZXalpCUlB0eXJkd0dGQTIycmNheGpq?=
 =?utf-8?B?eEoraGtKTU1ocGhCSEtPY3gxTDhJekpaM3hFWDNlM3RaTllpeFJqQWZwZytv?=
 =?utf-8?B?L0lpaUM0MEpkamRXZVFDeWtqazN3dGVKRlJTRVM3MGUwalQ5UThPaVdyeVNl?=
 =?utf-8?Q?QDWibZ92SNzi0QsbWpiwiP5GK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b03a53a-0d16-43e6-7dca-08db9f8ea7a2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 01:58:45.2274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gs3vsjcQRoGzREWUwtfdvUO1rD6pFq4e5z2A+RerJnAZiID4XYI7DI5hgghuBmYI3SVNcedHbSYsrLoabTstxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/2023 5:33 PM, Jarkko Sakkinen wrote:
> On Fri Aug 18, 2023 at 1:25 AM EEST, Todd Brandt wrote:
>> On Fri, 2023-08-18 at 00:47 +0300, Jarkko Sakkinen wrote:
>>> On Fri Aug 18, 2023 at 12:09 AM EEST, Todd Brandt wrote:
>>>> While testing S3 on 6.5.0-rc6 we've found that 5 systems are seeing
>>>> a
>>>> crash and reboot situation when S3 suspend is initiated. To
>>>> reproduce
>>>> it, this call is all that's required "sudo sleepgraph -m mem
>>>> -rtcwake
>>>> 15".
>>>
>>> 1. Are there logs available?
>>> 2. Is this the test case: https://pypi.org/project/sleepgraph/ (never
>>> used it before).
>>
>> There are no dmesg logs because the S3 crash wipes them out. Sleepgraph
>> isn't actually necessary to activate it, just an S3 suspend "echo mem >
>> /sys/power/state".
>>
>> So far it appears to only have affected test systems, not production
>> hardware, and none of them have TPM chips, so I'm beginning to wonder
>> if this patch just inadvertently activated a bug somewhere else in the
>> kernel that happens to affect test hardware.
>>
>> I'll continue to debug it, this isn't an emergency as so far I haven't
>> seen it in production hardware.
> 
> OK, I'll still see if I could reproduce it just in case.
> 
> BR, Jarkko

I'd like to better understand what kind of TPM initialization path has 
run.  Does the machine have some sort of TPM that failed to fully 
initialize perhaps?

If you can't share a full bootup dmesg, can you at least share

# dmesg | grep -i tpm

I think it would be really good to try the following:

0) Start with a machine without this patch in place
1) At bootup run this command:
# tpm2_getcap properties-fixed
2) Suspend machine
3) Repeat that command after suspend
4) Reboot with that patch and repeat steps 1 and 2.
