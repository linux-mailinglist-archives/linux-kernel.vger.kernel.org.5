Return-Path: <linux-kernel+bounces-117833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F9088B03B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C45B3201BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7004085A;
	Mon, 25 Mar 2024 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaOY5sQX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3307224DB;
	Mon, 25 Mar 2024 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395612; cv=none; b=HgSQapPtAN05a/Bx/X+iJ7EJALQXjqNLkhGsUfwvZAPVI5oRmVLcJUWJPRBpup5xsog1mOjZ7GIpQx8hcOHfjnP1x6JBAh6Y5ASfF9icV7RHCo3XDme9PyMxnGl+20WOIB16wv87uMUS4R1fnBJD6HP6tAhQ7jE7NnnAyKdX1Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395612; c=relaxed/simple;
	bh=g659JFfs5AjSVYM1zIakNFUS3zlJBueU+/TZUE+qaBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1sfTF+ZkBCFrrhmFzsOczEDiw/doJKrVyxZJpISPeUT/0+wxcQO5ke5XemVOfV/2qcKhXzUUlutmdcbCjScXJHpPEpBtG0yk5CssPgQwyH0eAgfuGKTTDXJyzy2w6HHyTtWNXigMw0nc9/k6Q6/oYFn+3oWHB6HOcsrS41wmac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaOY5sQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24BBC433C7;
	Mon, 25 Mar 2024 19:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711395612;
	bh=g659JFfs5AjSVYM1zIakNFUS3zlJBueU+/TZUE+qaBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gaOY5sQX73xGJ1WwJdYEk9DzGrGd4x/nYC1/t4EYJ/STpKzpCksYM/pu8XPqFaHMG
	 X9luV4z5WbBHm0t9j/jSRQlGL0oxs7b0+v0pm5pDTNdHg9AzTsco1Tc5/dKP+LoiUk
	 nBjKbARri3NJm/sqdxCZwILmkeGpo+GKpSBmHX0LuWiF8QqnCL2rhEUenl6pdcjPt+
	 cFbkekoZ4bwMugXMO+Ou4F/r7WEefbp5iM6+tNxGWV1DbOAtkQxJ60rbLu22Fxs7WR
	 r69Gx4tdOEMFLGSaL6UApteTt2w0irHgqXZhX167LzUgYhysZoHonbKJkWAGRQQ/bn
	 4DZdBXR+atfBw==
Date: Mon, 25 Mar 2024 19:40:05 +0000
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
Message-ID: <20240325-creamed-unlovely-4c80082e9b8c@spud>
References: <20240325155434.65589-1-puranjay12@gmail.com>
 <20240325155434.65589-3-puranjay12@gmail.com>
 <20240325-nineteen-unvaried-cb5cb5fd3a73@spud>
 <CANk7y0gWtwN7EJ24aoY9-RB9629d5Ks-9fMc3wnAAjjERcZhFw@mail.gmail.com>
 <20240325-perpetual-liking-25f26e485b65@spud>
 <CANk7y0jtURUC6PWx5nSDigMpScUT+p3qd=hTtqJkCqAN+Nq32A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f9ssCXyqoxZRmlTY"
Content-Disposition: inline
In-Reply-To: <CANk7y0jtURUC6PWx5nSDigMpScUT+p3qd=hTtqJkCqAN+Nq32A@mail.gmail.com>


--f9ssCXyqoxZRmlTY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 08:23:18PM +0100, Puranjay Mohan wrote:
> On Mon, Mar 25, 2024 at 8:19=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Mon, Mar 25, 2024 at 08:13:10PM +0100, Puranjay Mohan wrote:
> > > On Mon, Mar 25, 2024 at 8:10=E2=80=AFPM Conor Dooley <conor@kernel.or=
g> wrote:
> > > >
> > > > On Mon, Mar 25, 2024 at 03:54:34PM +0000, Puranjay Mohan wrote:
> > > > > LLVM generates bpf_addr_space_cast instruction while translating
> > > > > pointers between native (zero) address space and
> > > > > __attribute__((address_space(N))). The addr_space=3D0 is reserved=
 as
> > > > > bpf_arena address space.
> > > > >
> > > > > rY =3D addr_space_cast(rX, 0, 1) is processed by the verifier and
> > > > > converted to normal 32-bit move: wX =3D wY
> > > > >
> > > > > rY =3D addr_space_cast(rX, 1, 0) has to be converted by JIT.
> > > > >
> > > > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > > >
> > > > Doesn't compile for allmodconfig:
> > > >   ../arch/riscv/net/bpf_jit_comp64.c:1086:7: error: call to undecla=
red function 'insn_is_cast_user'; ISO C99 and later do not support implicit=
 function declarations [-Wimplicit-function-declaration]
> > > >
> > > > Cheers,
> > > > Conor.
> > >
> > > Yes,
> > > I mentioned in the cover letter that a patch is required.
> > > It just got merged in bpf-next/master:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/comm=
it/?id=3D770546ae9f4c1ae1ebcaf0874f0dd9631d77ec97
> > >
> > > So, rebasing on the latest bpf-next/master should fix the issue.
> >
> > Ah, I see now that there was a mention in the cover letter that I did
> > not see first time around.
> >
> > Bjorn, do you think there's anything we can do about these kinda
> > misleading CI failures for bpf stuff? Some stuff that touches bpf
> > definitely is worth us building, but should we try and build it on top
> > of the bpf tree instead?
>=20
> Is there a separate CI for RISCV related stuff? is it public?

It's based outta patchwork, just like the netdev/bpf stuff:
https://patchwork.kernel.org/project/linux-riscv/list/

> I would be interested in adding RISC-V support in
> https://github.com/kernel-patches/bpf
> Is someone already working on this?

If anyone is, it is probably something Bjorn knows about!

--f9ssCXyqoxZRmlTY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgHTFQAKCRB4tDGHoIJi
0kRtAP9o7BqT/u++er+Bnqqvg6xK9tBATuUjDpdT+rOwJ1PesgEAh1ycTqG5uqxR
xFOf+YAsdnGI0ZmRxmxH+/5isoHdjwg=
=shXF
-----END PGP SIGNATURE-----

--f9ssCXyqoxZRmlTY--

