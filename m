Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92FD7CBCE2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjJQHzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjJQHz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:55:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C724B93
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697529282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9Tx6gsKNLBlsQavHNGdhteUF9QO0P3cguwO27i3pv8=;
        b=ZVGrDfoORoRPMKwRVp+3ffoyIn2W8DMg7G4i3oB7uHphTcmg+dwpx+RQCfPEooa+wEzcPW
        KfXbQ8hQ5w4bbIQFq/f97COdFwKb2VQbq13UhATyf/+g0qaNY6Exhp3Bo8JRb/WmE1oak8
        +fNC2Tmec9HwPNq9wwYXYswuDuVZkMU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-5cjqbG33OeytMbk_rtEzMw-1; Tue, 17 Oct 2023 03:54:40 -0400
X-MC-Unique: 5cjqbG33OeytMbk_rtEzMw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50796a5bbecso4448294e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697529278; x=1698134078;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9Tx6gsKNLBlsQavHNGdhteUF9QO0P3cguwO27i3pv8=;
        b=B0DHw81ZNydNnzh3uwaverWzssp+piuJRzeIHWTj4yQfbCMcYhnWU8Ft8to2tRMFjJ
         Xk7yCkMptWfD2BNkp67h3fa0u2Pt4fvN5x8HkuYFRD4qteKg9LxcpjZdfuCQQT6ZC46K
         1+AT+ZccqYNea13OKxDD55jJp4+QLURyc+kxj+ao0WQu3MSUJoK7B07WMbrb77rW74jp
         QFxdoF0S9gPofDQ52SJRq1eseRkU3q92+uHECRW0+rD6/yNZ0HEyAoKxerb8POklLiK5
         0Q6bQK+t0A4vzDq1SNbJpTIwi8bFELC8+PC/reMCfLDP9o6UIqjaYSFf/fvJKObFKlpK
         Jk/g==
X-Gm-Message-State: AOJu0YwaGrAu8/ZtWmieWhOPxNO+mn9p2O83rwULzvG696lXTTr436cJ
        RhSuol8fdT25p3pdFwaZ5V1l07udMXUoYfWtKpsXn/KvClH0NB3BTODZvfnOqQLQBLD4+roZNPP
        lsQREElHrtd8SvJsh1gvcH5vg
X-Received: by 2002:ac2:528a:0:b0:500:75e5:a2f0 with SMTP id q10-20020ac2528a000000b0050075e5a2f0mr1170035lfm.51.1697529278759;
        Tue, 17 Oct 2023 00:54:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnj+02Gz6CBN/FvIxOvYBZmLKxkQG31upVGnOZzsxW/NOKskPJB/h4jHjz/vk7FZYVE3xDeQ==
X-Received: by 2002:ac2:528a:0:b0:500:75e5:a2f0 with SMTP id q10-20020ac2528a000000b0050075e5a2f0mr1169938lfm.51.1697529275395;
        Tue, 17 Oct 2023 00:54:35 -0700 (PDT)
Received: from polis (198.red-81-39-42.dynamicip.rima-tde.net. [81.39.42.198])
        by smtp.gmail.com with ESMTPSA id o22-20020a5d58d6000000b0031980783d78sm1064892wrf.54.2023.10.17.00.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 00:54:34 -0700 (PDT)
Date:   Tue, 17 Oct 2023 09:54:32 +0200
From:   Danilo Krummrich <dakr@redhat.com>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
Cc:     intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        airlied@gmail.com, daniel@ffwll.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/gpuvm: Dual-licence the drm_gpuvm code GPL-2.0 OR MIT
Message-ID: <ZS49uJq9kqJ2ueOv@polis>
References: <20231010142725.8920-1-thomas.hellstrom@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231010142725.8920-1-thomas.hellstrom@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 04:27:24PM +0200, Thomas Hellström wrote:
> Dual-licence in order to make it possible for other non-GPL os'es
> to re-implement the code. The use of EXPORT_SYMBOL_GPL() is intentionally
> left untouched to prevent use of drm_gpuvm as a proxy for non-GPL drivers
> to access GPL-only kernel symbols.
> 
> Much of the ideas and algorithms used in the drm_gpuvm code is already
> present in one way or another in MIT-licensed code.
> 
> Cc: Danilo Krummrich <dakr@redhat.com>
> Cc: airlied@gmail.com
> Cc: daniel@ffwll.ch
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Acked-by: Danilo Krummrich <dakr@redhat.com>

> ---
>  drivers/gpu/drm/drm_gpuvm.c | 2 +-
>  include/drm/drm_gpuvm.h     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> index 02ce6baacdad..08c088319652 100644
> --- a/drivers/gpu/drm/drm_gpuvm.c
> +++ b/drivers/gpu/drm/drm_gpuvm.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>  /*
>   * Copyright (c) 2022 Red Hat.
>   *
> diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
> index 361fea5cb849..21bbf11415b3 100644
> --- a/include/drm/drm_gpuvm.h
> +++ b/include/drm/drm_gpuvm.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
>  
>  #ifndef __DRM_GPUVM_H__
>  #define __DRM_GPUVM_H__
> -- 
> 2.41.0
> 

