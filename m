Return-Path: <linux-kernel+bounces-5554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 557C3818C27
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29BB282F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AB62031C;
	Tue, 19 Dec 2023 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="CcFe7niH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF101DDD4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DYZi0xUVKQjLCwKkFJ++JHdSFlP1E0i62Ei8BIy8Ocw=;
  b=CcFe7niHMWXGgPgJs6n7o04aUJqUMs/JXuBAeyYgFtzyeWGtvmWw0S3r
   01j1JxO8i58/DPAFX3CmmphvbRGLyiAQwN/247kHflvEM/fOdpTQoF6Uu
   XnZCgKYHTp8soNZNnm8Nk+pwcW9NBtFc5DUOxEUwtEOf0j149Q5EhAGOe
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,288,1695679200"; 
   d="scan'208";a="143170015"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 17:25:13 +0100
Date: Tue, 19 Dec 2023 17:25:13 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Piro Yang <piroyangg@gmail.com>
cc: Greg KH <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev, 
    Linux Outreachy <outreachy@lists.linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 RESEND] staging:vme_user:Fix the issue of return the
 wrong error code
In-Reply-To: <20231219161402.50510-1-piroyangg@gmail.com>
Message-ID: <ab556573-42fc-d25b-709e-332568c1a61d@inria.fr>
References: <20231219161402.50510-1-piroyangg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

The subject line looks wrong.  Normally there are spaces after :.  Look at
what others have done on this file and do the same.

Also, did you previously send a V3?  Resend is only for when you are
sending exactly the same thing you sent previously, not because you fixed
something up.

On Wed, 20 Dec 2023, Piro Yang wrote:

> Fixed the issue of returning the -ENOSYS error code when an
> error occurs.
>
> The error code of -ENOSYS indicates Invalid system call number,
> but there is not system call error. So replace -ENOSYS error code
> by using -EINVAL error code to return.
>
> Signed-off-by: Piro Yang <piroyangg@gmail.com>
> ---
>  v3: change the description and format for the patch.
>
>  v2: split two different changes,
>      only fix the issue of wrong error code.
> ---

The second --- is not needed.

Finally, it's not the application period of Outreachy, so please don't use
the list outreachy@lists.linux.dev.  That's only for outreachy applicants.

thanks,
julia

>  drivers/staging/vme_user/vme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> index 5c416c31ec57..9bc2d35405af 100644
> --- a/drivers/staging/vme_user/vme.c
> +++ b/drivers/staging/vme_user/vme.c
> @@ -341,7 +341,7 @@ int vme_slave_set(struct vme_resource *resource, int enabled,
>
>  	if (!bridge->slave_set) {
>  		dev_err(bridge->parent, "Function not supported\n");
> -		return -ENOSYS;
> +		return -EINVAL;
>  	}
>
>  	if (!(((image->address_attr & aspace) == aspace) &&
> --
> 2.25.1
>
>
>

