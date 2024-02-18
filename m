Return-Path: <linux-kernel+bounces-70331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834CD85962E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 11:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A971C218A5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B362E400;
	Sun, 18 Feb 2024 10:20:19 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2512DF84
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708251619; cv=none; b=R0SLDF+hA+tIYr/7MeBaW8520Vj/cwKAfj3FiERewx0NWMCeS31aha9oIOoiJjKUCCEU6hn9Cnr/cLhCTksn5tzMjWuEG1FjRkNlsYWTjHG2czlJzwHHrIlAu/f6QgY8kjkZRqdQprMRxEYh+NgoewAquvR+a6H4BwpJldWFE20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708251619; c=relaxed/simple;
	bh=ZtWVjcSYaslclUGRlichPSHeNhxbe+UlnZ7ja0YIWBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIhFBS9LxADufLcucjvQNOvlWGTwn9Hp50RUpZmDx1b4PbJuSmJz5fbw6zGoMLKSCXnQH2NonQkmNIhVWxuK85UPG2GXcV6Ze8kO8me7U/hmZfwXX0AMqATMxw6Pq6jY+aK+qLiaabCQramJoRdfReLyvjZb3CDK0p6diDteZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 41IAK3hM032418;
	Sun, 18 Feb 2024 11:20:03 +0100
Date: Sun, 18 Feb 2024 11:20:03 +0100
From: Willy Tarreau <w@1wt.eu>
To: Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] tools/nolibc: Fix strlcat() return code and size
 usage
Message-ID: <20240218102003.GA32375@1wt.eu>
References: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
 <20240129141516.198636-3-rodrigo@sdfg.com.ar>
 <20240211104817.GA19364@1wt.eu>
 <10b97cd3-5690-40b2-aa8e-3fea5dd4275f@sdfg.com.ar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10b97cd3-5690-40b2-aa8e-3fea5dd4275f@sdfg.com.ar>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Rodrigo,

On Wed, Feb 14, 2024 at 12:34:46PM -0300, Rodrigo Campos wrote:
> Here are two versions that are significantly shorter than the 101 bytes,
> that pass the tests (I added more to account for the src vs dst mismatch
> that was easy to pass tests when both buffers have the same size as they did
> before).
> 
> size_t strlcat_rata(char *dst, const char *src, size_t size)
> {
>         const char *orig_src = src;
>         size_t len = 0;
>         for (;len < size; len++) {
>                 if (dst[len] == '\0')
>                         break;
>         }
> 
>         /* Let's copy len < n < size-1 times from src.
>          * size is unsigned, so instead of size-1, that can wrap around,
>          * let's use len + 1 */
>         while (len + 1 < size) {
>                 dst[len] = *src;
>                 if (*src == '\0')
>                         break;
>                 len++;
>                 src++;
>         }
> 
>         if (src != orig_src)
>                 dst[len] = '\0';
> 
>         while (*src++)
>                 len++;
> 
>         return len;
> }
> 
> This one compiles to 81 bytes here using gcc 13.2.0 and to 83 using gcc
> 9.5.0. Compared to the one posted in the patchset, it is significantly
> smaller.

OK this looks good to me. I think your test on src != orig_src is not
trivial and that testing instead if (len < size) would be better, and
possibly even shorter.

> One based in the version you posted (uses strlen(dst) instead), is this one:
> 
> size_t strlcat_willy_fixed(char *dst, const char *src, size_t size)
> {
>         const char *orig_src = src;
>         size_t len = strlen(dst);
>         if (size < len)
>                 len = size;
> 
>         for (;len + 1 < size; len++, src++) {
>                 dst[len] = *src;
>                 if (*src == '\0')
>                         break;
>         }
> 
>         if (orig_src != src)
>                 dst[len] = '\0';
> 
>         while (*src++)
>                 len++;
> 
>         return len;
> }
> 
> 
> Note the "if size < len, then len=size", I couldn't get rid of it because we
> need to account for the smaller size of dst if we don't get passed it for
> the return code.

Please no, again as I mentioned earlier, it's wrong to use strlen(dst) in
this case: the only situation where we'd accept size < len is if dst is
already not zero-terminated, which means that strlen() cannot be used, or
you'd need strnlen() for that, I'm just seeing that we have it, I thought
we didn't.

> This one is 90 bytes here.

See the point I was making? Sometimes the amount of fat added around a
function call is important compared to just an increment and a comparison.
Of course that's not always true but that's one such example.

> What do you think? Can you make them shorter?

I don't want to enter that activity again this week-end ;-)  It's sufficient
here.

> If you like one of these, I can repost with the improved tests too.

Yeah please check the few points above for your version, make sure to
clean it up according to the kernel's coding style (empty line after
variable declaration, */ on the next line for the multi-line comment
etc) and that's fine.

Thanks,
Willy

