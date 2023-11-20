Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4656E7F1837
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjKTQLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjKTQLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:11:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE93DF4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:11:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C76C433C8;
        Mon, 20 Nov 2023 16:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700496675;
        bh=l4r0Zimkl2LX+9IdnFYB72JaaxPTIHzvY5B+YteFh1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aVeHwi+2Hgj/MxBohgdl7uWfeCXEx0zHDkNp3GoXfAlPyCNdXjhISc08To2mAWpsg
         Ka9agmJfeGTq2PwGP7qlDGL2YLoNjtaLlnd2RdQFk74FLmg3ZXJw8OYrOFjOCYjVDK
         jbbYKoWmyAwlnJ8SS28QkFVQZQu0D4d1lJTGkwE/CcJfi/xh9choFN3jLPEeJkjln+
         a8d5Q5l2VC6gcFdSM1pZijn63wQgEPhxjx2bpDgcdb9YbWkH4365hcYI5QfOxgcuRs
         baqdvbxxy2MiR/8bVvBENWqGlzB0zRWDLaLwc1eAK6LbUaC2QOh7tGPbYAcZ3zxuu5
         AZLFtTkfi6SiA==
Date:   Mon, 20 Nov 2023 16:11:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jannh@google.com" <jannh@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Pandey, Sunil K" <sunil.k.pandey@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to clone3()
Message-ID: <0f7747d2-f2ee-4e3e-be70-231673365339@sirena.org.uk>
References: <ZVTvvJTOV777UGsP@arm.com>
 <d90884a0-c4d3-41e9-8f23-68aa87bbe269@sirena.org.uk>
 <d05d23d56bd2c7de30e7732e6bd3d313d8385c47.camel@intel.com>
 <ZVXvptSmmJ6MQ0dY@arm.com>
 <1bd189e0-a7dd-422c-9766-ef1c9b0d3df8@sirena.org.uk>
 <ZVYfO/yqRtuRYaJA@arm.com>
 <54d3bc9c-9890-49f0-9e9d-78ea4d0d7199@sirena.org.uk>
 <9ce63f824b768f9635e55150815ee614fdee1d73.camel@intel.com>
 <eebf054b-7e0e-4732-8d8c-718073ec32ed@sirena.org.uk>
 <2f92f798a1807679d193fa19b217486f57398163.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oHaoulzZJbn3kFex"
Content-Disposition: inline
In-Reply-To: <2f92f798a1807679d193fa19b217486f57398163.camel@intel.com>
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


--oHaoulzZJbn3kFex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 17, 2023 at 05:43:26PM +0000, Edgecombe, Rick P wrote:

> Either of those seem fine to me, but it would be nice to get it vetted
> by the libc folks before committing. I'd maybe lean towards the one you
> suggested without the new flag.

I'll go with just taking the stack size as a parameter then, less
validation, hopefully the userspace people will be OK with that - I
agree it'd be best to get their buy in.

--oHaoulzZJbn3kFex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVbhRkACgkQJNaLcl1U
h9Cdrwf+PmZcxRd9PuAOMhD/6WyXjzTrfyyd7VVQcWto1Pi1mU7ex1a6Z6PPdldx
ICSc5ltzExGle1le1oPaux2tfECZmEUwesny78lyH61HNVLzpbnIwYgxf5gqug9l
/vSYnX2H2VhdXPnpkBoDWi6u0efw2aBYZiKvFCtTh+KOTOYCAsgGGevgtX0f2yKv
qn9eYcl8tN9LAwSLf9wzCs3hLPo1AS4RcxZwfsUaqEonFBtdHPx5jAFqXKkF7lc0
uU3bhzZF5mtnggRUWxTeQ9vzAPe57SywrWklzQNVj1OgRR/vthYZagsDCoLr/MjS
yCc4JkHAq5fDXpziU7O62hNi5nofMg==
=V1wv
-----END PGP SIGNATURE-----

--oHaoulzZJbn3kFex--
