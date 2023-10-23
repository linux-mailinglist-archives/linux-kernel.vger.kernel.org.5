Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00997D41C3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjJWVeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjJWVeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148B797
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698096818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZd41yISFX+lUiY07tb7vMQ/0JXmB7Nfc8wsR9vS8jk=;
        b=bKmyHSq8nT1IOkwwd0Q7wi4id2egAmmtCaEbtawe94jkCR4YtKt46KMLqCCTBwuxrgDc0E
        nGhCbUj6Tb7D+D1/1HQ+bnkXnpdNQgRRIuJXkuxzO6oscIWitlrDZzpzqgrjTyLKBdl93f
        RGplt1JFzO3Phrs8yx3sd/TMfLYBUAs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-xHrN-mbkPUaYH2zCDiFL-g-1; Mon, 23 Oct 2023 17:33:26 -0400
X-MC-Unique: xHrN-mbkPUaYH2zCDiFL-g-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507d4583c4cso3754973e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698096805; x=1698701605;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZd41yISFX+lUiY07tb7vMQ/0JXmB7Nfc8wsR9vS8jk=;
        b=EDNRmzE+ax+UQoXEEQ4wRp94tUfZ5aDVsDqeVWMj4jmmKpKB/A+tZ/8ndhEvbP5hIn
         2ku4iZooFzs1JRBFgipE7LjruwwLAEE32KTyPXKp5yr873ux/eicCBc3Q1IFYta8bZRN
         JpAZ1vJxAy0IddHdotMl0U90Ee9mOH0Sre/KqzfX1UEhMrLAlgaGzMPadHsVjLpIHf3i
         xBenMMZTGOftypAkW1BrVLJv9wt4Teg/7yUPLR52kjJsRRVTKwxJFmMo30A99RuDAiz/
         hK3sYeo8Fr+jpaXD1wK34ApQECMAlpxQkBN/mH8T7EXJO7dKHcs8HROsevMUUc60YjWa
         F2fw==
X-Gm-Message-State: AOJu0YzdRdAd1vGy4bUWmh7hh9ieyEph9ZuedbI7v4V3fOmRR7l2rvCM
        4Xz6JPTron+LwNBnENeLEyJMhHv30N8z7927pLQr8ZVSdTwsQ2W04LAf5tOTXskZ0E6T/I4jmgV
        DsBn5shvr3fUfFYumGEyV8FXw
X-Received: by 2002:a05:6512:15a4:b0:507:cd2e:5ed8 with SMTP id bp36-20020a05651215a400b00507cd2e5ed8mr10456962lfb.0.1698096805505;
        Mon, 23 Oct 2023 14:33:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGapk6NB4CB9u2pR9vlBZU5cSNx5G9AEjsi+1y4yDuwAgj/D1sdJd9L5nHhS4ooH0bpm4vvyw==
X-Received: by 2002:a05:6512:15a4:b0:507:cd2e:5ed8 with SMTP id bp36-20020a05651215a400b00507cd2e5ed8mr10456947lfb.0.1698096805187;
        Mon, 23 Oct 2023 14:33:25 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id hb13-20020a170906b88d00b009c46445fcc7sm7255536ejb.33.2023.10.23.14.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 14:33:24 -0700 (PDT)
Message-ID: <c358dbdb-1592-4808-90e8-26290ccb21c2@redhat.com>
Date:   Mon, 23 Oct 2023 23:33:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Nouveau] [PATCH] drm/nouveau: Fixing indentation and adding
 License Identifier tag
Content-Language: en-US
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc:     nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20231008172751.21953-1-bragathemanick0908@gmail.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20231008172751.21953-1-bragathemanick0908@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/23 19:27, Bragatheswaran Manickavel wrote:
> On running checkpatch.pl to nouveau_drm.h identified
> few warnings. Fixing them in this patch
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> +/*
> 
> WARNING: space prohibited between function name and open parenthesis '('
> +#define DRM_IOCTL_NOUVEAU_CHANNEL_FREE       DRM_IOW (DRM_COMMAND_BASE +
> DRM_NOUVEAU_CHANNEL_FREE, struct drm_nouveau_channel_free)

Even though this fixes a checkpatch warning, I don't see how this change
improves readability, rather the opposite. Personally, I prefer keeping this
as it is.

- Danilo

> 
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>   include/uapi/drm/nouveau_drm.h | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
> index 8d7402c13e56..900ca4f1ebe5 100644
> --- a/include/uapi/drm/nouveau_drm.h
> +++ b/include/uapi/drm/nouveau_drm.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: MIT */
>   /*
>    * Copyright 2005 Stephane Marchesin.
>    * All Rights Reserved.
> @@ -448,15 +449,15 @@ struct drm_nouveau_svm_bind {
>   
>   #define DRM_IOCTL_NOUVEAU_GETPARAM           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GETPARAM, struct drm_nouveau_getparam)
>   #define DRM_IOCTL_NOUVEAU_CHANNEL_ALLOC      DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_CHANNEL_ALLOC, struct drm_nouveau_channel_alloc)
> -#define DRM_IOCTL_NOUVEAU_CHANNEL_FREE       DRM_IOW (DRM_COMMAND_BASE + DRM_NOUVEAU_CHANNEL_FREE, struct drm_nouveau_channel_free)
> +#define DRM_IOCTL_NOUVEAU_CHANNEL_FREE       DRM_IOW(DRM_COMMAND_BASE + DRM_NOUVEAU_CHANNEL_FREE, struct drm_nouveau_channel_free)
>   
>   #define DRM_IOCTL_NOUVEAU_SVM_INIT           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_SVM_INIT, struct drm_nouveau_svm_init)
>   #define DRM_IOCTL_NOUVEAU_SVM_BIND           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_SVM_BIND, struct drm_nouveau_svm_bind)
>   
>   #define DRM_IOCTL_NOUVEAU_GEM_NEW            DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_NEW, struct drm_nouveau_gem_new)
>   #define DRM_IOCTL_NOUVEAU_GEM_PUSHBUF        DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_PUSHBUF, struct drm_nouveau_gem_pushbuf)
> -#define DRM_IOCTL_NOUVEAU_GEM_CPU_PREP       DRM_IOW (DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_CPU_PREP, struct drm_nouveau_gem_cpu_prep)
> -#define DRM_IOCTL_NOUVEAU_GEM_CPU_FINI       DRM_IOW (DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_CPU_FINI, struct drm_nouveau_gem_cpu_fini)
> +#define DRM_IOCTL_NOUVEAU_GEM_CPU_PREP       DRM_IOW(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_CPU_PREP, struct drm_nouveau_gem_cpu_prep)
> +#define DRM_IOCTL_NOUVEAU_GEM_CPU_FINI       DRM_IOW(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_CPU_FINI, struct drm_nouveau_gem_cpu_fini)
>   #define DRM_IOCTL_NOUVEAU_GEM_INFO           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_INFO, struct drm_nouveau_gem_info)
>   
>   #define DRM_IOCTL_NOUVEAU_VM_INIT            DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_VM_INIT, struct drm_nouveau_vm_init)

