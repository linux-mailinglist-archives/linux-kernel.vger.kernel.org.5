Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D219C76911D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjGaJJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjGaJIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:08:54 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197C5186;
        Mon, 31 Jul 2023 02:08:50 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EEB1CE0002;
        Mon, 31 Jul 2023 09:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690794529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcszE+mRus1ZYk+zN3T731tEjsl9eXNhSgD9fO66n6E=;
        b=TB051yceR4fX2KlSXLZMUo4a6HgM/3a00F+F3zV/FaiiVs1VQaY5ukAArLs0BoZ3IR+9au
        ugJ/poQTESxCi+nXg3dfCyaLzOX0lpt3ChQMEFsD9WFEixYG2GwpL4D+FWDsXxM2UgniOF
        UxKQ4LP9SdO16Tc7giSQ36Vip6uvm69V+WdbHII++000L8ALnHvwC/nG2e022ytEN5Ru/b
        0UWnz4SgJXKj9RN23Xij0YkTghXQZUBTe7KwESjt7e/Qz37omS6RZAetiXciGfgN5+d6Fr
        54NZiN2Oq2Jo3UPpd/252VL9z/7vMrXF/zrZSQDOJEOASaopvr1cc7CL6TLleg==
Date:   Mon, 31 Jul 2023 11:08:45 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mtd: rawnand: add nand-skip-bbtscan and
 nand-no-bbm-quirk DT options
Message-ID: <20230731110845.7b6e52ea@xps-13>
In-Reply-To: <7448d35b-ce62-7e80-6467-ed929ad6838b@gmail.com>
References: <61c84262-cd98-1e60-d95b-9b0492083994@gmail.com>
        <2b0dc481-562f-c8df-545e-dcf6548adb07@gmail.com>
        <20230715175538.7142a141@xps-13>
        <7448d35b-ce62-7e80-6467-ed929ad6838b@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

jbx6244@gmail.com wrote on Mon, 17 Jul 2023 12:49:43 +0200:

> On 7/15/23 17:55, Miquel Raynal wrote:
> > Hi Johan,
> >=20
> > jbx6244@gmail.com wrote on Sat, 15 Jul 2023 12:49:18 +0200:
> >  =20
> >> A NAND chip can contain a different data format then the MTD framework
> >> expects in the erase blocks for the Bad Block Table(BBT).
> >> Result is a failed probe, while nothing wrong with the hardware.
> >> Some MTD flags need to be set to gain access again.
> >>
> >> Skip the automatic BBT scan with the NAND_SKIP_BBTSCAN option
> >> so that the original content is unchanged during the driver probe.
> >> The NAND_NO_BBM_QUIRK option allows us to erase bad blocks with
> >> the nand_erase_nand() function and the flash_erase command.
> >>
> >> Add nand-skip-bbtscan and nand-no-bbm-quirk Device Tree options,
> >> so the user has the "freedom of choice" by neutral
> >> access mode to read and write in whatever format is needed. =20
> >  =20
>=20
> > This sounds like a partial solution. How do you handle bad blocks? =20
>=20
> Hi Miquel,
>=20
> See below some Rockchip related links:
>=20
> The file rk_ftl_arm_v7.S is marked GPL2, so I can freely refer/decode/hac=
k to/in that.
> For rk3066 a closed source piece called usbplug is still needed to progra=
m initial U-boot.
> This usbplug contains similar code as in the S file and formats the NAND =
for FTL.=20
> U-boot is not small enough yet (WIP if I have the time) to replace that.
> Long story short is that on Rockchip NAND's we can expect pages with vari=
ous ECC and scrambled/randomized all over the place.
>=20
> One effect is that when the MTD framework driver is probed a first time t=
he BBT pages don't look what was expected.
> For this first probe to be successful I must be able to turn of the MTD i=
nternal BBT scan and then erase/format all blocks except boot blocks of cou=
rse.
> During this first run bad blocks are handled by/tested/kept track of/set =
BBM in user space.
> This is not meant as permanent mode.(except maybe if this S file is conve=
rted as open source FTL (WIP))
>=20
> Richard doesn't like module parameters, so I can't simply do modprobe for=
 example in a script.
> After that the whole kernel/MTD must rebooted without these DT options.

Richard, do you think we should support such use case? Any direction
would help.

> =20
> This patch does make parameters/flags available for all.
> If that is too much freedom to handle I can parse them in the Rockchip dr=
iver, let me know.
> =20
> Linux always gets away with the "it must be generic functionality" excuse.
> In U-boot there is the same driver with little or no interaction with the=
 user, so we must deal with that.
> Please advise how we can solve this in a simple nice automated way.
>=20
>=20
> Johan
>=20
> =3D=3D=3D
>=20
> function FlashSetRandomizer()
> https://github.com/rockchip-linux/kernel/blob/develop-4.4/drivers/rk_nand=
/rk_ftl_arm_v7.S#L120
> https://github.com/rockchip-linux/u-boot/blob/next-dev/drivers/rknand/rk_=
ftl_arm_v7.S#L199
>=20
> Proof of concept for U-boot:
> [v2,06/11] rockchip: idb: add randomizer option
> http://patchwork.ozlabs.org/project/uboot/patch/0b295d0e-53d6-b35a-3058-8=
61e203b4d83@gmail.com/
>=20
> >  =20
> >> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> >> ---
> >>
> >> Previous discussion:
> >> [PATCH v3 3/3] mtd: rawnand: rockchip-nand-controller: add skipbbt opt=
ion
> >> https://lore.kernel.org/linux-mtd/1618382560.2326931.1689261435022.Jav=
aMail.zimbra@nod.at/
> >> ---
> >>  drivers/mtd/nand/raw/nand_base.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/n=
and_base.c
> >> index a6af521832aa..f0fa5c3519b1 100644
> >> --- a/drivers/mtd/nand/raw/nand_base.c
> >> +++ b/drivers/mtd/nand/raw/nand_base.c
> >> @@ -5521,6 +5521,12 @@ static int rawnand_dt_init(struct nand_chip *ch=
ip)
> >>  	if (of_property_read_bool(dn, "nand-is-boot-medium"))
> >>  		chip->options |=3D NAND_IS_BOOT_MEDIUM;
> >>
> >> +	if (of_property_read_bool(dn, "nand-no-bbm-quirk"))
> >> +		chip->options |=3D NAND_NO_BBM_QUIRK;
> >> +
> >> +	if (of_property_read_bool(dn, "nand-skip-bbtscan"))
> >> +		chip->options |=3D NAND_SKIP_BBTSCAN;
> >> +
> >>  	if (of_property_read_bool(dn, "nand-on-flash-bbt"))
> >>  		chip->bbt_options |=3D NAND_BBT_USE_FLASH;
> >>
> >> --
> >> 2.30.2
> >> =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
