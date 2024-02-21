Return-Path: <linux-kernel+bounces-75581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E0C85EB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2967283FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262D8127B6A;
	Wed, 21 Feb 2024 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Y2mV6MaF"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA44C3613B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708552812; cv=none; b=jNem4eMTmESaJHBLwZ56AdtbgwquhDd+J0JgLdL9o6Rg9MfZ98Kq4KHvmpNyq+fUcCc+tS40t56D+pso1caQ/ouXtTETKBaPaxhAoS3lgT7QCC5f/LdM2AcqHZQvDIrWwgiHWHtw3OLhXqRKt1obUPtU5wEHmN5Zwc9glCO5pWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708552812; c=relaxed/simple;
	bh=SufwymZ5NwgL0XE4kcsDtEe7AYzPzxizEBrTqHQThRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRU3a/CxLRPsfElO2AsT0Gt07RHaK/ibsWVLKy+wtXkrQfglg6Kq5mwpg0zo7GogC/6XNxohMcz8lyojnxJqSzBez6eA/jreXmFSpREyrEV2iekt7C1kU7/kfZ1eWO18qLNPC+gvOT/ZFqYqZ3jlDXxJiDDmzkyQ1tKjn+nx9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Y2mV6MaF; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708552806;
	bh=XnVUPIkyCpULff+S414jT9EjhkNpiO8qlJBr7sBhaGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y2mV6MaFSgV0UP3J3HeMAGsYirQsj+sP//OrS+/CUTPvxW4fctS88LezG04WdU6z+
	 /dr0c47MoAZEd71kENsFfWLIXIT+vUxWnR8pTGc17MYqccZsNoL96+hizbaKCHfbaq
	 vRib2s69g46VgA0ZqzPx/A5nq91/Ijm7jUJXefOYbo5CzpYnLlmqVG2+xAWlX5/WBX
	 msus5ECBHcmPr9jCNka7FX1CtHwsBim3rkwMjbt2oNGEaDnx3mhhgfCmKeHlE6aSYV
	 lHlAfh00/4VH3jBMa8No7aOjJsNchOQTlevj1EBxSrdr7hh8qFbpmBmafOIjeX9zs9
	 nJS2PhOLQFbEQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tg9Dg6qWdz4wcq;
	Thu, 22 Feb 2024 09:00:03 +1100 (AEDT)
Date: Thu, 22 Feb 2024 08:59:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jani Nikula
 <jani.nikula@linux.intel.com>, Arnd Bergmann <arnd@kernel.org>, Oded Gabbay
 <ogabbay@kernel.org>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matt Roper <matthew.d.roper@intel.com>, "Matthew Brost"
 <matthew.brost@intel.com>, Riana Tauro <riana.tauro@intel.com>, "Daniele
 Ceraolo Spurio" <daniele.ceraolospurio@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: skip building debugfs code for
 CONFIG_DEBUG_FS=n
Message-ID: <20240222085940.6cbb7c9f@canb.auug.org.au>
In-Reply-To: <zospejkdqekbndbov3ubbbvr5skxwohezeslzciivhxakfjoek@oa5sp2ffcfix>
References: <20240213134817.3347574-1-arnd@kernel.org>
	<877cj88lck.fsf@intel.com>
	<17209419-093b-4674-8b43-06c92312ef61@app.fastmail.com>
	<ngu6vq5izal6suyr57p4vlxnrn4kxyii4ewdktxvw7k3uezlcz@6oevav3wpcjh>
	<20240221172117.243799cf@canb.auug.org.au>
	<zospejkdqekbndbov3ubbbvr5skxwohezeslzciivhxakfjoek@oa5sp2ffcfix>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kwb+M4tVslI2c0Tke07JtS9";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/kwb+M4tVslI2c0Tke07JtS9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On Wed, 21 Feb 2024 13:45:35 -0600 Lucas De Marchi <lucas.demarchi@intel.co=
m> wrote:
>
> I don't think it's needed since drm-xe-next covers what is in
> drm-xe-fixes. Please add other maintainers and mailing list:
>=20
> M:      Oded Gabbay <ogabbay@kernel.org>
> M:      Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> L:      intel-xe@lists.freedesktop.org

Added.

--=20
Cheers,
Stephen Rothwell

--Sig_/kwb+M4tVslI2c0Tke07JtS9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXWckwACgkQAVBC80lX
0Gy5RQf/YxLuUSlc6Waa++WKI6+FKVhnxdxobjQoYhkC06LrLHdzLcOysj83pER8
jnoWCVjjB/KLSYlkALPht0we/GD2S10sH90KhaizyNf0Nwoz+tbx4W+IkLih1OOi
N/ujaQ+THyYXrvPtWNzzpMfrUYtOjwTaQd6CbREhlZMFprT/VTBL+Dov9xIwY3ZM
B9UAClAUP1KztZ7TuJco6Xh/jmi/0Q6kUcDfsev6klN4xAc+ZvUWkms2MQc7j5dt
mZQ1Z9nvatbwHaA1ZrWoAwGpEpHRtidCal/hir28pfgD4H3q6j0K1eVH4Clp915U
J15bKiSmBvBppvngNb2EZ72SYYdzVw==
=PsF1
-----END PGP SIGNATURE-----

--Sig_/kwb+M4tVslI2c0Tke07JtS9--

