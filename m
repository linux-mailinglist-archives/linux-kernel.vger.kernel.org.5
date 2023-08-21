Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC87782A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjHUNLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjHUNLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:11:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524EFE8;
        Mon, 21 Aug 2023 06:11:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC7B563544;
        Mon, 21 Aug 2023 13:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81813C433C8;
        Mon, 21 Aug 2023 13:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692623500;
        bh=fKeIzDelBhcXSFwPC4v8AT95YfiJ57nqdgQdtNrfJN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VsfbPZUkFt08a+Wx0UN0m8lvTnb/61UGGxfrg1HRj7GndsGHSlQ6Z7DiMk+vQwlho
         TTSL29bxPpzAy02jyElUvTTOnXNiWXT/Mm/G5GFQJAL8AzvZs4N9NR9yS8DvmAsiE2
         X+/mMIN1FnSaaYoXTbhV7ANfuPzYQzpLlF75tlgPgbFAs/ooMbq7cGQILEV6ZpWJ2k
         fGLfYtU0WktuizrYDj2suYlO/9wI2muPELUhvd5nfPR+Jq8iAyGqaNVy/PnM6qo171
         9dek6upF92jpbeNkPF5C1jx2jDXOUklt8z3S0Mf4ZbxHLmC1ei/bIkCxIDhEy2Doqs
         a/DT28fVwfJnQ==
Date:   Mon, 21 Aug 2023 14:11:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        Saravana Kannan <saravanak@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Stultz <jstultz@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Ferry Toth <fntoth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= Navarro 
        <ricardo.canuelo@collabora.com>,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        usama.anjum@collabora.com, kernelci@lists.linux.dev
Subject: Re: [PATCH 5.17 127/298] driver core: Fix wait_for_device_probe() &
 deferred_probe_timeout interaction
Message-ID: <0a06a54e-0348-4964-ab90-48c648712ed6@sirena.org.uk>
References: <20220613094924.913340374@linuxfoundation.org>
 <20220613094928.793712131@linuxfoundation.org>
 <6283c4b1-2513-207d-4ed6-fdabf3f3880e@collabora.com>
 <2023081619-slapping-congrats-8e85@gregkh>
 <471bf84d-9d58-befc-8224-359a62e29786@collabora.com>
 <CAGETcx-NVoN7b8XCV09ouof81XxZk4wtGhEcqcFAt6Gs=JWKdw@mail.gmail.com>
 <d8f8ddf6-8063-fb3a-7dad-4064a47c5fe8@collabora.com>
 <CAGETcx-DUm417mM-Nmyqj-e_rKUw69m=rTe5R6_Vxd_rsKMmGg@mail.gmail.com>
 <97b06c78-da3c-d8ab-ca72-ff37b9976f2a@collabora.com>
 <6d7a7ecc-1364-5cbe-0485-01d693dbdc6c@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9yeLbFu7ADkQpySe"
Content-Disposition: inline
In-Reply-To: <6d7a7ecc-1364-5cbe-0485-01d693dbdc6c@arm.com>
X-Cookie: Do not write below this line.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9yeLbFu7ADkQpySe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 01:39:11PM +0100, Robin Murphy wrote:
> On 2023-08-21 12:35, Shreeya Patel wrote:

> > AFAIK, script for running the tests is immediately ran after the boot
> > process is complete so there is no wait time.

> Regardless of what the kernel is doing, it seems like a fundamentally dumb
> test to specifically ask deferred probe to wait for up to a minute then
> complain that it hasn't finished after 11 seconds :/

IIRC that stuff is expecting the modules to be loaded from the initramfs
and checking from the main system which is a bit more sensible (at least
in the case where there is a main filesystem).  It's vulnerable to races
but less so, especially given the time a Debian rootfs typically takes
to boot over NFS.

--9yeLbFu7ADkQpySe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTjYoEACgkQJNaLcl1U
h9A6Swf/XtoTqsAUrhDq/Wh7JfVm3BoLQKbTuySudRcbCDjKQqaSOK6krL2dOyho
pMlwv20MA3H+NF8I/hbsKh76FXvk08d1iLcKHll3kfZOxLUmdhOXY56bn88FStfd
Yja0b9OFe5TkkxZngSggpps6F+hhI0Q1GbuX+VZKqwZ3+1cbM+osTfZDzxy5Y47x
NwqGj95If45WtM2T1uom9ODZS1xKNH3Y7TO7Ifkpqf9sV0h+l4cWYEUOahfcEh6z
hIH1+EeAJSqWhvoWxXgc0KkmrTV3MQetnfOOpofb9YEO7zvRnU2k/vzhY142cS3Z
MfbPxUXC9o6LeMMrbYdhvLEEImawAQ==
=cxsG
-----END PGP SIGNATURE-----

--9yeLbFu7ADkQpySe--
