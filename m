Return-Path: <linux-kernel+bounces-85223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90C486B276
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537CA1F27D06
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F4E15B0FD;
	Wed, 28 Feb 2024 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="A30R7Hlb"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E7114AD28
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132171; cv=none; b=sAAP/wfBXEezYDMd9LLeldy0Y2nNFb/HkbxyfSTIt/IqHKPmA9qJxuQld5+a8E0kkGl6AGLg56sHm4it842V7q8gqmwROy50IpeRkci1a8ScwO2VfndouHP2WfrYE0NFYbPAUHmzbQBIW635+a1RMwNz9RS0QpX2cE3KVhSXyDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132171; c=relaxed/simple;
	bh=Q509+z4lNQ5qFbVUTzEMvk4bHRjT+dQXAk+T+19cGlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDxzmVKhOj25oKTyiRLssRNdbjqlGEoqKqmeXvCgwMaOSJ4RO8zFUEVt0a1yN84M+0ez7igrURjFKgyaZAVcyIHUDCBp1iY5/6PSb8jUt7oYETn7MbYr6Q7iqp0xb4tZb1aEFLt5/6R0Axzvma2j54al80Di5KQSCi/H2xg/+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=A30R7Hlb; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d2c8c1b76cso2867621fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1709132167; x=1709736967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vcMWHnsgqS7W8fnpj1PaXiom5DksSZX96pEaShUzcc=;
        b=A30R7Hlbwqy44o3SylhtyDOf/io5qNZBIHD8lOS4gkbcIpgi8fcO2JYYL/u843WDkR
         mW02vDc9SNRdIjddyWsxISHxJS+hVPQQ1Mx7N/r1x46tnRMLuR67S0dNBKMkEIdySFsZ
         pugB0uCm4LxOlCemf4eh1Yoh7OL2TsLOknZP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709132167; x=1709736967;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vcMWHnsgqS7W8fnpj1PaXiom5DksSZX96pEaShUzcc=;
        b=tp3YwCHDF3QFfjez7rfFs9mEjgupyERaTyhms+4r35N3z21G7WhNhb7A9koLNU4QDx
         /ZrQGsN5xF8hVfoXrRjAa2/jGBK6xfnd+OPExpN5N8ShZRUqsdIKzIQ6flFLJw/rh+zY
         Ht1rasHfMVgxFP2cDdfr2NhERXt40tz37y9cYZziYIuqXYnHi/pkrQAglaryFYyirJYQ
         ok8whJfsIL1kqsRLXnhWE2l6ziPlGHcDH+ocuMmW85ZUMSfvM9ZQJKWOoQNOsFjelANM
         u64pbrwbZ0OeZfWNB1isjJ6AzUPnpbOo0hhbe2yBWV1Mq6cSSXm8TDUKyKB7Dxupi+bK
         2osA==
X-Forwarded-Encrypted: i=1; AJvYcCUUhLVBOT6mSMfkLJ3C8FfPmfaDLqNHHdCEYZUbwSetvUyu5JMlHKsGBY6M4RrxmWcxj5r+IufxtPe6k73VB5/eo3ldA+o6no/AABWr
X-Gm-Message-State: AOJu0YzbRuSGWnnodqjCdhwJv+WjhvbpsHp1Trd34l2zFYk8eq2LENgH
	g2Tkgz3zFrXsMLutIy0YjsEbCCK6mo8OKqSCmLthh8c9j0IC6TC0tgr0eW6BiX0=
X-Google-Smtp-Source: AGHT+IEAGFSW/uX/YpbDaJT1Mv1OsObD1Iuo5PxtDuR6p/AmF+ZMAoYUnQ3pqM6XlOYLcbdO9CcHKg==
X-Received: by 2002:a05:6512:3d88:b0:513:16a8:4292 with SMTP id k8-20020a0565123d8800b0051316a84292mr2579206lfv.2.1709132167118;
        Wed, 28 Feb 2024 06:56:07 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t4-20020a0560001a4400b0033d06dfcf84sm14599276wry.100.2024.02.28.06.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 06:56:06 -0800 (PST)
Date: Wed, 28 Feb 2024 15:56:04 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: ltuikov89@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/scheduler: Simplify the allocation of slab caches in
 drm_sched_fence_slab_init
Message-ID: <Zd9JhJ8gXfk7k9sz@phenom.ffwll.local>
Mail-Followup-To: Kunwu Chan <chentao@kylinos.cn>, ltuikov89@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240221085558.166774-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221085558.166774-1-chentao@kylinos.cn>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Wed, Feb 21, 2024 at 04:55:58PM +0800, Kunwu Chan wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Applied to drm-misc-next, thanks for your patch!
-Sima

> ---
>  drivers/gpu/drm/scheduler/sched_fence.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
> index 06cedfe4b486..0f35f009b9d3 100644
> --- a/drivers/gpu/drm/scheduler/sched_fence.c
> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
> @@ -33,9 +33,7 @@ static struct kmem_cache *sched_fence_slab;
>  
>  static int __init drm_sched_fence_slab_init(void)
>  {
> -	sched_fence_slab = kmem_cache_create(
> -		"drm_sched_fence", sizeof(struct drm_sched_fence), 0,
> -		SLAB_HWCACHE_ALIGN, NULL);
> +	sched_fence_slab = KMEM_CACHE(drm_sched_fence, SLAB_HWCACHE_ALIGN);
>  	if (!sched_fence_slab)
>  		return -ENOMEM;
>  
> -- 
> 2.39.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

