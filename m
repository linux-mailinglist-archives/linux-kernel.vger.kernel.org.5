Return-Path: <linux-kernel+bounces-20685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB12F828378
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523041F24940
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B5A3526E;
	Tue,  9 Jan 2024 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX06f7je"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A00BA45
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F5DC433F1;
	Tue,  9 Jan 2024 09:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704793857;
	bh=DvrmDiuY6GgmxhNHQtU1bWPrasmkM91rmXnYqEuWm3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HX06f7je50opK5ndx4+HaMqqxpX73NQHKGxSqMIx9qoF/P6rhkWNFMPCJ/vNSdk78
	 ku/AVOhpl405OAF/oiX0QfisXafKyrjFb/ZqesDHa4Kxh5Ktpqx13hZ5P2MK8que1a
	 3kn/wx7FiI07ijuoP3WwLXUfz9/5SBEH9+ESyax1q5N1pUpGdJ3DJaK8y+f03Tijzj
	 6Y8KEIt3Aajg2IxCSFFwkjYhpJWY4LTJPQXr8RAKW2NFrLi76Ff+lx5yT69D2JnjXu
	 LzqCqjuPoeMauqL4IfKuoHkWO7R1m0FkYXkmNpCTPkhLKwSTbD0pmVDbMQkK+1AaPP
	 Iv1GdXsGIUOkQ==
Date: Tue, 9 Jan 2024 09:50:51 +0000
From: Will Deacon <will@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Nhat Pham <nphamcs@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Christian Brauner <brauner@kernel.org>, Ian Kent <raven@themaw.net>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM64: Update __NR_compat_syscalls for
 statmount/listmount
Message-ID: <20240109095050.GA12915@willie-the-truck>
References: <20240109010906.429652-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109010906.429652-1-florian.fainelli@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jan 08, 2024 at 05:09:04PM -0800, Florian Fainelli wrote:
> Commit d8b0f5465012 ("wire up syscalls for statmount/listmount") added
> two new system calls to arch/arm64/include/asm/unistd32.h but forgot to
> update the __NR_compat_syscalls number, thus causing the following build
> failures:
> 
> ./arch/arm64/include/asm/unistd32.h:922:24: error: array index in initializer exceeds array bounds
>   922 | #define __NR_statmount 457
>       |                        ^~~
> arch/arm64/kernel/sys32.c:130:34: note: in definition of macro '__SYSCALL'
>   130 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
>       |                                  ^~
> 
> Bump up the number by two to accomodate for the new system calls added.
> 
> Fixes: d8b0f5465012 ("wire up syscalls for statmount/listmount")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  arch/arm64/include/asm/unistd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index 531effca5f1f..b63f870debaf 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -39,7 +39,7 @@
>  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
>  #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
>  
> -#define __NR_compat_syscalls		457
> +#define __NR_compat_syscalls		459
>  #endif
>  
>  #define __ARCH_WANT_SYS_CLONE
> -- 
> 2.34.1

Acked-by: Will Deacon <will@kernel.org>

Will

