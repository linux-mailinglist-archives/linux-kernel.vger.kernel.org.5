Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3110801E76
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 21:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjLBU0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 15:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjLBU0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 15:26:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EA4134
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 12:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701548773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iZJKmBTJ+Rbbpx8uaCWzSm8u5JZ8h0qLae0DxmI9+YE=;
        b=WjohETuyYMZohx9UabLQRTp7bYywPzrBF8RvrjA3jXGDJf+elacBtY/gIwQ/XR+ptjyW9j
        SU229D01Ma89V2oVgFcg1XW/aUI5XWYMJELLxmc/lYQFVIwofvW6/l+jEjyiV3IXNYTBnh
        b/jXZlNMZsQEpVet18Iyu+kjHieTxq8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-OToki39UOHe87ZofGzoEuA-1; Sat, 02 Dec 2023 15:26:11 -0500
X-MC-Unique: OToki39UOHe87ZofGzoEuA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-333405020f3so199323f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 12:26:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701548770; x=1702153570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZJKmBTJ+Rbbpx8uaCWzSm8u5JZ8h0qLae0DxmI9+YE=;
        b=LqsIMJaexyV5sCnTV9/xLZ/cPOU37xWwQlP7DAKJOk8Iy6RQxxWScEHal84DGpVMay
         kSCr2yxK6gQh0dGuey2zrGjytVUDwdLQRWXxtqAwI1JdRPKF7nLpEksd/T/wptMKf8Nk
         n83NwF6vQ8LzdKWiIs65ePr2R4UQUSAAEbD9IDyZCcyAkjUFQlLQCWGSTxpAkvSw36OW
         qAZztLaNGKdAcSs43sOO+4C8qpKzukhzmP/bT397I8frymhOK0sB+fKL5h6qB8+2oUj7
         +DADbtDodFFN2yfsc5hIYkxUOXzkMOX+1rYTmlekvvL4yxh5o8lz+030skzrkBtgWOa6
         bUCg==
X-Gm-Message-State: AOJu0Yyy1USBM4Ye4FA1t02WQ4F2bKwpSdd3py4mefVfRZ1xrNgGfy5q
        uIdrhYd84je9A4RwNz3ImhdmGevhmV2Lyyb6WWpyxuSuV7c8eb6BtWoo/fVwa+CrjZhNWVOZhha
        GnA88EaPPp+KgFtzWED4IlPyL
X-Received: by 2002:a5d:5485:0:b0:332:d11d:527c with SMTP id h5-20020a5d5485000000b00332d11d527cmr1940787wrv.8.1701548770111;
        Sat, 02 Dec 2023 12:26:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWSenljZ8Gq1p+cvw45tJ66/qyTEFm/51Rm7X9PzXUkLubJG54yM5edqJ1p/+3klDKGwcuJA==
X-Received: by 2002:a5d:5485:0:b0:332:d11d:527c with SMTP id h5-20020a5d5485000000b00332d11d527cmr1940784wrv.8.1701548769779;
        Sat, 02 Dec 2023 12:26:09 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id e5-20020a5d4e85000000b0033333bee379sm4281524wru.107.2023.12.02.12.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 12:26:08 -0800 (PST)
Date:   Sat, 2 Dec 2023 15:26:05 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gal Pressman <galp@nvidia.com>,
        Parav Pandit <parav@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 0/7] vdpa/mlx5: Add support for resumable vqs
Message-ID: <20231202152523-mutt-send-email-mst@kernel.org>
References: <20231201104857.665737-1-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201104857.665737-1-dtatulea@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 12:48:50PM +0200, Dragos Tatulea wrote:
> Add support for resumable vqs in the driver. This is a firmware feature
> that can be used for the following benefits:
> - Full device .suspend/.resume.
> - .set_map doesn't need to destroy and create new vqs anymore just to
>   update the map. When resumable vqs are supported it is enough to
>   suspend the vqs, set the new maps, and then resume the vqs.
> 
> The first patch exposes the relevant bits in mlx5_ifc.h. That means it
> needs to be applied to the mlx5-vhost tree [0] first.

I didn't get this. Why does this need to go through that tree?
Is there a dependency on some other commit from that tree?

> Once applied
> there, the change has to be pulled from mlx5-vhost into the vhost tree
> and only then the remaining patches can be applied. Same flow as the vq
> descriptor mappings patchset [1].
> 
> To be able to use resumable vqs properly, support for selectively modifying
> vq parameters was needed. This is what the middle part of the series
> consists of.
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-vhost
> [1] https://lore.kernel.org/virtualization/20231018171456.1624030-2-dtatulea@nvidia.com/
> 
> Dragos Tatulea (7):
>   vdpa/mlx5: Expose resumable vq capability
>   vdpa/mlx5: Split function into locked and unlocked variants
>   vdpa/mlx5: Allow modifying multiple vq fields in one modify command
>   vdpa/mlx5: Introduce per vq and device resume
>   vdpa/mlx5: Mark vq addrs for modification in hw vq
>   vdpa/mlx5: Mark vq state for modification in hw vq
>   vdpa/mlx5: Use vq suspend/resume during .set_map
> 
>  drivers/vdpa/mlx5/core/mr.c        |  31 +++---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 172 +++++++++++++++++++++++++----
>  include/linux/mlx5/mlx5_ifc.h      |   3 +-
>  include/linux/mlx5/mlx5_ifc_vdpa.h |   4 +
>  4 files changed, 174 insertions(+), 36 deletions(-)
> 
> -- 
> 2.42.0

