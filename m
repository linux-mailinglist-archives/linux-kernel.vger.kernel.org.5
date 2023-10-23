Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F68C7D3C11
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjJWQRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjJWQRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:17:14 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B2D10C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:17:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pv280UqLyOI52g6+OPQuxCYaj7rMrRkNqRtz4WXXenrmemcfYeTte0k1yJ/V8DZh3BOr/356EmjFh9faCKSlJZ2PxyOXOObpySJ4mU5+LmnXiBHTrcDEMrS3J8xkjZaIW0j2o/Na76I8tcqAEdALbwtxf38bWW4m4Qsal7BwJrfgFbtfY6w5D7v/aaDdZZrEl5BBunFVZB6XyIpe6SqVnzIAM3ceXwID5fI9twxuToMopZBtNyaiudzL5sYWV/3bSGhSe3e1sbhZ48U9KyHk1s7kOYcC1R6GincM25iKLPVlgeNHx5LFKrYB9LDf4o6vR9/QEVFqSvJnNc7JTcHYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rq4sYlR2UICh8JCHcA8eJSyGk2driLh365FkGeGWKIE=;
 b=gMDENiQ1vVm3UnTL5pBP9Awy/e+v6NRx1Y752aMit4RRxWryUvGnRDmSPhjxToV8Wi4gipWT6GSOFYfzan0x8pX35dpM9Mnt16AXk122R/qdrJqilRGWHHZPFxj2svN5AYDRGir8cu9c/8h9ismA3JC9PXcOG0M/gGpTkse4Awu4BKg7JpEPNwJ6gW7RHTHU+e6uIb0zz7Pbzn+hEewEjmZKpsV7kFagoLA1XYzoiiZXe6p5sPVWMAcXgw8UNwSqn5v+lPlxKgKIaJWoNXbce3JLd39kELRiwuqN4xJPgtqNFehf3rRiY0xryqxD9mN5EFQ3FEFR+AfSYQmQRF9yrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rq4sYlR2UICh8JCHcA8eJSyGk2driLh365FkGeGWKIE=;
 b=41Dl1IQzudxzsZcchMdPDzeDKb5hHdFiNXbUqxIYFdRDaaYJW4sUpipkt0EEQBH3jHea8maUyOMOo9rnwrTFl0H3/uh44QyFa7Hk4h+nl3BNlodt6MKNQ2MIdIc8JcUostLMXkk8nCmWQQOVkEZslmzaMRKbYiE/KxzKz1iEscE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 16:17:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Mon, 23 Oct 2023
 16:17:08 +0000
Message-ID: <08889426-e8e7-491b-bcc6-fd001bad3269@amd.com>
Date:   Mon, 23 Oct 2023 11:17:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: PIC probing code from e179f6914152 failing
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>, kys@microsoft.com,
        hpa@linux.intel.com
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
 <878r7z4kb4.ffs@tglx> <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
 <87ttqhcotn.ffs@tglx>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <87ttqhcotn.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0008.namprd11.prod.outlook.com
 (2603:10b6:806:6e::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: ae56b272-3a32-4d07-9389-08dbd3e38179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJoiywfslFq78sSAnsvia86ZRxbHSCmR/cy7KgK93WoKF5qSnTU+9XZBUGgjiZ1C5lbKM3j7WX9qI6PCuFI9FCRC1Sjr5l29Mu+Fy85EXVaMc9zmGANPBCmvXOFEw5xa7/Xq7fS2V/nMgFOr7vfd1IB4Vikrb2RGrCYKWtCFYU5Vq1TogXYODNQStehpvzYHJjbnON4qKihl4GO6BrEv4nD/nesr/ZRMvlomddCLNCJepV9pO6x9IV1DDyFd3keufz77+bKoBKWRDX5xSldquLwkePggoP8A4GAnV3cfphECvTSLtxoCcpsKu0frrbmRWDawjbfJpr6rmi6RMba+vKYR00bPnMjfkxdErH4QSlVg7tL2qrgKAMf9D2ev3OIaXXwAmhqVIY9wf7/NjDhNZnX+qOy4xM9djD6ieHVyDn9F6ENBwVTLtX5w653hIzRaCUm8o9mT7372vMsnxfdSFWCQfY7vDq6SG4yIgDKOyKZYdqIjNisr5u7CdQGCCWkWkHPkVd7eSgSYMwcAEL1W9ZslnIB+IPx8ojZrAjuN8atI+idyWLXM7bs76t4WcEHp9NUTYcVviGjTxXAYATsRYUSWQnV7Avzi91upIS0VZaEH4XWySvVkQnOcgeb7ZRbJrlxSQPVY4UzcCLIqspdXMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(83380400001)(26005)(53546011)(6512007)(6506007)(31686004)(36756003)(86362001)(31696002)(2616005)(38100700002)(6486002)(4326008)(41300700001)(8936002)(44832011)(8676002)(478600001)(5660300002)(2906002)(66946007)(66556008)(66476007)(54906003)(110136005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU9Ld3lCS05JZEZBYmE3YytRM0RRVCtDamZZSE5ocGJDMTVuVGFES2R4UlVh?=
 =?utf-8?B?L1J2SVQrQWR3ZlYvV3Uwc3FxTVliN1lMY3Z4MVhkaEp2MkFVNU5wbVNyUmlC?=
 =?utf-8?B?SEJvVVpuZTFQNFdVQ0I0UHFFRjFRVjZicWt6VTM5bTQzTkl2YW56YkhrOUUz?=
 =?utf-8?B?OVBIK3dQMTErQXdoNzFZUVBEb2pFUE5iUC9seGhyaFUwWC9MVndkR0hLeS9E?=
 =?utf-8?B?MGxJZ2p0WTI4REk4cDA1aUNaandNWHFYNDlDS1BvMFRQOVZYWEljYldqaUM3?=
 =?utf-8?B?UjdoUGxrN0pxbW9QL2JQVDArbDVETUdFTkJMOEVsc0ppVDQyTDlLZzNPYjl1?=
 =?utf-8?B?b0dVdTJUMlZ6VnVoZW05WUJFSUdUdzFIcC9yRk8rL1ZBMUlBQmdvU05yeTZE?=
 =?utf-8?B?MmpnbGhTLzdYNThEdjM0YXROd2NIb3ZUSy9Xa3BIRkFhZlJoRW5qdnhBM083?=
 =?utf-8?B?WEVzV1VJNkRuUUxFOHBXQytYdUZmT0p3Mng2ajcrcXpwV3lvTVZKN0F2Y0ow?=
 =?utf-8?B?eXVpWlQxcDRwemZpbDNUMjI0ZjZod05jMFN3dXlSQitHMURwMnR0dmNKZXM4?=
 =?utf-8?B?SzkzcUZOblVJVFNNRHVrOXdEUTN1TDB5R2dOU1JQUldYd1VLN090SXprTDR6?=
 =?utf-8?B?RkdLT3kxekVhMTRUSHg3aUJNNTlxSU9tRE5DRzJhQURtOGVMamRQbUxCdGRP?=
 =?utf-8?B?cmdMWkl3a2NVRzRweGlCQjlDazlSc1JtT29GR0lKSlJOVjI0KzFNQ2JiWUp3?=
 =?utf-8?B?ZmhKazFlcGhXajFhVEVKSWhRN1ZpRlFXTFJ2Mk11K1ExZjdVSDVwZmc4dXQx?=
 =?utf-8?B?MmlUc2QrRzBvWkt0a0xIVmp4bGFKczRoUkgvRWNHa2lSNGtpL0RETHQ3Qzc0?=
 =?utf-8?B?aFFaZWJ6ZnNZdExlSHpraElkaEtJSzBhYTg0Z1hFZy9yaDVZVHQ5U2p5WWhr?=
 =?utf-8?B?Y1BGVldJRXhjQS9mNElDUHRBWnN4S2NBNEt0NXRCSitUNFg1L2l3MFFQaWZ1?=
 =?utf-8?B?TlBUYm14TkdyWlQzN1Z4TkVMTDhWQlRzdThXQmlWWG5USzM0ZW9ndG9ZUTZJ?=
 =?utf-8?B?c2N4SUZQRWdIWDdaRTlaWXVINXZ0TDZQNGZVbnpqWVBpL0hNU085ZG5xMkwv?=
 =?utf-8?B?ZVdUZnlxTGg3OWc0R1U4R2N3MVo4eGxOR0RicmNSRnBUNWg0MzNhckJTQmN0?=
 =?utf-8?B?ZE1lYjFCZm9yVVFIMjVtUlNaVGtxTUhiUzlRd2gvZmFkTUV5ZWhibWhMSC9Q?=
 =?utf-8?B?Q2g0WnpxR1VKWmo4d0hSSFdZQnYrZytiZk9SSFlRR050SnZpOXJSL0ZWVTVX?=
 =?utf-8?B?OFRCY1VFRzJzaUdaVFFYMzcrcEkwVWtkdUZEU0xmSVFyUlJDZ1hham5lZWZh?=
 =?utf-8?B?TFhuUmdvemJMbDRMYzYwVnBFOTVaQSt6d0Z3TXFsSVZnOEVSaVNrU3J2TWpP?=
 =?utf-8?B?TTdrMGhueTN3c28yWXQ5cG9yemZ0R2NxWUM3Ym1FU1B1SmUxeEZPeVJjZ3ZZ?=
 =?utf-8?B?YlpnWkhITWgvc3RzWGp1eU9tMGZyMU9HUmFZUGFCbEczeEN5MXhYdkZCT0pz?=
 =?utf-8?B?ZFZKVHVNekNCeklPTXdBWlNnQTlzTllwVzg1ZmxtVzA3WWlkWldKZXd4ZkEw?=
 =?utf-8?B?RSt0OFBSVTd5NjhmWW9zS1Qxem9DeVVLbFFKMFBubHdUWWpCR01laFp4alA1?=
 =?utf-8?B?bUNFWEpvb2NyYkt2aUVFTG5QM1ZNRzRueFhxN211aWlkSDFOVmY4T1ZISUJl?=
 =?utf-8?B?YXB1RDZsZ083QXRscDd6YU52OXlDN1N1Wnp6dFI4bzIwSVJGS3A4dnRoN3ZR?=
 =?utf-8?B?M1lUWldYYkprNG1jQXF1b0F5dXBPdXM4bDFKY3U4SnBrbUZEMlZ5dHl3TWo0?=
 =?utf-8?B?d05MaDhQdTMyTUFmamJibXJCbm1tdTV1RDVlNGFEd1NBVWE1ZGlmTGxZTTYr?=
 =?utf-8?B?YTlBUm8wY1pFTzRrQzJjVklNS2gwdE1Bb0RDY0V5dk5Wek95TWYxK2ZFQjZl?=
 =?utf-8?B?SitabUlzb0gyWUE5cnJ4M0tESnNsLzVIa292TGZlc1ZCVG1Kd2tCQUtrM0dz?=
 =?utf-8?B?V1ZicndRbVAxZGwwZHpjUG5FbksycXR1WEpvZmdCMm14VUVvcE54bjV0WEFT?=
 =?utf-8?Q?la7nzRW/Dq87shOwHsKUJFuv8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae56b272-3a32-4d07-9389-08dbd3e38179
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 16:17:08.7906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWvfFBtg83o9M4jpO5tDdEtnOzYdhVXba02hDPiOX0rtwlY0AawrGOBg/0WFhFdMuBkr0mmhcYyKJxQaL8/tzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2023 10:59, Thomas Gleixner wrote:
> On Thu, Oct 19 2023 at 16:20, Mario Limonciello wrote:
>> On 10/18/2023 17:50, Thomas Gleixner wrote:
>>> The only interrupt which does not work is interrupt 0 because nothing
>>> allocates interrupt 0 due to nr_legacy_irqs == 0, but that's a trivially
>>> solvable problem.
>>
>>   From David's logs I can see that the timer interrupt gets wired up to
>> IRQ2 instead of IRQ0.
> 
> Sure, but that's not really a problem. Nothing needs the timer
> interrupt in principle.
> 
>> IOAPIC[0]: Preconfigured routing entry (33-2 -> IRQ 2 Level:0 ActiveLow:0)
>>
>> In my hacked up forcing NULL pic case this fixes that:
>>
>> diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
>> index 43c1c24e934b..885687e64e4e 100644
>> --- a/arch/x86/kernel/i8259.c
>> +++ b/arch/x86/kernel/i8259.c
>> @@ -424,7 +424,7 @@ static int legacy_pic_probe(void)
>>    }
>>
>>    struct legacy_pic null_legacy_pic = {
>> -       .nr_legacy_irqs = 0,
>> +       .nr_legacy_irqs = 1,
>>           .chip = &dummy_irq_chip,
>>           .mask = legacy_pic_uint_noop,
>>           .unmask = legacy_pic_uint_noop,
>>
>> I think it's cleaner than changing all the places that use
>> nr_legacy_irqs().
> 
> No. It's not cleaner. It's a hack and you still need to audit all places
> which depend on nr_legacy_irqs(). Also why '1'? You could as well use
> '16', no? >
>> On my side this makes:
>>
>> IOAPIC[0]: Preconfigured routing entry (33-2 -> IRQ 0 Level:0
>> ActiveLow:0)
> 
> Sure, but that can be achieved by other means in a clean way as
> well. Can we please focus on analyzing the underlying problems instead
> of trying random hacks? The timer part is well understood already.
> 
>>> That machine does not even need the timer interrupt because it has a
>>> usable APIC and TSC deadline timer, so no APIC timer calibration
>>> required. The same is true for CPUs which do not have a TSC deadline
>>> timer, but enumerate the APIC frequency via CPUID or MSRs.
>>
>> Don't you need it for things like rtcwake to be able to work?
> 
> Timer != RTC.
> 
> The RTC interrupt is separate (IRQ 8), but in the case of this system it
> is using the HPET-RTC emulation which fails to initialize because
> interrupt 0 is not available.

That's exactly why I allocated 1 IRQ for IRQ 0.

> 
>>> But that brings up an interesting question. How are those affected
>>> machines even reaching a state where the user notices that just the
>>> keyboard and the GPIO are not working? Why?
>>
>> So the GPIO controller driver (pinctrl-amd) uses platform_get_irq() to
>> try to discover the IRQ to use.
>>
>> This calls acpi_irq_get() which isn't implemented on x86 (hardcodes
>> -EINVAL).
>>
>> I can "work around it" by:
>>
>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> index 76bfcba25003..2b4b436c65d8 100644
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -187,7 +187,8 @@ int platform_get_irq_optional(struct platform_device
>> *dev, unsigned int num)
>>           }
>>
>>           r = platform_get_resource(dev, IORESOURCE_IRQ, num);
>> -       if (has_acpi_companion(&dev->dev)) {
>> +       if (IS_ENABLED(CONFIG_ACPI_GENERIC_GSI) &&
>> +            has_acpi_companion(&dev->dev)) {
>>                   if (r && r->flags & IORESOURCE_DISABLED) {
>>                           ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
>>                           if (ret)
> 
> So why is acpi_irq_get() reached when the PIC is disabled, but not when
> the PIC is enabled? Because of the below:
> 
>> but the resource that is returned from the next hunk ?
> 
> next hunk? The resource is returned by platform_get_resource() above, no?
> 
>> has the resource flags set wrong in the NULL pic case:
>>
>> NULL case:
>> r: AMDI0030:00 flags: 0x30000418
>> PIC case:
>> r: AMDI0030:00 flags: 0x418
>>
>> IOW NULL pic case has IORESOURCE_DISABLED / IORESOURCE_UNSET
> 
> So the real question is WHY are the DISABLED/UNSET flags not set in the
> PIC case?
> 
>> NULL case:
>> handler:  handle_edge_irq
>> dstate:   0x3740c208
>>               IRQ_TYPE_LEVEL_LOW
>>
>> PIC case:
>> handler:  handle_fasteoi_irq
>> dstate:   0x3740e208
>>               IRQ_TYPE_LEVEL_LOW
>>               IRQD_LEVEL
>>
>> I guess something related to the callpath for mp_register_handler().
> 
> Guessing is not helpful.
> 
> There is a difference in how the allocation info is set up when legacy
> PIC is enabled, but that does not explain the above resource flag
> difference.

I did a pile of printks and that's how I realized it's because of the 
missing call to mp_register_handler() which is dependent upon what 
appeared to me to be a superfluous number of legacy IRQs check (patch 1 
in my solution).

> 
> As there is no override for IRQ7:
> 
> [    0.011415] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.011417] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 20, APIC INT 02
> [    0.011418] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [    0.011419] Int: type 0, pol 3, trig 3, bus 00, IRQ 09, APIC ID 20, APIC INT 09
> ...
> [    0.011425] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 20, APIC INT 07
> 
> the initial setup of the IOAPIC interrupt is edge, while the initial
> setup of the legacy PIC is level. But that gets changed later to edge
> when the IOAPIC is initialized.
> 
> I'm not seeing the magic which make the above different yet, though I'm
> 100% sure by now that this "works" definitely not by design. It just
> works by pure luck.
> 
> Now when platform_get_irq_optional() sets the trigger type via
> irqd_set_trigger_type() it just sets LEVEL_LOW, but does not change the
> handler and does not set IRQD_LEVEL. It does neither change the IO/APIC
> pin setup. This happens because the IOAPIC interrupt chip does not
> implement an irq_set_type() callback.
> 
> IOW the whole machinery depends on magic setup ordering vs. PIC and pure
> luck. Adding the callback is not rocket science, but while it should
> make the interrupt work it still does not explain the magic "working"
> when the legacy PIC is enabled.
> 
> Let me sit down and add a pile of debug printks to all the relevant
> places as we really need to understand the underlying magic effects of
> legacy PIC first.
> 

OK let's see if you come up with different conclusions.
