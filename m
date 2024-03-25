Return-Path: <linux-kernel+bounces-117800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE3A88B42A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C273BE6927
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74F21773A;
	Mon, 25 Mar 2024 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXCND9aJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D11DDC3;
	Mon, 25 Mar 2024 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394369; cv=none; b=m7zjD17kjjWgVM1xW7aahL3A1xweGuMEH83vDGymjKj0kugHKPZhE8BEA/gakvuaouRB/STsLNy3toOO1JiU/iuIfLD4s5SMb4XSWm73e8OETCvRit6HgurtPdZN+dJuhCwoUSb1QBC8SUtb/WnoFHKH6g40CmGjJzTraRvMNq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394369; c=relaxed/simple;
	bh=6ur4nAJ4fwkwsjzeh2IAAOBPeg2ISaHYc8y9oEzYf0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzqsmWDjwHcOSE+42f0QpiKiNvozdP27EZzHGR2HTVYdKn5W32NC6TUQbOOaQM8/+IIE5xxkLThRmTFuZIBjqdWMDT6cDrSSShD+SDmOG9mrGULOYMc+ZGeJ05dTzETjSQtoUj6MxdqvRTX76UkhPKVMeX3AP+D+b2ztf6pt1/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXCND9aJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F160C433C7;
	Mon, 25 Mar 2024 19:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711394368;
	bh=6ur4nAJ4fwkwsjzeh2IAAOBPeg2ISaHYc8y9oEzYf0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sXCND9aJ3vGdPTUZkzw3cMJ5Z+8+y+sA3Uk5ODhmOoTed+Me48SbXmwHMI4vFE8q9
	 OiCwNyFZiIwGt211YsUirguF2WYHc0n7qVLfydSRisg1vsIENQmRU5sNeHlBkWg2X6
	 boT5bf8k5CSTQIQqX99uqvexvMmap6nQVi8qdsloo9afoa2C99WSfzQFRA7e7VON03
	 A5Jl1y6Q0BqnWGkJMbmGcJ99RzcFbojNzykJ6tf2KBnlQ2eWBcAGNe79laPQ7mdX3S
	 nr1V/mKPBZXumk7K4SPNyLpXm33p3Fbe6QtngW7xfbEy8vLqzRtzUMY+9rPVX24GD0
	 u6MCVVp5Qqfag==
Date: Mon, 25 Mar 2024 19:19:22 +0000
From: Conor Dooley <conor@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf,riscv: Implement bpf_addr_space_cast
 instruction
Message-ID: <20240325-perpetual-liking-25f26e485b65@spud>
References: <20240325155434.65589-1-puranjay12@gmail.com>
 <20240325155434.65589-3-puranjay12@gmail.com>
 <20240325-nineteen-unvaried-cb5cb5fd3a73@spud>
 <CANk7y0gWtwN7EJ24aoY9-RB9629d5Ks-9fMc3wnAAjjERcZhFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PLxoKXZPHO6ffd6M"
Content-Disposition: inline
In-Reply-To: <CANk7y0gWtwN7EJ24aoY9-RB9629d5Ks-9fMc3wnAAjjERcZhFw@mail.gmail.com>


--PLxoKXZPHO6ffd6M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 08:13:10PM +0100, Puranjay Mohan wrote:
> On Mon, Mar 25, 2024 at 8:10=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Mon, Mar 25, 2024 at 03:54:34PM +0000, Puranjay Mohan wrote:
> > > LLVM generates bpf_addr_space_cast instruction while translating
> > > pointers between native (zero) address space and
> > > __attribute__((address_space(N))). The addr_space=3D0 is reserved as
> > > bpf_arena address space.
> > >
> > > rY =3D addr_space_cast(rX, 0, 1) is processed by the verifier and
> > > converted to normal 32-bit move: wX =3D wY
> > >
> > > rY =3D addr_space_cast(rX, 1, 0) has to be converted by JIT.
> > >
> > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> >
> > Doesn't compile for allmodconfig:
> >   ../arch/riscv/net/bpf_jit_comp64.c:1086:7: error: call to undeclared =
function 'insn_is_cast_user'; ISO C99 and later do not support implicit fun=
ction declarations [-Wimplicit-function-declaration]
> >
> > Cheers,
> > Conor.
>=20
> Yes,
> I mentioned in the cover letter that a patch is required.
> It just got merged in bpf-next/master:
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?=
id=3D770546ae9f4c1ae1ebcaf0874f0dd9631d77ec97
>=20
> So, rebasing on the latest bpf-next/master should fix the issue.

Ah, I see now that there was a mention in the cover letter that I did
not see first time around.

Bjorn, do you think there's anything we can do about these kinda
misleading CI failures for bpf stuff? Some stuff that touches bpf
definitely is worth us building, but should we try and build it on top
of the bpf tree instead?

--PLxoKXZPHO6ffd6M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgHOOgAKCRB4tDGHoIJi
0t9oAQClrCCsg/y60Dzf2CGlzqqLxZlv5uLEMxOHA+AgGxIQiAD/bo+9Ay8m4QJy
igs4VljEQzP535ZsiOlBcFy7XOh6nAc=
=InP6
-----END PGP SIGNATURE-----

--PLxoKXZPHO6ffd6M--

