Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C587FAC16
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjK0Uzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjK0Uzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:55:46 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9DCD59;
        Mon, 27 Nov 2023 12:55:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUSdkHtwLtVSY6571ND7fcHe1H4wyJx1/LGDYmSyHPuh0+6TtxBZeLKa1U0rZe9OSz1inSAZ3A21Mp5csYWA6V0oSWEzsJD4mIlA3+j+OAFAN2gtRhFOamyXlg+5ShWB4F/Q7h/LcSUkLR570QQL6ESQKwhfzLZ5Dp2Y47938zyq3sacfBeaPy8MBNa3gbTXKzFOi+Y/JEyiqx0kw9zt8zKIRNXYkFwOyZaodxHmoxbWER+fhITGaGT7YlZmhEQs2fuLnQv6sues2giOO2F0bpielq3mqHE0R0f3ovoqLM/78bnIfi99xeqYvf4RbaB4ck+e1hBYQQ4ndil9K3DFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ud/RWcxE6wwxPFkNq+3lFji54o11DHmiXMWBRnyNcP0=;
 b=SnvwRDVDm3yNWR4+XRvEMJL/wKpRSi1BkwbHUwXdu8P9OAJhogjo/IvxeOFXvYTr9oVCBLweng7i3FEvhezDpRL+16FL8MtsgrgEk7kUqh1sKKu41RT/WdofT7D/aaliCO3aJ0kzFhrkFQuNjPN49Q/N7xKKRvfT23ZxP7xzF1rBSUHgDyJIrzYdJSZK/fbt1OftGeT0WsfYiJmFGlfj4yw3zeKZwYZzrc1byEdgwevvs2/E9u9fWvsgpNZbruywOdp2drzYSTHExGoqg8xVC+PNmG/L9kjyyJlBl7oCp8coJ0EJJd5nUUXwnTHgDqz8xGCSDAG4dh2Oc8FrGOGnCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud/RWcxE6wwxPFkNq+3lFji54o11DHmiXMWBRnyNcP0=;
 b=ZvtDWW+zggv9gV3WXpE1iaIytc5M3BEKkFSJiJ1YnuApcoJIYH/ozZcl/JDUiUQyxYnh+TrYZaEyCPQAgWwSsBJ53o7Iz7sdXCqPs+6P6QTJ4/+ZF9HUvwK1vwouyFN1tQXSuEjUZ2lOiTBSTfPsWK/9CK2vn7YOfj9FhPi1fJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 20:55:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 20:55:50 +0000
Message-ID: <e583fd64-2cff-4595-a559-a675c6f5ad0d@amd.com>
Date:   Mon, 27 Nov 2023 14:55:48 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: disable USB0 hub on ROG
 Ally before suspend
Content-Language: en-US
To:     Luke Jones <luke@ljones.dev>
Cc:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231126230521.125708-1-luke@ljones.dev>
 <20231126230521.125708-2-luke@ljones.dev>
 <30293382-2287-45a2-9269-55d547432085@amd.com>
 <F1VS4S.MV0FEK6EB3K22@ljones.dev>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <F1VS4S.MV0FEK6EB3K22@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0178.namprd04.prod.outlook.com
 (2603:10b6:806:125::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: b8065a4b-eb83-4682-5462-08dbef8b3c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5qeC6bV10oxyGM+uxNut9D5eM6L1kB5MyecEFpe0NiOxMT9yrihQrh1KqzMvxxNzkofi3XKhhDMg7X7fHNR9IyWOg3SZFoKxo9smcVK5mGr7BAyc8hG7l5J/6kJR0+0qPId1216NiZbJumCOq2hQTuYlFYBziSlqAjp64SMotPQU116FEDQa3sYliOr7LTJ4x+unauoPBT9M6fMEi+kh25+U9my+tdA9IJqhpb9UvO7qdTShSnKt/coYmXMXS6ZtDCzHOlePK6nD7DP/MtooWWyQKiWPl6m9MjSlHnovHGZWIPlDT441lD5B0vuuFQQuTW2Ur8CrmUNPahoPEJFhmZZPVYaJYZY/Ru8tjFbaZjphinBf0XLRN/FHh13jPR8jCTu0MadmiC5VhuXZq+D+rQVCrwiR/umvakcUqPt1IX+65y1UTzaN3HWwE9C3sHeWkD+3Ebc55fs6whWOpcuUNPQ05r0eMnY7lQPTws6l5RsLlBxaoXsfwahV45pHON9yLVuid9y7tIimBO2tSMhr9jSqs+Y1Ih948oMoXXTL8qYWjKXmxY3ZJy2ezTFmWE/+VR1MCjR7Z+sWawZcEVnGjR83/s+GS5dX95GMAbXKcxqK+Xq/yhdL527DElUkRsIkchLctKUjNEIPweDuEc0nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(8676002)(4326008)(31696002)(45080400002)(8936002)(6512007)(6506007)(53546011)(6916009)(66556008)(66946007)(66476007)(316002)(6486002)(478600001)(15650500001)(36756003)(38100700002)(41300700001)(31686004)(86362001)(26005)(44832011)(2906002)(2616005)(83380400001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3NrZDNiZ3lHbDdscEtqVStsRHl3a3YxTmlCMVJkMzRySXg2bmUwemRPS1B3?=
 =?utf-8?B?MElVVkY1TzJXRnJzMEphTEhGeWpqa1Jpa29sUkJCK1FZQUpscTBhOHQ0TndS?=
 =?utf-8?B?dFhsVmJOemhqTE12Ym1qU0ZiZXd4amk1dS83NE4rekUyY2VaU2l1THdBTXRz?=
 =?utf-8?B?RHR3R3p5d2tOUFBlK0JoamhRNE52U3FqdE5IZnJ6V3V1RkoxdkFqeWZicjZv?=
 =?utf-8?B?RWdDcXBkZDBDaGcveHJ0ZW9uZ2N3TEZvZCtubW1rcmlaVzg0WFBZVjQ4NjU1?=
 =?utf-8?B?cENmMXlnN3ZHSkczSTltMHN6WE42T2ZCSVJzemc2T01Lc2JmVVN3U1ZoZ3RG?=
 =?utf-8?B?VDdoUEVuYnIyWjNnUWF2UVVkazdmdE5WL1pDMXBKdHJRVWYwYnRNL01Wa0N4?=
 =?utf-8?B?NjVwWlJiTVZSMk92MVAvb21leWkzRlR2YUhRTzlWaVlLaHlOUU4rTUNVNXYy?=
 =?utf-8?B?ZzVnRnFHNlZmSzdRMXpvQnFwaVlBMWxMYXRQVXZyN3BVTlM3U2pvYTQ2SnV2?=
 =?utf-8?B?NUJoZFd4UUNFRDZXbTRPSFZqbG16OWVNcHk5ZVdKZmJUOWQxWDU5RjY2UElH?=
 =?utf-8?B?Y0JORG9ySk5PZmtvcFJnQmpnbEZ6RmpxTG5NWEhabnlmUXFxNGcrOFAyVm1V?=
 =?utf-8?B?cGd1YjM5RmZIOXB3RHIrNGRYTWFFc1Z4YlYrSkw4MUJYOUdIM2haaDdlb0V5?=
 =?utf-8?B?blFxdU05M2I0WVRyeGxoU1YrV082UjhXZCtlVG9XUDI0aE8wK1AweWpUbmY3?=
 =?utf-8?B?dEU0ZlhIRm81M3FwU1lWVUJocG5Vd3o0RTk4SE5EcEY3WTV6YzRBRVFLV3oy?=
 =?utf-8?B?bDN3b0swMkhMTVBDakxSUitPODNCYTQwMUg5U0VKSFJScW9LeVdkSGdiV05l?=
 =?utf-8?B?TUdsdnJzWVNTM2Z6VGIxcVpxaFMxZEt5OUNDS2pHUzR2Q3l2KzhtK0NETVBY?=
 =?utf-8?B?dkxPQ241SlpNVVVveEFJd05JRTNYbldrTWgwemVSZEc1Q1pUalBBV1BBMXpP?=
 =?utf-8?B?ZHFDSWVCZjdkZ3VVbElyd0lMZWFLckNwWjRUZENIci9IRGZIVExuSjBORkpC?=
 =?utf-8?B?WXMyaklZRDRRMTNQSnlTUzlnWlV6V1JmeXR0L1VoelFjMFVUenZDUk5NM2Fm?=
 =?utf-8?B?MWlqeTRVeEh3YkY3Qm1ubkVZT3FoeHQwRXdsUjVKM3NnWWhJNEM0aWowenpm?=
 =?utf-8?B?MnhBc29FUW1XUkQxSENYemxjUVkyZERIVFVXOUxhK3o1Nmh5RzYxVnpnUEhL?=
 =?utf-8?B?SmRVa2l3bk0wYWZWNFkwOXpVUzFVTlRpTkxvVFdGaml2UllmNHpQdXFIdWRy?=
 =?utf-8?B?VENmcy9xaEkvSUZWbFFPUFgxUzV4QXRTaHUwVFVIcjJyMTJDWjdTOUJabk5C?=
 =?utf-8?B?YnVkZjF6TThHb1dFMUFXSlJ3d1V0TTFGZlVQbDhHakVkcUlWaHVMWGRuZzY3?=
 =?utf-8?B?dHovOXp3R3dHUTVwdkNIOWl0NjhhT0xTVG8xaTkxUlF4WkgySHVPWVJzd1dE?=
 =?utf-8?B?WnF2VU1nQ0pUSVR1WmdER1RiL2Q0VFdZNk41MUhoVDhhcXg0Q2VBR1FHTTJ1?=
 =?utf-8?B?MTB4aDBMN0plTTJTaFBmOUlEUHZqT0dQTExlS0ZjNE9JeUd0bnN1RE9ZVUZJ?=
 =?utf-8?B?bWM0UUJpSisyTDMybVNRSXRCai9VSWRQWW8xR3gwSTNQdmxQaTh0cU9ES0Nv?=
 =?utf-8?B?YzQwVlFmaEJ4MktJNkJUWm82eFRUOFZxcTM5M05hSVRmQUo1eUc0NXJJRmc4?=
 =?utf-8?B?cm12V0swNW1vc2c4R2xCdDIzc1VjNEZ5VnNtQWlCZTJ2U3FHbmczRTVoa1U4?=
 =?utf-8?B?MUYrQzBnOUVKMFplWnpta3pucDdCSS95V0Z3bkQrSm9Tczg0OGZnQ2NjM2Jy?=
 =?utf-8?B?SkFsbFViREZPQS9vTW5zdTg4ek9oQ2x5SjVwNGI0Z1dwaHN6dzFZak9NRi9M?=
 =?utf-8?B?QmZuc2lsdEZPWFVrcUYwNWZFMGpUd2JibVVBcnJRYmJ3ajJvZlAvYUM4dzZH?=
 =?utf-8?B?N2l1V0VpM096eStCZkZMZUdpczVsVmVWSEIzcmFwYmkraHROQlZJYjB1eFFa?=
 =?utf-8?B?ak1vMUJkT1V0V2NnUTRvbG16d3ZJQ2dCNzdPVk84RkxDOVlCaTZYU3lDZGQz?=
 =?utf-8?Q?tUfw81mEHYsMJmSE7qxj3tjEv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8065a4b-eb83-4682-5462-08dbef8b3c9e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 20:55:50.1006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xauMtDT+u17b77Yl64b76OincrObxHpOvKpbvzIUoDayhAm+OnkMr01TD70zECz5gxrp3jvRfAlurV98AfrK9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2023 14:46, Luke Jones wrote:
> 
> 
> On Mon, Nov 27 2023 at 02:14:23 PM -06:00:00, Mario Limonciello 
> <mario.limonciello@amd.com> wrote:
>> On 11/26/2023 17:05, Luke D. Jones wrote:
>>> ASUS have worked around an issue in XInput where it doesn't support USB
>>> selective suspend, which causes suspend issues in Windows. They worked
>>> around this by adjusting the MCU firmware to disable the USB0 hub when
>>> the screen is switched off during the Microsoft DSM suspend path in 
>>> ACPI.
>>>
>>> The issue we have with this however is one of timing - the call the 
>>> tells
>>> the MCU to this isn't able to complete before suspend is done so we call
>>> this in a prepare() and add a small msleep() to ensure it is done. This
>>> must be done before the screen is switched off to prevent a variety of
>>> possible races.
>>
>> Right now the way that Linux handles the LPS0 calls is that they're 
>> all back to back.  Luke did try to inject a delay after the LPS0 calls 
>> were done but before it went to sleep but this wasn't sufficient.
>>
>> Another "potential" way to solve this problem from Linux may be to 
>> actually glue the LPS0 screen off call to when DRM actually has eDP 
>> turned off.
>>
>> Making such a change would essentially push back the "screen off" LPS0 
>> command to when the user has run 'systemctl suspend' (or an action 
>> that did this) because the compositor usually turns it off with DPMS 
>> at this time.
> 
> I would be willing to test this if you want some concrete data. 

It would require some cross subsystem plumbing to evaluate feasibility.
I don't currently have any plans to do it.

I think your patch makes sense; I just want to make it known that 
"might" clean this up if it ever happens.

> See my 
> big block of text below.
> 
>>
>> This is a much bigger change though and *much more ripe for breakage*.
>>
>> So I think in may be worth leaving a TODO comment to look into doing 
>> that in the future.
> Do you mean add the TODO to a line in this patch?

Yeah.  In case someone ever does it (me or otherwise) I think it would 
be good to have some reference in the comments that the commit 'might' 
be possible to revert.

> 
>>
>> If that ever happens; it's possible that this change could be reverted 
>> too.
>>
>>>
>>> Further to this the MCU powersave option must also be disabled as it can
>>> cause a number of issues such as:
>>> - unreliable resume connection of N-Key
>>> - complete loss of N-Key if the power is plugged in while suspended
>>> Disabling the powersave option prevents this.
>>>
>>> Without this the MCU is unable to initialise itself correctly on resume.
>>
>> initialize
> 
> Are we forced to use USA spelling? I'm from NZ
> "initialise is predominantly used in British English (used in UK/AU/NZ) 
> ( en-GB )"
> 

Ah I didn't realize it's an acceptable spelling for en-GB, and thought 
it was just a typo; sorry.

>>
>>>
>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>
>> I think it would be good to add a Closes: tag to the AMD Gitlab issue 
>> that this was discussed within as well as any other public references 
>> you know about.
>>
>> Additionally as Phoenix APU support goes back as far as kernel 6.1 and 
>> this is well contained to only run on the ROG I suggest to CC stable 
>> so that people can use the ROG on that LTS kernel or later.
>>
>>> ---
>>> -SNIP-
>>>   @@ -4701,6 +4749,8 @@ static const struct dev_pm_ops asus_pm_ops = {
>>>       .thaw = asus_hotk_thaw,
>>>       .restore = asus_hotk_restore,
>>>       .resume = asus_hotk_resume,
>>> +    .resume_early = asus_hotk_resume_early,
>>> +    .prepare = asus_hotk_prepare,
>>
>> Have you experimented with only using the prepare() call or only the 
>> resume_early() call?  Are both really needed?
> 
> I have yes. Although the device comes back eventually in resume after 
> only a prepare call it's not preferable as it tends to change the device 
> path. With resume_early we can get the device replugged super early 
> (before anything notices it's gone in fact).
> 
> This whole thing is a bit of a mess. It ends up being a race between 
> various things to prevent a HUB0 disconnect being registered by the xhci 
> subsystem, and adding the device back before the xhci subsystem gets 
> control.
> 
> If I add a sleep longer than 1300ms in prepare then the xhci subsys 
> registers a disconnect of the USB0 hub. If the sleep is under 250ms it 
> isn't quite enough for the MCU to do its thing, and on battery it seems 
> worse.
> 
> I have asked the ASUS guys I'm in contact with for something to disable 
> this MCU behaviour since it is purely a workaround for a broken Windows 
> thing :( They are open to something, maybe an OS detect in ACPI or a WMI 
> method addition similar to the MCU powersave method, from what I'm told 
> it would require an MCU firmware update along with BIOS update. If this 
> eventuates I'll submit an additional patch to check and set that plus 
> disable this.

Don't let them do an OS detection in ACPI, it's going to be too painful.
I would instead suggest that they can have a bit that you can program in 
via ACPI or WMI from the ASUS WMI driver that says to skip the MCU 
disconnect behavior.

> 
> I may possibly write a new version of this patch as we've seen that 
> enabling powersave reduces suspend power use by at least half. And 
> looking through my DSDT dumps, there are a few laptops with the same 
> feature as Ally. The patch for powersave being enabled requires also AC 
> power state on suspend change detection, and a later forced reset in 
> late resume (and the device paths change regardless when powersave is on).
> 
> When I look at it objectively, the device path changing should be a 
> non-issue really as it is fully handled by USB subsystem and behaves 
> exactly like what it is - a USB hub disconnect. It's just that some 
> userspace apps don't expect this. I will experiment some more.
> 
> Regards,
> Luke.
> 

As another experiment - what happens if you "comment out" the LPS0 calls 
that do this problematic stuff?

It's important to make sure the callback to amd-pmc stays in place, but 
if you just skip those ACPI ones does it still get to the deepest state 
and are there other problems?

>>
>>>   };
>>>     /* Registration 
>>> ***************************************************************/
>>> diff --git a/include/linux/platform_data/x86/asus-wmi.h 
>>> b/include/linux/platform_data/x86/asus-wmi.h
>>> index 63e630276499..ab1c7deff118 100644
>>> --- a/include/linux/platform_data/x86/asus-wmi.h
>>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>>> @@ -114,6 +114,9 @@
>>>   /* Charging mode - 1=Barrel, 2=USB */
>>>   #define ASUS_WMI_DEVID_CHARGE_MODE    0x0012006C
>>>   +/* MCU powersave mode */
>>> +#define ASUS_WMI_DEVID_MCU_POWERSAVE   0x001200E2
>>> +
>>>   /* epu is connected? 1 == true */
>>>   #define ASUS_WMI_DEVID_EGPU_CONNECTED    0x00090018
>>>   /* egpu on/off */
>>
> 
> 

