Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5B67D039F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346562AbjJSVU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjJSVU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:20:26 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D457F114
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltjLDhKCAOcGHduQj87myF+tzKgKWi2dMeMYJy2MGEklcY2KI+TTz85OqWk+NIUzA6LszWQPwYF2EEpwfCySiB492s1vrXlhgsOsk65/omFDD2JhgfWoDAl6FRFCxrBndBIPCLAaa7MfZ068pYJjrcZ2hxGTMPahdXczZlAuQnKeYnNa8Jn3LAH7RVnoQicFhWoMYvUQdUgOl+XkJH6w6m3CWMKDnrtBIfo9hTql2R+oMC3SIfGwJv/dyPlbjMtN+IbjhTWHiU4BOVDyD+7pbMzWmGyWFjULvLGHvIt3IdqDvnmnnTWZ9PlDwKLcDYtBjHBdvM7BGNtZOpiloj3vrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dD2/OWiDeZHL5kx0IlrlYRFFyJn3hCT7dQKQH3QOOuQ=;
 b=eHVr2hoRufJhY3EEIR1icgkPJW+16DTI1rRNeuag5cdkvvrSOWWy59gVmq9GwT61vHZGLzAExeBP6p+GoVHRA+Gz4mrOb4Lx9OYnqCBsifXZ520NmtWZpWYG7JPxftyLOCtFL3v2qWci8eiMWtb1EzfHaOvTymt1HdyhrA2SNax3uISdDzfCSWnhqh8/gaAdAn/dU+i9j9PAp0v3+smKVKAhHWSfjkaXaI8ji0nbsf/RFLKiqjUIs9iRwm1ikf1g/cZ5cbh8EuydtoQSAbG0lVdtXLVyWfy4dzStFREu2Rmsee5DmNaS3tfeFqnc6yBSoXcHaUANAazNdUVj5i3pnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dD2/OWiDeZHL5kx0IlrlYRFFyJn3hCT7dQKQH3QOOuQ=;
 b=lEQBvxVCF9wSmZMS50jvWI0fbacNXf4go5dLIHgPjJISMg5SodhZ6/B5G7XbtRhxsPfdWgbzsdRU8Ul8VQrDq3ctILKSVE9d8vrhEl7zBhW1Jpo1yhBoqjbOM6T6xhrsszzKv9EC9q0V5lA3WMmLoG7WILjNwU+RvUSY9+88gRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 19 Oct
 2023 21:20:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 21:20:20 +0000
Message-ID: <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
Date:   Thu, 19 Oct 2023 16:20:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: PIC probing code from e179f6914152 failing
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>, kys@microsoft.com,
        hpa@linux.intel.com
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
 <878r7z4kb4.ffs@tglx>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <878r7z4kb4.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0027.prod.exchangelabs.com (2603:10b6:805:b6::40)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e985a63-4988-41c3-af77-08dbd0e932af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UEnpJ7dZms7pH3FWTigbnydCEBLW15OAacZYZVsryBDwf9rFOulFmW1W6/A3MVVByxM+GmSi+asqfw6QudmDMEGe/YfbE2EBmvvmSie8blb5WiVq5+Fy4Ri2MDXIOuKbW6mtt0Oy49Tq2oYp/wWkpYocz8w4DzKyVuQgOM0Z6vZkeE3Fe2k2uWuHp/Ll/oOEcl5VF9HzuO/RiRIJsh43E/BAhul9qIl9CHLARLSZKR5SL9uwT1ZsKuBxTEVI5vnnRIvUVRK4Yb+3hBLM+PXe/ifkRLlaJwX89kZ6EvFXpd9HDZW/IFO223E0WFXdXORRBiAVnJg4b+BoN+d8JSZpnt6BKAxmiKM+OQT4RKBexLiVIX47HiHzd4sOdm1ZkXEOTM2EMu/C+TdPiYalhaHLxd44/AIlJef6YQgXJEJ5CtVdXIg3q9Tinjaqoqct/C8gP6wuepcP21Rkj98OnfaluoF/HYbcnYNMUpSjJHxB/CAYtjTi/Ey5T152xKdwBwk6pplJhJPHrxVSYRamfgLOftTNioupxT17ZHkLlmXP4pKCb6MGXJUkgCIFHr+cbCGDtR4b1ppfRtHFZLT5Lbd2n+8IbKY16cR4x6BqInvwRfccXjUsn/glGVJa73M0LMqg53fmfg/uVrcBoONPJITNaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(4326008)(8676002)(38100700002)(5660300002)(44832011)(41300700001)(8936002)(316002)(110136005)(83380400001)(54906003)(86362001)(66556008)(31696002)(2906002)(66946007)(36756003)(66476007)(31686004)(478600001)(6666004)(6512007)(6486002)(6506007)(53546011)(2616005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHZ0V2htaDBsUDh5VkNIalV2VHZBa1FaUjNoR1JlS0gxS3NYMzRJak8rOFpX?=
 =?utf-8?B?bTNKYlFSU3ZqWkgvWEZkVjNhOFh3S29YMk44MVRzMmRpTkN2RUhLeVU0QkJE?=
 =?utf-8?B?UXdSR1FTSkkyVVNWVzZTZXlacTlsQ0tSRVdXWjRSR2l2UkN2TmpWcTVQRERI?=
 =?utf-8?B?Yzh4NXhkM09EdVFVL1RjYWNwbFVmTDBBdGhodTJLUU0rV092RGNnMGt2VUx1?=
 =?utf-8?B?UUlsNS9QcEdhZUJBNDgrYWlzcUhNNmhzOFk4dkljV1V3eVhxdzFXK0tHNFlh?=
 =?utf-8?B?TTcrdVpYeGkzWWl5QzFZM1FZa0VXYmNLZWpCdDY0QWVTS2hoUHBLL2hJWnlm?=
 =?utf-8?B?bFdZdTZ3NDlzNFlocWlmTk40YjFvUlorTmJMSXpseTVOd1JpVUhPazhreDhC?=
 =?utf-8?B?NDR5ZHhXbTBmcUk4U2FhdkdWYk9iQm10UlQxUXRtR1c0TXVXSUMyQVNiUER6?=
 =?utf-8?B?Y1RKQWpOSFFGRGlRdVlWZ1hnVVhTQWY4SjMrei9BS0llbE9hUi9jWTJuUGxL?=
 =?utf-8?B?b25zejFBSmVWNnY2dlFadVo2UkMvYjBsV20xY05KWjI3bnNNalVvbllHaXQ5?=
 =?utf-8?B?WitGSitsb0Fud3RtOGpvVUxJY3JqZ3Y1TkU5dEM5d1lTT0ttSE14YTViMFg4?=
 =?utf-8?B?Z2lpem90U0tLdzBKYXlYOWxFYmRQQzlFdGNubElFa2JqYUwyRzF4V25wRmd4?=
 =?utf-8?B?aDhXY05WaGVYYndrcU1GUGhiOTVzeFBsMU1DWDJqRm9RTXdjaEU0R1llUjlG?=
 =?utf-8?B?QXdaWWlKK0d2V21IcU5CYlU3WGpxL095RUhwRXl1ZkRaZHJqcDIweXN6RXZF?=
 =?utf-8?B?QVlaTkMrQUUweEd4bmtYT3l6VkttdEtaZnczbmcvQVd2aTBkOFBKUU9ibDd2?=
 =?utf-8?B?M3c3a1VsaHh6ZmU5RG5hK1pVV2pSZU40d1ptaU1pdGhnTlViU3NieHVzbXhZ?=
 =?utf-8?B?VmEyZ2FXVmdLSFlaeXVORE1JSHR4WHNXTVVSTVltZzRhYVhMY0JKTTIvMSt1?=
 =?utf-8?B?b0RPa2RNenpqYk4rdXg0NGN1TGVGWFlKSng5NC9BenZnQjNUMlJVaWF2TEty?=
 =?utf-8?B?YkZSTVIxUzQ2cW4wMTJockZDTEtFYWd2anNJVXRtZ2tEZ0hLYjEzWGo2LzZG?=
 =?utf-8?B?VUt3bDFyaFdsc3JwT1VncjJ2ZnRmNy9OS3YrSFduQ0U0bFcyOHlPdlhoRmlo?=
 =?utf-8?B?U1hoeFp2dWNySUhIUVZISkpnQXo3dmYrdHg1clBWYVRJWVhhYTNnOW9PbFpT?=
 =?utf-8?B?TjdUV3BRMkllVFhNanFmdzhaUGRzM2laQU0wZ1MySkdNL2I5OTlKRDJaWnBU?=
 =?utf-8?B?cFdXOFBRcm83WFVTM2lwUDNwaG8yK2pRV2p2N2ladEhxY0ZsZ3oxV1hXcG1o?=
 =?utf-8?B?MncxTk1qRm5zL0hLQkN4NGIrVmJMMlUyNWtFaG9MYUhBTmFOa0c4aFJ5cGJk?=
 =?utf-8?B?WituMTZWYkgrV251eHJzcDh2MVBMeG5EQi82aGYvUEptOUMzb3llSTVzNUVv?=
 =?utf-8?B?WENNZmF5d0pXdjMzOVJ3RUkxam4xR2tBdlo1ZXI2a1lhd1NaYkhaaEdnWHVn?=
 =?utf-8?B?K01Gc3cxVkNMdzNKZWlkZ2R5YnFYaTYrTXRaSXNjMVFKRUlGVGxKUzVMR0gx?=
 =?utf-8?B?VkdCb2UzWGc3Qjg2REx0OWxhR2lZTFpGTmZ1ZU5oVnVteUlrdFVIckVuWXNP?=
 =?utf-8?B?UG42UTlxTzVpaDRzQ0FiYnk2UWtnY1lhSEZLcXpFYnZwaUp6UGJtTHdlMitJ?=
 =?utf-8?B?NmhGcjlZK3A3cW9SaXg4Rlo2TTVlWGhqV3Jwbk9GTjl5WWMxNW9BY0IrcXgw?=
 =?utf-8?B?S1Z4d2tOU3kzK3BWK0dULy9NOE50YmpYZ3A3R2oxSVJyUVluNjB6akJQQy9G?=
 =?utf-8?B?SHpZZHJMTWVGcndaLzBtTndqRmczeVUrbWJ3Qm5nbGtqYWZmamNGWjBoSXVz?=
 =?utf-8?B?aEkvYTJ3WXo5b0R6c1NUMExDS3d1eC9MaVNOVkRsK09KL2VTQ0pqZ2tzL09r?=
 =?utf-8?B?NUNaWUJsN21TYkRBTDVIdlB0cW00cTdsejR0TWR4cEVLWCtTWjNHUU9zSzlt?=
 =?utf-8?B?QzRYVnNWVDRpUzdPWEtvdE8zRUpCWDJMSW52aW92by8xOXg0NXhyZ0p6bnZR?=
 =?utf-8?Q?sWlAgq05Kr4Ro/1MZMNoySvH7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e985a63-4988-41c3-af77-08dbd0e932af
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 21:20:20.6574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Lx+3wbLw0rH0D0NixbPdvEId3xnmnFWEoOJTNx/TYg+vLfR1B5+bI3gTeaKM+9NluhRndLBcn542PqaJoPLFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/2023 17:50, Thomas Gleixner wrote:
> On Wed, Oct 18 2023 at 13:50, Mario Limonciello wrote:
>> Recently an issue was reported to Bugzilla [1] that the Keyboard (IRQ 1)
>> and GPIO controller (IRQ 7) weren't working properly on two separate
>> Lenovo machines.  The issues are unique to Linux.
>>
>> In digging through them, they happen because Lenovo didn't set up the
>> PIC in the BIOS.
>> Specifically the PIC probing code introduced by e179f6914152 ("x86, irq,
>> pic: Probe for legacy PIC and set legacy_pic appropriately") expects
>> that the BIOS sets up the PIC and uses that assertion to let Linux set
>> it up.
>>
>> One of the reporters confirmed that reverting e179f6914152 fixes the
>> issue.  Keyboard and GPIO controller both work properly.
>>
>> I wanted to ask if we can please revert that and come up with a
>> different solution for kexec with HyperV.
>> Can guests instead perhaps detect in early boot code they're running in
>> an EFI based hypervisor and explicitly set 'legacy_pic = &null_legacy_pic;'?
> 
> No. This detection mechanism prevents PIC usage also in other
> scenarios.
> 
> It's perfectly valid code and the assumption that you can read back what
> you wrote to the master IMR is entirely correct. If that's not the case
> then there is no PIC, the BIOS has disabled some parts of the legacy
> block or did not initialize it.
> 
> Letting the kernel blindly assume that there is always a PIC is just
> wrong. Worse, it puts the burden on everyone else to sprinkle
> "legacy_pic = null_pic;" all over the place with dubious
> conditions. That's exactly what the commit in question avoided.
> 
> So no, we are not going back there.
> 
> We could obviously change the probe() function to issue a full PIC
> initialization sequence before reading a known written value
> back. That's basically what the revert causes to happen via
> legacy_pic->init().
> 
> But I fundamentally hate to do that because forcing the init sequence
> just to make presumably broken code which has some dubious dependencies
> on the PIC or on nr_legacy_irqs > 0 happy is not really a solution when
> the PIC is actually not needed at all. For anything modern where all
> legacy interrupts are routed to the IO/APIC the PIC does not make any
> sense whatsoever.
> 
> We rather go and fix the real underlying problem.

Looking at the logs from David and also trying to mock up the failure on 
my side I have a few findings I'll share, please agree or disagree with 
them.

> 
> The kernel can handle the legacy interrupts perfectly fine through the
> IOAPIC. There is no hard requirement for the PIC at all except for
> really old systems which had the timer interrupt wired to the PIC and
> therefore required to route the timer interrupt through the PIC instead
> of the IO/APIC or did not provide routing entries for the IO/APIC. See
> the horrible hackery in check_timer() and the grossly misnomed
> init_IO_APIC_traps().
> 
> I just took a random machine, forced the NULL PIC and added
> 'apic=verbose' to the kernel command line and magically all the legacy
> interrupts are set up via IO/APIC despite the NULL PIC and therefore 0
> preallocated legacy interrupts.
> 
>    apic 0 pin 0 not connected
>   IOAPIC[0]: Preconfigured routing entry (0-1 -> IRQ 1 Level:0 ActiveLow:0)
>   IOAPIC[0]: Preconfigured routing entry (0-2 -> IRQ 2 Level:0 ActiveLow:0)
>   IOAPIC[0]: Preconfigured routing entry (0-3 -> IRQ 3 Level:0 ActiveLow:0)
>   ...
> 
> which is identical to the output with PIC enabled. That debug message is
> emitted from mp_irqdomain_alloc() which is invoked via the PNP resource
> management code.
> 
> Now /proc/interrupts:
> 
>             CPU0       CPU1       CPU2       CPU3
>    1:          0         56          0          0    IO-APIC   1-edge      i8042
>    4:        442          0          0          0    IO-APIC   4-edge      ttyS0
>    8:          0          0          0          0    IO-APIC   8-edge      rtc0
>    9:          0          0          0          0    IO-APIC   9-fasteoi   acpi
>   12:          0          0        122          0    IO-APIC  12-edge      i8042
> 
> Keyboard and serial are working, see?
> 
> The only interrupt which does not work is interrupt 0 because nothing
> allocates interrupt 0 due to nr_legacy_irqs == 0, but that's a trivially
> solvable problem.

 From David's logs I can see that the timer interrupt gets wired up to 
IRQ2 instead of IRQ0.

IOAPIC[0]: Preconfigured routing entry (33-2 -> IRQ 2 Level:0 ActiveLow:0)

In my hacked up forcing NULL pic case this fixes that:

diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 43c1c24e934b..885687e64e4e 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -424,7 +424,7 @@ static int legacy_pic_probe(void)
  }

  struct legacy_pic null_legacy_pic = {
-       .nr_legacy_irqs = 0,
+       .nr_legacy_irqs = 1,
         .chip = &dummy_irq_chip,
         .mask = legacy_pic_uint_noop,
         .unmask = legacy_pic_uint_noop,

I think it's cleaner than changing all the places that use 
nr_legacy_irqs().  On my side this makes:

IOAPIC[0]: Preconfigured routing entry (33-2 -> IRQ 0 Level:0 ActiveLow:0)

> 
> That machine does not even need the timer interrupt because it has a
> usable APIC and TSC deadline timer, so no APIC timer calibration
> required. The same is true for CPUs which do not have a TSC deadline
> timer, but enumerate the APIC frequency via CPUID or MSRs.

Don't you need it for things like rtcwake to be able to work?

> 
> But that brings up an interesting question. How are those affected
> machines even reaching a state where the user notices that just the
> keyboard and the GPIO are not working? Why?

So the GPIO controller driver (pinctrl-amd) uses platform_get_irq() to 
try to discover the IRQ to use.

This calls acpi_irq_get() which isn't implemented on x86 (hardcodes 
-EINVAL).

I can "work around it" by:

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 76bfcba25003..2b4b436c65d8 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -187,7 +187,8 @@ int platform_get_irq_optional(struct platform_device 
*dev, unsigned int num)
         }

         r = platform_get_resource(dev, IORESOURCE_IRQ, num);
-       if (has_acpi_companion(&dev->dev)) {
+       if (IS_ENABLED(CONFIG_ACPI_GENERIC_GSI) &&
+            has_acpi_companion(&dev->dev)) {
                 if (r && r->flags & IORESOURCE_DISABLED) {
                         ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
                         if (ret)

but the resource that is returned from the next hunk has the resource 
flags set wrong in the NULL pic case:

NULL case:
r: AMDI0030:00 flags: 0x30000418
PIC case:
r: AMDI0030:00 flags: 0x418

IOW NULL pic case has IORESOURCE_DISABLED / IORESOURCE_UNSET

This then later the GPIO controller interrupts are not actually working.
For example the attn pin for my I2C touchpad doesn't work.

Checking the debugfs with my "work around" in place I can see a few 
things set up differently:

NULL case:
handler:  handle_edge_irq
dstate:   0x3740c208
             IRQ_TYPE_LEVEL_LOW
             IRQD_ACTIVATED
             IRQD_IRQ_STARTED
             IRQD_SINGLE_TARGET
             IRQD_MOVE_PCNTXT
             IRQD_AFFINITY_ON_ACTIVATE
             IRQD_CAN_RESERVE
             IRQD_WAKEUP_STATE
             IRQD_DEFAULT_TRIGGER_SET
             IRQD_HANDLE_ENFORCE_IRQCTX

PIC case:
handler:  handle_fasteoi_irq
dstate:   0x3740e208
             IRQ_TYPE_LEVEL_LOW
             IRQD_LEVEL
             IRQD_ACTIVATED
             IRQD_IRQ_STARTED
             IRQD_SINGLE_TARGET
             IRQD_MOVE_PCNTXT
             IRQD_AFFINITY_ON_ACTIVATE
             IRQD_CAN_RESERVE
             IRQD_WAKEUP_STATE
             IRQD_DEFAULT_TRIGGER_SET
             IRQD_HANDLE_ENFORCE_IRQCTX

I guess something related to the callpath for mp_register_handler().

Maybe this is the same reason for the keyboard not working right.

> 
> The CPUID/MSR APIC frequency enumeration is Intel specific and
> everything else depends on a working timer interrupt to calibrate the
> APIC timer frequency. So AMD CPUs require the timer interrupt to
> work. The only explanation why this "works" in that null PIC case is
> that the PIT/HPET interrupt is actually wired to pin 0, but that's
> something to be determined...
> 
> Can I please get the following information from an affected machine:
> 
>    1) dmesg with 'apic=verbose' on the command line
>    2) /proc/interrupts
>    3) /sys/kernel/debug/irq/irqs/{0..15}
> 
>    #3 requires CONFIG_GENERIC_IRQ_DEBUGFS to be set.
> 
> Two versions of that please:
> 
>    1) Unpatched kernel
>    2) Patched kernel
> 
> Thanks,
> 
>          tglx

