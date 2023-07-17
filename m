Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4736F755FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjGQJvd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 05:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjGQJva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:51:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE333E56
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:51:28 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qLKsw-0006l0-7n; Mon, 17 Jul 2023 11:51:18 +0200
Message-ID: <862358e67a6f118b11ba16fb94828e9d1635cb66.camel@pengutronix.de>
Subject: Re: [PATCH v1 3/8] drm/etnaviv: Drop the second argument of the
 etnaviv_gem_new_impl()
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Sui Jingfeng <sui.jingfeng@linux.dev>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     loongson-kernel@lists.loongnix.cn,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 17 Jul 2023 11:51:16 +0200
In-Reply-To: <20230623100822.274706-4-sui.jingfeng@linux.dev>
References: <20230623100822.274706-1-sui.jingfeng@linux.dev>
         <20230623100822.274706-4-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jingfeng,

Am Freitag, dem 23.06.2023 um 18:08 +0800 schrieb Sui Jingfeng:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> Because it is not used by the etnaviv_gem_new_impl() function,
> no functional change.
> 
I think it would make sense to move into the opposite direction: in
both callsites of etnaviv_gem_new_impl we immediately call
drm_gem_object_init with the size. A better cleanup would be to make
use of the size parameter and move this object init call into
etnaviv_gem_new_impl.

Regards,
Lucas

> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index b5f73502e3dd..be2f459c66b5 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -542,7 +542,7 @@ static const struct drm_gem_object_funcs etnaviv_gem_object_funcs = {
>  	.vm_ops = &vm_ops,
>  };
>  
> -static int etnaviv_gem_new_impl(struct drm_device *dev, u32 size, u32 flags,
> +static int etnaviv_gem_new_impl(struct drm_device *dev, u32 flags,
>  	const struct etnaviv_gem_ops *ops, struct drm_gem_object **obj)
>  {
>  	struct etnaviv_gem_object *etnaviv_obj;
> @@ -591,8 +591,7 @@ int etnaviv_gem_new_handle(struct drm_device *dev, struct drm_file *file,
>  
>  	size = PAGE_ALIGN(size);
>  
> -	ret = etnaviv_gem_new_impl(dev, size, flags,
> -				   &etnaviv_gem_shmem_ops, &obj);
> +	ret = etnaviv_gem_new_impl(dev, flags, &etnaviv_gem_shmem_ops, &obj);
>  	if (ret)
>  		goto fail;
>  
> @@ -627,7 +626,7 @@ int etnaviv_gem_new_private(struct drm_device *dev, size_t size, u32 flags,
>  	struct drm_gem_object *obj;
>  	int ret;
>  
> -	ret = etnaviv_gem_new_impl(dev, size, flags, ops, &obj);
> +	ret = etnaviv_gem_new_impl(dev, flags, ops, &obj);
>  	if (ret)
>  		return ret;
>  

