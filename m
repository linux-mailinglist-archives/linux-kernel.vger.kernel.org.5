Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEF281108E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378211AbjLMLyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377447AbjLMLyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:54:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB233B0;
        Wed, 13 Dec 2023 03:54:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EB2FFEC;
        Wed, 13 Dec 2023 03:54:54 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F46E3F7F4;
        Wed, 13 Dec 2023 03:54:07 -0800 (PST)
Message-ID: <3b7742c4-bbae-4a78-a5a6-30df936a17d4@arm.com>
Date:   Wed, 13 Dec 2023 11:54:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
Content-Language: en-GB
To:     Lukas Wunner <lukas@wunner.de>,
        Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc:     bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
        will@kernel.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Haorong Ye <yehaorong@bytedance.com>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-3-haifeng.zhao@linux.intel.com>
 <20231213104417.GA31964@wunner.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231213104417.GA31964@wunner.de>
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

On 13/12/2023 10:44 am, Lukas Wunner wrote:
> On Tue, Dec 12, 2023 at 10:46:37PM -0500, Ethan Zhao wrote:
>> For those endpoint devices connect to system via hotplug capable ports,
>> users could request a warm reset to the device by flapping device's link
>> through setting the slot's link control register,
> 
> Well, users could just *unplug* the device, right?  Why is it relevant
> that thay could fiddle with registers in config space?
> 
> 
>> as pciehpt_ist() DLLSC
>> interrupt sequence response, pciehp will unload the device driver and
>> then power it off. thus cause an IOMMU devTLB flush request for device to
>> be sent and a long time completion/timeout waiting in interrupt context.
> 
> A completion timeout should be on the order of usecs or msecs, why does it
> cause a hard lockup?  The dmesg excerpt you've provided shows a 12 *second*
> delay between hot removal and watchdog reaction.

The PCIe spec only requires an endpoint to respond to an ATS invalidate 
within a rather hilarious 90 seconds, so it's primarily a question of 
how patient the root complex and bridges in between are prepared to be.

>> Fix it by checking the device's error_state in
>> devtlb_invalidation_with_pasid() to avoid sending meaningless devTLB flush
>> request to link down device that is set to pci_channel_io_perm_failure and
>> then powered off in
> 
> This doesn't seem to be a proper fix.  It will work most of the time
> but not always.  A user might bring down the slot via sysfs, then yank
> the card from the slot just when the iommu flush occurs such that the
> pci_dev_is_disconnected(pdev) check returns false but the card is
> physically gone immediately afterwards.  In other words, you've shrunk
> the time window during which the issue may occur, but haven't eliminated
> it completely.

Yeah, I think we have a subtle but fundamental issue here in that the 
iommu_release_device() callback is hooked to BUS_NOTIFY_REMOVED_DEVICE, 
so in general probably shouldn't be assuming it's safe to do anything 
with the device itself *after* it's already been removed from its bus - 
this step is primarily about cleaning up any of the IOMMU's own state 
relating to the given device.

I think if we want to ensure ATCs are invalidated on hot-unplug we need 
an additional pre-removal notifier to take care of that, and that step 
would then want to distinguish between an orderly removal where cleaning 
up is somewhat meaningful, and a surprise removal where it definitely isn't.

Thanks,
Robin.
