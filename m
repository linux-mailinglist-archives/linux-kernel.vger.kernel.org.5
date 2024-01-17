Return-Path: <linux-kernel+bounces-28750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B1830297
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B761F21654
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA2D1426D;
	Wed, 17 Jan 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IfmK3vmT"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98EA14003;
	Wed, 17 Jan 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484708; cv=none; b=MY5wK3C2YnbPant2rsMsfuE2uiRsFCIpYThqcFLTGRByZ9k5MkIT4w6Hk4ALgXhHF/E+VgFTuY0qxwQJfsHg1hIkcvrNp3MDrOvya/OZpHQIFLhrwB6xn4ltxIdQyhrNTGqesKJ07uJk2dYrHpB0NSW7o2zLK6zm9cLHh396EQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484708; c=relaxed/simple;
	bh=fACrlXOcrK6BDar3ZmQKohMwBmQrwFlqbx59S/4PHYA=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=d0Asfox5inZPdyHYptrGc8Ow2UXdJ1kWgUrDFmNfaaOoXQUpq2VL9U0FnnCTseEuZCWRWgkfscPsBBGL4+T0bdSz2rPLIvadR4y3/Sb56aAFlJ8KNofuCUFBPm7LwIF/efZysRNIl38fUqOj5vGYWu3ReVEYAYYnYjnLVsw5Zp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=IfmK3vmT; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6E6F97E2;
	Wed, 17 Jan 2024 10:43:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1705484634;
	bh=fACrlXOcrK6BDar3ZmQKohMwBmQrwFlqbx59S/4PHYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IfmK3vmTDAmf4XV/feDfL33G+rbYdIeDECl8fxjQOKj9pQkoaNQjyMdX+s/6q9kHU
	 cV7KcYWye9TYDFOPqPFTkf1tL4Xln+Q7V/8Os77T6wjlurfJz1DD+TUW5SP06cNFRK
	 8y8ojhXT3lj17+xqtWcAvdh0WWwqmKnCHL/kt1ZM=
Date: Wed, 17 Jan 2024 11:45:07 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Bo Liu <liubo03@inspur.com>
Cc: sakari.ailus@linux.intel.com, mchehab@kernel.org,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: mt9v032: convert to use maple tree register
 cache
Message-ID: <20240117094507.GC17920@pendragon.ideasonboard.com>
References: <20240117031105.3054-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117031105.3054-1-liubo03@inspur.com>

On Tue, Jan 16, 2024 at 10:11:05PM -0500, Bo Liu wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/mt9v032.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/mt9v032.c b/drivers/media/i2c/mt9v032.c
> index 3ca76eeae7ff..6dfbd1c56c22 100644
> --- a/drivers/media/i2c/mt9v032.c
> +++ b/drivers/media/i2c/mt9v032.c
> @@ -988,7 +988,7 @@ static const struct regmap_config mt9v032_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 16,
>  	.max_register = 0xff,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>  };
>  
>  /* -----------------------------------------------------------------------------

-- 
Regards,

Laurent Pinchart

