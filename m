Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85CA7C8786
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjJMOLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjJMOLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:11:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F07595
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:11:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76931C433C7;
        Fri, 13 Oct 2023 14:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697206260;
        bh=yblgfOK1RNan7Z74qeOHcSvb7Lln2WHm9wFm6gXbhf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BDgw2I9RUVi8FmfXMdDwfGWWNWixrlRokLda/7jno+fJ0koZRbGXp4dIOEsmtjntk
         6fTddidzhz/mBuaPzrgogyNNdQ4S/lmQAX+MOzr6brBSVnw8KeMcPv8anPgzJdIlKd
         4trW7twlDDnTL7za8haPzW56eNNAUr/sVEvMqRvex2XCQQRRqBNKLpBFiZJEMthMLz
         0RKpWnMpUztZPjibvq/g53a3cHwBso92RdxE1Hu11O9jXTAoWHQ+EnBQkRbto/DNjS
         qQ8ECY/K6f3DxAk2jfce54Obn1QWtZMLUuYoodqBF+OM0hH1f5lS2YGjeCbn5ELlkc
         kJow/8QLddtPw==
Date:   Fri, 13 Oct 2023 15:10:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     wangweidong.a@awinic.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, herve.codina@bootlin.com,
        shumingf@realtek.com, rf@opensource.cirrus.com, arnd@arndb.de,
        13916275206@139.com, ryans.lee@analog.com,
        linus.walleij@linaro.org, ckeepax@opensource.cirrus.com,
        fido_max@inbox.ru, sebastian.reichel@collabora.com,
        colin.i.king@gmail.com, liweilei@awinic.com, trix@redhat.com,
        dan.carpenter@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 3/3] ASoC: codecs: Add aw88399 amplifier driver
Message-ID: <ZSlP8GvTAOe35peC@finisterre.sirena.org.uk>
References: <20231013104220.279953-1-wangweidong.a@awinic.com>
 <20231013104220.279953-4-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ralK2eSCf+ixFXP0"
Content-Disposition: inline
In-Reply-To: <20231013104220.279953-4-wangweidong.a@awinic.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ralK2eSCf+ixFXP0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 13, 2023 at 06:42:20PM +0800, wangweidong.a@awinic.com wrote:

This looks good - some *very* minor comments below.

> +static const struct regmap_config aw88399_remap_config = {
> +	.val_bits = 16,
> +	.reg_bits = 8,
> +	.max_register = AW88399_REG_MAX - 1,

I see this is already the case for the aw88261 driver but it is a bit
weird that _REG_MAX isn't the maximum register - it looks like it should
probably be _NUM_REG.  Not the end of the world though.

> +static int aw_dev_dsp_update_container(struct aw_device *aw_dev,
> +			unsigned char *data, unsigned int len, unsigned short base)
> +{
> +	int i, ret;
> +
> +#ifdef AW88399_DSP_I2C_WRITES
> +	u32 tmp_len;

This looks like debug code which can hopefully be removed in favour of
the regmap implementation?

> +static int aw88399_codec_probe(struct snd_soc_component *component)
> +{
> +	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
> +	struct aw88399 *aw88399 = snd_soc_component_get_drvdata(component);
> +	int ret;
> +
> +	ret = aw88399_request_firmware_file(aw88399);
> +	if (ret < 0) {
> +		dev_err(aw88399->aw_pa->dev, "%s failed\n", __func__);
> +		return ret;
> +	}
> +
> +	INIT_DELAYED_WORK(&aw88399->start_work, aw88399_startup_work);
> +
> +	/* add widgets */
> +	ret = snd_soc_dapm_new_controls(dapm, aw88399_dapm_widgets,
> +							ARRAY_SIZE(aw88399_dapm_widgets));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* add route */
> +	ret = snd_soc_dapm_add_routes(dapm, aw88399_audio_map,
> +							ARRAY_SIZE(aw88399_audio_map));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_add_component_controls(component, aw88399_controls,
> +							ARRAY_SIZE(aw88399_controls));

You should just be able to pass these arrays in the component strucutre?

--ralK2eSCf+ixFXP0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUpT+8ACgkQJNaLcl1U
h9CaAggAgc0J/p2bTSZNLjaIAKHFr9ldNYbl+3tMxNJwBnPfL3p07scPxSt/foY8
rLrtsYpfxKahAjbKlN1R9JtZVYuMyUfO33ed2Ww093sWB513nZMd31yCzh1+sY1g
DlRT6ezLSe2XTkGTt2mFyzJcqLZOIrIzfOndism4/Esuk872ziqlaMTjq/2GBLVb
WNY4D5bUcRxlFl1jphCDCSsJYCy9lpZMLaHPWrlbJh0tq1k5r7WvJ/rG0vOhGQTN
GT5x1j0CifyeA5x5TjI/wWuJhAVRjHxc4NYaI8806i34cybrI8JUIf98JYyD/M7+
7xDFdzxO/GXPZzSRctMol3uf+grzhQ==
=22g1
-----END PGP SIGNATURE-----

--ralK2eSCf+ixFXP0--
