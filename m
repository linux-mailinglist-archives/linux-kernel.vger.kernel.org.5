Return-Path: <linux-kernel+bounces-74993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B86A85E102
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134951F23E85
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2DE80627;
	Wed, 21 Feb 2024 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckv1g7PC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B180616
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529099; cv=none; b=KtxlMd5LFPnaNT3IkHv7+I0anGhLDHlHtwLxuP43LZ2ymf2XpEWowMDtmn2kTUOneoI625LESpc++jAKfqP0L+BEDYZ2J+6LjOl2uFroliIjsreLQN9I6RQlZiKqngmdtF8bfwmRnBRT86TcW/2cj6Wkcd5GYlgz5EU4UgDTZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529099; c=relaxed/simple;
	bh=JC0OeWec5FrE69OK/lNBvWvQIi4uhRhvIlU+DytzGNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KV3x1U1qdt+f/06Bnq0kolXzeUFv2eczc0rI0tVHamJu7bYWX3Z9G3CC36NK3pPXGLLPOBOvOV9EtPZY+QmgH1ZvukjT3PK1Gk1P0DmkC7DnnmDmPyhnTCNrZb7HcOiGsBv1KrWWFKkNE0G1pNpEWAx1l5wnCaJvGpfplkwveFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ckv1g7PC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708529096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JC0OeWec5FrE69OK/lNBvWvQIi4uhRhvIlU+DytzGNU=;
	b=ckv1g7PCxhL3b96F7z2bjJu7XvjnvoWy2136kBX6hXmlhiqdP1co4iqPOFl/1wC5uink/v
	Bg37t6Ie71jXvcUCoX9ZscXi88MVNkCAbB/jS3pWjn9rBfPFfPKaJI/touvz7TqzHtVH+V
	fHgtkfnuawftoXuZhVnFy3tCeHnfoXo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-yQXoaKF3MhiyWGH70J9EeA-1; Wed, 21 Feb 2024 10:24:54 -0500
X-MC-Unique: yQXoaKF3MhiyWGH70J9EeA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68f33ba3d11so56872416d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:24:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529094; x=1709133894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JC0OeWec5FrE69OK/lNBvWvQIi4uhRhvIlU+DytzGNU=;
        b=CXS4a1JjGYPcyib8FLU+ox/NJzHP3MYHoT7jjpbkjne+Y2uAIIDoNxeZbk06jsU1oF
         +ho3n1RH9i3RyPC2HK9iF0BZL+rdGNIzJ1AWpp+vGGFFZJXO0yZyNCUbtXHB21/KHeZd
         n9iWIvY5TUM54h1AGmd0yDvEx7rT7PL1KvV3xH/MiLnjXLLAyfUy9cx7mVFhF/J/Ur8t
         O8nqESQ9QFKqAYbRIAI3aYrpniT39Ao8Y/45qT6jCzGGzzXHRlQM1VaRIpmwUqzdUWmG
         atheD3Gn6CaMJE3a2ck6ixc+ynzFy0P4Qzp4p/ubpgrCd+nYxl3XzBOOMw7+idlBfi3N
         tyXA==
X-Forwarded-Encrypted: i=1; AJvYcCXxQJK+lOeX3kcl4D/LUd9wDIgYTA5Ae+NBKgpHASYT08AK9H/dXU77ih+houe+zcyD3LAuXfgFl54r6piCp1C2jeYZoh28kAacAP2a
X-Gm-Message-State: AOJu0YzYBvc+zceh94+jZHpZUyodWMV7/qrNVI1RSUwIhqQGj+m31nsG
	cRWLEdMl6zvHgVnSf1dx5XDcbv8mglTA86l6iFOBjVpZFKiywSWJR3dAguvVY4o3EQy+FkzNhxU
	6YLs/kMi2bMrh+Mha9HUAtCHGbplspMU8j7jmJKbEs2cIAnNqTcXV44LUflS0Kg==
X-Received: by 2002:a0c:cb02:0:b0:68f:4191:6a9d with SMTP id o2-20020a0ccb02000000b0068f41916a9dmr11952170qvk.2.1708529094016;
        Wed, 21 Feb 2024 07:24:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPVZyaBfvZ8vXwiHa8tkALfxkIVZu+UfiW/uISQnCl11+LfUD1mAVqDNlrwtM6tDu7Kwc1GQ==
X-Received: by 2002:a0c:cb02:0:b0:68f:4191:6a9d with SMTP id o2-20020a0ccb02000000b0068f41916a9dmr11952141qvk.2.1708529093590;
        Wed, 21 Feb 2024 07:24:53 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id pv18-20020ad45492000000b0068f2ea5c678sm2307325qvb.118.2024.02.21.07.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:24:53 -0800 (PST)
Date: Wed, 21 Feb 2024 16:24:51 +0100
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
Message-ID: <fy3wffb2jwv4veo3golfn5olri77clxywbuwuokese7sbobixd@mird5k66cl2w>
References: <20240221141350.3740488-1-javierm@redhat.com>
 <1f28256c-e436-4add-aa67-2cfb2248b220@linaro.org>
 <6scz7iti3tzzrd4ph3gnuc2pvkcbtuuicgfgujh3pa3c34kdkt@bhfa4xbxeu7t>
 <cb8bf006-57df-494e-80f3-947582ec71f1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nbgb4ezh6w6ejdw7"
Content-Disposition: inline
In-Reply-To: <cb8bf006-57df-494e-80f3-947582ec71f1@linaro.org>


--nbgb4ezh6w6ejdw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 04:10:12PM +0100, Krzysztof Kozlowski wrote:
> On 21/02/2024 15:48, Maxime Ripard wrote:
> > On Wed, Feb 21, 2024 at 03:22:38PM +0100, Krzysztof Kozlowski wrote:
> >> On 21/02/2024 15:13, Javier Martinez Canillas wrote:
> >>> These options are needed by some Linux distributions (e.g: Fedora), so
> >>
> >> How ZRAM is needed? Why Fedora cannot boot without it? Debian, which I
> >> use on my arm64 boards, does not have any problem.
> >=20
> > Is it relevant in any way?
>=20
> Yes, because it is justification why we are doing it. Each commit is
> supposed to explain "why" and the explanation here is not enough.

There's a why though: it makes Fedora boot. It might not be enough for
you, but that's a different story. So, if it's not enough, please state
exactly what you expect from that patch description so Javier can
provide it.

> > I'm sure Debian can boot without MEMORY_HOTREMOVE, or BRIDGE, or
> > NUMA_BALANCING, or BPF_JIT, or NFS_FS, yet all of them are enabled. Let
> > me know if you want hundreds more examples.
>=20
> So if there is any bug, you are allowed to add new one? If there is any
> silly option, you are allowed to add new one?
>=20
> Feel free to propose dropping of any irrelevant options.

No, of course you aren't. My point is that Fedora is a distro just as
established and legitimate as Debian is. And apparently "it makes Debian
works" is a reasonable argument, since, well, it does.

If making Fedora boot with that defconfig is not a legitimate goal,
please state why, and document it (with the ack of all the maintainers
involved with that defconfig, obviously) so we don't have the same
argument over and over again.

> >> I kind of repeat comments from similar patch earlier:
> >> https://lore.kernel.org/all/fe1e74a2-e933-7cd9-f740-86d871076191@linar=
o.org/
> >>
> >> About XFS: I don't think it is needed to boot anything.
> >=20
> > Just like 9P_FS, NFS or UBIFS.
>=20
> NFS is often used on targets, e.g. my board farm, but also by other peopl=
e.
>=20
> UBIFS was added recently because one device was using it - you needed
> it. 9P_FS looks unnecessary.

So all we need is one person or use case to require it? Sounds like
we've checked that mark here.

> >> This is a defconfig, not a distro config. Please don't make it distro.
> >>
> >> I will gladly support things needed by systemd or equivalent, but not
> >> unusual filesystems needed by distro.
> >=20
> > It's a defconfig. It's whatever people want it to be. Or we need to come
> > up with a clearly defined set of rules of what is acceptable in that
> > defconfig or not, and prune every option that isn't.
>=20
> So that's the rule I am commenting from time to time. defconfigs are not
> distro configs. These are reference hardware configs and debugging
> configs.

Supporting a board farm is hardly either.

And again, I've never heard of such rule for that defconfig in my ~10y
as an ARM platform maintainer. But what do I know, right?

> I was working in distro so trust me - they do stuff differently
> and they not need XFS in our defconfig for anything.

Sure, but you're not just arguing for XFS there.

What I really don't get is this: this makes the life of people easier.

Being able to test an upstream kernel quickly when you have a bug in a
downstream distro is super valuable for any distro developper. And on
the long run, if we don't make the switch from a kernel distro to a
mainline kernel relatively easy, we're the ones that will lose out.
Because people just won't bother, or be frustrated and thus super
reluctant to do that work.

That's the part I don't get. Why do we want to make the life of people
harder. This patch has never been about making the defconfig the main
Fedora kernel configuration: it won't be, just like it isn't the Debian
kernel configuration.

However, it works for your board farm because it's just so much more
convenient, you can get a kernel from all the auto-builder and boot that
and you know that it's supposed to work. And that's totally reasonable.

So if it's convenient for you and your board farm, why do you oppose
other people trying to make it reasonably convenient for them?

Maxime

--nbgb4ezh6w6ejdw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZdYVwwAKCRDj7w1vZxhR
xQfIAP9aQIEniQ/41hUku1FMmbfk8C6uHIE42LCeZlNwAK37NwEA0gT5QzXSVMC8
w6iE/SmpnOSFNLVcqpa+35zgMWw3Uw0=
=cwHJ
-----END PGP SIGNATURE-----

--nbgb4ezh6w6ejdw7--


