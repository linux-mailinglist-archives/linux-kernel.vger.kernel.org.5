Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE0C7B7B23
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241945AbjJDJHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241818AbjJDJHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:07:17 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EE9EA;
        Wed,  4 Oct 2023 02:07:05 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8420C1C001A;
        Wed,  4 Oct 2023 09:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696410424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HTImhnCBUlgVnxT2gov/gnz4eDUCQxkYZCNPZyxmkJA=;
        b=MwyGCsQGVsRylVpnHadTw8kEdGld09pYQYGlBx7ct7J4ONwlTxQkIcdp6tXrD1IdRJGuUU
        Apczz0FMbAcAY45od84+YTLTClyF8R64AeFSjYB9cMscNRrYfOglQFkSdW0bZkbsQ1IthV
        XHrrU1UJ/kyA3GHvXMJMAvZFx3yMgXpN5z20k/WL88J0LS344mTmgU2VU0EfX8HyPMLJpl
        siUD8rcvPZP/DAxyst1hNJyz20hdwCI9Lk7epz1/AGIODdNvy0zvfxFjjhDoFAzO7trhB6
        YyNPTIn7AQKl2OwLw3WH/aM2cfniJfJGz91LOUSqgSP54DhBROsAF5uWOBLu6g==
Date:   Wed, 4 Oct 2023 11:07:01 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lizhi Hou <lizhi.hou@amd.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/1] of: address: Fix address translation when
 address-size is greater than 2
Message-ID: <20231004110701.0c9aa467@bootlin.com>
In-Reply-To: <CAL_Jsq+O245=TZQG5UsQS2xxBp0BRC2szg9vgbNsxKFBpPcvag@mail.gmail.com>
References: <20231003065236.121987-1-herve.codina@bootlin.com>
        <CAL_Jsq+O245=TZQG5UsQS2xxBp0BRC2szg9vgbNsxKFBpPcvag@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2023 16:12:25 -0500
Rob Herring <robh+dt@kernel.org> wrote:

> On Tue, Oct 3, 2023 at 1:53 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > With the recent addition of of_pci_prop_ranges() in commit 407d1a51921e
> > ("PCI: Create device tree node for bridge"), the ranges property can
> > have a 3 cells child address, a 3 cells parent address and a 2 cells
> > child size.  
> 
> Sigh. I'm starting to regret applying this for 6.6... You failed to Cc
> the AMD folks too. Lizhi now added.
> 
> What's different here from the test cases? The having 3 cells in
> parent and child?

Are you talking about of_unittest_pci_node()?
I so, only BAR0 is used and the DT overlay  is
	fragment@0 {
		target-path="";
		__overlay__ {
			#address-cells = <3>;
			#size-cells = <2>;
			pci-ep-bus@0 {
				compatible = "simple-bus";
				#address-cells = <1>;
				#size-cells = <1>;
				ranges = <0x0 0x0 0x0 0x0 0x1000>;
				reg = <0 0 0 0 0>;
				unittest-pci@100 {
					compatible = "unittest-pci";
					reg = <0x100 0x200>;
				};
			};
		};
	};

> 
> >
> > A range item property for a PCI device is filled as follow:
> >   <BAR_nbr> 0 0 <phys.hi> <phys.mid> <phys.low> <BAR_sizeh> <BAR_sizel>
> >   <-- Child --> <-- Parent (PCI definition) --> <- BAR size (64bit) -->
> >
> > This allow to translate BAR addresses from the DT. For instance:
> > pci@0,0 {
> >   #address-cells = <0x03>;
> >   #size-cells = <0x02>;
> >   device_type = "pci";
> >   compatible = "pci11ab,100\0pciclass,060400\0pciclass,0604";
> >   ranges = <0x82000000 0x00 0xe8000000
> >             0x82000000 0x00 0xe8000000
> >             0x00 0x4400000>;
> >   ...
> >   dev@0,0 {
> >     #address-cells = <0x03>;
> >     #size-cells = <0x02>;
> >     compatible = "pci1055,9660\0pciclass,020000\0pciclass,0200";
> >     /* Translations for BAR0 to BAR5 */
> >     ranges = <0x00 0x00 0x00 0x82010000 0x00 0xe8000000 0x00 0x2000000
> >               0x01 0x00 0x00 0x82010000 0x00 0xea000000 0x00 0x1000000
> >               0x02 0x00 0x00 0x82010000 0x00 0xeb000000 0x00 0x800000
> >               0x03 0x00 0x00 0x82010000 0x00 0xeb800000 0x00 0x800000
> >               0x04 0x00 0x00 0x82010000 0x00 0xec000000 0x00 0x20000
> >               0x05 0x00 0x00 0x82010000 0x00 0xec020000 0x00 0x2000>;
> >     ...
> >     pci-ep-bus@0 {
> >       #address-cells = <0x01>;
> >       #size-cells = <0x01>;
> >       compatible = "simple-bus";
> >       /* Translate 0xe2000000 to BAR0 and 0xe0000000 to BAR1 */
> >       ranges = <0xe2000000 0x00 0x00 0x00 0x20000000
> >                 0xe0000000 0x01 0x00 0x00 0x1000000>;  
> 
> Why are you reusing a PCI bus address value for the child bus? I'm
> wondering if this is some hackery because the child devices need PCI
> addresses to work. What address does a device need for DMA for
> example?

I don't think I re-use a PCI bus address.
In my device datasheet, 0xe2000000 to 0xe3ffffff are mapped to BAR0 and
0xe0000000 to 0xe0FFFFFF are mapped to BAR1.
And so, all devices use this kind of addresses in their 'reg' property.

> 
> Also, I think each BAR should be a separate child. We need to
> formalize this BAR addressing in a schema.

I am not sure that we should describe the hardware with a tree based on
BAR. On my system, some devices use two BARs.
For instance, I have a 'microchip,lan966x-switch'
https://elixir.bootlin.com/linux/v6.5/source/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml

This devices use two values (two reg set) for its reg property.
On my system, this device is accessed through the PCI bus and one reg set
should be accessed using BAR0 and the other set using BAR1.

Having a tree based on BARs will break this kind of devices.

> 
> >       ...
> >     };
> >   };
> > };
> >
> > During the translation process, the "default-flags" map() function is
> > used to select the matching item in the ranges table and determine the
> > address offset from this matching item.
> > This map() function simply calls of_read_number() and when address-size
> > is greater than 2, the map() function skips the extra high address part
> > (ie part over 64bit). This lead to a wrong matching item and a wrong
> > offset computation.
> > Also during the translation itself, the extra high part related to the
> > parent address is not present in the translated address.
> >
> > Fix the "default-flags" map() and translate() in order to take into
> > account the child extra high address part in map() and the parent extra
> > high address part in translate() and so having a correct address
> > translation for ranges patterns such as the one given in the example
> > above.  
> 
> Please add a test case for this.

Should I add it in the of_unittest_pci_node() or create a new unittest
dedicated to this translation test?

> 
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/of/address.c | 56 ++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 54 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index e692809ff822..8665de3a6344 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -100,6 +100,58 @@ static unsigned int of_bus_default_get_flags(const __be32 *addr)
> >         return IORESOURCE_MEM;
> >  }
> >
> > +static bool of_addr_is_equal(const __be32 *addr1, const __be32 *addr2, int na)
> > +{
> > +       int i;
> > +       u32 a1;
> > +       u32 a2;
> > +
> > +       for (i = 0; i < na; i++) {
> > +               a1 = be32_to_cpup(addr1 + i);
> > +               a2 = be32_to_cpup(addr2 + i);  
> 
> You don't need to do the swap. Then isn't this just a memcmp?

Indeed, I will remove the swap in the next iteration.

> 
> > +               if (a1 == a2)
> > +                       continue;
> > +               return false;
> > +       }
> > +       return true;
> > +}
> > +
> > +static u64 of_bus_default_flags_map(__be32 *addr, const __be32 *range, int na,
> > +                                   int ns, int pna)
> > +{
> > +       u64 cp, s, da;
> > +       int extra = 0;
> > +
> > +       if (na > 2) {  
> 
> I believe this clause works for na==2. It wouldn't for na==1 though.
> All you really need is:
> 
> if (na == 3)
>   extra = 1;
> 
> But at this point, don't we know we have a 3rd cell? We've only
> matched if we do, right? If "extra" is always 1, then this function is
> pretty much the same as the PCI and ISA versions after the flags
> comparison.

Right.
I will simplify this function in the next iteration.

> 
> > +               /*
> > +                * Given address contains more than 2 cells.
> > +                * The address high extra part must match the range extra part
> > +                * and must be filtered-out from 64bit offset computation.
> > +                */
> > +               extra = na - 2;
> > +               if (!of_addr_is_equal(addr, range, extra))  
> 
> A bit misleading as all you are doing is comparing the 3rd (top) cell.

Will simplify.

> 
> > +                       return OF_BAD_ADDR;
> > +
> > +               cp = of_read_number(range + extra, na - extra);
> > +               s  = of_read_number(range + na + pna, ns);
> > +               da = of_read_number(addr + extra, na - extra);
> > +       } else {
> > +               cp = of_read_number(range, na);
> > +               s  = of_read_number(range + na + pna, ns);
> > +               da = of_read_number(addr, na);
> > +       }
> > +       pr_debug("default flags map, extra=%d cp=%llx, s=%llx, da=%llx\n", extra, cp, s, da);
> > +
> > +       if (da < cp || da >= (cp + s))
> > +               return OF_BAD_ADDR;
> > +       return da - cp;
> > +}
> > +
> > +static int of_bus_default_flags_translate(__be32 *addr, u64 offset, int na)  
> 
> Same as of_bus_pci_translate() and of_bus_isa_translate(). 3rd case
> gets to rename and consolidate.
> 
> > +{
> > +       /* Keep "flags" part in translated address */
> > +       return of_bus_default_translate(addr + 1, offset, na - 1);
> > +}

I would keep of_bus_default_flags_translate() and use this one for PCI and ISA
translation.
Indeed, I think the term default_flags_translate makes sense in PCI and ISA as

> >
> >  #ifdef CONFIG_PCI
> >  static unsigned int of_bus_pci_get_flags(const __be32 *addr)
> > @@ -374,8 +426,8 @@ static struct of_bus of_busses[] = {
> >                 .addresses = "reg",
> >                 .match = of_bus_default_flags_match,
> >                 .count_cells = of_bus_default_count_cells,
> > -               .map = of_bus_default_map,
> > -               .translate = of_bus_default_translate,
> > +               .map = of_bus_default_flags_map,
> > +               .translate = of_bus_default_flags_translate,
> >                 .has_flags = true,
> >                 .get_flags = of_bus_default_flags_get_flags,
> >         },
> > --
> > 2.41.0
> >  

Thanks for your feedback.

Best regards,
Hervé
