Return-Path: <linux-kernel+bounces-25820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9422F82D654
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9131C2161E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B536E541;
	Mon, 15 Jan 2024 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ2lc/uZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D01D2F5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998F1C43390;
	Mon, 15 Jan 2024 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705312231;
	bh=eGRxQIF7PrJgEuijlpw7aixZyzO2hkfFM4iXxKd+Nz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZ2lc/uZT2SrNri4LKCvfWvQo3KwcuvbO89HWpQviq7Jga8wMoMuDOXFAfSJig4EV
	 TlSDRh98XRmAsRzDFkJ5QwvzIkD6vQp/lcE3zhxoProqQiqHmYGSLMKRTl8C2Iecep
	 6IaGSwbWhSxZasXJDHf4BZCpwZTuaY8qmoy4Ln7WjAo4RUxdjvOYp4TN2eZnLMY0Ta
	 XNkrf2qLOBQ2WabzA8k1FoLgQEav9Kh4S5gTGosNg3HArywfCL6T9LLXut57bzMVEH
	 woUeNFUpU0Ae8+MVTL8+h0Bbbeouu+HHXOFPkaBJegrvSzn4VMddlyBTo1w4AEhMe2
	 WFJU7LCes9V2A==
Date: Mon, 15 Jan 2024 17:37:41 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] riscv: enable lockless lockref implementation
Message-ID: <ZaT85b/FUDe9frUz@xhacker>
References: <20231202140323.315-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231202140323.315-1-jszhang@kernel.org>

On Sat, Dec 02, 2023 at 10:03:21PM +0800, Jisheng Zhang wrote:
> This series selects ARCH_USE_CMPXCHG_LOCKREF to enable the
> cmpxchg-based lockless lockref implementation for riscv. Then,
> implement arch_cmpxchg64_{relaxed|acquire|release}.
> 
> After patch1:
> Using Linus' test case[1] on TH1520 platform, I see a 11.2% improvement.
> On JH7110 platform, I see 12.0% improvement.
> 
> After patch2:
> on both TH1520 and JH7110 platforms, I didn't see obvious
> performance improvement with Linus' test case [1]. IMHO, this may
> be related with the fence and lr.d/sc.d hw implementations. In theory,
> lr/sc without fence could give performance improvement over lr/sc plus
> fence, so add the code here to leave performance improvement room on
> newer HW platforms.
> 
> Link: http://marc.info/?l=linux-fsdevel&m=137782380714721&w=4 [1]

Hi Palmer,

this series is also missed, let me know if there's something need to be
done.

Thanks
> 
> Since v1:
>   - only select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
> 
> Jisheng Zhang (2):
>   riscv: select ARCH_USE_CMPXCHG_LOCKREF
>   riscv: cmpxchg: implement arch_cmpxchg64_{relaxed|acquire|release}
> 
>  arch/riscv/Kconfig               |  1 +
>  arch/riscv/include/asm/cmpxchg.h | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> -- 
> 2.42.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

