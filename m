Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A845759F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGST6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjGST6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:58:51 -0400
Received: from out-49.mta0.migadu.com (out-49.mta0.migadu.com [IPv6:2001:41d0:1004:224b::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F9A92
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:58:49 -0700 (PDT)
Message-ID: <9a1590bd-5dfc-94ad-645e-a0a499ae5b23@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689796727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0X9JpDivKaFvl29MFTdl1MmoW2D7jWyZmoPkL8jU/wY=;
        b=g/U7HnDoDiCqmNZx9nygGmoTHsh/oR4gOBAp/GI+d29O4ufvQt6OR0CHo4r0LBcxZz9GnM
        /4jyWgrcpveBCEPEy5FQ5TPkk0pyFbmPiyrGZL1dAKoa+GM+RF9uf/7G/a5Eq/OqVKVBIQ
        0hhXwg4DTFrgz5FZ2cobs56lIWG+5N8=
Date:   Thu, 20 Jul 2023 03:58:36 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] PCI/VGA: Deal with PCI VGA compatible devices only
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn,
        Mario Limonciello <mario.limonciello@amd.com>
References: <20230719182617.GA509912@bhelgaas>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20230719182617.GA509912@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2023/7/20 02:26, Bjorn Helgaas wrote:
> On Tue, Jul 11, 2023 at 09:43:50PM +0800, Sui Jingfeng wrote:
[...]
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> I do not see Mario's Reviewed-by on the list.  I do see Mario's
> Reviewed-by [2] for a previous version, but that version added this in
> pci_notify():
>
>    + if (pdev->class != PCI_CLASS_DISPLAY_VGA << 8)
>    +   return 0;
>
> while this version adds:
>
>    + if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
>    +   return 0;
>
> It's OK to carry a review to future versions if there are
> insignificant changes, but this is a functional change that seems
> significant to me.  The first matches only 0x030000, while the second
> discards the low eight bits so it matches 0x0300XX.

Yes, you are right.

But I suddenly realized that this may deserve another patch, desperate 
trivial.

What this version adds here is *same* before this patch set is applied.

My explanation about the minor tweak being made before this version and 
previous version

is that  I want to keep my patch *less distraction*.

The major functional gains(benefit) is that we filter non VGA compatible 
devices out.

As a start point, I should keep one patch do one thing (do one thing and 
do it well).


On the other hand, even though the lest significant 8 but if pdev->class 
is really matter.

I think I still need to wait the things(a bug emerged, for example) 
became clear.

Instead of cleanup all potential problems with obvious motivation.

I think Mario will accept my explanation.

> [1] https://lore.kernel.org/r/20230718231400.GA496927@bhelgaas
> [2] https://lore.kernel.org/all/5b6fdf65-b354-94a9-f883-be820157efad@amd.com/
>
>> ---
>>   drivers/pci/vgaarb.c | 25 +++++++++++++------------
>>   1 file changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
>> index c1bc6c983932..021116ed61cb 100644
>> --- a/drivers/pci/vgaarb.c
>> +++ b/drivers/pci/vgaarb.c
>> @@ -754,10 +754,6 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
>>   	struct pci_dev *bridge;
>>   	u16 cmd;
>>   
>> -	/* Only deal with VGA class devices */
>> -	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
>> -		return false;
>> -
>>   	/* Allocate structure */
>>   	vgadev = kzalloc(sizeof(struct vga_device), GFP_KERNEL);
>>   	if (vgadev == NULL) {
>> @@ -1502,6 +1498,10 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
>>   
>>   	vgaarb_dbg(dev, "%s\n", __func__);
>>   
>> +	/* Deal with VGA compatible devices only */
>> +	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
>> +		return 0;
>> +
>>   	/* For now we're only intereted in devices added and removed. I didn't
>>   	 * test this thing here, so someone needs to double check for the
>>   	 * cases of hotplugable vga cards. */
>> @@ -1534,8 +1534,8 @@ static struct miscdevice vga_arb_device = {
>>   
>>   static int __init vga_arb_device_init(void)
>>   {
>> +	struct pci_dev *pdev = NULL;
>>   	int rc;
>> -	struct pci_dev *pdev;
>>   
>>   	rc = misc_register(&vga_arb_device);
>>   	if (rc < 0)
>> @@ -1543,13 +1543,14 @@ static int __init vga_arb_device_init(void)
>>   
>>   	bus_register_notifier(&pci_bus_type, &pci_notifier);
>>   
>> -	/* We add all PCI devices satisfying VGA class in the arbiter by
>> -	 * default */
>> -	pdev = NULL;
>> -	while ((pdev =
>> -		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>> -			       PCI_ANY_ID, pdev)) != NULL)
>> -		vga_arbiter_add_pci_device(pdev);
>> +	/*
>> +	 * We add all PCI VGA compatible devices in the arbiter by default
>> +	 */
>> +	do {
>> +		pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev);
>> +		if (pdev)
>> +			vga_arbiter_add_pci_device(pdev);
>> +	} while (pdev);
>>   
>>   	pr_info("loaded\n");
>>   	return rc;
>> -- 
>> 2.25.1
>>
