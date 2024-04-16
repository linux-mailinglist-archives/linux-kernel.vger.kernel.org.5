Return-Path: <linux-kernel+bounces-147497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E75C38A753E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF58B21C56
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E901413A25C;
	Tue, 16 Apr 2024 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cjZZt45z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277DA139CF1;
	Tue, 16 Apr 2024 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713298282; cv=none; b=DCoYbKtAZVqBzIDP7Y9L2xxicnZa6HGwTkeL3XE5KN/WGG8QruygtiW8/v3jGke/Tx5vvCJ+B0a9xPawdvRKAqJXSoK1V8xgiX0ez9hjSQiuffrTFCyszTwlOVFSCR6pdhKB2B4u3eD8DcZGrzBnYULeECCIRR6hntMPvd5cJSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713298282; c=relaxed/simple;
	bh=vH93qz9QypmdrxTbfPnlMTMImwmxiAcyrlntd9a+0o0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kHZC+5zvB06zsEs82cwQvPNlI8+jYOHSzFYdHuofK0mt/yeHjN4J/VytGx6HW6N1S5UB1/c4pOptt+7RMFsAbEEoT5iObyUUhNzBfsOcMipkWngs+5EIACuRriV47WZCvRKoFYEOP0AdHo0xHVQ9yu9hiks2i1egSntkYj96u1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cjZZt45z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947A5C3277B;
	Tue, 16 Apr 2024 20:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713298281;
	bh=vH93qz9QypmdrxTbfPnlMTMImwmxiAcyrlntd9a+0o0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cjZZt45zzFNVvRVLLkIaQ69+5t4zoCNBaDZANtTYyKIzGiPWX0wB/I6nLAB1CxgDP
	 LyDiexeqmuMVOpNvYwYTEYfDw/QqbKIpHEnEylNsfU0Nr6S5UXmnG60k+iAegOG4s6
	 wUvuXfyB5LNQoRUHmF5B7VHXvfaARZL14SvNsgdE=
Date: Tue, 16 Apr 2024 13:11:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Maxwell Bland <mbland@motorola.com>
Cc: linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Ard
 Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Yu Chien Peter Lin
 <peterlin@andestech.com>, Song Shuai <suagrfillet@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH 5/5] ptdump: add state parameter for non-leaf callback
Message-Id: <20240416131120.a801ff03a6d0bbec0e9151c8@linux-foundation.org>
In-Reply-To: <20240416122254.868007168-6-mbland@motorola.com>
References: <20240416122254.868007168-1-mbland@motorola.com>
	<20240416122254.868007168-6-mbland@motorola.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 14:51:32 -0500 Maxwell Bland <mbland@motorola.com> wrote:

> ptdump can now note non-leaf descriptor entries, a useful addition for
> debugging table descriptor permissions when working on related code
> 
> Signed-off-by: Maxwell Bland <mbland@motorola.com>
> ---
>  arch/arm64/mm/ptdump.c          |  6 ++++--
>  arch/powerpc/mm/ptdump/ptdump.c |  2 ++
>  arch/riscv/mm/ptdump.c          |  6 ++++--
>  arch/s390/mm/dump_pagetables.c  |  6 ++++--
>  arch/x86/mm/dump_pagetables.c   |  3 ++-
>  include/linux/ptdump.h          |  1 +
>  mm/ptdump.c                     | 13 +++++++++++++
>  7 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index 796231a4fd63..1a6f4a3513e5 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -299,7 +299,8 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
>  			.range = (struct ptdump_range[]){
>  				{info->base_addr, end},
>  				{0, 0}
> -			}
> +			},
> +			.note_non_leaf = false
>  		}

It would be acceptable to omit all of these and rely upon the runtime
zeroing which the compiler will emit.

Documentation/arch/arm64/ptdump.rst might need updating.

Please include sample output in the changelog so we can better
understand the user's view of this change.


