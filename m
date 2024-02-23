Return-Path: <linux-kernel+bounces-77997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0293B860DD8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0584282AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163C75CDE0;
	Fri, 23 Feb 2024 09:19:30 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5455C8E3;
	Fri, 23 Feb 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679969; cv=none; b=Jhb+yuGufTpRYZ4jS76Mhcyu0LECz+4/XzfFNKZoU/6AeGdM2ozPHaicXXUUWIlFhxxRz9BOscMwvJ/n7dORcoWCsoRSmRuLbvgvq3+Rba5VSuQyaga+d+KqYchnmIZYU5uSb6ECTsurtrMO55nVSCiefqgQGe02C0V5h3kWIes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679969; c=relaxed/simple;
	bh=mqL0eakhk7VpDDSz5MotaLvd3eO0HeCgpKFAvIq9lmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bC9o58o+mVrsXlcyuZgfuw+m1N7zITuBPTbszcLN1vkj95gL7tZ2Lmh+ZvFALaCbtf9G9U36Fc1gPCCli10r4mssF0vQsFlAYsjhqrsnnJFKCN9vnkhQ/w221N/ILBJoy+Zi2qabLGq1V0H1G+LO8uTqNDcePUHA9n4aO/w5OIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rdRi6-0003JF-00; Fri, 23 Feb 2024 10:19:14 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id BD759C069B; Fri, 23 Feb 2024 10:18:38 +0100 (CET)
Date: Fri, 23 Feb 2024 10:18:38 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Stephen Rothwell <sfr@rothwell.id.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] tty: mips_ejtag_fdc: Fix passing incompatible
 pointer type warning
Message-ID: <Zdhi7otmi4OQWxZ1@alpha.franken.de>
References: <20240215171740.14550-1-fancer.lancer@gmail.com>
 <20240215171740.14550-5-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240215171740.14550-5-fancer.lancer@gmail.com>

On Thu, Feb 15, 2024 at 08:17:29PM +0300, Serge Semin wrote:
> mips_ejtag_fdc_encode() method expects having a first argument passed of
> the "u8 **" type, meanwhile the driver passes the "const char **" type.
> That causes the next build-warning:
> 
> drivers/tty/mips_ejtag_fdc.c: In function ‘mips_ejtag_fdc_console_write’:
> drivers/tty/mips_ejtag_fdc.c:343:32: error: passing argument 1 of ‘mips_ejtag_fdc_encode’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>    word = mips_ejtag_fdc_encode(&buf_ptr, &buf_len, 1);
>                                 ^
> drivers/tty/mips_ejtag_fdc.c:216:24: note: expected ‘const u8 ** {aka const unsigned char **}’ but argument is of type ‘const char **’
>  static struct fdc_word mips_ejtag_fdc_encode(const u8 **ptrs,
>                         ^~~~~~~~~~~~~~~~~~~~~
> 
> Fix it by altering the type of the pointer which is passed to the
> mips_ejtag_fdc_encode() method.
> 
> Fixes: ce7cbd9a6c81 ("tty: mips_ejtag_fdc: use u8 for character pointers")
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/tty/mips_ejtag_fdc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
> index aac80b69a069..afbf7738c7c4 100644
> --- a/drivers/tty/mips_ejtag_fdc.c
> +++ b/drivers/tty/mips_ejtag_fdc.c
> @@ -309,7 +309,7 @@ static void mips_ejtag_fdc_console_write(struct console *c, const char *s,
>  	unsigned int i, buf_len, cpu;
>  	bool done_cr = false;
>  	char buf[4];
> -	const char *buf_ptr = buf;
> +	const u8 *buf_ptr = buf;
>  	/* Number of bytes of input data encoded up to each byte in buf */
>  	u8 inc[4];

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

