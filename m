Return-Path: <linux-kernel+bounces-75025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6436E85E1D9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5AA1C22F91
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062B780C03;
	Wed, 21 Feb 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATAu4DCG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D979DD6
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530569; cv=none; b=ZwR0X4y8GK7rCIz/R5j/Zf8oZ5oXt+nsRq/mv+kSCPIuffz0e5Tty1dDXKtM4ZsebltEnZyxB4tVuZTc/Kkd6BXJ6Vcq1yO7Jk5UbRq0xPN9rfPQ0G0sdaaccWYz5wJW1HGCO1+5+zkmXMWECQ2l8PZjBEi9yGRKSot7IgLDiS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530569; c=relaxed/simple;
	bh=hwpaeAK2A0BRvX+cxbKnv7ZICdPQvSnj7qc8U9mUU5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyiZWErX1nyqT4nWvWo1VDCpV51j7KD33geF//VX7DEgpyP00c7tGQRxRVimODdMNJLVXcqVGTIt7+PkCrHDTY28kDFV9cgHDmiQaHhidyqwcO2vzZ4lFq+MVTuq9Wku9kyB2zNp1Dnq6r5dbUHrq986vxM4xMNAgmbPxOnJx/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATAu4DCG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708530566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z6KRsTdorxPN8BArhHDwcf2eHxDT7ZWnApI5eFun+eU=;
	b=ATAu4DCGGwGA90SztorHap2OnGMzZ65fhlxuMVYXdPfODHbDQm5e8e7bBRm65Q/L9X8VgQ
	kJSI3y50bH1giYy4Fq3DlCfuhrj4TV5bW9zyNncwk0YjQKaIIR18+3JoJ+mvfnSMfhgkLJ
	24mOaXrR9RoqYqE2KqyGOhw1Yw1P8io=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-VBIIv13sP-Om0KcaTbf6Sw-1; Wed, 21 Feb 2024 10:49:24 -0500
X-MC-Unique: VBIIv13sP-Om0KcaTbf6Sw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50e91f9d422so7905334e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:49:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530563; x=1709135363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6KRsTdorxPN8BArhHDwcf2eHxDT7ZWnApI5eFun+eU=;
        b=pyGU3MTjeB1REVLs74ymDYIG3mCAb6y7Ttse4Jf3avNr4y5k36/HhirWM8ThdlGT4z
         3ruEi98ow5mNBspDsC76UiptcxJzCZ/eF40abof/CzUyc6DTZZl681YVShIsldgU75Hn
         aKa0XSW+iO/u5Bd4llZZh96tDPWe1xS8TlhRFenMahwkQUQMBJY8LA2QI0JywGqow/KU
         IuPHW7pn6THIYdlg3c24gyYFp/Sfd75n1iluVQW1EQ+hFvxKyl2P9OJLgv8T7Melmk8v
         nDc7NZacdgHi4Xm0Szciycb1/WnkgdZfkgLj/5dJLb9lN50g3ZYUBQqnttUylBHCnuZ6
         IbRw==
X-Forwarded-Encrypted: i=1; AJvYcCUK1fNbmKYVmPhceu/mie1krG+cpIr36ZRszkwSHIZxsHQ00oqLLaq5+RakhS96bw5rVAZxoqhfByGeUpGZnyvZGil7j0iPMnhxrXge
X-Gm-Message-State: AOJu0YygZCvn3uscLfwTs4EZiWHpnyV33r08sBkC47NoChmhDgVedf21
	mkWuhm4EmyjkVr8/8DVJQVr7Ix7Wi8FXkMqlvh9tJPpDvXkZMKU+BOu/9VVC/7afA9v6Cq6w1xw
	lOH3pvGAdeIDzuZpamfgRDTA+nY4UxEfTwRhe2aRUUCF3wAPv+ze1z1rJAYLYow==
X-Received: by 2002:a19:7407:0:b0:512:9e9f:2f1d with SMTP id v7-20020a197407000000b005129e9f2f1dmr8996667lfe.58.1708530562855;
        Wed, 21 Feb 2024 07:49:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9pakw+7NCjEySxHEjXbXEUwPzjgBc/GmOH1cvET55lg5PolO3VHYe4uM1ahCdUT8OQGu5uA==
X-Received: by 2002:a19:7407:0:b0:512:9e9f:2f1d with SMTP id v7-20020a197407000000b005129e9f2f1dmr8996651lfe.58.1708530562408;
        Wed, 21 Feb 2024 07:49:22 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id a8-20020a19ca08000000b00512d574bf49sm227000lfg.221.2024.02.21.07.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:49:22 -0800 (PST)
Date: Wed, 21 Feb 2024 16:49:21 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org, 
	Erico Nunes <nunes.erico@gmail.com>, Enric Balletbo i Serra <eballetbo@redhat.com>, 
	Brian Masney <bmasney@redhat.com>, Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: defconfig: Enable zram, xfs and loading
 compressed FW support
Message-ID: <bcmgu7y2aolyti7kzoitepcpvjj6omkmo7jro2qtv3d7xqyw3v@jy2qe2hkf7zf>
References: <20240221125928.3711050-1-javierm@redhat.com>
 <9f419e86-6e14-42a1-84e1-31cab62d8ea2@app.fastmail.com>
 <205248ce-caeb-4090-998e-379f79639bec@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="udbrxo4xcwl7lmmu"
Content-Disposition: inline
In-Reply-To: <205248ce-caeb-4090-998e-379f79639bec@linaro.org>


--udbrxo4xcwl7lmmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 04:39:18PM +0100, Krzysztof Kozlowski wrote:
> On 21/02/2024 16:31, Arnd Bergmann wrote:
> > On Wed, Feb 21, 2024, at 13:59, Javier Martinez Canillas wrote:
> >> These options are needed by some Linux distributions (e.g: Fedora), so
> >> let's enable them to make it easier for developers using such distros.
> >>
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >> ---
> >=20
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >=20
> >> @@ -1595,6 +1599,7 @@ CONFIG_HTE_TEGRA194_TEST=3Dm
> >>  CONFIG_EXT2_FS=3Dy
> >>  CONFIG_EXT3_FS=3Dy
> >>  CONFIG_EXT4_FS_POSIX_ACL=3Dy
> >> +CONFIG_XFS_FS=3Dm
> >>  CONFIG_BTRFS_FS=3Dm
> >>  CONFIG_BTRFS_FS_POSIX_ACL=3Dy
> >=20
> > Unfortunately this will increase build time noticeably, but
> > I agree it is the right thing to do.
> >=20
> > Can you send it (with any other acks) to soc@kernel.org so
> > I can merge it from there?
>=20
> Due to XFS, please include:
>=20
> Nacked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> so this will not be precedence used for further patches like this
> (Maxime already used such argument, so I want to be sure it will not be
> used against me in the future)

For the record, I didn't use anything against *you*. I'd just like
consistency over how defconfig rules are applied.

Maxime

--udbrxo4xcwl7lmmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZdYbgAAKCRDj7w1vZxhR
xWQXAP99z7nVKexNdksr6Ox8bZXwCip/K7ljbIGI4N3Upm0+6QD/cf89eUB1mSXj
+t/AAF/e2R8R2KbnuH9HWt1WyQ7kCgw=
=ut0h
-----END PGP SIGNATURE-----

--udbrxo4xcwl7lmmu--


