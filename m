Return-Path: <linux-kernel+bounces-10591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFFA81D6AE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 23:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C762F283033
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 22:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F48179A1;
	Sat, 23 Dec 2023 22:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmpsLpec"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8988F171A7
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 22:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CABAC433C8;
	Sat, 23 Dec 2023 22:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703369133;
	bh=tQ9mHBh0idipynQKJvhuVlCANWRLkmPWhm22rqwDcbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmpsLpecULGXLZZ38UqHJnck/LFawAwRsWD3i92NblJzrG0z0yMfO5dr/kQ0XBBrd
	 OMIYGAbEhitkfMRNov17nF6oeRm11rEviYP9kr3I08F7ZOFU/X9XVtzxsyqpoNKLTQ
	 I6aXxwA4NPkZP/lfUvNNEIzVIYqCiH1jV8EuYGhDuH/ic0G/jlbXHw1zn0CdhppCFb
	 j+t15ZqbQsPVJpTc3kBoulatIv5aPwjtBLU7Hz5p3qnm1441iYl7O+WNkNPFp93ixZ
	 QE/3sWZIfGEoEv7rmP23Qpcuh3BIRJSpBt+HwnxLB1I353MSxSwtUkeUu17MFsZEpv
	 m1GvTOLyyXpcQ==
Date: Sat, 23 Dec 2023 16:05:27 -0600
From: Eric Biggers <ebiggers@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Qingfang DENG <dqfext@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH v3 1/2] riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
Message-ID: <20231223220527.GA19298@quark.localdomain>
References: <20231223155226.4050-1-jszhang@kernel.org>
 <20231223155226.4050-2-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223155226.4050-2-jszhang@kernel.org>

On Sat, Dec 23, 2023 at 11:52:25PM +0800, Jisheng Zhang wrote:
> +config RISCV_EFFICIENT_UNALIGNED_ACCESS
> +	bool "Use unaligned access for some functions"

How about:

	bool "Assume the CPU supports fast unaligned memory accesses"

> +	depends on NONPORTABLE
> +	select HAVE_EFFICIENT_UNALIGNED_ACCESS
> +	default n

There's no need to explicitly list "default n", since n is already the default.

> +	help
> +	  Say Y here if you want the kernel only run on hardware platforms which
> +	  support efficient unaligned access, then unaligned access will be used
> +	  in some functions for optimized performance.

How about:

	  Say Y here if you want the kernel to assume that the CPU supports
	  efficient unaligned memory accesses.  When enabled, this option
	  improves the performance of the kernel on such CPUs.  However, the
	  kernel will run much more slowly, or will not be able to run at all,
	  on CPUs that do not support efficient unaligned memory accesses.

- Eric

