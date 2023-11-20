Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C3D7F186F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjKTQTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjKTQTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:19:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC63ED;
        Mon, 20 Nov 2023 08:19:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A59DC433C7;
        Mon, 20 Nov 2023 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700497154;
        bh=zPI+e21nyYjzMEzKo0SN9jHwcF4lz+sz54brvdC2b8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVfwlp5SdtqhwP0I976PJXdYckjEzGyjN+RE3ELyFK7teO6jAbhxVTrCooKQB9nng
         zCfdh+UNzp9UCbPlQY9B/BCMD+iD9ioAll3bUx6eMkBbImbnJBwA84uOMZwzUox+Be
         WZ+Ah2o2yJAc5A+WiBCz2abU+qU/N3HEPgh3c2NVY0Z7gNnxVTN8I0n4Z0HU4oRQ8+
         zcOK6BnRK9ERuCnol1itwwR4wKHne7OGHiIvuNZn2bTCuITKekA8fLKlMRLRniMSGQ
         Aud55stw529Z91f2S4F2Qai/Ss8MkHxxETyz69isFfiXRx0F7uH/xIYDTKcmcth/1j
         Mz2x3yEeSc72Q==
Date:   Mon, 20 Nov 2023 16:19:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Maciej Strozek <mstrozek@opensource.cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: cs43130: Allow driver to work without IRQ
 connection
Message-ID: <d13f5857-f386-46b0-9bdd-d832b35617c0@sirena.org.uk>
References: <20231120141734.76679-1-mstrozek@opensource.cirrus.com>
 <7248897a-0b59-4cdc-9915-d3297f2d6efe@sirena.org.uk>
 <261e118d-529b-0ce0-5524-d24d767fa92f@opensource.cirrus.com>
 <c031657a-a1ec-44eb-8885-afee68d7523b@sirena.org.uk>
 <20231120161638.GJ32655@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rzS+1eaHwgk3+pb4"
Content-Disposition: inline
In-Reply-To: <20231120161638.GJ32655@ediswmail.ad.cirrus.com>
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


--rzS+1eaHwgk3+pb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 20, 2023 at 04:16:38PM +0000, Charles Keepax wrote:
> On Mon, Nov 20, 2023 at 03:54:14PM +0000, Mark Brown wrote:

> > It seems like a clear code bug if this is ever called with an unknown
> > completion, I'd expect a WARN_ON_ONCE() there.  The lack of a delay is
> > potentially going to affect how any error handling works which doesn't
> > feel ideal though the users look fine right now.

> I guess perhaps another option might be to not stick so strictly
> to the wait_for_completion_timeout API. This function could
> return an -EINVAL here and a -ETIMEDOUT for a timeout then the
> callers could be updated accordingly.

Yes, that'd help with clarity in terms of the interface - the completion
API is a bit non-standard here.

--rzS+1eaHwgk3+pb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVbhvwACgkQJNaLcl1U
h9DTugf/Xo+maNejN5Jyb9v31+Y+fHdHGg1J8zN/OqLLyg4DRlqQvEHLQ0Z4gc2O
bFjezKAU1O/mblEtNuyzjXwdnSIsDlEs0eeISe+iaHEJo9OLpvObin3ChBrVbT4o
lmFIYeP5eWNcNlAKZd9y+tr+S9puRpVPZASSH0/QUOtfQYpO5vmlNZyynqqSUhdg
NKi2XzdLK3xLKDM55bP2RTS4TDhOe4O5VJWdVRDu59m+6Und1K1rIubf0GRaIpHQ
h9SycOlh0X2BRRBBQEqoCgE2R/vWBS9NhCban4yRN2ZOfdlfAqsEFvEWJ5utLkpR
yAEkAerxrkLam35ISNijLA4euRO1Uw==
=Qcqi
-----END PGP SIGNATURE-----

--rzS+1eaHwgk3+pb4--
