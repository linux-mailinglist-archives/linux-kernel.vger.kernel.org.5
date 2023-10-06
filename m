Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCAB7BB2A3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 09:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjJFHuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 03:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjJFHuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 03:50:13 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A66FC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 00:42:51 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A4A91C0008;
        Fri,  6 Oct 2023 07:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696578170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQFwrUeYJEDlw/TSLgMcUD55L/pInUxyhSLEs5AXqms=;
        b=VJLR3AQC9+1xKQjLSwdQ3raBHu845I2YoP2u6Ky5XHpnYjv9gz2yDZOTA2zeNg2Ha+mlSy
        nn9CdZ7cU8OXPxk9ga5Iw8dH+anBW82dAHFHiS9fCWJ5dUe0zFXn6DMCNN4s/H1loT+RKo
        vk1rOFzpcUJ9X6AC+JxF7TvGKfAl5RIpvgdf5bIXvkqj5U7fcWz0CvutHgQp9ZLzzUb9ad
        0+ZmBBpPlUS4W+xepzpoDXTcUk7oCg4hoif52eV7dDNo01pkzoA6a1dqU2Fk1US/dvykxX
        SY2xAMQbak5GwswsSADneVcE8RN3bSNS5o4tvsYSxMB7DCnbBm7sM5XAcuI+ng==
Date:   Fri, 6 Oct 2023 09:42:45 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     dregan@mail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, joel.peshkin@broadcom.com,
        computersforpeace@gmail.com, dan.beygelman@broadcom.com,
        frieder.schrempf@kontron.de, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, richard@nod.at, bbrezillon@kernel.org,
        kdasu.kdev@gmail.com
Subject: Re: [PATCH v2] mtd: rawnand: brcmnand: Initial exec_op
 implementation
Message-ID: <20231006094245.6cc24e03@xps-13>
In-Reply-To: <0c72dbb4-8ee5-c9b0-b029-9689e9d72f5e@broadcom.com>
References: <trinity-bb7db9f1-d34d-4fe2-bed3-814d3a63476a-1694571881792@3c-app-mailcom-lxa03>
        <20230922162424.4a7b27ec@xps-13>
        <trinity-06dd34f4-ab26-4c60-bcf8-f986f1d08058-1696039055941@3c-app-mailcom-lxa04>
        <20231002143527.4ccf254a@xps-13>
        <04350e70-6ef0-4998-664f-20b96b63b0f4@broadcom.com>
        <20231003112819.53707d54@xps-13>
        <37416f2e-f150-cc8f-76bd-3d54f9e25d08@broadcom.com>
        <20231004005525.3f406823@xps-13>
        <0f6bd61c-19ed-8153-1763-eef2498726c7@broadcom.com>
        <0c72dbb4-8ee5-c9b0-b029-9689e9d72f5e@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

william.zhang@broadcom.com wrote on Thu, 5 Oct 2023 17:42:21 -0700:

> Hi Miquel,
>=20
> On 10/03/2023 09:47 PM, William Zhang wrote:
> >=20
> >=20
> > On 10/03/2023 03:55 PM, Miquel Raynal wrote: =20
> >> Hi William,
> >>
> >> william.zhang@broadcom.com wrote on Tue, 3 Oct 2023 11:46:25 -0700:
> >> =20
> >>> Hi Miquel,
> >>>
> >>> On 10/03/2023 02:28 AM, Miquel Raynal wrote: =20
> >>>> Hi William,
> >>>>
> >>>> william.zhang@broadcom.com wrote on Mon, 2 Oct 2023 12:57:01 -0700: =
=20
> >>>>> Hi Miquel,
> >>>>>
> >>>>> On 10/02/2023 05:35 AM, Miquel Raynal wrote: =20
> >>>>>> Hi David,
> >>>>>>
> >>>>>> dregan@mail.com wrote on Sat, 30 Sep 2023 03:57:35 +0200:
> >>>>>> =C2=A0=C2=A0=C2=A0 >>>> Initial exec_op implementation for Broadco=
m STB, >>>>>> Broadband and iProc SoC =20
> >>>>>>> This adds exec_op and removes the legacy interface.
> >>>>>>>
> >>>>>>> Signed-off-by: David Regan <dregan@mail.com>
> >>>>>>> Reviewed-by: William Zhang <william.zhang@broadcom.com>
> >>>>>>>
> >>>>>>> ---
> >>>>>>> =C2=A0=C2=A0 >>> =20
> >>>>>> ...
> >>>>>> =C2=A0=C2=A0=C2=A0 >>>> +static int brcmnand_parser_exec_matched_o=
p(struct >>>>>> nand_chip *chip, =20
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct nand=
_subop *subop)
> >>>>>>> +{
> >>>>>>> +=C2=A0=C2=A0=C2=A0 struct brcmnand_host *host =3D nand_get_contr=
oller_data(chip);
> >>>>>>> +=C2=A0=C2=A0=C2=A0 struct brcmnand_controller *ctrl =3D host->ct=
rl;
> >>>>>>> +=C2=A0=C2=A0=C2=A0 struct mtd_info *mtd =3D nand_to_mtd(chip);
> >>>>>>> +=C2=A0=C2=A0=C2=A0 const struct nand_op_instr *instr =3D &subop-=
>instrs[0];
> >>>>>>> +=C2=A0=C2=A0=C2=A0 unsigned int i;
> >>>>>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
> >>>>>>> +
> >>>>>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < subop->ninstrs; i++) {
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 instr =3D &subop->ins=
trs[i];
> >>>>>>> +
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((instr->type =3D=
=3D NAND_OP_CMD_INSTR) &&
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (instr->ctx.cmd.opcode =3D=3D NAND_CMD_STATUS))
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ctrl->status_cmd =3D 1;
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (ctrl->status=
_cmd && (instr->type =3D=3D >>>>>>> NAND_OP_DATA_IN_INSTR)) {
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /*
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * need to fake the nand device write protect >>>>>>> because nand=
_base does a
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * nand_check_wp which calls nand_status_op >>>>>>> NAND_CMD_STATU=
S which checks
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * that the nand is not write protected before an >>>>>>> operatio=
n starts.
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * The problem with this is it's done outside >>>>>>> exec_op so t=
he nand is
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * write protected and this check will fail until >>>>>>> the writ=
e or erase
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * or write back operation actually happens where we >>>>>>> turn =
off wp.
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 */
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 u8 *in;
> >>>>>>> +
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ctrl->status_cmd =3D 0;
> >>>>>>> +
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 instr =3D &subop->instrs[i];
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 in =3D instr->ctx.data.buf.in;
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 in[0] =3D brcmnand_status(host) | NAND_STATUS_WP; /* >>>>>>> hide WP st=
atus */ =20
> >>>>>>
> >>>>>> I don't understand why you are faking the WP bit. If it's set,
> >>>>>> brcmnand_status() should return it and you should not care about >=
>>>>> it. If
> >>>>>> it's not however, can you please give me the path used when we have
> >>>>>> this issue? Either we need to modify the core or we need to provide
> >>>>>> additional helpers in this driver to circumvent the faulty path. =
=20
> >>>>>
> >>>>> The reason we have to hide wp status for status command is because
> >>>>> nand_base calls nand_check_wp at the very beginning of write and er=
ase
> >>>>> function. This applies to both exec_op path and legacy path. With
> >>>>> Broadcom nand controller and most of our board design using the WP =
pin
> >>>>> and have it asserted by default, the nand_check_wp function will fa=
il
> >>>>> and write/erase aborts.=C2=A0 This workaround has been there before=
 this
> >>>>> exec_op patch.
> >>>>>
> >>>>> I agree it is ugly and better to be addressed in the nand base >>>>=
> code. And
> >>>>> I understand Broadcom's WP approach may sound a bit over cautious >=
>>>> but we
> >>>>> want to make sure no spurious erase/write can happen under any
> >>>>> circumstance except software explicitly want to write and erase.  >=
>>>> WP is
> >>>>> standard nand chip pin and I think most the nand controller has that
> >>>>> that pin in the design too but it is possible it is not used and
> >>>>> bootloader can de-assert the pin and have a always-writable nand fl=
ash
> >>>>> for linux. So maybe we can add nand controller dts option >>>>> "na=
nd-use-wp".
> >>>>> If this property exist and set to 1,=C2=A0 wp control is in use and=
 nand
> >>>>> driver need to control the pin on/ff as needed when doing write and
> >>>>> erase function. Also nand base code should not call nand_check_wp w=
hen
> >>>>> wp is in use. Then we can remove the faking WP status workaround. =
=20
> >>>>>> =C2=A0=C2=A0=C2=A0 >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 } else if (instr->type =3D=3D NAND_OP_WAITRDY_INSTR) { =20
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D bcmnand_ctrl_poll_status(host, NAND_CTRL_RDY, >>>>>>> NAND_CTRL=
_RDY, 0);
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ctrl->wp_cmd) {
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctrl->wp_cmd =3D 0;
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 brcmnand_wp(mtd, 1); =20
> >>>>>>
> >>>>>> This ideally should disappear.
> >>>>>> =C2=A0=C2=A0=C2=A0 >> Maybe we can have the destructive operation =
patch from Borris. =20
> >>>>> Controller driver still need to assert/deassert the pin if it uses =
>>>>> nand
> >>>>> wp feature but at least it does not need to guess the op code. =20
> >>>>
> >>>> Ah, yeah, I get it.
> >>>>
> >>>> Please be my guest, you can revive this patch series (might need lig=
ht
> >>>> tweaking, nothing big) and also take inspiration from it if necessar=
y:
> >>>> https://github.com/bbrezillon/linux/commit/e612e1f2c69a33ac5f2c91d13=
669f0f172d58717 >>>>
> >>>> https://github.com/bbrezillon/linux/commit/4ec6f8d8d83f5aaca5d1877f0=
2d48da96d41fcba >>>>
> >>>> https://github.com/bbrezillon/linux/commit/11b4acffd761c4928652d7028=
d19fcd6f45e4696 >>>> =20
> >>> Sure we will incorporate the destructive operation patch and provide a
> >>> new revision.
> >>>
> >>> The WP status workaround will stay at least for this change. If you
> >>> think my suggestion using a dts setting above is okay, we can provide=
 a
> >>> patch for that as well.=C2=A0 Or if you have any other idea or sugges=
tion,
> >>> we'd like to hear too. =20
> >>
> >> I thought this was not needed as Boris initial conversion did not need
> >> it. The goal is to get rid of this workaround.
> >> Boris' initial patch did remove that workaround but it will break the =
=20
> > board that uses WP pin because the nand_check_wp run before the exec_op=
 > and status returned is write-protected in the erase and write function.
> > I explained that above and you can see the code here:
> > https://elixir.bootlin.com/linux/v6.6-rc4/source/drivers/mtd/nand/raw/n=
and_base.c#L4599 > >=20
> > I agree with your goal to remove this workaround and we have suggested
> > one possible fix but we are also open to any other solution.
> >  =20
> We have integrated the destructive operation patch and are ready for the
> v3.  If you don't think my proposal on the WP status fix is a good idea,
> can we get this exce_op conversion patch series going first?  After all,
> we don't modify the WP status handling behavior in this patch. We can
> fix it in another patch whenever we agree on a solution.  Please let me
> know and thanks a lot for all your comments and thoughts.

The NAND core has been a playground for coding horrors sometimes, and
this ->exec_op() conversion is us the way to a cleaner and mastered
approach, I am not willing to let something that obvious get in, I'm
sorry. For you it's just a workaround, for me it means any change in
the core will just break with this controller.

This is of course not against you or your work, perhaps I should
emphasize that I strongly appreciate your efforts and, besides this
workaround the code is clean.

The problem is that the WP pin can be used in two different ways:
internally and externally. When it's used externally, you expect it
to be deasserted before you start a destructive operation. When you use
it internally, you expect it to be deasserted during the destructive
operation.

The final solution needs to be approved by comparing with
similar drivers which perform this internal procedure themselves
as well. Maybe we could add a flag somewhere in the core's controller
structure to tell the core not to perform these checks as we master the
handling of the WP pin, telling the controller will handle it
correctly as long as the destructive flag is passed.

Thanks, Miqu=C3=A8l
