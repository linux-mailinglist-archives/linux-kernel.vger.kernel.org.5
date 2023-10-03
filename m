Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E897B6575
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjJCJ23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjJCJ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:28:28 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3859890
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:28:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19075240011;
        Tue,  3 Oct 2023 09:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696325302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LUpeZWYWn2dpMeICgIzJ1OnKQMz83J2Ptk+IlDZ7bZ0=;
        b=CcX5WgNZ/g86NLb2gp6kIt3CMp3RGip5kj1CmUPLesutlePOS5m9KX5nrR6vdLSVbXvbWV
        XyefnWVwl/wUYUgeivRrawjEBnO76yYGaudgjSuXDS6VG4lZ/l54pHuANstHsdLCEaO3e1
        Okz5E+nHaO7Ga2i/gfRJ+6Tj+OAIZT7031iRAi0yBzjSbNFpisS+IcZmyxEPwLmFKAsXho
        k0zr0MI59D2x0Q9GW3ERMMnITySpHjEKt9CtNumwuks94rfkRm7Pg05a9P1Gzw4o7Z3a/u
        dKE3+sT0X5PhkMSfwaG1/nHYEya+Axuu3KcGubHBe9dY/nIX2NSdb/2Oi3lETA==
Date:   Tue, 3 Oct 2023 11:28:19 +0200
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
Message-ID: <20231003112819.53707d54@xps-13>
In-Reply-To: <04350e70-6ef0-4998-664f-20b96b63b0f4@broadcom.com>
References: <trinity-bb7db9f1-d34d-4fe2-bed3-814d3a63476a-1694571881792@3c-app-mailcom-lxa03>
        <20230922162424.4a7b27ec@xps-13>
        <trinity-06dd34f4-ab26-4c60-bcf8-f986f1d08058-1696039055941@3c-app-mailcom-lxa04>
        <20231002143527.4ccf254a@xps-13>
        <04350e70-6ef0-4998-664f-20b96b63b0f4@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

william.zhang@broadcom.com wrote on Mon, 2 Oct 2023 12:57:01 -0700:

> Hi Miquel,
>=20
> On 10/02/2023 05:35 AM, Miquel Raynal wrote:
> > Hi David,
> >=20
> > dregan@mail.com wrote on Sat, 30 Sep 2023 03:57:35 +0200:
> >  =20
> >> Initial exec_op implementation for Broadcom STB, Broadband and iProc S=
oC
> >> This adds exec_op and removes the legacy interface.
> >>
> >> Signed-off-by: David Regan <dregan@mail.com>
> >> Reviewed-by: William Zhang <william.zhang@broadcom.com>
> >>
> >> ---
> >> =20
> >=20
> > ...
> >  =20
> >> +static int brcmnand_parser_exec_matched_op(struct nand_chip *chip,
> >> +					 const struct nand_subop *subop)
> >> +{
> >> +	struct brcmnand_host *host =3D nand_get_controller_data(chip);
> >> +	struct brcmnand_controller *ctrl =3D host->ctrl;
> >> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> >> +	const struct nand_op_instr *instr =3D &subop->instrs[0];
> >> +	unsigned int i;
> >> +	int ret =3D 0;
> >> +
> >> +	for (i =3D 0; i < subop->ninstrs; i++) {
> >> +		instr =3D &subop->instrs[i];
> >> +
> >> +		if ((instr->type =3D=3D NAND_OP_CMD_INSTR) &&
> >> +			(instr->ctx.cmd.opcode =3D=3D NAND_CMD_STATUS))
> >> +			ctrl->status_cmd =3D 1;
> >> +		else if (ctrl->status_cmd && (instr->type =3D=3D NAND_OP_DATA_IN_IN=
STR)) {
> >> +			/*
> >> +			 * need to fake the nand device write protect because nand_base do=
es a
> >> +			 * nand_check_wp which calls nand_status_op NAND_CMD_STATUS which =
checks
> >> +			 * that the nand is not write protected before an operation starts.
> >> +			 * The problem with this is it's done outside exec_op so the nand =
is
> >> +			 * write protected and this check will fail until the write or era=
se
> >> +			 * or write back operation actually happens where we turn off wp.
> >> +			 */
> >> +			u8 *in;
> >> +
> >> +			ctrl->status_cmd =3D 0;
> >> +
> >> +			instr =3D &subop->instrs[i];
> >> +			in =3D instr->ctx.data.buf.in;
> >> +			in[0] =3D brcmnand_status(host) | NAND_STATUS_WP; /* hide WP statu=
s */ =20
> >=20
> > I don't understand why you are faking the WP bit. If it's set,
> > brcmnand_status() should return it and you should not care about it. If
> > it's not however, can you please give me the path used when we have
> > this issue? Either we need to modify the core or we need to provide
> > additional helpers in this driver to circumvent the faulty path. =20
>=20
> The reason we have to hide wp status for status command is because
> nand_base calls nand_check_wp at the very beginning of write and erase
> function. This applies to both exec_op path and legacy path. With
> Broadcom nand controller and most of our board design using the WP pin
> and have it asserted by default, the nand_check_wp function will fail
> and write/erase aborts.  This workaround has been there before this
> exec_op patch.
>=20
> I agree it is ugly and better to be addressed in the nand base code. And
> I understand Broadcom's WP approach may sound a bit over cautious but we
> want to make sure no spurious erase/write can happen under any
> circumstance except software explicitly want to write and erase.  WP is
> standard nand chip pin and I think most the nand controller has that
> that pin in the design too but it is possible it is not used and
> bootloader can de-assert the pin and have a always-writable nand flash
> for linux. So maybe we can add nand controller dts option "nand-use-wp".
> If this property exist and set to 1,  wp control is in use and nand
> driver need to control the pin on/ff as needed when doing write and
> erase function. Also nand base code should not call nand_check_wp when
> wp is in use. Then we can remove the faking WP status workaround.
>=20
> >  =20
> >> +		} else if (instr->type =3D=3D NAND_OP_WAITRDY_INSTR) {
> >> +			ret =3D bcmnand_ctrl_poll_status(host, NAND_CTRL_RDY, NAND_CTRL_RD=
Y, 0);
> >> +			if (ctrl->wp_cmd) {
> >> +				ctrl->wp_cmd =3D 0;
> >> +				brcmnand_wp(mtd, 1); =20
> >=20
> > This ideally should disappear.
> >  =20
> Maybe we can have the destructive operation patch from Borris.
> Controller driver still need to assert/deassert the pin if it uses nand
> wp feature but at least it does not need to guess the op code.

Ah, yeah, I get it.

Please be my guest, you can revive this patch series (might need light
tweaking, nothing big) and also take inspiration from it if necessary:
https://github.com/bbrezillon/linux/commit/e612e1f2c69a33ac5f2c91d13669f0f1=
72d58717
https://github.com/bbrezillon/linux/commit/4ec6f8d8d83f5aaca5d1877f02d48da9=
6d41fcba
https://github.com/bbrezillon/linux/commit/11b4acffd761c4928652d7028d19fcd6=
f45e4696

Thanks,
Miqu=C3=A8l
