Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4DC7AAF13
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjIVKEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjIVKEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:04:49 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4C691
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=MIME-Version:Content-Transfer-Encoding:Content-Type:
        References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=qtYnwIkoH4lirr7DPpydUuHqVeSRQWS/iyAS31oCrSc=; b=OqmpouJ+2lA6r+hpdKjZ2DzNIA
        vAhb92n8zU6NVW6FR4D9ebQNIka+NXSefdtLV16MrRPP9/KqvOa94cts0UxrtQrSVISbRn1AyryiP
        JF/2Wbn0x6VSursnvpbxHtZcPMbxHWGAiSoq/3AVsCQB5dw5pj9avmx3TemlmMeZAhaLrjnXvER9U
        bm177FARu96Ae+aC7cMhQkDSgz4xANSadWZhU3/nEfQlZOITO4X2cMsCBGoFWS4jQoGmck1emig8s
        npj1fjszn/Jy3wgKopHMcDJhMoEPQIUBCqrFyk0or3VRqoMKFt5ZzpW00/z3pm9b4sdYfQSKsWUjw
        gqtDhcFg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <martin@geanix.com>)
        id 1qjd1c-000GkW-4a; Fri, 22 Sep 2023 12:04:40 +0200
Received: from [185.17.218.86] (helo=[192.168.64.76])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@geanix.com>)
        id 1qjd1b-000G0e-KL; Fri, 22 Sep 2023 12:04:39 +0200
Message-ID: <e7e2c33d3f769b0afb88badbbedc41102ce95ee5.camel@geanix.com>
Subject: Re: [PATCH] mtd: rawnand: check nand support for cache reads
From:   Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        JaimeLiao <jaimeliao.tw@gmail.com>
Cc:     kernel@pengutronix.de, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 22 Sep 2023 12:04:39 +0200
In-Reply-To: <20230922100116.145090-1-r.czerwinski@pengutronix.de>
References: <20230922100116.145090-1-r.czerwinski@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27039/Fri Sep 22 09:38:03 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-22 at 12:01 +0200, Rouven Czerwinski wrote:
> Both the JEDEC and ONFI specification say that read cache sequential
> support is an optional command. This means that we not only need to
> check whether the individual controller implements the command, we
> also
> need to check the parameter pages for both ONFI and JEDEC NAND
> flashes
> before enabling sequential cache reads.
>=20
> This fixes support for NAND flashes which don't support enabling
> cache
> reads, i.e. Samsung K9F4G08U0F or Toshiba TC58NVG0S3HTA00.
>=20
> Sequential cache reads are no only available for ONFI and JEDEC
> devices,
> if individual vendors implement this, it needs to be enabled per
> vendor.
>=20
> Tested on i.MX6Q with a Samsung NAND flash chip that doesn't support
> sequential reads.
>=20
> Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache
> reads")
>=20
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> ---
> @Martin, M=C3=A5ns:
> I would appreciate if you could test this on your hardware.
>=20
> @Miguel:
> I didn't have the time to test this on ONFI/JEDEC devices with
> support
> yet, I'd be fine if you hold off merging this.
>=20
> =C2=A0drivers/mtd/nand/raw/nand_base.c=C2=A0 | 3 +++
> =C2=A0drivers/mtd/nand/raw/nand_jedec.c | 3 +++
> =C2=A0drivers/mtd/nand/raw/nand_onfi.c=C2=A0 | 3 +++
> =C2=A0include/linux/mtd/jedec.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 3 +++
> =C2=A0include/linux/mtd/onfi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1 +
> =C2=A0include/linux/mtd/rawnand.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1=
 +
> =C2=A06 files changed, 14 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/nand_base.c
> b/drivers/mtd/nand/raw/nand_base.c
> index d4b55155aeae..1fcac403cee6 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5110,6 +5110,9 @@ static void
> rawnand_check_cont_read_support(struct nand_chip *chip)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mtd_info *mtd =3D =
nand_to_mtd(chip);
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!chip->parameters.supports=
_read_cache)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (chip->read_retries)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return;
> =C2=A0
> diff --git a/drivers/mtd/nand/raw/nand_jedec.c
> b/drivers/mtd/nand/raw/nand_jedec.c
> index 836757717660..e6ecbc4b2493 100644
> --- a/drivers/mtd/nand/raw/nand_jedec.c
> +++ b/drivers/mtd/nand/raw/nand_jedec.c
> @@ -94,6 +94,9 @@ int nand_jedec_detect(struct nand_chip *chip)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto free_jedec_param_page;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (p->opt_cmd[0] & JEDEC_OPT_=
CMD_READ_CACHE)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0chip->parameters.supports_read_cache;

Missing ` =3D true` here ?

> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memorg->pagesize =3D le32=
_to_cpu(p->byte_per_page);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mtd->writesize =3D memorg=
->pagesize;
> =C2=A0
> diff --git a/drivers/mtd/nand/raw/nand_onfi.c
> b/drivers/mtd/nand/raw/nand_onfi.c
> index f15ef90aec8c..bf79bf2b5866 100644
> --- a/drivers/mtd/nand/raw/nand_onfi.c
> +++ b/drivers/mtd/nand/raw/nand_onfi.c
> @@ -303,6 +303,9 @@ int nand_onfi_detect(struct nand_chip *chip)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ONFI_FEATURE_ADDR_TIMING_MODE, 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (le16_to_cpu(p->opt_cmd) & =
ONFI_OPT_CMD_READ_CACHE)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0chip->parameters.supports_read_cache;

And here?

// Martin
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0onfi =3D kzalloc(sizeof(*=
onfi), GFP_KERNEL);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!onfi) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ret =3D -ENOMEM;
> diff --git a/include/linux/mtd/jedec.h b/include/linux/mtd/jedec.h
> index 0b6b59f7cfbd..56047a4e54c9 100644
> --- a/include/linux/mtd/jedec.h
> +++ b/include/linux/mtd/jedec.h
> @@ -21,6 +21,9 @@ struct jedec_ecc_info {
> =C2=A0/* JEDEC features */
> =C2=A0#define JEDEC_FEATURE_16_BIT_BUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0(1 << 0)
> =C2=A0
> +/* JEDEC Optional Commands */
> +#define JEDEC_OPT_CMD_READ_CACHE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0BIT(1)
> +
> =C2=A0struct nand_jedec_params {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* rev info and features =
block */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* 'J' 'E' 'S' 'D'=C2=A0 =
*/
> diff --git a/include/linux/mtd/onfi.h b/include/linux/mtd/onfi.h
> index a7376f9beddf..55ab2e4d62f9 100644
> --- a/include/linux/mtd/onfi.h
> +++ b/include/linux/mtd/onfi.h
> @@ -55,6 +55,7 @@
> =C2=A0#define ONFI_SUBFEATURE_PARAM_LEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A04
> =C2=A0
> =C2=A0/* ONFI optional commands SET/GET FEATURES supported? */
> +#define ONFI_OPT_CMD_READ_CACHE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(1)
> =C2=A0#define ONFI_OPT_CMD_SET_GET_FEATURES=C2=A0=C2=A0BIT(2)
> =C2=A0
> =C2=A0struct nand_onfi_params {
> diff --git a/include/linux/mtd/rawnand.h
> b/include/linux/mtd/rawnand.h
> index 90a141ba2a5a..766856fcaba8 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -233,6 +233,7 @@ struct nand_parameters {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Generic parameters */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *model;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool supports_set_get_fea=
tures;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool supports_read_cache;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DECLARE_BITMAP(set_featur=
e_list, ONFI_FEATURE_NUMBER);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DECLARE_BITMAP(get_featur=
e_list, ONFI_FEATURE_NUMBER);
> =C2=A0

