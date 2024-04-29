Return-Path: <linux-kernel+bounces-162325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FCA8B59BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7309EB2D0CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E08B6FE0D;
	Mon, 29 Apr 2024 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiH1TfTw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B22C157;
	Mon, 29 Apr 2024 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396003; cv=none; b=Eo1uWLoOpjC4mgscsazFb5IY2OHYXemWdi6FnaiYuds9cCrY9ci99y8PBcRv7K1PC67aOWLSSZ8e8B+lLkNYZVXwfJxdJv9AH9FtkF1I7opAZXxAzn9m5m0QW0jBt6AGS04aiQMZ9o3jJ+jJhGY5Xil3rPoNZn4Fl8u7iwP2/8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396003; c=relaxed/simple;
	bh=rZ8Z2pUcpPP3Q2H18yeuPh2A8Fkeenaxddz/S6gwAFM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sh2DaDxGWl1JtgKAtA5R2w0zvbUL8H40cXj+5VJyVOGMvsYhGyU/MjfX5+cAk7fRp7LqqkoMaH8eYdv7K+tQll8+sfbXlfXNIGtZzj1QYTlab+QhMGYuXWOYdE29AYop9bK5fWmmOMie1LvztWYt9ot/8t6NIrm8qmJtqHM9vE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiH1TfTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF56C113CD;
	Mon, 29 Apr 2024 13:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714396003;
	bh=rZ8Z2pUcpPP3Q2H18yeuPh2A8Fkeenaxddz/S6gwAFM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ZiH1TfTwjL1ui8iuu+JRSBlEsR7ExhktYPKOFOwNrqB4LuN7L3rYAYwm897fOmZXV
	 hWjbBVN+GM9oyyv9Ohf9UjM1JAVtYdp7X392I3p9NkOh5haxxUx08ASdYOgxKc0/8k
	 YAjFJAls6nOMnmn58JtTLDXBJcnBotEkI3TqYgG5OHYRxIryK8iohfn0TiammN7x6J
	 Fp5MDJLbxlkp1Yr5SjoJoIDTYKn2DYRgXR49FulNasegGJ8YnTvGs+8ibxU/dGvCw6
	 B7EGz2llTZ0dnkzFXJrY8QGKizSV6C4JO0TGKlyF38BNOkf5G+zjieZmQ98ljvIlC8
	 +f3G5wa34tXfg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Apr 2024 16:06:39 +0300
Message-Id: <D0WMNTCRUN00.TQHC8O6X6WI2@kernel.org>
Cc: <mona.vij@intel.com>, <kailun.qin@intel.com>
Subject: Re: [PATCH 0/2] x86/sgx: Fix two data races in EAUG/EREMOVE flows
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Dmitrii Kuvaiskii" <dmitrii.kuvaiskii@intel.com>,
 <dave.hansen@linux.intel.com>, <kai.huang@intel.com>,
 <haitao.huang@linux.intel.com>, <reinette.chatre@intel.com>,
 <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240429104330.3636113-1-dmitrii.kuvaiskii@intel.com>
In-Reply-To: <20240429104330.3636113-1-dmitrii.kuvaiskii@intel.com>

On Mon Apr 29, 2024 at 1:43 PM EEST, Dmitrii Kuvaiskii wrote:
> SGX runtimes such as Gramine may implement EDMM-based lazy allocation of
> enclave pages and may support MADV_DONTNEED semantics [1]. The former
> implies #PF-based page allocation, and the latter implies the usage of
> SGX_IOC_ENCLAVE_REMOVE_PAGES ioctl.
>
> A trivial program like below (run under Gramine and with EDMM enabled)
> stresses these two flows in the SGX driver and hangs:
>
> /* repeatedly touch different enclave pages at random and mix with
>  * `madvise(MADV_DONTNEED)` to stress EAUG/EREMOVE flows */
> static void* thread_func(void* arg) {
>     size_t num_pages =3D 0xA000 / page_size;
>     for (int i =3D 0; i < 5000; i++) {
>         size_t page =3D get_random_ulong() % num_pages;
>         char data =3D READ_ONCE(((char*)arg)[page * page_size]);
>
>         page =3D get_random_ulong() % num_pages;
>         madvise(arg + page * page_size, page_size, MADV_DONTNEED);
>     }
> }
>
> addr =3D mmap(NULL, 0xA000, PROT_READ | PROT_WRITE, MAP_ANONYMOUS, -1, 0)=
;
> pthread_t threads[16];
> for (int i =3D 0; i < 16; i++)
>     pthread_create(&threads[i], NULL, thread_func, addr);

I'm not convinced that kernel is the problem here but it could be also
how Gramine is implemented.

So maybe you could make a better case of that. The example looks a bit
artificial to me.

>
> This program uncovers two data races in the SGX driver. The remaining
> patches describe and fix these races.
>
> I performed several stress tests to verify that there are no other data
> races (at least with the test program above):
>
> - On Icelake server with 128GB of PRMRR (EPC), without madvise(). This
>   stresses the first data race. A Gramine SGX test suite running in the
>   background for additional stressing. Result: 1,000 runs without hangs
>   (result without the first bug fix: hangs every time).
> - On Icelake server with 128GB of PRMRR (EPC), with madvise(). This
>   stresses the second data race. A Gramine SGX test suite running in the
>   background for additional stressing. Result: 1,000 runs without hangs
>   (result with the first bug fix but without the second bug fix: hangs
>   approx. once in 50 runs).
> - On Icelake server with 4GB of PRMRR (EPC), with madvise(). This
>   additionally stresses the enclave page swapping flows. Two Gramine SGX
>   test suites running in the background for additional stressing of
>   swapping (I observe 100% CPU utilization from ksgxd which confirms that
>   swapping happens). Result: 1,000 runs without hangs.
>
> (Sorry for the previous copy of this email, accidentally sent to
> stable@vger.kernel.org. Failed to use `--suppress-cc` during a test send.=
)
>
> Dmitrii Kuvaiskii (2):
>   x86/sgx: Resolve EAUG race where losing thread returns SIGBUS
>   x86/sgx: Resolve EREMOVE page vs EAUG page data race
>
>  arch/x86/kernel/cpu/sgx/encl.c  | 10 +++++++---
>  arch/x86/kernel/cpu/sgx/encl.h  |  3 +++
>  arch/x86/kernel/cpu/sgx/ioctl.c |  1 +
>  3 files changed, 11 insertions(+), 3 deletions(-)

BR, Jarkko

