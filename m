Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6901B8016DD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjLAWtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAWtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:49:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E421E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:49:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FABC433C7;
        Fri,  1 Dec 2023 22:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701470970;
        bh=7UHBRH5A/rAUW8O3WYeKaOaOXX0+pl8vP8IIGkcTjO8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UvKxojd96ybvz4wCT9QMbUD7BYFKOW7L32k1cM25SmfLk6GBxSewQ5EydhsMm94us
         rygz+JfUakNQhTBUUoZVdDPJZbLsJOmsHmZcxkfXI74F+u5hHmYqcOFdSgYh+A3x59
         jkiHiPltMgj7x0VouBYtCgsE2dAgWul/msywmd8AhKr2goC5+57p0FTwkJfxIclrgU
         YP/WqlHhVtbEvhtLIJwTT0oAaL/v1k0YU0Vty1JTCYD1U6z+HOZzPcBat3lC0hGqGe
         Dey12bQ/+2mx2mUkRM4vY28KyXA1OpnRC9gHm2DBWfkJHK9GUMU6ggiR549HbVmcXk
         bu0iD+ZH2Vf5Q==
Date:   Fri, 1 Dec 2023 16:49:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lizhi Hou <lizhi.hou@amd.com>, Rob Herring <robh@kernel.org>,
        Max Zhen <max.zhen@amd.com>,
        Sonal Santan <sonal.santan@amd.com>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: of: Attach created of_node to existing device
Message-ID: <20231201224928.GA534494@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130165700.685764-3-herve.codina@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 05:56:59PM +0100, Herve Codina wrote:
> The commit 407d1a51921e ("PCI: Create device tree node for bridge")
> creates of_node for PCI devices.
> During the insertion handling of these new DT nodes done by of_platform,
> new devices (struct device) are created.
> For each PCI devices a struct device is already present (created and
> handled by the PCI core).
> Having a second struct device to represent the exact same PCI device is
> not correct.

Can you rewrap this or, if you intend multiple paragraphs, add blank
lines between them?

> On the of_node creation, tell the of_platform that there is no need to
> create a device for this node (OF_POPULATED flag), link this newly
> created of_node to the already present device and tell fwnode that the
> device attached to this of_node is ready (fwnode_dev_initialized()).
> 
> With this fix, the of_node are available in the sysfs device tree:
> /sys/devices/platform/soc/d0070000.pcie/
> + of_node -> .../devicetree/base/soc/pcie@d0070000
> + pci0000:00
>   + 0000:00:00.0
>     + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0
>     + 0000:01:00.0
>       + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0/dev@0,0
> 
> On the of_node removal, revert the operations.
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/pci/of.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 51e3dd0ea5ab..5afd2731e876 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -615,7 +615,8 @@ void of_pci_remove_node(struct pci_dev *pdev)
>  	np = pci_device_to_OF_node(pdev);
>  	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
>  		return;
> -	pdev->dev.of_node = NULL;
> +
> +	device_remove_of_node(&pdev->dev);
>  
>  	of_changeset_revert(np->data);
>  	of_changeset_destroy(np->data);
> @@ -668,12 +669,22 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  	if (ret)
>  		goto out_free_node;
>  
> +	/*
> +	 * This of_node will be added to an existing device.
> +	 * Avoid any device creation and use the existing device
> +	 */
> +	of_node_set_flag(np, OF_POPULATED);
> +	np->fwnode.dev = &pdev->dev;
> +	fwnode_dev_initialized(&np->fwnode, true);
> +
>  	ret = of_changeset_apply(cset);
>  	if (ret)
>  		goto out_free_node;
>  
>  	np->data = cset;
> -	pdev->dev.of_node = np;
> +
> +	/* Add the of_node to the existing device */
> +	device_add_of_node(&pdev->dev, np);
>  	kfree(name);
>  
>  	return;
> -- 
> 2.42.0
> 
