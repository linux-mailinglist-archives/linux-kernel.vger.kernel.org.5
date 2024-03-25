Return-Path: <linux-kernel+bounces-117928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F4888B16A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72430305B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651E351034;
	Mon, 25 Mar 2024 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCgGYaWC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4019339AC;
	Mon, 25 Mar 2024 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398671; cv=none; b=e7i8jkegHTdLQXAMyNaO12EyUNkaOgAf2TPOXrMMlavIa3Uo24X4OTYR7wxOAfhH4D7UAyCThJQ494At5il/xmTjyf42SE2u8Lv5ntIhnucO0ziNHQGD5EwbNYNFR4uF0Cv7x9AFeLH5Krdnca/RGHVUreXLAU4zhckJjGpZ0KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398671; c=relaxed/simple;
	bh=nD0S0HBjHRK4yrg36noMRJ6p5zTTPnr1zy2wYZ1vL+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eX2qguaKtmJiuLAoYCQkhT80sPFIn1q+7ffaiGurqp8bBo4JCAqEVXb87qMp3Nd2IObQLl+NmJ4WI/aBzOO44aM0FVSYnStHebnX9R8e7AyIG92PGFC09q2KlpK7n5v91sGLjKBQHF5F87LUSLlcPZjMtclJUnZenliWMlb6kK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCgGYaWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7DDC433C7;
	Mon, 25 Mar 2024 20:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711398671;
	bh=nD0S0HBjHRK4yrg36noMRJ6p5zTTPnr1zy2wYZ1vL+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SCgGYaWCWESKfwcXnv/GMus7WOS80RJzGQFjdD0a86l6riuGwhfZ8MgMv4ERjhrM/
	 M7R27wq88yxd7GpkzUVai+PHZ4FWpy0uuwfmLBmYXwciojwsd9G/A66lpAcM9NybWR
	 fCiMPYecDMzbvBThaZVZGhc3156X17MWF0CkVAVL9/nwgk6tFBv55VP+j/8cGiTDQo
	 jZmXnhis6fMdhmwLAo1MHErUeqidYOlOqRCxylDCR5Spyo6pQRVPo5ik8838uBWBro
	 fjYSucUy2KGQldTKfku64YUJXrFAvD5mOrdCZsZPFJaYS/uXlhgxZH5DOW05PbsTqM
	 Wt4TNHu0WkJrw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>, Conor Dooley <conor@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang
 <xi.wang@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Pu Lehui <pulehui@huaweicloud.com>, Manu
 Bretelle <chantra@meta.com>, Mykola Lysenko <mykolal@meta.com>, Nikolay
 Yurin <yurinnick@meta.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf,riscv: Implement
 bpf_addr_space_cast instruction
In-Reply-To: <CANk7y0jtURUC6PWx5nSDigMpScUT+p3qd=hTtqJkCqAN+Nq32A@mail.gmail.com>
References: <20240325155434.65589-1-puranjay12@gmail.com>
 <20240325155434.65589-3-puranjay12@gmail.com>
 <20240325-nineteen-unvaried-cb5cb5fd3a73@spud>
 <CANk7y0gWtwN7EJ24aoY9-RB9629d5Ks-9fMc3wnAAjjERcZhFw@mail.gmail.com>
 <20240325-perpetual-liking-25f26e485b65@spud>
 <CANk7y0jtURUC6PWx5nSDigMpScUT+p3qd=hTtqJkCqAN+Nq32A@mail.gmail.com>
Date: Mon, 25 Mar 2024 21:31:08 +0100
Message-ID: <878r263vg3.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay12@gmail.com> writes:

> Is there a separate CI for RISCV related stuff? is it public?
>
> I would be interested in adding RISC-V support in
> https://github.com/kernel-patches/bpf
> Is someone already working on this?

+Cc Manu/Mykola/Nico who's doing all of the awesome BPF CI work at Meta,
and can keep me honest. ;-)

I did some early hacks for to add RISC-V support for the BPF CI, but
haven't had time to work on it recently. :-(

  [1] https://github.com/libbpf/ci/pull/87
  [2] https://github.com/kernel-patches/vmtest/pull/194

I've been talking recently to Lehui about it as well.

Two major things are missing:

1. Cross-compilation support (expand on [1])
2. Align the rootfs with what the other arch are using, to run the tests
   on Qemu/TCG (and proper HW at some point!). RISC-V does not have
   Debian Stable support, and would probably need Ubuntu or Debian Sid
   snapshop. Manu outlines some issues here:
   https://github.com/libbpf/ci/pull/83

Having to manually run BPF tests ("non-official RISC-V BPF CI") is a
mess!


Bj=C3=B6rn

