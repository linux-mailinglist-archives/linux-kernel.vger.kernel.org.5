Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5C1755FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjGQJpA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 05:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjGQJoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:44:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8077A2D48
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:43:58 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qLKlM-0005SU-Ml; Mon, 17 Jul 2023 11:43:28 +0200
Message-ID: <4f80b175f94eaf386354d1f3425208ca6cf20482.camel@pengutronix.de>
Subject: Re: [PATCH v1 1/8] drm/etnaviv: Using the size_t variable to store
 the number of pages
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
Date:   Mon, 17 Jul 2023 11:43:23 +0200
In-Reply-To: <20230623100822.274706-2-sui.jingfeng@linux.dev>
References: <20230623100822.274706-1-sui.jingfeng@linux.dev>
         <20230623100822.274706-2-sui.jingfeng@linux.dev>
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
> Because the etnaviv_gem_new_private() function receives the size_t argument
> for the number of pages. And the number of pages should be unsigned.
> 
> Note that Most 32-bit architectures use "unsigned int" size_t,
> and all 64-bit architectures use "unsigned long" size_t.
> So, let's keep the argument and parameter consistent.
> 
This explanation doesn't add up. npages is just that: a number of
pages. Why would it make sense to use size_t here?

If you want to be consistent I would have expected this change to
switch things to unsigned int, as you did in the second patch of this
series.

Regards,
Lucas

> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> index 3524b5811682..b003481adc2b 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> @@ -114,7 +114,8 @@ struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
>  {
>  	struct etnaviv_gem_object *etnaviv_obj;
>  	size_t size = PAGE_ALIGN(attach->dmabuf->size);
> -	int ret, npages;
> +	size_t npages = size / PAGE_SIZE;
> +	int ret;
>  
>  	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_WC,
>  				      &etnaviv_gem_prime_ops, &etnaviv_obj);
> @@ -123,8 +124,6 @@ struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
>  
>  	lockdep_set_class(&etnaviv_obj->lock, &etnaviv_prime_lock_class);
>  
> -	npages = size / PAGE_SIZE;
> -
>  	etnaviv_obj->sgt = sgt;
>  	etnaviv_obj->pages = kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
>  	if (!etnaviv_obj->pages) {

