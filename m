Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE50379439D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244041AbjIFTLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244129AbjIFTLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:11:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D6E199A;
        Wed,  6 Sep 2023 12:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wda8zpD4fSESh20WT8a7fv3Y9BVXZzv0ajrqgLGnEV+3dWYnL7Rz+UhQz9uDS03d86ro9/WJyYpXQwkfJc1JR/f1WBGngsdvVrJCt7LoF871YrjtaqeBkd1Zq0WcQ8JUbRnzvXbKUN8O/vne4p/FKNiv4nruIbdnm/zkh0TIMAGQNTebrSBLpOwUD3MinBVB6dMdQCTP54IPzRd01A+7Azr6xTTWpPSaKmHrOd0com9eeJ1hoOR+gAMXxTn5WNvNKfp1k8wBzMEHN+PpweTzzhtLsYcd8oGUWs1fRLENT4bnOUngOMC8Fvam837Sd0zW1089aE3Xe1VCMWE5MRnBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYZfiZu2Q1RxKbjZrtgessJaItP6wkgbsP0/tZEFMEc=;
 b=nNEQybgmVOQSBB6u676ht4wlL/lmm5YVv4Ig64torO1WGmkshkCdS9kH+k7QYvnr0MOEdwdWqvp7ahFPirTyAr6NUcoLfEDq+JNB0f1rVAR0kC9XxOV8OdvUVGJlViebOmRZpUFjHoE/7pCz3TLMTL3K+IW/Qa/KfFcLRWqVUtnwvqlVigFiaJ1JuX7Cza0vlvpBHzcR9bA826HNqgks6XxGLzxCsiYYQawlIb0M05zJGIR9zF3gz/0X1tWojQrCO1cO8rf2CQ308rb1/GoEXE69Z5SgmHHqCORERYdZ0+0brPul7+iajS1AFw0v0hT/d6NpGxssum4FIXde5V04wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYZfiZu2Q1RxKbjZrtgessJaItP6wkgbsP0/tZEFMEc=;
 b=3u0fxQh0NzdwZYnp1aknX1N4IOd2md54TlsTQ2JS9rJUyuIeZSzZCtOb85hrc2x0Y9G+rjSm0mBjAc7IPTAd63G8QQ40HbVSSrUVMBG4vROIFPOcUrWwkx4xoO9M36/fYcAjbu6OCLbkD5andfA1EiNKwvReSguxbmR0DCTAZ10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 19:10:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 19:10:59 +0000
Message-ID: <0c9a2ade-1501-48a7-baa8-37ab5a2c9ac5@amd.com>
Date:   Wed, 6 Sep 2023 14:10:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/3] Avoid PCIe D3 for AMD PCIe root ports
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     bhelgaas@google.com, Shyam-sundar.S-k@amd.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20230829171212.156688-1-mario.limonciello@amd.com>
 <6ce36e6e-726a-69f3-882c-0790d311eee1@redhat.com>
 <4c80cda2-82e4-4eb3-99c5-f2be3bfa96ed@amd.com>
 <fbd1369e-1738-3346-19ad-e291da491f12@redhat.com>
 <CAJZ5v0gSUwysQChe1K7CZSZhMbD0m3S27HFe7HwXSdfrMoNq6Q@mail.gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0gSUwysQChe1K7CZSZhMbD0m3S27HFe7HwXSdfrMoNq6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::7)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad55da2-487b-4578-7aa0-08dbaf0d015b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DxRjhcldSMmB04k+0hRcCSpiYWEbGcLzMoZ+MwGnyTyEIWG8nyiCbRtOjsInYsYBW/gLi2g5OyzDzNqLyYW7734TpPnqwXlI6Dbq39JYvxtX3OGdNejuH35OtjLual1wYdecdkbnBOAh5Pmk9hKc88F5JoyRXp20oyAr/SYQhzd4itWpHyXMg9e49bY8aItMZynoDWzdWaf3LqGJp/kNnVVEcVeKriK1Wm+0IRUXqZyVfs88A4jD7BorEfnuhHUKQsXg+Wu7M5wersl5Cqt8XhJWBzQOnNmZ4DtZ26CUml3JCfgwlpuFopJfnO5+VqracT28iWefH9brENRHQ3noqSx4Hg5lZQl8kaT+DDsHNdNd7j1RCmqGBgDYZkaPElN7k6JAoB/Xrt9xXTo7i1HIVy3NcRye8V6o5nBupzMNqs4uXnuYkti/3/fghynACE+Kq/Sd7KzRndMNN1UgvegtLHLXJClzgW6LPpZemGd/Wx8AZi+9tKX3+62hSvF2WJF9D+86xRdBPXs+guI/g5jhy/Pb5gjSC5bDZXigdNcFW90k8RarkZyDJ8D2YXVgH+GPT/tQtec/I6X2+ST34Mm+3SQbKg1gUiTfAkLe4+/+1my2luxJxSI87YYkXb2P6HjxeUlyabwmB2d8ySZwgXensw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199024)(186009)(1800799009)(31686004)(6666004)(53546011)(6486002)(6506007)(36756003)(31696002)(38100700002)(86362001)(2616005)(2906002)(26005)(83380400001)(966005)(6512007)(478600001)(110136005)(8676002)(316002)(8936002)(4326008)(5660300002)(66946007)(44832011)(66556008)(41300700001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU5nMFREOG55YTJpbjJGS0o3Vm5DVFFMRGRJWTB1TFhvUk5aWTB0ZXFpanVF?=
 =?utf-8?B?b2RXaHdER0E3eE5jOEU3Vzdlek4rM2RXbzZhSXZMR2lJS0gvOEZxb3RnQlpN?=
 =?utf-8?B?bG52MHdPK0pCYjlVRGJnY2k5VEp5anlvbFJvVUJQcTJVRXpyWTRORFRHVndY?=
 =?utf-8?B?bUFoSU5EZ2xSN2xpdFlpc2M4c3g0a2QybEZndTVwZXFnTmhGV0ROa0dxQ08v?=
 =?utf-8?B?TFRGVm00WU1IVUIzZUljR1dacHMwN01hREF6UExqKzhOU3g4azZ0TElaTEFX?=
 =?utf-8?B?enRKelRDU2VGTzFVS2VxR2s1YnJYZmpWVFZRM3ZiQm11aTUwenFQSS9GSk1V?=
 =?utf-8?B?VjFLdk54TjBOaVBrQzNHRm1JS3RKaStXRUJaR0xzaVczRTJIVVZkYm45Ykcx?=
 =?utf-8?B?LzVVSXZRRFNxWkRUNjhYR2pEc1RoSi9TZ2JjSTlSVXplTTg4SHJ0eDhzQnBk?=
 =?utf-8?B?eWYxanR1TkpKdlZhREdaTk4wSnY4V3VWOUVCSkZ3L0VVVFpmdmt4Y1dwbWNB?=
 =?utf-8?B?R3NrWjBWbGowZm9xK3hER3cwTDEvN25aekozSERJTWFIUGtXNk4zSlB2MDlM?=
 =?utf-8?B?cEdlMzE0Q3RLcXluVmZ5eVFleDV3R09JQlhwL3FGcTRnQURyamtONVJkWlht?=
 =?utf-8?B?akZ6MWtUS1dOSjVFWmJmL3hrNGdkT1BtdnpwZ3g0NzllTjIxa3A3dU5aK1JV?=
 =?utf-8?B?VnZocWxyc3ZjMVl3Wk9PMWI1d1F6WkQ5S1RBMEV5VFJ2WVpWbTZNU0NuYVg4?=
 =?utf-8?B?TkNEbHd6ejl4SWN6NlF3RHhHVG1USG1acGsrTUNMYnZOZzJhZUhETEgxQk9k?=
 =?utf-8?B?SWdnZkRTUDVDbDBiYWZySDRNdlZ2UEZ1SEQyemtwdEF3dExwVkJIRC8vUVhx?=
 =?utf-8?B?TVQxaFBHYTR1elV2RlVra3F6SnlvMUY0YXhuQkltU1Y4MnlDRXYvWjIzZVN5?=
 =?utf-8?B?cXRNcTM3aWtveEIwUXMzM2Z5UDl5UXdRamUrY1UxSU03UHhSVGxwcnRNR05Q?=
 =?utf-8?B?N0t4YUN6Tzk5OGd2RzJaSG1SLzhKQUVhL3hpL2RId2oyTWUxMUdkRERZb0Q1?=
 =?utf-8?B?b21ONXI3SXF2Y3RUQmJaSTR5UVAwVEp3MTZweXUxaGpTcjVuZ1FnUjgreTN2?=
 =?utf-8?B?cVFXWG56ZEU3QURaakVIU3hLUUhzSmVqMzg1aFhMK0FNV1I1bjBZaGxZeFhW?=
 =?utf-8?B?dEp2Rkppc08xeTVEME5zL3FjNHl2bmg2UWRLWDJsV0FoUFVtcW1BNm1Yd1FV?=
 =?utf-8?B?bkVTeHU4N3NoUXEwaENaNlUzbmdsY2pYNXdyRTlENkdlY25zOE94ZUNSanM0?=
 =?utf-8?B?MkNDd3ZFNnE4NzNncTF2THBUM210bkFIN1J5TW9SbTdhcjd1azFKckZxeVYv?=
 =?utf-8?B?MG1RK3ZvZTh0c1pObjNpT3ppZCtHQmZOODRKbk5rTmZyMlBhVXVBckkrMEtl?=
 =?utf-8?B?RGdDV0pvejRKZ3hOckRKTFAranpyUWZNM1hkY2UvZ295YzZVWHlLWHR0QUZu?=
 =?utf-8?B?a3pFTnZjYnpMS1VCdFAyVllaczV4R3BZT21vaXl3bDM1aGUzcVpGKzhLa0tM?=
 =?utf-8?B?RHZ0RC9WcHZDTm1KMzd6UXRTK0QrNVdrblZiNG1PNXJOU1VsR3JUaVRFRks2?=
 =?utf-8?B?TDc2b3FXS2lMbWZmQ0psMklBUmdUZDA5Q25PVzdBY3poV3R1WmJsK3ZTNjl5?=
 =?utf-8?B?K210QXlRc3JpTDBGQTNISmZnTGIrNko2UVNUQjdpNXlyRWtCT0ZpQ2RDMXpL?=
 =?utf-8?B?QzVhOHpFRUQxa090QUVWbjd2NEhocTJGS1plRndXV0xpRGlKRHRWTEZsZjY3?=
 =?utf-8?B?WGtyYXl5dE1BaG9YSHo1TkxGdWFIWW5kcjQ2ZlVEQTR1L0FidjlsdXdKME13?=
 =?utf-8?B?cllBcUI1NGw5ZHBpWjVCamxqZER5MUVGUG0vMEpma2ppSmJUMVBmOUlsWkxM?=
 =?utf-8?B?UXJvUkhrK244SXdqRnY4b0RLM2FjS2VjRzlxTzhVNXAwSnkxUWF3Z0ZXbGt1?=
 =?utf-8?B?eDByQ2lXRDRROFVSMWZOL0MxbWdnc1Y1SDVROTJKMEpLYjBhQzViL0JOZ2dh?=
 =?utf-8?B?SnJYS295dEVwQVZFYUdKWmRycTFhNFZLSlRXcDhMSzJ1Tnp3T2xUOStiZGRJ?=
 =?utf-8?Q?uO2OaUdX0iqDnLJt8H7BE94fi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad55da2-487b-4578-7aa0-08dbaf0d015b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 19:10:59.7136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxR0gbVVN1Kn/+9SAf0hwgjHXCHM0oEUdRzUm5a2oiP/qQnWTmwL0sGR0dgYzkPCJ/xsilUWMpdY5y1x55r+5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/2023 13:56, Rafael J. Wysocki wrote:
> On Wed, Sep 6, 2023 at 2:24 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Mario,
>>
>> On 9/5/23 14:45, Mario Limonciello wrote:
>>> On 9/5/2023 05:13, Hans de Goede wrote:
>>>> Hi Mario,
>>>>
>>>> On 8/29/23 19:12, Mario Limonciello wrote:
>>>>> D3 on PCIe root ports isn't used on Windows systems in Modern Standby.
>>>>> This series adjusts the amd-pmc driver to choose the same strategy
>>>>> for Rembrandt and Phoenix platforms in Linux with s2idle.
>>>>>
>>>>> LPS0 constraints are the basis for it; which if they are added for
>>>>> Windows would also apply for Linux as well.
>>>>>
>>>>> This version doesn't incorporate a callback, as it's pending feedback
>>>>> from Bjorn if that approach is amenable.
>>>>>
>>>>> NOTE:
>>>>> This series relies upon changes that are both in linux-pm.git and
>>>>> platform-x86.git. So it won't be able to apply to either maintainer's
>>>>> tree until later.
>>>>>
>>>>> Mario Limonciello (3):
>>>>>     ACPI: x86: s2idle: Export symbol for fetching constraints for module
>>>>>       use
>>>>>     platform/x86/amd: pmc: Adjust workarounds to be part of a switch/case
>>>>>     platform/x86/amd: pmc: Don't let PCIe root ports go into D3
>>>>
>>>> Thank you for the new version.
>>>>
>>>> I understand you wanted to get this new approach "out there" but
>>>> this does not address my remarks on v15:
>>>>
>>>> https://lore.kernel.org/platform-driver-x86/53d26a63-64f3-e736-99f5-32bf4b5ba31d@redhat.com/
>>>>
>>>
>>> Right; I called out in the cover letter this is pending feedback from Bjorn.
>>>
>>>> Bjorn, I suggest to allow platform code to register a callback
>>>> to influence pci_bridge_d3_possible() results there. Can you
>>>> take a look at this and let us know what you think of this
>>>> suggestion ?
>>>>
>>>> Looking at this problem again and rereading the commit message
>>>> of "platform/x86/amd: pmc: Don't let PCIe root ports go into D3"
>>>>
>>>> I see that the problem is that the PCIe root ports to which
>>>> the USB controllers connect should not be allowed to go
>>>> into D3 when an USB child of them is configured to wakeup
>>>> the system.
>>>>
>>>> It seems to me that given that problem description,
>>>> we should not be directly messing with the bridge_d3
>>>> setting at all.
>>>>
>>>> Instead the XHCI code should have an AMD specific quirk
>>>> where it either unconditionally calls pci_d3cold_disable()
>>>> on the XHCI PCIe device; or it could even try to be smart
>>>> and call pci_d3cold_enable() / pci_d3cold_disable()
>>>> from its (runtime)suspend handler depending on if any
>>>> USB child is configured as a system wakeup source.
>>>>
>>>> Note that it is safe to repeatedly call pci_d3cold_enable()
>>>> / _disable() there is no need to balance the calls.
>>>>
>>>
>>> It's only the PCIe root port that is used for XHCI tunneling that has this issue.  This specific problem is NOT for the root port of "any" AMD XHCI controllers.  There is no problem with any of the XHCI controllers
>>> going into D3hot.
>>
>> "XHCI tunneling" is an unfamiliar term for me. Are we talking about a XHCI controller inside a USB4/thunderbold dock here which is connected to the laptop over PCIe tunneling over thunderbolt ?
>>
>> Or do you mean the XHCI controller inside the laptop which is connected to a USB4/thunderbolt capable Type-C port which is used when that port is in USB3/USB2 mode ?
>>
>> As long as the XHCI controller is inside the laptop (and not in the dock), presumably you can identify it by say a set of PCI device-ids of the "tunneling" XHCI controllers on affected AMD platforms. So you could then still call pci_d3cold_disable() from the XHCI driver on only those controllers.
>>
>> Note I'm not saying this is the best solution. I'm just trying to understand what you mean with " the PCIe root port that is used for XHCI tunneling" .
>>
>> I also see that Rafael has said elsewhere in the thread that he needs to think a bit about how to best handle this ...
> 
> Yes, I have, and that's because of the realization that the
> requirements may differ depending on whether or not there is a device
> (USB or other) enabled to wake up the system from sleep under the Root
> Port in question.
> 
> Essentially, the problem is that wakeup doesn't work and the
> investigation led to the Root Port's power state when suspended, but
> that power state only appears to be too deep for the wakeup to work
> and not in general.
> 
> IIUC, the port can be safely programmed into D3hot and then back to D0
> and that works as long as there are no wakeup devices under it (Mario,
> please correct me if that's not the case).

This is correct.

> 
> Now, when a USB device on the bus segment under the port is configured
> for system wakeup, it needs to be able to trigger a wake interrupt
> when the system is in the sleep state.  That wake interrupt is not
> generated by the USB wakeup device itself, but by the USB controller
> handling it.  The USB controller is a PCIe device, so in order to
> generate a wake interrupt it needs the link to its parent port to be
> up unless it is capable of generating PMEs from D3cold (which only is
> the case when it is connected to a separate wake power source and that
> is indicated by setting the corresponding bit in its PM Capabilities
> Register).  If that is not the case, and its parent port is programmed
> into D3hot, that may cause the link between them to go down and so the
> wake interrupt cannot be generated.  This means that the port which is
> generally allowed to go into D3hot (because why not), may not be
> allowed to do so if system wakeup devices are present under it and
> that appears to be the missing piece to me.

At a glance this description makes sense, but the logic in 
pci_target_state() already accounts for finding the matching states that 
PME can be generated from.

 From one of these systems this is the problematic root port:

pci 0000:00:08.3: PME# supported from D0 D3hot D3cold

It's accurate while the system isn't in the deepest state too.
If I rmmod amd-pmc or unbind it then the platform will never be notified 
that the OS said it can go to the deepest state at suspend.

With no changes to the kernel pressing a key on the keyboard works and 
you can see the IRQ that woke the system matches the PCIe PME.

I think what we're at here is likely an unspecified platform behavior 
that is "masked" in Windows due to the way that policy works in Windows 
(constraints will influence what states are selected for integrated 
devices by the uPEP driver).

I'm going to drop my updated series to the mailing list that adds the 
ability for a driver to register a vote like Hans suggested and we can 
see what everyone thinks.
