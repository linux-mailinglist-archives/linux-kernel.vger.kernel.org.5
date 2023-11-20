Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9637F105F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjKTK2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjKTK22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:28:28 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336BFD51
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:28:21 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1EE55C000C;
        Mon, 20 Nov 2023 10:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700476099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6E0UQ9FmojGlOqNPoGhTA5IFG2wg+7A9OzJneyMdeI8=;
        b=hoUPSXarh/RJ8Opj9F17Qax6XFWXsAOt5m7/l8Rrt3TnySvVQXpyoBA7E6iN9NjcmCcBAq
        d6AENXCO19FSV44vI2r4Ul+mz/lEpMXdo9s8yTqZ0mWOavxxF5RP0awhDpre8F3t70N/JF
        ag8rCQ4ozLDLMT5lNgD9OUp7yJE308I/8dNHAB4Ds/DhynqJdAF+KMU10oxiXeFuX4f/9V
        tbG8QCw/uMTQKW5Ddcun7y3/srF9RszdhpFxpS+XBOWIofJkb+X369eioCu6VpsFpIZo3u
        dQnht89BvfPEia+qKFdWMb/pQKTSP5vJtbRnHH5IsvunHGqSKd5Wq6BcTo854w==
Date:   Mon, 20 Nov 2023 11:28:16 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     dregan@broadcom.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, joel.peshkin@broadcom.com,
        computersforpeace@gmail.com, dan.beygelman@broadcom.com,
        william.zhang@broadcom.com, frieder.schrempf@kontron.de,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, richard@nod.at,
        bbrezillon@kernel.org, kdasu.kdev@gmail.com,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH v4 4/4] mtd: rawnand: brcmnand: exec_op implementation
Message-ID: <20231120112816.15a19e05@xps-13>
In-Reply-To: <20231023171444.322311-4-dregan@broadcom.com>
References: <20231023171444.322311-1-dregan@broadcom.com>
        <20231023171444.322311-4-dregan@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

dregan@broadcom.com wrote on Mon, 23 Oct 2023 10:14:44 -0700:

> From: David Regan <dregan@broadcom.com>
>=20
> exec_op implementation for Broadcom STB, Broadband and iProc SoC
> This adds exec_op and removes the legacy interface. Based on changes
> proposed by Boris Brezillon.
>=20
> https://github.com/bbrezillon/linux/commit/4ec6f8d8d83f5aaca5d1877f02d48d=
a96d41fcba
> https://github.com/bbrezillon/linux/commit/11b4acffd761c4928652d7028d19fc=
d6f45e4696
>=20
> Signed-off-by: David Regan <dregan@broadcom.com>

I'm fine with patches 1-3, a few minor nits on this version as well,
nothing big. I guess I'll let some time to Florian as well to give his
feedback and perhaps test the ->exec_op() implementation.

...

> +static int brcmnand_exec_instr(struct brcmnand_host *host, int i,
> +				const struct nand_operation *op)
> +{
> +	struct brcmnand_controller *ctrl =3D host->ctrl;
> +	const struct nand_op_instr *instr =3D &op->instrs[i];
> +	const u8 *out;
> +	u8 *in;
> +	int ret =3D 0;
> +	bool last_op;
> +
> +	/*
> +	 * if we are on the last command in the sequence (not including
> +	 * waitrdy which is not a NAND command) then flag the controller

May I suggest:

	/*
	 * The controller needs to be aware of the last command in the operation
	 * (WAITRDY excepted).
	 */

> +	 */
> +	last_op =3D (((i =3D=3D (op->ninstrs - 1)) &&
> +			(instr->type !=3D NAND_OP_WAITRDY_INSTR)) ||

You can cross the 80 chars boundary. Please use this form:

	last_op =3D ((i =3D=3D (op->ninstrs - 1)) && (instr->type !=3D NAND_OP_WAI=
TRDY_INSTR)) ||
		  ((i =3D=3D (op->ninstrs - 2)) && (op->instrs[i+1].type =3D=3D NAND_OP_W=
AITRDY_INSTR));

> +			((i =3D=3D (op->ninstrs - 2)) &&
> +			(op->instrs[i+1].type =3D=3D NAND_OP_WAITRDY_INSTR)));
> +
> +	switch (instr->type) {
> +	case NAND_OP_CMD_INSTR:
> +		brcmnand_low_level_op(host, LL_OP_CMD,
> +				      instr->ctx.cmd.opcode, last_op);
> +		break;
> +
> +	case NAND_OP_ADDR_INSTR:
> +		for (i =3D 0; i < instr->ctx.addr.naddrs; i++)
> +			brcmnand_low_level_op(host, LL_OP_ADDR,
> +					      instr->ctx.addr.addrs[i],
> +					      last_op &&
> +						  i =3D=3D (instr->ctx.addr.naddrs - 1));
> +		break;
> +
> +	case NAND_OP_DATA_IN_INSTR:
> +		in =3D instr->ctx.data.buf.in;
> +		for (i =3D 0; i < instr->ctx.data.len; i++) {
> +			brcmnand_low_level_op(host, LL_OP_RD, 0, last_op &&
> +						  i =3D=3D (instr->ctx.data.len - 1));
> +			in[i] =3D brcmnand_read_reg(host->ctrl,
> +						  BRCMNAND_LL_RDATA);
> +		}
> +		break;
> +
> +	case NAND_OP_DATA_OUT_INSTR:
> +		out =3D instr->ctx.data.buf.out;
> +		for (i =3D 0; i < instr->ctx.data.len; i++)
> +			brcmnand_low_level_op(host, LL_OP_WR, out[i], last_op &&
> +						  i =3D=3D (instr->ctx.data.len - 1));
> +		break;
> +
> +	case NAND_OP_WAITRDY_INSTR:
> +		ret =3D bcmnand_ctrl_poll_status(host, NAND_CTRL_RDY, NAND_CTRL_RDY, 0=
);
> +		break;
> +
> +	default:
> +		dev_err(ctrl->dev, "unsupported instruction type: %d\n",
> +			instr->type);
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int brcmnand_exec_op_is_status(const struct nand_operation *op)

brcmnand_op_is_status() would make more sense

> +{
> +	if ((op->ninstrs =3D=3D 2) &&
> +		(op->instrs[0].type =3D=3D NAND_OP_CMD_INSTR) &&
> +		(op->instrs[0].ctx.cmd.opcode =3D=3D NAND_CMD_STATUS) &&
> +		(op->instrs[1].type =3D=3D NAND_OP_DATA_IN_INSTR))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int brcmnand_exec_op_is_reset(const struct nand_operation *op)

same here, please s/exec_//

> +{
> +	if ((op->ninstrs =3D=3D 1) &&
> +		(op->instrs[0].type =3D=3D NAND_OP_CMD_INSTR) &&
> +		(op->instrs[0].ctx.cmd.opcode =3D=3D NAND_CMD_RESET))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int brcmnand_exec_op(struct nand_chip *chip,
> +			    const struct nand_operation *op,
> +			    bool check_only)
> +{
> +	struct brcmnand_host *host =3D nand_get_controller_data(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	u8 *status;
> +	unsigned int i;
> +	int ret =3D 0;
> +
> +	if (check_only)
> +		return 0;
> +
> +	if (brcmnand_exec_op_is_status(op)) {
> +		status =3D op->instrs[1].ctx.data.buf.in;
> +		*status =3D brcmnand_status(host);
> +
> +		return 0;
> +	}

I would add the below chunk here:

	} else if (brcmnand_exec_op_is_reset(op)) {
		...

		return ...
	}

> +
> +	if (op->deassert_wp)
> +		brcmnand_wp(mtd, 0);
> +
> +	for (i =3D 0; i < op->ninstrs; i++) {
> +		ret =3D brcmnand_exec_instr(host, i, op);
> +		if (ret)
> +			break;
> +	}
> +
> +	if (op->deassert_wp)
> +		brcmnand_wp(mtd, 1);
> +
> +	if (brcmnand_exec_op_is_reset(op)) {
> +		brcmnand_wp(mtd, 1);
> +		brcmnand_status(host);
> +	}
> +
> +	return ret;
> +}

Thanks,
Miqu=C3=A8l
