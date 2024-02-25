Return-Path: <linux-kernel+bounces-80019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDEF8629D1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 09:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9B78B21489
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 08:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14BCE55F;
	Sun, 25 Feb 2024 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K1IDhiv5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19349445;
	Sun, 25 Feb 2024 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708851364; cv=none; b=MPoKjdh2gF/pSLEIGZLnkCMgm54732cq88Ue6m1xpOSe6LEXO87i+keLr3kGLp+y3druI0OdtUXRqEAOf0DFDGifPOudQOYMMDyLk50aR2OGiCweQn55OrfLjxx86a50fpqUQBMwJpz5ZnHcMl0qLBCYj0LCVKxbvD/R9vE/9kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708851364; c=relaxed/simple;
	bh=38kp4Bs+qLUhrrZmHZ4+Od2TQWEIG08zA9tTBFZcypY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqwKQZvEtDglADQt42gCYl0NfP4mdKEiDWNZePP8bz0JvLN/SOU0qgLgebQZaTOM/iK4ZQDGxdb3LryMDo2dYQLgqQRI62RdI4muPjasbT10+1O6Pad+sXaMaOnbiRVrKOCbAafE1fK9yIQqLhOMf8m7nYuWSrOd66YaiEIQX6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K1IDhiv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC01AC433C7;
	Sun, 25 Feb 2024 08:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708851363;
	bh=38kp4Bs+qLUhrrZmHZ4+Od2TQWEIG08zA9tTBFZcypY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K1IDhiv5jvK/2H48lJqX+xJl5pEuRbA8n+pEIxesovoKIUTnnAbZWVPV9T5fIAa8M
	 6kZGXjHW9VIJkLELBvQkdPK09ICmNXjzsgnyVTrjpxVLW8SruYRM9+SYXT7LtWPQnG
	 8u6CnoZY/XxoCMoc6UPwdy5Vez8wxpMWcsWsmYIg=
Date: Sun, 25 Feb 2024 09:56:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dileep Sankhla <dileepsankhla.ds@gmail.com>
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, pure.logic@nexus-software.ie,
	johan@kernel.org, elder@kernel.org
Subject: Re: [PATCH] staging: greybus: put macro in a do - while loop
Message-ID: <2024022538-buffoon-praising-f748@gregkh>
References: <20240225084017.418773-1-dileepsankhla.ds@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225084017.418773-1-dileepsankhla.ds@gmail.com>

On Sun, Feb 25, 2024 at 02:10:17PM +0530, Dileep Sankhla wrote:
> Enclose the macro gb_loopback_stats_attrs defined with multiple
> replacement statements in a do - while loop. This avoids possible
> if/else logic defects and clears a checkpatch error.
> 
> ERROR: Macros with multiple statements should be enclosed in a do -
> while loop
> 
> Signed-off-by: Dileep Sankhla <dileepsankhla.ds@gmail.com>
> ---
>  drivers/staging/greybus/loopback.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> index bb33379b5297..eb5a7a20f5a3 100644
> --- a/drivers/staging/greybus/loopback.c
> +++ b/drivers/staging/greybus/loopback.c
> @@ -162,9 +162,11 @@ static ssize_t name##_avg_show(struct device *dev,		\
>  static DEVICE_ATTR_RO(name##_avg)
>  
>  #define gb_loopback_stats_attrs(field)				\
> -	gb_loopback_ro_stats_attr(field, min, u);		\
> -	gb_loopback_ro_stats_attr(field, max, u);		\
> -	gb_loopback_ro_avg_attr(field)
> +	do {							\
> +		gb_loopback_ro_stats_attr(field, min, u);	\
> +		gb_loopback_ro_stats_attr(field, max, u);	\
> +		gb_loopback_ro_avg_attr(field);			\
> +	} while (0)

Did you test build this?

>  #define gb_loopback_attr(field, type)					\
>  static ssize_t field##_show(struct device *dev,				\

Why did you only change one if you thought this was a valid change?

thanks,

greg k-h

