Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDCE780FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378422AbjHRQGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344992AbjHRQGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:06:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1297FE42;
        Fri, 18 Aug 2023 09:06:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 060BB1FB;
        Fri, 18 Aug 2023 09:06:58 -0700 (PDT)
Received: from [10.57.91.158] (unknown [10.57.91.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 007453F762;
        Fri, 18 Aug 2023 09:06:14 -0700 (PDT)
Message-ID: <6ef158ef-c592-64fe-d204-4e7a526b4e47@arm.com>
Date:   Fri, 18 Aug 2023 17:06:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH] iommu: arm-smmu-nvidia: Add default domain type
 implementation op
Content-Language: en-GB
To:     Thierry Reding <thierry.reding@gmail.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Stanimir Varbanov <stanimir.varbanov@suse.com>,
        Stanimir Varbanov <svarbanov@suse.de>,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krishna Reddy <vdumpa@nvidia.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <20230710082252.9702-1-svarbanov@suse.de> <ZKvgG4-IzqiYPSUT@orome>
 <93026b47-3b72-8439-486e-e0cda21dd0fe@suse.com> <ZK17X4ueSI5rWKVL@orome>
 <ZK_8uU2XJAWMk23M@orome>
 <2a6fe812-3881-8dc9-1e7e-237ce7490155@linux.intel.com>
 <ZLDxrDMoLsniQx4x@orome>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZLDxrDMoLsniQx4x@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-14 07:56, Thierry Reding wrote:
> On Fri, Jul 14, 2023 at 11:14:08AM +0800, Baolu Lu wrote:
>> On 2023/7/13 21:31, Thierry Reding wrote:
>>> On Tue, Jul 11, 2023 at 05:55:11PM +0200, Thierry Reding wrote:
>>>> On Tue, Jul 11, 2023 at 01:58:34PM +0300, Stanimir Varbanov wrote:
>>>>> Hi Thierry,
>>>>>
>>>>> Thank you for the comments!
>>>>>
>>>>> On 7/10/23 13:40, Thierry Reding wrote:
>>>>>> On Mon, Jul 10, 2023 at 11:22:52AM +0300, Stanimir Varbanov wrote:
>>>>>>> Add def_domain_type implementation op and override default IOMMU
>>>>>>> domain Kconfig option (CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y), which
>>>>>>> could be enabled on some distros. The current quirk has been done
>>>>>>> for Tegra234 machine, because I found the issue on it. The issue
>>>>>>> itself appears on USB host controller which cannot be initialized
>>>>>>> without IOMMU translation. Something more, we proved that IOMMU
>>>>>>> translation is needed for display and GPU drivers as well.
>>>>>>>
>>>>>>> I evaluated few possible options to solve that:
>>>>>>>
>>>>>>>    a) select default IOMMU domain from .def_domain_type op
>>>>>>>    b) Unset CONFIG_IOMMU_DEFAULT_PASSTHROUGH=n
>>>>>>>    c) add iommu.passthrough=0 on the kernel cmdline
>>>>>>>    d) firmware - ACPI / DT
>>>>>>>
>>>>>>> a) This option is implemented in the proposed patch.
>>>>>>>
>>>>>>> b) Since that the community has agreed that pass-through is preferred
>>>>>>> as a default IOMMU domain option because this will avoid performance
>>>>>>> impacts on some of the platforms [1]. On the other side we have examples
>>>>>>> where you cannot even install Linux distribution on a machine where the
>>>>>>> storage media cannot be detected and the system just hangs.
>>>>>>
>>>>>> That's not how I read that thread. It sounds more to me like Will and
>>>>>> Robin had ideas on how to improve the performance and were planning to
>>>>>> address these issues. It doesn't exactly sound to me like there was
>>>>>> concensus to make passthrough the default.
>>>>>>
>>>>>> Having said that, given that it's possible for distributions and users
>>>>>> to set CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y, I think it would be useful in
>>>>>> general to have a way of enforcing IOMMU translations if it's needed by
>>>>>> the hardware.
>>>>>
>>>>> Exactly, the problem is that some platforms prefer passthrough to avoid
>>>>> performance impacts but others cannot even boot the kernel (and thus
>>>>> installation failure). Passing iommu.passthrough=0 should be an
>>>>> administrator decision, balancing between security and performance.
>>>>>
>>>>> On the other hand the aforementioned mail thread gave some performance
>>>>> numbers which might be are outdated having the improvements made in smmu
>>>>> driver in mind. Unfortunately, I cannot confirm that the performance has
>>>>> been improved during that time.
>>>>>
>>>>>>
>>>>>> I'm not sure I fully understand the particular problems that you're
>>>>>> seeing on Tegra234, though. I'm not aware of anything in the USB host
>>>>>> controller driver (or hardware, for that matter) that would require the
>>>>>> IOMMU to be enabled. The only peculiarity that I can think of is the
>>>>>> firmware, which is typically loaded by an early bootloader and therefore
>>>>>> might perhaps need the IOMMU to properly map this in the kernel.
>>>>>> However, my understanding is that this firmware is loaded into special
>>>>>> carveout regions which don't require remapping.
>>>>>
>>>>> On Jetson Orin AGX (R35.2.1) I see these errors:
>>>>>
>>>>> tegra-mc 2c00000.memory-controller: unknown: write @0x0000000000000080:
>>>>> EMEM address decode error (EMEM decode error)
>>>>>
>>>>> tegra-xusb 3610000.usb: Error while assigning device slot ID
>>>>> tegra-xusb 3610000.usb: Max number of devices this xHCI host supports is 36.
>>>>> usb usb2-port3: couldn't allocate usb_device
>>>>> tegra-mc 2c00000.memory-controller: unknown: write @0x0000000000000090:
>>>>> EMEM address decode error (EMEM decode error)
>>>>> tegra-xusb 3610000.usb: Error while assigning device slot ID
>>>>> tegra-xusb 3610000.usb: Max number of devices this xHCI host supports is 36.
>>>>> usb usb1-port3: couldn't allocate usb_device
>>>>>
>>>>> tegra-mc 2c00000.memory-controller: unknown: write @0x00000000000000a0:
>>>>> EMEM address decode error (EMEM decode error)
>>>>> tegra-xusb 3610000.usb: Error while assigning device slot ID
>>>>> tegra-xusb 3610000.usb: Max number of devices this xHCI host supports is 36.
>>>>> usb usb1-port4: couldn't allocate usb_device
>>>>>
>>>>>>
>>>>>> However, passthrough is admittedly not something that we've thoroughly
>>>>>> tested, so it's possible you're running into a use-case that I'm not
>>>>>> aware of. In that case, could you provide a few more specifics (such as
>>>>>> the DTB and .config) of your build configuration so that I can try and
>>>>>> reproduce?
>>>>>
>>>>> To reproduce you have to add iommu.passthrough=1 on kernel cmdline. The
>>>>> dtb is from Jetpack.
>>>>
>>>> I was able to reproduce this on Jetson Orin NX (the differences to AGX
>>>> Orin should be negligible in this context), though I ended up patching
>>>> the DTB to disable all SMMUs. What fixed it for me was to drop the
>>>> dma-coherent property from the usb@3610000 node. Can you try that on
>>>> your end to see if that works for you as well?
>>>>
>>>> Not that that's a proper solution, of course, but just trying to find
>>>> out if there's perhaps something else going on.
>>>>
>>>>   From the looks of it, it seems like these devices aren't actually DMA
>>>> coherent inherently, but rather the SMMU translations make the accesses
>>>> to memory coherent. I'm trying to find out the exact details, but if it
>>>> turns out to be the case, then what we really want is a way for an IOMMU
>>>> to mark any devices that get attached to it as DMA coherent. It's not
>>>> sufficient to hard-code this in DT because there are various ways in
>>>> which device can end up not attached to an IOMMU despite what the DT
>>>> says.
>>>>
>>>> Jason, or anyone of the IOMMU folks, any thoughts on how this could be
>>>> achieved? DT already has a way of walking up the "DMA hierarchy" looking
>>>> for a DMA coherent parent, but again, making this rely entirely on DT
>>>> seems insufficient.
>>>
>>> I've got a bit more information on what's happening here. There are
>>> three different ways that a device's memory accesses can coherent on
>>> Tegra: 1) when translated through the ARM SMMU, 2) some devices can
>>> force coherency through configuration registers and 3) each device can
>>> be forced to be coherent via the memory controller.
>>>
>>> Option 3) is not something we have much control over because this is
>>> configured during early boot and the corresponding registers locked
>>> down, so the OS can at maximum read out the configuration.
>>>
>>> Option 1) is what is typically used, so a common pattern is that if we
>>> enable IOMMU translations via DT, we also set dma-coherent. Conversely,
>>> if IOMMU translations are disabled via DT, the dma-coherent property
>>> should also be removed because by default most devices will not be
>>> hardcoded to be DMA coherent via option 3). Most device drivers will
>>> also not program the device's configuration registers.
>>>
>>> As a result the desired configuration is to always enable SMMU and rely
>>> on the SMMU translations to provide DMA coherency. As we've seen this
>>> can be problematic, because the device tree doesn't always tell the true
>>> story. For example even if the iommus property exists, the device may
>>> not end up attached to the IOMMU for a number of reasons (the IOMMU
>>> could itself be disabled, a kernel command-line option could prevent the
>>> attachment, or a device could even be detached explicitly).
>>>
>>> So I think what we want to avoid is to mark all device tree nodes as
>>> dma-coherent because it can lead to inconsistencies. A better option
>>> would be to have this property inherited via the IOMMU if the IOMMU
>>> translations themselves cause the coherency to be established. Now it
>>> seems like DT already contains a way of doing that via the "DMA parent".
>>> This works by looking up a special interconnects path called "dma-mem".
>>> We already use this on Tegra to make the memory controller the DMA
>>> parent of all memory clients (i.e. all DMA capable hardware blocks) in
>>> order to enforce a bus-level DMA mask.
>>>
>>> However, in order for the DMA parent mechanism to work for IOMMU, we'd
>>> need to redirect the DMA parent to be the IOMMU, but in that case we
>>> loose the link to the memory controller. Unless, perhaps, if there's a
>>> way to construct an ICC path from device to IOMMU and then to memory
>>> controller and external memory controller (EMC).
>>>
>>> For reference, here's roughly what the data path looks like on Tegra:
>>>
>>> 	device --> MC --> SMMU enabled --> SMMU --> EMC --> DRAM
>>> 	              |                          ^
>>> 	              --> SMMU bypass -----------|
>>>
>>> SMMU can be enabled/disabled per device via a stream ID override
>>> register in the memory controller.
>>>
>>> The biggest downside of that mechanism is still that it's a static
>>> configuration and doesn't respect the actual runtime attachment of a
>>> device to an IOMMU.
>>>
>>> Adding the DT folks to see if they have any good ideas on how best to
>>> represent this from a DT point of view. Would it perhaps be an option
>>> to consider the iommus property when walking up the DMA ancestry?
>>
>> Is it possible to handle this dynamically in the code? Say, set device
>> to be DMA coherent in probe_finalize callback of Tegra iommu driver if
>> the IOMMU translation for this device is on. And clear it in the iommu
>> release device path.
>>
>> Normally we switch the DMA ops in the probe_finalize callback and iommu
>> device release.
> 
> Yeah, I had looked into this as well. Intel, AMD and VirtIO all seem to
> do this during .probe_finalize(), whereas on ARM64 this happens as part
> of the bus' .dma_configure() callback.
> 
> One thing that we could potentially do is fiddle with the struct device
> .dma_coherent member in .probe_finalize() and .release_device(), but I'm
> not sure about the potential ramifications. That is, do we have places
> in the code that assume dev->dma_coherent to be statically set during
> device instantiation?
> 
> We would have to default to not marking devices as dma-coherent in DT
> for that to work, though, because otherwise if someone were to disable
> the IOMMU altogether, .probe_finalize() and .release_device() would
> never get called and we'd never get a chance to override.
> 
> I wonder if we could also use this to dynamically switch a device into
> coherent mode. For example, if it is marked as dma-coherent in device
> tree but doesn't end up as dev->dma_coherent when the driver probes, we
> could try and force coherency via the device's configuration registers.

Indeed, if the device itself can control the memory attributes it 
outputs, then take a look at most users of device_get_dma_attr() for 
examples of doing exactly that.

> I don't know yet if that's really a good idea, though. For correctness
> it would be enough if we can detect at runtime whether a device is DMA
> coherent or not via the IOMMU.

It would be pretty trivial to hook up dynamic coherency through the 
IOMMU API too, but the problem is that in general the IOMMU doesn't 
necessarily know. In ACPI, IORT includes the nifty "Coherent Path to 
Memory" attribute, but no equivalent exists for DT. A "dma-coherent" 
property on the IOMMU node only says that the IOMMU's own memory 
accesses are coherent, but that doesn't guarantee that all of its 
translation interfaces are on coherent paths as well.

Thanks,
Robin.
