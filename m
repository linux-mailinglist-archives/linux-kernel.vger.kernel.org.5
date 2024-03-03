Return-Path: <linux-kernel+bounces-89884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F66386F6DD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE052B2131E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C3779DAB;
	Sun,  3 Mar 2024 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTRuqOSX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A5679B6C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709494905; cv=none; b=kqA2yj1AFz31FPM9Z5aSfICGXrojpFOzfC9EaYWnFYxDoVImXQc/Nd1zbUItm+xzg4mLiL1+saP0pPpo4VwDTOy8jY58Zbnd22yuQguu58+NctLtdQ9WBnWnNr9ks3Sf4gddXNyqXYcP1GZGPz4ta8iL4ZKAPOiuihAWMvsMpuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709494905; c=relaxed/simple;
	bh=+E5ggpM/hP5EXhzqfsuNKFSQ5CtjgjuoKpGUYJW27cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTc3w2OKxe8o8+PjQZL4RSxoSfo7jgUu/kM1oopMeViLmeKEnEoWAvkLssdG6pExROSwUoh70kLq7GUKoXy4WcoGCOBOZXDsKHj1w3BGJ5RT9BKBoXUthHc8vbd08F1r7uvaiZlaI9S10f5Ga/TVXWzaXKv9XTKe7LeyiENu5Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTRuqOSX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709494900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CrZqCaxS9s67B9eUeOozSgFserucqgwctSw84bcfIM8=;
	b=ZTRuqOSXnhpKPQjDviJvCYeNP8pYXOe6+2DbRT8LVKJX8oGiDjA+ccMyO1wwJPPy154DPt
	qkfydepyh9MsW4b+MJgJ+h1Bn7CmZ+vwylUUb2YBh8jJPkTqN12WuokKKSL8wWR0us6Y0O
	3QXHy1TVn/iQ0KtdgP4JWDW84DePDQ8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-KbDxi2v7NCOtOZ_MXBFG6w-1; Sun, 03 Mar 2024 14:41:36 -0500
X-MC-Unique: KbDxi2v7NCOtOZ_MXBFG6w-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a450c660cdeso51417366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 11:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709494895; x=1710099695;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrZqCaxS9s67B9eUeOozSgFserucqgwctSw84bcfIM8=;
        b=EBYD35HXGbwHrXu0zxfat6aZgR4NN1068ztdaFDpob4urFboPg2i1j+JvSQL06xlWh
         pdjkwb+Ryuc8V/A+U+tu09r8ISGMKTzMxjUb6bSRgvSamNOxYC6bghTQtWy9HBfA1S+1
         YJPkh4H9sNBPwIuzuJuKBfIo6eZHA2NNG0b/Vn+lZ01VHW00tgoClZW/uBf3bSP3aSzH
         Tz1dybIhizKGVgKnkg0uW/sKWgp2wEYX/QWqt9OC/1ClQU+Gd9AWn1rCYU+7aJ9KuDKO
         5OURfjURtz71Sa1RULVVs5WAKfLdFktAeioVSDlHqtrNt+gOcNPW6HJSeiiNNmk7Hb2q
         +zQA==
X-Forwarded-Encrypted: i=1; AJvYcCXeUEWqE4lk8Wy16t5Ie8DBTUmAKU5d/fzeCGWZeMOxbvNTIU5smU2/GiWvWWYfe0K2WZGHYO7qORrVpT9ZHWHIbSlixllry3THwQm3
X-Gm-Message-State: AOJu0YxF8W9UBSLidr4P/8J24DY1oh2jvzwT9fOGaj/0E+iwKui/QdOD
	c/XDogaIZSkmLubzXCDS5TQnqtcSYPhnrP2t0UCvC1Z/M6SlIKjqKw+W7KTntWljdkqPMChg6ot
	BncpZjtjymkLnzrW5LbdAZ3/goZN31dK25pxjUTgoYzrpdAZAMHR229ooV6/Lig==
X-Received: by 2002:a17:906:bc48:b0:a44:958:c3a4 with SMTP id s8-20020a170906bc4800b00a440958c3a4mr4451501ejv.32.1709494895277;
        Sun, 03 Mar 2024 11:41:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu1jxPV7cPS+/fsucBMIlB97ZiWQ90zg1WuMlonpMMThfwE6bnawsbVY/blo0sj3F2RYlgDg==
X-Received: by 2002:a17:906:bc48:b0:a44:958:c3a4 with SMTP id s8-20020a170906bc4800b00a440958c3a4mr4451489ejv.32.1709494894956;
        Sun, 03 Mar 2024 11:41:34 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id tk2-20020a170907c28200b00a43ab3e38d6sm3933441ejc.114.2024.03.03.11.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 11:41:34 -0800 (PST)
Message-ID: <0f6180b5-92ef-4fb5-8df9-734ec4105c68@redhat.com>
Date: Sun, 3 Mar 2024 20:41:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] drm/vboxvideo: fix mapping leaks
Content-Language: en-US, nl
To: Philipp Stanner <pstanner@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>, Sam Ravnborg <sam@ravnborg.org>,
 dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, stable@kernel.vger.org
References: <20240301112959.21947-1-pstanner@redhat.com>
 <20240301112959.21947-11-pstanner@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240301112959.21947-11-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/1/24 12:29, Philipp Stanner wrote:
> When the PCI devres API was introduced to this driver, it was wrongly
> assumed that initializing the device with pcim_enable_device() instead
> of pci_enable_device() will make all PCI functions managed.
> 
> This is wrong and was caused by the quite confusing PCI devres API in
> which some, but not all, functions become managed that way.
> 
> The function pci_iomap_range() is never managed.
> 
> Replace pci_iomap_range() with the actually managed function
> pcim_iomap_range().
> 
> CC: <stable@kernel.vger.org> # v5.10+
> Fixes: 8558de401b5f ("drm/vboxvideo: use managed pci functions")
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Since this depends on the pcim_iomap_range() function which is new
in this series and since the vboxvideo code does not see a lot
of changes I think that it would be best for this patch to be
merged through the PCI tree together with the rest of the series.

Regards,

Hans


> ---
>  drivers/gpu/drm/vboxvideo/vbox_main.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_main.c b/drivers/gpu/drm/vboxvideo/vbox_main.c
> index 42c2d8a99509..d4ade9325401 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_main.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_main.c
> @@ -42,12 +42,11 @@ static int vbox_accel_init(struct vbox_private *vbox)
>  	/* Take a command buffer for each screen from the end of usable VRAM. */
>  	vbox->available_vram_size -= vbox->num_crtcs * VBVA_MIN_BUFFER_SIZE;
>  
> -	vbox->vbva_buffers = pci_iomap_range(pdev, 0,
> -					     vbox->available_vram_size,
> -					     vbox->num_crtcs *
> -					     VBVA_MIN_BUFFER_SIZE);
> -	if (!vbox->vbva_buffers)
> -		return -ENOMEM;
> +	vbox->vbva_buffers = pcim_iomap_range(
> +			pdev, 0, vbox->available_vram_size,
> +			vbox->num_crtcs * VBVA_MIN_BUFFER_SIZE);
> +	if (IS_ERR(vbox->vbva_buffers))
> +		return PTR_ERR(vbox->vbva_buffers);
>  
>  	for (i = 0; i < vbox->num_crtcs; ++i) {
>  		vbva_setup_buffer_context(&vbox->vbva_info[i],
> @@ -116,11 +115,10 @@ int vbox_hw_init(struct vbox_private *vbox)
>  	DRM_INFO("VRAM %08x\n", vbox->full_vram_size);
>  
>  	/* Map guest-heap at end of vram */
> -	vbox->guest_heap =
> -	    pci_iomap_range(pdev, 0, GUEST_HEAP_OFFSET(vbox),
> -			    GUEST_HEAP_SIZE);
> -	if (!vbox->guest_heap)
> -		return -ENOMEM;
> +	vbox->guest_heap = pcim_iomap_range(pdev, 0,
> +			GUEST_HEAP_OFFSET(vbox), GUEST_HEAP_SIZE);
> +	if (IS_ERR(vbox->guest_heap))
> +		return PTR_ERR(vbox->guest_heap);
>  
>  	/* Create guest-heap mem-pool use 2^4 = 16 byte chunks */
>  	vbox->guest_pool = devm_gen_pool_create(vbox->ddev.dev, 4, -1,


