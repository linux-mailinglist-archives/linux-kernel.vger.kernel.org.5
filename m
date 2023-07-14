Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24407752FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjGNDOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjGNDO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:14:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478A130DB;
        Thu, 13 Jul 2023 20:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689304461; x=1720840461;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W0M0Irt0GRR0M/wBK6Bo1dJ2wHgwJBI9j7flSidhoKw=;
  b=WQkkjBbVLV/2u7p92xsJz/Dod+lEqkQiD1KDa39KFWIIhaqouNWm2uLe
   ehOk6M0k7ZVi7V4tCmTVxzCW28bc852+4m80zQvJMrvKF2Z99cxrnCcyu
   bMG2f1VDGTjVKwOr4qoJ6oCYrAiNZ8v3sS8Ydzowmv1ShLd8dDon4fLpA
   DJpO33bXEWjHxOmq4bSgv/qaF1qZknsDLpXSfC7/fwfkaPcPwpkJyLkc1
   I2tXRjiAO//3VjGmR8G1Z8B7K7u6Y6k+PFqgduLXsZrl48enlvoMus0Wx
   BOhRBcHqxXwVjGeWAG3NE6gU2lEbXQtNCv2fAxqcKUNGItwsZZD+zufAf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="368018269"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="368018269"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:14:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="757417300"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="757417300"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.49]) ([10.252.191.49])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:14:12 -0700
Message-ID: <2a6fe812-3881-8dc9-1e7e-237ce7490155@linux.intel.com>
Date:   Fri, 14 Jul 2023 11:14:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com, Stanimir Varbanov <svarbanov@suse.de>,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krishna Reddy <vdumpa@nvidia.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH] iommu: arm-smmu-nvidia: Add default domain type
 implementation op
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Stanimir Varbanov <stanimir.varbanov@suse.com>
References: <20230710082252.9702-1-svarbanov@suse.de> <ZKvgG4-IzqiYPSUT@orome>
 <93026b47-3b72-8439-486e-e0cda21dd0fe@suse.com> <ZK17X4ueSI5rWKVL@orome>
 <ZK_8uU2XJAWMk23M@orome>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZK_8uU2XJAWMk23M@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/13 21:31, Thierry Reding wrote:
> On Tue, Jul 11, 2023 at 05:55:11PM +0200, Thierry Reding wrote:
>> On Tue, Jul 11, 2023 at 01:58:34PM +0300, Stanimir Varbanov wrote:
>>> Hi Thierry,
>>>
>>> Thank you for the comments!
>>>
>>> On 7/10/23 13:40, Thierry Reding wrote:
>>>> On Mon, Jul 10, 2023 at 11:22:52AM +0300, Stanimir Varbanov wrote:
>>>>> Add def_domain_type implementation op and override default IOMMU
>>>>> domain Kconfig option (CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y), which
>>>>> could be enabled on some distros. The current quirk has been done
>>>>> for Tegra234 machine, because I found the issue on it. The issue
>>>>> itself appears on USB host controller which cannot be initialized
>>>>> without IOMMU translation. Something more, we proved that IOMMU
>>>>> translation is needed for display and GPU drivers as well.
>>>>>
>>>>> I evaluated few possible options to solve that:
>>>>>
>>>>>   a) select default IOMMU domain from .def_domain_type op
>>>>>   b) Unset CONFIG_IOMMU_DEFAULT_PASSTHROUGH=n
>>>>>   c) add iommu.passthrough=0 on the kernel cmdline
>>>>>   d) firmware - ACPI / DT
>>>>>
>>>>> a) This option is implemented in the proposed patch.
>>>>>
>>>>> b) Since that the community has agreed that pass-through is preferred
>>>>> as a default IOMMU domain option because this will avoid performance
>>>>> impacts on some of the platforms [1]. On the other side we have examples
>>>>> where you cannot even install Linux distribution on a machine where the
>>>>> storage media cannot be detected and the system just hangs.
>>>>
>>>> That's not how I read that thread. It sounds more to me like Will and
>>>> Robin had ideas on how to improve the performance and were planning to
>>>> address these issues. It doesn't exactly sound to me like there was
>>>> concensus to make passthrough the default.
>>>>
>>>> Having said that, given that it's possible for distributions and users
>>>> to set CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y, I think it would be useful in
>>>> general to have a way of enforcing IOMMU translations if it's needed by
>>>> the hardware.
>>>
>>> Exactly, the problem is that some platforms prefer passthrough to avoid
>>> performance impacts but others cannot even boot the kernel (and thus
>>> installation failure). Passing iommu.passthrough=0 should be an
>>> administrator decision, balancing between security and performance.
>>>
>>> On the other hand the aforementioned mail thread gave some performance
>>> numbers which might be are outdated having the improvements made in smmu
>>> driver in mind. Unfortunately, I cannot confirm that the performance has
>>> been improved during that time.
>>>
>>>>
>>>> I'm not sure I fully understand the particular problems that you're
>>>> seeing on Tegra234, though. I'm not aware of anything in the USB host
>>>> controller driver (or hardware, for that matter) that would require the
>>>> IOMMU to be enabled. The only peculiarity that I can think of is the
>>>> firmware, which is typically loaded by an early bootloader and therefore
>>>> might perhaps need the IOMMU to properly map this in the kernel.
>>>> However, my understanding is that this firmware is loaded into special
>>>> carveout regions which don't require remapping.
>>>
>>> On Jetson Orin AGX (R35.2.1) I see these errors:
>>>
>>> tegra-mc 2c00000.memory-controller: unknown: write @0x0000000000000080:
>>> EMEM address decode error (EMEM decode error)
>>>
>>> tegra-xusb 3610000.usb: Error while assigning device slot ID
>>> tegra-xusb 3610000.usb: Max number of devices this xHCI host supports is 36.
>>> usb usb2-port3: couldn't allocate usb_device
>>> tegra-mc 2c00000.memory-controller: unknown: write @0x0000000000000090:
>>> EMEM address decode error (EMEM decode error)
>>> tegra-xusb 3610000.usb: Error while assigning device slot ID
>>> tegra-xusb 3610000.usb: Max number of devices this xHCI host supports is 36.
>>> usb usb1-port3: couldn't allocate usb_device
>>>
>>> tegra-mc 2c00000.memory-controller: unknown: write @0x00000000000000a0:
>>> EMEM address decode error (EMEM decode error)
>>> tegra-xusb 3610000.usb: Error while assigning device slot ID
>>> tegra-xusb 3610000.usb: Max number of devices this xHCI host supports is 36.
>>> usb usb1-port4: couldn't allocate usb_device
>>>
>>>>
>>>> However, passthrough is admittedly not something that we've thoroughly
>>>> tested, so it's possible you're running into a use-case that I'm not
>>>> aware of. In that case, could you provide a few more specifics (such as
>>>> the DTB and .config) of your build configuration so that I can try and
>>>> reproduce?
>>>
>>> To reproduce you have to add iommu.passthrough=1 on kernel cmdline. The
>>> dtb is from Jetpack.
>>
>> I was able to reproduce this on Jetson Orin NX (the differences to AGX
>> Orin should be negligible in this context), though I ended up patching
>> the DTB to disable all SMMUs. What fixed it for me was to drop the
>> dma-coherent property from the usb@3610000 node. Can you try that on
>> your end to see if that works for you as well?
>>
>> Not that that's a proper solution, of course, but just trying to find
>> out if there's perhaps something else going on.
>>
>>  From the looks of it, it seems like these devices aren't actually DMA
>> coherent inherently, but rather the SMMU translations make the accesses
>> to memory coherent. I'm trying to find out the exact details, but if it
>> turns out to be the case, then what we really want is a way for an IOMMU
>> to mark any devices that get attached to it as DMA coherent. It's not
>> sufficient to hard-code this in DT because there are various ways in
>> which device can end up not attached to an IOMMU despite what the DT
>> says.
>>
>> Jason, or anyone of the IOMMU folks, any thoughts on how this could be
>> achieved? DT already has a way of walking up the "DMA hierarchy" looking
>> for a DMA coherent parent, but again, making this rely entirely on DT
>> seems insufficient.
> 
> I've got a bit more information on what's happening here. There are
> three different ways that a device's memory accesses can coherent on
> Tegra: 1) when translated through the ARM SMMU, 2) some devices can
> force coherency through configuration registers and 3) each device can
> be forced to be coherent via the memory controller.
> 
> Option 3) is not something we have much control over because this is
> configured during early boot and the corresponding registers locked
> down, so the OS can at maximum read out the configuration.
> 
> Option 1) is what is typically used, so a common pattern is that if we
> enable IOMMU translations via DT, we also set dma-coherent. Conversely,
> if IOMMU translations are disabled via DT, the dma-coherent property
> should also be removed because by default most devices will not be
> hardcoded to be DMA coherent via option 3). Most device drivers will
> also not program the device's configuration registers.
> 
> As a result the desired configuration is to always enable SMMU and rely
> on the SMMU translations to provide DMA coherency. As we've seen this
> can be problematic, because the device tree doesn't always tell the true
> story. For example even if the iommus property exists, the device may
> not end up attached to the IOMMU for a number of reasons (the IOMMU
> could itself be disabled, a kernel command-line option could prevent the
> attachment, or a device could even be detached explicitly).
> 
> So I think what we want to avoid is to mark all device tree nodes as
> dma-coherent because it can lead to inconsistencies. A better option
> would be to have this property inherited via the IOMMU if the IOMMU
> translations themselves cause the coherency to be established. Now it
> seems like DT already contains a way of doing that via the "DMA parent".
> This works by looking up a special interconnects path called "dma-mem".
> We already use this on Tegra to make the memory controller the DMA
> parent of all memory clients (i.e. all DMA capable hardware blocks) in
> order to enforce a bus-level DMA mask.
> 
> However, in order for the DMA parent mechanism to work for IOMMU, we'd
> need to redirect the DMA parent to be the IOMMU, but in that case we
> loose the link to the memory controller. Unless, perhaps, if there's a
> way to construct an ICC path from device to IOMMU and then to memory
> controller and external memory controller (EMC).
> 
> For reference, here's roughly what the data path looks like on Tegra:
> 
> 	device --> MC --> SMMU enabled --> SMMU --> EMC --> DRAM
> 	              |                          ^
> 	              --> SMMU bypass -----------|
> 
> SMMU can be enabled/disabled per device via a stream ID override
> register in the memory controller.
> 
> The biggest downside of that mechanism is still that it's a static
> configuration and doesn't respect the actual runtime attachment of a
> device to an IOMMU.
> 
> Adding the DT folks to see if they have any good ideas on how best to
> represent this from a DT point of view. Would it perhaps be an option
> to consider the iommus property when walking up the DMA ancestry?

Is it possible to handle this dynamically in the code? Say, set device
to be DMA coherent in probe_finalize callback of Tegra iommu driver if
the IOMMU translation for this device is on. And clear it in the iommu
release device path.

Normally we switch the DMA ops in the probe_finalize callback and iommu
device release.

Best regards,
baolu
