Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7657D9D03
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346167AbjJ0Pct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjJ0Pcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:32:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83DE186
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:32:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4065C433CC;
        Fri, 27 Oct 2023 15:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698420764;
        bh=aChtwQGdHEGlL/2vHSMUTmEjJHwKdxF69/sIZezXbkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1aMFD/pecquhT5urGcllCPxNxNhhAJ+4z2/3M2sxxhBbVXvc7yJ9VmyhScgBJ7yX
         7RWIP1Wf3E6EJrvlyBYkvT5cFH0l677Y5Uz89WoRLJlna37ukA7h786W7n4sIT28UW
         TuX8Tg7tdBWbvizs8EWM0as6WJTl9RM99yD08BuvFg6TGpsFnYZ4et3B5nVSHmCBA0
         mRiYmOxQNwKFvrbzpwMEWy1zTbGivYGTYo6OabXnxzUbnE1tR9ATX5xMq8u705BPUu
         /b9lACQs1snP+ZThGBH3V5HbfO2S+D3GfSswdkEfQnDXrYvAt6SJd3cg+OpMJMP/6l
         9a7imxoufexgA==
Date:   Fri, 27 Oct 2023 16:32:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        johan@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [RFC PATCH 0/2] ASoC: soc-dai: add flag to mute and unmute
 stream during trigger.
Message-ID: <ZTvYFzwltTCMqUHY@finisterre.sirena.org.uk>
References: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
 <54c44548-c2e4-466d-bfe4-b48db9e5d20c@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9XWll2GzhA2eHJ8H"
Content-Disposition: inline
In-Reply-To: <54c44548-c2e4-466d-bfe4-b48db9e5d20c@linux.intel.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9XWll2GzhA2eHJ8H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 02:00:13PM +0200, Amadeusz S=C5=82awi=C5=84ski wrot=
e:
> On 10/27/2023 12:57 PM, Srinivas Kandagatla wrote:

> > Click/Pop Noise was a long pending issue with WSA Codecs which are prone
> > to accumlate DC when ports are active but without any data streams.
> > There are multiple places in the current setup, where this could happen
> > in both startup as well as shutdown path.

> Have you tried something like:
> diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
> index e40d583a1ce6..f02362cf95dc 100644
> --- a/sound/soc/codecs/wsa883x.c
> +++ b/sound/soc/codecs/wsa883x.c

=2E..

> WSA883X_VBAT_ADC_COEF_F_1DIV2);
> +               snd_soc_component_write_field(component, WSA883X_DRE_CTL_=
1,
> +                                             WSA883X_DRE_GAIN_EN_MASK, 0=
);
>                 snd_soc_component_write_field(component, WSA883X_PA_FSM_C=
TL,

=2E..

> As it is one thing from wsa883x_digital_mute() which seems missing in
> SND_SOC_DAPM_PRE_PMD switch case, so it seems to leave GAIN always enable=
d?
>=20
> Anyway this seems like something that if possible should be fixed on codec
> driver side instead of introducing global flag?

If the issue is that the device misbehaves as soon as the incoming data
stream stops then we need to do something strictly before we do the
actual trigger operation which we don't currently have hooks for.  Even
if we run quickly after the trigger there's going to be a window where
there's no incoming audio and no mute.

--9XWll2GzhA2eHJ8H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU72BcACgkQJNaLcl1U
h9BJdAf+MgNS4dzqiUaPAPLBuQUJ8Eds5JgTvgd3LKT+ci6/ihqIo1ohl8ioniwe
qDfG8kH2PGHNtVh6V0ZscNaO2Q3tH4CZThajaxH001HBk71wAFIUg+6vI9jt398v
gbg42Pvss2VLiDiapocyo9f84icai+r8rB6HKdVogHAuFwzyGL0OBjkF7bEPBleF
6FAY8tkbmGzcvj4/nN9iKnhkD4Sw4uGfGYQ/LPFv4I/62I+3NyIGsExKYDs/c9bP
k2rWh8EX/FngG+qXZxxvDjL/OOY5omvv6nTiHe+yWnga2028i2dT09KEdDkhiqm+
Ci1KBcmqgkk17tL/brBL14W5BxkOpA==
=vQG3
-----END PGP SIGNATURE-----

--9XWll2GzhA2eHJ8H--
