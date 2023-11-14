Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA4C7EAB63
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjKNINO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjKNINN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:13:13 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D38E182;
        Tue, 14 Nov 2023 00:13:07 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E137A1BF209;
        Tue, 14 Nov 2023 08:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699949586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZdNblzkd8F7iiAV5Qi3t38lgqoePxjurhUeqg9MBO/k=;
        b=hc7uwVIXgWs6Z3zi3h5HjploxX2lsNJSxN+seHqwKtsJJ+uUgZAiBnStvTNjr6hQOobTNS
        Y2E90a4lclhzFlY3fwd1Y6YoiHd54zvxCc5xhbdPI1ZmSkMgTlnFqxeN4KN98a5o9UB48x
        1gbCMwCbvvXo7iqZHvCCLlvjlEnvN1zQ5CynNfR7s1r5wUDTaZomf69xN8B+KdmumQjNvC
        KtPTxcCR3LHsmpQ3I4zD5TOK9v6oIe4yLICTJ/fw+f82gw0PXya2gv6GyFsJ325G8J6Daq
        axlCn4s9XsI0CvoXZngsVpavEGmS5Nz4J6c3nqSHvEUHICHaXdp9Fse11yan/A==
Date:   Tue, 14 Nov 2023 09:13:02 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ronald Monthero <debug.penguin32@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, richard@nod.at, vigneshr@ti.com,
        heiko@sntech.de, martin.blumenstingl@googlemail.com,
        paul@crapouillou.net, robh@kernel.org,
        u.kleine-koenig@pengutronix.de, AVKrasnov@sberdevices.ru,
        r.czerwinski@pengutronix.de, jaimeliao.tw@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v3] mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand
 controller response
Message-ID: <20231114091302.1f865d66@xps-13>
In-Reply-To: <20231113173251.623268-1-debug.penguin32@gmail.com>
References: <ZVJJAReXiEVc35HZ@smile.fi.intel.com>
        <20231113173251.623268-1-debug.penguin32@gmail.com>
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

Hi Ronald,

debug.penguin32@gmail.com wrote on Tue, 14 Nov 2023 03:32:49 +1000:

> Under heavy load it is likely that the controller is done
> with its own task but the thread unlocking the wait is not
> scheduled in time. Increasing IFC_TIMEOUT_MSECS allows the
> controller to respond within allowable timeslice of 1 sec.
>=20
> fsl,ifc-nand 7e800000.nand: Controller is not responding
>=20
> [<804b2047>] (nand_get_device) from [<804b5335>] (nand_write_oob+0x1b/0x4=
a)
> [<804b5335>] (nand_write_oob) from [<804a3585>] (mtd_write+0x41/0x5c)
> [<804a3585>] (mtd_write) from [<804c1d47>] (ubi_io_write+0x17f/0x22c)
> [<804c1d47>] (ubi_io_write) from [<804c047b>] (ubi_eba_write_leb+0x5b/0x1=
d0)
>=20
> Cc: stable@vger.kernel.org

I believe the Fixes tag is the latest missing piece?

> Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> ---
>  drivers/mtd/nand/raw/fsl_ifc_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/f=
sl_ifc_nand.c
> index 20bb1e0cb5eb..f0e2318ce088 100644
> --- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
> +++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
> @@ -21,7 +21,7 @@
> =20
>  #define ERR_BYTE		0xFF /* Value returned for read
>  					bytes when read failed	*/
> -#define IFC_TIMEOUT_MSECS	500  /* Maximum number of mSecs to wait
> +#define IFC_TIMEOUT_MSECS	1000 /* Maximum timeout to wait
>  					for IFC NAND Machine	*/
> =20
>  struct fsl_ifc_ctrl;


Thanks,
Miqu=C3=A8l
