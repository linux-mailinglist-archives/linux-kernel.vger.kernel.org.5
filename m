Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C637B8D12
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245407AbjJDTT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244879AbjJDTTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:19:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10259270B;
        Wed,  4 Oct 2023 12:08:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E01DC433BF;
        Wed,  4 Oct 2023 19:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696446514;
        bh=z8q9WQnLCGbK8w2/hCp6xPfP35wCO0KBvWTQAtx1ACc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BsdvoO2+tSeEpeT+wbyLwgBePSJh50QAg5hT651xp9vHI96MWfVTSIvJA8H7HSsav
         cANW7E0He5qhHnC5EAInOL4AsOWN+Olu4h2C9W6D5Zmu2pFRQ2or1IP+hDwJRggKIG
         8oDHJUph/RfCfttP7mPSgjxeAPGJKHwfGo3AgEv/+7NYNw2XZsnbe2q7xBwODo58vD
         bWR1EDu3qec6W2wQnHQcETNSktY1uKSryZi8UIBUxs9X7KfUO3h5eDGwtc0iMQcFw9
         /WrqIhcHQBAnbaRP4SnRUhjWXF2kHFEPeb+U7z+jRM0XMKsFNjVE09jW/gaOD6Moqb
         mHgq9LUW12oJA==
Date:   Wed, 4 Oct 2023 20:08:24 +0100
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
Message-ID: <c7e9aef7-d90d-4eb5-b4fd-72857346dcad@sirena.org.uk>
References: <20231004130243.493617-1-krzysztof.kozlowski@linaro.org>
 <6628a5f6-ed22-4039-b5c2-2301c05c7e3e@linux.intel.com>
 <2023100453-perfected-palm-3503@gregkh>
 <624b044a-1f0f-4961-8b57-cb5346e7b0d3@linux.intel.com>
 <2023100452-craziness-unpopular-7d97@gregkh>
 <04c5911a-a894-44b3-9f0e-fe9e6de203f2@linux.intel.com>
 <d648c3d1-53ac-4021-ac7f-6a81f1a72dd3@sirena.org.uk>
 <bf4ee895-293f-4bc3-ac4b-30df6361e973@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jPpsDvd3ypYAmiPv"
Content-Disposition: inline
In-Reply-To: <bf4ee895-293f-4bc3-ac4b-30df6361e973@linux.intel.com>
X-Cookie: This space intentionally left blank.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jPpsDvd3ypYAmiPv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 04, 2023 at 03:00:40PM -0400, Pierre-Louis Bossart wrote:
> On 10/4/23 11:40, Mark Brown wrote:

> > FWIW DT is much less affected here since all the inter-device references
> > are explicit in the DT (modulo needing to work around breakage) so we're
> > not hard coding in the way ACPI so unfortunately requires.

> Isn't there a contradiction between making "all inter-device references
> explicit in the DT" and having a device name use an IDA, which cannot
> possibly known ahead of time?

No, the thing with DT is that we don't use the device name for binding
at all - it's printed in things but it's not part of how we do lookups
(unless there's something I didn't notice in the Soundwire specifics I
guess).  Lookups are done with inter-node references in the DT.

--jPpsDvd3ypYAmiPv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUduCcACgkQJNaLcl1U
h9DtVQf9E1QE9QxbJsHcy6ZNkCNbvskvokOqadTQX9lvcIS3emkiN65JK+oD5D9u
XOjh5OjUmolwPIvKggNJbTNdh25/e3ama+JYh0xeT9jM605vR/9UdNCXxuGm2Y4k
SLFoFvCxDZ1CZ+HEnZnlIPrOX2+afXoLezCHleEvCZbMzmMCcrFdmIGk2fOA+BTj
6Kr00wCESeg/kJGYUqmWuHNu/15U3TryRBv6r9l4VYTQYr62xk05pBt5KS2iC9UQ
aSACeVfLXF/B9X2KZwsD83deIBFj7FL9cwNrG4LLMneihfvJlFAswdK3qYZYyDXK
VAhMd3hpWTPMd4uq2JEpC90gyiY1ZA==
=60Fx
-----END PGP SIGNATURE-----

--jPpsDvd3ypYAmiPv--
