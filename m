Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883DA7B81FB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242868AbjJDOQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242770AbjJDOP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:15:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E81BF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:15:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FC7C433C7;
        Wed,  4 Oct 2023 14:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696428952;
        bh=YMXqF2086IHwMBRj5Tp+vck/KJO+L/Ns77eunTZpu38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uZz1Ace7zromvNOtNZ4hnSiqZPOUIaULVa4vxoBbHhvOuGOMTIOuIzV/RPeRnVWSz
         ciCvK8IxHezXNuDNVQfeTMV9cjOCh57h59zDgjLyBfpXnCttUtH0Qpzp04DbhIG5c2
         Tl2EQHyN9vyR4pWZEwlSL1LIPToxRkouQnigK3O6R1OUgRfR8bULuWJcZFenCNIKQu
         RaKjttfSLv1YS7L8yaDpVgYSE5HmDgAE6h6SPbdIaPKCJcbLKCYaqBgXCA/rT1zqZH
         QLrhs5eIEqqUf0A9OXNHbSfl62diFVdPccWV5hLZQlKyKvtE7I9oOdFxapi8AoZna0
         bL4v/mRfteS1g==
Received: (nullmailer pid 2947266 invoked by uid 1000);
        Wed, 04 Oct 2023 14:15:49 -0000
Date:   Wed, 4 Oct 2023 09:15:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Lizhi Hou <lizhi.hou@amd.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/1] of: address: Fix address translation when
 address-size is greater than 2
Message-ID: <20231004141549.GA2793277-robh@kernel.org>
References: <20231003065236.121987-1-herve.codina@bootlin.com>
 <CAL_Jsq+O245=TZQG5UsQS2xxBp0BRC2szg9vgbNsxKFBpPcvag@mail.gmail.com>
 <20231004110701.0c9aa467@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231004110701.0c9aa467@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 11:07:01AM +0200, Herve Codina wrote:
> On Tue, 3 Oct 2023 16:12:25 -0500
> Rob Herring <robh+dt@kernel.org> wrote:
> 
> > On Tue, Oct 3, 2023 at 1:53 AM Herve Codina <herve.codina@bootlin.com> wrote:
> > >
> > > With the recent addition of of_pci_prop_ranges() in commit 407d1a51921e
> > > ("PCI: Create device tree node for bridge"), the ranges property can
> > > have a 3 cells child address, a 3 cells parent address and a 2 cells
> > > child size.  
> > 
> > Sigh. I'm starting to regret applying this for 6.6... You failed to Cc
> > the AMD folks too. Lizhi now added.
> > 
> > What's different here from the test cases? The having 3 cells in
> > parent and child?
> 
> Are you talking about of_unittest_pci_node()?

That and there's a non-PCI one.

> I so, only BAR0 is used and the DT overlay  is
> 	fragment@0 {
> 		target-path="";
> 		__overlay__ {
> 			#address-cells = <3>;
> 			#size-cells = <2>;
> 			pci-ep-bus@0 {
> 				compatible = "simple-bus";
> 				#address-cells = <1>;
> 				#size-cells = <1>;
> 				ranges = <0x0 0x0 0x0 0x0 0x1000>;
> 				reg = <0 0 0 0 0>;
> 				unittest-pci@100 {
> 					compatible = "unittest-pci";
> 					reg = <0x100 0x200>;
> 				};
> 			};
> 		};
> 	};
> 
> > 
> > >
> > > A range item property for a PCI device is filled as follow:
> > >   <BAR_nbr> 0 0 <phys.hi> <phys.mid> <phys.low> <BAR_sizeh> <BAR_sizel>
> > >   <-- Child --> <-- Parent (PCI definition) --> <- BAR size (64bit) -->
> > >
> > > This allow to translate BAR addresses from the DT. For instance:
> > > pci@0,0 {
> > >   #address-cells = <0x03>;
> > >   #size-cells = <0x02>;
> > >   device_type = "pci";
> > >   compatible = "pci11ab,100\0pciclass,060400\0pciclass,0604";
> > >   ranges = <0x82000000 0x00 0xe8000000
> > >             0x82000000 0x00 0xe8000000
> > >             0x00 0x4400000>;
> > >   ...
> > >   dev@0,0 {
> > >     #address-cells = <0x03>;
> > >     #size-cells = <0x02>;
> > >     compatible = "pci1055,9660\0pciclass,020000\0pciclass,0200";
> > >     /* Translations for BAR0 to BAR5 */
> > >     ranges = <0x00 0x00 0x00 0x82010000 0x00 0xe8000000 0x00 0x2000000
> > >               0x01 0x00 0x00 0x82010000 0x00 0xea000000 0x00 0x1000000
> > >               0x02 0x00 0x00 0x82010000 0x00 0xeb000000 0x00 0x800000
> > >               0x03 0x00 0x00 0x82010000 0x00 0xeb800000 0x00 0x800000
> > >               0x04 0x00 0x00 0x82010000 0x00 0xec000000 0x00 0x20000
> > >               0x05 0x00 0x00 0x82010000 0x00 0xec020000 0x00 0x2000>;
> > >     ...
> > >     pci-ep-bus@0 {
> > >       #address-cells = <0x01>;
> > >       #size-cells = <0x01>;
> > >       compatible = "simple-bus";
> > >       /* Translate 0xe2000000 to BAR0 and 0xe0000000 to BAR1 */
> > >       ranges = <0xe2000000 0x00 0x00 0x00 0x20000000
> > >                 0xe0000000 0x01 0x00 0x00 0x1000000>;  
> > 
> > Why are you reusing a PCI bus address value for the child bus? I'm
> > wondering if this is some hackery because the child devices need PCI
> > addresses to work. What address does a device need for DMA for
> > example?
> 
> I don't think I re-use a PCI bus address.

Okay, I guess they happen to be similar. It depends on the host bridge, 
but often the PCI addresses are arbitrary. Often platforms just reuse 
the CPU address, but really they are independent.

> In my device datasheet, 0xe2000000 to 0xe3ffffff are mapped to BAR0 and
> 0xe0000000 to 0xe0FFFFFF are mapped to BAR1.
> And so, all devices use this kind of addresses in their 'reg' property.

Okay, your size is off. For 0xe2000000, you have 0x2000_0000 rather than 
0x0200_0000. (It would be good if this mistake triggered a warning)

> 
> > 
> > Also, I think each BAR should be a separate child. We need to
> > formalize this BAR addressing in a schema.
> 
> I am not sure that we should describe the hardware with a tree based on
> BAR. On my system, some devices use two BARs.
> For instance, I have a 'microchip,lan966x-switch'
> https://elixir.bootlin.com/linux/v6.5/source/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
> 
> This devices use two values (two reg set) for its reg property.
> On my system, this device is accessed through the PCI bus and one reg set
> should be accessed using BAR0 and the other set using BAR1.

Okay, if the h/w is like that, then I agree.

> 
> Having a tree based on BARs will break this kind of devices.
> 
> > 
> > >       ...
> > >     };
> > >   };
> > > };
> > >
> > > During the translation process, the "default-flags" map() function is
> > > used to select the matching item in the ranges table and determine the
> > > address offset from this matching item.
> > > This map() function simply calls of_read_number() and when address-size
> > > is greater than 2, the map() function skips the extra high address part
> > > (ie part over 64bit). This lead to a wrong matching item and a wrong
> > > offset computation.
> > > Also during the translation itself, the extra high part related to the
> > > parent address is not present in the translated address.
> > >
> > > Fix the "default-flags" map() and translate() in order to take into
> > > account the child extra high address part in map() and the parent extra
> > > high address part in translate() and so having a correct address
> > > translation for ranges patterns such as the one given in the example
> > > above.  
> > 
> > Please add a test case for this.
> 
> Should I add it in the of_unittest_pci_node() or create a new unittest
> dedicated to this translation test?

Extending the existing tests is fine. If you can make the non-PCI one 
fail, that would be better as it doesn't depend on the QEMU PCI test 
device.

Rob
