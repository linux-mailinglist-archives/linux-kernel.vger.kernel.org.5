Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5A77F17E6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjKTPyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjKTPyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:54:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3B8A0;
        Mon, 20 Nov 2023 07:54:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426F6C433C7;
        Mon, 20 Nov 2023 15:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700495659;
        bh=5RAM8HOVYUU9Y/pFLKOLBfOhvTkMT7lRAWd7TNxEfAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SAspqX/Dssj5RtfYYHt3wCNydfXbYEChxLPiGn0CxTcos3DUyxsJRYAWvTbSzACdC
         khzbW5fbO+tAL6mOjcdK6TSxZTmy2Jg5kHagr4AwE9OVE4EIDJ4IdxESD0VDXbzzzN
         2NIKX4cL8+ip0K4sdCmw5SY9ipsHc7EWDRcJCGwIsRMKzWsuW+P5n0nIayyXxvwXCY
         NqtM7oaQvOiehJ/z3p3y15yvlGU6Fa1EcLgodrrPCChE4PiVeajCbIRJXzZ7X254PN
         ZUGArM91RkYiqfhCWBvHTIesTitsw/LLrjrjcwkPfZ9FY7S4fmphedlIsLbkY+qdbH
         n6gyVNiln89ig==
Date:   Mon, 20 Nov 2023 15:54:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: cs43130: Allow driver to work without IRQ
 connection
Message-ID: <c031657a-a1ec-44eb-8885-afee68d7523b@sirena.org.uk>
References: <20231120141734.76679-1-mstrozek@opensource.cirrus.com>
 <7248897a-0b59-4cdc-9915-d3297f2d6efe@sirena.org.uk>
 <261e118d-529b-0ce0-5524-d24d767fa92f@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ycCrs6TZIAPbbyZe"
Content-Disposition: inline
In-Reply-To: <261e118d-529b-0ce0-5524-d24d767fa92f@opensource.cirrus.com>
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


--ycCrs6TZIAPbbyZe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 03:46:26PM +0000, Maciej Strozek wrote:
> W dniu 20/11/2023 o=A014:40, Mark Brown pisze:

> > > +		} else {
> > > +			return 0;
> > > +		}

> > Is it a bug to call this function without to_poll set to something
> > known?  This will just silently ignore it which seems wrong and is
> > inconsitent with the handling in the interrupt case which will wait for
> > the the completion to be signalled and report a timeout on error.

> In interrupt case 0 means timeout (and calling function should expect 0 as
> error/timeout), so the only inconsistency I see is in not waiting before
> returning a timeout, but that would be needlessly wasting time?
> Do you think adding a debug print or a comment would help here?

It seems like a clear code bug if this is ever called with an unknown
completion, I'd expect a WARN_ON_ONCE() there.  The lack of a delay is
potentially going to affect how any error handling works which doesn't
feel ideal though the users look fine right now.

--ycCrs6TZIAPbbyZe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVbgSUACgkQJNaLcl1U
h9DLHggAgw4p1rPiLwpJ1J/hleOS2jFFzXuwTkstI6G2g5uZWsaBuaUFeZQyHriY
avc7aCFDEjYZBryEbey+S08tmNygDp+qVkHrCy2VSCyVM3TeP7vaIwtebTA+bLWL
3bdP22f26lajNin048S3VyyLv0pYblUm3hSpCA/fIhp2TGW2HtRD7U1cSx9giCx1
yMpMKx559NWzmdv2Mmi9iRCDZvgFixZT+74VtshWAwhDBE3pmxax7DxXQ2XlG0RM
/WlpqGQbtspRZrIuhrL5TC1xZG4V1HEB5S9FpYggmY97cOxb7ZiPaN1Y7NP2ZaCt
qiwhCBj+GjggmiCqjjqbzxVHhdwouA==
=hruj
-----END PGP SIGNATURE-----

--ycCrs6TZIAPbbyZe--
