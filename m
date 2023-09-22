Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED457AB38D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjIVOYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjIVOYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:24:39 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DED4AB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:24:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 74C4E240002;
        Fri, 22 Sep 2023 14:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695392668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VaBjDetDbRhvwrAbuz3kh4SD4X01Nb3vQdwmE9HZ9yk=;
        b=VyHp6tobZv3De2axOlkIO4xstXf+w2DkGQ6VzGK0wiOHADtOSwbd4v7pOspBXHDQDEl6po
        RtmINFGCHaMaa7G43mzozDpjuMyt5jGW5wuQKHmW8geoBqKRKvgEVg3/MELOX0SO5+SOct
        Do8vtyfvQ2Y2gJSQ9BsvpZT0xxmlwPGESHXZA95/mQWKAxXUapqjQvNR+MgLcyRa3mXhCv
        0ScfCuDN9t/4iopIY7tCCYR9vL++5kIg7Od/0saxs8Yzb8WCRad9TLqwkneeE+46RHOoXG
        k/wWEbIEjisO5ih7513s6g7KvlfLasgaisFm3v4gINQhKgjEWi91a4LLJCd3vg==
Date:   Fri, 22 Sep 2023 16:24:24 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     dregan@mail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, joel.peshkin@broadcom.com,
        computersforpeace@gmail.com, dan.beygelman@broadcom.com,
        william.zhang@broadcom.com, frieder.schrempf@kontron.de,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, richard@nod.at,
        bbrezillon@kernel.org, kdasu.kdev@gmail.com
Subject: Re: [PATCH] mtd: rawnand: brcmnand: Initial exec_op implementation
Message-ID: <20230922162424.4a7b27ec@xps-13>
In-Reply-To: <trinity-bb7db9f1-d34d-4fe2-bed3-814d3a63476a-1694571881792@3c-app-mailcom-lxa03>
References: <trinity-bb7db9f1-d34d-4fe2-bed3-814d3a63476a-1694571881792@3c-app-mailcom-lxa03>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

dregan@mail.com wrote on Wed, 13 Sep 2023 04:24:41 +0200:

> Initial exec_op implementation for Broadcom STB, Broadband and iProc SoC
> This adds exec_op and removes the legacy interface.

Thanks a lot for the conversion, a few comments below.

> Signed-off-by: David Regan <dregan@mail.com>
> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 384 ++++++++++-------------
>  1 file changed, 161 insertions(+), 223 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
> index 440bef477930..b075dade4129 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -625,6 +625,8 @@ enum {
>  /* Only for v7.2 */
>  #define	ACC_CONTROL_ECC_EXT_SHIFT		13
>=20
> +static u8 brcmnand_status(struct brcmnand_host *host);
> +
>  static inline bool brcmnand_non_mmio_ops(struct brcmnand_controller *ctr=
l)
>  {
>  #if IS_ENABLED(CONFIG_MTD_NAND_BRCMNAND_BCMA)
> @@ -1022,19 +1024,6 @@ static inline int brcmnand_sector_1k_shift(struct =
brcmnand_controller *ctrl)
>  		return -1;
>  }
>=20
> -static int brcmnand_get_sector_size_1k(struct brcmnand_host *host)
> -{
> -	struct brcmnand_controller *ctrl =3D host->ctrl;
> -	int shift =3D brcmnand_sector_1k_shift(ctrl);
> -	u16 acc_control_offs =3D brcmnand_cs_offset(ctrl, host->cs,
> -						  BRCMNAND_CS_ACC_CONTROL);
> -
> -	if (shift < 0)
> -		return 0;
> -
> -	return (nand_readreg(ctrl, acc_control_offs) >> shift) & 0x1;
> -}
> -
>  static void brcmnand_set_sector_size_1k(struct brcmnand_host *host, int =
val)
>  {
>  	struct brcmnand_controller *ctrl =3D host->ctrl;
> @@ -1387,7 +1376,8 @@ static void brcmnand_wp(struct mtd_info *mtd, int w=
p)
>  			return;
>=20
>  		brcmnand_set_wp(ctrl, wp);
> -		nand_status_op(chip, NULL);
> +		/* force controller operation to update internal copy of NAND chip sta=
tus */
> +		brcmnand_status(host);
>  		/* NAND_STATUS_WP 0x00 =3D protected, 0x80 =3D not protected */
>  		ret =3D bcmnand_ctrl_poll_status(ctrl,
>  					       NAND_CTRL_RDY |
> @@ -1643,16 +1633,6 @@ static void brcmnand_send_cmd(struct brcmnand_host=
 *host, int cmd)
>  			   cmd << brcmnand_cmd_shift(ctrl));
>  }
>=20
> -/***********************************************************************
> - * NAND MTD API: read/program/erase
> - ***********************************************************************/
> -
> -static void brcmnand_cmd_ctrl(struct nand_chip *chip, int dat,
> -			      unsigned int ctrl)
> -{
> -	/* intentionally left blank */
> -}
> -
>  static bool brcmstb_nand_wait_for_completion(struct nand_chip *chip)
>  {
>  	struct brcmnand_host *host =3D nand_get_controller_data(chip);
> @@ -1703,6 +1683,17 @@ static int brcmnand_waitfunc(struct nand_chip *chi=
p)
>  				 INTFC_FLASH_STATUS;
>  }
>=20
> +static u8 brcmnand_status(struct brcmnand_host *host)
> +{
> +	struct nand_chip *chip =3D &host->chip;
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +
> +	brcmnand_set_cmd_addr(mtd, 0);
> +	brcmnand_send_cmd(host, CMD_STATUS_READ);
> +
> +	return brcmnand_waitfunc(chip);
> +}
> +
>  enum {
>  	LLOP_RE				=3D BIT(16),
>  	LLOP_WE				=3D BIT(17),
> @@ -1752,190 +1743,6 @@ static int brcmnand_low_level_op(struct brcmnand_=
host *host,
>  	return brcmnand_waitfunc(chip);
>  }
>=20
> -static void brcmnand_cmdfunc(struct nand_chip *chip, unsigned command,
> -			     int column, int page_addr)
> -{
> -	struct mtd_info *mtd =3D nand_to_mtd(chip);
> -	struct brcmnand_host *host =3D nand_get_controller_data(chip);
> -	struct brcmnand_controller *ctrl =3D host->ctrl;
> -	u64 addr =3D (u64)page_addr << chip->page_shift;
> -	int native_cmd =3D 0;
> -
> -	if (command =3D=3D NAND_CMD_READID || command =3D=3D NAND_CMD_PARAM ||
> -			command =3D=3D NAND_CMD_RNDOUT)
> -		addr =3D (u64)column;
> -	/* Avoid propagating a negative, don't-care address */
> -	else if (page_addr < 0)
> -		addr =3D 0;
> -
> -	dev_dbg(ctrl->dev, "cmd 0x%x addr 0x%llx\n", command,
> -		(unsigned long long)addr);
> -
> -	host->last_cmd =3D command;
> -	host->last_byte =3D 0;
> -	host->last_addr =3D addr;
> -
> -	switch (command) {
> -	case NAND_CMD_RESET:
> -		native_cmd =3D CMD_FLASH_RESET;
> -		break;
> -	case NAND_CMD_STATUS:
> -		native_cmd =3D CMD_STATUS_READ;
> -		break;
> -	case NAND_CMD_READID:
> -		native_cmd =3D CMD_DEVICE_ID_READ;
> -		break;
> -	case NAND_CMD_READOOB:
> -		native_cmd =3D CMD_SPARE_AREA_READ;
> -		break;
> -	case NAND_CMD_ERASE1:
> -		native_cmd =3D CMD_BLOCK_ERASE;
> -		brcmnand_wp(mtd, 0);
> -		break;
> -	case NAND_CMD_PARAM:
> -		native_cmd =3D CMD_PARAMETER_READ;
> -		break;
> -	case NAND_CMD_SET_FEATURES:
> -	case NAND_CMD_GET_FEATURES:
> -		brcmnand_low_level_op(host, LL_OP_CMD, command, false);
> -		brcmnand_low_level_op(host, LL_OP_ADDR, column, false);
> -		break;
> -	case NAND_CMD_RNDOUT:
> -		native_cmd =3D CMD_PARAMETER_CHANGE_COL;
> -		addr &=3D ~((u64)(FC_BYTES - 1));
> -		/*
> -		 * HW quirk: PARAMETER_CHANGE_COL requires SECTOR_SIZE_1K=3D0
> -		 * NB: hwcfg.sector_size_1k may not be initialized yet
> -		 */
> -		if (brcmnand_get_sector_size_1k(host)) {
> -			host->hwcfg.sector_size_1k =3D
> -				brcmnand_get_sector_size_1k(host);
> -			brcmnand_set_sector_size_1k(host, 0);
> -		}
> -		break;
> -	}
> -
> -	if (!native_cmd)
> -		return;
> -
> -	brcmnand_set_cmd_addr(mtd, addr);
> -	brcmnand_send_cmd(host, native_cmd);
> -	brcmnand_waitfunc(chip);
> -
> -	if (native_cmd =3D=3D CMD_PARAMETER_READ ||
> -			native_cmd =3D=3D CMD_PARAMETER_CHANGE_COL) {
> -		/* Copy flash cache word-wise */
> -		u32 *flash_cache =3D (u32 *)ctrl->flash_cache;
> -		int i;
> -
> -		brcmnand_soc_data_bus_prepare(ctrl->soc, true);
> -
> -		/*
> -		 * Must cache the FLASH_CACHE now, since changes in
> -		 * SECTOR_SIZE_1K may invalidate it
> -		 */
> -		for (i =3D 0; i < FC_WORDS; i++)
> -			/*
> -			 * Flash cache is big endian for parameter pages, at
> -			 * least on STB SoCs
> -			 */
> -			flash_cache[i] =3D be32_to_cpu(brcmnand_read_fc(ctrl, i));
> -
> -		brcmnand_soc_data_bus_unprepare(ctrl->soc, true);
> -
> -		/* Cleanup from HW quirk: restore SECTOR_SIZE_1K */
> -		if (host->hwcfg.sector_size_1k)
> -			brcmnand_set_sector_size_1k(host,
> -						    host->hwcfg.sector_size_1k);
> -	}
> -
> -	/* Re-enable protection is necessary only after erase */
> -	if (command =3D=3D NAND_CMD_ERASE1)
> -		brcmnand_wp(mtd, 1);
> -}
> -
> -static uint8_t brcmnand_read_byte(struct nand_chip *chip)
> -{
> -	struct brcmnand_host *host =3D nand_get_controller_data(chip);
> -	struct brcmnand_controller *ctrl =3D host->ctrl;
> -	uint8_t ret =3D 0;
> -	int addr, offs;
> -
> -	switch (host->last_cmd) {
> -	case NAND_CMD_READID:
> -		if (host->last_byte < 4)
> -			ret =3D brcmnand_read_reg(ctrl, BRCMNAND_ID) >>
> -				(24 - (host->last_byte << 3));
> -		else if (host->last_byte < 8)
> -			ret =3D brcmnand_read_reg(ctrl, BRCMNAND_ID_EXT) >>
> -				(56 - (host->last_byte << 3));
> -		break;
> -
> -	case NAND_CMD_READOOB:
> -		ret =3D oob_reg_read(ctrl, host->last_byte);
> -		break;
> -
> -	case NAND_CMD_STATUS:
> -		ret =3D brcmnand_read_reg(ctrl, BRCMNAND_INTFC_STATUS) &
> -					INTFC_FLASH_STATUS;
> -		if (wp_on) /* hide WP status */
> -			ret |=3D NAND_STATUS_WP;
> -		break;
> -
> -	case NAND_CMD_PARAM:
> -	case NAND_CMD_RNDOUT:
> -		addr =3D host->last_addr + host->last_byte;
> -		offs =3D addr & (FC_BYTES - 1);
> -
> -		/* At FC_BYTES boundary, switch to next column */
> -		if (host->last_byte > 0 && offs =3D=3D 0)
> -			nand_change_read_column_op(chip, addr, NULL, 0, false);
> -
> -		ret =3D ctrl->flash_cache[offs];
> -		break;
> -	case NAND_CMD_GET_FEATURES:
> -		if (host->last_byte >=3D ONFI_SUBFEATURE_PARAM_LEN) {
> -			ret =3D 0;
> -		} else {
> -			bool last =3D host->last_byte =3D=3D
> -				ONFI_SUBFEATURE_PARAM_LEN - 1;
> -			brcmnand_low_level_op(host, LL_OP_RD, 0, last);
> -			ret =3D brcmnand_read_reg(ctrl, BRCMNAND_LL_RDATA) & 0xff;
> -		}
> -	}
> -
> -	dev_dbg(ctrl->dev, "read byte =3D 0x%02x\n", ret);
> -	host->last_byte++;
> -
> -	return ret;
> -}
> -
> -static void brcmnand_read_buf(struct nand_chip *chip, uint8_t *buf, int =
len)
> -{
> -	int i;
> -
> -	for (i =3D 0; i < len; i++, buf++)
> -		*buf =3D brcmnand_read_byte(chip);
> -}
> -
> -static void brcmnand_write_buf(struct nand_chip *chip, const uint8_t *bu=
f,
> -			       int len)
> -{
> -	int i;
> -	struct brcmnand_host *host =3D nand_get_controller_data(chip);
> -
> -	switch (host->last_cmd) {
> -	case NAND_CMD_SET_FEATURES:
> -		for (i =3D 0; i < len; i++)
> -			brcmnand_low_level_op(host, LL_OP_WR, buf[i],
> -						  (i + 1) =3D=3D len);
> -		break;
> -	default:
> -		BUG();
> -		break;
> -	}
> -}
> -
>  /*
>   *  Kick EDU engine
>   */
> @@ -2345,8 +2152,9 @@ static int brcmnand_read_page(struct nand_chip *chi=
p, uint8_t *buf,
>  	struct mtd_info *mtd =3D nand_to_mtd(chip);
>  	struct brcmnand_host *host =3D nand_get_controller_data(chip);
>  	u8 *oob =3D oob_required ? (u8 *)chip->oob_poi : NULL;
> +	u64 addr =3D (u64)page << chip->page_shift;
>=20
> -	nand_read_page_op(chip, page, 0, NULL, 0);
> +	host->last_addr =3D addr;
>=20
>  	return brcmnand_read(mtd, chip, host->last_addr,
>  			mtd->writesize >> FC_SHIFT, (u32 *)buf, oob);
> @@ -2359,8 +2167,9 @@ static int brcmnand_read_page_raw(struct nand_chip =
*chip, uint8_t *buf,
>  	struct mtd_info *mtd =3D nand_to_mtd(chip);
>  	u8 *oob =3D oob_required ? (u8 *)chip->oob_poi : NULL;
>  	int ret;
> +	u64 addr =3D (u64)page << chip->page_shift;
>=20
> -	nand_read_page_op(chip, page, 0, NULL, 0);
> +	host->last_addr =3D addr;
>=20
>  	brcmnand_set_ecc_enabled(host, 0);
>  	ret =3D brcmnand_read(mtd, chip, host->last_addr,
> @@ -2468,11 +2277,11 @@ static int brcmnand_write_page(struct nand_chip *=
chip, const uint8_t *buf,
>  	struct mtd_info *mtd =3D nand_to_mtd(chip);
>  	struct brcmnand_host *host =3D nand_get_controller_data(chip);
>  	void *oob =3D oob_required ? chip->oob_poi : NULL;
> +	u64 addr =3D (u64)page << chip->page_shift;
>=20
> -	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> -	brcmnand_write(mtd, chip, host->last_addr, (const u32 *)buf, oob);
> +	host->last_addr =3D addr;
>=20
> -	return nand_prog_page_end_op(chip);
> +	return brcmnand_write(mtd, chip, host->last_addr, (const u32 *)buf, oob=
);
>  }
>=20
>  static int brcmnand_write_page_raw(struct nand_chip *chip, const uint8_t=
 *buf,
> @@ -2481,13 +2290,15 @@ static int brcmnand_write_page_raw(struct nand_ch=
ip *chip, const uint8_t *buf,
>  	struct mtd_info *mtd =3D nand_to_mtd(chip);
>  	struct brcmnand_host *host =3D nand_get_controller_data(chip);
>  	void *oob =3D oob_required ? chip->oob_poi : NULL;
> +	u64 addr =3D (u64)page << chip->page_shift;
> +	int ret =3D 0;
>=20
> -	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> +	host->last_addr =3D addr;
>  	brcmnand_set_ecc_enabled(host, 0);
> -	brcmnand_write(mtd, chip, host->last_addr, (const u32 *)buf, oob);
> +	ret =3D brcmnand_write(mtd, chip, host->last_addr, (const u32 *)buf, oo=
b);
>  	brcmnand_set_ecc_enabled(host, 1);
>=20
> -	return nand_prog_page_end_op(chip);
> +	return ret;
>  }
>=20
>  static int brcmnand_write_oob(struct nand_chip *chip, int page)
> @@ -2511,6 +2322,139 @@ static int brcmnand_write_oob_raw(struct nand_chi=
p *chip, int page)
>  	return ret;
>  }
>=20
> +static void brcmnand_exec_instr(struct brcmnand_host *host,
> +				const struct nand_op_instr *instr,
> +				bool last_op)
> +{
> +	struct brcmnand_controller *ctrl =3D host->ctrl;
> +	unsigned int i;
> +	const u8 *out;
> +	u8 *in;
> +
> +	bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY, NAND_CTRL_RDY, 0);
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
> +					      last_op);
> +		break;
> +
> +	case NAND_OP_DATA_IN_INSTR:
> +		in =3D instr->ctx.data.buf.in;
> +		for (i =3D 0; i < instr->ctx.data.len; i++) {
> +			brcmnand_low_level_op(host, LL_OP_RD, 0, last_op);
> +			in[i] =3D brcmnand_read_reg(host->ctrl,
> +						  BRCMNAND_LL_RDATA);
> +		}
> +		break;
> +
> +	case NAND_OP_DATA_OUT_INSTR:
> +		out =3D instr->ctx.data.buf.out;
> +		for (i =3D 0; i < instr->ctx.data.len; i++)
> +			brcmnand_low_level_op(host, LL_OP_WR, out[i], last_op);
> +		break;
> +
> +	default:

Should probably return an error.

> +		break;
> +	}
> +}
> +
> +static int brcmnand_parser_exec_matched_op(struct nand_chip *chip,
> +					 const struct nand_subop *subop)
> +{
> +	struct brcmnand_host *host =3D nand_get_controller_data(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	const struct nand_op_instr *instr =3D &subop->instrs[0];
> +	unsigned int i;
> +	int ret =3D 0;
> +
> +	static int erase; /* will initialize to zero */
> +	static int status; /* will initialize to zero */

Looks really suspicious, I believe you should rework your
implementation to avoid static variables here.

> +
> +	for (i =3D 0; i < subop->ninstrs; i++) {
> +		instr =3D &subop->instrs[i];
> +
> +		if ((instr->type =3D=3D NAND_OP_CMD_INSTR) &&
> +			(instr->ctx.cmd.opcode =3D=3D NAND_CMD_STATUS))
> +			status =3D 1;
> +		else if (status && (instr->type =3D=3D NAND_OP_DATA_IN_INSTR)) {
> +			/*
> +			 * need to fake the nand device write protect because nand_base does a
> +			 * nand_check_wp which calls nand_status_op NAND_CMD_STATUS which che=
cks
> +			 * that the nand is not write protected before an operation starts.
> +			 * The problem with this is it's done outside exec_op so the nand is
> +			 * write protected and this check will fail until the write or erase
> +			 * or write back operation actually happens where we turn off wp.
> +			 */

If there is a problem with the core it needs to be handled in the core,
not workarounded here. The whole logic with the status property seems
really wrong.

> +			u8 *in;
> +
> +			status =3D 0;
> +
> +			instr =3D &subop->instrs[i];
> +			in =3D instr->ctx.data.buf.in;
> +			in[0] =3D brcmnand_status(host) | NAND_STATUS_WP; /* hide WP status */
> +		} else { /* otherwise pass to low level implementation */
> +			if ((instr->type =3D=3D NAND_OP_CMD_INSTR) &&
> +				(instr->ctx.cmd.opcode =3D=3D NAND_CMD_RESET)) {
> +				erase =3D 0;
> +				status =3D 0;
> +			}
> +
> +			if (erase) {
> +				erase =3D 0;
> +				brcmnand_wp(mtd, 1);
> +			}
> +
> +			if ((instr->type =3D=3D NAND_OP_CMD_INSTR) &&
> +				(instr->ctx.cmd.opcode =3D=3D NAND_CMD_ERASE1))
> +				brcmnand_wp(mtd, 0);
> +
> +			if ((instr->type =3D=3D NAND_OP_CMD_INSTR) &&
> +				(instr->ctx.cmd.opcode =3D=3D NAND_CMD_ERASE2))
> +				erase =3D 1;
> +
> +			brcmnand_exec_instr(host, instr, i =3D=3D (subop->ninstrs - 1));
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct nand_op_parser brcmnand_op_parser =3D NAND_OP_PARSER(
> +	/* false means the element MUST match,
> +	 * true means it does not have to match, catch all patterns
> +	 */

I believe the comment is not really useful here?

> +	NAND_OP_PARSER_PATTERN(
> +		brcmnand_parser_exec_matched_op,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true)),
> +	NAND_OP_PARSER_PATTERN(
> +		brcmnand_parser_exec_matched_op,
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 8)),
> +	NAND_OP_PARSER_PATTERN(
> +		brcmnand_parser_exec_matched_op,
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 8192)),
> +	NAND_OP_PARSER_PATTERN(
> +		brcmnand_parser_exec_matched_op,
> +		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(true, 8192)),
> +	NAND_OP_PARSER_PATTERN(
> +		brcmnand_parser_exec_matched_op,
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
> +);
> +
> +static int brcmnand_exec_op(struct nand_chip *chip,
> +			    const struct nand_operation *op,
> +			    bool check_only)
> +{
> +	return nand_op_parser_exec_op(chip, &brcmnand_op_parser, op, check_only=
);
> +}
> +
>  /***********************************************************************
>   * Per-CS setup (1 NAND device)
>   ***********************************************************************/
> @@ -2821,6 +2765,7 @@ static int brcmnand_attach_chip(struct nand_chip *c=
hip)
>=20
>  static const struct nand_controller_ops brcmnand_controller_ops =3D {
>  	.attach_chip =3D brcmnand_attach_chip,
> +	.exec_op =3D brcmnand_exec_op,
>  };
>=20
>  static int brcmnand_init_cs(struct brcmnand_host *host,
> @@ -2845,13 +2790,6 @@ static int brcmnand_init_cs(struct brcmnand_host *=
host,
>  	mtd->owner =3D THIS_MODULE;
>  	mtd->dev.parent =3D dev;
>=20
> -	chip->legacy.cmd_ctrl =3D brcmnand_cmd_ctrl;
> -	chip->legacy.cmdfunc =3D brcmnand_cmdfunc;
> -	chip->legacy.waitfunc =3D brcmnand_waitfunc;
> -	chip->legacy.read_byte =3D brcmnand_read_byte;
> -	chip->legacy.read_buf =3D brcmnand_read_buf;
> -	chip->legacy.write_buf =3D brcmnand_write_buf;
> -
>  	chip->ecc.engine_type =3D NAND_ECC_ENGINE_TYPE_ON_HOST;
>  	chip->ecc.read_page =3D brcmnand_read_page;
>  	chip->ecc.write_page =3D brcmnand_write_page;
> --
> 2.37.3
>=20


Thanks,
Miqu=C3=A8l
