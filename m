Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B179078B886
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjH1Tjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjH1TjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:39:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B2C12F;
        Mon, 28 Aug 2023 12:39:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8154D6475E;
        Mon, 28 Aug 2023 19:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1FDC433C8;
        Mon, 28 Aug 2023 19:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693251560;
        bh=zuRblMquL75h66BAHp2HzufNQ+pbQGVcWUOzMVV/uVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qer4oeWvqVuAXXmGE3r0+p62B+xJcj23lHhzq0+ym3nKcS5maLgpFmoU0epY/FrLq
         xgVlp/URtzJ1aXBVTPwfcRxplGetqo+QkSnNyjaUVZUzzNNEysJnTURkgxzBGgDB6R
         M9HIi6OmFTo+pWKQhKAocJZl0hToRoAqOa5EKxml/k+IaIv5H47W1bAmpY3s0liyk9
         evkW0Fe3PSGDG6LmRp3UtwLSbvSwH2RJdLFKBqb0y4nxCGoiDzP1SHPJQ1eYl6QEex
         pcKwrfyscFxlXylo3mbINlGn9zyj6o3513Ve29J3to0rLqOfXp7BXxiA8qLAcLP2EK
         hbC3NKLXfZOzg==
Date:   Mon, 28 Aug 2023 20:39:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        RicardoRivera-Matosricardo.rivera-matos@cirrus.com
Subject: Re: [PATCH 4/7] ASoC: cs35l45: Analog PCM Volume and Amplifier Mode
 controls
Message-ID: <ZOz35ABAsLYROJ4c@finisterre.sirena.org.uk>
References: <20230828170525.335671-1-vkarpovi@opensource.cirrus.com>
 <20230828170525.335671-4-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RuSj6/CZAu0X82sy"
Content-Disposition: inline
In-Reply-To: <20230828170525.335671-4-vkarpovi@opensource.cirrus.com>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RuSj6/CZAu0X82sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 28, 2023 at 12:05:22PM -0500, Vlad Karpovich wrote:

> +static int cs35l45_amplifier_mode_put(struct snd_kcontrol *kcontrol,
> +				      struct snd_ctl_elem_value *ucontrol)
> +{

> +	snd_soc_component_enable_pin_unlocked(component, "SPK");
> +	snd_soc_dapm_sync_unlocked(dapm);
> +	snd_soc_dapm_mutex_unlock(dapm);

> +	cs35l45->amplifier_mode = ucontrol->value.integer.value[0];

> +	return 0;
> +}

This should return 1 on change (I did see that there's some code which
generates notifications but it would still be better to flag changes
here, it makes review a lot easier).

--RuSj6/CZAu0X82sy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTs9+EACgkQJNaLcl1U
h9DzuwgAgwy2vcETGFOVFw/Ki8yb/HOhnBIy0TJB3UqAL1L+6WcQq+HwdayDRocu
wvKE+uqIfK8bgEhXkDMDCnoKucYrNI5CDY/UMjeihYPIKFLOKtTTh31X09OHbStd
O+h9NeP4pyIBvZV6NyrJVH54MMT/dF+XwAOQOhGllbexeZlMi5h9qA736o7ob0bl
YD9eVCVjAQdazTLbLxUwK2fNl/WH+jDch5MH1U2kZwxZ3BYRgZUolgWjUv2y3rgm
fMqUcmmouWcc/WEjvyhUqExQI/6Jy8r8qdskx3mAr5iih8hq9vEwRR7c41eRyEvE
yCE07xjrRi7XESt5SVu1JqWzODjDUQ==
=QHEm
-----END PGP SIGNATURE-----

--RuSj6/CZAu0X82sy--
