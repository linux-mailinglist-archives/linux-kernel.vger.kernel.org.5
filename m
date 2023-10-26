Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908EB7D83F1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345118AbjJZNz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbjJZNzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:55:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8601AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:55:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8655C433C8;
        Thu, 26 Oct 2023 13:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698328520;
        bh=5Ibq5Q2b6kNTww8PLC2zpz+31ms1Um2eROt680O2BHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dSOIYGyVdy2z/l/T0a1Qwm2GDCF96yyux/z86sMl6qc4VlkUCbNC5IkORopWISQN6
         K9PK+iV/uonZwpwqV7fwDU1R/mTxv5aySGPgVGo9d6x+Fv8R+krnQXDWCb00ydi0ME
         1E2NpPTBYf/K3UmKkaKcvyHzkFrTggA9MvUfL/GtHTzgA0MuQJuHE4LyfggjHRMNaw
         AygmVp8SChcoR4uA0pr9k9D6mCSbi8i88/QGLzIix0FAxFkHmkGLdkYwEl4NEerBXG
         lWTFz3CIhK4+VWVwXxhvtFghiJWv5cqriP3feotrz1pmMpv6vYF7UYwAdMotwxyD85
         p6w8vWmWagJmA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qw0pr-0006of-1v;
        Thu, 26 Oct 2023 15:55:43 +0200
Date:   Thu, 26 Oct 2023 15:55:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        johan+linaro@kernel.org, steev@kali.org,
        dmitry.baryshkov@linaro.org
Subject: Re: [PATCH 3/4] ASoC: codecs: wsa883x: mute/unmute PA in correct
 sequence
Message-ID: <ZTpv3_kYTbOh2eUY@hovoldconsulting.com>
References: <20230323164403.6654-1-srinivas.kandagatla@linaro.org>
 <20230323164403.6654-4-srinivas.kandagatla@linaro.org>
 <ff3eb88a-6941-4303-a4ba-17cad3842b88@sirena.org.uk>
 <2a0aabf5-41a3-cc07-3203-9b0bca6b71aa@linaro.org>
 <ZTjKWHAAfSYfc5px@hovoldconsulting.com>
 <6df45f92-5fe6-4b44-af04-c528d540ac06@sirena.org.uk>
 <ZTkNcHAzgnL5xpAO@hovoldconsulting.com>
 <9c622323-6b94-4622-840f-5f126942ae96@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VVJx21a7MFh1MrX1"
Content-Disposition: inline
In-Reply-To: <9c622323-6b94-4622-840f-5f126942ae96@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VVJx21a7MFh1MrX1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 02:05:25PM +0100, Mark Brown wrote:
> On Wed, Oct 25, 2023 at 02:43:28PM +0200, Johan Hovold wrote:
> > On Wed, Oct 25, 2023 at 01:36:14PM +0100, Mark Brown wrote:
> > > On Wed, Oct 25, 2023 at 09:57:12AM +0200, Johan Hovold wrote:
>=20
> > > > I understand Srini has looked at this but has not yet been able to =
come
> > > > up with a generic implementation. Would it be possible to merge the=
 two
> > > > codec fixes as an interim workaround for 6.7?

> So, having gone and fished the series out of lore to look at what the
> patches are I'm pretty surprised here, it's been about six months since
> the original discussion and I'd not have expected this to be such a
> difficult thing to do, or at least that any issues would have been
> flagged up by now.  What are the issues that have been encountered here?

I'm also surprised that this has not yet been resolved, especially given
that I've been reminding Srini about the need to get this fixed
repeatedly for the past six months.

I haven't looked at this myself yet and I don't know what the technical
issues he hinted about having run into would be.

Srini, can you provide some details?

Johan

--VVJx21a7MFh1MrX1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZTpv2wAKCRALxc3C7H1l
CO+CAP997q0itC7uj37ZLjWkrVX2kK5YCakwXEo2cZ9+7uxGCQEAogaJB3d3AUNc
p78DfnBVBDmH8Dy6vi0L/VNuTvLNjQs=
=H7Nx
-----END PGP SIGNATURE-----

--VVJx21a7MFh1MrX1--
