Return-Path: <linux-kernel+bounces-157852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F4B8B1750
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C28282657
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A35616F0F3;
	Wed, 24 Apr 2024 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QnY8CZJh"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BD4156993
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714002076; cv=none; b=n41u4ckJGsF5yH7t0xx5jeACJLVYA1qWbKyRUQSkFImudsfwUpCijaTN9ziX+R57PHhe8MnOJC0GjhfzMCuwGLfTTSLlbbpPNA37Wny9hk8L3dVnaGxP5z2+wzQZHZI9n3RDAwhMZ6X/6l8oAe2GeYok4xlu1z8lzNq0YZUbfAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714002076; c=relaxed/simple;
	bh=6/nCZHN2ot48niRYtILsWxW3A5Rhs7kQzyWs5jyek1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhveRFwiJtMBVjcfzGIETiM2afod0xDD4XN5o0iFTh7Y+PdavB1PobPmt9VpOGwKOLXNwXR6k5PHYvEJDSQuZizG4gl8Rs4WcMGh22rFcTKYrS5A219kK9DuDfi0DB4L8/zTKiY0ZUa5ggdQGMuMv6s8O7MBDcpU3cbVPTplrOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QnY8CZJh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e8bbcbc2b7so3870105ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714002074; x=1714606874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EoToNmnIGQ/tl3VHTK0FT9JY72AxGKijH26JKi5+fVQ=;
        b=QnY8CZJhTsPFSi4w4PkrRWtrY1WmkKbA8QV/LCygPM8cq72JVRsp/LY1JMt9sP/7F2
         jAWYr781FitO9fYKdWKDoGf+CxTtc2Y3vE6AfcR4BkuyCucigVIPd5c/t0K9+Qrss6EH
         UX4MWVzui3Kq07TwzMy11bPT5NtYa7k2yZxRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714002074; x=1714606874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoToNmnIGQ/tl3VHTK0FT9JY72AxGKijH26JKi5+fVQ=;
        b=IKKgqiuaoFvA6KnsUagYbJ0DS9krtllf2OhRlkmku29tuyiqGyFJZIvb3p+eK9hCzR
         fkLh8/GnX7/vA+EsSpLJgap0x7ng7UUPiACYbMqtiv8KmsR/p8DYbQiaqzHpIvgs+6tV
         Co/FzoO2/FmhORZx8R4B641EnNLQlIjVRq+TLVENbZaauT7wJSc9UWCMnJcgxrVMhEOD
         OvHRARwXy9qs1nlEEzZ2EP2hQYrHcQxrJz5beyN7b4bMoQlfJkTZ+5llvqzSDAtNw8ZF
         prFDvzD2EmZ+6K8rL/pwJluQfTJckhKTIdDVYXMZnXpf4A2p6SHXv0rZfWxEInrxq1uL
         a+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXYfRlKx+DR9FIiFpFKmBDgKd1m78V7ee7jC+6eohfa2aTc9chbX/PhVtoI9U4/oAbV6m4wrjAPVRiQmxfHmllfPWoenzbO67uSwVVM
X-Gm-Message-State: AOJu0YyBCbJASyNrhxhn+7ZjtK3hjEEz4iCXflWX5cyUZL/LIinNMjd2
	Hq86uZISl0kvbuvzrGXklAImriCHkaEfZwHHtgZGq6bhgtbqmQu5kl+SgxhBLA==
X-Google-Smtp-Source: AGHT+IEKgCjBpENw0+PWDNYZyL454MuCp/jPYNsO+pEjvBJa9o+e+CAFfi7+1nI4ZhFCYvLI+RA//w==
X-Received: by 2002:a17:903:2302:b0:1e3:d0fd:236c with SMTP id d2-20020a170903230200b001e3d0fd236cmr5913125plh.37.1714002074531;
        Wed, 24 Apr 2024 16:41:14 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709027ed700b001d8f111804asm12691608plb.113.2024.04.24.16.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:41:14 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:41:13 -0700
From: Kees Cook <keescook@chromium.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: tony.luck@intel.com, gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
	Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] pstore/ram: Replace of_node_put with __free() for
 automatic cleanup
Message-ID: <202404241639.3F455ECCD@keescook>
References: <20240415161409.8375-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415161409.8375-1-jain.abhinav177@gmail.com>

On Mon, Apr 15, 2024 at 04:14:09PM +0000, Abhinav Jain wrote:
> Add __free(device_node) to the parent_node struct declaration.
> Move declaration to initialization for ensuring scope sanity.
> Remove of_node_put from parent_node struct.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>  fs/pstore/ram.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index b1a455f42e93..14f2f4864e48 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -644,7 +644,6 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>  			    struct ramoops_platform_data *pdata)
>  {
>  	struct device_node *of_node = pdev->dev.of_node;
> -	struct device_node *parent_node;
>  	struct resource *res;
>  	u32 value;
>  	int ret;
> @@ -704,14 +703,13 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>  	 * we're not a child of "reserved-memory" and mimicking the
>  	 * expected behavior.
>  	 */
> -	parent_node = of_get_parent(of_node);
> +	struct device_node *parent_node __free(device_node) = of_node_parent(of_node);

Please don't move variable definitions into the middle of the function
body. :)

>  	if (!of_node_name_eq(parent_node, "reserved-memory") &&
>  	    !pdata->console_size && !pdata->ftrace_size &&
>  	    !pdata->pmsg_size && !pdata->ecc_info.ecc_size) {
>  		pdata->console_size = pdata->record_size;
>  		pdata->pmsg_size = pdata->record_size;
>  	}
> -	of_node_put(parent_node);

So this change is functionally fine, but there's really no good reason
to do this -- there is no fancy error handling here, so there's no
benefit to making this change. It doesn't really help readability.

-Kees

>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 

-- 
Kees Cook

