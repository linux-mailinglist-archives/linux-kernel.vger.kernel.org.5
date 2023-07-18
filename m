Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901F875834B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjGRRQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjGRRQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:16:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0412BBE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BFF06165C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897CDC433C7;
        Tue, 18 Jul 2023 17:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689700604;
        bh=hOS8hHZ69rZwffHsfBNU1mv9uSJBfqr7PZFO7Qzp4zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qvMH347thgaPRQviAhGECvzPYxGLqqeaiSZq+AvaobsLnUSrRYYrfFU67IRwlV+fc
         VB2BSu88aYZWfVyp7WMlzq8KiHqASv6zNH6AG0fbYYIVoYGG6xD0r5oTifwWjkBZFg
         xFBBjw0dBOsysTgW9SlW6gYHXQHZK6wrw23yWJEbJtSWsbloanoD1+4HTemMc1iHxg
         jUYinyOQokWu22RrQxmyJQNknZROW5FVlvtYkC+W0zB15ccSXGjiCR5VqIbX6INhc1
         Panipjui29c1zyyPdXIh6csBzxmi2XrGF0dI2fOXRkNkK6Zb073igSSZTBJssHQup4
         9dNkl8kINr9BA==
Date:   Tue, 18 Jul 2023 18:16:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] mfd: wm5110: Update to use maple tree register
 cache
Message-ID: <b7a1884c-77fb-41c7-b660-10d2d5d68aae@sirena.org.uk>
References: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
 <20230713-mfd-cirrus-maple-v1-8-16dacae402a8@kernel.org>
 <20230718154200.GG103419@ediswmail.ad.cirrus.com>
 <20230718170035.GH103419@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s1vFkW2z8enz8TEJ"
Content-Disposition: inline
In-Reply-To: <20230718170035.GH103419@ediswmail.ad.cirrus.com>
X-Cookie: Nothing happens.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s1vFkW2z8enz8TEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 18, 2023 at 05:00:35PM +0000, Charles Keepax wrote:
> On Tue, Jul 18, 2023 at 03:42:00PM +0000, Charles Keepax wrote:

> > This one appears to cause me some issues, seems to get the IRQs
> > into a weird state when doing compressed stream stuff. The
> > issue seems to also require commit bfa0b38c1483 ("regmap:
> > maple: Implement block sync for the maple tree cache") to be
> > present. So it definitely seems to relate to the cache sync,
> > but not sure if it is something todo with the device itself,
> > or the maple tree stuff yet.

> Ah... I think I see the regcache_sync sets async=true, but then
> the maple tree code immediately deletes the buffer after calling
> _regmap_raw_write. So its a racy use after free.

> How would we feel about having the maple tree code, clear async
> again?

I was going to say, it must be a maple tree issue.  I think we should
push that async down into the rbtree code, that's probably also broken
for other cache types if used in conjunction with slow buses...

--s1vFkW2z8enz8TEJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS2yPYACgkQJNaLcl1U
h9Chbgf+IkhQ8KqyZmS/h4BdOV/WW+wNBQIFknq70iMrXrdCnF4wWE820V5uzfxT
GI1fFTyCYgfvzjrf/SL+av9jBU10AsOaPq2lfXHuQDIH3PFPPayE3yNRSBIIAyyu
an8AxQMPC1aP6G73M9e9rXD3R3I5XcMa5x74gc83LR/V4hPGfy1PW8kJlRJYLf71
srdqss69glOvET27EBCtho0eEYv1pH1KZIRXgPawBnJXnuaVzqw7Ppp61XPalERI
udkzoZvz5mvGb7mfnnYNi9MwYjQf47ycu0qcPoG9VWQbTlaeUwKIXpPEF4/zoYBu
Vb5Nsk+AtKwFkRtuDLF/NSu6BmHTyQ==
=EAHj
-----END PGP SIGNATURE-----

--s1vFkW2z8enz8TEJ--
