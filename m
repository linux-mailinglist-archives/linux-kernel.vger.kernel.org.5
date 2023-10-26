Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EF87D8340
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344969AbjJZNFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjJZNFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:05:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2895412A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:05:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DCCC433C7;
        Thu, 26 Oct 2023 13:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698325530;
        bh=cNusDpyZxnvyLEqSRhYFk1jLbzQXc/rViNGZhUcC+Tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ni2zlJ6nxjzV+09ncyfuuZhW0x88pV07KMAWYut+At+GVo7aJMuDQYHhOn8iP2z3b
         X9mn4oNGuCevgbkh4S6kdojtLKRNCQkvW5JlRJvbSlMe9HO1sdLy5jdSdCugZryuwu
         b4qUWA8hYzMgug5LLhM78AZ6MUPiEcTzJ8KOU+FebQFch2JbYm+CvpUH4is/kykIBq
         zCglek5l/ECJvHKn7C/pjUc63Gobe+ghT+BpGaEqM2/wzJ/VKAjdDViZMRq4a+8pX5
         euNUheIkyxc8JZ2NgjVClP8ooV+FDbvA2LXa06yceghcXSTMjKaDg7Q1eSpWgH2D8I
         fh3V6L6RdR76g==
Date:   Thu, 26 Oct 2023 14:05:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        johan+linaro@kernel.org, steev@kali.org,
        dmitry.baryshkov@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 3/4] ASoC: codecs: wsa883x: mute/unmute PA in correct
 sequence
Message-ID: <9c622323-6b94-4622-840f-5f126942ae96@sirena.org.uk>
References: <20230323164403.6654-1-srinivas.kandagatla@linaro.org>
 <20230323164403.6654-4-srinivas.kandagatla@linaro.org>
 <ff3eb88a-6941-4303-a4ba-17cad3842b88@sirena.org.uk>
 <2a0aabf5-41a3-cc07-3203-9b0bca6b71aa@linaro.org>
 <ZTjKWHAAfSYfc5px@hovoldconsulting.com>
 <6df45f92-5fe6-4b44-af04-c528d540ac06@sirena.org.uk>
 <ZTkNcHAzgnL5xpAO@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S8PzKVa+OunEe76B"
Content-Disposition: inline
In-Reply-To: <ZTkNcHAzgnL5xpAO@hovoldconsulting.com>
X-Cookie: I'm also against BODY-SURFING!!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S8PzKVa+OunEe76B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 25, 2023 at 02:43:28PM +0200, Johan Hovold wrote:
> On Wed, Oct 25, 2023 at 01:36:14PM +0100, Mark Brown wrote:
> > On Wed, Oct 25, 2023 at 09:57:12AM +0200, Johan Hovold wrote:

> > > I understand Srini has looked at this but has not yet been able to come
> > > up with a generic implementation. Would it be possible to merge the two
> > > codec fixes as an interim workaround for 6.7?

> > You're talking about two fixes here but this is a 4 patch series...

> Yes, sorry, I should have been more clear. I was talking about the codec
> fixes so that's patch 3 and 4.

> I believe the first two have already been applied.

So, having gone and fished the series out of lore to look at what the
patches are I'm pretty surprised here, it's been about six months since
the original discussion and I'd not have expected this to be such a
difficult thing to do, or at least that any issues would have been
flagged up by now.  What are the issues that have been encountered here?

--S8PzKVa+OunEe76B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU6ZBQACgkQJNaLcl1U
h9CoWwf/czxazVwv2xOxm4GAYE1nhKBy3faZlKBN3zJKj7ZEcDHorF/p0Ob+LAIY
r64OiYQnPRzuZ93XOK9aos+ApK9V/RyVG9oX1Txq+Lyf0p0MseB2VuGadmpZx+19
rBD2eG61ZFh0TCcLCNSe52bF4pb7NOQLKolFnb29wVkFyoNJhBq82uJko1Gr5uMc
q+F/eh9pQNKLrtF5XNBS9rib4+M2tMYx/TcoB66Fn0pYDaAdoKoYfR+E701q7CbJ
JiQY/nT9i2MOHnGXBCM2SR7FFvTBJdvGKac07khIQN8l1HBnbK4RF2xEhZq59D6a
wbFNvuIebxfncim9pbFNF4bCSZABuw==
=tHu5
-----END PGP SIGNATURE-----

--S8PzKVa+OunEe76B--
