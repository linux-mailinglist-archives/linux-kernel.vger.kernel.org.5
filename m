Return-Path: <linux-kernel+bounces-117774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B80288AF75
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FFE2E672E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7631D11CAF;
	Mon, 25 Mar 2024 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTqfAjRA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250AFC0B;
	Mon, 25 Mar 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393840; cv=none; b=r2k1po2tmJ843B4fbMmt86/QlP2Qyp0t0CXrzG+THSDxfHhfWBf8ED8iFbldxCpnSl+xJWqo726+UQMhXLprwTLVwN0p/ksg0bnoGswaV03OPU16Wf2DUb4XEBje4Xo/5tWz+/CgibdzHNBf/8UuvRssQccfUDyDHbaL6ipGa+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393840; c=relaxed/simple;
	bh=YM908c+j5fTB0+d8tviHlAjBkwLbRaCWKwimpN6KDuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imZdyz7cWW6SLovvt5at75IsGk7WonsUTCYD4zhlrQSKLgq9/nn6hXFZLmVo0Bvs//9q2ieSEfEYziiK5U73+Vmt3EwOV0cIBsvCXagIfGm+s+lDlf4iTUelWGvERV186le8WDrWvhKBiRrCfwXnO7wGooRIjZWkxqlal7MkY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTqfAjRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B6AC433C7;
	Mon, 25 Mar 2024 19:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711393840;
	bh=YM908c+j5fTB0+d8tviHlAjBkwLbRaCWKwimpN6KDuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTqfAjRA00stt7hYeZ5sCjX5qkPjrMqAXOXztdxABRY1gZpyvo+FHTcTXgICgk7uB
	 3sydLdwkOWIa+HbviwUTgMhry2H1+ktxDgLE1Ao+ap00TsgprTfp2R6zhP1MBL5hIW
	 ln5naleeG6L4zUc8mdmgfp50zzgF0DR+yJ3xcW/Fg13+OGyhgOInbf1e8ZI4YwLtMW
	 QyTLmEI0N2g9uZfiXE5RTSsNQKbv4uWLdS6QrTEqlcJaqzZeDkz1wlDukTaNlkF4hS
	 ZaaMNesACzyZyxEouqRtMzSh2nAKUB6YyAYmydAWR4itmNRbOdf7C57uUF0ia/Ue5T
	 +UGg/ucn825vQ==
Date: Mon, 25 Mar 2024 19:10:33 +0000
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
Message-ID: <20240325-nineteen-unvaried-cb5cb5fd3a73@spud>
References: <20240325155434.65589-1-puranjay12@gmail.com>
 <20240325155434.65589-3-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="71chSDPH9+bsHkEY"
Content-Disposition: inline
In-Reply-To: <20240325155434.65589-3-puranjay12@gmail.com>


--71chSDPH9+bsHkEY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 03:54:34PM +0000, Puranjay Mohan wrote:
> LLVM generates bpf_addr_space_cast instruction while translating
> pointers between native (zero) address space and
> __attribute__((address_space(N))). The addr_space=3D0 is reserved as
> bpf_arena address space.
>=20
> rY =3D addr_space_cast(rX, 0, 1) is processed by the verifier and
> converted to normal 32-bit move: wX =3D wY
>=20
> rY =3D addr_space_cast(rX, 1, 0) has to be converted by JIT.
>=20
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Doesn't compile for allmodconfig:
  ../arch/riscv/net/bpf_jit_comp64.c:1086:7: error: call to undeclared func=
tion 'insn_is_cast_user'; ISO C99 and later do not support implicit functio=
n declarations [-Wimplicit-function-declaration]

Cheers,
Conor.

--71chSDPH9+bsHkEY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgHMKQAKCRB4tDGHoIJi
0pNmAQDHYFRpN53l7wvgU0xtapilGEKe+kTzj3USSRCYuZ7l/wD+KKyZpPzhsx8y
1uaOjd8prQZDz9yE3MkMa+iuSm8fegU=
=yW/s
-----END PGP SIGNATURE-----

--71chSDPH9+bsHkEY--

