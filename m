Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBD9760C74
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjGYHxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjGYHxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:53:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7E4E0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:53:07 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BCBAE6602329;
        Tue, 25 Jul 2023 08:53:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690271586;
        bh=zjDdOFC9a1xT+iucTQPYYWPpLRkpkkaJ/SZ1lyENylU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A5RF9fvuErLTTvbPfKhQvA4Hyyh6T7cSpgCDd1LSttaXS1+zKyeE/EdBcrPV1NeG2
         Z44sXJRI/ITzfx42VkryHJN1NV70oos2eRxd0ENr1QT5fKNLqUQUYvNCoGpW7VgX6r
         c+fCgy1Myi1ALYgq9563g+WhzpVaeAbR8yDD9aV8958g1aBi7p6e1cRLnwyUohmhU4
         mdtvTUjZASe68U7AuXMKB+NuO2shG+u1+GOAo1dUblr3ehIDu+nMk9nP7nFOeWQlg5
         alymvlFCeOQZcLTvAjgCBAbFvQB0swt+U1uc5apucwQz2eb/0h517UGrsR+YSb8tte
         UuBCB+OFmonmg==
Date:   Tue, 25 Jul 2023 09:53:03 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v14 12/12] drm/gem: Add _unlocked postfix to
 drm_gem_pin/unpin()
Message-ID: <20230725095303.07611834@collabora.com>
In-Reply-To: <20230722234746.205949-13-dmitry.osipenko@collabora.com>
References: <20230722234746.205949-1-dmitry.osipenko@collabora.com>
        <20230722234746.205949-13-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jul 2023 02:47:46 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Make clear that drm_gem_pin/unpin() functions take reservation lock by
> adding _unlocked postfix to the function names.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

I'm still a bit confused by the fact we sometimes use the
xxx[_locked]() pattern (version without the _locked suffix takes the
lock) and other times the xxx[_unlocked]() pattern (version with the
_unlocked suffix takes the lock). It'd be good to chose one pattern and
stick to it, at least for all core functions...

> ---
>  drivers/gpu/drm/drm_gem.c      | 4 ++--
>  drivers/gpu/drm/drm_internal.h | 4 ++--
>  drivers/gpu/drm/drm_prime.c    | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index c18686f434d4..805eb0d85297 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1146,7 +1146,7 @@ void drm_gem_print_info(struct drm_printer *p, unsigned int indent,
>  		obj->funcs->print_info(p, indent, obj);
>  }
>  
> -int drm_gem_pin(struct drm_gem_object *obj)
> +int drm_gem_pin_unlocked(struct drm_gem_object *obj)
>  {
>  	if (obj->funcs->pin)
>  		return obj->funcs->pin(obj);
> @@ -1154,7 +1154,7 @@ int drm_gem_pin(struct drm_gem_object *obj)
>  	return 0;
>  }
>  
> -void drm_gem_unpin(struct drm_gem_object *obj)
> +void drm_gem_unpin_unlocked(struct drm_gem_object *obj)
>  {
>  	if (obj->funcs->unpin)
>  		obj->funcs->unpin(obj);
> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> index d7e023bbb0d5..80f5bd1da8fd 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -173,8 +173,8 @@ void drm_gem_release(struct drm_device *dev, struct drm_file *file_private);
>  void drm_gem_print_info(struct drm_printer *p, unsigned int indent,
>  			const struct drm_gem_object *obj);
>  
> -int drm_gem_pin(struct drm_gem_object *obj);
> -void drm_gem_unpin(struct drm_gem_object *obj);
> +int drm_gem_pin_unlocked(struct drm_gem_object *obj);
> +void drm_gem_unpin_unlocked(struct drm_gem_object *obj);
>  int drm_gem_vmap(struct drm_gem_object *obj, struct iosys_map *map);
>  void drm_gem_vunmap(struct drm_gem_object *obj, struct iosys_map *map);
>  
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 63b709a67471..8145b49e95ff 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -583,7 +583,7 @@ int drm_gem_map_attach(struct dma_buf *dma_buf,
>  	if (!obj->funcs->get_sg_table)
>  		return -ENOSYS;
>  
> -	return drm_gem_pin(obj);
> +	return drm_gem_pin_unlocked(obj);
>  }
>  EXPORT_SYMBOL(drm_gem_map_attach);
>  
> @@ -601,7 +601,7 @@ void drm_gem_map_detach(struct dma_buf *dma_buf,
>  {
>  	struct drm_gem_object *obj = dma_buf->priv;
>  
> -	drm_gem_unpin(obj);
> +	drm_gem_unpin_unlocked(obj);
>  }
>  EXPORT_SYMBOL(drm_gem_map_detach);
>  

