Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1E775E2D0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 17:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjGWPMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 11:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGWPMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 11:12:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF8AD1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 08:12:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E682C60DC4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 15:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2B8C433C7;
        Sun, 23 Jul 2023 15:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690125140;
        bh=7aE78xDzl/ON3r/nv0LAZnUncUCQ/xBV5NONfduK9ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jOVIIRv3sXq4FXkR6BZW4hfETFGqFM/tqUeagS7jLSdqtBBLQYbjNIbG2m7LcSsUP
         kNTA2oyNqg6OZKJWeNrQuSEIrUyKohWnNOVkK+AZ7mJSmpVj195F3U7tK7Mp2rdC56
         caOZ7u9hsvwio4IdPJokCjMMXPH14M1IkllBCy1QKk+29I7XGyvPYlWwD6Wncl9SDd
         OVyLq1BCqfZF4kuxOnZYuBmrkNVrOglX4d9FYYXwFGgGIDuAPFYtXRFcbGyg9XYh+S
         i17akoLyw9kx6G5W/EEz3WCC2PNDb3KRJl8LwdRSo8kWvVUM9IKgfcFIRY9Ay1F5hJ
         rSxozhjzKsUXQ==
Date:   Sun, 23 Jul 2023 16:12:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     oder_chiou@realtek.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: rt5665: add missed regulator_bulk_disable
Message-ID: <ZL1DUWAeBbArQL1f@finisterre.sirena.org.uk>
References: <tencent_AA66A80A12D4372BB57E5B7A60471EB00A08@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RGYqtdSr/tWD83Ar"
Content-Disposition: inline
In-Reply-To: <tencent_AA66A80A12D4372BB57E5B7A60471EB00A08@qq.com>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RGYqtdSr/tWD83Ar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 23, 2023 at 03:07:31PM +0800, Zhang Shurong wrote:

> +	ret = devm_add_action_or_reset(&i2c->dev, rt5665_i2c_disable_regulators,
> +			rt5665);
> +	if (ret)
> +		return ret;
> +
>  	ret = regulator_bulk_enable(ARRAY_SIZE(rt5665->supplies),
>  				    rt5665->supplies);
>  	if (ret != 0) {

This will attempt to disable the regulators if the initial enable fails
which is a bug.

--RGYqtdSr/tWD83Ar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS9Q1AACgkQJNaLcl1U
h9BHjQf/aCDfhC3YfwWnLCjc1UBV+wGtWAEEvrQyc4lgEtRAfTxg8aMYh5uoDDHh
Jf9iWUR4pnv1O54RJcD2I+3mWZKhrXBz5f43jQ0VrkUWACRnE/zVNr2jdQLq/DB3
LCc6Sh6gpfmJOqLhhjZoi5Dvt7fYPZH2cnqTLqNW4Ghql8XrEYpdWCsZffUkKitp
iTxfMd98oGz1SLSHqs9BP0V3DxB3yiZnnvijeQk04gZNENTXczpp1shvuriC8669
1HAkxm93xb6lW0kQDPsiysThYCT3ZiH2PjCXjMhq/J0hbgnKzTQd2HWH1dZ4cJNO
wqQbNFikIKFmu5nP3ZjshAPCRUUJQA==
=VBnm
-----END PGP SIGNATURE-----

--RGYqtdSr/tWD83Ar--
