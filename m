Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B507EE6E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjKPSlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKPSlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:41:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56CE194
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:41:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869CDC433C7;
        Thu, 16 Nov 2023 18:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700160077;
        bh=axDloRwFo8G9keDVvfti1AbZSDYwXXFVtTtUR/GsIhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pma9qkeRVPQcWRu3uBsdtKvpuVIgNSNViUMZuUAsPzW0fPCAwJupH64Rorn1lXigY
         oaSevdGsXzgdUA358FZmo3L3HdiGxwBi4lzyktHO6ps8ysOMJduDj1QhTP5VAYpkUk
         r4jpy7BB/GULp/bmBvJ/VYwJK9ImBUMhB/XaYQCa7gHHQ+wT9qvjCrG0pqpBcrjdH8
         kA2/xCGko6HFcbNsf1vbFrliwyVvLF9DQ+lKv+ukKtXX2dKDbOOibJN2URvD1vF6o3
         WTWoD98qttsiSQhb09vJTJvaiFrjRcq+wSM/iKMaTgDRshlU5vr22WTT9su8wzPKcj
         RueF5t/2ZQovg==
Date:   Thu, 16 Nov 2023 18:41:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jannh@google.com" <jannh@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Pandey, Sunil K" <sunil.k.pandey@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to clone3()
Message-ID: <eebf054b-7e0e-4732-8d8c-718073ec32ed@sirena.org.uk>
References: <c9434fa9d864612ed9082197a601c5002ed86a38.camel@intel.com>
 <d873072c-e1f4-4e1f-9efc-dfbd53054766@sirena.org.uk>
 <ZVTvvJTOV777UGsP@arm.com>
 <d90884a0-c4d3-41e9-8f23-68aa87bbe269@sirena.org.uk>
 <d05d23d56bd2c7de30e7732e6bd3d313d8385c47.camel@intel.com>
 <ZVXvptSmmJ6MQ0dY@arm.com>
 <1bd189e0-a7dd-422c-9766-ef1c9b0d3df8@sirena.org.uk>
 <ZVYfO/yqRtuRYaJA@arm.com>
 <54d3bc9c-9890-49f0-9e9d-78ea4d0d7199@sirena.org.uk>
 <9ce63f824b768f9635e55150815ee614fdee1d73.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6jnoQqzq7uwk9KbQ"
Content-Disposition: inline
In-Reply-To: <9ce63f824b768f9635e55150815ee614fdee1d73.camel@intel.com>
X-Cookie: micro:
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6jnoQqzq7uwk9KbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 16, 2023 at 06:11:17PM +0000, Edgecombe, Rick P wrote:

> Now that I've thought about it more, removing the CLONE_VFORK part of
> the logic has several downsides. It is a little extra work to create
> and unmap a shadow stack for an operation that is supposed to be this
> limited fast thing.

It does rather feel like it's defeating the point of the thing.

> It also will change the SSP(let me know if anyone has a general term we
> can use) for the child. So if you have like:

SSP seems fine, we're already using shadow stack here.

> What about a CLONE_NEW_SHSTK for clone3 that forces a new shadow stack?
> So keep the existing logic, but the new flag can override the logic for
> !CLONE_VM and CLONE_VFORK if the caller wants. The behavior of
> shadow_stack_size is then simple. 0 means use default size, !0 means
> use the passed size. No need to overload and tie up args->stack.

That does seem like it cuts through the ambiguous cases.  If we go for
that it feels like we should require the flag when specifying a size,
just to be sure that everything is clear.  Though having said that we
could just always allocate a shadow stack if a size is specified
regardless of the flags, requiring people who want non-default behaviour
to have some idea what stack size they want.  I don't think I have
strong opinons between having the new flag or always allocating a stack
if a size is specified.

--6jnoQqzq7uwk9KbQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVWYkMACgkQJNaLcl1U
h9AnPQf+OrS9UnpK/M86Qe+eZ528KWBeQ9RRfz6xqRg0c/kGK8aPqBjZTcIlGNKo
d+yKeTyTrlEaJLLd7jod/7KrOJjsYSDVokQXwODuLjTZYQJpPzJaHqXs/7gTrCHl
bi7ce8CTK1y0SBanxfqk+uhy+26/tXCuF6DEytoY4dTwOn88k+L2ol0D17BeqHmm
7jLLDyvzl8FSLnksehEldYXRveieFSWJB2zODhPtQvRwbzsymNPkEXN+oVvCxiTh
kIFOodspI8EmbIDryfo9U0xzfbaYTgg+2tB9C36LVNTg6idLgi6eeAB0nFk7+6x6
kVKeD4/4OM8Gtp9VErF0qo5dP468EQ==
=Iru+
-----END PGP SIGNATURE-----

--6jnoQqzq7uwk9KbQ--
