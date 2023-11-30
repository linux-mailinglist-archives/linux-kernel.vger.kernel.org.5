Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5F57FE4A8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343749AbjK3ANE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 19:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK3ANC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:13:02 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE13F4;
        Wed, 29 Nov 2023 16:13:08 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cf7a8ab047so3867925ad.1;
        Wed, 29 Nov 2023 16:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701303188; x=1701907988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=llp625eBHSklHYRyyFpz3DN5XNqEMa63GZO3UGUzFOc=;
        b=J8pzU8/Md36jyKJ03/ZnQt1HxtgFeyxm8pC8oTNzsZVOY/jgmQztVSBpne6emmyRBL
         dMc3ygkyN+7oGi0ZGYVqEsf3Z2ixsihu8fs77HT8Mx/92VZ+YdTl888806PC3F5rDZn5
         P68Z4Duqy08H1s5v7GxZFcUKWfpolTEoPNuj5Unz/aIJ7kkqB5far2y5UqtKgTYUejXg
         xvmg4h/UV0CKtWeqxymzs656tR9x/h6kSLMf0Y5ARN+ymqJ09P55b3xIEWpcrB274I6s
         gYiGm5KOLjDtBIuciptA27p0fNyt+g3oVz+K7cfYHtJKlZOfUgjwfRLoKI6I3ocRpv9n
         lKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701303188; x=1701907988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llp625eBHSklHYRyyFpz3DN5XNqEMa63GZO3UGUzFOc=;
        b=wtRgq2OsEevhVUORA7uftSw9bRi9ZFDWKC49NnjBhQhgzmyH/vTp40z+ZohXkE9Fhc
         h6iWGsEavmpQVDohO9QeScDW+RsXp5rfsE67geDEZsUOG2EI/ePirAzUojR++W58xG1v
         MAOA7qcVBlmc6f6LzTCYQFshGwLxZLPfXnMLgw1uv1EqGt4iTa8f/YVJdAyU42vOvD0w
         5X1bUpiAHMk3o9M8T8i9YI73JOk65A0t4bcCR383BsSrAV5CJX5OawsFP+HZxT1UFpbd
         lIdVt14386cc5d6d2EEGkrMBpY0TMqwM/GcX98Xz60wVVx1/DX2ayjFUcyPK/Xhcr8uH
         EM8Q==
X-Gm-Message-State: AOJu0YzI68cgbZZ1+IeyU3Ph3W+FlACulCHF2D8TJsB9VoJVy8fayIXw
        8p2CCq1iWqBZHv3HzYo/+ls=
X-Google-Smtp-Source: AGHT+IGV8y3JIQefxKXs91Nva16n7dSGeJRZST1APeuo5h+MlHpWqkDAfo5U2A1DEygfgAKvILIzKw==
X-Received: by 2002:a17:902:8217:b0:1cc:49e7:ee1b with SMTP id x23-20020a170902821700b001cc49e7ee1bmr17994646pln.58.1701303188222;
        Wed, 29 Nov 2023 16:13:08 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902d2c600b001cfcf3dd317sm6456123plc.61.2023.11.29.16.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 16:13:07 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 47C031141356B; Thu, 30 Nov 2023 07:13:03 +0700 (WIB)
Date:   Thu, 30 Nov 2023 07:13:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Livepatching <live-patching@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Attreyee Mukherjee <tintinm2017@gmail.com>,
        Chandan Babu R <chandanbabu@kernel.org>
Subject: Re: [PATCH 0/2] Minor grammatical fixup for livepatch docs
Message-ID: <ZWfTjmL9RCUrqCqj@archie.me>
References: <20231129132527.8078-1-bagasdotme@gmail.com>
 <874jh4pr8w.fsf@meer.lwn.net>
 <ZWdYGrhTYFzG5BZq@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="79WZgSpXvLpPvpaF"
Content-Disposition: inline
In-Reply-To: <ZWdYGrhTYFzG5BZq@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--79WZgSpXvLpPvpaF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 03:26:18PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 29, 2023 at 07:29:35AM -0700, Jonathan Corbet wrote:
> > Bagas Sanjaya <bagasdotme@gmail.com> writes:
> >=20
> > > I was prompted to write this little grammar fix series when reading
> > > the fix from Attreyee [1], with review comments requesting changes
> > > to that fix. So here's my version of the fix, with reviews from [1]
> > > addressed (and distinct grammar fixes splitted).
> >=20
> > How is this helpful?  Why are you trying to push aside somebody who is
> > working toward a first contribution to the kernel?  This is not the way
> > to help somebody learn to work with the kernel community.
>=20
> This is not the first such "contribution" from Bagas recently.
>=20
> https://lore.kernel.org/linux-doc/20231121095658.28254-1-bagasdotme@gmail=
=2Ecom/
>=20
> was as a result of
> https://lore.kernel.org/linux-xfs/87r0klg8wl.fsf@debian-BULLSEYE-live-bui=
lder-AMD64/
>=20
> I didn't say anything at the time, but clearly I should have squelched
> this bad behaviour by Bagas before he did it to a newbie.
>=20
> Bagas, find your own project to work on.  Don't steal glory from others.

OK, thanks! I was in 'gabut mode' then...

--=20
An old man doll... just what I always wanted! - Clara

--79WZgSpXvLpPvpaF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWfTigAKCRD2uYlJVVFO
o1WRAQDjPyXAhXCE7w/Kb8phglapgtD0isoZyQ4PX7KDZuAN4AD/Sbgq4OKBu4e+
ImjI03e2t4/pu2eUB/rOp2wbO//fxAQ=
=zVHZ
-----END PGP SIGNATURE-----

--79WZgSpXvLpPvpaF--
