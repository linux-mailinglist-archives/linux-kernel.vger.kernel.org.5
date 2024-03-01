Return-Path: <linux-kernel+bounces-88288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AF986DFB3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370F21F24048
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CE26BFC2;
	Fri,  1 Mar 2024 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6lffpy5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4FA6A352
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709290467; cv=none; b=PgK8cHCMyfKQhpij/VdxOgtmaXf2BrzcIkDWnZDpn3fDhWy/FCOBv0/zBw7DtiJ+9tdlXktdiOUrxDT3OLgFC37kagFQgZW8uvafsZ9+2tXVxuWrQfuQmlKMPGVoyzTjlCf7ZqibrQTkt8oFQ7SeAyM/JiODrF+YEJJX04ZabH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709290467; c=relaxed/simple;
	bh=9yUqjRiZDnW0sxFymCG3HhyOZ20gbsK/kpqIlF8AEuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYT6w/D/9rkjylPJwPTsS+80I9I2NpmdTCpFgC3zS14B6E5iKp9GWpvkTS+APJ0VctK5aWPwb0JYdzWaWJhT/6adjAdPNSnnyRZJpJIwaz2ufp85HMHO/ZO2Krnit/5NKZ7SqMMmoxjGVJNGxJLLuuvFrP5nbe3W1mOZb0dNHd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6lffpy5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709290464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tjGEhzuhFUDcE6IMM+mL5TlbxL3v8+X2s2hqXwmwqxI=;
	b=a6lffpy5gQsfuT4K8MEEjear1hptBKoogxLQUm8uq6CSHNQVFhFDaVM5TXLIihoGy0SS0g
	9xZeRIBYQFwefKANsfq4aXVYc9m/NTNesqocbu4lzUPqsz/l52sN2lws/8M3FaRIYIWNSo
	rPn0vhAmQy2gNUL+1GX5tBc3B+bVAgU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-b4NeP0x0OrKwLhGq2lOl_g-1; Fri, 01 Mar 2024 05:54:21 -0500
X-MC-Unique: b4NeP0x0OrKwLhGq2lOl_g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1CCB106CF91;
	Fri,  1 Mar 2024 10:54:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C7014492BE8;
	Fri,  1 Mar 2024 10:54:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 6AB671800DFF; Fri,  1 Mar 2024 11:54:18 +0100 (CET)
Date: Fri, 1 Mar 2024 11:54:18 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Aleksandr Burakov <a.burakov@rosalinux.ru>
Cc: Dave Airlie <airlied@redhat.com>, 
	virtualization@lists.linux-foundation.org, spice-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] drm/qxl: fix NULL dereference in qxl_add_mode
Message-ID: <oprbqmdpjzhjwuqypqfdnirl44drvrhlaiounos44ywdbiustm@myk6llv5chlv>
References: <20240301085511.23298-1-a.burakov@rosalinux.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301085511.23298-1-a.burakov@rosalinux.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Fri, Mar 01, 2024 at 11:55:11AM +0300, Aleksandr Burakov wrote:
> Return value of a function 'drm_cvt_mode' is dereferenced without
> checking for NULL but drm_mode_create() in drm_cvt_mode() may
> return NULL value in case of memory allocation error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 1b043677d4be ("drm/qxl: add qxl_add_mode helper function")
> Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
> ---
>  drivers/gpu/drm/qxl/qxl_display.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index a152a7c6db21..447532c29e02 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -236,8 +236,10 @@ static int qxl_add_mode(struct drm_connector *connector,
>  		return 0;
>  
>  	mode = drm_cvt_mode(dev, width, height, 60, false, false, false);
> -	if (preferred)
> +	if (preferred && mode)
>  		mode->type |= DRM_MODE_TYPE_PREFERRED;
> +	else
> +		return 0;
>  	mode->hdisplay = width;

That doesn't fix the NULL pointer dereference in case "preferred" is
false.

I'd suggest "if (!mode) return 0" instead.


