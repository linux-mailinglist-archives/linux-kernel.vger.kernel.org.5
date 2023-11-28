Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D77F7FC16F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346059AbjK1Rgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjK1Rgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:36:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 177FCCA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:36:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2398C15;
        Tue, 28 Nov 2023 09:37:23 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AE053F6C4;
        Tue, 28 Nov 2023 09:36:35 -0800 (PST)
Message-ID: <a9674ad7-e773-495b-abc3-dae1f74a7694@arm.com>
Date:   Tue, 28 Nov 2023 17:36:33 +0000
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
 <69db9205-cb9a-425a-a48e-6d68d1f900f1@arm.com>
 <20231128163342.GI432016@ziepe.ca>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231128163342.GI432016@ziepe.ca>
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

On 28/11/2023 4:33 pm, Jason Gunthorpe wrote:
> On Tue, Nov 28, 2023 at 04:02:42PM +0000, Robin Murphy wrote:
>> On 28/11/2023 2:43 pm, Jason Gunthorpe wrote:
>>> On Tue, Nov 28, 2023 at 10:42:11AM +0000, Robin Murphy wrote:
>>>> With bus ops gone, the trick of registering against a specific bus no
>>>> longer really works, and we start getting given devices from other buses
>>>> to probe,
>>>
>>> Make sense
>>>
>>>> which leads to spurious groups for devices with no IOMMU on
>>>> arm64,
>>>
>>> I'm not sure I'm fully understanding what this means?
>>
>> It means on my arm64 ACPI system, random platform devices which are created
>> after iommufd_test_init() has run get successfully probed by the mock
>> driver, unexpectedly:
> 
> Okay that is what I guessed
> 
>>> I guess that the mock driver is matching random things once it starts
>>> being called all the time because this is missing:
>>>
>>>    static struct iommu_device *mock_probe_device(struct device *dev)
>>>    {
>>> +       if (dev->bus != &iommufd_mock_bus_type)
>>> +               return -ENODEV;
>>>           return &mock_iommu_device;
>>>    }
>>>
>>> Is that sufficient to solve the problem?
>>
>> Unfortunately not...
> 
> I see, so we create the other problem that without bus ops we don't
> get to have two 'global' drivers and with the above mock won't probe
> on x86.
> 
>> I did intend coexistence to work on x86 too, where the "other" driver would
>> be virtio-iommu using fwnodes, so aligning the mock driver that way seemed
>> far neater than any more special-case hacks in core code.
> 
> Lets just do the above and what I suggested earlier. This is from a
> WIP tree I have, it shows the idea but needs other stuff to work. If
> you agree I'll pull its parts out and post a clean version of them.
> 
> commit 51c9a54cc111b4b31af6a0527015db82e782e1d3
> Author: Jason Gunthorpe <jgg@ziepe.ca>
> Date:   Tue Nov 28 11:54:47 2023 -0400
> 
>      iommu: Call all drivers if there is no fwspec
>      
>      Real systems only have one ops, so this effectively invokes the single op
>      in the system to probe each device. If there are multiple ops we invoke
>      each one once, and drivers that don't understand the struct device should
>      return -ENODEV.

You see this is exactly the kind of complexity I *don't* want, since the 
only thing it would foreseeably benefit is the one special case of the 
IOMMUFD selftest, which can far more trivially just adopt the other of 
the two "standard" usage models we have. I've been trying to get *away* 
from having to have boilerplate checks in all the drivers, and this 
would require bringing back a load of the ones I've just removed :(

As I said before, I really want to avoid the perf_event_init model of 
calling round every driver saying "hey, do you want this?" since it's 
also error-prone if any of those drivers doesn't get the boilerplate 
exactly right and inadvertently fails to reject something it should 
have. The difference with perf is that it has the notion of generic 
events which *can* be handled by more than one driver. We do not, and 
conceivably never will, have that for IOMMU client devices, so we can 
realistically make the core code responsible for calling the right 
driver by construction, and since we're now mostly there already, it 
seem by far the most sensible thing to continue in that direction.

Thanks,
Robin.


>      Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 7468a64778931b..54e3f14429b3b4 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -241,6 +241,26 @@ static int remove_iommu_group(struct device *dev, void *data)
>   	return 0;
>   }
>   
> +static void iommu_device_add(struct iommu_device *iommu)
> +{
> +	struct iommu_device *cur;
> +
> +	/*
> +	 * Keep the iommu_device_list grouped by ops so that
> +	 * iommu_find_init_device() works efficiently.
> +	 */
> +	mutex_lock(&iommu_probe_device_lock);
> +	list_for_each_entry(cur, &iommu_device_list, list) {
> +		if (cur->ops == iommu->ops) {
> +			list_add(&iommu->list, &cur->list);
> +			goto out;
> +		}
> +	}
> +	list_add(&iommu->list, &iommu_device_list);
> +out:
> +	mutex_unlock(&iommu_probe_device_lock);
> +}
> +
>   /**
>    * iommu_device_register() - Register an IOMMU hardware instance
>    * @iommu: IOMMU handle for the instance
> @@ -262,9 +282,7 @@ int iommu_device_register(struct iommu_device *iommu,
>   	if (hwdev)
>   		iommu->fwnode = dev_fwnode(hwdev);
>   
> -	mutex_lock(&iommu_probe_device_lock);
> -	list_add_tail(&iommu->list, &iommu_device_list);
> -	mutex_unlock(&iommu_probe_device_lock);
> +	iommu_device_add(iommu);
>   
>   	for (int i = 0; i < ARRAY_SIZE(iommu_buses) && !err; i++)
>   		err = bus_iommu_probe(iommu_buses[i]);
> @@ -502,6 +520,29 @@ static void iommu_deinit_device(struct device *dev)
>   
>   DEFINE_MUTEX(iommu_probe_device_lock);
>   
> +static int iommu_find_init_device(struct iommu_probe_info *pinf)
> +{
> +	const struct iommu_ops *ops = NULL;
> +	struct iommu_device *iommu;
> +	int ret;
> +
> +	lockdep_assert_held(&iommu_probe_device_lock);
> +
> +	/*
> +	 * Each unique ops gets a chance to claim the device, -ENODEV means the
> +	 * driver does not support the device.
> +	 */
> +	list_for_each_entry(iommu, &iommu_device_list, list) {
> +		if (iommu->ops != ops) {
> +			ops = iommu->ops;
> +			ret = iommu_init_device(pinf, iommu->ops);
> +			if (ret != -ENODEV)
> +				return ret;
> +		}
> +	}
> +	return -ENODEV;
> +}
> +
>   static int __iommu_probe_device(struct iommu_probe_info *pinf)
>   {
>   	struct device *dev = pinf->dev;
> @@ -524,13 +565,6 @@ static int __iommu_probe_device(struct iommu_probe_info *pinf)
>   		ops = fwspec->ops;
>   		if (!ops)
>   			return -ENODEV;
> -	} else {
> -		struct iommu_device *iommu;
> -
> -		iommu = iommu_device_from_fwnode(NULL);
> -		if (!iommu)
> -			return -ENODEV;
> -		ops = iommu->ops;
>   	}
>   
>   	/*
> @@ -546,7 +580,10 @@ static int __iommu_probe_device(struct iommu_probe_info *pinf)
>   	if (dev->iommu_group)
>   		return 0;
>   
> -	ret = iommu_init_device(pinf, ops);
> +	if (ops)
> +		ret = iommu_init_device(pinf, ops);
> +	else
> +		ret = iommu_find_init_device(pinf);
>   	if (ret)
>   		return ret;
>   
