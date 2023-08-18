Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D6C7815EF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 01:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242946AbjHRX6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 19:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242717AbjHRX6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 19:58:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AE12D65;
        Fri, 18 Aug 2023 16:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkCBe1EEfkL8sBn3BOr+mrYJ2tQuWhPa1W4fJnhmRh0VKOA1b0N/dCeQNtP3EGtB8P5b9hYo8ZfBtOfNCBCU4nMim1XAsEmjm8kDCKArzZAE8gHAgkF3sb16FrUl603GqJS8IqOVmsG/J6URMG+FaF+ErOicOeBgp20gnWaSllA2+o9y1gGrMEl4kg0L3yaH+GmcrHnyNIOeOV2Mhus6XyWZ9j4SZ2LlXynzDYQiwqdFSKS8ieKiow88nJzpq76L0zgX5FKuP4R0CUP1dVKUx+uC9UgBANKqz/O3GnCAo+Qqu/ctgfKlJFyE1PUNavpskNxBkm4tvKq50L63BR8LIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzAqwlpRc8z1ikiGNunPbbeEtWQvVwqeYnxfMljkLGw=;
 b=QTwHbFnQ47dPF/YTzPPLMoD9agem+6Gs9+aOS3CjEyeLt4fBm8hYsm0O0/PMDu7UXdkEqOstv3fioEF4hlv4K7nn4zW5r92nG24sCC1rr0OwqGoZNtpekG8t880l3zNF1wNH+R2hyFZLjm4nSq2CzxfUjSGob74jfo5NVoeGW866SwF1i6N9i2P3UY0oS3l0RHUhAzg5ZJNlIXP4f1wfw2vYsoV8NntcA4l06v4sGig9ZXW5KLZhz5Ia5f2VQ8Vd9qltrZMbFN4LetxTanBDAaD6qAmQdqb+hJqJxynHRT0vjUXXLRM5P30xjcGcMBiVOzXKKjHakUgao5qnPb65lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzAqwlpRc8z1ikiGNunPbbeEtWQvVwqeYnxfMljkLGw=;
 b=HY3Vz/Gm7AGtDC+7jGdeY28MKcbgACeujWh0RBQa7Ho9gqBw908lb7FDw7FvMNnHY6gOBn18o5U59/Am6/Tv2vkZ9no9Tn3ERUAxalNh4tA8csxnJE7IiCkmZY9q8Cdd4brcLNDQrlTajCVd9u8n92ZCQbyhNzx4kgstObT/vqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 23:58:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 23:58:00 +0000
Message-ID: <719602ec-c9fc-4a72-9585-d50595cb6dca@amd.com>
Date:   Fri, 18 Aug 2023 18:57:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Don't make vendor check required for probe
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        charles.d.prestopine@intel.com, rafael.j.wysocki@intel.com,
        len.brown@intel.com, stable@vger.kernel.org,
        Todd Brandt <todd.e.brandt@intel.com>
References: <20230818181516.19167-1-mario.limonciello@amd.com>
 <CUW0GZCVHKPB.1W7ESSPE7INHQ@seitikki>
 <25a21516-7201-4ee4-be2b-f67edaf97e2a@amd.com>
 <CUW2JM314GAR.36XV41132X3OX@seitikki>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CUW2JM314GAR.36XV41132X3OX@seitikki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0233.namprd04.prod.outlook.com
 (2603:10b6:806:127::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: ca8dc99b-f2f1-4411-b096-08dba046f3d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZYcvHjfz7kIJD5nN2SrlOTi6JPZTbYhrtK2J/MZ8whK9XDEd0vwmy8mTH4OsB6OT6V+bkddf+HuWJhnmBAKKmrsvyzLraD+hTKdvcmkMLW6zO0oGydKQirTh/l0GjaE5IBIlQ/T9eKjDrCOKUZuAlNhU8msa/mrL45mVUmILrYMSeII3o+E9g05bzyULijelYuY1MQIfOTg8L3ITSEqVCBUXlWIgcq3n/asVGuDOEYD09uYqbQOw5RQEjzoz9PQnfSonNBOASLldf6dyY4GoJ0SMVclaGeljJFIQtqoMSg+9uzgAz1a+bEzIIkNXs48+7iUd/fR6EP+2HhubkoMi87xICIQJzJVNP6hesFq66+a8YhEn9ctx6bazMUK9JVy3QQVZSC2+TznH5++GywVEC9Kw/rI6e7sMFaHqbhd3HXCDP2Xn1NFy2HJ36GTbJKgnGEuTzLKTgMYEsFNkN5paPBsexFZCdR3WwgGCkq23kBDau57Q5KbgTkrRZXUMGp0zQLpa2LuCis+tCZvp3WJ/UVh3jnpglhAHX/Yl4PzIRgpyPMc9lfAxMu+d8dw+R60F8/Qp/LHLfm4zG15G2/kwN9Qfki2oauE8OUychh6k4fTWMFtTvib0ILI9P36KBtX4oLSRHkw7SFMwlTyt3AUng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199024)(186009)(1800799009)(2906002)(6916009)(66556008)(66476007)(54906003)(66946007)(4326008)(5660300002)(8676002)(8936002)(316002)(41300700001)(966005)(53546011)(478600001)(6486002)(6506007)(31686004)(6666004)(6512007)(2616005)(26005)(83380400001)(86362001)(31696002)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0hYcUdoZ21UcEp3bWRucGdwaUc0WE1BV1NOSHRTOEVPYWVQbUJTWUJKZ0la?=
 =?utf-8?B?M0lBWm5DN2VKUXhOTU1UeEMxTTV6a3dicEhSa3hRUmIvVnQ0dVV3YXFlc3Jn?=
 =?utf-8?B?c2VscnRjU0xaUytJM2VTS1NEM05ER3NwSFpNaXNHaHVUdVFYS3N0VHY0RXpL?=
 =?utf-8?B?SlhGUElLRmpTRTBPMmJ6cUpneFIybEd2aXA5Qi93NnVKbTRZS0NFdG1na0NM?=
 =?utf-8?B?NktYemt5YW9TbWE4ZVJXemtpY1ZBMWRET1VUdEt3cFVpYXkzTVRVVU4yVklK?=
 =?utf-8?B?YU1uRXY2NE5wdnlzN0NaalMwYkVFV1VsNWZZQlBuNS94N2xJWFQxdC9pSlhY?=
 =?utf-8?B?YzZCZCs5Nm45RkthanZWVDVXK3p0TzRqZ3RoeWwxeDVpemRPN1YzYmtMeUFB?=
 =?utf-8?B?YVlFbmFhbDhCUnBobGpzTCtwdlpPVGlPWjV3MGhjSUMvTFYzUjBtVXNvMGRO?=
 =?utf-8?B?cXoya2syeXpyN3d5WlFPTG0zZ3k1U1JtWWVlQVBLdU9OUnhjZlo5bDdaYStO?=
 =?utf-8?B?S1ZkL0VuUFoySUZFR0Y2THl6dWVSbUVkRDhBZU52OWF1a1Rnd3kwNkJKNmd1?=
 =?utf-8?B?V2xQWkVRNTRSUzBGcjhHb1hpWms2Z3JGVkJYN0ZRN25VbWxEUWtYYlBGaFlS?=
 =?utf-8?B?L0xHcGxpaDFBb1V5R0oxRnZCN1ZROXBOWkI2SXZDMjh1cnFCejR4Q3BQenRm?=
 =?utf-8?B?UitQbGE3NW5TSHFlTWlTOGQwdEt3dHBMcTNGUWFtY3lJaUNOWDZ1bmNib3c0?=
 =?utf-8?B?UklnN0s5djIyVUtWaGN3Zml6ZGYyWHV1ZlF0TUpOUEJuaDBvZ3h4Q3RYYldv?=
 =?utf-8?B?THNaVWh3QXp0bUo5Yno5UHQyRmFLWmtKTGQvcllPR1RYajJ4akhVZjV3R1J1?=
 =?utf-8?B?TjNtZklxY2haNGhNUkw4Ly9BRXJxa2RJYTZLVzgzN1dHb20yQ255bnhqMktB?=
 =?utf-8?B?bUtVSHFab3FUaEpuQ0k3ZmxDVUN5WU9oM2NvZ3dNKythTEc0VG9PK3AvVnpu?=
 =?utf-8?B?Z0F0enAyQi80VWc5Z3I1QytDVU5hc1hxb2s5TE1sZDdQTnppaGhhMnJsQ3hF?=
 =?utf-8?B?TERhM0pjRHlpTWw0NWZhdXNuc1hCaG1TZ2szUk9xTFRuVm1LK0dvL1pwUkpF?=
 =?utf-8?B?Vk1SSFFHL244SkQrOGN2ejBPK0h5OHBPbmF2Q2VvN0dMSktxay9CQ1lPcHUv?=
 =?utf-8?B?dFFRMWJ3UXZrS0pYQXczRTZQUC9zNm5scmlCWE9TamtTWlVCd2VKYzdKRUFn?=
 =?utf-8?B?cTBGRkRtS0pzRHVuM1psdFgzVmt0bFU2dFdvcVI3VFl1RFFHdyswaFhTRkxO?=
 =?utf-8?B?T1FxSlhDL2V3MGdxb2J4ZjFma0F5K09Zd2hXTWl4MTZUVFZMN1V5V3VkQVVC?=
 =?utf-8?B?ZFlIWlB3UTczVzhGcnEyMit3bnpTMnJiT2RDWnIrWEc1WHExRCtDQ0xsbG5x?=
 =?utf-8?B?cWxKNUdWNzZnMWdLMzFuOU56eHhPS2xnaDB4eCtZVzhaaVlFMVBKRUJLYlZI?=
 =?utf-8?B?aSt1dmtQR2hYNmpMd3gveWIveDd1TmFMdVRIS1V5OTJmMjU4aU5peFBBQmF0?=
 =?utf-8?B?N2NxNklIRytPRnZaeXVma1V5N2paYnRXQ1NjZEZVNndNcG1mZnpJbXd6K3FB?=
 =?utf-8?B?SUoycEZOSmRoLzlxUkplbkNvcEY2SUxBZUhXRDNZOWRyaDhJeW4zNWtnMjEx?=
 =?utf-8?B?QTZaTzRHYTc0aDAxWFZRWlpTVmEwZWxuV3JVaDZ2dUV6S0pEeC9SVytLczF5?=
 =?utf-8?B?eHp3VXpGckY4eTZmV2NQaDBMR0dlK0lGM2QxWG1ZNXI1QnlJdE8wZFhMSVRG?=
 =?utf-8?B?d2g4VmZrRmx2c09WVmxSM0FIR0hMek85VXp3RzVQeGh2UWpEYXB6c29wL2E5?=
 =?utf-8?B?bGFHYzRrVG9hbHpMSXVzb2g2aTl3OTRIZWVUVTl5UEFPVTVWaFFsTUpCUWsz?=
 =?utf-8?B?ekF6YURpNnFmaGRzSmF0b2d2TzVraHNwdDdRZ0w3bGRnV21lTWM4YXB2V2hl?=
 =?utf-8?B?S25DajVrU1JXRkR3M2dNYXFWb2VtckYyR1MzMXNRZ3doK2t4a2F2citRaWdM?=
 =?utf-8?B?R0o3RGFMWFVqdzNTWG9mNGsxbWJpQWdnM0U2TDU2OXB6bGNxRVNhTXNESkQr?=
 =?utf-8?Q?0/u9rPSUYrNAuF+sOhaB1ixnP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8dc99b-f2f1-4411-b096-08dba046f3d6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 23:58:00.3892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMEeX/rWI2TTE9S9eW6+gsgicw/Cp4zAyKSMIxqi3tyHe0opCbndggYdcfxoC2V9FvNIVgP2+L4VXdKIeRGD4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2023 6:44 PM, Jarkko Sakkinen wrote:
> On Fri Aug 18, 2023 at 10:38 PM UTC, Limonciello, Mario wrote:
>>
>>
>> On 8/18/2023 5:07 PM, Jarkko Sakkinen wrote:
>>> On Fri Aug 18, 2023 at 6:15 PM UTC, Mario Limonciello wrote:
>>>> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
>>>> all AMD fTPMs") doesn't work properly on Intel fTPM.  The TPM doesn't reply
>>>> at bootup and returns back the command code.
>>>
>>> Is this reproducible with any production hardware? You are stating it
>>> as it was reproducible categorically with any Intel fTPM.
>>>
>>
>> Yes, it's affecting production hardware too.
>> Someone came to the kernel bugzilla and reported a regression on 6.4.11
>> on a Lenovo Intel laptop as well.
> 
> Now the description says that cateogrically all Intel fTPM's fail.

According to Todd this change caused 5 *different* reference Intel 
systems all to fail.  I know they're not production hardware, but still..

> 
> I asked for the laptop model in the bugzilla bug, which should be put to
> the commit description later on (hopefully with a snippet of klog
> transcript). This commit cannot be applied as it is at the moment, even
> if it turned out to be a legit fix.
> 
>>>> As this isn't crucial for anything but AMD fTPM and AMD fTPM works, throw
>>>> away the error code to let Intel fTPM continue to work.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
>>>
>>> It does make sense not to exercise this outside of AMD CPus but since
>>> there is no production hardware failing, it cannot be categorized as a
>>> bug fix.
>>
>> See above (and also kernel bugzilla).
>>
>>>
>>>> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217804
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/char/tpm/tpm_crb.c | 3 +--
>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
>>>> index 9eb1a18590123..b0e9931fe436c 100644
>>>> --- a/drivers/char/tpm/tpm_crb.c
>>>> +++ b/drivers/char/tpm/tpm_crb.c
>>>> @@ -472,8 +472,7 @@ static int crb_check_flags(struct tpm_chip *chip)
>>>>    	if (ret)
>>>>    		return ret;
>>>>    
>>>> -	ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
>>>> -	if (ret)
>>>> +	if (tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL))
>>>>    		goto release;
>>>
>>> It would be better not to exercise a potentially failing code path at
>>> all. This initiates full transaction with the TPM.
>>
>> So why does a full transaction not work in this case?
> 
> It makes absolutely zero sense to send a message to a TPM just to know
> that you are on AMD CPU, right?
> 
> E.g. you could check if boot_cpu_data.x86_vendor == X86_VENDOR_AMD right
> in the beginning of this function.
> 

You couldn't replace the whole function with this check.

If you apply it to everything on an AMD system you catch too much.  You 
need to know it's specifically an AMD fTPM to avoid tripping the stutter 
bug.  Pluton is fine, dTPMs are fine too.
