Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CAA7B5AB7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbjJBTCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjJBTCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:02:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECE35AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 12:02:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F5B0C15;
        Mon,  2 Oct 2023 12:03:10 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEF363F59C;
        Mon,  2 Oct 2023 12:02:29 -0700 (PDT)
Message-ID: <a4078085-4061-2b52-daba-1cd642f0cf9d@arm.com>
Date:   Mon, 2 Oct 2023 20:02:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 4/7] iommu: Switch __iommu_domain_alloc() to device ops
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
References: <cover.1696253096.git.robin.murphy@arm.com>
 <458dd0ed839541693a49da33239b33cf4c48b8ec.1696253096.git.robin.murphy@arm.com>
 <20231002141615.GA650249@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231002141615.GA650249@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2023 3:16 pm, Jason Gunthorpe wrote:
> On Mon, Oct 02, 2023 at 02:49:12PM +0100, Robin Murphy wrote:
>> @@ -2120,20 +2120,30 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
>>   	return domain;
>>   }
>>   
>> -static struct iommu_domain *
>> -__iommu_group_domain_alloc(struct iommu_group *group, unsigned int type)
>> +static int __iommu_domain_alloc_dev(struct device *dev, void *data)
>>   {
> 
> Why?

Because out of 3 callsites, two were in a context which now needed to
make the iommu_group_first_dev() call itself anyway, thus recalculating
it twice more with the mutex still held would clearly be silly, and so
rather than bother refactoring the __iommu_group_domain_alloc() helper I
squashed it into its one remaining user. I don't know a good way to tell
git-format-patch to show a particular range of lines as a complete
removal of one function plus the addition of an entirely unrelated new
one which just happens to be in the same place.

> The point of this design is that drivers are not allowed to
> allocate different things for devices in the same group. So we always
> force the driver to see only the first device in the group even if we
> have a more specific device available in the call chain.

OK, but I can't read your mind. All I have visibility of is some
code which factored out a helper function for a sequence common to
several users, as is typical; neither the commit message of 8359cf39acba
nor the cover letter from that series provide any obvious explanation of
this "design".

> This patch has undone this design and passed in more specific devs :(

Um... Good? I mean in 3/4 cases it's literally the exact same code just
factored out again, while the one I've added picks some arbitrary device
in a different way. But the first device in the group list is still just
that - some arbitrary device - it's by no means guaranteed to be the
*same* device each time the group is re-locked, so pretending it's some
kind of useful invariant is misleading and wrong. Frankly now that you
*have* explained the design intent here, it's only made me more set on
removing it for being unclear, overcomplicated, and yet fundamentally
useless.

Yes, we absolutely expect that if dev_iommu_ops(dev)->device_group for
two devices returns the same group, the driver should bloody well give
the same result for either dev_iommu_ops(dev)->domain_alloc, but there's
no practical way to enforce that at this level of code. If a driver ever
did have inconsistent behaviour across devices within a group, trying to
always use the "one true device" would only help *hide* that and make it
harder to debug, not at all prevent it.

> The new code here:
> 
>>   struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
>>   {
>> -	if (bus == NULL || bus->iommu_ops == NULL)
>> +	struct device *dev = NULL;
>> +
>> +	/* We always check the whole bus, so the return value isn't useful */
>> +	bus_for_each_dev(bus, NULL, &dev, __iommu_domain_alloc_dev);
>> +	if (!dev)
>>   		return NULL;
>> -	return __iommu_domain_alloc(bus->iommu_ops, NULL,
>> -				    IOMMU_DOMAIN_UNMANAGED);
>> +
>> +	return __iommu_domain_alloc(dev, IOMMU_DOMAIN_UNMANAGED);
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_domain_alloc);
> 
> Should just obtain any group for the bus and pass that to
> __iommu_group_domain_alloc().
> 
> Also, how does the locking work here? Definately can't pass dev
> outside the bus_for_each_dev() like this.

It works like in most of the rest of the API right now... this is still
the process of cleaning up the old ugly stuff in order to be able to
evolve the API foundations to the point where we *can* have a reasonable
locking scheme. It's a multi-step process, and I'd really like to get
the internal bus-ops-to-instance-ops transition completed in order to
then clean up the "of_iommu_configure() at driver probe time"
catastrophe, get iommu_domain_alloc() callers to pass a valid device
themselves, teach the ARM DMA ops about default domains (for which it's
a great help that you've now got the driver-side groundwork done,
thanks!), and then maybe we can finally have nice things.

> If this needs to sweep over arbitary devices that are not the caller's
> probe'd device it needs to hold at least the device_lock to prevent
> racing with release.
> 
> So I'd structure this to find the matching device, lock the
> device_lock, get the group refcount, unlock the device_lock then
> get the group_mutex, check for non-empty and then call
> __iommu_group_domain_alloc()

...and as your reward you'd get much the same deadlocks as with the last
attempt to bring device_lock into it, thanks to
arm_iommu_create_mapping(), and drivers calling iommu_domain_alloc()
from their own probe routines :(

FYI the diff below is what I've hacked out so far, but I'll test it with
a fresh head tomorrow (just pasting it in here I've noticed at least one
bug...)

> (there is a missing lockdep annotation in
> __iommu_group_domain_alloc(), the group mutex is needed)

(fear not, iommu_group_first_dev() brings that to those places!)

Thanks,
Robin.

----->8-----
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3d29434d57c6..78366e988e31 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2128,27 +2128,41 @@ static struct iommu_domain *__iommu_domain_alloc(struct device *dev,
  static int __iommu_domain_alloc_dev(struct device *dev, void *data)
  {
  	struct device **alloc_dev = data;
+	struct iommu_group *group = iommu_group_get(dev);
  
-	if (!dev_has_iommu(dev))
+	if (!group)
  		return 0;
  
-	WARN_ONCE(*alloc_dev && dev_iommu_ops(dev) != dev_iommu_ops(*alloc_dev),
-		  "Multiple IOMMU drivers present, which the public IOMMU API can't fully support yet. You may still need to disable one or more to get the expected result here, sorry!\n");
+	mutex_lock(&group->mutex);
+	/* Theoretically we could have raced against release */
+	if (list_empty(&group->devices)) {
+		mutex_unlock(&group->mutex);
+		iommu_group_put(group);
+		return 0;
+	}
  
-	*alloc_dev = dev;
+	if (!*alloc_dev)
+		*alloc_dev = dev;
+
+	WARN_ONCE(dev_iommu_ops(dev) != dev_iommu_ops(*alloc_dev),
+		  "Multiple IOMMU drivers present, which the public IOMMU API can't fully support yet. You may still need to disable one or more to get the expected result here, sorry!\n");
  	return 0;
  }
  
  struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
  {
  	struct device *dev = NULL;
+	struct iommu_domain *dom;
  
  	/* We always check the whole bus, so the return value isn't useful */
  	bus_for_each_dev(bus, NULL, &dev, __iommu_domain_alloc_dev);
  	if (!dev)
  		return NULL;
  
-	return __iommu_domain_alloc(dev, IOMMU_DOMAIN_UNMANAGED);
+	dom = __iommu_domain_alloc(dev, IOMMU_DOMAIN_UNMANAGED);
+	mutex_unlock(&dev->iommu_group->mutex);
+	iommu_group_put(dev->iommu_group);
+	return dom;
  }
  EXPORT_SYMBOL_GPL(iommu_domain_alloc);
  
