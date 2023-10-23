Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9DF7D2BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjJWHzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbjJWHy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:54:58 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9219A6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:54:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17C761C0007;
        Mon, 23 Oct 2023 07:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698047695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9NG6Qfj/WvzlqK/Izjv2p/D3wthz19tmgf7a/knaCMY=;
        b=hHX6svNA8O44ORGFy2KuHXQI6HdTd0ct3xmsyiM8tjvU2ri8O1qHdk0pwbAV7fuIn9Pz6C
        RwziQHjcpNNtAGFk7em7mLUJ35b+87AbB8bDSx2Dj3wH/uD03XrZlSrBiOnt75StPEIL+B
        pSzK9cOn4TSIESr1oPxIdeL7E9kuok8REOmlf3eu0EgyVvsyFfSGmnnMAWLsoAMOyw1Tfq
        CYJuEsi2gHRFfK+M8oikm52DRszFLnVJly31hzJ8BiWFht8Xj7SflSxEOUP671J+6SDWiv
        gHBV0jmOFJ601FDlEUD8CiAEDh8Gsw3T2cmDn7+lKcM0LlgGT+eNzjG2cm+aow==
Date:   Mon, 23 Oct 2023 09:54:51 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mtd: rawnand: add support for TH58NYG3S0HBAI4 NAND
 flash
Message-ID: <20231023095451.65c4c0ec@xps-13>
In-Reply-To: <20231021150212.20509-1-amadeus@jmu.edu.cn>
References: <20231021150212.20509-1-amadeus@jmu.edu.cn>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chukun,

amadeus@jmu.edu.cn wrote on Sat, 21 Oct 2023 23:02:12 +0800:

> The Toshiba TH58NYG3S0HBAI4 is detected with 128 byte OOB while the flash
> has 256 bytes OOB. This adds a static NAND ID entry to correct this.

Any way you can detect this and fix the parameter page at run time
instead?

> Tested on Arcadyan AW1000 flashed with OpenWrt.
>=20
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  drivers/mtd/nand/raw/nand_ids.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_=
ids.c
> index 650351c62af6..2b871dfd1d09 100644
> --- a/drivers/mtd/nand/raw/nand_ids.c
> +++ b/drivers/mtd/nand/raw/nand_ids.c
> @@ -58,6 +58,9 @@ struct nand_flash_dev nand_flash_ids[] =3D {
>  		{ .id =3D {0xad, 0xde, 0x14, 0xa7, 0x42, 0x4a} },
>  		  SZ_16K, SZ_8K, SZ_4M, NAND_NEED_SCRAMBLING, 6, 1664,
>  		  NAND_ECC_INFO(40, SZ_1K) },
> +	{"TH58NYG3S0HBAI4 8G 1.8V 8-bit",
> +		{ .id =3D {0x98, 0xa3, 0x91, 0x26, 0x76} },
> +		  SZ_4K, SZ_1K, SZ_256K, 0, 4, 256, NAND_ECC_INFO(8, SZ_512) },
>  	{"TH58NVG2S3HBAI4 4G 3.3V 8-bit",
>  		{ .id =3D {0x98, 0xdc, 0x91, 0x15, 0x76} },
>  		  SZ_2K, SZ_512, SZ_128K, 0, 5, 128, NAND_ECC_INFO(8, SZ_512) },


Thanks,
Miqu=C3=A8l
