Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF517549EF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjGOPzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGOPzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:55:44 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B6F132;
        Sat, 15 Jul 2023 08:55:42 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A88B21C0003;
        Sat, 15 Jul 2023 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689436541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t/7fa1VodGmzW8y0BKaOaML3SEXmiAKlgK+Q/+vMQV8=;
        b=dUH6X1Y12IOT2F/sFhd4jGSWKbwni4/FzOi0GZOEN5k4LPXlD9Aw7mB0U6xeWT6zGwPLf7
        buhDI5e6DpVZWdnjfizz98ZRZHj+y4U1ZcmsL6nvukOOj7fUAQ/cTHg99Sa3wpTaTk7Yh/
        4R8hHVg49rPBpA1s7/ElgLGKuywYt7H20Li9CwzReflL0Dnq2Q+gCDs+RBVUX7uIPuWF6C
        OxOecvHzgww6n5qpiLkUJlhx/BkOR4d7rZvOvhMvvY64Mmqq6yOEPKA1f3PFrTJm/i1qnr
        aSVPoLaewwsYN6qGYbNPxUiHz+M6mrxWqCTkwhTDgWQS66Y+jD9UBVMU1fvl+g==
Date:   Sat, 15 Jul 2023 17:55:38 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mtd: rawnand: add nand-skip-bbtscan and
 nand-no-bbm-quirk DT options
Message-ID: <20230715175538.7142a141@xps-13>
In-Reply-To: <2b0dc481-562f-c8df-545e-dcf6548adb07@gmail.com>
References: <61c84262-cd98-1e60-d95b-9b0492083994@gmail.com>
        <2b0dc481-562f-c8df-545e-dcf6548adb07@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

jbx6244@gmail.com wrote on Sat, 15 Jul 2023 12:49:18 +0200:

> A NAND chip can contain a different data format then the MTD framework
> expects in the erase blocks for the Bad Block Table(BBT).
> Result is a failed probe, while nothing wrong with the hardware.
> Some MTD flags need to be set to gain access again.
>=20
> Skip the automatic BBT scan with the NAND_SKIP_BBTSCAN option
> so that the original content is unchanged during the driver probe.
> The NAND_NO_BBM_QUIRK option allows us to erase bad blocks with
> the nand_erase_nand() function and the flash_erase command.
>=20
> Add nand-skip-bbtscan and nand-no-bbm-quirk Device Tree options,
> so the user has the "freedom of choice" by neutral
> access mode to read and write in whatever format is needed.

This sounds like a partial solution. How do you handle bad blocks?

> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>=20
> Previous discussion:
> [PATCH v3 3/3] mtd: rawnand: rockchip-nand-controller: add skipbbt option
> https://lore.kernel.org/linux-mtd/1618382560.2326931.1689261435022.JavaMa=
il.zimbra@nod.at/
> ---
>  drivers/mtd/nand/raw/nand_base.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand=
_base.c
> index a6af521832aa..f0fa5c3519b1 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5521,6 +5521,12 @@ static int rawnand_dt_init(struct nand_chip *chip)
>  	if (of_property_read_bool(dn, "nand-is-boot-medium"))
>  		chip->options |=3D NAND_IS_BOOT_MEDIUM;
>=20
> +	if (of_property_read_bool(dn, "nand-no-bbm-quirk"))
> +		chip->options |=3D NAND_NO_BBM_QUIRK;
> +
> +	if (of_property_read_bool(dn, "nand-skip-bbtscan"))
> +		chip->options |=3D NAND_SKIP_BBTSCAN;
> +
>  	if (of_property_read_bool(dn, "nand-on-flash-bbt"))
>  		chip->bbt_options |=3D NAND_BBT_USE_FLASH;
>=20
> --
> 2.30.2
>=20


Thanks,
Miqu=C3=A8l
