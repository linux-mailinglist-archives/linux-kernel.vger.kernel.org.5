Return-Path: <linux-kernel+bounces-102961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF5E87B922
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06190285182
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94F85D47F;
	Thu, 14 Mar 2024 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyMQnHws"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF75779C5;
	Thu, 14 Mar 2024 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710403887; cv=none; b=spK1sVJwGAL32gY/JStZRftIt0a40kyoyyRsmBw9TQ17iteuSSHzERy2rdCmf1Nnh17qUnpIeRxDaD4mrahJsOqHIP7D2kGrI/T37izjuIr9aZmliV9rwBYotuhDJrRDza3revOmQ0nvR/6npwTAoP1H2KMKUVrAOlz3iL0vqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710403887; c=relaxed/simple;
	bh=NO+ZW60yLD2wc8AABrXiS+RwiBeV7cq6+PvpAuXogEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ponPqu7xr8049zhLutENa7fzoHf+Z0acVbadb7MibmQNOSrgJUh10U2y72h4YJslSNlXFTY7Y5LYHCoQ88XXNR46RisOrNnSGzilgkMQwy5Wp7wUqcpT4BOFd8td+l3criKssX80SWBl/hQipztAkEKfJMeCQB7gUoRyrGXi4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyMQnHws; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6b6e000a4so601625b3a.0;
        Thu, 14 Mar 2024 01:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710403885; x=1711008685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ed0A7yGqIqW7nqq4bbIHiKgiRHb6GXeWpYIhTrEZnuQ=;
        b=MyMQnHwsvjss/1a/Xd3w5y5X2004KLuQ22gsIzWuIvzEz5/Ie+SZxg6fm3+8TG7VIj
         oJu4obe+Pq+hQTZDcj/pHzPriNHoHYVBS1FevfhO6z/rSnIY9PGBe6sxeqWly3IPHknJ
         UptEns3NEOGogzJXXfiwl/kuQ2ejht/PUy494eGQh59YOkPyOYpbne6DaEfmlwsVpc/u
         21YmqhBnFn83nITt8aiulmY4YAbVA31aDyiVpNY6WEJf3Ey8I0vgDaEA3ZhtM/Y3wWgk
         jM2vMw7CAJhajzWCGhEXo8SxVkqID0bNitF9dm/Is7CM8gJl2DGCAyAtSvDWE32lbZnw
         Skpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710403885; x=1711008685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ed0A7yGqIqW7nqq4bbIHiKgiRHb6GXeWpYIhTrEZnuQ=;
        b=IqnUL69f/aW7aS4bPovyXeTGXvf3zDGJh49GTxHkyZHuPbqDv5Lg2XZHPvJFI9DjUi
         7C1CDdFZ6msf6X0PcO7rKp5DPZOsKcNH5BrLzowmZoHv70DqxVVn4Tl41rfBJv8vQ9eV
         NS3GsASZkV2u7HGBCAHNqEhnYHOSinrIeqPhM6uZuc4o/qpnkZZSid5sk1AoxpaYS4XO
         an8s4zIalKZWRnM/YSR659iSy0B8cRdLfn/59fkYjz31x0BMIRwk23x8MiTv2gPv8Yn/
         RiQoys8rQ4/PsP8EeYbPZUVFONZc6ULNz8xyh71KqkqzFwVQtQrndgXaK+MpVvKKo+L2
         e2Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUF7PPmjvvdC+J6rNnluaVr+dPI4S/DHJNx5QkSOggHVr2yVoVmzpydNh2b7HiN7jH4wP6qb04kQQU6ZAmJRqM+GvlqqjPKn1VXsb6DY4mmEC+BkmT3bkPCuYEk9wTwf5N0DE8O
X-Gm-Message-State: AOJu0Yz+3pTDBHOi81HH/5EaCHKQpCqUEtAyvVU/CewoHpoMH1vHtcHC
	u1hUJfpqxMChFZ9OyHG739US4oD309PZxBv2qV1f0UFxPmRArVwH
X-Google-Smtp-Source: AGHT+IGCfGhd7Co+tzE7kQNOWIKve63oD0Q0B55yf8nAOYslaGaOI6ZA+HiVaX26sCHBwOdjB/MoWA==
X-Received: by 2002:a05:6a21:328b:b0:1a1:75a0:db4a with SMTP id yt11-20020a056a21328b00b001a175a0db4amr1473705pzb.23.1710403884866;
        Thu, 14 Mar 2024 01:11:24 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id s40-20020a056a0017a800b006e6859b647asm905816pfg.16.2024.03.14.01.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 01:11:24 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C85AF184797C6; Thu, 14 Mar 2024 15:11:20 +0700 (WIB)
Date: Thu, 14 Mar 2024 15:11:20 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: Re: [PATCH 6.7 00/61] 6.7.10-rc1 review
Message-ID: <ZfKxKNNJycoCzTkO@archie.me>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C4B/hgc1ZARScNut"
Content-Disposition: inline
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>


--C4B/hgc1ZARScNut
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:31:35PM -0400, Sasha Levin wrote:
>=20
> This is the start of the stable review cycle for the 6.7.10 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--C4B/hgc1ZARScNut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZfKxJAAKCRD2uYlJVVFO
o52zAP9ILH+cmHH3mCZJSxV3BMh/XyFxwHhVtC/MAMmNyBMGuwD/bAeJyp2/i/12
mlC1r83WI3TdgtbHWd71OaKVnIij1AE=
=7uJa
-----END PGP SIGNATURE-----

--C4B/hgc1ZARScNut--

