Return-Path: <linux-kernel+bounces-165744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1A28B907B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BDF2B20C3D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1130E1635A2;
	Wed,  1 May 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jQgW0CgZ"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12113956C
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594638; cv=none; b=Rt2JzvEcEbBjNg0Ljj24qYR9JejFcNZfAJ6C7cJ5HCT5yRz9KHo7xY76qyx635LDjcf0EHZZYF0w8C9UaVJFZqFnXjBk+5NdN3EVHJJEpVDiroHff5fE/hVgxlVmTRb4Wy6wS+v3uTlPKar6s578MNxpidPL4g/vitMWd1dw6uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594638; c=relaxed/simple;
	bh=GGpAKEpoycwjSWcYUqnZv8ZhAZUkHxo5m5D9dqJxuNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBPcPONoNOoovHaZzgL1HyYMkwZE6HzVbrmOoH/xV8uMAHw7eem8gYL2qgb6CLf5t/dK/793qlwSlWPSac2kfaQxf9wVojaUgwt06ruW6VvgDw7bUXUTKzlG/lZ/RVAJYoBSTQmvwCGHlMGRT80cpVYsRkK53MZ0U1+BC1xcIbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jQgW0CgZ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f2f6142d64so6765487b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 13:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714594636; x=1715199436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TzZlykvaZE49hrAwdEmOhVJUm5xEaSWSbmXs/qt6Y88=;
        b=jQgW0CgZjKAOEc1i32X+GqrG9yW5MdlKY2k8Efxwz8nU+RLfUYZ5CXsF9mPSY/nz/P
         TjHq3AOx7LGAUILxHTHsBT+P9AhvIqMmLnHYQefRI1QvPuOn5+4+ESQPa0eUFQCEJ/Ur
         kRwqbnyPYATUVSO5wbd/dd3DiAwwSK02MyjOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594636; x=1715199436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzZlykvaZE49hrAwdEmOhVJUm5xEaSWSbmXs/qt6Y88=;
        b=mpWIarZb+uA/1ABVLjCi9B/QfhzyPHGHe0Vma8Acdp//gHpcnf9K6u1w9sZ6b14c+I
         V3gsiY7fldG4+VoUI+bR4RmBhxgpUpzEOjTzDDYYv3Js3nntrJ4wBp/hdHfL8asZyboP
         7KsP9bjfVcbX5URYQGNNCba/UA5Zd+LzYAeT6LOrI2SPWYUnjpdbaZVaupMANyi6ioa5
         FB6b31IbdqI+pCdsnl4qqEdjrG84d2UnokR/rB2XPcejhaCJBjJ5PyYgnBoKDntpmNnU
         UgKd35+A8/WGSnM0xJJ1xrSZvgkAt1O0DlMemFob2KzJVUoQEBujYJzl9xo54FUctkIJ
         Qlmw==
X-Forwarded-Encrypted: i=1; AJvYcCUopqvF6kdlCFQWCQANozKUU1YrTs5schFlbToFSiAfM6dxNxI+SkLERNbog7yF/p1M8+5t2Vma8fgRVO/xaOOiYfl59xAaOK9oFqR0
X-Gm-Message-State: AOJu0Yy5UOWNSEHCvCMU72SnTqfhJuOj6xeqp2FtiOfthNlQzy2VRHqI
	Ca/qkYKPL3cvXSgOhYnhE+c45FwHVRwkNpZiaH5e8A0FtIf6jndsZYo041rOMQ==
X-Google-Smtp-Source: AGHT+IGbzYi1d+ldsT9LN6hCvo5dwU6UWZPN8BaXQ/g+gSm91//aeds7KiSLXD8zvIV8i+uTgvZrTQ==
X-Received: by 2002:a05:6a21:6d82:b0:1ac:d96a:4fd6 with SMTP id wl2-20020a056a216d8200b001acd96a4fd6mr4640333pzb.23.1714594636355;
        Wed, 01 May 2024 13:17:16 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j19-20020aa783d3000000b006eaf3fd91a1sm23012143pfn.62.2024.05.01.13.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:17:16 -0700 (PDT)
Date: Wed, 1 May 2024 13:17:15 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	Sven Eckelmann <sven@narfation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v3] batman-adv: Add flex array to struct
 batadv_tvlv_tt_data
Message-ID: <202405011317.9896F210@keescook>
References: <AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Wed, May 01, 2024 at 05:02:42PM +0200, Erick Archer wrote:
> The "struct batadv_tvlv_tt_data" uses a dynamically sized set of
> trailing elements. Specifically, it uses an array of structures of type
> "batadv_tvlv_tt_vlan_data". So, use the preferred way in the kernel
> declaring a flexible array [1].
> 
> At the same time, prepare for the coming implementation by GCC and Clang
> of the __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions). In this case, it is important to note
> that the attribute used is specifically __counted_by_be since variable
> "num_vlan" is of type __be16.
> 
> The following change to the "batadv_tt_tvlv_ogm_handler_v1" function:
> 
> -	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
> -	tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);
> 
> +	tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
> +						     + flex_size);
> 
> is intended to prevent the compiler from generating an "out-of-bounds"
> notification due to the __counted_by attribute. The compiler can do a
> pointer calculation using the vlan_data flexible array memory, or in
> other words, this may be calculated as an array offset, since it is the
> same as:
> 
>         &tt_data->vlan_data[num_vlan]
> 
> Therefore, we go past the end of the array. In other "multiple trailing
> flexible array" situations, this has been solved by addressing from the
> base pointer, since the compiler either knows the full allocation size
> or it knows nothing about it (this case, since it came from a "void *"
> function argument).
> 
> The order in which the structure batadv_tvlv_tt_data and the structure
> batadv_tvlv_tt_vlan_data are defined must be swap to avoid an incomplete
> type error.
> 
> Also, avoid the open-coded arithmetic in memory allocator functions [2]
> using the "struct_size" macro and use the "flex_array_size" helper to
> clarify some calculations, when possible.
> 
> Moreover, the new structure member also allow us to avoid the open-coded
> arithmetic on pointers in some situations. Take advantage of this.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Thanks for the tweak!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

