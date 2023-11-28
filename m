Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF087FC242
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346456AbjK1QCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346092AbjK1QCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:02:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61CD719A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:02:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F0B4C15;
        Tue, 28 Nov 2023 08:03:34 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A77E3F6C4;
        Tue, 28 Nov 2023 08:02:46 -0800 (PST)
Message-ID: <69db9205-cb9a-425a-a48e-6d68d1f900f1@arm.com>
Date:   Tue, 28 Nov 2023 16:02:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommufd/selftest: Use a fwnode to distinguish devices
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     joro@8bytes.org, kevin.tian@intel.com, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1701165201.git.robin.murphy@arm.com>
 <e365c08b21a8d0b60e6f5d1411be6701c1a06a53.1701165201.git.robin.murphy@arm.com>
 <20231128144331.GA1191405@ziepe.ca>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231128144331.GA1191405@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 2:43 pm, Jason Gunthorpe wrote:
> On Tue, Nov 28, 2023 at 10:42:11AM +0000, Robin Murphy wrote:
>> With bus ops gone, the trick of registering against a specific bus no
>> longer really works, and we start getting given devices from other buses
>> to probe,
> 
> Make sense
> 
>> which leads to spurious groups for devices with no IOMMU on
>> arm64,
> 
> I'm not sure I'm fully understanding what this means?

It means on my arm64 ACPI system, random platform devices which are 
created after iommufd_test_init() has run get successfully probed by the 
mock driver, unexpectedly:

root@crazy-taxi:~# ls /sys/kernel/iommu_groups/*/devices
/sys/kernel/iommu_groups/0/devices:
0000:07:00.0

/sys/kernel/iommu_groups/1/devices:
'Fixed MDIO bus.0'

/sys/kernel/iommu_groups/10/devices:
0001:00:00.0

/sys/kernel/iommu_groups/2/devices:
0000:04:05.0

/sys/kernel/iommu_groups/3/devices:
0000:08:00.0

/sys/kernel/iommu_groups/4/devices:
0000:09:00.0

/sys/kernel/iommu_groups/5/devices:
0001:01:00.0

/sys/kernel/iommu_groups/6/devices:
alarmtimer.2.auto

/sys/kernel/iommu_groups/7/devices:
psci-cpuidle

/sys/kernel/iommu_groups/8/devices:
snd-soc-dummy

/sys/kernel/iommu_groups/9/devices:
0000:00:00.0  0000:01:00.0  0000:02:08.0  0000:02:10.0  0000:02:11.0 
0000:02:12.0  0000:02:13.0  0000:02:14.0  0000:03:00.0
root@crazy-taxi:~# cat /sys/kernel/iommu_groups/*/type
DMA
blocked
DMA
DMA
DMA
DMA
DMA
blocked
blocked
blocked
DMA

> I guess that the mock driver is matching random things once it starts
> being called all the time because this is missing:
> 
>   static struct iommu_device *mock_probe_device(struct device *dev)
>   {
> +       if (dev->bus != &iommufd_mock_bus_type)
> +               return -ENODEV;
>          return &mock_iommu_device;
>   }
> 
> Is that sufficient to solve the problem?

Unfortunately not...

>> but may inadvertently steal devices from the real IOMMU on Intel,
>> AMD or S390.
> 
> AMD/Intel/S390 drivers already reject bus's they don't understand.
> 
> Intel's device_to_iommu() will fail because
> for_each_active_dev_scope() will never match the mock device.
> 
> amd fails because check_device() -> get_device_sbdf_id() fails due to
> no PCI and not get_acpihid_device_id().
> 
> s390 fails because !dev_is_pci(dev).

Indeed, but then when such probes do fail, they've failed for good. We 
don't have any way to somehow dig up the mock driver's ops and try 
again, so the selftest ends up broken (i.e. the real driver "steals" the 
mock devices, in the inverse of the case I was concerned about if the 
mock driver somehow manages to register first).

The assumption was as commented in the code, that there would only ever 
be one driver per system *not* using fwnodes, but as I say I missed the 
mock driver when considering that. To be fair, I'm not sure it even 
existed when I *first* wrote that code :)

I did intend coexistence to work on x86 too, where the "other" driver 
would be virtio-iommu using fwnodes, so aligning the mock driver that 
way seemed far neater than any more special-case hacks in core code.

> The fwspec drivers should all fail if they don't have a fwspec, and
> they shouldn't for mock bus devices since it doesn't implement
> dma_configure.

Right, the selftests still work fine on my arm64 system (and the 
spurious groups happen to be benign since those aren't real DMA-capable 
device anyway), but I expect they're busted on x86/s390 with today's -next.

Thanks,
Robin.
