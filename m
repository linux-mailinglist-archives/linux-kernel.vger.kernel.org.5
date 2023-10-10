Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEDF7BFB1B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjJJMTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjJJMTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:19:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D795A4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:19:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D09C433C7;
        Tue, 10 Oct 2023 12:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696940382;
        bh=sEVlrLrAZSdHFXAv0vW7xg1SHdyTN9p2QBUnItRsFbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BdPOSZBsPAHmivXoJZBs36ei4YrGgNB9IRansk+2wIAaxEghTX8MvO25Q58xFyO92
         d43t6B/xohkgGgBQWIrA9u4Tao5p2A1mauEfueMjXw9pso+WKeDgtSJRFtwbZH4TZz
         ouSIKuYC3pVM0jfOCqidRrClgel+isHmjicigarZeC7rIL6sPsUhhQ9+qS4McGqMBO
         IEwArTTsreKIt36wR5Rfbq6bITZ9EbPMSCTfWx3q1j4KYUOTBR6+17SztT6xLwETEk
         /fQKivkWkDRwM450ZxVn9+5OZ49i8g2UH8fK6cyugwYOhOPZT60OSftZ4i5FJvo+Oy
         PtktLz45TyFVw==
Date:   Tue, 10 Oct 2023 13:19:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/3] regulator: fixed: forward under-voltage events
Message-ID: <5e51792a-cc93-4364-a51b-c2b116d89369@sirena.org.uk>
References: <20231010085906.3440452-1-o.rempel@pengutronix.de>
 <20231010085906.3440452-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sc4/D+hultAuc0Xk"
Content-Disposition: inline
In-Reply-To: <20231010085906.3440452-3-o.rempel@pengutronix.de>
X-Cookie: I feel partially hydrogenated!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sc4/D+hultAuc0Xk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 10, 2023 at 10:59:06AM +0200, Oleksij Rempel wrote:
> Add handler to forward under-voltage events.
> On systems for more or less complicated regulator chains we need to
> forward under-voltage events to actual driver which need to react on
> them.

It isn't clear to me why this would be implemented in one specific
driver, nor why this would be done unconditionally.  Could you provide
some information on the problem you're trying to solve here?  This feels
like something that should be a core feature.

> +static int reg_fixed_regulator_notifier(struct notifier_block *nb,
> +					unsigned long event, void *data)
> +{
> +	struct fixed_voltage_data *priv =
> +		container_of(nb, struct fixed_voltage_data, nb);
> +	struct regulator_dev *rdev = priv->dev;
> +
> +	if (event != REGULATOR_EVENT_UNDER_VOLTAGE_WARN &&
> +	    event != REGULATOR_EVENT_UNDER_VOLTAGE)
> +		return NOTIFY_OK;
> +
> +	regulator_notifier_call_chain(rdev, event, NULL);

This would be better written as a switch statement for extensibility,
and it's not clear why the filtering?

--sc4/D+hultAuc0Xk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUlQVgACgkQJNaLcl1U
h9BzmQf8DlvDTySkrhtUhIgfciqU+pjEPtHsKQqoDt7De9vv7WBpPjMCs9c8j27a
Bh1J0WSWgde+2u39XUSddSwJyWnNwUdJSM0CeZKXd0bEYPfsVHpCrxVbq3RGes83
sr+3cD6QylEJmNwtmvqiMKfrzfRWZIZIAAJb6a/o1hYY+OgrY1ddK+KAJTIP195t
azfhhfMmHANcCAqqsdIJX3++16Wg+fI+XuntB4nb4LKQFfDtOdtuK29rh0Vd3ox6
hODpV3nf4yF2h/QugxX/neL4Cjg8Xi/Tkgq90E557WcMH2MRzYchNfgwFjztfHzK
JQWDqvRIw/+u3TdwWkTYuxLw2LlsQg==
=K/BW
-----END PGP SIGNATURE-----

--sc4/D+hultAuc0Xk--
