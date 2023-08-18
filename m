Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A81D781276
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379292AbjHRR5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379348AbjHRR52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:57:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C142B421A;
        Fri, 18 Aug 2023 10:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdrlcI9j/xk2bshe/K2/zY2VZj0CygxzXS8nE9zhQibJ07WCtbcrgw6Psqu+I5TjqpZE5cgKXVsmUKYMtE0Iq241Wb0Dl4tFLaC21AgCMxJWYsFwH0Lf76Dw0Cx7LNnpvkPJ/1JogRsqpx1Qtt8VunBLNNyNrPw6Au7qexZSG5LOYUT3lyYUzdOXH/Bfv//QC4WfFGP//AQ2vD4ZR6SFD6d9NCp7AsczhQTZ1OQ8eEOUwn2We8n7f9UreyPSVO8nrlk0unlO/iNMX/R7+RbYJ+wWMtI9v8idKwTjhDELciwAyg3nCy8+UyVebEkFGyTeHl4Ai/+H1F79COwiK8khYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdvGM3LD2W5Co8eczTCCCJUi+iZ30djX0DLInek606I=;
 b=e6uZXe9rcoakQeI1/v5cnISrqPHcAfnGM/kV1QA3/xNurDDXMTSMy2b3Kgr6P8kKXpNLRxB4ouxhhEnRSJO/qrR1oprVOBUroLuUz4CrzROfqaYB9iQAJRyXEBr9nTRbuMWvJzmwKkGsml/0CN5q04JEXbtDfmR7E0D31490077LBrSBN56MvkYlgF2fl6ZhtkQG/luIea22WaLRHR1wgqHj1FNEvX+Zd3dJdsrGVNA+bxmBwgjQvnrpQEbip8xp7xGUtAJGnew1hWNgxqtN+AbwwrAZ94g8g2ux/nVe2bolDpv06nwJtJrisEWExKNrJGactu7DrqQxUfcjQn/Yhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdvGM3LD2W5Co8eczTCCCJUi+iZ30djX0DLInek606I=;
 b=F61SW0qXiJz0a4cRtJ1NrSSst7E0BpQKFdynMHPueCTjv88qlEjvp3Ys2bFJTkZ+0cC5tlHI7FQt76PvNn9BvE/2EjLfpg4o+gTKiBoQjeEJSXRGeDNVWx4M6OLZxWsqR2t5KAKaUGfrYkFeqV55Ew04GHJW5ME0Ok9+jhKm5Xg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.20; Fri, 18 Aug 2023 17:57:22 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 17:57:22 +0000
Message-ID: <64f62f2f-91ef-4707-b1bb-19ce5e81f719@amd.com>
Date:   Fri, 18 Aug 2023 12:57:20 -0500
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
 <92b93b79-14b9-46fe-9d4f-f44ab75fd229@amd.com>
 <CUVV2MQRCGET.2U22LFQPX1J3G@suppilovahvero>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CUVV2MQRCGET.2U22LFQPX1J3G@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:806:6f::14) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bcaf87c-2f79-46af-58c7-08dba014926a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MNNS6ehqoMHwIqO+Pi70P0i5Ah8NaYE50S1roGvHzRNEkZwmYzDeOjjujiggYHmQDlhOxxK71ctl0XUiUa7GCfYE2L2ACX48HUYYEMB1/Ab4YBB8GCKIxmRWxgzCzt4AHBi8rZpjx2rTw6krIb0m/QQ7UM4HK0Ue1cDC5zgf3AyO/jKtayyNWnhxgPs67iGr6Nuzgy9NUMSspT8ILoPGgW4sO2EccOmtwVelheJnLoWU/mgU7Al3Es1kndkw8KM6pyB7P6LHX3XQvlM30g2d1QYSgFf90eqVJq45RY4xX3mzGFK4rfL3r0i//3OeGlktcqKpTLRN0S2wqUpyI/tbgrfYVBWiIJxN9JP+WpY2nTe+4rtcsw7Q2XAtR7ZgW33WuICFbPzSsO/W9Du3iradcH1PkmL1q3UjG5aNnC73k9tL+ldWbH6jiyZZuM2Bsbp7beVTI95ghHLXjwiBl0ntwwMT/jHJpO6qIW0q58jBAw9ivqPDjxIlm2UukFhHnIK9sQyjbitIU87euK6J3SUBTlQ22MZS6Nyw70HIzA7bjgbLnF5haanYtWFtX5I+ZLcyefDsTfewMebco1AZ3QA5jzxIHok7myApRgnga/oflAnkltDg6m1PapJ/QSBuCyMeFqj0E0YThegjV4/TI64mH59SN2geFcAjqvTOdTXUPTv7uEJico6gXBn8fK8Fb8+5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(346002)(39860400002)(186009)(1800799009)(451199024)(36756003)(31696002)(86362001)(31686004)(66556008)(316002)(66476007)(478600001)(966005)(66946007)(41300700001)(38100700002)(6486002)(6512007)(26005)(53546011)(6506007)(2616005)(8676002)(5660300002)(4326008)(8936002)(2906002)(44832011)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0xKR2wzUUZQU0t4UUM4UzZqcVlLRjhyVnBHdzRHTmxoZVFUYldXUzhJaUpK?=
 =?utf-8?B?RlRuV0diOGc3YWNXSzFWS2VQTDlGTkViWGhmdE5paWRxY3BOazVoY1QvVExJ?=
 =?utf-8?B?VFhocnpCcnRXNnE3Tk5UUFZyY2drYmQvZ0ZaVzk3UFhhMERXUDlFWWlScnlu?=
 =?utf-8?B?UnNOaURtMk1nTmZXd0dDZjhpVHIxMzV3QWJQSGY4LzhDZy9KNnc0RnhiZHov?=
 =?utf-8?B?UXVYRExuaCtwdU5DemorRU1jdDVaKzNGSytSUjJpZFJmQkxnSnNWSm5COTVn?=
 =?utf-8?B?aEk5VDVsNzYza2xQQ2JvNUpFVTNiQm9PaytFQm1xVlpORUNQSmUycElnN0RB?=
 =?utf-8?B?RVo5dDc0QVBPMzlSTUc0b1JYc1VteXp1V3M1MDRkNGpQMWdvKzFkTUN0dmRy?=
 =?utf-8?B?NjJVQ251bXROSUxHTENFRVZVZTl6bFJhbzFDVGo4aGFGYjM2dlJLRENkbUcz?=
 =?utf-8?B?NHNPdXFHOEtoT1dXNUJaUVE2ckdTQi9uTzc2UGc0MGxyQldJd3U5MTJSa0xG?=
 =?utf-8?B?dnhRU2dZZU1BMjUwWjYvMGdQMEFEbG5GU2FmRUFJck1BSlZIa292cUxWTVRV?=
 =?utf-8?B?RG9NSk9pQVN1ekVIbUhXclc1dmMyTDNMUU9EV0k5V3oyeHB4cHM3MHRhb0h1?=
 =?utf-8?B?R2NXMzZ5NjRQN0tpQnRJZG1Ja3FMcjdMRFJ1MnJpN0xZZ04yMDhUTUR3bjN0?=
 =?utf-8?B?NUlDTXlvN3JsQ2s4MzBIUVpMVHF6TWdWd0d0M05QZzFvVmlHcTB3QksvenZR?=
 =?utf-8?B?Vy8zc3ZRVDk3VVpPenE1ZVNacElwRzRESlVvYlAzTHdaM2hwdktKa1RwYURI?=
 =?utf-8?B?SkxRRlkyZld2NUFvWTVoVzFNdzZXZnRQNTZ5MzdwbU5YUFVuNEhqa1QyTi94?=
 =?utf-8?B?SGx0N1J5SHpsRnlEb1Q4cHlzS2hHY0U5aDFlS1VqRnhTS1lqeDJuOTVzdHZk?=
 =?utf-8?B?REc5dHJ2TlliSUE5WE1tMXlUS0o5TTJlWkNMd1dCUUcxNjlBdjNIR2NxVUFv?=
 =?utf-8?B?SnJDOHVEOGxRNlgzaTRUWmphT2l1bWtQZXhtaUkvaXV2YmJyN0g1b3gwMkdn?=
 =?utf-8?B?Ti9PdDk1azZBVXpYMzlSc0M3bXJFTDBnNHFBOWI5VlZSbUtSKzNSM2dJSmpr?=
 =?utf-8?B?K21UaVlOYzljYlMwRzAyeWF3SjF3eS9jV2JTanpNUDBMNFNyR3JWRHZUeUEy?=
 =?utf-8?B?Q1pPV29OMkpZajJSSS9mUXFxMUl0QWIyemNsV3pJcEM3WStkWDlQRDd1b3Ez?=
 =?utf-8?B?UXp6OEpuR0Q0R0VnUnd0TUROY3Z6cDJqOUJ4c1IwN3FhTkx5dkcvbGk1ZGhB?=
 =?utf-8?B?QzdVRUlHN2Fzb0lhd0c0Q2R3S1pub0ZTd05VRzNicFpEQU9BUkttZGcxcWJa?=
 =?utf-8?B?Yjl2aC9JbG00VjMxT0VCdU9HUndiWGxvbG1uOWx2dDhHdUkxQ3hTc2dOcEVs?=
 =?utf-8?B?NmRsWVo4RHhuTnQ4NjdSaG5OOGFxTUpGQzRsRW1RT3NWeDFBMUltaDZLeGx5?=
 =?utf-8?B?K294S0pjeE41VzFTZjJBVG5XUXUvZk1sdHRxaG9oSVRmU0FpbnBPYXBOcFh0?=
 =?utf-8?B?Q1FQV3l2SmdPL2RFQ0dTdXE5NHpPWHg4MTgrc2ZPVDgvNzlnd1BZNjVtbnB1?=
 =?utf-8?B?YjZJNjEyVDJRM3RpUWVYRVlPRExxTlllVWNHdUZCOU51ZU13am1aVllrcktp?=
 =?utf-8?B?SHhCT2dHVEU4SjdKc2JveTZHNVY4ckdLSnZKeldxcmRLQTNSWG11Mk1ZcWpS?=
 =?utf-8?B?WmNBN1J5dmlFWFRqL2htUUxnbXk5dkY5SWUvT05QckxHam96YXA4Uk1XYXM1?=
 =?utf-8?B?cXZPWWZRNWx1RmdsaFB2ZENIZEp5eVVTa1cvUmtjVXA3QWNmcUc2L3NzVGhk?=
 =?utf-8?B?TnZuVDVaZ0E5d252UTA3SUhzUnowWXlZVTVaZ05TazdzQUJtY0l6Q0pER1hN?=
 =?utf-8?B?ck9PNkwxRTlHSWVMbnNQNUNMNkE5UHZva2ZCTCt3QnQvcXA2SVQ0cUdrek9l?=
 =?utf-8?B?OUhqU1ZWSkFHQk9Ed0RaSG9jL0UvSm9ncEZxQ1V0UG1QMHhCK1dzMjJvbzBK?=
 =?utf-8?B?NVNMZmpSZG1ZOS9WWUMrZ0JIQ2tac3FtL3Q5SVliTEZaNjF4Qk55U2FmSzZG?=
 =?utf-8?Q?bd7kXKnH9NiIniFMknonLdgNq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcaf87c-2f79-46af-58c7-08dba014926a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 17:57:22.0797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: numnXEFRudZp40Z7KykKVrTFVbpbsjrE3ZwJc3mVtleqv53WS3lwdw/d0QxACQn0Gh9oht9AxWXr/QesXUROkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/2023 12:53, Jarkko Sakkinen wrote:
> On Fri Aug 18, 2023 at 8:21 PM EEST, Mario Limonciello wrote:
>> On 8/18/2023 12:00, Jarkko Sakkinen wrote:
>>> On Fri Aug 18, 2023 at 4:58 AM EEST, Limonciello, Mario wrote:
>>>>
>>>>
>>>> On 8/17/2023 5:33 PM, Jarkko Sakkinen wrote:
>>>>> On Fri Aug 18, 2023 at 1:25 AM EEST, Todd Brandt wrote:
>>>>>> On Fri, 2023-08-18 at 00:47 +0300, Jarkko Sakkinen wrote:
>>>>>>> On Fri Aug 18, 2023 at 12:09 AM EEST, Todd Brandt wrote:
>>>>>>>> While testing S3 on 6.5.0-rc6 we've found that 5 systems are seeing
>>>>>>>> a
>>>>>>>> crash and reboot situation when S3 suspend is initiated. To
>>>>>>>> reproduce
>>>>>>>> it, this call is all that's required "sudo sleepgraph -m mem
>>>>>>>> -rtcwake
>>>>>>>> 15".
>>>>>>>
>>>>>>> 1. Are there logs available?
>>>>>>> 2. Is this the test case: https://pypi.org/project/sleepgraph/ (never
>>>>>>> used it before).
>>>>>>
>>>>>> There are no dmesg logs because the S3 crash wipes them out. Sleepgraph
>>>>>> isn't actually necessary to activate it, just an S3 suspend "echo mem >
>>>>>> /sys/power/state".
>>>>>>
>>>>>> So far it appears to only have affected test systems, not production
>>>>>> hardware, and none of them have TPM chips, so I'm beginning to wonder
>>>>>> if this patch just inadvertently activated a bug somewhere else in the
>>>>>> kernel that happens to affect test hardware.
>>>>>>
>>>>>> I'll continue to debug it, this isn't an emergency as so far I haven't
>>>>>> seen it in production hardware.
>>>>>
>>>>> OK, I'll still see if I could reproduce it just in case.
>>>>>
>>>>> BR, Jarkko
>>>>
>>>> I'd like to better understand what kind of TPM initialization path has
>>>> run.  Does the machine have some sort of TPM that failed to fully
>>>> initialize perhaps?
>>>>
>>>> If you can't share a full bootup dmesg, can you at least share
>>>>
>>>> # dmesg | grep -i tpm
>>>
>>> It would be more useful perhaps to get full dmesg output after power on
>>> and before going into suspend.
>>>
>>> Also ftrace filter could be added to the kernel command-line:
>>>
>>> ftrace=function ftrace_filter=tpm*
>>>
>>> After bootup:
>>>
>>> mount -t tracefs nodev /sys/kernel/tracing
>>> cat /sys/kernel/tracing/trace
>>>
>>> BR, Jarkko
>>
>> Todd and I have gone back and forth a little bit on the bugzilla
>> (https://bugzilla.kernel.org/show_bug.cgi?id=217804), and it seems that
>> this isn't an S3 problem - it's a probing problem.
>>
>> [    1.132521] tpm_crb: probe of INTC6001:00 failed with error 378
>>
>> That error 378 specifically matches TPM2_CC_GET_CAPABILITY, which is the
>> same command that was being requested.  This leads me to believe the TPM
>> isn't ready at the time of probing.
>>
>> In this case one solution is we could potentially ignore failures for
>> that tpm2_get_tpm_pt() call, but I think we should first understand why
>> it doesn't work at probing time for this TPM to ensure the actual quirk
>> isn't built on a house of cards.
> 
> Given that there is nothing known broken (at the moment) in production,
> I think the following might be a reasonable change.
> 
> BR, Jarkko
> 

Yeah that would prevent it.

Here's a simpler change that I think should work too though:

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 9eb1a18590123..b0e9931fe436c 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -472,8 +472,7 @@ static int crb_check_flags(struct tpm_chip *chip)
         if (ret)
                 return ret;

-       ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
-       if (ret)
+       if (tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL))
                 goto release;

         if (val == 0x414D4400U /* AMD */)

I think Todd needs to check whether TPM works with that or not though.
