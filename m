Return-Path: <linux-kernel+bounces-6793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA0C819DA6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C471F26820
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB16210EF;
	Wed, 20 Dec 2023 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNpkHQ5Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC41210F6;
	Wed, 20 Dec 2023 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d9f8578932so4198443a34.2;
        Wed, 20 Dec 2023 03:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703070339; x=1703675139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZK4NlSSPgQwsGSHLA/Pycg97M136hutjFPJCvYqz4Ck=;
        b=nNpkHQ5Q3t4Vo5jzD23CVoq4WvQoIo0KMvz3puhxF8NGoLAumpp9y9YCesviDnkEYE
         IIpHKqK+yqGtcCv6967F9JmIfMAoeIhyji6Wr2grvc+OaJIAgaOcfuqgndq/NC9RlzuD
         yZCQahT8PryFRjVvHkfhOzsggEW7QpsBPEtkLiwyhUXVVLznCJpJyt9nub3z8XU889G2
         6faxu/zp/He6sCK1H26wrro2HQw7J2cnjGxPsswQzMpAYbaL5C4rYI59g+EsXSTEiKlp
         TCqwGWTjaNwKV9H/sRGBRDnjgK2OcrwqVHziTBtXbNU2aHGXMTgcI9fIew9mzudbbma7
         EgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703070339; x=1703675139;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZK4NlSSPgQwsGSHLA/Pycg97M136hutjFPJCvYqz4Ck=;
        b=LLZqY+EKJWTt9E0GaXodjQlmpSbz0x+V3lTTp7qIXTurvcq1vMW4GbE43+Wh8LxU13
         cf91NbsjqKmGo2pCy1IPG+JjBODo22gDgUu8HqjqXZw4UtSFCEV9C41LaLhWw1kAOrcL
         krLk8IGEyBhes0VN0xL+EBYqg0vf3Is+p2zJTA8kL45f+deeXyeEo53gHGY9FCrTjfYV
         IjBjhu1aCIDKMT428Oi+rp5QwjOvEcmD1r3IumJY7PVhM9CiNY8PyLS8zcwvY0xPOo/d
         AcFqRnkKE1QVnZSwIIL0v2HcFBXO+1l39hacSXd1UEEOQo4IUbBTbvSbsB+YhTRNVfOu
         +k+w==
X-Gm-Message-State: AOJu0YxICztuiizqOEvtUtOpT2P9e1KAH60aCheMIxsGRcajqqNv6Ybv
	2Y8wbDKMdDu9KfWPy1kr6Uo=
X-Google-Smtp-Source: AGHT+IHNw5Fjt6eji/RZDZ0VYxrLINVasZMdhYpFeaAe+l8GXMP3b8PGNjKBysKhnQL06umOFZ4krA==
X-Received: by 2002:a05:6359:4c1c:b0:170:bd6c:b7cf with SMTP id kj28-20020a0563594c1c00b00170bd6cb7cfmr23746012rwc.46.1703070339040;
        Wed, 20 Dec 2023 03:05:39 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id fk1-20020a056a003a8100b006d40f44dc03sm7642917pfb.11.2023.12.20.03.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 03:05:38 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id AF6051028B299; Wed, 20 Dec 2023 18:05:34 +0700 (WIB)
Date: Wed, 20 Dec 2023 18:05:34 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kalle Valo <kvalo@kernel.org>, Daniel Berlin <dberlin@dberlin.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Arend van Spriel <aspriel@gmail.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	SHA-cyfmac-dev-list@infineon.com, asahi@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, David Airlie <airlied@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Nick Hollinghurst <nick.hollinghurst@raspberrypi.com>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
Message-ID: <ZYLKftqKFJ_PMmF3@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rMlNXoe/imCf0D6r"
Content-Disposition: inline
In-Reply-To: <6e330280-0b0a-4483-ac09-cd974d87a7ae@marcan.st>


--rMlNXoe/imCf0D6r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 01:16:20PM +0900, Hector Martin wrote:
>=20
>=20
> On 2023/12/20 10:44, Linus Torvalds wrote:
> > Put another way: if we effectively don't have a driver maintainer that
> > can test things, and somebody is willing to step up, shouldn't we take
> > that person up on it?
>=20
> Personally, I do think the rPi folks themselves should step up for
> *testing* at the very least. I did point them at our downstream WiFi
> branch at one point during a previous discussion and haven't heard back,
> so either they never tested it, or they did and it didn't break
> anything. If they're shipping popular Linux hardware where the WiFi
> chipset vendor has fully and completely checked out of any upstream
> support, they need to either accept that upstream support will likely
> break at some point (because that's just what happens when nobody cares
> about a given piece of hardware, especially with drivers shared across
> others like this one) or they need to proactively step up and take on,
> minimally, an early testing role themselves.

I'm agree that downstream (e.g. rPi) developers should also participating
in upstream kernel development.

Also Cc: rPi folks to solicit their opinions.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--rMlNXoe/imCf0D6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYLKewAKCRD2uYlJVVFO
ozFjAP9RYxpZvqkXRWkXgtGFOlqyvnG5Y1UEvsJdEKmqzdW30AD8CHkVFxApQ5TK
WCwps84FH+6ExEtPz0RrClRSWpi05QI=
=ea1G
-----END PGP SIGNATURE-----

--rMlNXoe/imCf0D6r--

