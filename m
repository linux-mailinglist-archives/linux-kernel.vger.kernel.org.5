Return-Path: <linux-kernel+bounces-127018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6628945DE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EC31F22191
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5630C53819;
	Mon,  1 Apr 2024 20:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="jHjFVSmv"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6C951C52
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712002135; cv=none; b=kMFNCO/lwwNyfsMPBWBxaVglKfZJjS0oH+9j+28snzK16qPHRgAbLqV1f95uJanNZM3E+5K1NYrhbv+h7G1BBVKNlq60916NBk0tPGhXa9MU6yrq8paiHA5ROYAI/qw1nhWEQhwNuP9DDqBSCJ49YNWt3pbug5m/U7pQGdis//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712002135; c=relaxed/simple;
	bh=9ziyHFW1xbg3LeHXWDh3lD+n4WpebuIyi03HNsaX3Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7tmwyQSU9Iyo5evvmKNIkZPhNUUmwDCUGXnYcTLyRh5KxLTMgsiGKkZf7jJilasnOke4pY9tlSA1f+Z15mFGmfqqqLk1y8h8G0M8UOF8Tu7aYCW5DjyHnUxbdbHMZANuP809hGTaHK+yWqMvWJ/XWl7QiOux9JRnGh0q54ZZaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=jHjFVSmv; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 655AC62FD5E0;
	Mon,  1 Apr 2024 22:08:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1712002123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6uzxeeCXx2GteCLHIEaxu9FTl7Vo3pQTpoPxx4XKqAM=;
	b=jHjFVSmvo9SJZgKzBrfNcqyRlqocuEkwwmvOycbJKjzG474hmKijpqugq/bh9rbB/h284v
	9pZGaBRylOW3FmQWEfePFQt+pbKnRLGmwZOQOAZm24rrxgn6GMvBwQBKpFFgE2LDjDcrwk
	WtMJbT/dM/Y0HZ9Fy6s49fx6VukTrvM=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 Vlastimil Babka <vbabka@suse.cz>, stable@vger.kenrel.org,
 Lorenzo Stoakes <lstoakes@gmail.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH] mm, mmap: remove vma_merge()
Date: Mon, 01 Apr 2024 22:08:31 +0200
Message-ID: <2335177.ElGaqSPkdT@natalenko.name>
In-Reply-To: <20240401192623.18575-2-vbabka@suse.cz>
References: <20240401192623.18575-2-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4896029.GXAFRqVoOG";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4896029.GXAFRqVoOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm, mmap: remove vma_merge()
Date: Mon, 01 Apr 2024 22:08:31 +0200
Message-ID: <2335177.ElGaqSPkdT@natalenko.name>
In-Reply-To: <20240401192623.18575-2-vbabka@suse.cz>
References: <20240401192623.18575-2-vbabka@suse.cz>
MIME-Version: 1.0

Hello.

On pond=C4=9Bl=C3=AD 1. dubna 2024 21:26:24, CEST Vlastimil Babka wrote:
> With SLAB gone I was looking for what I could delete next, and then it
> dawned on me - it should be vma_merge(). It's simply an unmaintainable
> mess.
>=20
> The code is extremely hard to follow. There has been a number of recent
> attempts to made it more readable, by Liam, Lorenzo and myself. Almost
> every time this only resulted in subtle embarassing bugs [1] [2] [3] [4]
> [5]. For many of the bugs the only reliable testcase we have is the rpm
> process running in the Open Build Service. Which is worrying, as that
> clearly makes vma_merge() a potential supply chain attack vector for
> planting backdoors.
>=20
> Thus simply remove vma_merge() and all the related code, and adjust all
> callers to take the path as if merging was attempted and failed.
> The only downside is that there might now be more vmas and maple tree
> nodes due to no merging. To extensively validate that, I've booted the
> kernel with virtme-ng before and after the change and checked slabinfo
> for the number of active objects:
>=20
> before:
> maple_node          1159
> vm_area_struct      1538
>=20
> after:
> maple_node          1113
> vm_area_struct      1861
>=20
> Yeah there's more vma's but interestingly, less maple tree nodes. I
> believe it's worth it. The larger number of smaller vmas could even help
> with better parallelism thanks to per-vma locking. So the conclusion is
> obvious - we should have never tried merging vmas in the first place,
> hence the tags on this patch.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dd014cd7c1c35
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D4c6759967826
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D7e7757876f25
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D1419430c8abb
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dfc0c8f9089c2
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: <stable@vger.kenrel.org> # CVE mandatory
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Singed-off-by-one: Vlastimil Babka <vbabka@suse.cz>

Nyacked-by: Oleksandr Natalenko <oleksandr@natalenko.name>

TYVM!

> ---
>  mm/internal.h |   7 -
>  mm/mmap.c     | 368 +++-----------------------------------------------
>  mm/mremap.c   |  60 --------
>  3 files changed, 17 insertions(+), 418 deletions(-)

/* SNIP */

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart4896029.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmYLFD8ACgkQil/iNcg8
M0vAbg/6A8Krc8bk+nqpqjPO0IDAhn5xp+Cdh/sua9KVU7ddNCpZdgsHRUz91tU5
GOQQmTWjpZU55lTS72r7LCE6KvU/UYOAnIVbwD1Iy5xLAKd6261tmMhAxQlCqJ6E
7m/4jys/Kzex9tl6ulKsZHbgURoAfo+7WBuSSCwLJpFvxNMQMoKdIrHj/bbC6G7C
ylDz+pd1w7FM/3Lc/Le7xAMbG+EA+U3jcif0kprjXiq7njq8g4RalahModA4LI4E
NcehS9hGeueZrmaP2nKHhGryR/o1nc328tC1RzlF2Aby+oP9FxihUfYNf497oqew
VzOZqMeMzDV8Vl6oyQe8WqOp6z2Ht2588BnecgpHkckkUs99wltQr5XvYKSYVf51
WZUCXNSgB7XyUAJpgG+L/FBDvaMJCKeDhOesscm8SStVs7FEZQYXVf+Bf6SlK5sB
0ybZMW3vEdBd0tMfoic+Wr4FTgFwJcONeOkHTqjnp7t/tAzmNfh8qSW+LlNZ4ji5
T4uX+mkEYpNuMxq9/4t34nohaG+LgArjTwcFr1gfzBe1HasO6dGw/dUAM2rqrLlN
p7w8lNygK5FyVZUH9sXMoa+5HOxbcLjA9wAEP31ISwA+O688D4qL7gGWq6uzucba
kZPF9HYPD323SZhDZ+Z3UOuEbDDBHpSwuXplQjJYwokrTHGDelU=
=aH3Z
-----END PGP SIGNATURE-----

--nextPart4896029.GXAFRqVoOG--




