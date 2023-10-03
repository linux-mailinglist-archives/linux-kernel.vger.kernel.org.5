Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8758C7B7320
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbjJCVMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjJCVMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:12:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C750D7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:12:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF8AC433C9;
        Tue,  3 Oct 2023 21:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696367559;
        bh=l0FCnY5pU4umvfRCAPFiudSeIIRtVXn2RLWvb73Xh1w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JZ+hjmuTQJ6ZY1ZVp2rv2I8Y82Iw3KMHK8FM4ne8KNFdSbb0NlNMUN+Wt0Ao4lNaR
         vI6v2rguqIlmzLviz3UAZFs94zR8LmRjxkCGKGqIFVSI5ztp4dgjGgPQaCg2ImoQn4
         RFsxSJ4T7gb75RNvSJsoUurVoRoLvdVMMNfhP6QBbnLXI0TQlN+Fp3Lxoo5ynxkqlc
         z3hBniVPjdK+Z1X/LOi/xd7mjrQdaz2N9HzTa2C3Q66L/F9ZKQrohkvPrewWzc69PF
         X5lEAx3TvFGvegOcl6wxaNzazG4MFWasSY8CT/lE3ICCmBw0kBuiT1wDVfGMhT9W5Z
         8PQYoajkzkMTg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-503065c4b25so1709661e87.1;
        Tue, 03 Oct 2023 14:12:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YxNwPWbndYjWynFvUOVe3kjMJhAHrvbI2hndPMAV/2eQn+I1sqg
        RelIb22Uc6buaj9E8l6hvcRhverMOwjNVGG2ww==
X-Google-Smtp-Source: AGHT+IEI5Koj+rpPumZOdUd5lqY3ameNoqIdKlN4yxluWHb83LK1bdeZ/zS6p1KPV2LAQpn8xO+fisvS4yG5aWs3cyU=
X-Received: by 2002:a05:6512:3f18:b0:503:35bb:1e74 with SMTP id
 y24-20020a0565123f1800b0050335bb1e74mr297292lfa.61.1696367557235; Tue, 03 Oct
 2023 14:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231003065236.121987-1-herve.codina@bootlin.com>
In-Reply-To: <20231003065236.121987-1-herve.codina@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 3 Oct 2023 16:12:25 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+O245=TZQG5UsQS2xxBp0BRC2szg9vgbNsxKFBpPcvag@mail.gmail.com>
Message-ID: <CAL_Jsq+O245=TZQG5UsQS2xxBp0BRC2szg9vgbNsxKFBpPcvag@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: address: Fix address translation when
 address-size is greater than 2
To:     Herve Codina <herve.codina@bootlin.com>,
        Lizhi Hou <lizhi.hou@amd.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 1:53=E2=80=AFAM Herve Codina <herve.codina@bootlin.c=
om> wrote:
>
> With the recent addition of of_pci_prop_ranges() in commit 407d1a51921e
> ("PCI: Create device tree node for bridge"), the ranges property can
> have a 3 cells child address, a 3 cells parent address and a 2 cells
> child size.

Sigh. I'm starting to regret applying this for 6.6... You failed to Cc
the AMD folks too. Lizhi now added.

What's different here from the test cases? The having 3 cells in
parent and child?

>
> A range item property for a PCI device is filled as follow:
>   <BAR_nbr> 0 0 <phys.hi> <phys.mid> <phys.low> <BAR_sizeh> <BAR_sizel>
>   <-- Child --> <-- Parent (PCI definition) --> <- BAR size (64bit) -->
>
> This allow to translate BAR addresses from the DT. For instance:
> pci@0,0 {
>   #address-cells =3D <0x03>;
>   #size-cells =3D <0x02>;
>   device_type =3D "pci";
>   compatible =3D "pci11ab,100\0pciclass,060400\0pciclass,0604";
>   ranges =3D <0x82000000 0x00 0xe8000000
>             0x82000000 0x00 0xe8000000
>             0x00 0x4400000>;
>   ...
>   dev@0,0 {
>     #address-cells =3D <0x03>;
>     #size-cells =3D <0x02>;
>     compatible =3D "pci1055,9660\0pciclass,020000\0pciclass,0200";
>     /* Translations for BAR0 to BAR5 */
>     ranges =3D <0x00 0x00 0x00 0x82010000 0x00 0xe8000000 0x00 0x2000000
>               0x01 0x00 0x00 0x82010000 0x00 0xea000000 0x00 0x1000000
>               0x02 0x00 0x00 0x82010000 0x00 0xeb000000 0x00 0x800000
>               0x03 0x00 0x00 0x82010000 0x00 0xeb800000 0x00 0x800000
>               0x04 0x00 0x00 0x82010000 0x00 0xec000000 0x00 0x20000
>               0x05 0x00 0x00 0x82010000 0x00 0xec020000 0x00 0x2000>;
>     ...
>     pci-ep-bus@0 {
>       #address-cells =3D <0x01>;
>       #size-cells =3D <0x01>;
>       compatible =3D "simple-bus";
>       /* Translate 0xe2000000 to BAR0 and 0xe0000000 to BAR1 */
>       ranges =3D <0xe2000000 0x00 0x00 0x00 0x2000000
>                 0xe0000000 0x01 0x00 0x00 0x1000000>;

Why are you reusing a PCI bus address value for the child bus? I'm
wondering if this is some hackery because the child devices need PCI
addresses to work. What address does a device need for DMA for
example?

Also, I think each BAR should be a separate child. We need to
formalize this BAR addressing in a schema.

>       ...
>     };
>   };
> };
>
> During the translation process, the "default-flags" map() function is
> used to select the matching item in the ranges table and determine the
> address offset from this matching item.
> This map() function simply calls of_read_number() and when address-size
> is greater than 2, the map() function skips the extra high address part
> (ie part over 64bit). This lead to a wrong matching item and a wrong
> offset computation.
> Also during the translation itself, the extra high part related to the
> parent address is not present in the translated address.
>
> Fix the "default-flags" map() and translate() in order to take into
> account the child extra high address part in map() and the parent extra
> high address part in translate() and so having a correct address
> translation for ranges patterns such as the one given in the example
> above.

Please add a test case for this.

>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/of/address.c | 56 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index e692809ff822..8665de3a6344 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -100,6 +100,58 @@ static unsigned int of_bus_default_get_flags(const _=
_be32 *addr)
>         return IORESOURCE_MEM;
>  }
>
> +static bool of_addr_is_equal(const __be32 *addr1, const __be32 *addr2, i=
nt na)
> +{
> +       int i;
> +       u32 a1;
> +       u32 a2;
> +
> +       for (i =3D 0; i < na; i++) {
> +               a1 =3D be32_to_cpup(addr1 + i);
> +               a2 =3D be32_to_cpup(addr2 + i);

You don't need to do the swap. Then isn't this just a memcmp?

> +               if (a1 =3D=3D a2)
> +                       continue;
> +               return false;
> +       }
> +       return true;
> +}
> +
> +static u64 of_bus_default_flags_map(__be32 *addr, const __be32 *range, i=
nt na,
> +                                   int ns, int pna)
> +{
> +       u64 cp, s, da;
> +       int extra =3D 0;
> +
> +       if (na > 2) {

I believe this clause works for na=3D=3D2. It wouldn't for na=3D=3D1 though=
.
All you really need is:

if (na =3D=3D 3)
  extra =3D 1;

But at this point, don't we know we have a 3rd cell? We've only
matched if we do, right? If "extra" is always 1, then this function is
pretty much the same as the PCI and ISA versions after the flags
comparison.

> +               /*
> +                * Given address contains more than 2 cells.
> +                * The address high extra part must match the range extra=
 part
> +                * and must be filtered-out from 64bit offset computation=
.
> +                */
> +               extra =3D na - 2;
> +               if (!of_addr_is_equal(addr, range, extra))

A bit misleading as all you are doing is comparing the 3rd (top) cell.

> +                       return OF_BAD_ADDR;
> +
> +               cp =3D of_read_number(range + extra, na - extra);
> +               s  =3D of_read_number(range + na + pna, ns);
> +               da =3D of_read_number(addr + extra, na - extra);
> +       } else {
> +               cp =3D of_read_number(range, na);
> +               s  =3D of_read_number(range + na + pna, ns);
> +               da =3D of_read_number(addr, na);
> +       }
> +       pr_debug("default flags map, extra=3D%d cp=3D%llx, s=3D%llx, da=
=3D%llx\n", extra, cp, s, da);
> +
> +       if (da < cp || da >=3D (cp + s))
> +               return OF_BAD_ADDR;
> +       return da - cp;
> +}
> +
> +static int of_bus_default_flags_translate(__be32 *addr, u64 offset, int =
na)

Same as of_bus_pci_translate() and of_bus_isa_translate(). 3rd case
gets to rename and consolidate.

> +{
> +       /* Keep "flags" part in translated address */
> +       return of_bus_default_translate(addr + 1, offset, na - 1);
> +}
>
>  #ifdef CONFIG_PCI
>  static unsigned int of_bus_pci_get_flags(const __be32 *addr)
> @@ -374,8 +426,8 @@ static struct of_bus of_busses[] =3D {
>                 .addresses =3D "reg",
>                 .match =3D of_bus_default_flags_match,
>                 .count_cells =3D of_bus_default_count_cells,
> -               .map =3D of_bus_default_map,
> -               .translate =3D of_bus_default_translate,
> +               .map =3D of_bus_default_flags_map,
> +               .translate =3D of_bus_default_flags_translate,
>                 .has_flags =3D true,
>                 .get_flags =3D of_bus_default_flags_get_flags,
>         },
> --
> 2.41.0
>
