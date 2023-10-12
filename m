Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DD17C6646
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377335AbjJLHIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343616AbjJLHIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:08:11 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636259D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:08:10 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9EE46C000E;
        Thu, 12 Oct 2023 07:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697094488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cayfJuQq3NXYzj1/eaV9Gu3hreC8uKdYtTQAop1dAvc=;
        b=iU+ayrS4MhjJtxriO7JYbpC7IhF9LIexIviPpRR1v24GJJsoL2uFDhTGqW84m/GWZWFELo
        hJ6g6ws5FAepcBx9pLKOGnkgSC+XtKd2m/mzLBcn524KoSOZshMOFdC0sLv3qiNwOTCXU1
        mtbhZD/ggsZJaRIevk9owPL/XCQaHZ1baSguNDMOGgA+KfzlZdPAunMvKmbIeBhHI49t1c
        bC6B5Ry/M9X0Mu52tuin1KWCuH3R1Pc4TVtjYDHI13+q16BG+ie8ZPTTzrO+yuzjTqWN+b
        FM8DIA6qTkW0VUgjZ7Q6JbBErMt7fbIpHrLn/RfYxFqCPv/V7G0VtooLkhjF1Q==
Date:   Thu, 12 Oct 2023 09:08:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     dregan@mail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, joel.peshkin@broadcom.com,
        computersforpeace@gmail.com, dan.beygelman@broadcom.com,
        william.zhang@broadcom.com, frieder.schrempf@kontron.de,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, richard@nod.at,
        bbrezillon@kernel.org, kdasu.kdev@gmail.com,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH v2 2/4] mtd: rawnand: NAND controller write protect
Message-ID: <20231012090805.7af1e8e0@xps-13>
In-Reply-To: <trinity-85483437-5787-42fc-8cf6-157a3f7324dc-1697071270308@3c-app-mailcom-lxa05>
References: <trinity-85483437-5787-42fc-8cf6-157a3f7324dc-1697071270308@3c-app-mailcom-lxa05>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dregan@mail.com,

dregan@mail.com wrote on Thu, 12 Oct 2023 02:41:10 +0200:

> Allow NAND controller to be responsible for write protect pin
> handling during fast path and exec_op destructive operation
> when controller_wp flag is set.
>=20
> Signed-off-by: David Regan <dregan@mail.com>
>=20
> ---
>=20
> Changes in v2: none
> ---
>  drivers/mtd/nand/raw/nand_base.c | 4 ++++
>  include/linux/mtd/rawnand.h      | 2 ++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand=
_base.c
> index 47cc2c35153b..38ed0ced5b8e 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -367,6 +367,10 @@ static int nand_check_wp(struct nand_chip *chip)
>  	if (chip->options & NAND_BROKEN_XD)
>  		return 0;
>=20
> +	/* controller responsible for NAND write protect */
> +	if (chip->controller->controller_wp)
> +		return 0;
> +
>  	/* Check the WP bit */
>  	ret =3D nand_status_op(chip, &status);
>  	if (ret)
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 31aceda8616c..f03b9d7f48b8 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -1111,6 +1111,7 @@ struct nand_controller_ops {
>   *			the bus without restarting an entire read operation nor
>   *			changing the column.
>   * @supported_op.cont_read: The controller supports sequential cache rea=
ds.
> + * @controller_wp:	controller responsible for NAND write protect.

			The controller is in charge of handling the WP pin

>   */
>  struct nand_controller {
>  	struct mutex lock;
> @@ -1119,6 +1120,7 @@ struct nand_controller {
>  		unsigned int data_only_read: 1;
>  		unsigned int cont_read: 1;
>  	} supported_op;
> +	bool controller_wp;
>  };
>=20
>  static inline void nand_controller_init(struct nand_controller *nfc)
> --
> 2.37.3
>=20
>=20


Thanks,
Miqu=C3=A8l
