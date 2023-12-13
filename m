Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2F58115A8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442124AbjLMPEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442104AbjLMPEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:04:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0158A0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:04:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D54C433C7;
        Wed, 13 Dec 2023 15:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702479894;
        bh=nLxZSg/yD+znXZHWu4Vars8EQtCSP3KKevIj0nvJOvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FXfv4/LqeVxml8cC8xOBVkj+C55XQsUDotUQ7wQUxQWoFbyIib8cxLn83khaDCc4k
         TILfe0piJJA6WNjTiLEbHky3WCF3flzGtV+5xo0vYZQlBu4zRP3y29JPvzgpQlvpSX
         vVpfhuu6luVuxCbLAUa4tNmNKCq0zOs07W4sF7mJyieBq7NX65GCPoLpF+ROydPe0K
         Zz1W/D9mBRGgS/BsylPZd0XI4b2QIJ7IMKiVxK6Ho3Fi47X9WIOzlsYqJJ9ZFxueeg
         udiK2Vi7fEU/qhifgMPuGQMc57/j6njhGJ4fwgdvcWN7OvaGicgLZv7oDBpNVisLX/
         WMtM18XMSrccg==
Date:   Wed, 13 Dec 2023 16:04:52 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     davidgow@google.com
Cc:     Rae Moar <rmoar@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 0/4] kunit: Add helpers for creating test-managed
 devices
Message-ID: <7rgeotye4grxdtbxip53fykjm4a3sudochsfzdvkmyqltvj7zv@qekkt42x2j25>
References: <20231208-kunit_bus-v2-0-e95905d9b325@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="znksof6fizamytva"
Content-Disposition: inline
In-Reply-To: <20231208-kunit_bus-v2-0-e95905d9b325@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--znksof6fizamytva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, Dec 08, 2023 at 06:09:28PM +0800, davidgow@google.com wrote:
> KUnit tests often need to provide a struct device, and thus far have
> mostly been using root_device_register() or platform devices to create
> a 'fake device' for use with, e.g., code which uses device-managed
> resources. This has several disadvantages, including not being designed
> for test use, scattering files in sysfs, and requiring manual teardown
> on test exit, which may not always be possible in case of failure.
>=20
> Instead, introduce a set of helper functions which allow devices
> (internally a struct kunit_device) to be created and managed by KUnit --
> i.e., they will be automatically unregistered on test exit. These
> helpers can either use a user-provided struct device_driver, or have one
> automatically created and managed by KUnit. In both cases, the device
> lives on a new kunit_bus.
>=20
> This is a follow-up to a previous proposal here:
> https://lore.kernel.org/linux-kselftest/20230325043104.3761770-1-davidgow=
@google.com/
>=20
> (The kunit_defer() function in the first patch there has since been
> merged as the 'deferred actions' feature.)
>=20
> My intention is to take this whole series in via the kselftest/kunit
> branch, but I'm equally okay with splitting up the later patches which
> use this to go via the various subsystem trees in case there are merge
> conflicts.

Could you take (and apply eventually) that patch as part of your series?
https://lore.kernel.org/linux-kselftest/20231205090405.153140-1-mripard@ker=
nel.org/

Thanks
Maxime

--znksof6fizamytva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXnIFAAKCRDj7w1vZxhR
xbTWAQC3bH552498SP6tLXv7kKo878Z61Buc15OZAdQwh4kdXQEA9UZqLQkvJTrT
kQ13+qYaarJ8Jpvwt41WGCqAxaRt7gw=
=yRUg
-----END PGP SIGNATURE-----

--znksof6fizamytva--
