Return-Path: <linux-kernel+bounces-117914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F7488B131
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7191C61544
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8910245026;
	Mon, 25 Mar 2024 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bum2rFsu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8BEFC01;
	Mon, 25 Mar 2024 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397973; cv=none; b=pCDUpTvV/Z//bc0ku419teFgeh4YD1jNgaMLvfdOzSAFmt5+QuqSOcOJ2AnKbKeaqgq1drGxglWsYScuGucQCSr0mvSPg6GMtAqFN/hcRgwNHWGrsPnIxsqIK+ytmLXcJCq9FRYheKZficQHYUbj/9lrBdcCtAW19KjaehhFF7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397973; c=relaxed/simple;
	bh=jHzWHipH1FUjrW3QmoX2gyQBJf9dn+dr+EwQqJeJ2Gc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VMMdW+7n8qQRF5QoHz/Midbc1Xe/Z9FOveAJ76FEEt1Q8WjaQ6U8eu4mE7gqFL/5y3uigRAC/0XGYe43ruVhprY3MzdOd5CQMbVS2aH28kUdsxlYUCwbKbkatqmViJuNc+h2bcFPPxL/cUkPnjILMztzR6yv6o0o/YLaz4Lku8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bum2rFsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC190C433F1;
	Mon, 25 Mar 2024 20:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711397972;
	bh=jHzWHipH1FUjrW3QmoX2gyQBJf9dn+dr+EwQqJeJ2Gc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Bum2rFsu+JPbqMUpVZ1X5guR1xNpEttm8Bi0nI3fr55l93tXuus0BNLJLeKq6cFCd
	 caP7tYJXuxFtGlATVhMJ9W+JnBCc26LRFiqW8uAAJSUEmA+9jnmCwbcqaG45Y4E0/h
	 Vw2l8X+A14Yy2ImoX1HWxBHe0aObKGkgdI9of6Ojoq7Nfi/UwJMsFbwvLPT4aWoL1Z
	 eI26NO5jq5IGego/V4W6BppAreU9bQumYwzFBHyBd4z6RQIGRd0f/+RqOYNngXfZWz
	 xmU/KgNGbaNCTCVMYdVBIybqSj4/QaJ6gVsqqYBxP7pbOEUlzBc2ay/67VzrEF2O8o
	 YlSi505dIgR3Q==
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
In-Reply-To: <20240325-creamed-unlovely-4c80082e9b8c@spud>
References: <20240325155434.65589-1-puranjay12@gmail.com>
 <20240325155434.65589-3-puranjay12@gmail.com>
 <20240325-nineteen-unvaried-cb5cb5fd3a73@spud>
 <CANk7y0gWtwN7EJ24aoY9-RB9629d5Ks-9fMc3wnAAjjERcZhFw@mail.gmail.com>
 <20240325-perpetual-liking-25f26e485b65@spud>
 <CANk7y0jtURUC6PWx5nSDigMpScUT+p3qd=hTtqJkCqAN+Nq32A@mail.gmail.com>
 <20240325-creamed-unlovely-4c80082e9b8c@spud>
Date: Mon, 25 Mar 2024 21:19:29 +0100
Message-ID: <87edby3vzi.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Conor Dooley <conor@kernel.org> writes:

>> Is there a separate CI for RISCV related stuff? is it public?
>
> It's based outta patchwork, just like the netdev/bpf stuff:
> https://patchwork.kernel.org/project/linux-riscv/list/

*salesman mode on*

..and more information on the CI (and source!) can be found here:

  https://github.com/linux-riscv/github-ci/wiki
  https://wiki.riseproject.dev/display/HOME/PoC+Github+Runners+on+GKE

Improvements are very much welcome. It's pretty much only Conor and me
doing best effort hacking on the CI.


Bj=C3=B6rn

