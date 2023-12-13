Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6230810B72
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjLMH00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjLMH0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:26:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED1EAD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:26:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9ADC433C7;
        Wed, 13 Dec 2023 07:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702452390;
        bh=76OJVqmnozrsnIZlwxGqTR/mpG0Abmmm32RAtiZ6W+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o7KlIn0S1Hpqs8X1x8ZQp5yK2Q09F2mVnQ56btuzJyny0Gewb2PB8TvdDEDW9BYYZ
         iGbx/j27UdO53hdQnvB2R4g3yV2Cbc50kAb64IwIOok0MYUsO0JjS8+xn1QmQCQ/Cf
         E85+4GrJzX66OeaX2QlF3E/9FcBnQk2dFgMGF3PI=
Date:   Wed, 13 Dec 2023 08:26:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        mst@redhat.com, rafael@kernel.org, lenb@kernel.org,
        bhelgaas@google.com, mika.westerberg@linux.intel.com,
        boris.ostrovsky@oracle.com, joe.jin@oracle.com,
        stable@vger.kernel.org, Fiona Ebner <f.ebner@proxmox.com>,
        Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: [RFC 2/2] PCI: acpiphp: slowdown hotplug if hotplugging multiple
 devices at a time
Message-ID: <2023121321-politely-creamer-fbad@gregkh>
References: <20231213003614.1648343-1-imammedo@redhat.com>
 <20231213003614.1648343-3-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213003614.1648343-3-imammedo@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 01:36:14AM +0100, Igor Mammedov wrote:
> previous commit ("PCI: acpiphp: enable slot only if it hasn't been enabled already"
> introduced a workaround to avoid a race between SCSI_SCAN_ASYNC job and
> bridge reconfiguration in case of single HBA hotplug.
> However in virt environment it's possible to pause machine hotplug several
> HBAs and let machine run. That can hit the same race when 2nd hotplugged
> HBA will start re-configuring bridge.
> Do the same thing as SHPC and throttle down hotplug of 2nd and up
> devices within single hotplug event.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 6b11609927d6..30bca2086b24 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -37,6 +37,7 @@
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> +#include <linux/delay.h>
>  
>  #include "../pci.h"
>  #include "acpiphp.h"
> @@ -700,6 +701,7 @@ static void trim_stale_devices(struct pci_dev *dev)
>  static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>  {
>  	struct acpiphp_slot *slot;
> +        int nr_hp_slots = 0;
>  
>  	/* Bail out if the bridge is going away. */
>  	if (bridge->is_going_away)
> @@ -723,6 +725,10 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>  
>  			/* configure all functions */
>  			if (slot->flags != SLOT_ENABLED) {
> +				if (nr_hp_slots)
> +					msleep(1000);
> +
> +                                ++nr_hp_slots;
>  				enable_slot(slot, true);
>  			}
>  		} else {
> -- 
> 2.39.3
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
