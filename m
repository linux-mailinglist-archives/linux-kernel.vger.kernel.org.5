Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F75802E2A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjLDIzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjLDIzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:55:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4974CCD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701680114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0AN6JCFDsnCGduiL8fNvKVYamhB7M2dQghKbiuZenRQ=;
        b=hKttobFFBexPdGcwBKlWGWQijl4smwvSFj/zv1+j1plYUDtWT50gsRLwitqfemyXgK/44o
        G2a6QDzfR9Nfj+HI0LZeRfAk+cMX4jdRyCp0fPPpjQFqwnwnFnAMu7sog9ZnEvREmpCtxW
        hiXRaqeOv9maH4a1Bkm/Zhe3WMq6CO4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515--Xu5OZOBMtK0IV56aSUi-w-1; Mon, 04 Dec 2023 03:55:13 -0500
X-MC-Unique: -Xu5OZOBMtK0IV56aSUi-w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33344663fbcso905918f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 00:55:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701680112; x=1702284912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AN6JCFDsnCGduiL8fNvKVYamhB7M2dQghKbiuZenRQ=;
        b=khCV1cSjxgdfAyqhLcl/XcA+Qmn0OlVXb4B6BGb/HBxVd6yOYaADwyTEhMqw+7D1kq
         m/13n+wEpKmuZNxfRvHnZI6JNPjlw/qhHo66oTLkp5wXu7wXngWVYbGEiKTz6iQ/N7vx
         zFfEHjG28Ov+766HlktGulojV4VkZv4fRQO0IIrBOOThSguVc3uAGlR3Ai1cudcvseDX
         9weE8X4igaOKj3NgsAmJPPeyn1VQaTwZFJc8q2Nr2SsgoIFTzyHIIjk2ZRtYg17KmEr/
         f8I6ntmS6YEk6JukZPcgjitAWXNZEuOiTCQa87R5GQXjcNy1l+XTBmLpFFqzmZ6xXHI3
         Rbcw==
X-Gm-Message-State: AOJu0Yy7f252Hzir7WQa2ogj7OSc1crsmXh2SzR676DyjJ8/gQ2GVYtB
        9sQYwKEWgy9PgiwQADwg0CO+DGaQRlS8+W23u2ioj5rmHUNbOlJqsS4JuHoQOehOkqKjAAdJLuL
        2KNbIYYq4xhU6spKyhVrnW6lr
X-Received: by 2002:adf:fe03:0:b0:333:2fd2:765e with SMTP id n3-20020adffe03000000b003332fd2765emr1292014wrr.79.1701680112062;
        Mon, 04 Dec 2023 00:55:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6o767vIbm8ZsJXOcZvJBzFh+btgTQgB0JYi5+5AiuODwwmWvCd5ESmGDV8zXhTYkKs+bnzA==
X-Received: by 2002:adf:fe03:0:b0:333:2fd2:765e with SMTP id n3-20020adffe03000000b003332fd2765emr1292008wrr.79.1701680111648;
        Mon, 04 Dec 2023 00:55:11 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600010cc00b0033340aa3de2sm4299066wrx.14.2023.12.04.00.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 00:55:11 -0800 (PST)
Date:   Mon, 4 Dec 2023 03:55:07 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
        Parav Pandit <parav@nvidia.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "galp@nvidia.com" <galp@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH vhost 0/7] vdpa/mlx5: Add support for resumable vqs
Message-ID: <20231204035443-mutt-send-email-mst@kernel.org>
References: <20231201104857.665737-1-dtatulea@nvidia.com>
 <20231202152523-mutt-send-email-mst@kernel.org>
 <aff0361edcb0fd0c384bf297e71d25fb77570e15.camel@nvidia.com>
 <20231203112324-mutt-send-email-mst@kernel.org>
 <e088b2ac7a197352429d2f5382848907f98c1129.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e088b2ac7a197352429d2f5382848907f98c1129.camel@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 08:53:26AM +0000, Dragos Tatulea wrote:
> On Sun, 2023-12-03 at 11:23 -0500, Michael S. Tsirkin wrote:
> > On Sun, Dec 03, 2023 at 03:21:01PM +0000, Dragos Tatulea wrote:
> > > On Sat, 2023-12-02 at 15:26 -0500, Michael S. Tsirkin wrote:
> > > > On Fri, Dec 01, 2023 at 12:48:50PM +0200, Dragos Tatulea wrote:
> > > > > Add support for resumable vqs in the driver. This is a firmware feature
> > > > > that can be used for the following benefits:
> > > > > - Full device .suspend/.resume.
> > > > > - .set_map doesn't need to destroy and create new vqs anymore just to
> > > > >   update the map. When resumable vqs are supported it is enough to
> > > > >   suspend the vqs, set the new maps, and then resume the vqs.
> > > > > 
> > > > > The first patch exposes the relevant bits in mlx5_ifc.h. That means it
> > > > > needs to be applied to the mlx5-vhost tree [0] first.
> > > > 
> > > > I didn't get this. Why does this need to go through that tree?
> > > > Is there a dependency on some other commit from that tree?
> > > > 
> > > To avoid merge issues in Linus's tree in mlx5_ifc.h. The idea is the same as for
> > > the "vq descriptor mappings" patchset [1].
> > > 
> > > Thanks,
> > > Dragos
> > 
> > Are there other changes in that area that will cause non-trivial merge
> > conflicts?
> > 
> There are pending changes in mlx5_ifc.h for net-next. I haven't seen any changes
> around the touched structure but I would prefer not to take any risk.
> 
> Thanks,
> Dragos

This is exactly what linux-next is for.


> > > > > Once applied
> > > > > there, the change has to be pulled from mlx5-vhost into the vhost tree
> > > > > and only then the remaining patches can be applied. Same flow as the vq
> > > > > descriptor mappings patchset [1].
> > > > > 
> > > > > To be able to use resumable vqs properly, support for selectively modifying
> > > > > vq parameters was needed. This is what the middle part of the series
> > > > > consists of.
> > > > > 
> > > > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-vhost
> > > > > [1] https://lore.kernel.org/virtualization/20231018171456.1624030-2-dtatulea@nvidia.com/
> > > > > 
> > > > > Dragos Tatulea (7):
> > > > >   vdpa/mlx5: Expose resumable vq capability
> > > > >   vdpa/mlx5: Split function into locked and unlocked variants
> > > > >   vdpa/mlx5: Allow modifying multiple vq fields in one modify command
> > > > >   vdpa/mlx5: Introduce per vq and device resume
> > > > >   vdpa/mlx5: Mark vq addrs for modification in hw vq
> > > > >   vdpa/mlx5: Mark vq state for modification in hw vq
> > > > >   vdpa/mlx5: Use vq suspend/resume during .set_map
> > > > > 
> > > > >  drivers/vdpa/mlx5/core/mr.c        |  31 +++---
> > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 172 +++++++++++++++++++++++++----
> > > > >  include/linux/mlx5/mlx5_ifc.h      |   3 +-
> > > > >  include/linux/mlx5/mlx5_ifc_vdpa.h |   4 +
> > > > >  4 files changed, 174 insertions(+), 36 deletions(-)
> > > > > 
> > > > > -- 
> > > > > 2.42.0
> > > > 
> > > 
> > 
> 

