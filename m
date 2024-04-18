Return-Path: <linux-kernel+bounces-150777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472C48AA46B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039DD282CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC51919068F;
	Thu, 18 Apr 2024 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="iKBMnnuf"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13996D1C7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713473735; cv=none; b=sEb32HonG0mqriZdQNNbkUm/YQGquBQArCq6CxzIE3gkqCv2P/9Zmeov8I6gBjUGyr//MCcIr1QhhendP8DgSD0LxmEtkUkHF5ELLSmyqK9XBnseQh5upgfdKSKRdO33ei8+FN3yaCjllCRJ4JpVp7QVSnLGJsTPvGBRbC86yB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713473735; c=relaxed/simple;
	bh=Uz+ZlJEqo15wPjuyhcJL6oFRLFmTBAS5fb2Hjk9xTCM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=j4f1ZcsNDfiRZNTQmWUZwTcSOE0GDMjoxWwGWOSK2Oh7MokIxGoZDg15llrYKC0Tez26l4WgLEFoot0EUw4MkNVRlXqd0i/8vypA2wwJZP9u132e0pe1j/AXYC1nx9mvPNWEezIgc3K9hllyWZU+SovAg8BKYbQLA55Mo0xwpJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=iKBMnnuf; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=G8QTA78gicQvOzCOLPgT2dkGgBOXRzDjv6gxywnqqYY=;
  b=iKBMnnufEm63BJiJ736VH7eybDpAcLSFt8Jpjcc7GivmlCaKDSvE+BHY
   DYyD4JvBLFKAZEkhcykeFxkpU6IcFxPWOTqzBqhd3OvJkg60LdGUTyymg
   aMx1dYFxSkgpHpk1pZMcPOTLdBdk7JHPUDfYzZ0lCgP+0ZFfIyMnyQOrq
   c=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,213,1708383600"; 
   d="scan'208";a="162321955"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 22:55:24 +0200
Date: Thu, 18 Apr 2024 22:55:23 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Ricardo Ribalda <ribalda@chromium.org>
cc: Nicolas Palix <nicolas.palix@imag.fr>, Denis Efremov <efremov@linux.com>, 
    cocci@inria.fr, linux-kernel@vger.kernel.org
Subject: Re: [cocci] [PATCH] coccinelle: misc: minmax: Suppress reports for
 err returns
In-Reply-To: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
Message-ID: <alpine.DEB.2.22.394.2404182255010.3213@hadrien>
References: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
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

Applied, thanks. (Coccinelle for-6.10 branch).

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

