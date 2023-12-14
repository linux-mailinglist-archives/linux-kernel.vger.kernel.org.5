Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E01813734
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjLNREw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLNREu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:04:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B3EA0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:04:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339BAC433C7;
        Thu, 14 Dec 2023 17:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702573497;
        bh=C97ruMhJD+gwin8Xnu1LxzszeY6cxubadNcfiKJUIwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YI3IJG6Lrj/HrM1w+0YF6QRLpTy5ywxmGCt1xrbg3M6yQAZkbul9dR7KVAh61p3Vy
         6O/cITES1ZMQMJmH/7O1zvs3FaUz1bhz1fIgD4u3zjObCyYA7ilwzbFmUtvNuE0HHG
         AGZeBj1VZD3AWNK4ZSxz0UwGUoLUdqfqW/Gfp0OHS4xyaGXSJIxZasuQBpziKeN9M2
         gquPYYYZgeqkbl2jfiuXPFKMdVgueXfGox1LOBEXfVx7bj/Q/r+9uVaRkL3UXoD2wT
         PM/uwb4ivacX+FDYVjDe1awrKPWQhzqt0GdzScTAPZvSyxlLAS3tWzOQ4wEIfdrIYc
         JCKbhjGAeITLA==
Date:   Thu, 14 Dec 2023 17:04:52 +0000
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
Message-ID: <cd926fd5-e607-491f-8bf8-40f404d56ea3@sirena.org.uk>
References: <20231213123556.20469-1-lujianhua000@gmail.com>
 <7b13b8b6-9048-48a3-b1a1-e62de88e8171@sirena.org.uk>
 <ZXsklsO7nOqBFgzt@Gentoo>
 <bee0ab28-6bd3-4904-8afc-44fe7ddacb79@sirena.org.uk>
 <ZXszbA5fVq2AMjEb@Gentoo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JCIFsr6HNtGfUJfo"
Content-Disposition: inline
In-Reply-To: <ZXszbA5fVq2AMjEb@Gentoo>
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


--JCIFsr6HNtGfUJfo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 15, 2023 at 12:55:08AM +0800, Jianhua Lu wrote:
> On Thu, Dec 14, 2023 at 03:56:52PM +0000, Mark Brown wrote:
> > On Thu, Dec 14, 2023 at 11:51:50PM +0800, Jianhua Lu wrote:

> > > Currently, qcom TDM setup need to read hw_params, if we want to move it
> > > to machine driver, we must hardcode some params, but it will reduce reduce
> > > readability.

> > What makes you say that TDM setup needs to read hw_params?

> qcom_snd_tdm_hw_params function read PCM_FORMAT to set slot_width value, read
> channels to set rx_mask value.

A large part of the purpose of doing TDM configuration is to fix the
slot width and assign which slots are in use by this interface - the TDM
configuration is a constraint on what hardware paramters can be set and
should always be followed regardless of what is being done with the
audio stream.  If you're just trying to configure the sample size for
DSP modes then that shouldn't go through the TDM configuration API,
that's just normal hw_params() so should be done directly.  Possibly the
hardware doesn't support manual TDM configuration?

--JCIFsr6HNtGfUJfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV7NbMACgkQJNaLcl1U
h9CaTAf/QuuvzKht/LhszwAptQsmHYSw9+3gn9Ddg+d9YAEb6/OWNMxB2kDd2hJ+
pfflmY+FKXTgJS6MskMch8Dxuc0QV/eInQwS6waQO4QjCZ/rqAHTutMLj/Hf7GDq
51FCW7bGjJOnnTn353AW3e6LoiwP6CMKhnw0ZVue2advz+frgtPZQF1NfWoVroIf
AJn1YspPewXTyysr99iHRJVNAGWevm5yg/fhUDtJA39qa0VM1l4AnYnW6ONoAT+Q
lNlFkDH22WUAzLS2lh+vqU+hd6ji18ldAzZ4KaiXFqBFQ2ag7Af7sckObeANsBLZ
fq5EK41S13Jqa3AZ5k1Q0CemAw0jZg==
=xdNX
-----END PGP SIGNATURE-----

--JCIFsr6HNtGfUJfo--
