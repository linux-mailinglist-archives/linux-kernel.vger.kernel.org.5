Return-Path: <linux-kernel+bounces-149928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B27298A97F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9C42823B1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF37615E1EE;
	Thu, 18 Apr 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9EE8h6c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F5E15AAA5;
	Thu, 18 Apr 2024 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437758; cv=none; b=K5rgZytab3stFOJhvpogXWxpDXQP5uOvY2VZOOoFW3Sy3NaiDdENRlo+NEi0e2l41+gEEJGb744dH9Lq6+wh0gAgz3IxmZ0vmyQYxd+OsgI3upHDEHndNO6WKf/jeMMEfAPlamH3OpyKkVaqIHMG2DVdTt1UCF8PJkgvmgAD04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437758; c=relaxed/simple;
	bh=QKZFgiAAxVmB0Ab5Gva4C9DkDubO+iF3SWJEtPIsX54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCL78Rw8HjquFGSWQi/inyK1Z3tGti9uPprtrWvN655wUZAr5pusCvy5gnqAg2/o13FC8xh2eNJV2T7IWvXuwzA22InSCFYOMIlA+7Qo4f9MqlElN3QzNE0WmXafjJc23l3+NByEiWoAE62N6wzrrggyu6fTCH5A4I9nNvgHYWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9EE8h6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B970C113CC;
	Thu, 18 Apr 2024 10:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713437757;
	bh=QKZFgiAAxVmB0Ab5Gva4C9DkDubO+iF3SWJEtPIsX54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9EE8h6c6EWLkKWVpIDYsnrXuMlaE30U6yItOJCjmn5/bI3ZabIyA4UKpilHNOIdr
	 QcM3XONAwYtkblNReNMkGnUWnxmhPXC3l38oIX1599gIR3sr2TMgyY7VnG9Kshg+jT
	 14j16rC9ARdf0SX+YRY0zBXWMislAXOQsKLpVxpGGGhLICGI1WLSNPsmnivIlaZqgL
	 ch79sKBN2oGs6LILzeZri63UzbcUYpHD0UiSTRxj2JsuPjsfv9WhANU0yE2+gOeCv6
	 sLgfsrsCGRJiT0sNsvzJ1vZeGRWQXuqFQbJIl1zqcKFde14VmQJsKRXUgqJWavd08I
	 2n4Gf9BPpjcAA==
Date: Thu, 18 Apr 2024 13:54:46 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Andreas Dilger <adilger@dilger.ca>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	linux-riscv@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"ndesaulniers @ google . com" <ndesaulniers@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Tejun Heo <tj@kernel.org>,
	Krister Johansen <kjlx@templeofstupid.com>,
	Changbin Du <changbin.du@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] init: fix allocated page overlapping with PTR_ERR
Message-ID: <ZiD79h1OXbzmpfCi@kernel.org>
References: <20240418102943.180510-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418102943.180510-1-namcao@linutronix.de>

On Thu, Apr 18, 2024 at 12:29:43PM +0200, Nam Cao wrote:
> There is nothing preventing kernel memory allocators from allocating a
> page that overlaps with PTR_ERR(), except for architecture-specific
> code that setup memblock.
> 
> It was discovered that RISCV architecture doesn't setup memblock
> corectly, leading to a page overlapping with PTR_ERR() being allocated,
> and subsequently crashing the kernel (link in Close: )
> 
> The reported crash has nothing to do with PTR_ERR(): the last page
> (at address 0xfffff000) being allocated leads to an unexpected
> arithmetic overflow in ext4; but still, this page shouldn't be
> allocated in the first place.
> 
> Because PTR_ERR() is an architecture-independent thing, we shouldn't
> ask every single architecture to set this up. There may be other
> architectures beside RISCV that have the same problem.
> 
> Fix this one and for all by reserving the physical memory page that
> may be mapped to the last virtual memory page as part of low memory.
> 
> Unfortunately, this means if there is actual memory at this reserved
> location, that memory will become inaccessible. However, if this page
> is not reserved, it can only be accessed as high memory, so this
> doesn't matter if high memory is not supported. Even if high memory is
> supported, it is still only one page.
> 
> Closes: https://lore.kernel.org/linux-riscv/878r1ibpdn.fsf@all.your.base.are.belong.to.us
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: <stable@vger.kernel.org> # all versions

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  init/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/init/main.c b/init/main.c
> index 881f6230ee59..f8d2793c4641 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -900,6 +900,7 @@ void start_kernel(void)
>  	page_address_init();
>  	pr_notice("%s", linux_banner);
>  	early_security_init();
> +	memblock_reserve(__pa(-PAGE_SIZE), PAGE_SIZE); /* reserve last page for ERR_PTR */
>  	setup_arch(&command_line);
>  	setup_boot_config();
>  	setup_command_line(command_line);
> -- 
> 2.39.2
> 

-- 
Sincerely yours,
Mike.

