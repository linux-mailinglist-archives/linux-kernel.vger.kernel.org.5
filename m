Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5A3812E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443957AbjLNLLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443857AbjLNLLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:11:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265F2B7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:11:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A62FC433C7;
        Thu, 14 Dec 2023 11:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702552272;
        bh=tSqtRyvgEQ0GCuf1DdZJacTJr0JiylSUmZyHxqPK9OI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cCNuWUbzFvztyPbxIPZYloc3r2gvIGR44ZX/PAhyUzpsmaGnjfVBeXjODksVQkrRv
         rJ/Fzh7Eq8MOLQm4BiJCnhEFzio5AMHGKVo0RC5Z/J1c5sTyEw9N/zHJpo//kjmBas
         769lb6R6o5NjA0e7soNvl7yKKYl+CuiCTRe6RcQcCZ0Jjdjyys5t0TcCjU5Y+gSN03
         0vjqS9t9E3gECuBpRZ1ivXEE180z0qnDCTsZIYVtH4dBGX7WiLwJ4yCN+OZ7Wx4Tan
         QhydMSyC3NzfjdQMBgQVS6YcMD0QQf/2HQu/yGgkwhTTMR8ijYGFU+3tj2v8nsHzt/
         edNavnPrdwnWQ==
Date:   Thu, 14 Dec 2023 11:11:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] ASoC: qcom: common: Add qcom_snd_tdm_hw_params
 function
Message-ID: <7b13b8b6-9048-48a3-b1a1-e62de88e8171@sirena.org.uk>
References: <20231213123556.20469-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pWlLgRFGMMJxpNhu"
Content-Disposition: inline
In-Reply-To: <20231213123556.20469-1-lujianhua000@gmail.com>
X-Cookie: Preserve the old, but know the new.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWlLgRFGMMJxpNhu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 13, 2023 at 08:35:53PM +0800, Jianhua Lu wrote:

> Add qcom TDM setup function to support TDM ports for qcom platform.

> +int qcom_snd_tdm_hw_params(struct snd_pcm_substream *substream,
> +			   struct snd_pcm_hw_params *params)
> +{

...

> +		ret = snd_soc_dai_set_tdm_slot(cpu_dai, tx_mask, rx_mask, slots, slot_width);
> +		if (ret < 0) {

The expectation is that TDM is set up by the machine driver, not from
hw_params - if the TDM setup can be changed from within hw_params then
it's hard to see how it's going to interact well with other TDM users on
the bus.  More usually hw_params() would be influenced by the setup done
in set_tdm_slot().

--pWlLgRFGMMJxpNhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV64skACgkQJNaLcl1U
h9C9BAf9E/yW6RaCxOVG4VbZ+wP9jHD/RCqjvzrJAain8Y2xlAPZE7PaTuVOBmRh
276IS1kDHcPSzRkXkhKFm1KGpr9nOYR1wGrk9Fku5RQQbOwSjvlpOUSwgd5GpUMf
8PT/7ejXSbJKG0vQZc5hsnbwrPGZdn8X381WXdnexczXxna0Vx/fv1wbkPx4OlA5
Xv2LFN3bTEQDmczWtbGo+64Qe/OnJOudRmn/XWjTjjTY7ztP2M4rDpYN/Bd+fyq5
VCWAFEaXIFlgGti7V3UvDBV86hs3GOWHnDHuapeAxahhWEp1U/JU8/okkRsFy+kK
grHgwa1sQD7a7t9jN8Qc4OpT++24iA==
=krXQ
-----END PGP SIGNATURE-----

--pWlLgRFGMMJxpNhu--
