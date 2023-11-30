Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9877FFA02
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346743AbjK3SuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjK3SuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:50:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D07194
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701370226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lCwsLtFmW+kFN1Kj1fiGWPZkFIiqQ/RxZjKKxOIAVpA=;
        b=UaPVv0FNj6HOFP++f6T8ZzSFv2MUtWcfdh6Zu3Knt7wHt3KzaLoiPYwOVHt5UsAPudCoxZ
        tzR1zmwrxj1pBe7tpAc58YJJ0Us7ruw2tINhcMBIFHeXjjVuH/jG3n6gCkge5u8RTEeYv3
        cXtWCfwZC8jdibwyb5lmF1fDsaD9DOI=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-ZgDfb7g0NeqzAmqkN3J2_g-1; Thu, 30 Nov 2023 13:50:25 -0500
X-MC-Unique: ZgDfb7g0NeqzAmqkN3J2_g-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-589ce3eb26cso1385456eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:50:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701370224; x=1701975024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCwsLtFmW+kFN1Kj1fiGWPZkFIiqQ/RxZjKKxOIAVpA=;
        b=sTlraUb32ayXX+ZpD1YMrQafk3m8NqO+WmdnBGx9tOZ6/g8xdNG33nUcJeI/IpHnQF
         m+/8Dv08/xQDRkg4GEnt9MDf8JbZ0+JnQBT8D8ZvVnRssfT8YL0J/V3ueCDCDOwLNMnP
         0Un54QZjdg2eewYNnvmf7ji0cqKKBckWGZI1eLoNxRTAMB/Q6iU087VV8VRmvQqAUpWO
         Kk0jVnOka1jup007JOwXEsgJKqgUgvoGxZ5CmNhzsxhjUt2qRxXTaxxR9a3fgJqD0kmH
         0D7sVj9wlwoMPWxpYKakbtRtHTt3BhuwSIegtQnbierwOpjnIdskMrrj3Lo0HTd9SfFf
         VPYA==
X-Gm-Message-State: AOJu0YyyW46ha2a5qk5vvb0YF0ST0NBir7jwuiqRYjv/GhzqiRdQ24Im
        ccbVW8w7MmxYMJQwq04cq3qLVYiCieUy8VX27qIsrUvXrJpK8fGcVIPaQQl/bjIykuh4j09hs20
        ka2qK4Yy6lGqpJOQSfLs+mnx0
X-Received: by 2002:a05:6870:b49e:b0:1fa:1774:e6df with SMTP id y30-20020a056870b49e00b001fa1774e6dfmr23618821oap.44.1701370224662;
        Thu, 30 Nov 2023 10:50:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG87HrOlypi7PlWvhmEmXj75rwcMMhyA4/AZHcMvyD77iGxKcXs3Mv+FkuQEVXfPdbnMWCH5Q==
X-Received: by 2002:a05:6870:b49e:b0:1fa:1774:e6df with SMTP id y30-20020a056870b49e00b001fa1774e6dfmr23618810oap.44.1701370224457;
        Thu, 30 Nov 2023 10:50:24 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id sf11-20020a056871230b00b001fa592385b9sm385063oab.40.2023.11.30.10.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 10:50:23 -0800 (PST)
Date:   Thu, 30 Nov 2023 11:50:22 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] vfio: Drop vfio_file_iommu_group() stub to fudge around
 a KVM wart
Message-ID: <20231130115022.010ec041.alex.williamson@redhat.com>
In-Reply-To: <20231130001000.543240-1-seanjc@google.com>
References: <20231130001000.543240-1-seanjc@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 16:10:00 -0800
Sean Christopherson <seanjc@google.com> wrote:

> Drop the vfio_file_iommu_group() stub and instead unconditionally declare
> the function to fudge around a KVM wart where KVM tries to do symbol_get()
> on vfio_file_iommu_group() (and other VFIO symbols) even if CONFIG_VFIO=n.
> 
> Ensuring the symbol is always declared fixes a PPC build error when
> modules are also disabled, in which case symbol_get() simply points at the
> address of the symbol (with some attributes shenanigans).  Because KVM
> does symbol_get() instead of directly depending on VFIO, the lack of a
> fully defined symbol is not problematic (ugly, but "fine").
> 
>    arch/powerpc/kvm/../../../virt/kvm/vfio.c:89:7:
>    error: attribute declaration must precede definition [-Werror,-Wignored-attributes]
>            fn = symbol_get(vfio_file_iommu_group);
>                 ^
>    include/linux/module.h:805:60: note: expanded from macro 'symbol_get'
>    #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak,visibility("hidden"))); &(x); })
>                                                               ^
>    include/linux/vfio.h:294:35: note: previous definition is here
>    static inline struct iommu_group *vfio_file_iommu_group(struct file *file)
>                                      ^
>    arch/powerpc/kvm/../../../virt/kvm/vfio.c:89:7:
>    error: attribute declaration must precede definition [-Werror,-Wignored-attributes]
>            fn = symbol_get(vfio_file_iommu_group);
>                 ^
>    include/linux/module.h:805:65: note: expanded from macro 'symbol_get'
>    #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak,visibility("hidden"))); &(x); })
>                                                                    ^
>    include/linux/vfio.h:294:35: note: previous definition is here
>    static inline struct iommu_group *vfio_file_iommu_group(struct file *file)
>                                      ^
>    2 errors generated.
> 
> Although KVM is firmly in the wrong (there is zero reason for KVM to build
> virt/kvm/vfio.c when VFIO is disabled), fudge around the error in VFIO as
> the stub is unnecessary and doesn't serve its intended purpose (KVM is the
> only external user of vfio_file_iommu_group()), and there is an in-flight
> series to clean up the entire KVM<->VFIO interaction, i.e. fixing this in
> KVM would result in more churn in the long run, and the stub needs to go
> away regardless.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308251949.5IiaV0sz-lkp@intel.com
> Closes: https://lore.kernel.org/oe-kbuild-all/202309030741.82aLACDG-lkp@intel.com
> Closes: https://lore.kernel.org/oe-kbuild-all/202309110914.QLH0LU6L-lkp@intel.com
> Link: https://lore.kernel.org/all/0-v1-08396538817d+13c5-vfio_kvm_kconfig_jgg@nvidia.com
> Link: https://lore.kernel.org/all/20230916003118.2540661-1-seanjc@google.com
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Michael Ellerman <mpe@ellerman.id.au>
> Fixes: c1cce6d079b8 ("vfio: Compile vfio_group infrastructure optionally")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  include/linux/vfio.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 454e9295970c..a65b2513f8cd 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -289,16 +289,12 @@ void vfio_combine_iova_ranges(struct rb_root_cached *root, u32 cur_nodes,
>  /*
>   * External user API
>   */
> -#if IS_ENABLED(CONFIG_VFIO_GROUP)
>  struct iommu_group *vfio_file_iommu_group(struct file *file);
> +
> +#if IS_ENABLED(CONFIG_VFIO_GROUP)
>  bool vfio_file_is_group(struct file *file);
>  bool vfio_file_has_dev(struct file *file, struct vfio_device *device);
>  #else
> -static inline struct iommu_group *vfio_file_iommu_group(struct file *file)
> -{
> -	return NULL;
> -}
> -
>  static inline bool vfio_file_is_group(struct file *file)
>  {
>  	return false;
> 
> base-commit: ae2667cd8a479bb5abd6e24c12fcc9ef5bc06d75

I think we've squashed all the outstanding concerns in the other
thread, so I've pushed this to my for-linux branch for v6.7.  Speak up
if I'm missing any unresolved issues.  Thanks!

Alex

