Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89787837E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjHVC0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjHVC0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:26:12 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2C0DB;
        Mon, 21 Aug 2023 19:26:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pb0y21/gWxtHFMGPZsKcAVYEzIuV6ItXneXqbTupyX7Qptc0uKH8flNHM6fZKZp2ijiYsivUcGn/p6fH2xRErzgjCPj76fO3HipyFH+GcqTx+a1BlN1rwgAYhtfK55xbiNfxXeD51BEOi+vwCg6dN1efel6hQUP3Kyn5VsQ22gHf/RvhKapDdgAj1njwlquCxtSrxX4NLmpSS2h0fPBFecUyry16ZNyItpyIDi1MJQ2gtzhmr1wJ0NX3y906iwIIF1stj/yYx8mqdR2IiBbUS5Dh1kLPOa9PhFgg5geJ2X4j4ZJyP3jOoTjrjTda+2KDjCvVKXgMAXZkyFKbf3hBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Odbk600YgWvbbDRn32SO9sC5JlFv/7FRmRF840lqEgk=;
 b=NV6jr3dLHEddV8k1ZgoMurdGEJi27k7QWMZMLOVfzjfNg8c6Q7yW9rsBBBBgxKSEH3LXybPrFy93AoEY5X5MGTR739CzEfZ5EDCoFYzaWf9HftmQAn6o7GuDrfE9FATuRWXzaLrxpYe18WFZqjW9RqTZqYBcNol4uUVOMDWHe6q9rI0/Nuz/F+yaYrpNZE0rI/Oua8k/yDVCwgo8/ZSrBMFTLVN7TGBcy6ePSonkjz7R1E4VS6oL05TqtbH5WE/GaW/OEH9MTQ66L/I+BPEBgpQbXY/AsIuxnXjYmc/PnrKJvwSMoGl5QDvio/1ykHpV/S8DM+kAPbEl+K2FWDZpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Odbk600YgWvbbDRn32SO9sC5JlFv/7FRmRF840lqEgk=;
 b=NvexEDWHH7u5nSmnu/BvSLMfz8F9Ni3DGaWE6VPvnHXm6UZa6hZ1bw6XyvetMlUwiqPJyiDRhHxSxFdY7x61Cq83NRgUzJaSQV/0680kcXybqbiQ+WMqI4LM/gTNpQn1h05Qg4wVqCN87Kxp9MF4VZ/JSDMeefApygKxKLlG0Bw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 by DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 02:26:05 +0000
Received: from CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::48cb:8b61:d51e:3582]) by CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::48cb:8b61:d51e:3582%7]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 02:26:05 +0000
Message-ID: <ca876775-6cb5-33c7-5512-232d34a47f4a@amd.com>
Date:   Mon, 21 Aug 2023 21:26:02 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH] ACPI: PHAT: Add Platform Health Assessment Table support
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Avadhut Naik <avadhut.naik@amd.com>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org
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
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <CAJZ5v0g_DyQAnSuigBc-f0UNmW0mo=0yMadES+0NhphJs_k+cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:806:121::10) To CY5PR12MB6203.namprd12.prod.outlook.com
 (2603:10b6:930:24::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6203:EE_|DM6PR12MB4092:EE_
X-MS-Office365-Filtering-Correlation-Id: 601f0bfa-597f-49e6-468f-08dba2b722bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLOtDI3CtLz73546H5idCrCR/r0tiIoRF+Wa+thlxnSxJg4eI+z5iGjBXntCPeRWKeB8YGfYyxZWKh7Ilg6dY+kZ6dFkTyh9yfIu9uw4gNqNxhcXVQY4B/OJrc7ZELkxtRO5gCHbt+AAVce8myISvJs+wnfMMZKXZxEKz6zS00C3eVSJRIHlxNtFFUKyJIP0YcvwffJDG+whv0qo500A9SOUH0uYRpSIm1Qs2AKL3VCAi/k5FbDB6/6ag8s4Ph15vufHo2Yx13sIz8q/pb9xs2AFx2J2/vWlj3W0UB/tn0U/vh6haLLooGA3jDKugWoh5NQoGrXJVLDJeI6DebZJKw+XvSQoMvMzAqZ0Jjg3xz3seah9atF8aZZyru1Jlgm8C5icM8yVVQmr2qEnSeULfdJo6ZI0I3Gws75XqRtxi1eo0/EW3CS3Efno4gFOlAMGeMudyky1il3CvwD5YFCgH2G3RH8tS92GvAruT9TADj+NLIbvfMRmm67BmDvPBbgu4G7t+h7Uf0FWiTCeCWi1WnznaDwE6iBtG/2f/kF4onSd/21t3An0fCoPblasiavpvr4SUdx2LUhimKX2ahrlVmY2yETugbUpfJfXc/l7nhkrmB3uokS4SlnFuzipppl/QXpCD78hScZshV9MP9vLJ3hbqRmZNioMXLqcFhWPgz1tydM1znwC3aVziVJSy+/ewwCp68RoPz6Y7I3zropXtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6203.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199024)(1800799009)(186009)(2906002)(53546011)(38100700002)(6486002)(6506007)(83380400001)(5660300002)(26005)(31686004)(31696002)(8676002)(8936002)(2616005)(4326008)(316002)(66946007)(6512007)(6636002)(54906003)(66556008)(66476007)(110136005)(478600001)(6666004)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVFTczRSZlQxbnFiSE9mNldIMFZER2oyZmo4d1ZYM1EraFdnbm4yZ1Y0dkNo?=
 =?utf-8?B?OHowa2xCMmtyVklDUVRnYWRZdEc5U3pseDZZdThxMlQvZ29BeldBVStsNHJ6?=
 =?utf-8?B?MmtEVjR1RFZFeXlyWE5tN1JZSmRaZWtnQkNDYTZldVhoVmF2a0NsZ241b3J0?=
 =?utf-8?B?UzhRcjYxNTdGQjQ5OFBkaVBpUEFtbDJ2azdLdGZPSVJLNnlVNzNRaTdIUVVr?=
 =?utf-8?B?bFdPdTkvVUFkTTVnSjFnWklDNnVBQXV1aE9xNThPcU9XTDVWS3doVzJwWmNN?=
 =?utf-8?B?Y1lqTVZzM0xucU5CdTZSb2R5TjIrVyswOTlOamVsL1hwMStxNE5qaXBnazZw?=
 =?utf-8?B?ejZqOFg1cjZJSW5rTGNoUXZVUzNBV0J3dlVJb0RUZ0tkMS9UK1VOeXh6SHow?=
 =?utf-8?B?YlZVREhNdExGTVdsd1Btck44anlURy9vZWpGL05zVnFEbnJ0R1Vpa3NFTzJq?=
 =?utf-8?B?SEhQSVNEZ3JGcEY0dlA5OHJ4WmV5Q0tPRm5tSHpYZ1Z0N2d5NUJXRmxMaEtw?=
 =?utf-8?B?eGErSWNLcmtZcjFydkpVZ1dHM29hOExHVTdxeXNHSXVudjdrbnJuUmNpcHJY?=
 =?utf-8?B?RHJCZ1VSM2tVa2NCYXRWLzFHdmptVzhrMjQwN2hLMWlRaTFpS25zQXA2VDNN?=
 =?utf-8?B?ejNDRm9OWXBtUVlLMXNmSEFZdXpjWGlWdkpEUDUrdVpybkhrNmlLc0tpT3Fx?=
 =?utf-8?B?SHM3MktGME12aVNhVnVTUzRoYWQySTJVaWo0RmcyTGxzMmZkQ0hkd09yRmxY?=
 =?utf-8?B?ZEpwNnM2RFJIazlSRk9ZYzFSNHRGZ0R4anhFeWV0bWcwRXk2ZkptZk9xeWpt?=
 =?utf-8?B?OWMva09IVDd5SnIrOUZqY2pWdzZtWUF5K3VOM2FBbEYza0VwMTlYdTI2VG85?=
 =?utf-8?B?REt0OHlpWW10UDVCTGxHaWJabHl5UEpITFNENktsZ01aYjNjZmFlakxUUmNE?=
 =?utf-8?B?eUVMN2ZJMTBoRERhSG9YT2NzY2c3eGNkUytmTExqcDF1TlA5ZTlyRmYxbmJC?=
 =?utf-8?B?OWpJTmxPSG1qYm94THdtWWxqOGdnUndIRXl6TWRHQlN4Vis2dUMwc3I1V0x6?=
 =?utf-8?B?RUZPTW8rd09hRFV6bElTZFhEWkdPUXlKMDNpVXFsaEJHQlNoN09Pbld5OHN4?=
 =?utf-8?B?dVF3UXQ4c2JxQ3p5TndJd1FrMEsvS2l0bm4wdjRuMFJBbmt3b01STmw1YUxY?=
 =?utf-8?B?VjcxdE1mK1BkYlNoaDhMaTkzT0tkaGhlRXBXZnhMZFJEQWxvbXZHK09MSmJT?=
 =?utf-8?B?Qk9zOU1sSXhJeXBydzUwYlZDRU1jd1I0ejlWWnFKTmRMREFCbC96bkcwbGtZ?=
 =?utf-8?B?TzRlN2JGcy9keU1xR2ZBNHh4ck0vUFNadWk5eEl4d0ErTjZRM1JJVzhUSnI2?=
 =?utf-8?B?V3VhMk8xWnNVNU9neURMMXZZU3hXV2lzcDZNRkszWXJTWjZUREN6NmVnR1NQ?=
 =?utf-8?B?Tm1zUTFuS3ZhYVduekVuSGloR3B0a1MybGt2L0FrR3ZNMzdYZlhTMHRVd2RH?=
 =?utf-8?B?ZFBnczFvRG10UFZBV1F5L05YZTFhZ0pjVFAyZ29ycTQyQUU1ZG41NUZGd0Y1?=
 =?utf-8?B?cURuREs5aDhMVTN6OXhKdXlZYzcwM0YvMXNwOFNzRDk0bEZHelMxeGJNSDVT?=
 =?utf-8?B?MUVRZ1N3RURobE1VYWhKbXNMdy9oOGhwSUJkWEplN0tTS2s2SUZ5eEpCbFFr?=
 =?utf-8?B?RXllTFpkOVZZSysveDZITnFSQk9aUWlOWWZSdVQrQUc5cWJNQmZWWU5YSlRW?=
 =?utf-8?B?Q3ZjUGUxdUVwc3dCenNGQjJwSmtuYXVRNUlOYThWemYyM0dxbU5YZER5L2VN?=
 =?utf-8?B?RHhoajlkT2NRanV4L1FXZmhFT1d0cUluVk9UMDNxUTV0S2NRMEJCVzVSbThv?=
 =?utf-8?B?ZG1oR2Jib3NhV3I4TWpFTDRuMmtOTzNUbnhzMTNlTndOeUIwT0cyWkthUXh5?=
 =?utf-8?B?U3lRQ3VRVWlhQUlDWVRTTXFJSWJwQW5ySFBpRnlXY1NIWWRaeS9YMUFGUXR3?=
 =?utf-8?B?dlEzS25JZjlaRXcxWUZWcVBnRS9RYytQTnI5NGtsZGxLelFYaGVFMmcvYW5j?=
 =?utf-8?B?a2FNa0dTbDZCTkw2MmNsUnpjTHNxY2NGc0plTTRNcnk5emd6ZnVTWGRhRTFm?=
 =?utf-8?Q?KwEm0It8qM0KpM0J6uQ6VXt+F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601f0bfa-597f-49e6-468f-08dba2b722bc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6203.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 02:26:05.0376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyJ4xTPNwwGwM7uoYWuiQ0IRsuEtLe2VL2HXltTstcBotsizNAhPrl/Ca+c8QQk7JbJddriUM/Az8DXNsFDt2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/21/2023 13:01, Rafael J. Wysocki wrote:
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

I do somewhat agree with your point.

IIUC, ACPI Table parsing can be undertaken from user-space for ACPI
tables that provide error information through sysfs and, if required, MMIO.

Our principal motive though in wanting to add support for this table in the
kernel, and please correct me if I am wrong, was the absence of an open-source
tool to accomplish this. Having support for the table in the kernel should alleviate
users from the need to develop tools and manually run them whence an unexpected
reset is encountered. The data is already available in the dmesg / journal for
analysis and will be available across reboots in the journal.

An alternative for a tool might be using acpidump utility and ASL but even that
can be tedious at times since tables are in little-endian format and users might
be required to undertake byte level decoding of the dumped table by referring
to ACPI specs. Wouldn't having parsed data available in the dmesg, at least,
be convenient in such cases?

Another important motive was the reset reason health record itself. Below is
an excerpt from the ACPI spec v6.5

The reset reason is intended to supplement existing fault reporting mechanisms on the platform (e.g. BERT tables, CPER) or in the operating system (e.g. event logs)

Since existing fault reporting mechanisms log into the dmesg buffer (AFAIK) and
Reset Reason Health Record is intended to supplement them, wouldn't it be fitting
to have the record available in dmesg buffer too and ensure that all error info
is not scattered but available in a single place and across reboots?

Also, I do agree with Mario in that we should set expected reset reasons to
debug. Rather, we could have the entire record as debug for expected resets and
only log to the dmesg for unexpected resets.

-- 
Thanks,
Avadhut Naik
