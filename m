Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC1A7B534F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbjJBMfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbjJBMfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:35:36 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38B383
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:35:32 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 023FAC000C;
        Mon,  2 Oct 2023 12:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696250131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNMuGJL44gj1ZB3e/uIcPx32jrKTbp3WUjy5cGFxIrI=;
        b=UaYnoZbI9nCRnp+/H4oltdkSs70wxX+I01PxntZGZZYeYIJCrGKSNK5eg7y892Qh6Eolct
        30aCRk5yz1i4cV5BBApon3dVHnya7+DDwsjYzfDsxW5UGL0Y38C3656zFcjExO3zNvfsKx
        XzBkxnFwIGfE3b8uN4lCuP0/OCwHinymBiscuCF3/vXjTyhyV+uWtatIj1ZJP/Zwx36rhD
        ONhPESCrNSzZruBIJtCyK73GNT1cY9eQmyP89tNSMqjw9DOx2cS3sclxSqwDmH9735hEsd
        oTriY9YKyORJbbr24sw1CqZEczeb6FagqrBM8fcpCtTsKynVd3umVkFdRi5PAw==
Date:   Mon, 2 Oct 2023 14:35:27 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     dregan@mail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, joel.peshkin@broadcom.com,
        computersforpeace@gmail.com, dan.beygelman@broadcom.com,
        william.zhang@broadcom.com, frieder.schrempf@kontron.de,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, richard@nod.at,
        bbrezillon@kernel.org, kdasu.kdev@gmail.com
Subject: Re: [PATCH v2] mtd: rawnand: brcmnand: Initial exec_op
 implementation
Message-ID: <20231002143527.4ccf254a@xps-13>
In-Reply-To: <trinity-06dd34f4-ab26-4c60-bcf8-f986f1d08058-1696039055941@3c-app-mailcom-lxa04>
References: <trinity-bb7db9f1-d34d-4fe2-bed3-814d3a63476a-1694571881792@3c-app-mailcom-lxa03>
 <20230922162424.4a7b27ec@xps-13>
 <trinity-06dd34f4-ab26-4c60-bcf8-f986f1d08058-1696039055941@3c-app-mailcom-lxa04>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

dregan@mail.com wrote on Sat, 30 Sep 2023 03:57:35 +0200:

> Initial exec_op implementation for Broadcom STB, Broadband and iProc SoC
> This adds exec_op and removes the legacy interface.
>=20
> Signed-off-by: David Regan <dregan@mail.com>
> Reviewed-by: William Zhang <william.zhang@broadcom.com>
>=20
> ---
>=20

...

> +static int brcmnand_parser_exec_matched_op(struct nand_chip *chip,
> +					 const struct nand_subop *subop)
> +{
> +	struct brcmnand_host *host =3D nand_get_controller_data(chip);
> +	struct brcmnand_controller *ctrl =3D host->ctrl;
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	const struct nand_op_instr *instr =3D &subop->instrs[0];
> +	unsigned int i;
> +	int ret =3D 0;
> +
> +	for (i =3D 0; i < subop->ninstrs; i++) {
> +		instr =3D &subop->instrs[i];
> +
> +		if ((instr->type =3D=3D NAND_OP_CMD_INSTR) &&
> +			(instr->ctx.cmd.opcode =3D=3D NAND_CMD_STATUS))
> +			ctrl->status_cmd =3D 1;
> +		else if (ctrl->status_cmd && (instr->type =3D=3D NAND_OP_DATA_IN_INSTR=
)) {
> +			/*
> +			 * need to fake the nand device write protect because nand_base does a
> +			 * nand_check_wp which calls nand_status_op NAND_CMD_STATUS which che=
cks
> +			 * that the nand is not write protected before an operation starts.
> +			 * The problem with this is it's done outside exec_op so the nand is
> +			 * write protected and this check will fail until the write or erase
> +			 * or write back operation actually happens where we turn off wp.
> +			 */
> +			u8 *in;
> +
> +			ctrl->status_cmd =3D 0;
> +
> +			instr =3D &subop->instrs[i];
> +			in =3D instr->ctx.data.buf.in;
> +			in[0] =3D brcmnand_status(host) | NAND_STATUS_WP; /* hide WP status */

I don't understand why you are faking the WP bit. If it's set,
brcmnand_status() should return it and you should not care about it. If
it's not however, can you please give me the path used when we have
this issue? Either we need to modify the core or we need to provide
additional helpers in this driver to circumvent the faulty path.

> +		} else if (instr->type =3D=3D NAND_OP_WAITRDY_INSTR) {
> +			ret =3D bcmnand_ctrl_poll_status(host, NAND_CTRL_RDY, NAND_CTRL_RDY, =
0);
> +			if (ctrl->wp_cmd) {
> +				ctrl->wp_cmd =3D 0;
> +				brcmnand_wp(mtd, 1);

This ideally should disappear.

> +			}
> +		} else { /* otherwise pass to low level implementation */
> +			if ((instr->type =3D=3D NAND_OP_CMD_INSTR) &&
> +				(instr->ctx.cmd.opcode =3D=3D NAND_CMD_RESET)) {
> +				brcmnand_status(host);
> +				ctrl->status_cmd =3D 0;
> +				ctrl->wp_cmd =3D 0;
> +				brcmnand_wp(mtd, 1);

Same

> +			}
> +
> +			if ((instr->type =3D=3D NAND_OP_CMD_INSTR) &&
> +				((instr->ctx.cmd.opcode =3D=3D NAND_CMD_ERASE1) ||
> +				(instr->ctx.cmd.opcode =3D=3D NAND_CMD_SEQIN))) {
> +				brcmnand_wp(mtd, 0);
> +				ctrl->wp_cmd =3D 1;

Same

> +			}
> +
> +			ret =3D brcmnand_exec_instr(host, instr, i =3D=3D (subop->ninstrs - 1=
));
> +		}
> +	}
> +
> +	return ret;
> +}



Thanks,
Miqu=C3=A8l
