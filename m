Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004518038DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjLDPaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbjLDPaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:30:13 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625F0B0;
        Mon,  4 Dec 2023 07:30:19 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7344C0002;
        Mon,  4 Dec 2023 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701703818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lC9iyWjs9SLEvLAN2a3GzP/PTmAJHX40lkoy38ZLB0k=;
        b=bfXoqu1SHr+oH1qgM13BQ42PmdEr/OrtXWgYNyd4mi0IvjPKxdaXM34KEWtWo2ZPDDOaNN
        2aVnMnk3QAOsLzzljcSKG1BwvrSt8QFxEFnvdpGstNTny56/CtegMepgR6P5DbgsDkTxE3
        U3hIxUH+Na9u6pEOwjEZ7Iapj6uZ7fi9fpDVcHvTd1PkHItobDD4/Z94fhF8qYF4YivGEW
        8W6UEkCcCdLnW/88B1GPkQMNac7/XPvL11hI+nGeWh3Kof7ZjAegaV9lHL0u/DJ9Cb9qwL
        26suZIke97jSjH1eMR2uy7yugCsBW2JIkP6o9CbX713c9oVGJYR3Rd8CzYg6rw==
Date:   Mon, 4 Dec 2023 16:30:14 +0100
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
Message-ID: <20231204163014.4da383f2@bootlin.com>
In-Reply-To: <CAL_JsqLtCS3otZ1sfiPEWwrWB4dyNpu4e0xANWJriCEUYr+4Og@mail.gmail.com>
References: <20231130165700.685764-1-herve.codina@bootlin.com>
        <CAL_JsqJvt6FpXK+FgAwE8xN3G5Z23Ktq=SEY-K7VA7nM5XgZRg@mail.gmail.com>
        <20231204134335.3ded3d46@bootlin.com>
        <CAL_JsqLtCS3otZ1sfiPEWwrWB4dyNpu4e0xANWJriCEUYr+4Og@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, 4 Dec 2023 07:59:09 -0600
Rob Herring <robh@kernel.org> wrote:

[...]

> > > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > index 9c2137dae429..46b252bbe500 100644
> > > --- a/drivers/pci/bus.c
> > > +++ b/drivers/pci/bus.c
> > > @@ -342,8 +342,6 @@ void pci_bus_add_device(struct pci_dev *dev)
> > >          */
> > >         pcibios_bus_add_device(dev);
> > >         pci_fixup_device(pci_fixup_final, dev);
> > > -       if (pci_is_bridge(dev))
> > > -               of_pci_make_dev_node(dev);
> > >         pci_create_sysfs_dev_files(dev);
> > >         pci_proc_attach_device(dev);
> > >         pci_bridge_d3_update(dev);
> > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > index 51e3dd0ea5ab..e15eaf0127fc 100644
> > > --- a/drivers/pci/of.c
> > > +++ b/drivers/pci/of.c
> > > @@ -31,6 +31,8 @@ int pci_set_of_node(struct pci_dev *dev)
> > >                 return 0;
> > >
> > >         node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
> > > +       if (!node && pci_is_bridge(dev))
> > > +               of_pci_make_dev_node(dev);
> > >         if (!node)
> > >                 return 0;  
> >
> > Maybe it is too early.
> > of_pci_make_dev_node() creates a node and fills some properties based on
> > some already set values available in the PCI device such as its struct resource
> > values.
> > We need to have some values set by the PCI infra in order to create our DT node
> > with correct values.  
> 
> Indeed, that's probably the issue I'm having. In that case,
> DECLARE_PCI_FIXUP_HEADER should work. That's later, but still before
> device_add().
> 
> I think modifying sysfs after device_add() is going to race with
> userspace. Userspace is notified of a new device, and then the of_node
> link may or may not be there when it reads sysfs. Also, not sure if
> we'll need DT modaliases with PCI devices, but they won't work if the
> DT node is not set before device_add().

Ok, we can try using DECLARE_PCI_FIXUP_HEADER.
On your side, is moving from DECLARE_PCI_FIXUP_EARLY to DECLARE_PCI_FIXUP_HEADER
fix your QEMU unittest ?

We have to note that between the pci_fixup_device(pci_fixup_header, dev) call
and the device_add() call, the call to pci_set_msi_domain() is present.
MSIs are not supported currently but in the future ...

Related to DT modaliases, I don't think they are needed.
All drivers related to PCI device should be declared as pci_driver.
Correct me if I am wrong but I think that the core PCI will load the correct
module without any DT modalias.

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
