Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20196783093
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjHUS4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHUS4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:56:34 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800D126EAB;
        Mon, 21 Aug 2023 11:54:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCSG6hIhEUr30wfi1YmXxVGaUmi1X/l6NtYvOVGUsH7YZ+96r3EKkaWI4CV/yr/6Ths+0QLWn24Zb5RbdF4obLaGdUfYeVcqKIGTjzMHA1PBpuip+VpbZfso9jUPxkKn70ZCjh/XOsfO7q3fkmCT+T+UepSs8nioHJkPRhP6u/ts4jNQMtpZjnKXm1JWh1wJEYbPMDfC4oQEhx/acWYNnfFUd8meZqz+7MZ9o3YV8EJxVuk0iNOK/JsryRj+vtIDR/KlK9U718ZZ7e/qRTh+Ov03A+xt+gNUC4ZFHJMLG815sh/rQrQ3+cc08x+wkALSm9v6giVuc453zS1zV3iRRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cfg5uIsRmoATR5n9mx7LCgv8V06yYw97Nv5sXKpLjm4=;
 b=A1ETdkGN6AV+UmCvHqVgiEHvuzlrb/PWctQBNvmauT48Nu4YvtDU3r71rQOBHIOtgFVkGPRET5p9n01oKb1ikSmf8Mbc6EhIhd2k9gV/StwBJmhBfbSJd27I6bGSwKEwlYpqFLk7HOJWyDj0UGzSRoFHDbMfouQ3Du2f1Ysfqp2ikA+3wml2LiPLuYbXqQjNyeLu1pDTCkIMwSjtuI/7ay3v5r//3ChhZQuG79b6O1zfI/ZCQV2l0FLXYyZSoSPjVI4bSESA2PJu1OKTNcKMPGHk76KBPUlYE+nvMH2qchcyFM2UUNTJKDnTTfjNlz9+OTXd1hQBADEKzQEdK3uLyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cfg5uIsRmoATR5n9mx7LCgv8V06yYw97Nv5sXKpLjm4=;
 b=Y6CSgqmG+Yh/dEumFFIPkx78o82vusLqkKB82h/p6xYKlknL2TxnWYI112OfbxdLoau6WXC2HjZVFGkeETr/KxFuHelPDqbCQLmGjsqjd6MJmGLHD5EZPGnZZpUcD3LctA++H2y/uZiRPsbfUDyLY6CECzL1xEXA5T7iAh8bMK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 18:44:49 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 18:44:48 +0000
Message-ID: <9d491dfe-13d8-4072-a90b-5f68107fcf95@amd.com>
Date:   Mon, 21 Aug 2023 14:44:45 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, Avadhut Naik <avadnaik@amd.com>,
        "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Avadhut Naik <avadhut.naik@amd.com>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: PHAT: Add Platform Health Assessment Table support
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
References: <20230810234856.2580143-1-avadhut.naik@amd.com>
 <a0ab4d07-fb73-418b-b88d-c3ad6aa4cf49@intel.com>
 <655c916e-356c-03e3-6c67-aa40886dd5e2@amd.com>
 <CAJZ5v0j0R1GK=0z+LJd_PSh4zDv9Ydw2YA7HWm1R5wjCUsbbYQ@mail.gmail.com>
 <1c579c96-5010-4e5b-aa27-afb4f4f6746a@amd.com>
 <CAJZ5v0iPRCJLH5bkKyhjUq_tmjmR6R73fhUm3JnKptcm1cn9fQ@mail.gmail.com>
 <6bc15195-aa26-4e29-b625-74fca84f7a6f@amd.com>
 <CAJZ5v0jEcD_1+jHfAk9eN0YYJFbDZN2rZ97KHyH2-w6EqRN9+g@mail.gmail.com>
 <43b65307-bc3f-4014-9bf8-a96c6ed15d9b@amd.com>
 <CAJZ5v0g+uVZwoOr-2W19Ux9u-D=WiY=-dtcQZwYU0Ov_GE5d=w@mail.gmail.com>
 <CAJZ5v0g_DyQAnSuigBc-f0UNmW0mo=0yMadES+0NhphJs_k+cw@mail.gmail.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <CAJZ5v0g_DyQAnSuigBc-f0UNmW0mo=0yMadES+0NhphJs_k+cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:e5::9) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SA0PR12MB4511:EE_
X-MS-Office365-Filtering-Correlation-Id: c1dc2284-8c4c-4aca-0edb-08dba276b22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UeEUc4NF8xM9MSXbu7mJl+lnh+RZrzsh8L6P6cwAp3CTM27FBMGsoxnyg4kMhY8MLPbx3Pr60DUAXHhzg3RYqloqtSN571wDbL5NjaefrE1qg7xkp9PmU/hTSZCfX3ci/tGu4mUKTn6ZOZYlOsH+ZT8ea2h87aw6WNOkT3AbnPzsKKP+F4BALBd7WbASUKP2NsmeOOFINdqj1Oz3FdM0ZAZTvYG86qNqNjiiarerQk+Rwq5KD7e0txVuq8WMA0eFbq6XelSmRp0EWcKUx1MFI+tUTRgahnmfp7msNMPGCmzGO4rsfd4oBclOKK0IglnsYEMiEdIfR2gYOCa1t++i7qOa0gYCzMMzDRqJh9D3ERpFe8gkg2bJ8M+kt5h2KP4pEU61c2fVq7yT961HWFyagM2S4t8746Ugqi1elJQtvqCcO8N4JHOgMdoT5UleTc99NqzqpPC7lcEG0gEPvCzc1nrgpYXbcea/Ez2Q6O7RSeY0lDMTETJdI28WFlG43tw/5ql83DB2W2Fjh448fF7IRTqrVJ/CXTSajHwns1z5XTbDRXtC4vfQT3NZ7CFT7bRPRMFNcgXjwITlWBFzVwab/Xa8lVGbpgsd4j79eMPAllB3S1Ppo2sUuFB6BCtHrD6wf4Bz0yhWwgnP12dCsGLlQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(1800799009)(186009)(2906002)(83380400001)(53546011)(6506007)(38100700002)(6486002)(5660300002)(44832011)(26005)(31696002)(86362001)(31686004)(8676002)(8936002)(2616005)(4326008)(6512007)(316002)(66476007)(6636002)(54906003)(66556008)(66946007)(110136005)(478600001)(6666004)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STlsTnZVK2tyLzhXbjlKZm9TZzlGMzFqQTBUVERRUUhUajlUOWFVa0ttQ0Ju?=
 =?utf-8?B?cDhzN1M5a3N1MVEwV1dFQVltc0JWTHlZdWFWaVR0dzNOcE5vZ29NSnlyQkdJ?=
 =?utf-8?B?d3pMTS9FWEY4ZW5OVmsxZ3BDOUlsZkdId1hSc3Nib2tabVV1M0tJRXFqVnNh?=
 =?utf-8?B?ZEhnMzVFNHNpcXJrMUxSRjc4MlpHUVJrd3B2bkk0SmpmdFVXVENBc2hwY1p3?=
 =?utf-8?B?N2V4cGhQMEdOam90ZmFVNEU5ZHY4ZVFnNUc5WVo0U0xKTWRRNm1tZUs3MG4y?=
 =?utf-8?B?WUJhR3VoRUY4RHV5M0NQQnVSSzN6SXpwelM3S0xHZWFwVlllU3VqSW9GLzdS?=
 =?utf-8?B?N1JvQ2llQXJVRW5BdDhtcmVtS01DTG1oS2lLN1ZmbUgrZWpHMTBNY0ZqK2pZ?=
 =?utf-8?B?ZnZaM0ltS01LN05oWDRrY3Y5WGNCc2ttQ1Z5YmRKcUQzQ21IVG5JUE1yMEV6?=
 =?utf-8?B?K2JxVndBTnR2UG16OVBuUXIxZHFBK0lMV3IzZVZodHFHSHhmWW1yS215UVFK?=
 =?utf-8?B?MjJBdzczVmw3Znd6OVdaVVFyU29hVUUxTkM3ckp1V3FydDBqZTVBQ3VxT2pG?=
 =?utf-8?B?NE0vZnJsSXFibHYyMmZrQzRRRUFXcnFEY2VsYmhrcG90MjQ3V0RqUnBvcWlL?=
 =?utf-8?B?dVBKeUp1QmdIYXVlOGt3NHhWeW9YeFZuT3VxT2NRY3Q0Y2E0TEY1c2FDai8x?=
 =?utf-8?B?U3VDK0t2QmtDM09IOFNVMmtHMUphS2x0N21OU0pQU21GVG5mRnFlY1pkbDFK?=
 =?utf-8?B?dGlHcVAya2lOZjVxcFMwZTlqWk4rNmk5KzlneVhFdmw3MXV2d01rb3dBdllG?=
 =?utf-8?B?QkNpbitQaE1sL3lLQWp6UnR4eUJjeVhKSG5scXhXMk9tanhOb21XMGVzU1py?=
 =?utf-8?B?bmhOYmpuYnJoQlkrQUZpZFNuUTZMTTdRallVMkM1U0IyKzdIY1UvbmlrVFc4?=
 =?utf-8?B?OXpUNFJHNVJmZnZpVWpISEE5YTN0VUxsekIzblFaOXU2bXdJMm5lRlhPelhL?=
 =?utf-8?B?ZXZXa2JoWm5NK1Jrc0owZVJST2NwdnZMT2N5RHF1L3V6TWRWdmZqMFRucU5P?=
 =?utf-8?B?ZXhJeEtLWk5tYlJoemJGSU55NWs0QWQrQ1dMNzlRd1pTZVF4Tlp4cW9qL1Zy?=
 =?utf-8?B?Y21GTDU5RVdDK2xFSGJ1b2JKaVJHQ1NvRGFKcUMvOXNtYTlMTTM2RC9pbmtG?=
 =?utf-8?B?SU9YbmhiQld6MzJsM29Kdnl4a1JIeGlLNng3RzYyOGtOYmIrUEpqMjA4WlFW?=
 =?utf-8?B?bklBR05objJHaHdjZHljUlR1TWRES0lBRGh4bTd2dm83bnkzMGpaZnlGTWEx?=
 =?utf-8?B?ZWYzMEJiOWp2ckxydXI1RlhuaDM3UVQ4UHpXUkpaSkR5YlJOSGdlZ2Z2UUw4?=
 =?utf-8?B?dTBrMTQvdVQrUWRycFhWVVJrZncvMnRjS2VTZ0x0ZlNDd3paL211SytOYWFZ?=
 =?utf-8?B?dStCMlpzc3RqTGNHRmZPNmJtUjZkbVp1YTl0Nks3T1NEV2djeWxwUFdPYXJy?=
 =?utf-8?B?akZMK1QyTXdWU2krL0tFYWF1V0UwdWRwb3M5S2lUWU5oZUNielN2RUNMb0xC?=
 =?utf-8?B?YlNoN2dnMWRJcXZhRk5lRTNPOTRTb2ZwZDA1SW00aVVoVzY2QjJLMVBqVm8r?=
 =?utf-8?B?ZWcrUzdVMkFGa3VqTUlQdUdqWEpDRG5yNWNOYnpiZ1JlbGZacEZhZDVqZ0Fi?=
 =?utf-8?B?YkQzdUN1cmZpSGQ3SlFnRUNERlZPVXViSHVjT01WZUI0OURqcWNCckRFTTZ4?=
 =?utf-8?B?bVVlSGNiMU9sWnVaNGpFc2xxRmdYNVFhc3pDdCtoaldwemZXb1RYTE14RVdS?=
 =?utf-8?B?Y29pclJTeGlneXdFbXlwbWZrMUZEQldVSjVrVHJHSDZDLzdxR1hER2NHczJX?=
 =?utf-8?B?V0QzVnZnMmN2bjZWTThSaTJ5UktRb1AyRms4Ly9qVzhxaUs2eWFVWkZnY2ZQ?=
 =?utf-8?B?cDh3MTMwRGNIQjMwaGlHSktGTWpGZVdPSWxEb01tRUxvSU9JTGVrNDdEUWtu?=
 =?utf-8?B?QjNJREdlMHhDWUEzaEcwd29mMUsyMHlGbkRybjQ0d0VybWpzVS9Gc2hlblBM?=
 =?utf-8?B?NDBZQVhNaVFHZDZqdmRaWXYyQ29zOXYrTW1DRzV3UXdKMC8vV0pUUDExNkdD?=
 =?utf-8?Q?O3WdoOVeXFhGLbbesjhCfqmZ1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dc2284-8c4c-4aca-0edb-08dba276b22e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 18:44:48.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+BU7m37L9TjxjuuuHeEXV+sTy/NZn3ii1978TsWyLD0wCtm3EmstO6/5gMKT4QLumMh3xG18I0KOYPe6g/35Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/23 2:01 PM, Rafael J. Wysocki wrote:
> On Mon, Aug 21, 2023 at 7:52 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Mon, Aug 21, 2023 at 7:35 PM Limonciello, Mario
>> <mario.limonciello@amd.com> wrote:
>>>
>>>
>>>
>>> On 8/21/2023 12:29 PM, Rafael J. Wysocki wrote:
>>>> On Mon, Aug 21, 2023 at 7:17 PM Limonciello, Mario
>>>> <mario.limonciello@amd.com> wrote:
>>>>>
>>>>> On 8/21/2023 12:12 PM, Rafael J. Wysocki wrote:
>>>>> <snip>
>>>>>>> I was just talking to some colleagues about PHAT recently as well.
>>>>>>>
>>>>>>> The use case that jumps out is "system randomly rebooted while I was
>>>>>>> doing XYZ".  You don't know what happened, but you keep using your
>>>>>>> system.  Then it happens again.
>>>>>>>
>>>>>>> If the reason for the random reboot is captured to dmesg you can cross
>>>>>>> reference your journal from the next boot after any random reboot and
>>>>>>> get the reason for it.  If a user reports this to a Gitlab issue tracker
>>>>>>> or Bugzilla it can be helpful in establishing a pattern.
>>>>>>>
>>>>>>>>> The below location may be appropriate in that case:
>>>>>>>>> /sys/firmware/acpi/
>>>>>>>>
>>>>>>>> Yes, it may. >
>>>>>>>>> We already have FPDT and BGRT being exported from there.
>>>>>>>>
>>>>>>>> In fact, all of the ACPI tables can be retrieved verbatim from
>>>>>>>> /sys/firmware/acpi/tables/ already, so why exactly do you want the
>>>>>>>> kernel to parse PHAT in particular?
>>>>>>>>
>>>>>>>
>>>>>>> It's not to say that /sys/firmware/acpi/PHAT isn't useful, but having
>>>>>>> something internal to the kernel "automatically" parsing it and saving
>>>>>>> information to a place like the kernel log that is already captured by
>>>>>>> existing userspace tools I think is "more" useful.
>>>>>>
>>>>>> What existing user space tools do you mean?  Is there anything already
>>>>>> making use of the kernel's PHAT output?
>>>>>>
>>>>>
>>>>> I was meaning things like systemd already capture the kernel long
>>>>> ringbuffer.  If you save stuff like this into the kernel log, it's going
>>>>> to be indexed and easier to grep for boots that had it.
>>>>>
>>>>>> And why can't user space simply parse PHAT by itself?
>>>>>>   > There are multiple ACPI tables that could be dumped into the kernel
>>>>>> log, but they aren't.  Guess why.
>>>>>
>>>>> Right; there's not reason it can't be done by userspace directly.
>>>>>
>>>>> Another way to approach this problem could be to modify tools that
>>>>> excavate records from a reboot to also get PHAT.  For example
>>>>> systemd-pstore will get any kernel panics from the previous boot from
>>>>> the EFI pstore and put them into /var/lib/systemd/pstore.
>>>>>
>>>>> No reason that couldn't be done automatically for PHAT too.
>>>>
>>>> I'm not sure about the connection between the PHAT dump in the kernel
>>>> log and pstore.
>>>>
>>>> The PHAT dump would be from the time before the failure, so it is
>>>> unclear to me how useful it can be for diagnosing it.  However, after
>>>> a reboot one should be able to retrieve PHAT data from the table
>>>> directly and that may include some information regarding the failure.
>>>
>>> Right so the thought is that at bootup you get the last entry from PHAT
>>> and save that into the log.
>>>
>>> Let's say you have 3 boots:
>>> X - Triggered a random reboot
>>> Y - Cleanly shut down
>>> Z - Boot after a clean shut down
>>>
>>> So on boot Y you would have in your logs the reason that boot X rebooted.
>>
>> Yes, and the same can be retrieved from the PHAT directly from user
>> space at that time, can't it?
>>
>>> On boot Z you would see something about how boot Y's reason.
>>>
>>>>
>>>> With pstore, the assumption is that there will be some information
>>>> relevant for diagnosing the failure in the kernel buffer, but I'm not
>>>> sure how the PHAT dump from before the failure can help here?
>>>
>>> Alone it's not useful.
>>> I had figured if you can put it together with other data it's useful.
>>> For example if you had some thermal data in the logs showing which
>>> component overheated or if you looked at pstore and found a NULL pointer
>>> dereference.
>>
>> IIUC, the current PHAT content can be useful.  The PHAT content from
>> boot X (before the failure) which is what will be there in pstore
>> after the random reboot, is of limited value AFAICS.
> 
> To be more precise, I don't see why the kernel needs to be made a
> man-in-the-middle between the firmware which is the source of the
> information and user space that consumes it.

I think that's a fair point.

Is there a preferred set of tools that can be updated?

If not, would it make sense to develop a set of common kernel tools for
this?

In my experience, it seems many folks use tools from their vendors or
custom tools.

Thanks,
Yazen
