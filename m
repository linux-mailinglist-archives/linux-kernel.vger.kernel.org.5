Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D15E7B83D7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242957AbjJDPkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242945AbjJDPkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:40:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD85E5;
        Wed,  4 Oct 2023 08:40:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F8BC433C8;
        Wed,  4 Oct 2023 15:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696434023;
        bh=df8KZVSxg7fpWft4bfdcKowE+/YFVMdWA60GDzXP/SA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qyB2BHOgxF8GQS+OT5aMzixIcMGOMkIlJUdzNz/zkYVW/2KT5hD86elSvXvBR1aOF
         HfuB84Exme7eqzvCmMfGVZX/2zLHvshcJ3nrn1AX1ps9db0ZvOorxznPT4zjrpP4dg
         iVpclSSmQ7mAGXzlLhf3loHYTM74I5o80TwUBnDH6jGuGU8HpdB4uM1Fee2b/+J6SC
         MXXLWRCYRQCRQOXCdti2Od2bORajK0Zaq8Ry1lCkjZTrY8p3xi3lDLM3OgmYsRKs+Y
         jt4qYeZ6qP4QJGnktKPIyWSzR3ALNypsNV9PDwoI+YPlHEJcGT6f59/3SjDIqDR+pl
         sfJYoEVjcffTA==
Date:   Wed, 4 Oct 2023 16:40:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] soundwire: fix initializing sysfs for same devices on
 different buses
Message-ID: <d648c3d1-53ac-4021-ac7f-6a81f1a72dd3@sirena.org.uk>
References: <20231004130243.493617-1-krzysztof.kozlowski@linaro.org>
 <6628a5f6-ed22-4039-b5c2-2301c05c7e3e@linux.intel.com>
 <2023100453-perfected-palm-3503@gregkh>
 <624b044a-1f0f-4961-8b57-cb5346e7b0d3@linux.intel.com>
 <2023100452-craziness-unpopular-7d97@gregkh>
 <04c5911a-a894-44b3-9f0e-fe9e6de203f2@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dDaSu7Aom8sfapyH"
Content-Disposition: inline
In-Reply-To: <04c5911a-a894-44b3-9f0e-fe9e6de203f2@linux.intel.com>
X-Cookie: This space intentionally left blank.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDaSu7Aom8sfapyH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 04, 2023 at 11:16:09AM -0400, Pierre-Louis Bossart wrote:

> > matching the name is fine (if you are matching it against an existing
> > name) but expecting the name to be anything specific is not going to
> > work as the name is dynamic and can/will change each boot.

> Not following, sorry.

> In the SoundWire context, the device name directly follows the ACPI or
> Device Tree information, I don't really see how its name could change on
> each boot (assuming no DSDT override or overlays of course). The
> platform descriptors are pretty much fixed, aren't they?

> Intel and AMD make such assumptions on names for pretty much all machine
> drivers, it's not really something new - probably 15+ years? Adding Mark
> Brown in CC: to make sure he's aware of this thread.

FWIW DT is much less affected here since all the inter-device references
are explicit in the DT (modulo needing to work around breakage) so we're
not hard coding in the way ACPI so unfortunately requires.

--dDaSu7Aom8sfapyH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUdh2AACgkQJNaLcl1U
h9Dg2Qf/TTjAvH7rrj88JqMZ5e52pLzKRkYsKDlpQCGarm9GRbl3b1sbc4orAwYD
nhn2kx1bqWrZANB5fm83hWKNBRtiWvVbau+lR+CbxXAAi/D26zd7btSx7k2yfXNW
g5jolY8IR1AR1CNOwIFWPvO9uvZGlfFU96iiPTyaOHMyytLu91ygLkbFY7ImfOWe
bnlr48wrjy4idRhEH1L8ST+CHS/ENx+lj3uXXYy0zfeiyZNgWFAQ5C0m95lfecF+
ZZmVnKbRikSlIL+ZHAtukR1ywmRkWdOTy8Y2y4yfYzquIQ2QoMa3GDr3wAq8L8/q
VSutkzU+PAYOrHHfngft5JSKCGv5QQ==
=AlEx
-----END PGP SIGNATURE-----

--dDaSu7Aom8sfapyH--
