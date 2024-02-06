Return-Path: <linux-kernel+bounces-54745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FA884B31F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F8EB222E1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4BE12F36F;
	Tue,  6 Feb 2024 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsMkmGGE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72EF7CF18
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217648; cv=none; b=W8VI1LRfhAtM9PEwoRqpJur84CzbpSV6dicLG2Wm+5e2QFqNDJO4mPwNWLqiOGsVoaET/wjSIJqqVZEyZ85NkrUxmTr9QRTBJDZoSnKnO2Cst6H+hNAWUaupy64UzNFP58R6GkeVwM5dntbihu6DMWeKNemUyFBj2w/MTMKHVSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217648; c=relaxed/simple;
	bh=xGQ2siEis2dp8YR3J8tnqz3bRjd7/ANM689y38iX/oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJYaTKG+tTrZCbVIal6QQle5ouzfw/mj2cnnNlzpbeUT0RyxzB5h0y3VSDweL9TGBs7HKEngZjZLIwNZAe23AuKynayC7h5QXZ+8elC/ODna7jxAOFRiabB7kVT8NanYEvE4PGPBKr7+4DNYgLaXytIEBpc0/OaExG5WLV4jH+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsMkmGGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8ACC433C7;
	Tue,  6 Feb 2024 11:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707217648;
	bh=xGQ2siEis2dp8YR3J8tnqz3bRjd7/ANM689y38iX/oU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QsMkmGGEeNySOzggCapOZHRb32NG7Ip6l1hDQ4NnBvtlKm7HIbW7aT+nols1LjB9N
	 D/su0NYM3kFvuCoofvTcQu/gWUjbJBT76A+rUb5Tze5+vKYNePodBdRDC4vcYrdvex
	 lniOw8PeVYcxpYlGd1lhOQc8Uf3caf4EnzKGLV/1FT94J/VynmO6pENWQfbJm4LzSq
	 lY4alk/Sx05jE7Yk/n3lOxuox+5hn2ru3syZmPSW7NK7OfTnQTdWBtEAhNXJwsyg3V
	 gzGGc6SZrh5J+2JxqZ8golV1P5dziJUxJYrPeyxTpmNFGGkvKQW4RHu98gZZsZoOnk
	 xOr6Gluq0cCIA==
Date: Tue, 6 Feb 2024 11:07:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>
Subject: Re: [RFC PATCH] arm64/sve,sme: Refine scalable regset sizes at boot
Message-ID: <ZcIS6ySfoGzwv31M@finisterre.sirena.org.uk>
References: <ZcEaeLeEG8ve+Yp7@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tUcVIMoILeqN9Cr+"
Content-Disposition: inline
In-Reply-To: <ZcEaeLeEG8ve+Yp7@e133380.arm.com>
X-Cookie: You might have mail.


--tUcVIMoILeqN9Cr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 05:27:20PM +0000, Dave Martin wrote:

> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -9,6 +9,7 @@
>   */
> =20
>  #include <linux/audit.h>
> +#include <linux/cache.h>
>  #include <linux/compat.h>
>  #include <linux/kernel.h>
>  #include <linux/sched/signal.h>

Why?

--tUcVIMoILeqN9Cr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCEusACgkQJNaLcl1U
h9DN/Qf/eJiu4dmCh/4zaMTBDjDxjqZ3s7ykyv0apDohMVgaNbHu+Eoqm9vxUqMv
D+zC15iJvwB7xktHVrFPXjhUVUtB/xkLuOmt5sdOO52UptVGA/b62SeA+9H6Hd7y
p/fuFFELhqF+LpFCOeiUsMs5yLK5sovk62VCaG+LNF7enqg40PG7dLpdQYzUDgIM
X9gbipJErjoh8futoKQLjKUzA1oCoE481uJnL+sFyPzVTxrnEHB240B9kIFuz8ZC
j3Kym4jAcVbLsd0QquSgHqSwtF+WPbW+qvnvkeygZh+zwGKAnBY3roory8ZsBMSH
9V9uP0TCPd+hlf8pNeLU+SAnehdR1Q==
=/s1I
-----END PGP SIGNATURE-----

--tUcVIMoILeqN9Cr+--

