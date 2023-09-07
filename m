Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8A679735E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbjIGPXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjIGPWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:22:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B68561BF6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:21:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0349D75;
        Thu,  7 Sep 2023 05:22:52 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F2AD3F7B4;
        Thu,  7 Sep 2023 05:22:13 -0700 (PDT)
Message-ID: <15d1dd8f-a002-8b98-55ba-632427e621cf@arm.com>
Date:   Thu, 7 Sep 2023 13:22:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: snd-cmipci oops during probe on arm64 (current mainline,
 pre-6.6-rc1)
Content-Language: en-GB
To:     Antonio Terceiro <antonio.terceiro@linaro.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <ZPelHaX/Lt++kkOm@linaro.org> <877cp3esse.wl-tiwai@suse.de>
 <4f335dd2-8043-c60e-cf84-c2b01c4fee12@arm.com> <ZPjGuCdmPgqznc5t@linaro.org>
 <43632d9d-722c-b14f-336a-eac402ef9362@arm.com> <ZPkcIayHbYJopT6n@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZPkcIayHbYJopT6n@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2023 1:41 am, Antonio Terceiro wrote:
> On Wed, Sep 06, 2023 at 08:52:40PM +0100, Robin Murphy wrote:
>> On 2023-09-06 19:36, Antonio Terceiro wrote:
>>> I'm pretty sure I saw reports of people using PCI GPUs on this machine,
>>> but I would need to confirm.
>>
>> GPUs and any other PCIe devices will be fine, since they will use memory
>> BARs - I/O space is pretty much deprecated in PCIe, and as mentioned some
>> systems don't even support it at all. I found a datasheet for CMI8738, and
>> they seem to be right at the other end of the scale as legacy PCI chips with
>> *only* an I/O BAR (and so I guess your card includes a PCIe-PCI bridge as
>> well), so are definitely going to be hitting paths that are less
>> well-exercised on arm64 in general.
> 
> OK, that makes sense. So If I'm able to find a card that is genuinely
> PCIe¹, then it should work?
> 
> ¹ this one has a connector that looks like a PCIe x1, but it's not
>    really PCIe as the chipset was designed for legacy PCI?

Probably - native PCIe endpoints are still allowed to have I/O 
resources, but they are required to be accessible as equivalent memory 
resources as well, so most PCIe drivers are unlikely to care about I/O 
BARs at all.

>>> What info would I need to gather from the machine in order to figure
>>> this out?
>>
>> The first thing I'd try is rebuilding the kernel with CONFIG_INDIRECT_PIO
>> disabled and see what difference that makes. I'm not too familiar with that
>> area of the code, so the finer details of how to debug broken I/O space
>> beyond that would be more of a linux-pci question.
> 
> Tried that, didn't help.

OK, I managed to have a poke around on a full-fat Altra Mt.Jade system, 
and indeed, at least on this one, the firmware is not describing any I/O 
space windows at all:

[    8.657752] pci_bus 0001:00: root bus resource [bus 00-ff]
[    8.663235] pci_bus 0001:00: root bus resource [mem 
0x30000000-0x37ffffff window]
[    8.670715] pci_bus 0001:00: root bus resource [mem 
0x380000000000-0x3bffdfffffff window]
[    8.678926] pci 0001:00:00.0: [1def:e100] type 00 class 0x060000

[and so on for all 11(!) PCI segments...]

...which then leads to a lot of failing to configure I/O at the bridges:

[    9.005653] pci 0000:00:01.0: BAR 13: no space for [io  size 0x1000]
[    9.012006] pci 0000:00:01.0: BAR 13: failed to assign [io  size 0x1000]

...but unfortunately what I don't then have is any endpoint with an I/O 
BAR in that machine to see how that plays out. Either way, though, if 
your machine looks the same as this (i.e. does not report any "root bus 
resource [io ... window]" entries and fails to assign any I/O space), 
then there's no way that card can work, and it would seem to indicate a 
bug somewhere between the PCI layer and the driver that it's able to get 
as far as making an access to something it has no means of accessing.

If on the other hand your firmware is different and *does* claim to have 
I/O windows as well, then something else is going screwy and I don't 
know, sorry.

Cheers,
Robin.
