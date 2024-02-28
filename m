Return-Path: <linux-kernel+bounces-85740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EF286BA2A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010101F275F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D2C7005E;
	Wed, 28 Feb 2024 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZtLJz/W4"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6827003E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156773; cv=none; b=h3i2pGOmdq+JcUHv8yPIQCpbQxVOJP7sVJ6/Z9bRj4HMVgypgBd8g9EZJCXHj1eElZAtZGtX94PckzO2N60y95MLGqPUE4ywFTL4q+skjQ1Wh5AZDtPErHuJf8n9mEGIgnTml1ndhzQrY1/PuuVSz80Uyg4rjIJWRe7tcm4j7ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156773; c=relaxed/simple;
	bh=fcDVrwhc94lvkdvuNxLBpqQuiN5giB/sSTSBYGUgGIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7BH1VeYxgPfg3SPZE3alGTsluqYq6kA4+/brabsyTHob2sH3BTjknBLWrislnSucmSsx0AvjbsGdDS4JSN1PHnFWzC03Nv80UZTbh1hNR9xN+AlWBg+nHQ99GUS26uLgZ9M6SVfDQOj/+UNC9NWaWiRLzMW0qlD4MyptTqvjhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZtLJz/W4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc1e7c0e29so2810535ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709156771; x=1709761571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YdpR7cAKDSC45Ra+lrCp3FSf1aPEjcGJZRBQhc0h7f4=;
        b=ZtLJz/W4FVvtDRebNbxjo9KAbyrivuwW7+Y8BDkVKdrGwX6LFTJ541BhPJLPafiylL
         L1pr8exLx7rY4kcmGR46OVXlksD5v1A+XiM1EMekDxwic601QGOOpe9j/cXgjsOoXyoy
         eX4Xe+VYEYoDAYDRSvSJtR2m0DxJiFFjHoCIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709156771; x=1709761571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdpR7cAKDSC45Ra+lrCp3FSf1aPEjcGJZRBQhc0h7f4=;
        b=peBvGlutxs87KSlCtnPcZKH1HncyF8mrOagPIjfqbX6npRzbC92pAWHnDysQ1IkFpT
         X1aymQjnWfjjwFcQly61HZjXX2sBFnBOTnqpi0BiUt7WFCs0uXK7NjVLwMS6B1VjETJh
         vaIJy7sXbEUgf9PIGDYWLAjAL0Ikh01UsSjaC3mR+l6wTLEti5oDq/Xnj7y8IDiSORYs
         cqQi3CNhfCH6D+eA08FrI99njgFSnHvRUoD+eSn4pnYZkQik/JzvPXirwbob15RFfnKx
         KusX5oZHC6++OmkLSXmP0oMTopEuaj/mtnUyfC62xF4ulJyuHYGMtLcYBnGVM9NRm07x
         M/2g==
X-Forwarded-Encrypted: i=1; AJvYcCVywQ3xE2RLwRx3sNmEUo4hXiuf0mWhDZj8VBXGOJcL8ouqZYGCUn1+3bnMtlBYolyuAYcF1MMKloUhQ/AJiv3dnUM7heIrq1KCGtPn
X-Gm-Message-State: AOJu0Yx/tpUuimuXkTOAMxnyx66uUW4IdoOw3XM+6YMvgvT2F+ueHg2A
	KQl6H9FtKzR4FmScarWzyKbsVS0x6Yu0KS46fxxmPILVK7KhwWSHAHeSMX2gXQ==
X-Google-Smtp-Source: AGHT+IFK5KehNOc+U2G0Wb+EMlndfkoXfMOcgULHS3OIVI0AWPxjaSZUD8y4ptkj3iwHc9bqJccSpg==
X-Received: by 2002:a17:902:ec81:b0:1dc:696d:6bb0 with SMTP id x1-20020a170902ec8100b001dc696d6bb0mr246471plg.6.1709156771102;
        Wed, 28 Feb 2024 13:46:11 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id je6-20020a170903264600b001dc23e877bfsm3733240plb.268.2024.02.28.13.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 13:46:10 -0800 (PST)
Date: Wed, 28 Feb 2024 13:46:10 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v4 7/8] net-device: Use new helpers from overflow.h in
 netdevice APIs
Message-ID: <202402281341.AC67EB6E35@keescook>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>

On Wed, Feb 28, 2024 at 10:41:37PM +0200, Andy Shevchenko wrote:
> We have two new helpers struct_size_with_data() and struct_data_pointer()
> that we can utilize in alloc_netdev_mqs() and netdev_priv(). Do it so.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/netdevice.h |  3 ++-
>  net/core/dev.c            | 10 +++++-----
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index c41019f34179..d046dca18854 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -25,6 +25,7 @@
>  #include <linux/bug.h>
>  #include <linux/delay.h>
>  #include <linux/atomic.h>
> +#include <linux/overflow.h>
>  #include <linux/prefetch.h>
>  #include <asm/cache.h>
>  #include <asm/byteorder.h>
> @@ -2668,7 +2669,7 @@ void dev_net_set(struct net_device *dev, struct net *net)
>   */
>  static inline void *netdev_priv(const struct net_device *dev)
>  {
> -	return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
> +	return struct_data_pointer(dev, NETDEV_ALIGN);
>  }

I really don't like hiding these trailing allocations from the compiler.
Why can't something like this be done (totally untested):


diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 118c40258d07..dae6df4fb177 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2475,6 +2475,8 @@ struct net_device {
 	/** @page_pools: page pools created for this netdevice */
 	struct hlist_head	page_pools;
 #endif
+	u32			priv_size;
+	u8			priv_data[] __counted_by(priv_size) __aligned(NETDEV_ALIGN);
 };
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
@@ -2665,7 +2667,7 @@ void dev_net_set(struct net_device *dev, struct net *net)
  */
 static inline void *netdev_priv(const struct net_device *dev)
 {
-	return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
+	return dev->priv_data;
 }
 
 /* Set the sysfs physical device reference for the network logical device
diff --git a/net/core/dev.c b/net/core/dev.c
index cb2dab0feee0..afaaa3224656 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10814,18 +10814,14 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 		return NULL;
 	}
 
-	alloc_size = sizeof(struct net_device);
-	if (sizeof_priv) {
-		/* ensure 32-byte alignment of private area */
-		alloc_size = ALIGN(alloc_size, NETDEV_ALIGN);
-		alloc_size += sizeof_priv;
-	}
+	alloc_size = struct_size(p, priv_data, sizeof_priv);
 	/* ensure 32-byte alignment of whole construct */
 	alloc_size += NETDEV_ALIGN - 1;
 
 	p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
 	if (!p)
 		return NULL;
+	p->priv_size = sizeof_priv;
 
 	dev = PTR_ALIGN(p, NETDEV_ALIGN);
 	dev->padded = (char *)dev - (char *)p;


-- 
Kees Cook

