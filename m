Return-Path: <linux-kernel+bounces-117910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B430C88B35C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A902B44C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4390C58109;
	Mon, 25 Mar 2024 20:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cuh01lJp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0605812B;
	Mon, 25 Mar 2024 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397739; cv=none; b=ewUyWjTkwOyDZumYfhzUK74FZGrxL6Z3gEmFaGVoRixsZsR6Hh7uy4oDR2sNJhTg/NjHrn99GJ/if0+BnT3vKADB3IyrM7KWqwglIKfIx9lu1Ls5UsRiT9IF83d3Ch/71We4uQE/SaGQoIzxAyyKQrOk/IcEnFndgTUN4TVcrgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397739; c=relaxed/simple;
	bh=VnLILID+B4AMhTkZ41ybygjTq3wYwO3V7O/AXYomsuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p1OfoWJTO7zaw1mxvRLFReQ7DyZvMD1iMG5V25HBiL4ws6JryV2F/TOqYjKDdD4gNTdJUYzzhYwEXcwheCwl/wS8qYxUNCzMX1Nf04H5B+8G8zvGmHDgtreq/fGUunien6sE6KnxvVMZTdEHT4KlBwNfDqeEerGcHAknwEzwRdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cuh01lJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB76C433F1;
	Mon, 25 Mar 2024 20:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711397738;
	bh=VnLILID+B4AMhTkZ41ybygjTq3wYwO3V7O/AXYomsuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Cuh01lJp5vogSObIBpycMUzfX0whg8W2LHhV+rxvsyYYcy4Hn3vZH4GKGoaTSj6as
	 Ho9/uJJWQrZdOFyqv55geuMINcPN7mIrNVAReXXbHMKvCMZ72FAu/9z4yvE+OYz+i/
	 BOneQVelLQBCjs+4udPyGAb4w8zY8B1OAENKvSZ5qBCpFU25bbkoCvETuayzuj/YZW
	 GRx7gPPvhXJ1iCoiLPbKBqxG+wqNBEhF91cg4SJOStJkwOI4DhMPBC7IZwJosz7zwA
	 ywXg1UeD4cFpwxdmAfsPchSbxwRMO6zIvJbyzsf1UhNThOtbQQLaPtWWquNY/FVU+l
	 f+TYNDP8cHECg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Conor Dooley <conor@kernel.org>, Puranjay Mohan <puranjay12@gmail.com>
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
 linux-kernel@vger.kernel.org, Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf,riscv: Implement
 bpf_addr_space_cast instruction
In-Reply-To: <20240325-perpetual-liking-25f26e485b65@spud>
References: <20240325155434.65589-1-puranjay12@gmail.com>
 <20240325155434.65589-3-puranjay12@gmail.com>
 <20240325-nineteen-unvaried-cb5cb5fd3a73@spud>
 <CANk7y0gWtwN7EJ24aoY9-RB9629d5Ks-9fMc3wnAAjjERcZhFw@mail.gmail.com>
 <20240325-perpetual-liking-25f26e485b65@spud>
Date: Mon, 25 Mar 2024 21:15:35 +0100
Message-ID: <87il1a3w60.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Conor Dooley <conor@kernel.org> writes:

> Bjorn, do you think there's anything we can do about these kinda
> misleading CI failures for bpf stuff? Some stuff that touches bpf
> definitely is worth us building, but should we try and build it on top
> of the bpf tree instead?

IMO: The way to go is enabling RV support in the BPF CI (I'll expand on
this in Puranjay's later mail), and ignore BPF series for the RV
patchwork CI. I think having multiple trees in the RV CI is not worth
the pain...

Sort of related is that I think it could be worthwhile only building
series that had some human interaction (a pair of eyes -- "yes, this
does make sense to build"). Right now we're just building everything,
and we have to pay (money *and* time) for it.

..and then the BPF series would e.g. not be built at the RV PW CI.


(But mostly me thinking out loud! ;-))
Bj=C3=B6rn

