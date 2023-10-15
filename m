Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B0C7C99CA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjJOPfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOPfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:35:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F58C5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=HGu2TaKT3AxH2/KDcfAn+b808o6kLJvW+inbCvMRQfA=; b=TlB9LrBEvBR8U9kbW3JXBYMqhS
        IMRLVtX+gud02KZZLfT6KxH6GIUrTwr65NYCZNPIoyR4ts1bf1BGjZZOCak40c/IDhYMV0UzzNd2I
        uSlOjBjnOCxtVPP9vAbCVi05hFP8XrXAo71uBJWxDyqShQcpVbDaCjFZijgpDgKuG74XWkxvKaX6S
        pE8McOzLpU1Qdpw+iE+5RQeoZsDSv3XouuLZD0+2GIftQgOyNZ0sJ2C7qcpCEP3SggwRZMxdh3w9f
        /bCirbus8+q2Jo4NbwFelF//3rJMdszdGQSEMqNat/Bm8q8RxlTlmuoJ0zPq2Oj8llZkmmLJzpHhn
        +9R+SwvA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qs39D-007Ntb-2R;
        Sun, 15 Oct 2023 15:35:19 +0000
Message-ID: <35984b5f-d4f5-4d45-9e17-b41140ff78e0@infradead.org>
Date:   Sun, 15 Oct 2023 08:35:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tiny: print 'struct resource *' correctly
Content-Language: en-US
To:     Yussef Dalton <yussef.dalton@gmail.com>, tzimmermann@suse.de
Cc:     javierm@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231015131100.331880-1-yussef.dalton@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231015131100.331880-1-yussef.dalton@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/23 06:11, Yussef Dalton wrote:
> Since format specifier %pr refers to a 'struct resource *', there is no
> need to take the address of the 'res' variable since it is already of
> type 'struct resource *'.
> 
> Signed-off-by: Yussef Dalton <yussef.dalton@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/gpu/drm/tiny/ofdrm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/ofdrm.c b/drivers/gpu/drm/tiny/ofdrm.c
> index 2d999a0facde..6372ab383747 100644
> --- a/drivers/gpu/drm/tiny/ofdrm.c
> +++ b/drivers/gpu/drm/tiny/ofdrm.c
> @@ -1208,13 +1208,13 @@ static struct ofdrm_device *ofdrm_device_create(struct drm_driver *drv,
>  
>  	ret = devm_aperture_acquire_from_firmware(dev, fb_pgbase, fb_pgsize);
>  	if (ret) {
> -		drm_err(dev, "could not acquire memory range %pr: error %d\n", &res, ret);
> +		drm_err(dev, "could not acquire memory range %pr: error %d\n", res, ret);
>  		return ERR_PTR(ret);
>  	}
>  
>  	mem = devm_request_mem_region(&pdev->dev, fb_pgbase, fb_pgsize, drv->name);
>  	if (!mem) {
> -		drm_warn(dev, "could not acquire memory region %pr\n", &res);
> +		drm_warn(dev, "could not acquire memory region %pr\n", res);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  

-- 
~Randy
