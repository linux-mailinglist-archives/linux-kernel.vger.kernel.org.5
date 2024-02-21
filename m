Return-Path: <linux-kernel+bounces-74936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFF085E034
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44CFFB22A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926C17FBA8;
	Wed, 21 Feb 2024 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoCfnC8p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE377FBA6
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526919; cv=none; b=m3COvw13wmTPigoi0A1jf/gMFAXhTpYnz72Y/vB/ntuj7vSfOb2UltQDlYJSDJU6HKciM6mm62OE6NvOS9l5gWVuUfiSQfFISMfnA/ydcw/t4zuwYZZx5GUlmjP92Jvk6s9z91ksfBg0a/ZDydID67rb7h+tGYBvbERhCbO65fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526919; c=relaxed/simple;
	bh=E6rUGIoX3jmK3ZWXlGG5Zj1+nEasvTnZXjGhct+3LKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E73dw7LyrS7BuxvwriFf2Wzwpd0Z7jWJ3vLVg5yrjAvD+TGhYl3MhXb//51EvBZareCVgHNX1eKDuMAJu+PLj4QdTbUrY0RnWmvOFheBVRCEf9fmyy0HImmgtqJqn/VWnBdKUEadg/hkiCUC6/ODQ4ACK2vEXiG5Q8WxVo6T7mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UoCfnC8p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708526917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E6rUGIoX3jmK3ZWXlGG5Zj1+nEasvTnZXjGhct+3LKA=;
	b=UoCfnC8patLyA0pOkrIJ1XuCfOPYGllSryJDEd7XxfISv36bshHCNZQoAKf+cWbfYyshBx
	MXQWc3ZQukXCV9nBbI9jBRA27YMqhyWueCI/gvTz2Y63heEaVmJLJQWhMgZOEjnIqSooM+
	dv7qAfNIInyQIq5Nem5kXaGytBJsF1k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-YKWBFKHSPAue6Eez1tTlDg-1; Wed, 21 Feb 2024 09:48:35 -0500
X-MC-Unique: YKWBFKHSPAue6Eez1tTlDg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e435a606aso40749185e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708526914; x=1709131714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6rUGIoX3jmK3ZWXlGG5Zj1+nEasvTnZXjGhct+3LKA=;
        b=eFvvlgZyl2M4cIo48Rv1TFLRgCdCCqqXTcnZVlYZq3BW8vzAV+BLAqrEH7J2mB9wUN
         xEVexPd96tvoehKtHvot0aDAbJf2YB8jDKwEPU4To78ugURpLRLd6eYEtxlSpage8nhx
         84y/UCAsb+z2ajAJKw/Ckual0bSNOId+iSgXCfapdNTagIOsn5zhCU0Fk1+LOWprutL+
         fqyakxtJEc3M2SDKAWEgXB4twDD8JCDPkauxuBvLKqE+AnTOy1/b+C3PcnCFSLVwj9X9
         fAyTwE1xi2ljBkhWd9ghHukuA1WVOEDb3uDz416EiXQgIPPF2VoZ5zets0vh6ez4/xj3
         uKGg==
X-Forwarded-Encrypted: i=1; AJvYcCXaPSal8QGQ8V2QHvLsyCMejLYlBAF9eFrtyZt+LtERgGE6DcJeFCvMNdqgEjdONG0IljrgPz9kcQueI0V1eLe1GkxrfWnzvnFtKtfi
X-Gm-Message-State: AOJu0YxeDZa9xrcnHMyJCfsBtfuoB03N1M95QqY+PCuKtiQKSJ7W+cR0
	myOLwu346hRoB93/vKnPQJHx+4WSn58zdHbrZoAn74+Dno9s50GY0Q/5XzCiEMIsJqnhSjxSiN3
	SSuOSQcRDMCohtKdUZA1+99iEkJYBU9/JvWGBxVh7/omqMb4LxpeSG5ZapLVqqQ==
X-Received: by 2002:a05:600c:470e:b0:412:63f6:cc71 with SMTP id v14-20020a05600c470e00b0041263f6cc71mr7437875wmo.41.1708526914289;
        Wed, 21 Feb 2024 06:48:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfG4nEIctr2HaMwBCcJv+qECDB0nW3Cf3ADbfkrgxhDQUP09xX5FMAadINtlJRtI9kjpdCuw==
X-Received: by 2002:a05:600c:470e:b0:412:63f6:cc71 with SMTP id v14-20020a05600c470e00b0041263f6cc71mr7437859wmo.41.1708526913787;
        Wed, 21 Feb 2024 06:48:33 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id fc13-20020a05600c524d00b00412157dc70bsm18726465wmb.30.2024.02.21.06.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 06:48:33 -0800 (PST)
Date: Wed, 21 Feb 2024 15:48:33 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>, 
	linux-kernel@vger.kernel.org, Enric Balletbo i Serra <eballetbo@redhat.com>, 
	Erico Nunes <nunes.erico@gmail.com>, Brian Masney <bmasney@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: defconfig: Enable zram, xfs and loading
 compressed FW support
Message-ID: <6scz7iti3tzzrd4ph3gnuc2pvkcbtuuicgfgujh3pa3c34kdkt@bhfa4xbxeu7t>
References: <20240221141350.3740488-1-javierm@redhat.com>
 <1f28256c-e436-4add-aa67-2cfb2248b220@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wnlsxlke5bn36lym"
Content-Disposition: inline
In-Reply-To: <1f28256c-e436-4add-aa67-2cfb2248b220@linaro.org>


--wnlsxlke5bn36lym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 03:22:38PM +0100, Krzysztof Kozlowski wrote:
> On 21/02/2024 15:13, Javier Martinez Canillas wrote:
> > These options are needed by some Linux distributions (e.g: Fedora), so
>=20
> How ZRAM is needed? Why Fedora cannot boot without it? Debian, which I
> use on my arm64 boards, does not have any problem.

Is it relevant in any way?

I'm sure Debian can boot without MEMORY_HOTREMOVE, or BRIDGE, or
NUMA_BALANCING, or BPF_JIT, or NFS_FS, yet all of them are enabled. Let
me know if you want hundreds more examples.

> I kind of repeat comments from similar patch earlier:
> https://lore.kernel.org/all/fe1e74a2-e933-7cd9-f740-86d871076191@linaro.o=
rg/
>=20
> About XFS: I don't think it is needed to boot anything.

Just like 9P_FS, NFS or UBIFS.

> This is a defconfig, not a distro config. Please don't make it distro.
>=20
> I will gladly support things needed by systemd or equivalent, but not
> unusual filesystems needed by distro.

It's a defconfig. It's whatever people want it to be. Or we need to come
up with a clearly defined set of rules of what is acceptable in that
defconfig or not, and prune every option that isn't.

Maxime

--wnlsxlke5bn36lym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZdYNQAAKCRDj7w1vZxhR
xWPeAQDT7CEcNapap6MapS3Fswbd2HGjBOYLDGqPBoYDCmDQngD/RFfKh+NqAkGD
EC73+WgxZ1u2HafsgB6HRiwdF1NGGwE=
=rto+
-----END PGP SIGNATURE-----

--wnlsxlke5bn36lym--


