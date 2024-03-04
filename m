Return-Path: <linux-kernel+bounces-91032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725988708B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E20D2846C9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E0B61685;
	Mon,  4 Mar 2024 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC4xiaJr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EDB6166E;
	Mon,  4 Mar 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574741; cv=none; b=gQL5VwK6QqC7V0AqVcWSAzvZFlNm4Yy/CTh+BQj7ptJiJiJdukTo2+cbgGa/IxmGoOSnSfMZrqQHMS4wvO4m8oKbPSwfoG/V7KwxRbrnER95rHiAIWYWwS4gIVf6v3M4h4BV48jrizxrkSnC0iNkuBga5gv2Vb6ZhClqIyuFLFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574741; c=relaxed/simple;
	bh=XsmLd6DfO7PQEwcDTEcc6uqrYp9tQ2/PbdbwVblQHkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUnFMX+4Rsqw0Lycp7FbruQtEudLDc4FqYBoPilzAADEZBZuV2fr7ceNoAI4PShpRDgBGGX1XU5MdOVLYYedk7+21i525Iz6wgUGE6TTow8zzv/RGdRT1U+7/SRQdvKA/LLOF5lkW8b6aqPOEDEXiMjoD1/rhxa0VUaJelFlD6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC4xiaJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA6DC433C7;
	Mon,  4 Mar 2024 17:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709574741;
	bh=XsmLd6DfO7PQEwcDTEcc6uqrYp9tQ2/PbdbwVblQHkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZC4xiaJryMbdfWazibogbn5M6jpCgylKmUZcmirvSSGRb7PUTGD4F7ZE3EV50jI/y
	 7ZsmqhX43rVWND+xjzTI7slAHxyk9V6NWW1XxoSYZelRmgkYk3XpAT5raY1biwbv2P
	 OlPtoQBWMDxLCuy0frnPFueteW/sm+HSyFp/DarS74SuoV4V5FXHVlkuEFO6Asctxg
	 r7R5E27MhixIvL1KbsTwof3W5F24Bg6BPNq7rqWz1Bvfn1jxdWVktoHH7FnzaLfdXL
	 g9dbCuB8DAwsmHbHWKmpbM8CXl5lMEHv4oXXPBAwU6dnwxNYn0DhsZyrtyenhr5JSW
	 ZUWCMSLpybtGw==
Date: Mon, 4 Mar 2024 17:52:16 +0000
From: Simon Horman <horms@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH net-next 1/6] net: hns: make hnae_class constant
Message-ID: <20240304175216.GN403078@kernel.org>
References: <20240302-class_cleanup-net-next-v1-0-8fa378595b93@marliere.net>
 <20240302-class_cleanup-net-next-v1-1-8fa378595b93@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240302-class_cleanup-net-next-v1-1-8fa378595b93@marliere.net>

+ Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Sat, Mar 02, 2024 at 02:05:57PM -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the hnae_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/hisilicon/hns/hnae.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.c b/drivers/net/ethernet/hisilicon/hns/hnae.c
> index 8a1027ad340d..d4293f76d69d 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hnae.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hnae.c
> @@ -12,7 +12,9 @@
>  
>  #define cls_to_ae_dev(dev) container_of(dev, struct hnae_ae_dev, cls_dev)
>  
> -static struct class *hnae_class;
> +static const struct class hnae_class = {
> +	.name = "hnae",
> +};
>  
>  static void
>  hnae_list_add(spinlock_t *lock, struct list_head *node, struct list_head *head)
> @@ -111,7 +113,7 @@ static struct hnae_ae_dev *find_ae(const struct fwnode_handle *fwnode)
>  
>  	WARN_ON(!fwnode);
>  
> -	dev = class_find_device(hnae_class, NULL, fwnode, __ae_match);
> +	dev = class_find_device(&hnae_class, NULL, fwnode, __ae_match);
>  
>  	return dev ? cls_to_ae_dev(dev) : NULL;
>  }
> @@ -415,7 +417,7 @@ int hnae_ae_register(struct hnae_ae_dev *hdev, struct module *owner)
>  	hdev->owner = owner;
>  	hdev->id = (int)atomic_inc_return(&id);
>  	hdev->cls_dev.parent = hdev->dev;
> -	hdev->cls_dev.class = hnae_class;
> +	hdev->cls_dev.class = &hnae_class;
>  	hdev->cls_dev.release = hnae_release;
>  	(void)dev_set_name(&hdev->cls_dev, "hnae%d", hdev->id);
>  	ret = device_register(&hdev->cls_dev);
> @@ -448,13 +450,12 @@ EXPORT_SYMBOL(hnae_ae_unregister);
>  
>  static int __init hnae_init(void)
>  {
> -	hnae_class = class_create("hnae");
> -	return PTR_ERR_OR_ZERO(hnae_class);
> +	return class_register(&hnae_class);
>  }
>  
>  static void __exit hnae_exit(void)
>  {
> -	class_destroy(hnae_class);
> +	class_unregister(&hnae_class);
>  }
>  
>  subsys_initcall(hnae_init);
> 
> -- 
> 2.43.0
> 
> 

