Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6C87B2414
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjI1Rke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjI1Rkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:40:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2C1DD;
        Thu, 28 Sep 2023 10:40:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32483535e51so1131194f8f.0;
        Thu, 28 Sep 2023 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695922827; x=1696527627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JZDBA/8Pc4Dr+87oHFNU6cXwe4pXOmPmryPM6oar90=;
        b=D6NORaH7vQbe6YskfbK+BcjrhKegCO8Tq6xhTMq6JklA0S8rqMgYBWV7pEyTbZfmBG
         nofrlNiRghUsCMpU8trkrIgDHrznArkxnTGEnJEAF7XIRTv1H6dkBnQipJtB6AC79DHz
         QVt4CELRl6HNyYNTi/OZ2P96vCv8pNentxgvFhAkXBKsAC4WbMoU5XQ/elvYUwPfWRg0
         eHo7dlU4F6wOgkNpIoMV4g3TYnWutMSqm03f3FFKmr4qExMk89YHfxXeX13ir1Sgf5Zv
         4Th1Ztqy/x7Q26Hdjnnu6Hk940/NRa/5LYlPGj7RtLZHFXVpLq6X0+FXuXed11BdDIMJ
         c3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695922827; x=1696527627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JZDBA/8Pc4Dr+87oHFNU6cXwe4pXOmPmryPM6oar90=;
        b=DmssudV0+IxdoqtC+s0DRsPorpO6N9zkZxug4TvS7Tyn4Do3mHsDYTg1liZfJZQOje
         9DtccKOumXfVS74vn+E+5TobJWvS3GhvQVYmfOapc8bKlZ+BDox7CgJ52v575Gm3uvck
         0+1z6g4psZwD2kwv2jZaggeJaGSksA3GoA+/P7LMgNluM/ua0RwbGam8+fPiM38TJy+C
         Z7XQnEys4tM4VJOVX34tFKk/eGV5uhNHFnGq5yHL9v0riNr2UBIST+zRvAm9mVPtd0fy
         +p/dwSVrKYA3SEKFIz0NqTskf6Kw+t9FGzuKg+GSeRoLfdX0qDo+Y7zqaJr3O6lVCpG8
         PmIQ==
X-Gm-Message-State: AOJu0Yz5o78r6cj7zcmb3ZvGqnGzsR4oEtSX/2QZEwKTXYSmXtGZVXAy
        79krdDDV3+Prl6RRLAgUNj0=
X-Google-Smtp-Source: AGHT+IEHAV165RCcjAA6LQ0/PQ5U9fKuk2lxw+cuUqmE44d+PQBNtgHEq/2KzsaNxNwXPyHtbnwK7g==
X-Received: by 2002:a5d:4cc3:0:b0:31f:ef77:67e4 with SMTP id c3-20020a5d4cc3000000b0031fef7767e4mr1506433wrt.37.1695922826104;
        Thu, 28 Sep 2023 10:40:26 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d6b51000000b0031980294e9fsm19907065wrw.116.2023.09.28.10.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 10:40:25 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org,
        Michael Walle <michael@walle.cc>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V5] nvmem: add explicit config option to read old syntax fixed OF
 cells
Date:   Thu, 28 Sep 2023 19:40:22 +0200
Message-ID: <4947329.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20230927204446.4231-1-zajec5@gmail.com>
References: <20230927204446.4231-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 27. september 2023 ob 22:44:46 CEST je Rafa=C5=82 Mi=C5=82ecki n=
apisal(a):
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> Binding for fixed NVMEM cells defined directly as NVMEM device subnodes
> has been deprecated. It has been replaced by the "fixed-layout" NVMEM
> layout binding.
>=20
> New syntax is meant to be clearer and should help avoiding imprecise
> bindings.
>=20
> NVMEM subsystem already supports the new binding. It should be a good
> idea to limit support for old syntax to existing drivers that actually
> support & use it (we can't break backward compatibility!). That way we
> additionally encourage new bindings & drivers to ignore deprecated
> binding.
>=20
> It wasn't clear (to me) if rtc and w1 code actually uses old syntax
> fixed cells. I enabled them to don't risk any breakage.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> [for meson-{efuse,mx-efuse}.c]
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> [for mtk-efuse.c, nvmem/core.c, nvmem-provider.h]
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> [MT8192, MT8195 Chromebooks]
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
> [for microchip-otpc.c]
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> [SAMA7G5-EK]
> Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
> V2: Fix stm32-romem.c typo breaking its compilation
>     Pick Martin's Acked-by
>     Add paragraph about layouts deprecating add_legacy_fixed_of_cells
> V3: Update commit description:
>     1. Make it clear we're NOT dropping fixed cells support
>     2. Use nicer words (s/made sense/was totally safe/)
>     3. Explain fixed cells layout thing
>     4. Add paragraph with purpose of this commit
> V4: Completely rewrite commit message.
>     Rename config option to "add_legacy_fixed_of_cells".
> V5: Rebase patch
>     Cover sec-qfprom.c which uses legacy syntax
>=20
>  drivers/mtd/mtdcore.c          | 2 ++
>  drivers/nvmem/apple-efuses.c   | 1 +
>  drivers/nvmem/core.c           | 8 +++++---
>  drivers/nvmem/imx-ocotp-scu.c  | 1 +
>  drivers/nvmem/imx-ocotp.c      | 1 +
>  drivers/nvmem/meson-efuse.c    | 1 +
>  drivers/nvmem/meson-mx-efuse.c | 1 +
>  drivers/nvmem/microchip-otpc.c | 1 +
>  drivers/nvmem/mtk-efuse.c      | 1 +
>  drivers/nvmem/qcom-spmi-sdam.c | 1 +
>  drivers/nvmem/qfprom.c         | 1 +
>  drivers/nvmem/rave-sp-eeprom.c | 1 +
>  drivers/nvmem/rockchip-efuse.c | 1 +
>  drivers/nvmem/sc27xx-efuse.c   | 1 +
>  drivers/nvmem/sec-qfprom.c     | 1 +
>  drivers/nvmem/sprd-efuse.c     | 1 +
>  drivers/nvmem/stm32-romem.c    | 1 +
>  drivers/nvmem/sunplus-ocotp.c  | 1 +
>  drivers/nvmem/sunxi_sid.c      | 1 +

=46or sunxi:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  drivers/nvmem/uniphier-efuse.c | 1 +
>  drivers/nvmem/zynqmp_nvmem.c   | 1 +
>  drivers/rtc/nvmem.c            | 1 +
>  drivers/w1/slaves/w1_ds250x.c  | 1 +
>  include/linux/nvmem-provider.h | 2 ++
>  24 files changed, 30 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 9bd661be3ae9..fbf60d1364f0 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -552,6 +552,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
>  	config.dev =3D &mtd->dev;
>  	config.name =3D dev_name(&mtd->dev);
>  	config.owner =3D THIS_MODULE;
> +	config.add_legacy_fixed_of_cells =3D of_device_is_compatible(node, "nvm=
em-cells");
>  	config.reg_read =3D mtd_nvmem_reg_read;
>  	config.size =3D mtd->size;
>  	config.word_size =3D 1;
> @@ -898,6 +899,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(st=
ruct mtd_info *mtd,
>  	config.name =3D compatible;
>  	config.id =3D NVMEM_DEVID_AUTO;
>  	config.owner =3D THIS_MODULE;
> +	config.add_legacy_fixed_of_cells =3D true;
>  	config.type =3D NVMEM_TYPE_OTP;
>  	config.root_only =3D true;
>  	config.ignore_wp =3D true;
> diff --git a/drivers/nvmem/apple-efuses.c b/drivers/nvmem/apple-efuses.c
> index 9b7c87102104..d3d49d22338b 100644
> --- a/drivers/nvmem/apple-efuses.c
> +++ b/drivers/nvmem/apple-efuses.c
> @@ -36,6 +36,7 @@ static int apple_efuses_probe(struct platform_device *p=
dev)
>  	struct resource *res;
>  	struct nvmem_config config =3D {
>  		.dev =3D &pdev->dev,
> +		.add_legacy_fixed_of_cells =3D true,
>  		.read_only =3D true,
>  		.reg_read =3D apple_efuses_read,
>  		.stride =3D sizeof(u32),
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index eaf6a3fe8ca6..2710943f53c4 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -997,9 +997,11 @@ struct nvmem_device *nvmem_register(const struct nvm=
em_config *config)
>  	if (rval)
>  		goto err_remove_cells;
> =20
> -	rval =3D nvmem_add_cells_from_legacy_of(nvmem);
> -	if (rval)
> -		goto err_remove_cells;
> +	if (config->add_legacy_fixed_of_cells) {
> +		rval =3D nvmem_add_cells_from_legacy_of(nvmem);
> +		if (rval)
> +			goto err_remove_cells;
> +	}
> =20
>  	rval =3D nvmem_add_cells_from_fixed_layout(nvmem);
>  	if (rval)
> diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
> index c38d9c1c3f48..517d83e11af2 100644
> --- a/drivers/nvmem/imx-ocotp-scu.c
> +++ b/drivers/nvmem/imx-ocotp-scu.c
> @@ -220,6 +220,7 @@ static int imx_scu_ocotp_write(void *context, unsigne=
d int offset,
> =20
>  static struct nvmem_config imx_scu_ocotp_nvmem_config =3D {
>  	.name =3D "imx-scu-ocotp",
> +	.add_legacy_fixed_of_cells =3D true,
>  	.read_only =3D false,
>  	.word_size =3D 4,
>  	.stride =3D 1,
> diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
> index a223d9537f22..434f197e27bf 100644
> --- a/drivers/nvmem/imx-ocotp.c
> +++ b/drivers/nvmem/imx-ocotp.c
> @@ -615,6 +615,7 @@ static int imx_ocotp_probe(struct platform_device *pd=
ev)
>  		return PTR_ERR(priv->clk);
> =20
>  	priv->params =3D of_device_get_match_data(&pdev->dev);
> +	imx_ocotp_nvmem_config.add_legacy_fixed_of_cells =3D true;
>  	imx_ocotp_nvmem_config.size =3D 4 * priv->params->nregs;
>  	imx_ocotp_nvmem_config.dev =3D dev;
>  	imx_ocotp_nvmem_config.priv =3D priv;
> diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
> index d6b533497ce1..b922df99f9bc 100644
> --- a/drivers/nvmem/meson-efuse.c
> +++ b/drivers/nvmem/meson-efuse.c
> @@ -93,6 +93,7 @@ static int meson_efuse_probe(struct platform_device *pd=
ev)
> =20
>  	econfig->dev =3D dev;
>  	econfig->name =3D dev_name(dev);
> +	econfig->add_legacy_fixed_of_cells =3D true;
>  	econfig->stride =3D 1;
>  	econfig->word_size =3D 1;
>  	econfig->reg_read =3D meson_efuse_read;
> diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efus=
e.c
> index d6d7aeda31f9..3ff04d5ca8f8 100644
> --- a/drivers/nvmem/meson-mx-efuse.c
> +++ b/drivers/nvmem/meson-mx-efuse.c
> @@ -210,6 +210,7 @@ static int meson_mx_efuse_probe(struct platform_devic=
e *pdev)
>  	efuse->config.owner =3D THIS_MODULE;
>  	efuse->config.dev =3D &pdev->dev;
>  	efuse->config.priv =3D efuse;
> +	efuse->config.add_legacy_fixed_of_cells =3D true;
>  	efuse->config.stride =3D drvdata->word_size;
>  	efuse->config.word_size =3D drvdata->word_size;
>  	efuse->config.size =3D SZ_512;
> diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otp=
c.c
> index 436e0dc4f337..7cf81738a3e0 100644
> --- a/drivers/nvmem/microchip-otpc.c
> +++ b/drivers/nvmem/microchip-otpc.c
> @@ -261,6 +261,7 @@ static int mchp_otpc_probe(struct platform_device *pd=
ev)
>  		return ret;
> =20
>  	mchp_nvmem_config.dev =3D otpc->dev;
> +	mchp_nvmem_config.add_legacy_fixed_of_cells =3D true;
>  	mchp_nvmem_config.size =3D size;
>  	mchp_nvmem_config.priv =3D otpc;
>  	nvmem =3D devm_nvmem_register(&pdev->dev, &mchp_nvmem_config);
> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
> index b36cd0dcc8c7..87c94686cfd2 100644
> --- a/drivers/nvmem/mtk-efuse.c
> +++ b/drivers/nvmem/mtk-efuse.c
> @@ -83,6 +83,7 @@ static int mtk_efuse_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->base);
> =20
>  	pdata =3D device_get_match_data(dev);
> +	econfig.add_legacy_fixed_of_cells =3D true;
>  	econfig.stride =3D 1;
>  	econfig.word_size =3D 1;
>  	econfig.reg_read =3D mtk_reg_read;
> diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sda=
m.c
> index 70f2d4f2efbf..9aa8f42faa4c 100644
> --- a/drivers/nvmem/qcom-spmi-sdam.c
> +++ b/drivers/nvmem/qcom-spmi-sdam.c
> @@ -142,6 +142,7 @@ static int sdam_probe(struct platform_device *pdev)
>  	sdam->sdam_config.name =3D "spmi_sdam";
>  	sdam->sdam_config.id =3D NVMEM_DEVID_AUTO;
>  	sdam->sdam_config.owner =3D THIS_MODULE;
> +	sdam->sdam_config.add_legacy_fixed_of_cells =3D true;
>  	sdam->sdam_config.stride =3D 1;
>  	sdam->sdam_config.word_size =3D 1;
>  	sdam->sdam_config.reg_read =3D sdam_read;
> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> index 525be03b7bba..116a39e804c7 100644
> --- a/drivers/nvmem/qfprom.c
> +++ b/drivers/nvmem/qfprom.c
> @@ -357,6 +357,7 @@ static int qfprom_probe(struct platform_device *pdev)
>  {
>  	struct nvmem_config econfig =3D {
>  		.name =3D "qfprom",
> +		.add_legacy_fixed_of_cells =3D true,
>  		.stride =3D 1,
>  		.word_size =3D 1,
>  		.id =3D NVMEM_DEVID_AUTO,
> diff --git a/drivers/nvmem/rave-sp-eeprom.c b/drivers/nvmem/rave-sp-eepro=
m.c
> index df6a1c594b78..9ecf3873cbb7 100644
> --- a/drivers/nvmem/rave-sp-eeprom.c
> +++ b/drivers/nvmem/rave-sp-eeprom.c
> @@ -328,6 +328,7 @@ static int rave_sp_eeprom_probe(struct platform_devic=
e *pdev)
>  	of_property_read_string(np, "zii,eeprom-name", &config.name);
>  	config.priv		=3D eeprom;
>  	config.dev		=3D dev;
> +	config.add_legacy_fixed_of_cells	=3D true;
>  	config.size		=3D size;
>  	config.reg_read		=3D rave_sp_eeprom_reg_read;
>  	config.reg_write	=3D rave_sp_eeprom_reg_write;
> diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efus=
e.c
> index 4004c5bece42..2b40978ddb18 100644
> --- a/drivers/nvmem/rockchip-efuse.c
> +++ b/drivers/nvmem/rockchip-efuse.c
> @@ -205,6 +205,7 @@ static int rockchip_rk3399_efuse_read(void *context, =
unsigned int offset,
> =20
>  static struct nvmem_config econfig =3D {
>  	.name =3D "rockchip-efuse",
> +	.add_legacy_fixed_of_cells =3D true,
>  	.stride =3D 1,
>  	.word_size =3D 1,
>  	.read_only =3D true,
> diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
> index 2210da40dfbd..bff27011f4ff 100644
> --- a/drivers/nvmem/sc27xx-efuse.c
> +++ b/drivers/nvmem/sc27xx-efuse.c
> @@ -247,6 +247,7 @@ static int sc27xx_efuse_probe(struct platform_device =
*pdev)
>  	econfig.reg_read =3D sc27xx_efuse_read;
>  	econfig.priv =3D efuse;
>  	econfig.dev =3D &pdev->dev;
> +	econfig.add_legacy_fixed_of_cells =3D true;
>  	nvmem =3D devm_nvmem_register(&pdev->dev, &econfig);
>  	if (IS_ERR(nvmem)) {
>  		dev_err(&pdev->dev, "failed to register nvmem config\n");
> diff --git a/drivers/nvmem/sec-qfprom.c b/drivers/nvmem/sec-qfprom.c
> index e48c2dc0c44b..19799b3fe00a 100644
> --- a/drivers/nvmem/sec-qfprom.c
> +++ b/drivers/nvmem/sec-qfprom.c
> @@ -47,6 +47,7 @@ static int sec_qfprom_probe(struct platform_device *pde=
v)
>  {
>  	struct nvmem_config econfig =3D {
>  		.name =3D "sec-qfprom",
> +		.add_legacy_fixed_of_cells =3D true,
>  		.stride =3D 1,
>  		.word_size =3D 1,
>  		.id =3D NVMEM_DEVID_AUTO,
> diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
> index 7e6e31db4baa..bb3105f3291f 100644
> --- a/drivers/nvmem/sprd-efuse.c
> +++ b/drivers/nvmem/sprd-efuse.c
> @@ -408,6 +408,7 @@ static int sprd_efuse_probe(struct platform_device *p=
dev)
>  	econfig.read_only =3D false;
>  	econfig.name =3D "sprd-efuse";
>  	econfig.size =3D efuse->data->blk_nums * SPRD_EFUSE_BLOCK_WIDTH;
> +	econfig.add_legacy_fixed_of_cells =3D true;
>  	econfig.reg_read =3D sprd_efuse_read;
>  	econfig.reg_write =3D sprd_efuse_write;
>  	econfig.priv =3D efuse;
> diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
> index 0f84044bd1ad..1541c20709d2 100644
> --- a/drivers/nvmem/stm32-romem.c
> +++ b/drivers/nvmem/stm32-romem.c
> @@ -207,6 +207,7 @@ static int stm32_romem_probe(struct platform_device *=
pdev)
>  	priv->cfg.priv =3D priv;
>  	priv->cfg.owner =3D THIS_MODULE;
>  	priv->cfg.type =3D NVMEM_TYPE_OTP;
> +	priv->cfg.add_legacy_fixed_of_cells =3D true;
> =20
>  	priv->lower =3D 0;
> =20
> diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
> index f3a18aa0a6c7..38f5d9df39cd 100644
> --- a/drivers/nvmem/sunplus-ocotp.c
> +++ b/drivers/nvmem/sunplus-ocotp.c
> @@ -145,6 +145,7 @@ static int sp_ocotp_read(void *priv, unsigned int off=
set, void *value, size_t by
> =20
>  static struct nvmem_config sp_ocotp_nvmem_config =3D {
>  	.name =3D "sp-ocotp",
> +	.add_legacy_fixed_of_cells =3D true,
>  	.read_only =3D true,
>  	.word_size =3D 1,
>  	.size =3D QAC628_OTP_SIZE,
> diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> index 5d364d85347f..ba14a76208ab 100644
> --- a/drivers/nvmem/sunxi_sid.c
> +++ b/drivers/nvmem/sunxi_sid.c
> @@ -153,6 +153,7 @@ static int sunxi_sid_probe(struct platform_device *pd=
ev)
>  	nvmem_cfg->dev =3D dev;
>  	nvmem_cfg->name =3D "sunxi-sid";
>  	nvmem_cfg->type =3D NVMEM_TYPE_OTP;
> +	nvmem_cfg->add_legacy_fixed_of_cells =3D true;
>  	nvmem_cfg->read_only =3D true;
>  	nvmem_cfg->size =3D cfg->size;
>  	nvmem_cfg->word_size =3D 1;
> diff --git a/drivers/nvmem/uniphier-efuse.c b/drivers/nvmem/uniphier-efus=
e.c
> index 0a1dbb80537e..6ad3295d3195 100644
> --- a/drivers/nvmem/uniphier-efuse.c
> +++ b/drivers/nvmem/uniphier-efuse.c
> @@ -52,6 +52,7 @@ static int uniphier_efuse_probe(struct platform_device =
*pdev)
>  	econfig.size =3D resource_size(res);
>  	econfig.priv =3D priv;
>  	econfig.dev =3D dev;
> +	econfig.add_legacy_fixed_of_cells =3D true;
>  	nvmem =3D devm_nvmem_register(dev, &econfig);
> =20
>  	return PTR_ERR_OR_ZERO(nvmem);
> diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
> index f49bb9a26d05..7f15aa89a9d0 100644
> --- a/drivers/nvmem/zynqmp_nvmem.c
> +++ b/drivers/nvmem/zynqmp_nvmem.c
> @@ -58,6 +58,7 @@ static int zynqmp_nvmem_probe(struct platform_device *p=
dev)
> =20
>  	priv->dev =3D dev;
>  	econfig.dev =3D dev;
> +	econfig.add_legacy_fixed_of_cells =3D true;
>  	econfig.reg_read =3D zynqmp_nvmem_read;
>  	econfig.priv =3D priv;
> =20
> diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
> index 07ede21cee34..37df7e80525b 100644
> --- a/drivers/rtc/nvmem.c
> +++ b/drivers/rtc/nvmem.c
> @@ -21,6 +21,7 @@ int devm_rtc_nvmem_register(struct rtc_device *rtc,
> =20
>  	nvmem_config->dev =3D dev;
>  	nvmem_config->owner =3D rtc->owner;
> +	nvmem_config->add_legacy_fixed_of_cells =3D true;
>  	nvmem =3D devm_nvmem_register(dev, nvmem_config);
>  	if (IS_ERR(nvmem))
>  		dev_err(dev, "failed to register nvmem device for RTC\n");
> diff --git a/drivers/w1/slaves/w1_ds250x.c b/drivers/w1/slaves/w1_ds250x.c
> index 7592c7050d1d..cb426f7dd23d 100644
> --- a/drivers/w1/slaves/w1_ds250x.c
> +++ b/drivers/w1/slaves/w1_ds250x.c
> @@ -168,6 +168,7 @@ static int w1_eprom_add_slave(struct w1_slave *sl)
>  	struct nvmem_device *nvmem;
>  	struct nvmem_config nvmem_cfg =3D {
>  		.dev =3D &sl->dev,
> +		.add_legacy_fixed_of_cells =3D true,
>  		.reg_read =3D w1_nvmem_read,
>  		.type =3D NVMEM_TYPE_OTP,
>  		.read_only =3D true,
> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provide=
r.h
> index dae26295e6be..1b81adebdb8b 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -82,6 +82,7 @@ struct nvmem_cell_info {
>   * @owner:	Pointer to exporter module. Used for refcounting.
>   * @cells:	Optional array of pre-defined NVMEM cells.
>   * @ncells:	Number of elements in cells.
> + * @add_legacy_fixed_of_cells:	Read fixed NVMEM cells from old OF syntax.
>   * @keepout:	Optional array of keepout ranges (sorted ascending by start=
).
>   * @nkeepout:	Number of elements in the keepout array.
>   * @type:	Type of the nvmem storage
> @@ -112,6 +113,7 @@ struct nvmem_config {
>  	struct module		*owner;
>  	const struct nvmem_cell_info	*cells;
>  	int			ncells;
> +	bool			add_legacy_fixed_of_cells;
>  	const struct nvmem_keepout *keepout;
>  	unsigned int		nkeepout;
>  	enum nvmem_type		type;
>=20




