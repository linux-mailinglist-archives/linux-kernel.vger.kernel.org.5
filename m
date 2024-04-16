Return-Path: <linux-kernel+bounces-146499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B87108A6625
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470F12830A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A63433CE;
	Tue, 16 Apr 2024 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="DlAUHYf0"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E4B8825
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713256345; cv=none; b=SV7O6OjSu4r84gxtVv5zaxfzdbukVSjjGxOPFg3/NqdGSTAgHjC774HaOv9LXs6BSaE+H/pLvMLtNfE3V7DfguzDYtYP2GVWC+JEOMiiP2ChFHVFQdM79sd+tY3SllERlYyQ+gwOQ2vacYQrur+22CwskzKMa9XKjyD1HqUVOyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713256345; c=relaxed/simple;
	bh=+aAh3WQg3gPojv9v1+dLx2czBIy4iBe4dAdRn7h7fgw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gIHV/mDfM29b8JVFlFaddvz1LHNyT3SGCprj1zEUvMCCrZrI4fGAtCGB/sCZxuV3ag6r3YtO6FYEewrG3XRqDVP9nQv3JOKRZNLHbwTM0iSDFJrUdo2ENByd70lxAMBnj91zS911Uv6ZMmb5nixmTABv9ABjX1PeMylbq3qd+9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=DlAUHYf0; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yFAspJZiElnV7ukAcy7TezRh9JQm8uQrSj63spw6SrQ=;
  b=DlAUHYf0e5Aqj6iIpamUPwirUZwwNkwrWCOJ6YJ31SbATaWX+aLW8qCd
   xnreRUqQx/oeoXmoWeFz1I0ne+Uo8mAAjIQBD1FKkw4BVUdiqPBl2PLvt
   qztUxP7pVe7H36/8PfwJoz92sPKaVnT4EZo09e8BB+A1BLiVnbjj/f9i1
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,205,1708383600"; 
   d="scan'208";a="161799962"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 10:32:10 +0200
Date: Tue, 16 Apr 2024 10:32:09 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ricardo Ribalda <ribalda@chromium.org>
cc: Nicolas Palix <nicolas.palix@imag.fr>, Denis Efremov <efremov@linux.com>, 
    cocci@inria.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: misc: minmax: Suppress reports for err
 returns
In-Reply-To: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
Message-ID: <ebdeebc4-f840-295-1a25-fc66127e1238@inria.fr>
References: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 15 Apr 2024, Ricardo Ribalda wrote:

> Most of the people prefer:
>
> return ret < 0 ? ret: 0;
>
> than:
>
> return min(ret, 0);
>
> Let's tweak the cocci file to ignore those lines completely.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

I agree.  Thanks for the patch.

julia

> ---
> Following discussion at:
> https://lore.kernel.org/linux-media/20240415203304.GA3460978@ragnatech.se/T/#m4dce34572312bd8a02542d798f21af7e4fc05fe8
> ---
>  scripts/coccinelle/misc/minmax.cocci | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
> index fcf908b34f27..ca4830ae3042 100644
> --- a/scripts/coccinelle/misc/minmax.cocci
> +++ b/scripts/coccinelle/misc/minmax.cocci
> @@ -50,11 +50,26 @@ func(...)
>  	...>
>  }
>
> +// Ignore errcode returns.
> +@errcode@
> +position p;
> +identifier func;
> +expression x;
> +binary operator cmp = {<, <=};
> +@@
> +
> +func(...)
> +{
> +	<...
> +	return ((x) cmp@p 0 ? (x) : 0);
> +	...>
> +}
> +
>  @rmin depends on !patch@
>  identifier func;
>  expression x, y;
>  binary operator cmp = {<, <=};
> -position p;
> +position p != errcode.p;
>  @@
>
>  func(...)
> @@ -116,21 +131,6 @@ func(...)
>  	...>
>  }
>
> -// Don't generate patches for errcode returns.
> -@errcode depends on patch@
> -position p;
> -identifier func;
> -expression x;
> -binary operator cmp = {<, <=};
> -@@
> -
> -func(...)
> -{
> -	<...
> -	return ((x) cmp@p 0 ? (x) : 0);
> -	...>
> -}
> -
>  @pmin depends on patch@
>  identifier func;
>  expression x, y;
>
> ---
> base-commit: 71b3ed53b08d87212fbbe51bdc3bf44eb8c462f8
> change-id: 20240415-minimax-1e9110d4697b
>
> Best regards,
> --
> Ricardo Ribalda <ribalda@chromium.org>
>
>

