Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E6E803340
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjLDMng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:43:34 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C452883;
        Mon,  4 Dec 2023 04:43:39 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 70DF72000D;
        Mon,  4 Dec 2023 12:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701693818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1DfrWvoIhnqIrBmnbQT3pjCFnN3Mxl0X/IRcdWInnY=;
        b=oO/nVy4DEOF4v/suLVoDkaVWWWnRV7ee/hieNCOY4iauBMq4ThTBlqhQs8btv6g8/l8jpW
        f18qVODj2QLwoE/kMhiR8dDJwP8x3LxJI1BfDO918zL4GWgEOy6UZVEfWKhdUyMgYn1myp
        ibOuIHRQsFokadpkBNyqKmbTPQBYO2vMry2RDMjAfjp0NQi2Czl4ZqmHwMHNoaO6mnMiHG
        7xwqxiH9ZYqqsa+w25GLDUdBkYoxD6afxJVstun7bbsqzN0RZVsZLLiOcs9v7mp1Iguxmn
        /9p534+gyTW1fdXg/kXbpDqlEjUjEOdfVo0C/7nLqr5OhCrHwUpTkNpEYL2F6g==
Date:   Mon, 4 Dec 2023 13:43:35 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>,
        Sonal Santan <sonal.santan@amd.com>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 0/2] Attach DT nodes to existing PCI devices
Message-ID: <20231204134335.3ded3d46@bootlin.com>
In-Reply-To: <CAL_JsqJvt6FpXK+FgAwE8xN3G5Z23Ktq=SEY-K7VA7nM5XgZRg@mail.gmail.com>
References: <20231130165700.685764-1-herve.codina@bootlin.com>
        <CAL_JsqJvt6FpXK+FgAwE8xN3G5Z23Ktq=SEY-K7VA7nM5XgZRg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, 1 Dec 2023 16:26:45 -0600
Rob Herring <robh@kernel.org> wrote:

> On Thu, Nov 30, 2023 at 10:57 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Hi,
> >
> > The commit 407d1a51921e ("PCI: Create device tree node for bridge")
> > creates of_node for PCI devices.
> > During the insertion handling of these new DT nodes done by of_platform,
> > new devices (struct device) are created.
> > For each PCI devices a struct device is already present (created and
> > handled by the PCI core).
> > Creating a new device from a DT node leads to some kind of wrong struct
> > device duplication to represent the exact same PCI device.
> >
> > This patch series first introduces device_{add,remove}_of_node() in
> > order to add or remove a newly created of_node to an already existing
> > device.
> > Then it fixes the DT node creation for PCI devices to add or remove the
> > created node to the existing PCI device without any new device creation.  
> 
> I think the simpler solution is to get the DT node created earlier. We
> are just asking for pain if the DT node is set for the device at
> different times compared to static DT nodes.
> 
> The following fixes the lack of of_node link. The DT unittest fails
> with the change though and I don't see why.
> 
> Also, no idea if the bridge part works because my qemu setup doesn't
> create bridges (anyone got a magic cmdline to create them?).
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 9c2137dae429..46b252bbe500 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -342,8 +342,6 @@ void pci_bus_add_device(struct pci_dev *dev)
>          */
>         pcibios_bus_add_device(dev);
>         pci_fixup_device(pci_fixup_final, dev);
> -       if (pci_is_bridge(dev))
> -               of_pci_make_dev_node(dev);
>         pci_create_sysfs_dev_files(dev);
>         pci_proc_attach_device(dev);
>         pci_bridge_d3_update(dev);
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 51e3dd0ea5ab..e15eaf0127fc 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -31,6 +31,8 @@ int pci_set_of_node(struct pci_dev *dev)
>                 return 0;
> 
>         node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
> +       if (!node && pci_is_bridge(dev))
> +               of_pci_make_dev_node(dev);
>         if (!node)
>                 return 0;

Maybe it is too early.
of_pci_make_dev_node() creates a node and fills some properties based on 
some already set values available in the PCI device such as its struct resource
values.
We need to have some values set by the PCI infra in order to create our DT node
with correct values.

Best regards,
Hervé

> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ea476252280a..e50b07fe5a63 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6208,9 +6208,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
> 0x9a31, dpc_log_size);
>   * before driver probing, it might need to add a device tree node as the final
>   * fixup.
>   */
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
> 
>  /*
>   * Devices known to require a longer delay before first config space access

