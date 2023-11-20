Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342637F1723
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbjKTPSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjKTOkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:40:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B468112;
        Mon, 20 Nov 2023 06:40:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12022C433D9;
        Mon, 20 Nov 2023 14:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700491241;
        bh=fKSFDTPaD6Lcq6nGxYGityzYPzRmBFK23grRo+/lSPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=km2pYWqSd0Akzz7o5kzivimfr413uygrPREk+75MALZPGzevA//nGj1CPjLaS6tia
         hT7CZk+8Db35Jek1PHuWWP+fJIVcNv+TGwkouyWdN4Fhefe87L34bXIASzl+kGdxQB
         UcUCfP0d/yC14aBvmUII0eZzNNTIjEQfqToI2CZtu/oWinDfAzuv81ovNdsueXlkHb
         df4yUkxLFulA6pDBumapL3Kls1r7Z/B2+5GEsYAFgrHhvqx3Uy6R2knCT8EZuxAUPj
         I1vOsuW9eQ9Pydu1WOb/6y+yxLVF+F+4EYb2e3HgMhPSfpfx3NjRtcg8wnVkCjyIXp
         WTfdDap97Q4RQ==
Date:   Mon, 20 Nov 2023 14:40:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: cs43130: Allow driver to work without IRQ
 connection
Message-ID: <7248897a-0b59-4cdc-9915-d3297f2d6efe@sirena.org.uk>
References: <20231120141734.76679-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ngykg7d4U2ShnusP"
Content-Disposition: inline
In-Reply-To: <20231120141734.76679-1-mstrozek@opensource.cirrus.com>
X-Cookie: <Manoj> I *like* the chicken
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ngykg7d4U2ShnusP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 20, 2023 at 02:17:34PM +0000, Maciej Strozek wrote:

> +	if (cs43130->has_irq_line) {
> +		ret = wait_for_completion_timeout(to_poll, msecs_to_jiffies(time));
> +	} else {

If you just put a return here then you don't need the else and can
reduce the intentation level of the rest of the function, making it more
legible.

> +		if (to_poll == &cs43130->xtal_rdy) {
> +			offset = 0;
> +			flag = CS43130_XTAL_RDY_INT;
> +		} else if (to_poll == &cs43130->pll_rdy) {
> +			offset = 0;
> +			flag = CS43130_PLL_RDY_INT;
> +		} else if (to_poll == &cs43130->hpload_evt) {
> +			offset = 3;
> +			flag = CS43130_HPLOAD_NO_DC_INT | CS43130_HPLOAD_UNPLUG_INT |
> +				CS43130_HPLOAD_OOR_INT | CS43130_HPLOAD_AC_INT |
> +				CS43130_HPLOAD_DC_INT | CS43130_HPLOAD_ON_INT |
> +				CS43130_HPLOAD_OFF_INT;
> +		} else {
> +			return 0;
> +		}

Is it a bug to call this function without to_poll set to something
known?  This will just silently ignore it which seems wrong and is
inconsitent with the handling in the interrupt case which will wait for
the the completion to be signalled and report a timeout on error.

> @@ -2545,8 +2579,10 @@ static int cs43130_i2c_probe(struct i2c_client *client)
>  					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
>  					"cs43130", cs43130);
>  	if (ret != 0) {
> -		dev_err(cs43130->dev, "Failed to request IRQ: %d\n", ret);
> -		goto err;
> +		dev_dbg(cs43130->dev, "Failed to request IRQ: %d, will poll instead\n", ret);
> +		cs43130->has_irq_line = 0;
> +	} else {
> +		cs43130->has_irq_line = 1;

This will treat probe deferral as the interrupt not being supplied, and
will squash even real errors silently - it should probably check for
both the specific error the clock API returns when no clock is provided
by the firmware and probe deferral and handle both specifically.

--ngykg7d4U2ShnusP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVbb+QACgkQJNaLcl1U
h9ANtQf9HpUItxdNu8HZE7UjElxpRzAIFKCaS3TPUtFoTXoNzA+4OKON8YPVsS2q
/Layk4N8U75c4dANNdQ2gj+PvJcsclCig5JowC3T4+DI5OnvuDwgsdRO3YXpSZUx
nwEEJ9F5s1M+YcOpSqmyRK7DIzd7oAySK/omwlETb6xBZxjYuLLAmgIiUl6YUzMk
2TGL2kz1Bue2lVfMoDAHUKm3ciJSjqEZf6yqcLDrBziUYKQHZwInggmGh2Wcn1JP
IOEQWDZBGtTSw+m6X2Y48QnWRVxNiYtwRHamlAlEnXCUKEWwD11x5VWAViGmFhMa
8KqsU+/V7+hpI4BkPQ+jhjhDw8VQQQ==
=M67k
-----END PGP SIGNATURE-----

--ngykg7d4U2ShnusP--
