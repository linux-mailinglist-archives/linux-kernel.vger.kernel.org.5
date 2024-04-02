Return-Path: <linux-kernel+bounces-128629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D05895D3A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E581F24DA2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34CF15CD56;
	Tue,  2 Apr 2024 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWuILH3a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE51515B0E8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088194; cv=none; b=JqCiHdkzdootXJEaDL6Be3toMv9GvtZA9w5GchV/Lq+L0UqMHAZBDjuTkH1LDTnl5IFBS7r4Txy3Rrjh0Tsg+CryYkuB/SjGodrMgl1cTq2m0RO6BkUBiE/kp8Us6L2N8pQ5V0jq77pjEmaa3QM1bogj/7lzeZ8wRCO5LcXvQW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088194; c=relaxed/simple;
	bh=H8PVhVb6CYsoWQXlADyDecxVg2x6hB4fYQ/3d9hMkuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mygqzz/ZcJTgXxq5Z6gjZA5s3qTUze4VNdaWllbsFFrVZIcoPwKKmSV1TuEDQPPKgFa5bkfLJ0RUd6/oAvlO8z4i5HhBN+4LymX++rljUVyy9Nbcr0smvuRSEU3Bc8gbMjOnTiektFJtEXEjicMwZNaVGgZCve5a5jY0G1jguj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWuILH3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932EBC433F1;
	Tue,  2 Apr 2024 20:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712088193;
	bh=H8PVhVb6CYsoWQXlADyDecxVg2x6hB4fYQ/3d9hMkuA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LWuILH3aXMIcYXceJrc/FgrFBYuN5GKmh6SA4aoQ8f/sQo5moe6djHq5qRqxLo2Qt
	 VHu49cyDOI/0BcmrxDXWGv+cHq7wl01jYSSXhghACfxwiwwyjaeuiB9BR4sS+ckzmx
	 RbrlCo8D6nfFMJ+klXtsdCXWOQ6yYyI0Wy/jJVVydOkb5NoBowTdt5GQHtswqe3cle
	 82/gswHy/SRFR6yYAEp8AIUdO1zvHRSFixB/sGYAPq+dan/2jWOwN9fasCuo7fhUkR
	 ZKDK/R9es4FA8HNBnXI3U/QXp9c2Ot1v5fPFpCAxMBWokVeTvVjSnnywiv/49BgQ36
	 +DeTN+/EZFpgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4F59ECE0FF2; Tue,  2 Apr 2024 13:03:13 -0700 (PDT)
Date: Tue, 2 Apr 2024 13:03:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH 1/8] sparc32: make __cmpxchg_u32() return u32
Message-ID: <85837f16-903c-44cd-8277-377e0228eb61@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240402041138.GF538574@ZenIV>
 <20240402042835.11815-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402042835.11815-1-viro@zeniv.linux.org.uk>

On Tue, Apr 02, 2024 at 12:28:28AM -0400, Al Viro wrote:
> Conversion between u32 and unsigned long is tautological there,
> and the only use of return value is to return it from
> __cmpxchg() (which return unsigned long).
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

I have pulled these in as replacements for my patches in the meantime.

Thank you!

							Thanx, Paul

> ---
>  arch/sparc/include/asm/cmpxchg_32.h | 2 +-
>  arch/sparc/lib/atomic32.c           | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
> index d0af82c240b7..112bfaa28729 100644
> --- a/arch/sparc/include/asm/cmpxchg_32.h
> +++ b/arch/sparc/include/asm/cmpxchg_32.h
> @@ -39,7 +39,7 @@ static __always_inline unsigned long __arch_xchg(unsigned long x, __volatile__ v
>  /* bug catcher for when unsupported size is used - won't link */
>  void __cmpxchg_called_with_bad_pointer(void);
>  /* we only need to support cmpxchg of a u32 on sparc */
> -unsigned long __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
> +u32 __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
>  
>  /* don't worry...optimizer will get rid of most of this */
>  static inline unsigned long
> diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
> index cf80d1ae352b..d90d756123d8 100644
> --- a/arch/sparc/lib/atomic32.c
> +++ b/arch/sparc/lib/atomic32.c
> @@ -159,7 +159,7 @@ unsigned long sp32___change_bit(unsigned long *addr, unsigned long mask)
>  }
>  EXPORT_SYMBOL(sp32___change_bit);
>  
> -unsigned long __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
> +u32 __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
>  {
>  	unsigned long flags;
>  	u32 prev;
> @@ -169,7 +169,7 @@ unsigned long __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
>  		*ptr = new;
>  	spin_unlock_irqrestore(ATOMIC_HASH(ptr), flags);
>  
> -	return (unsigned long)prev;
> +	return prev;
>  }
>  EXPORT_SYMBOL(__cmpxchg_u32);
>  
> -- 
> 2.39.2
> 

