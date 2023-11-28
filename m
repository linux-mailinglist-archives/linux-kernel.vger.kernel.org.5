Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009937FC1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344793AbjK1OAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345480AbjK1Nzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:55:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CFEB5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:55:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFA6C433C7;
        Tue, 28 Nov 2023 13:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701179752;
        bh=lFIEgWDg6ujlYIK15c4mSDxbSIcEHaZgX85DXfe9QGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KLzSKVhXkLTg7AQ9TpKMI2z9nmc3YqIzV83md6KCBEuHklxpnZWradeRC1PKSkX5R
         r8tBhqET9GhRVQxrlYxBTQ3+diBm4t6hXOFFPcx63yswQKRUFYFqNV9iY8BLDb7gzy
         LJm1WRtwyrYXPOmBLSd5MjocUqZpBSNrEeXDrNn0PLr4vuekk3Bj9eUG0AbtmrCe3G
         kx3fqKgLAbOfHmqJNCAkTe4pg9ZIWFcd7YXeOLoP5ZJaSCzJfloEs8hiTk4AHGiOOP
         ZWhPHaGiHpNsRADieRWYOajseQJ2Wl2NG4WhUMpaP5UFnTgltkof4OCSqdQ6YNNl8z
         z52r+DJmYbxww==
Date:   Tue, 28 Nov 2023 13:55:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "debug@rivosinc.com" <debug@rivosinc.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "Pandey, Sunil K" <sunil.k.pandey@intel.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "kito.cheng@sifive.com" <kito.cheng@sifive.com>
Subject: Re: Shadow stack enabling from dynamic loader v/s kernel on exec
Message-ID: <ZWXxZYm/t69afFJZ@finisterre.sirena.org.uk>
References: <CAKC1njRkpaqbAFWrZpz75u4M-T8mniY2QHVZEENameqnHOOGPg@mail.gmail.com>
 <ZWHcBq0bJ+15eeKs@finisterre.sirena.org.uk>
 <b2498b8097da6223f54aebd80f2e3f0b06fe47e2.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RHQr7V8m/3wCdFHK"
Content-Disposition: inline
In-Reply-To: <b2498b8097da6223f54aebd80f2e3f0b06fe47e2.camel@intel.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RHQr7V8m/3wCdFHK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 27, 2023 at 05:32:24PM +0000, Edgecombe, Rick P wrote:

> security focused runtime environment. So a seccomp mode starts to seem
> like a separate enabling mode with it's own rules, in which case it
> could be left for the future.

My understanding is that seccomp is generic enough to allow you to write
filters without any specific shadow stack support, though I'm not sure
about handling for arch_prctl() so perhaps it's harder on x86.

> I don't think doing exec based enabling will impact the app developers
> expectations, because it should be confined to the loader. So it's fine
> either way from my perspective.

Yes, I don't think there's an issue for apps either way - it's more an
issue for people doing system level security.

> > On arm64 there would be the potential for disrupting some limited and
> > theoretical use cases where GCS is enabled even though some libraries
> > do
> > not support it

> On x86 we see this case already in testing. Why do you think it is
> theoretical?

Right, it's fairly easy to add something not flagged as GCS compatible
at runtime through dlopen().  I think I was thinking of the case where
the program is not marked as supporting GCS but enables GCS usage
selectively at runtime, it wouldn't be able to do that for the main
thread since we don't allow reenabling.

--RHQr7V8m/3wCdFHK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVl8WQACgkQJNaLcl1U
h9AyFAf5AfIg+BaZjkXaiSmsN4zgQJ5QAmBA/ntx6Z7SGGIRRRLSfISISp7SLGcW
+KbkP9KTgt1G9Aku7ycNS6tckK26J+cJLw5n+7Q1Vzdr88dLMQ+a5Jsnznb9J4EC
8FbqdGBj+biihnELtiQJ4xTW00nH3XDRDZyYdZDZuLx1YfWBRojSn6rvazJCAiMH
Hw80cAZAoNLOvrdbLKbmoif0JTfWj1LSCm+M4FnvOBD75W+eWgwDhnW5DHqtJ7Ov
f8U9Gb3yhJBL1sVjZq/bzygUiPb92/e1OBz5K37iAscmjs1CMeR5ALXJhgW2Wsb0
1OAcbg9DTrAjMOeW/83EQGmvdLtmGA==
=9qsU
-----END PGP SIGNATURE-----

--RHQr7V8m/3wCdFHK--
