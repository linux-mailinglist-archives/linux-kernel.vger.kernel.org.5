Return-Path: <linux-kernel+bounces-60706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5F58508BD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147FE1C212B7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD695A4CA;
	Sun, 11 Feb 2024 11:08:23 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F7559178
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707649702; cv=none; b=TnbsicLqaOCfBUh5LU4v2HqG9OfNonwog/plsM+U5qdbVlIDCyPhH7auPlXZIwjcF0RpQ6jCiOG8YsSeL0GMn9BUVYjlW9hTHRRYWIyq2mvTRUdrrnoZHhD5Fh+zxQ8J85xr1tldZ8ia/B4Ku/UrEdRT9+/LIb5XR1PT8v0l974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707649702; c=relaxed/simple;
	bh=YMK5mYmh5pkQTR3lu25u8R0yI2heFAc1gy8wypaXvqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzR5arRmI/yCEdwnxDuqlW7vAvOHZN89K3guJkcr+0xuDTDpBFpOoxLg+7GoBLdU/9RogEiXUJUAfze6D+DGrGq8KHoOetLfWw3XbDOXleJC7EhnFnfZI4lTnwrCosxSYSx/NeHQ3GL3bzQlDg08754BnoRZtyATPRTr4b8z9Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 41BB8E9V022146;
	Sun, 11 Feb 2024 12:08:14 +0100
Date: Sun, 11 Feb 2024 12:08:14 +0100
From: Willy Tarreau <w@1wt.eu>
To: Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] tools/nolibc: Fix strlcpy() return code and size
 usage
Message-ID: <20240211110814.GB19364@1wt.eu>
References: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
 <20240129141516.198636-4-rodrigo@sdfg.com.ar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129141516.198636-4-rodrigo@sdfg.com.ar>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Rodrigo,

On Mon, Jan 29, 2024 at 03:15:15PM +0100, Rodrigo Campos wrote:
> The return code should always be strlen(src), and we should copy at most
> size-1 bytes.
> 
> While we are there, make sure to null-terminate the dst buffer.
> 
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---
>  tools/include/nolibc/string.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
> index b2149e1342a8..e4bc0302967d 100644
> --- a/tools/include/nolibc/string.h
> +++ b/tools/include/nolibc/string.h
> @@ -212,15 +212,16 @@ size_t strlcpy(char *dst, const char *src, size_t size)
>  	size_t len;
>  	char c;
>  
> -	for (len = 0;;) {
> +	for (len = 0; len < size; len++) {
>  		c = src[len];
> -		if (len < size)
> +		if (len < size - 1)
>  			dst[len] = c;
> +		if (len == size - 1)
> +			dst[len] = '\0';
>  		if (!c)
>  			break;
> -		len++;
>  	}
> -	return len;
> +	return strlen(src);
>  }

It's good, but for the same reason as the previous one, I'm getting
smaller code by doing less in the loop. Also calling strlen() here
looks expensive, I'm seeing that the compiler inlined it nevertheless
and did it in a dep-optimized way due to the asm statement. That
results in 67 bytes total while a simpler version gives 47.

If I explicitly mark strlen() __attribute__((noinline)) that prevents
it from doing so starting with gcc-10, where it correctly places a jump
from strlcpy() to strlen() and ends up with 50 bytes (vs 44 for the alt
one). The other one I can propose is directly derived from the other
strlcat() variant, which first performs the copy and starts to count:

size_t strlcpy(char *dst, const char *src, size_t size)
{
        size_t len;

        for (len = 0; len < size; len++) {
                if (!(dst[len] = src[len]))
                        return len;
        }

        /* end of src not found before size */
        if (size)
                dst[size - 1] = '\0';

        while (src[len])
                len++;

        return len;
}

Just let me know what you think. And I think we should explicitly mark
strlen() and the few other ones we're marking weak as noinline so that
the compiler perfers a call there to inlining. Well, registers clobbering
might not always be worth, but given that strlen() alone provides some
savings I think it's still interesting.

Thanks,
Willy

