Return-Path: <linux-kernel+bounces-75028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B22F85E1E6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7997BB23E82
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF0980C02;
	Wed, 21 Feb 2024 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxgtkgOM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DAF80BFE
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530688; cv=none; b=Omx6R7nmrbJ/3xNEjPcRsQBYiGsS9KfHpB+P/mOYZSMu8/6XvYhGzxA7ZVWnYc+TkA7BH65NWBLh4Q9tRkU1jMEU1H1ZDiC1rnKHmvyLUF5nZEARQa9U6ncdpq5lCeHoVlnj/QbkKC1Q2sNrdurNXZl3GcIWJT0ahDwEAIfBWtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530688; c=relaxed/simple;
	bh=6vxZNRAJfKX7NUOsWuC6BFl9z7Yjfzkpmb7xxziVVMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYBdFdGSIibvcTf1dJ2WJ8lBwZhnujMXnIxpDyG+wb6c7DVJ1JkdEl/s+9QtpmyA9eO1yrNWGQWHbqypzdWGQAEkKelnIGCuUhx6moKsMOMJ4foyzp0lg7KwRBh92VNwb4W1Lnr0WtwQh8buZzPxzG6pHpRjcjm8EDu2SksbhBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YxgtkgOM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708530685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6vxZNRAJfKX7NUOsWuC6BFl9z7Yjfzkpmb7xxziVVMI=;
	b=YxgtkgOMSYtzcA7BHbPYPootbVlne92biLmeep8RGzXJoBAHg21YS9TnIXRHWTavQMvPEf
	MqewBPOmdEU0pF6TEMQnDBToZdbYspPj6XE4TDWmtF+6o10Go0OnX048ZKFkS/ViLsheCm
	r5BgLNte3e89ONf6tXjf/JO36SDSQoY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589--VWZnVdfPKaXmwophUaHOA-1; Wed, 21 Feb 2024 10:51:23 -0500
X-MC-Unique: -VWZnVdfPKaXmwophUaHOA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41256ffe281so20118535e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:51:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530682; x=1709135482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vxZNRAJfKX7NUOsWuC6BFl9z7Yjfzkpmb7xxziVVMI=;
        b=VnQu5S08ksJB7Qn8N7t3IRw2F6UZxptOJrXycDIBhBBk9ma1HoYFlPzoSDL/+Z9gyM
         yMGhzfpOlS/Y618J7tYrL68X4uCBLbJbpKozuVD0gkjl++jR25efJ5b/k9xP3kWHip6A
         IotMdYYVQE8VWpJ7sq5XwWhNRy22NbkkuvqrJ2M2yitIISxHD9KIqNID9ISeqLeRZkrX
         vtpOo7Sz9AlLSacgbH5vjkkSle1vtNMTFUEPvmSNMu0awaduqJimw3sPfUGIMp5+hjNc
         fpEnrd/rbzTozl2O2KalZqdFXZ+iYspeF5Gz8KKqsSBtUM89+Vsf4ECc1OClvGHinTqN
         6xPA==
X-Forwarded-Encrypted: i=1; AJvYcCXtVXN7FoPkOY/JLLukuJx5CfAxIfzmr6E3/T9jqp3xmfewXssrefaeQJB0TR8djBWHGAJ8iCeiXrvFjGlSdVvxVNPP9xh+jPVi5nvJ
X-Gm-Message-State: AOJu0Yw7s1auk8HXMvPNrb57Te90T7LxzDNRc/s8R4jS1KQX/M5O3oc2
	S9Kk6ImxKGkRCLZYZ/yxiY/Ik6eBkRR00pCu7GMFuyukqBIXVaz6m1gKjddNr+3WdrqUrUIBCBo
	0LM3gJXWktkkPiYvlqDjoglIMMeEqqlcKocekqtuGZQn4thv/3gBm3cZw8TFGeA==
X-Received: by 2002:a05:600c:1c1d:b0:412:5757:e87e with SMTP id j29-20020a05600c1c1d00b004125757e87emr9066312wms.31.1708530682781;
        Wed, 21 Feb 2024 07:51:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpCSFLJg+1H78+yjZdUWj+YwI9fWV5IfpbTSIOPq4OG2i4jHssWZwbBB/QKhIcmcEyNkvmiA==
X-Received: by 2002:a05:600c:1c1d:b0:412:5757:e87e with SMTP id j29-20020a05600c1c1d00b004125757e87emr9066297wms.31.1708530682419;
        Wed, 21 Feb 2024 07:51:22 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe647000000b0033b406bc689sm17487652wrn.75.2024.02.21.07.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:51:21 -0800 (PST)
Date: Wed, 21 Feb 2024 16:51:20 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org, 
	Enric Balletbo i Serra <eballetbo@redhat.com>, Erico Nunes <nunes.erico@gmail.com>, 
	Brian Masney <bmasney@redhat.com>, Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: defconfig: Enable zram, xfs and loading
 compressed FW support
Message-ID: <724jnhrbs6r4q6whynr3aon5w7mhfvetlgcnts4nukvtxbuium@mrjv6apjqk7r>
References: <20240221141350.3740488-1-javierm@redhat.com>
 <1f28256c-e436-4add-aa67-2cfb2248b220@linaro.org>
 <6scz7iti3tzzrd4ph3gnuc2pvkcbtuuicgfgujh3pa3c34kdkt@bhfa4xbxeu7t>
 <cb8bf006-57df-494e-80f3-947582ec71f1@linaro.org>
 <fy3wffb2jwv4veo3golfn5olri77clxywbuwuokese7sbobixd@mird5k66cl2w>
 <56625c21-1b34-479b-b5b2-4c4d8b7a11b3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b7rp77zy3dqc2xbd"
Content-Disposition: inline
In-Reply-To: <56625c21-1b34-479b-b5b2-4c4d8b7a11b3@app.fastmail.com>


--b7rp77zy3dqc2xbd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 04:41:38PM +0100, Arnd Bergmann wrote:
> On Wed, Feb 21, 2024, at 16:24, Maxime Ripard wrote:
> > On Wed, Feb 21, 2024 at 04:10:12PM +0100, Krzysztof Kozlowski wrote:
> >> On 21/02/2024 15:48, Maxime Ripard wrote:
> >> > On Wed, Feb 21, 2024 at 03:22:38PM +0100, Krzysztof Kozlowski wrote:
> >> >> On 21/02/2024 15:13, Javier Martinez Canillas wrote:
> >> >>> These options are needed by some Linux distributions (e.g: Fedora)=
, so
> >> >>
> >> >> How ZRAM is needed? Why Fedora cannot boot without it? Debian, whic=
h I
> >> >> use on my arm64 boards, does not have any problem.
> >> >=20
> >> > Is it relevant in any way?
> >>=20
> >> Yes, because it is justification why we are doing it. Each commit is
> >> supposed to explain "why" and the explanation here is not enough.
> >
> > There's a why though: it makes Fedora boot. It might not be enough for
> > you, but that's a different story. So, if it's not enough, please state
> > exactly what you expect from that patch description so Javier can
> > provide it.
>=20
> It's definitely enough for me. It makes a lot of sense to have
> a defconfig that boots common and popular distros.
>=20
> I don't use ZRAM either, but I can see that being useful to
> avoid swapping to SD cards or eMMC when that is the only
> available swap device.
>=20
> >> >> I kind of repeat comments from similar patch earlier:
> >> >> https://lore.kernel.org/all/fe1e74a2-e933-7cd9-f740-86d871076191@li=
naro.org/
> >> >>
> >> >> About XFS: I don't think it is needed to boot anything.
> >> >=20
> >> > Just like 9P_FS, NFS or UBIFS.
> >>=20
> >> NFS is often used on targets, e.g. my board farm, but also by other pe=
ople.
> >>=20
> >> UBIFS was added recently because one device was using it - you needed
> >> it. 9P_FS looks unnecessary.
> >
> > So all we need is one person or use case to require it? Sounds like
> > we've checked that mark here.
>=20
> I think we want all of the above. We can probably drop ext2 since
> we already need ext4, but that is a different question.
>=20
> >> I was working in distro so trust me - they do stuff differently
> >> and they not need XFS in our defconfig for anything.
> >
> > Sure, but you're not just arguing for XFS there.
> >
> > What I really don't get is this: this makes the life of people easier.
> >
> > Being able to test an upstream kernel quickly when you have a bug in a
> > downstream distro is super valuable for any distro developper. And on
> > the long run, if we don't make the switch from a kernel distro to a
> > mainline kernel relatively easy, we're the ones that will lose out.
> > Because people just won't bother, or be frustrated and thus super
> > reluctant to do that work.
>=20
> We had previously discussed adding config fragments for common
> distros the way we have kvm_guest.config, but if the Javier's
> patch is all that is actually needed for Fedora, that seems better
> to me than the added complexity of fragments.

Oh, right. Fragments would be a great tool to reconcile the need for
minimal boot time and supporting reasonable use-cases.

I guess it's even more of a struggle with the single arm64 defconfig vs
the minimal vs batteries included defconfig setup we had for arm.

Maxime

--b7rp77zy3dqc2xbd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZdYb+AAKCRDj7w1vZxhR
xfneAP9jK3qR96b/wB2KMaKgrfj0X3cPayFrngbz47ysnllt7QEA1vqkfXuQyvem
rL+P/babebxH6r64YEa6nGgy/UEjDgw=
=XUC6
-----END PGP SIGNATURE-----

--b7rp77zy3dqc2xbd--


