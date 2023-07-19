Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A5F759D39
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGSS0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGSS0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:26:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AAF1FC8;
        Wed, 19 Jul 2023 11:26:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54AD5617CB;
        Wed, 19 Jul 2023 18:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86513C433C8;
        Wed, 19 Jul 2023 18:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689791179;
        bh=6nmxXiiQH/ZgR/96VnW9bkCyBKJ7S68RVdSGVdB9E38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Z+u7r3i/0+xnn6FAc7NUsW8Tlb84OCb6IRrTAwcTC6JC+fOwa17/ERlpVm7bocSTv
         /x2ZvRb8KTK7MXBjgS3M0xtQV1V8R0Uwq1BTghd9MZH/kLdx56uCyDJzOoTMm1rj0L
         2+Co/0CcxzsUxq8TjzvfbgSIHMnMKEIaHgSvL2G3qi+A+qX+314ECd0CU3iROLETBF
         taaCSiqPZPVAlHbivih/xuF8ZB8DegYq2cw+Dy0e4GHQ4NkNwmGTrzfQ30SNH8xMD0
         ihLzwndiC1oPP+LujNtk+LElPQoisUEZBdffDOh2kOnF6Jyi1iFcw4ous5GoEZYrCA
         IVTVt+FhJVdpg==
Date:   Wed, 19 Jul 2023 13:26:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Sui@freedesktop.org,
        Jingfeng@loongson.cn, Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 2/6] PCI/VGA: Deal with PCI VGA compatible devices only
Message-ID: <20230719182617.GA509912@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711134354.755966-3-sui.jingfeng@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 09:43:50PM +0800, Sui Jingfeng wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> Currently, vgaarb only cares about PCI VGA-compatible class devices.
> 
> While vga_arbiter_del_pci_device() gets called unbalanced when some PCI
> device is about to be removed. This happens even during the boot process.

The previous code calls vga_arbiter_add_pci_device() for every device
(every device present at boot and also every hot-added device).  It
only allocates a vga_device if pdev->class is 0x0300XX.

It calls vga_arbiter_del_pci_device() for every device removal.  It
does nothing unless it finds a vga_device.

This seems symmetric and reasonable to me.  Did you observe a problem
with it?

> Another reason is that the vga_arb_device_init() function is not efficient.
> Since we only care about VGA-compatible devices (pdev->class == 0x030000),
> We could filter the unqualified devices out in the vga_arb_device_init()
> function. While the current implementation is to search all PCI devices
> in a system, this is not necessary.

Optimization is fine, but the most important thing here is to be clear
about what functional change this patch makes.  As I mentioned at [1], 
if this patch affects the class codes accepted, please make that clear
here.

> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>

I do not see Mario's Reviewed-by on the list.  I do see Mario's
Reviewed-by [2] for a previous version, but that version added this in
pci_notify():

  + if (pdev->class != PCI_CLASS_DISPLAY_VGA << 8)
  +   return 0;

while this version adds:

  + if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
  +   return 0;

It's OK to carry a review to future versions if there are
insignificant changes, but this is a functional change that seems
significant to me.  The first matches only 0x030000, while the second
discards the low eight bits so it matches 0x0300XX.

[1] https://lore.kernel.org/r/20230718231400.GA496927@bhelgaas
[2] https://lore.kernel.org/all/5b6fdf65-b354-94a9-f883-be820157efad@amd.com/

> ---
>  drivers/pci/vgaarb.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index c1bc6c983932..021116ed61cb 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -754,10 +754,6 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
>  	struct pci_dev *bridge;
>  	u16 cmd;
>  
> -	/* Only deal with VGA class devices */
> -	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
> -		return false;
> -
>  	/* Allocate structure */
>  	vgadev = kzalloc(sizeof(struct vga_device), GFP_KERNEL);
>  	if (vgadev == NULL) {
> @@ -1502,6 +1498,10 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
>  
>  	vgaarb_dbg(dev, "%s\n", __func__);
>  
> +	/* Deal with VGA compatible devices only */
> +	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
> +		return 0;
> +
>  	/* For now we're only intereted in devices added and removed. I didn't
>  	 * test this thing here, so someone needs to double check for the
>  	 * cases of hotplugable vga cards. */
> @@ -1534,8 +1534,8 @@ static struct miscdevice vga_arb_device = {
>  
>  static int __init vga_arb_device_init(void)
>  {
> +	struct pci_dev *pdev = NULL;
>  	int rc;
> -	struct pci_dev *pdev;
>  
>  	rc = misc_register(&vga_arb_device);
>  	if (rc < 0)
> @@ -1543,13 +1543,14 @@ static int __init vga_arb_device_init(void)
>  
>  	bus_register_notifier(&pci_bus_type, &pci_notifier);
>  
> -	/* We add all PCI devices satisfying VGA class in the arbiter by
> -	 * default */
> -	pdev = NULL;
> -	while ((pdev =
> -		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> -			       PCI_ANY_ID, pdev)) != NULL)
> -		vga_arbiter_add_pci_device(pdev);
> +	/*
> +	 * We add all PCI VGA compatible devices in the arbiter by default
> +	 */
> +	do {
> +		pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev);
> +		if (pdev)
> +			vga_arbiter_add_pci_device(pdev);
> +	} while (pdev);
>  
>  	pr_info("loaded\n");
>  	return rc;
> -- 
> 2.25.1
> 
