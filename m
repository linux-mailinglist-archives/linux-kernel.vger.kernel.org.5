Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210A97DCD1B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344298AbjJaMlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344246AbjJaMlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:41:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8FB97
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:41:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B07C433C7;
        Tue, 31 Oct 2023 12:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698756109;
        bh=zWSLV7OqTO7fjuZ1oF+Fq43mMRHT9MLHeYnDIzIn1ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U4pmJS/F2FQlIrYRIY4eD0PK3/c1vIp8rPVgaBVutzEfL+WdmPYp46dxtwdg6QGSf
         hrva00UzYQeAnEyQznB2v+H9b3rtcC2sJ7TMN1huk3iuIn9gs0l8Y82j/IHQRvMyZ3
         vMKkq/BCE4k+jBiBmuITYQvYKGWUJnibTy93NIDt6ZPkzixB/zyjZ5lAAkhcyuXmz2
         BFs8d2Y6+Hrdp50LHG61aUeSb2dy5zXqn4klqGzxyaJRtqpw2P3nY87oDSFJcpFe/5
         2K1NUm4Xqamre0Z4TPPzer7ZYANaWrNtWsYjQrvDZ8B53poSmCQTNQEfBHKKJHhcM8
         k/xJon0UObhXg==
Date:   Tue, 31 Oct 2023 12:41:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/6] regulator: bcm590xx: Add support for BCM59054
Message-ID: <53aae3a6-9e6f-4156-b807-082d11d858ed@sirena.org.uk>
References: <20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com>
 <20231030-bcm59054-v2-5-5fa4011aa5ba@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UpRfkmziJnKTBjHv"
Content-Disposition: inline
In-Reply-To: <20231030-bcm59054-v2-5-5fa4011aa5ba@gmail.com>
X-Cookie: Is it clean in other dimensions?
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UpRfkmziJnKTBjHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 30, 2023 at 08:41:47PM +0100, Artur Weber wrote:
> The BCM59054 is fairly similar in terms of regulators to the already
> supported BCM59056, as included in the BCM590XX driver.

> Add support for the BCM59054's regulators to the BCM590XX driver.
> Switch from using defines for common checks to using functions which
> return different values depending on the identified MFD model.

> While we're at it, fix a bug where the enable/vsel register
> offsets for GPLDO and LDO regulators were calculated incorrectly.

> Also, change the regulator enable bitmask to cover the entire PMMODE
> register.

As is very clear from the commit log this is a whole bunch of changes
which really should be split out into multiple patches.  There's the
bug fix, there's the multiple refactorings to support the new device and
the new device itself.  As covered in submitting-patches.rst you should
do one change per patch, this makes things much easier to follow.

> +	if (pmu->mfd->device_type == BCM59054_TYPE) {
> +		info = bcm59054_regs;
> +		n_regulators = BCM59054_NUM_REGS;
> +	} else if (pmu->mfd->device_type == BCM59056_TYPE) {
> +		info = bcm59056_regs;
> +		n_regulators = BCM59056_NUM_REGS;
> +	}

There's no error handling here if there's an unknown type.

> -		if ((BCM590XX_REG_IS_LDO(i)) || (BCM590XX_REG_IS_GPLDO(i))) {
> +		if (bcm590xx_reg_is_ldo(pmu, i) || \
> +				bcm590xx_reg_is_gpldo(pmu, i)) {
>  			pmu->desc[i].ops = &bcm590xx_ops_ldo;
>  			pmu->desc[i].vsel_mask = BCM590XX_LDO_VSEL_MASK;
> -		} else if (BCM590XX_REG_IS_VBUS(i))
> -			pmu->desc[i].ops = &bcm590xx_ops_vbus;
> -		else {
> +		} else if (bcm590xx_reg_is_static(pmu, i)) {
> +			pmu->desc[i].ops = &bcm590xx_ops_static;
> +		} else {
>  			pmu->desc[i].ops = &bcm590xx_ops_dcdc;
>  			pmu->desc[i].vsel_mask = BCM590XX_SR_VSEL_MASK;
>  		}

It seems like everything would be a lot simpler and clearer to just have
tables of regulators per device rather than have all these conditionals.

--UpRfkmziJnKTBjHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVA9gcACgkQJNaLcl1U
h9AgHAf/fXAIYfkZOEjidR1JA8aj8T+gmmVW38F5iafSQpIYGKnkq58f+AZTAJa8
apU9HeN3u8zGGeKDwEbVR77SOBZFeBiVrWOcuPgV2iHt6rjcZarVJo6xdt/SNMlu
rz35kfi3w8R27zzgT3q5V/7WWpfE0KxJwj7E+DWqVO7rKEwVtxEh0APHDy7WRVg6
6KZxHMZj3/4iTfA1j4Q+i6qz5aMhy0GRZrBpke3zocc5qbZlccFOVkXIWNRgKm0I
l/NSor7QAq7jg5YIEF74ITxsAjFYaIKf0ZUbqMSGITOUubpGH3J6MwyC3y4iWJf3
r0wQxybrqX+ffkM5vu56fafygzUmgA==
=8PAM
-----END PGP SIGNATURE-----

--UpRfkmziJnKTBjHv--
