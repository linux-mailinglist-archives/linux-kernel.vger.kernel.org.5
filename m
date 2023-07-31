Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10696769ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjGaPdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjGaPc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:32:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CA8130;
        Mon, 31 Jul 2023 08:32:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 779EC21D89;
        Mon, 31 Jul 2023 15:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690817570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2FbcQ8yFfgUJFefrrMdKUgNR2DCiMc4lJKw7kMkuHo4=;
        b=Fl7kPpTgfDgeXnVU4h+yHv3cdMKZ+UYT+MOJsEh4DUAqhp/Z/CiniBVHmsInWPlwSz4kEy
        Uty6+dq+diketKgqXLVRdnNJagHMM/treIQEx0PqDXYozZDnuuaICoS01bo+3gP7Bx0Q4S
        MXOz/bQ0DTbVVTP2Wmrcyb3UHpl8VvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690817570;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2FbcQ8yFfgUJFefrrMdKUgNR2DCiMc4lJKw7kMkuHo4=;
        b=VzaWJ7/r9SZgvsJK4+5Iyk0RYRjJvV9fSQ/HRKfC4U3THia5co5KjbpIvj+/ZWiPy+tCq9
        mY+FEvkQJBW8+ACA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02513133F7;
        Mon, 31 Jul 2023 15:32:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y2kIOiHUx2RgeAAAMHmgww
        (envelope-from <svarbanov@suse.de>); Mon, 31 Jul 2023 15:32:49 +0000
Message-ID: <088fcc47-e5a3-c1a4-88cf-8f3c2bfdd130@suse.de>
Date:   Mon, 31 Jul 2023 18:32:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH] iommu: arm-smmu-nvidia: Add default domain type
 implementation op
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Stanimir Varbanov <svarbanov@suse.de>, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Krishna Reddy <vdumpa@nvidia.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20230710082252.9702-1-svarbanov@suse.de> <ZKvgG4-IzqiYPSUT@orome>
 <93026b47-3b72-8439-486e-e0cda21dd0fe@suse.com> <ZK17X4ueSI5rWKVL@orome>
From:   Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <ZK17X4ueSI5rWKVL@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On 7/11/23 18:55, Thierry Reding wrote:
> On Tue, Jul 11, 2023 at 01:58:34PM +0300, Stanimir Varbanov wrote:
>> Hi Thierry,
>>
>> Thank you for the comments!
>>
>> On 7/10/23 13:40, Thierry Reding wrote:
>>> On Mon, Jul 10, 2023 at 11:22:52AM +0300, Stanimir Varbanov wrote:
>>>> Add def_domain_type implementation op and override default IOMMU
>>>> domain Kconfig option (CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y), which
>>>> could be enabled on some distros. The current quirk has been done
>>>> for Tegra234 machine, because I found the issue on it. The issue
>>>> itself appears on USB host controller which cannot be initialized
>>>> without IOMMU translation. Something more, we proved that IOMMU
>>>> translation is needed for display and GPU drivers as well.
>>>>
>>>> I evaluated few possible options to solve that:
>>>>
>>>>  a) select default IOMMU domain from .def_domain_type op
>>>>  b) Unset CONFIG_IOMMU_DEFAULT_PASSTHROUGH=n
>>>>  c) add iommu.passthrough=0 on the kernel cmdline
>>>>  d) firmware - ACPI / DT
>>>>
>>>> a) This option is implemented in the proposed patch.
>>>>
>>>> b) Since that the community has agreed that pass-through is preferred
>>>> as a default IOMMU domain option because this will avoid performance
>>>> impacts on some of the platforms [1]. On the other side we have examples
>>>> where you cannot even install Linux distribution on a machine where the
>>>> storage media cannot be detected and the system just hangs.
>>>
>>> That's not how I read that thread. It sounds more to me like Will and
>>> Robin had ideas on how to improve the performance and were planning to
>>> address these issues. It doesn't exactly sound to me like there was
>>> concensus to make passthrough the default.
>>>
>>> Having said that, given that it's possible for distributions and users
>>> to set CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y, I think it would be useful in
>>> general to have a way of enforcing IOMMU translations if it's needed by
>>> the hardware.
>>
>> Exactly, the problem is that some platforms prefer passthrough to avoid
>> performance impacts but others cannot even boot the kernel (and thus
>> installation failure). Passing iommu.passthrough=0 should be an
>> administrator decision, balancing between security and performance.
>>
>> On the other hand the aforementioned mail thread gave some performance
>> numbers which might be are outdated having the improvements made in smmu
>> driver in mind. Unfortunately, I cannot confirm that the performance has
>> been improved during that time.
>>
>>>
>>> I'm not sure I fully understand the particular problems that you're
>>> seeing on Tegra234, though. I'm not aware of anything in the USB host
>>> controller driver (or hardware, for that matter) that would require the
>>> IOMMU to be enabled. The only peculiarity that I can think of is the
>>> firmware, which is typically loaded by an early bootloader and therefore
>>> might perhaps need the IOMMU to properly map this in the kernel.
>>> However, my understanding is that this firmware is loaded into special
>>> carveout regions which don't require remapping.
>>
>> On Jetson Orin AGX (R35.2.1) I see these errors:
>>
>> tegra-mc 2c00000.memory-controller: unknown: write @0x0000000000000080:
>> EMEM address decode error (EMEM decode error)
>>
>> tegra-xusb 3610000.usb: Error while assigning device slot ID
>> tegra-xusb 3610000.usb: Max number of devices this xHCI host supports is 36.
>> usb usb2-port3: couldn't allocate usb_device
>> tegra-mc 2c00000.memory-controller: unknown: write @0x0000000000000090:
>> EMEM address decode error (EMEM decode error)
>> tegra-xusb 3610000.usb: Error while assigning device slot ID
>> tegra-xusb 3610000.usb: Max number of devices this xHCI host supports is 36.
>> usb usb1-port3: couldn't allocate usb_device
>>
>> tegra-mc 2c00000.memory-controller: unknown: write @0x00000000000000a0:
>> EMEM address decode error (EMEM decode error)
>> tegra-xusb 3610000.usb: Error while assigning device slot ID
>> tegra-xusb 3610000.usb: Max number of devices this xHCI host supports is 36.
>> usb usb1-port4: couldn't allocate usb_device
>>
>>>
>>> However, passthrough is admittedly not something that we've thoroughly
>>> tested, so it's possible you're running into a use-case that I'm not
>>> aware of. In that case, could you provide a few more specifics (such as
>>> the DTB and .config) of your build configuration so that I can try and
>>> reproduce?
>>
>> To reproduce you have to add iommu.passthrough=1 on kernel cmdline. The
>> dtb is from Jetpack.
> 
> I was able to reproduce this on Jetson Orin NX (the differences to AGX
> Orin should be negligible in this context), though I ended up patching
> the DTB to disable all SMMUs. What fixed it for me was to drop the
> dma-coherent property from the usb@3610000 node. Can you try that on
> your end to see if that works for you as well?
> 

I can confirm that deleting dma-coherent property from usb@3610000 DT
node fixes the issue with USB host controller for me.

~Stan
