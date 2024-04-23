Return-Path: <linux-kernel+bounces-155124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B818AE58E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E0E1C22ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B1B8662E;
	Tue, 23 Apr 2024 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Nj0ErV9Y"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3066B6EB70;
	Tue, 23 Apr 2024 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873819; cv=none; b=TnGQ18+4CNPxLpdFHiVkjWvtgbes8rlrhGKPEjIlUOnEPabQeATwkj6cLcmYJbYP0i/I2T2r5u1z9hyDf0OdFXxXmnLHM3Ut+Mv4wlKTADNHBwtMMGv9FKM80nS/iPsBmjMhTCVtvtE8bmzI11tXBwqh7arjMNjHCf9JQrbWka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873819; c=relaxed/simple;
	bh=UZ//9VIhv4qjWnX5nh9G7I3qe5jqrU01sdWw60cEs94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3y4tQvbdFFMZm9MRl7ddcK6YC/xUvJB3z0mJYWrYqFVfM+vZx8LFlUQlQJn96DycULGm3Z3QwdXNGG3gGe454IoXplJBhPQtBrI7qApvYz4W+69kUR65bOizeGYrrlLgM8kdbLk7yIEQIgpx3PUKWSbw/AFovER+tnUqBNniVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Nj0ErV9Y; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713873809;
	bh=UZ//9VIhv4qjWnX5nh9G7I3qe5jqrU01sdWw60cEs94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nj0ErV9YWJwsnZC1nAbagW7U5GC6uljdCO49jdTWnQjEBIDnK+TcmLT8mKps8xs+L
	 s43TKbaU+t2cjcn/FkyJH91tPEO244We4/LuubAU2W3Qt1CTl1itiALH7+W0NCg0jd
	 mlPmbosYNJOJBqB1wFHnh2qT93HEkecRIw+dbqF65GwiVmqE44M0oWUuNlh0UnBZqZ
	 VkHetyLOvlznFKNoBelItJLkZFfB4C8t2KNPeQTG6bDo9oCc+qZsaCWyMiPDofp6uj
	 YmE7CdBQYOBS4aFscD3b6FXGPQQ44kCykq6hHbCpWeRsL/OxirUTcVmFmaj4wDkLGF
	 mEU1CFffbWIHw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VP13j3qj2z4wxx;
	Tue, 23 Apr 2024 22:03:29 +1000 (AEST)
Date: Tue, 23 Apr 2024 22:03:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Suren Baghdasaryan
 <surenb@google.com>
Subject: Re: linux-next: manual merge of the vhost tree with the mm tree
Message-ID: <20240423220317.01d65416@canb.auug.org.au>
In-Reply-To: <e07add5b-e772-4a8c-b71f-79f1fe74580a@redhat.com>
References: <20240423145947.142171f6@canb.auug.org.au>
	<e07add5b-e772-4a8c-b71f-79f1fe74580a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F=LLHuWQLYmMaKRwZGZ4m/P";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/F=LLHuWQLYmMaKRwZGZ4m/P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 23 Apr 2024 10:21:55 +0200 David Hildenbrand <david@redhat.com> wro=
te:
>
> Easy header conflict. @MST, @Andrew, do we simply want to take that
> virtio-mem patch via the MM tree to get rid of the conflict
> completely?

And because it is so trivial a conflict, you should just mention it to
Linus when you send the merge requests.

--=20
Cheers,
Stephen Rothwell

--Sig_/F=LLHuWQLYmMaKRwZGZ4m/P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYno4UACgkQAVBC80lX
0Gw69gf/XLART4dB3aN423dkAk+x5c9i17dlzZu5MoepPrVeq1GAD99uWEQuY1dF
5aSI/kORlQfom5RkSxsOCJGCAsbShJiadKA/TxsAH80cPzcj/h9AMB0kAc8dK9XZ
3Of9QVsds2jtdnXGvZrdxfV5jpRz0Whu3Wjk3Il7Cw/4qVMmpKnYb+g4rDmUWEZl
gnGukR/QLOjFvFwgjcX0+SUHVEJYl2kNKKE56DiaOWrNni9nLcWn/IjgMDS/wXbs
iUAyi1uTvydVfQItmkGBQ/0VrWLA6gOFjfTb7WJMEjvCCg+A8FiEvBmmb6zVemLq
IqEtsIAtJyS5ZdvE9fs8Su0gpJZPYw==
=4h11
-----END PGP SIGNATURE-----

--Sig_/F=LLHuWQLYmMaKRwZGZ4m/P--

