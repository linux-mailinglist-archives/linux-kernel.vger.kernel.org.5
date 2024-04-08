Return-Path: <linux-kernel+bounces-135213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3960589BCCC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACC61C22353
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D99052F85;
	Mon,  8 Apr 2024 10:15:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFEA47F4A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571351; cv=none; b=gHmvMhXO6QP+LTdg/rx6wB64t+7lg9XOWSLm/xsFv3UFmXQGPOEWDmZDIpj3yZtiUFSw6F6eN0Obdn1WlFieQIQC9KIcnHJbeEKIUu8aBedq1UfE9ORGakNgs0G3ZYcLMzPV+98d6mr11Gve1QvFjQL1z5aBFUpxIMPvRWWgez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571351; c=relaxed/simple;
	bh=6656wgXhCIaDQgy7RQtYIBZ1HxG+G84/yZNGuxzwqGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nR6fOi6UkV5kSXpNQV3a9EBQIsDSxk/b7FcnETuo9wPTa6+aQuXBs/f1g2kyRNmBmKDIW4+/IByt36ts5WWKXDQwwvB/4UTtso677R1EAbj0AXaRkdMZEdC2VeXpIIpqLhdC635f7fNwReuLLhlMN3Dx0QVC4ZZJ+bYm76Q5Gz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 902D81007
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 03:16:19 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF2203F766
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 03:15:48 -0700 (PDT)
Date: Mon, 8 Apr 2024 11:15:41 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Huai-Yuan Liu <qq810974084@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com
Subject: Re: [PATCH V2] drm/arm/malidp: fix a possible null pointer
 dereference
Message-ID: <ZhPDzdRp_6BAQkyP@e110455-lin.cambridge.arm.com>
References: <20240407063053.5481-1-qq810974084@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240407063053.5481-1-qq810974084@gmail.com>

On Sun, Apr 07, 2024 at 02:30:53PM +0800, Huai-Yuan Liu wrote:
> In malidp_mw_connector_reset, new memory is allocated with kzalloc, but 
> no check is performed. In order to prevent null pointer dereferencing, 
> ensure that mw_state is checked before calling 
> __drm_atomic_helper_connector_reset.
> 
> Fixes: 8cbc5caf36ef ("drm: mali-dp: Add writeback connector")
> Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for the patch. I will pull it into drm-misc-fixes before the end of the week.

Best regards,
Liviu

> ---
> V2:
> * In patch V2, we additionally set connector->state to NULL. In this way
> we can ensure that there is no state pointing to freed memory.
>   Thanks to Liviu Dudau for helpful suggestion.
> ---
>  drivers/gpu/drm/arm/malidp_mw.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
> index 626709bec6f5..2577f0cef8fc 100644
> --- a/drivers/gpu/drm/arm/malidp_mw.c
> +++ b/drivers/gpu/drm/arm/malidp_mw.c
> @@ -72,7 +72,10 @@ static void malidp_mw_connector_reset(struct drm_connector *connector)
>  		__drm_atomic_helper_connector_destroy_state(connector->state);
>  
>  	kfree(connector->state);
> -	__drm_atomic_helper_connector_reset(connector, &mw_state->base);
> +	connector->state = NULL;
> +
> +	if (mw_state)
> +		__drm_atomic_helper_connector_reset(connector, &mw_state->base);
>  }
>  
>  static enum drm_connector_status
> -- 
> 2.34.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

