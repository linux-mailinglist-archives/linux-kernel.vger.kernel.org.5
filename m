Return-Path: <linux-kernel+bounces-129706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3A2896EBE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6A71C21678
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2DB145FF7;
	Wed,  3 Apr 2024 12:13:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94A3142E75
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712146401; cv=none; b=cfExWCoI17cKNFvkdONMYMiUctb+4vEMxoUGhsPK9YfAmRzPmEwal05T66LkQPbYij6TuaCvx1AWLBKkffAFOKsdSQ03TQNUtt2P4nWspWYjZX2SdyNP0hryPCNob7s+ICXXOvj23tUwBGN5OBfX+6inVX5aopYXUoX6um/qQQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712146401; c=relaxed/simple;
	bh=MnDzAPaZgh+LwiX3vguMB41qPw4moIIh3UtknoJDEz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3yhAMKLSpko5qtmb5Oul/S9/h54/zQdcjLuOcZDsIe7znIHXBFEKfcyUFNX3dAPRmNyV7dzzyGIwtMoo3mgysblOaYBFYB9XHC6AVbjHq9nXGfm+0CtpYtLmUYbUFDrlAUTYHXslDWYALiOE5ZEufaJ1zIV4sdBP3MHFYReMwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 705321007
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 05:13:50 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2836A3F64C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 05:13:19 -0700 (PDT)
Date: Wed, 3 Apr 2024 13:13:11 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Huai-Yuan Liu <qq810974084@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com
Subject: Re: [PATCH] drm/arm/malidp: fix a possible null pointer dereference
Message-ID: <Zg1H15nvHr_zbpKo@e110455-lin.cambridge.arm.com>
References: <20240403014301.969988-1-qq810974084@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240403014301.969988-1-qq810974084@gmail.com>

Hi,

On Wed, Apr 03, 2024 at 09:43:01AM +0800, Huai-Yuan Liu wrote:
> 
> In malidp_mw_connector_reset, new memory is allocated with kzalloc, but 
> no check is performed. In order to prevent null pointer dereferencing, 
> ensure that mw_state is checked before calling 
> __drm_atomic_helper_connector_reset.

Thanks for the patch, it does look like an oversight. Can I suggest you
respin your patch and add a

	connector->state = NULL;

right after kfree(connector->state) ?

That way we can be sure we're not leaving state pointing to freed memory.

Best regards,
Liviu

> 
> Fixes: 8cbc5caf36ef ("drm: mali-dp: Add writeback connector")
> Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
> ---
>  drivers/gpu/drm/arm/malidp_mw.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
> index 626709bec6f5..25623ef9be80 100644
> --- a/drivers/gpu/drm/arm/malidp_mw.c
> +++ b/drivers/gpu/drm/arm/malidp_mw.c
> @@ -72,7 +72,9 @@ static void malidp_mw_connector_reset(struct drm_connector *connector)
>  		__drm_atomic_helper_connector_destroy_state(connector->state);
>  
>  	kfree(connector->state);
> -	__drm_atomic_helper_connector_reset(connector, &mw_state->base);
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

