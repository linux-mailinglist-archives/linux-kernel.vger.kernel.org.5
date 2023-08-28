Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8859778B708
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjH1SK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjH1SKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:10:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3B711B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C33376444B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 18:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE4CC433C8;
        Mon, 28 Aug 2023 18:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693246201;
        bh=6qVm5eu3nBLA4L41AWZPBY7DE/hYw6IGKyR3CT1kSVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jxqp1PKNeKqxH9XxAtGSVBbcskK8Cl3Fa1hHhIkDQtAbmWs/6QdF0b3jvXIkW+d6h
         fGcUsDp3/5cRjwWglsH0LatFZtPIOB/fXfRzlHFyDoOvZCrNyeJrSrtKLy55l6TwEo
         XN1ZVwjKf+sSPCd6GcYKkHrUukYYSkLw6JegCeKpRmJaztGaTW37ynHq6uWvi/Zh/3
         zSXJMaXGLY+zVVPKnLJvjcr9xwy01mPUpVGgP6IFAzqN2e3fvkw2jP389DpzBBv6Gs
         aiHM0LVjW8Vg9rpWmJ8EZT5/i6ffUtrNZbDqPpodPrkurL11ZeZ/l2dS+PGvYRSRD5
         rOgBOj+lrKQVg==
Date:   Mon, 28 Aug 2023 19:09:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: es8316: Enable support for MCLK div by 2
Message-ID: <ZOzi9BuTo2oXcKta@finisterre.sirena.org.uk>
References: <20230824210135.19303-1-posteuca@mutex.one>
 <20230824210135.19303-3-posteuca@mutex.one>
 <ZOfRXjuSTxSV89SC@finisterre.sirena.org.uk>
 <87msyc9mtm.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+uIW5b0/qxOBqojE"
Content-Disposition: inline
In-Reply-To: <87msyc9mtm.fsf@mutex.one>
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


--+uIW5b0/qxOBqojE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 28, 2023 at 12:50:45AM +0300, Marian Postevca wrote:
> Mark Brown <broonie@kernel.org> writes:

> > machine with this MCLK rather than that's based on the spec.  I would
> > instead suggest applying the MCLK divider in any case where we can do so
> > and still generate suitable clocking for the rest of the system, or at
> > least hit 256fs (the datasheet quotes 256/384fs on the front page which
> > suggests it's targetting 256fs, that'd be a fairly normal number, and
> > there's mention of 12/24MHz USB clocks being directly usable).  Doing
> > this should either make no odds or result in better performance.

> Not 100% sure what checks should be done for a MCLK to determine if it
> generates suitable clocking. Would something along this patch make
> sense?

In general a MCLK that allows you to configure the dividers in the CODEC
appropriately for use.  So long as it works your change looks fine I
think modulo.

> +	do {
> +		/* Validate supported sample rates that are autodetected from MCLK */
> +		for (i = 0; i < NR_SUPPORTED_MCLK_LRCK_RATIOS; i++) {
> +			const unsigned int ratio = supported_mclk_lrck_ratios[i];
> +
> +			if (clk % ratio != 0)
> +				continue;
> +			if (clk / ratio == params_rate(params))
> +				break;
> +		}

Use ARRAY_SIZE()

--+uIW5b0/qxOBqojE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTs4vMACgkQJNaLcl1U
h9Cs2wf9HV5zUoSs/LvsLfOeFiaGB5ddhE+WQq3xn04EGc99oxAxAM0QC74yD/k7
lnmI75j0iaJ0fIvzw15pskMwqqbS1Ttwtqj6H69YFIHBhqKnEbwTEgDuM/Jn8dgc
0jlo28+95C4kIDbp6Lz8oFS4ObJKJ4+Ibnf0yoxiJ0Q5II2EwvUYEGGqMhFTbPDB
H9takbgRwqKbi+06fOUVeag/RCM/N929K+rLez7nd2bPHr9d5vzxnCTh7A99og6T
0c6e2ZMTB2XasURLiHWTj68voJtyucJGOn6AGJPrWAAj39bxytuYZlQTIbEQwR9m
J5O7HY/1N3xAAXWi++H0u0A1HyQBUA==
=oTdg
-----END PGP SIGNATURE-----

--+uIW5b0/qxOBqojE--
