Return-Path: <linux-kernel+bounces-5806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE6A818FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0901D28AC9A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63DE37D17;
	Tue, 19 Dec 2023 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sjSIBeIJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F7539844;
	Tue, 19 Dec 2023 18:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FFBC433C8;
	Tue, 19 Dec 2023 18:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703010162;
	bh=wSkiNjun2WCZD0RxVXQmuAD/N273lzHSG6FvzoIS+ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjSIBeIJAPebdHDxXCC1d7uqA9GkNF23p1NHcKoyn30cPzw/xCTjaxvq3+TrTXwUv
	 fsiw5vrzcaO1Y80EfN89YXyAZK9OLCTY/ip86xesQodMfPLkZjzidg5Aem01zlR6HO
	 zc/A0JQt8csDafBQBDpk4xZ6Prf7wJQruSRaD/S0=
Date: Tue, 19 Dec 2023 19:22:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tanzir Hasan <tanzirh@google.com>
Cc: Kees Cook <keescook@chromium.org>, Nick DeSaulniers <nnn@google.com>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 1/2] kernel.h: removed REPEAT_BYTE from kernel.h
Message-ID: <2023121938-stargazer-purse-0dc1@gregkh>
References: <20231219-libstringheader-v4-0-aaeb26495d2f@google.com>
 <20231219-libstringheader-v4-1-aaeb26495d2f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219-libstringheader-v4-1-aaeb26495d2f@google.com>

On Tue, Dec 19, 2023 at 06:09:51PM +0000, Tanzir Hasan wrote:
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -39,13 +39,6 @@
>  
>  #define STACK_MAGIC	0xdeadbeef
>  
> -/**
> - * REPEAT_BYTE - repeat the value @x multiple times as an unsigned long value
> - * @x: value to repeat
> - *
> - * NOTE: @x is not checked for > 0xff; larger values produce odd results.
> - */
> -#define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
>  
>  /* generic data direction definitions */
>  #define READ			0
> diff --git a/include/linux/wordpart.h b/include/linux/wordpart.h
> new file mode 100644
> index 000000000000..6a5ed5d54ba2
> --- /dev/null
> +++ b/include/linux/wordpart.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023 Google LLC <tanzirh@google.com>
> + */
> +
> +#ifndef _LINUX_WORDPART_H
> +#define _LINUX_WORDPART_H
> +/**
> + * REPEAT_BYTE - repeat the value @x multiple times as an unsigned long value
> + * @x: value to repeat
> + *
> + * NOTE: @x is not checked for > 0xff; larger values produce odd results.
> + */
> +#define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))

Legal note, this file is NOT copyright Google as no Google employe
actually wrote the logcal contents of it.

Please be VERY careful when doing stuff like this, it has potentially
big repercussions, and you don't want to have to talk to lots of
lawyers a few years from now and explain how you messed it all up :(

Nick, odds are there's a Google copyright class that Tanzir should take
here, if not, I recommend the free LF one that anyone can take online
that explains the issues here:
	https://training.linuxfoundation.org/training/open-source-licensing-basics-for-software-developers/

As-is, this change is STRONGLY Nacked by me.

thanks,

greg k-h

