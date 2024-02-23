Return-Path: <linux-kernel+bounces-77995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8C2860DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3389B2130D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763735C91B;
	Fri, 23 Feb 2024 09:19:29 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4DA5C8E2;
	Fri, 23 Feb 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679969; cv=none; b=MEe3oWG31JWOPk2ozrFnK3CRRn5ov7YdDBJuMjWYD6ylSQ+1+CuZNEnGZHkX/8y2umJlCykSUlk4JXSdOCUp0sZ9XXbWQJ2fVMF7Gh/4k39/klmpf+gGcy25fOu7FhGRxOCHZsElRK6Pfi8wQoJ+7kMgjWDCzeJyfws1BzKCdds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679969; c=relaxed/simple;
	bh=Q0FbdRdB6nBI0aIGb393byRDit6/AWIKztZb74t9bD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXvrLDqDkxtY4rCGZp5VvrZs7O9I/INy6t0/3NZdDND/VOjIXUNMzsG+vYPRo5VLRjrc+JW5/P+Y+Pb+Ll9MdXpv6S3UZNKiT07naw112HI6CCoksYr32+MvqpOyn94KfUkBqhq2jsO8dSPmwSXZQApeYEFBER9wxSLyNvjxtao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rdRi6-0003JD-00; Fri, 23 Feb 2024 10:19:14 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id E58CCC0267; Fri, 23 Feb 2024 10:18:24 +0100 (CET)
Date: Fri, 23 Feb 2024 10:18:24 +0100
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
Subject: Re: [PATCH 3/4] mips: zboot: Fix "no previous prototype" build
 warning
Message-ID: <Zdhi4ArYz+Ex/4xD@alpha.franken.de>
References: <20240215171740.14550-1-fancer.lancer@gmail.com>
 <20240215171740.14550-4-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240215171740.14550-4-fancer.lancer@gmail.com>

On Thu, Feb 15, 2024 at 08:17:28PM +0300, Serge Semin wrote:
> Without having the putc() prototype forwardly declared the next
> build-warning is printed:
> 
> arch/mips/boot/compressed/uart-prom.c:6:6: warning: no previous prototype for ‘putc’ [-Wmissing-prototypes]
> ...
> 
> Fix that by adding the "decompress.h" header file with the putc() function
> declaration to the source files which have the method redefined.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  arch/mips/boot/compressed/uart-16550.c   | 2 ++
>  arch/mips/boot/compressed/uart-alchemy.c | 2 ++
>  arch/mips/boot/compressed/uart-prom.c    | 2 ++
>  3 files changed, 6 insertions(+)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

