Return-Path: <linux-kernel+bounces-8248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F7D81B46D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287EE1F254A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4155F6BB34;
	Thu, 21 Dec 2023 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtpvG06C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBDA697A6;
	Thu, 21 Dec 2023 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d9f7af8918so485071a34.0;
        Thu, 21 Dec 2023 02:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703155942; x=1703760742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3V2bqFbXFz6uzfuAS3EMaj60alCFn4Hya5TWFrc6X7E=;
        b=YtpvG06CYl+FDHybVEb/ZxQDQEiWnV6BGj3Mhgop3OA4nD4yg7p10pyWofpy2el8wi
         nWwqpCHpyjQy8A1YA23kfs4z22AZarQK0Tkm4984RmxDeg7zZ6HCbpllQQiVuuyB/FpV
         5ty+IAcU2r49/ha3tu9acrRycY8Z4QOHc2xK/tQDr0neVTss3chybcjQnDo/2PXch7Xv
         34KY9/Zq73sI+fUwagP+pm1/sORUCmm20H/IiHzoU3bmSdz8ZugcoS1hxZBMYjVTqM/o
         K251G3q0/DrNTkVMLsxpHgnGwW5FvdwRZquZ7CVyPQgRhdPJQhfaxHCIjDFT3MClDL1Y
         AP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703155942; x=1703760742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3V2bqFbXFz6uzfuAS3EMaj60alCFn4Hya5TWFrc6X7E=;
        b=EsbUTWFQ8pc8ewjhy5I9cw5NxZvZtGJUiKKfUwx80Mzi58Zri7yPEmL5wK1E+Tdkfe
         AX/jYQ5EEZ/HZBBLKTs6+5l5Fom7I1huJ0HsoRHfjOafXZCXYRWPMQ/j4qruQJqDLnvx
         zCi10IUme6FlSTbYuT5h6IAu6MQS6qeDMSji+Wh7gKgmzY/Bl/VdixAxElKefY5mmESE
         5HfZAM+eMtsWCgasauuJc5GiHw99gZ+Gz4JlMftxtHBviVHQw0jwqL/r948J1w3x61jS
         C//A2SAisbB1j6xLXmboVZSe1ZsKh6QUmdpKrlOau9ZlwnVAFJi0AXGH2qlPYNs5WWkk
         klVg==
X-Gm-Message-State: AOJu0Yzi6XBxn2Vq6kR9hns4ubneQ4Nz7PaCYMras20Dl7L6Hd3M6Y5e
	LBPsBocS65bMcs1K9bMA/Lc=
X-Google-Smtp-Source: AGHT+IFl2rzPibrLT4xBwUK8vXKFc6W5IyhD8xzAPhynxnUm6Us+9LLSahTk+9jzj64K1Mvvu6RZXg==
X-Received: by 2002:a05:6359:a0f:b0:172:e0d4:43c9 with SMTP id el15-20020a0563590a0f00b00172e0d443c9mr964626rwb.10.1703155941859;
        Thu, 21 Dec 2023 02:52:21 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id q20-20020aa79834000000b006d978ad1c56sm598412pfl.54.2023.12.21.02.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:52:21 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id DE4F01025E0AC; Thu, 21 Dec 2023 17:52:16 +0700 (WIB)
Date: Thu, 21 Dec 2023 17:52:16 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Nathan Chancellor <nathan@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Karsten Keil <isdn@linux-pingi.de>,
	Karsten Keil <keil@b1-systems.de>,
	YouHong Li <liyouhong@kylinos.cn>
Subject: Re: [PATCH net 0/2] ISDN/mISDN maintenanceship cleanup
Message-ID: <ZYQY4OW4U28OY-i0@archie.me>
References: <20231221091419.11764-1-bagasdotme@gmail.com>
 <ba2ac330-d977-4637-93bc-99ee953faab8@gmail.com>
 <2023122121-yiddish-unproven-d793@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mrhndHuSUZHXM3O1"
Content-Disposition: inline
In-Reply-To: <2023122121-yiddish-unproven-d793@gregkh>


--mrhndHuSUZHXM3O1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 10:32:58AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 21, 2023 at 04:17:37PM +0700, Bagas Sanjaya wrote:
> > On 12/21/23 16:14, Bagas Sanjaya wrote:
> > > When I'm looking at simple typofix against ISDN subsystem [1], I find
> > > out more about subsystem activity. It turns out that the subsystem
> > > maintainer has been inactive since 3 years ago. And also, when I test
> > > sending "Lorem ipsum" message to the subsystem mailing list, it gets
> > > bounced.
> > >=20
> >=20
> > Oops, sorry not adding the link.
> >=20
> > [1]: https://lore.kernel.org/lkml/20231221024758.1317603-1-liyouhong@ky=
linos.cn/
>=20
> I too like to ignore pointless changes like this at times.  Just because
> others do, does NOT mean that the subsystem is not being maintained.

Unless maintainers in question agree after their inactivity.

Ciao!

--=20
An old man doll... just what I always wanted! - Clara

--mrhndHuSUZHXM3O1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYQY4AAKCRD2uYlJVVFO
oyzDAQDV0vQYfA1X7q9/0rAvwBI4TYCCe68k3H+T31bEqvwjWwEAwFw+NsdY7K/O
rO+vF4hMLPGDdjm3BRdpB5MsdoouKgk=
=NBX+
-----END PGP SIGNATURE-----

--mrhndHuSUZHXM3O1--

