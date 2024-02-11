Return-Path: <linux-kernel+bounces-60701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1908508B0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123152827BC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12245A11D;
	Sun, 11 Feb 2024 10:52:38 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E5159169
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707648758; cv=none; b=ndxRF90PllthBfkNBWFln8YgNm/l/iH2w16WTGvlTMZvRtS8VMnS1KzdUn9haAyo6d1Y5IH3RzBj3OcV9HYPiOwBqGw33gpD58egC5ddKt+C9IhbX6seYcpXCX3ReiEz0MWd3o6hVfP1dhCkdx0Js4TmBkl4Ei21ZPIVZnDhKGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707648758; c=relaxed/simple;
	bh=cNxbcgqqMclAIyBM5OsBn20kZKGMNf6fjjyrqyOYt2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGk35YcGU1OcVLNTtTsNAzJqGDfCMT5VHpS5K9OupW1o1FdXZr7U6AQjJtHr9xfMfYwSkRaNEI2vS2/8fuokWFvaWbAJJQEYdEeJVSG/rHTZAfVKZ53Rbs1JRmNX3aDCAkI+jos5PacBJ6OCq7u9zHIvxLesgKOb5oPxuKnTl64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 41BAmHBB021945;
	Sun, 11 Feb 2024 11:48:17 +0100
Date: Sun, 11 Feb 2024 11:48:17 +0100
From: Willy Tarreau <w@1wt.eu>
To: Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] tools/nolibc: Fix strlcat() return code and size
 usage
Message-ID: <20240211104817.GA19364@1wt.eu>
References: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
 <20240129141516.198636-3-rodrigo@sdfg.com.ar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129141516.198636-3-rodrigo@sdfg.com.ar>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Rodrigo,

first, thanks for the series!

On Mon, Jan 29, 2024 at 03:15:14PM +0100, Rodrigo Campos wrote:
> The return code should always be strlen(src) + strlen(dst), but dst is
> considered shorter if size is less than strlen(dst).
> 
> While we are there, make sure to copy at most size-1 bytes and
> null-terminate the dst buffer.
> 
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---
>  tools/include/nolibc/string.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
> index ed15c22b1b2a..b2149e1342a8 100644
> --- a/tools/include/nolibc/string.h
> +++ b/tools/include/nolibc/string.h
> @@ -187,23 +187,23 @@ char *strndup(const char *str, size_t maxlen)
>  static __attribute__((unused))
>  size_t strlcat(char *dst, const char *src, size_t size)
>  {
> -	size_t len;
>  	char c;
> +	size_t len = strlen(dst);
> +	size_t ret = strlen(src) + (size < len? size: len);

From what I'm reading in the man page, ret should *always* be the sum
of the two string lengths. I guess it helps for reallocation. It's even
explicitly mentioned:

  "While this may seem somewhat confusing, it was done to make truncation
   detection simple."

Above ret will be bound to the existing size so a realloc wouldn't work.
Thus I think the correct solution is:

	size_t ret = strlen(src) + len;

> -	for (len = 0; dst[len];	len++)
> -		;
> -
> -	for (;;) {
> +	for (;len < size;) {
>  		c = *src;
> -		if (len < size)
> +		if (len < size - 1)
>  			dst[len] = c;
> +		if (len == size - 1)
> +			dst[len] = '\0';
>  		if (!c)
>  			break;
>  		len++;
>  		src++;
>  	}
>  
> -	return len;
> +	return ret;
>  }

The test inside the loop is going to make this not very efficient. Same
for the fact that we're measuring the length of src twice (once via
strlen, a second time through the loop). I've just had a look and it
compiles to 77 bytes at -Os. A simpler variant would consist in trying
to copy what fits in <size> and once reached, go on just for trailing
zero and the size measurement:

size_t strlcat(char *dst, const char *src, size_t size)
{
        size_t len = strlen(dst);

        while (len < size) {
                if (!(dst[len] = *src))
                        return len;
                len++;
                src++;
        }

        /* end of src not found before size */

        if (size)
                dst[size - 1] = '\0';

        while (*src++)
                len++;

        return len;
}

For me it's 58 bytes, or 19 less / 25% smaller, and at first glance it
should do the right thing as well.

What do you think ?

Thanks!
Willy

