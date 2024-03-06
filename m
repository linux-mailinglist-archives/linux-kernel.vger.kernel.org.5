Return-Path: <linux-kernel+bounces-94566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEB0874180
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27021F2379F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F20E14F65;
	Wed,  6 Mar 2024 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CXXCYn+0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69015134BF
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709757732; cv=none; b=aFF7X6RKnVghew9I6pWYwJQOjxB80whtIY3+eEiMSqVMJaf2iQq0PbXIeLUkPQ+rDfRFAeyv9t6TwbhWdeECzWuKVCJv197S0ZI03R5Z24tPphw4PgKXsHhpc3xV7BJeaDwCw/bWH/gIWv3Wn4oiw6nJhzKNXpZKcwcoYgqMFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709757732; c=relaxed/simple;
	bh=8QjkGGN56rur3Zd21nSy/XsuEaDgsedBd1S3bKFlFU0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JTA27zBpOSBtVHNVtjoZK9zrB1Ijo6sbx19F/XDrzoiX4WCeWHDCeh3p+PzJC5Yr8SZMEAmlF8pyQEDOZVZsE8p9hYmWFTZYPriQ6FGMrpvMPPkr3BgEab7aRz9eMRtZfk8fdDhNRjxfSnJ0nur/PjlvEniMSO5vwr9wEo9oaxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CXXCYn+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19ECC433C7;
	Wed,  6 Mar 2024 20:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1709757732;
	bh=8QjkGGN56rur3Zd21nSy/XsuEaDgsedBd1S3bKFlFU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CXXCYn+0DRw9TwQ+UvHiyx2VWaZ0gl28mmO8VtprvUd4GJBgqWgqN7MefW8nwY6BK
	 e5ZF0XtGmtIQ3kCBnxuzmW8tITG1Bq/QlZlCFse/mJ9YJafeCY5ZCibamGBUOpyuGC
	 1f4AATCSiL44yozW5VWrQnRO0ZqwLG18MVlgVMNE=
Date: Wed, 6 Mar 2024 12:42:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: do not put quotes on cmdline items unless
 necessary
Message-Id: <20240306124211.b490ea3c2372d89cff8c287c@linux-foundation.org>
In-Reply-To: <20240306122452.1664709-1-linux@rasmusvillemoes.dk>
References: <20240306122452.1664709-1-linux@rasmusvillemoes.dk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Mar 2024 13:24:52 +0100 Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> When trying to migrate to using bootconfig to embed the kernel's and
> PID1's command line with the kernel image itself, and so allowing
> changing that without modifying the bootloader, I noticed that
> /proc/cmdline changed from e.g.
> 
>   console=ttymxc0,115200n8 cma=128M quiet -- --log-level=notice
> 
> to
> 
>   console="ttymxc0,115200n8" cma="128M" quiet -- --log-level="notice"
> 
> The kernel parameters are parsed just fine, and the quotes are indeed
> stripped from the actual argv[] given to PID1. However, the quoting
> doesn't really serve any purpose and looks excessive, and might
> confuse some (naive) userspace tool trying to parse /proc/cmdline. So
> do not quote the value unless it contains whitespace.
> 
> ...
>
> --- a/init/main.c
> +++ b/init/main.c
> @@ -319,12 +319,20 @@ static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
>  
>  #define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
>  
> +static int has_space(const char *v)
> +{
> +	for (; *v; v++)
> +		if (isspace(*v))
> +			return 1;
> +	return 0;
> +}

Do we already have something which does this?

Could do strchr(' ')||strchr('\t')

Do we really support tab separation here?  I doubt if that gets used or
tested much.

This function could be __init.



