Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949E578129B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379374AbjHRSMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379370AbjHRSMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:12:05 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B622D70;
        Fri, 18 Aug 2023 11:12:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKO9nPeg1y68wnMCBjcGYZ9tAJDdSBlq7TI3dNumMvuRUhsf1XdZV9W6MmvW1ICBXX3qYoXzBz5hJSB7v1A9VIWcbKUoxGlD/xq/u/CI9AcsJUlTZgiKO/ivO/kBbk2SurRisLQhJ4SxPHUulwORHXN1p00qxo5ujUTCNz1RCgtp+tdgTwKMZ1NYaxAiAQWOyEAo74VHPEhUW0oPEGTPeAJXjZoTFzkNBNzqeVYvDl/WBQlXjCQR0gweZf7AKoJUZ6nkgXPAOP65RA8DHPO2zHpp1OtvJzgIccoSP0Zoiz3lbWhv2xthH6go+nsCmEPZmqMtwktUiCJ3L/gJuwmMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnMSqvL9YFm6UIM4K51A3V+M3dnzO2dhbzhnOQFG4d0=;
 b=mxdH7hBIKNsisHG2NDDC89rkfATDoIUynVWvmfz7NTX1rAKxfSBOdj1sXYvy/HkopnIpeW2xXqqHoHnhMEyLSwmtIWZldEq4M+43/wkU/uj/d4f4LjuFD9J4CPjtjZAfEk2IVYBzh+EHYGbG/A9sxFRCYODryUYS+Pe8A5F8wfiKwD5KZgXLaaKH+rsfiK1d4mragN5ZKl6/p169LqFGZRBnBwsHD+FK3xWU1GzY2wAl0C9XDRdgd/8ctxUUzz9A+3xlohAWTFBs83MyIb/tcjReeVQftOEL+IbSu9rKQTN5kmW9G1zfwa+5QKUhSa8AqNFjBEb1m4qdxupQljW0Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnMSqvL9YFm6UIM4K51A3V+M3dnzO2dhbzhnOQFG4d0=;
 b=k4e7V8xcHfvSIFYbQqLMPQU2NPZKbtg0ROWSALGzuDREJ7CmL3MgxlO8hd8x83CKfwaN2XvupE/5ZXCAo2dgVkH7XvkX/RomiuNJYZvmKK46i+KJ2AKeAQA2AkYVnxrOGhGv3wLazqsEDt9dWaacASR4xXOKGFQ2p/BvlfY+2Z4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Fri, 18 Aug 2023 18:12:00 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 18:11:59 +0000
Message-ID: <eec91766-10a9-4d50-8e82-376f52f54be8@amd.com>
Date:   Fri, 18 Aug 2023 13:11:57 -0500
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
 <64f62f2f-91ef-4707-b1bb-19ce5e81f719@amd.com>
 <CUVVDC2QGWV6.HGLDFFEGMGGU@suppilovahvero>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CUVVDC2QGWV6.HGLDFFEGMGGU@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0054.namprd05.prod.outlook.com
 (2603:10b6:803:41::31) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: c40405a4-d096-4091-9e92-08dba0169d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UH4/+1lnD28RaqPyKbbSKnG5DWteFWQJd1syIEVg222P5qd/mZhTp96l2hb950DXKMamLLBWiABSOuwZgsxZsyXcGWti6XaUWprZ7aWhDTlnelbmZ/lTNm41gdtXQlDgmnbD348l/tXND/BjvT2o2EQrwWJkZCymyREvsJ4WAQKmPz4htHEdmcNMDLuRw/1LmDaWiHTQbvwsGTYpo+VU8WVbcdJ2dbs8UYYUT0yOpaCM09dh54owm1VgGrng24jMAyTYy196mbB9lWuWp4ban9sgDCPlN42L6lQ6zZxPaGRT3APNqzf5ApznOXvl/Vwmxjk+/ISjGOl/ths9FagD1kiIZ37C1nfhkwHrdFOQIhG9D07qT/d8B2d3s+qvRg5/F6uONvAl1AlPYQqIYO1y6vO3sdMyWG/MfqNZw9axqWIHFwBYPdIdR4yRm+5eeUxxcIIEwwJpH92sPOaIW5EbbE6CVFrhlsFe9sZIl1vW++LENfjZFh1mVEdFT+ahnTAlg8ACRW01Q9ZV9cpdrs/dHUqBEwVFtpwB/iAMY7/FutneXHgQ/FbD/f6Bx7GH6aYg5AxM3Fv+lD7btm8RNaZh9UnHvl3EccUQidA8c8jnE06KKFfQCpKo7+ub+1HEQ9LLE2sqBq00IoerxoXYB/0a15f1QG0xLujYxiyRfhtxlDtVzzFhNhnTLlEbhTImclYI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(186009)(1800799009)(451199024)(36756003)(86362001)(31696002)(31686004)(83380400001)(8676002)(26005)(53546011)(2906002)(8936002)(5660300002)(44832011)(4326008)(41300700001)(6506007)(6486002)(2616005)(6512007)(966005)(316002)(66946007)(66476007)(38100700002)(478600001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWxpdjFDNzJyRWNJeEs0cEhHWnlLVytQZFE3djRCNWVySW9LZkxZTlRoVlJB?=
 =?utf-8?B?bGtYR2pSWHBudHJZK21KUEY2eFBQT1A0OUhrdHFZWEdWTzh4Tll4MlVBc2Zn?=
 =?utf-8?B?SzBlOUNqSlJIZGNCdmZsRjk2RWtKODQzNXR3cTRqNHFNWHRCN1NLQ2RpeU9u?=
 =?utf-8?B?S1NNdSs1WDJJdk9iejJYd2xic2xmWWN4djdQWG5PS1hEUmJIdFhTL0JlR3ln?=
 =?utf-8?B?Z0NKdHNsNmtFcklubzhCengwTU4zaS83Ym5iSkRtR1JSanNDSVJ4MmdJWEtJ?=
 =?utf-8?B?aU5HUUdjZ05meXhxWXF1eWU2V1pyZkhjdUVPRDZycHVTNFVJNldQeUtQN0JZ?=
 =?utf-8?B?ZEowS0xKWU01aW12U1M0U1pnSkZaYWU3NE10Y3FWdlQ4TGVUckFxcHIzS3V1?=
 =?utf-8?B?MkgyT2xuTlhGUEdRTlA5TnJqWGxGeHU4b1VXQURSSk9UQUduUFR4Q0ZLMmNJ?=
 =?utf-8?B?Zm1kSmRhNmt2czNrMXNxVkFVdWQ4N3dzK2Y2ekxkQnBHM3E4YXhjZml4MXhC?=
 =?utf-8?B?Rmo1L3p2ejgxajlxUS9OdGhhWSt5UzZUKzdFQmhPRkUvclpXRzdCZmdvVFVj?=
 =?utf-8?B?RkZRaG9KS1k3RXBPM0IxaFlFbmpvZ2luaUxuckdOSTlNaTlkcmRiRFA3NS9u?=
 =?utf-8?B?Z3RTY2VuWmprdW5zazAwYi82a1ZqL3N6UjBjSTk5UmMyYzJFTWYvcDFMejlU?=
 =?utf-8?B?RkR2UUdwN1Rqdk5IODZRWll1N3d0UVpaVWQxdDQ2NGZ6a05uWHVnZUF3R3FF?=
 =?utf-8?B?MGtTeXVXS0tIYkhzWEUrbFZlaHJGamluQWlCRmcvMnU1Y2hYTW5IOGtmREdZ?=
 =?utf-8?B?OUtuRWZiMXBuZFBVQ0lOS0ZEZURmTy9iN29rZk1PVDdRMk9KbXIrSjZBalQ1?=
 =?utf-8?B?UEh6dlpBTHR5SEtyaUF5d1RMY3g5OHowTm9RK0lnM0N3Mi9yUGRNTFE0cjho?=
 =?utf-8?B?c21sKzc3UUliMWpEY2dVZzFXYVZwRzNHTW9LVmp2djg2U0ppUXoxR3U3Y1ZQ?=
 =?utf-8?B?aFNlQnRSUEhpYnpMRHJMZ0Q5Z0JsQzV4eDByZC81OWJiVXJ4eTNaZ0svTE94?=
 =?utf-8?B?TUpjdkNsZGFNZlRQRXc4a3o2RXJVMUN5YURWd3dzMWFQeTRtejZITzhoRG9X?=
 =?utf-8?B?aTdIQnFjZG52RDNzbUM1SEFRY2ZLS1F6MVhveFFzSENXZC9JYk9wa3Q2c3hn?=
 =?utf-8?B?UVBabmhjOEIxMW84M1ZHVUNkb3V0SXFhWEUwNS90QlYwT2VJbTI2am5RYkZM?=
 =?utf-8?B?ZHdrUzhWb3FCbEZURC81dW5yMHMvVVJDOVdna2M2VjBsSmFUSmxvMXFvYmw1?=
 =?utf-8?B?WHFMeDgzLzFmb2E0eWM5TVJnNHlaQW55SEtsdktObSt6N0p1dWVSNGdZbm5Y?=
 =?utf-8?B?SWJwZUIrbTliTVRBZFpySDJJZFZzYWZuU3Ayd1dhMTVSUlhBOFcyMnVMY2ZC?=
 =?utf-8?B?R3QvbC9LOGxUZ2gyOURkOUlsRlFiZ3VUV0c5emEwMk0rSktBQjJiYVFQS0o0?=
 =?utf-8?B?UWV4QTNtZGV3SFlnUjV5TGdzeng3MmlrWTQrUEJTZ2RpZWtJTVhlZnBGendz?=
 =?utf-8?B?eUJzaVpmLzdoaWR5dm9scEdoV3B1WFZhdXQyWUlNN2xOZnNzeG9sSDhBSDZY?=
 =?utf-8?B?a0FhTkhxeEphaHkrRWltdnNjVlFJdGcrMXV0bkJWOFNmSS9STENrYWRkYkZ3?=
 =?utf-8?B?UkNPVEd5V0l3VmVnbmFHVHlEN1psRzIxUldZYWFUMnBEaFgyUXZXbjAwZkhS?=
 =?utf-8?B?NWJuM1pya3k0ditpOUlqSHcvbEV2YTY4RFlUNjFOay9Wc0UzSmQ4QXdVbWZo?=
 =?utf-8?B?TlB1dDVSTmFIUWtsQUN5Vlc1Y2Vqaml3blJ5cmJXaVRsdml3ZkR3cyt1WVNl?=
 =?utf-8?B?MnZFbXBielNpRi9YWUJNZE80MmZRelUremN2ZnlydzhvUmZ5eENyMHpud3g3?=
 =?utf-8?B?KzlSLzNmdlZMcUVadUFjRGp2NUoxamtMc3VkUlIwSTgxSzcwd2VhbE1TSmdZ?=
 =?utf-8?B?eDhLSXpFSnRsSmdYVXBrckdEVndmbGQ2bWhxQjBKcVVPWi8yWUgzVEc3dWhv?=
 =?utf-8?B?YWQ3VHhNTjJpbjhtVjlKU291YXIvOFpmcXltK1JZd016M1pvUUozZ25xRUJv?=
 =?utf-8?Q?1XFPsNDwBvnKQUWjyT5DwpmRj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40405a4-d096-4091-9e92-08dba0169d86
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 18:11:59.7133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zq5sqB9T4kfaOvcMXNuEhb74pR+RAnPjk+nTpF8PIcRJJB63Xxi19xjer4/qcUCKaVMqjnrOscGahgfLUO5Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/2023 13:07, Jarkko Sakkinen wrote:
> On Fri Aug 18, 2023 at 8:57 PM EEST, Mario Limonciello wrote:
>> On 8/18/2023 12:53, Jarkko Sakkinen wrote:
>>> On Fri Aug 18, 2023 at 8:21 PM EEST, Mario Limonciello wrote:
>>>> On 8/18/2023 12:00, Jarkko Sakkinen wrote:
>>>>> On Fri Aug 18, 2023 at 4:58 AM EEST, Limonciello, Mario wrote:
>>>>>>
>>>>>>
>>>>>> On 8/17/2023 5:33 PM, Jarkko Sakkinen wrote:
>>>>>>> On Fri Aug 18, 2023 at 1:25 AM EEST, Todd Brandt wrote:
>>>>>>>> On Fri, 2023-08-18 at 00:47 +0300, Jarkko Sakkinen wrote:
>>>>>>>>> On Fri Aug 18, 2023 at 12:09 AM EEST, Todd Brandt wrote:
>>>>>>>>>> While testing S3 on 6.5.0-rc6 we've found that 5 systems are seeing
>>>>>>>>>> a
>>>>>>>>>> crash and reboot situation when S3 suspend is initiated. To
>>>>>>>>>> reproduce
>>>>>>>>>> it, this call is all that's required "sudo sleepgraph -m mem
>>>>>>>>>> -rtcwake
>>>>>>>>>> 15".
>>>>>>>>>
>>>>>>>>> 1. Are there logs available?
>>>>>>>>> 2. Is this the test case: https://pypi.org/project/sleepgraph/ (never
>>>>>>>>> used it before).
>>>>>>>>
>>>>>>>> There are no dmesg logs because the S3 crash wipes them out. Sleepgraph
>>>>>>>> isn't actually necessary to activate it, just an S3 suspend "echo mem >
>>>>>>>> /sys/power/state".
>>>>>>>>
>>>>>>>> So far it appears to only have affected test systems, not production
>>>>>>>> hardware, and none of them have TPM chips, so I'm beginning to wonder
>>>>>>>> if this patch just inadvertently activated a bug somewhere else in the
>>>>>>>> kernel that happens to affect test hardware.
>>>>>>>>
>>>>>>>> I'll continue to debug it, this isn't an emergency as so far I haven't
>>>>>>>> seen it in production hardware.
>>>>>>>
>>>>>>> OK, I'll still see if I could reproduce it just in case.
>>>>>>>
>>>>>>> BR, Jarkko
>>>>>>
>>>>>> I'd like to better understand what kind of TPM initialization path has
>>>>>> run.  Does the machine have some sort of TPM that failed to fully
>>>>>> initialize perhaps?
>>>>>>
>>>>>> If you can't share a full bootup dmesg, can you at least share
>>>>>>
>>>>>> # dmesg | grep -i tpm
>>>>>
>>>>> It would be more useful perhaps to get full dmesg output after power on
>>>>> and before going into suspend.
>>>>>
>>>>> Also ftrace filter could be added to the kernel command-line:
>>>>>
>>>>> ftrace=function ftrace_filter=tpm*
>>>>>
>>>>> After bootup:
>>>>>
>>>>> mount -t tracefs nodev /sys/kernel/tracing
>>>>> cat /sys/kernel/tracing/trace
>>>>>
>>>>> BR, Jarkko
>>>>
>>>> Todd and I have gone back and forth a little bit on the bugzilla
>>>> (https://bugzilla.kernel.org/show_bug.cgi?id=217804), and it seems that
>>>> this isn't an S3 problem - it's a probing problem.
>>>>
>>>> [    1.132521] tpm_crb: probe of INTC6001:00 failed with error 378
>>>>
>>>> That error 378 specifically matches TPM2_CC_GET_CAPABILITY, which is the
>>>> same command that was being requested.  This leads me to believe the TPM
>>>> isn't ready at the time of probing.
>>>>
>>>> In this case one solution is we could potentially ignore failures for
>>>> that tpm2_get_tpm_pt() call, but I think we should first understand why
>>>> it doesn't work at probing time for this TPM to ensure the actual quirk
>>>> isn't built on a house of cards.
>>>
>>> Given that there is nothing known broken (at the moment) in production,
>>> I think the following might be a reasonable change.
>>>
>>> BR, Jarkko
>>>
>>
>> Yeah that would prevent it.
>>
>> Here's a simpler change that I think should work too though:
>> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
>> index 9eb1a18590123..b0e9931fe436c 100644
>> --- a/drivers/char/tpm/tpm_crb.c
>> +++ b/drivers/char/tpm/tpm_crb.c
>> @@ -472,8 +472,7 @@ static int crb_check_flags(struct tpm_chip *chip)
>>           if (ret)
>>                   return ret;
>>
>> -       ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
>> -       if (ret)
>> +       if (tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL))
>>                   goto release;
>>
>>           if (val == 0x414D4400U /* AMD */)
>>
>> I think Todd needs to check whether TPM works with that or not though.
> 
> Hmm... I'm sorry if I have a blind spot now but what is that changing?
> 
> BR, Jarkko

It throws away the error code if it fails for some reason.
Todd just checked it works too.  I'll drop it on the M/L for review.
