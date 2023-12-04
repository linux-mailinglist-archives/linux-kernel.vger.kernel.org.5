Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF5080313C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjLDLEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjLDLEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:04:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680A6CD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701687891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aT/At2upGCT9VPho4S8jj9YWkQ5O4LoKTBPlC60T3Pg=;
        b=FQbEXrt4SA5Wv0/IkoT6jBTexCnH9//44VqJ3SXCF661VPpiSMoO2gj3kU7gflfT8p2lx5
        cHtjJdzybJy7X4YCJPlYrxo0hrasM328Bw/EdS+bcPPZ+qsVQ+yI+bJQPnIUmv61f7bopA
        ObkxWTawfMI4GoSBwYsISRGFbVxDJng=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-cpVTNXVMOGiah9MKQAv9jA-1; Mon, 04 Dec 2023 06:04:48 -0500
X-MC-Unique: cpVTNXVMOGiah9MKQAv9jA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b3d4d6417so29577225e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 03:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701687887; x=1702292687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aT/At2upGCT9VPho4S8jj9YWkQ5O4LoKTBPlC60T3Pg=;
        b=V54Tbxh75z6S0uFFLfaDkfyrpHunvtL1I7mZoBXUcvIO7HHsshuOpMD29mNMeqFAkl
         gs8/WzHhkI8dIcJHV3WjiEJE15rMP1/Dxy3Qm8pVaLIyYSPjGPM7iFpbzTf5jL2X5x8r
         SzKMq9Hy5kViV+Wx1fOfGB6b85pHWF4Wh/Y1dI8CDuP6eIzkrqzIswN7Pf/JS4Xqausc
         uHPGErQdd21eSVKCT0oZzTTcZj3VVFbkNg2H5jnlj18nq3pWzRBlCaW9uH1xgy+FrI3N
         n00D5/8W/v1eg138Zjj6yKVVc9WiKJLiGRPmIdbFkNh0Hm/kF3oU6QALH/meZd4MkM8t
         5VXw==
X-Gm-Message-State: AOJu0YzVQIrPwIzYjXeadp13hF3CABtnhHx0vfs74+VToI1xjDfYa2Mv
        /Uc1jpXfePytaHycwPeRcMxusbuDDwk6IL8Mv8949Q8KgQiy1AbztpUi0jrXNQAdLSzF/pxD86M
        4ZsAHeI64qmSFjbTUzWKulL92
X-Received: by 2002:a7b:ce8d:0:b0:40c:b81:d31e with SMTP id q13-20020a7bce8d000000b0040c0b81d31emr342743wmj.148.1701687887339;
        Mon, 04 Dec 2023 03:04:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFihxBxPdB2ys3q394rHHxaK//1lPggGSVUB+ncquBCZ170Lw3mhpOTy808C1BWlo7xnT0FBw==
X-Received: by 2002:a7b:ce8d:0:b0:40c:b81:d31e with SMTP id q13-20020a7bce8d000000b0040c0b81d31emr342733wmj.148.1701687886974;
        Mon, 04 Dec 2023 03:04:46 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c155100b004083729fc14sm18256693wmg.20.2023.12.04.03.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 03:04:46 -0800 (PST)
Date:   Mon, 4 Dec 2023 06:04:42 -0500
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
Message-ID: <20231204060300-mutt-send-email-mst@kernel.org>
References: <20231201104857.665737-1-dtatulea@nvidia.com>
 <20231202152523-mutt-send-email-mst@kernel.org>
 <aff0361edcb0fd0c384bf297e71d25fb77570e15.camel@nvidia.com>
 <20231203112324-mutt-send-email-mst@kernel.org>
 <e088b2ac7a197352429d2f5382848907f98c1129.camel@nvidia.com>
 <20231204035443-mutt-send-email-mst@kernel.org>
 <b9f5c48788daa3ac335b589b2ad23ea8366c08ba.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9f5c48788daa3ac335b589b2ad23ea8366c08ba.camel@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 09:16:07AM +0000, Dragos Tatulea wrote:
> On Mon, 2023-12-04 at 03:55 -0500, Michael S. Tsirkin wrote:
> > On Mon, Dec 04, 2023 at 08:53:26AM +0000, Dragos Tatulea wrote:
> > > On Sun, 2023-12-03 at 11:23 -0500, Michael S. Tsirkin wrote:
> > > > On Sun, Dec 03, 2023 at 03:21:01PM +0000, Dragos Tatulea wrote:
> > > > > On Sat, 2023-12-02 at 15:26 -0500, Michael S. Tsirkin wrote:
> > > > > > On Fri, Dec 01, 2023 at 12:48:50PM +0200, Dragos Tatulea wrote:
> > > > > > > Add support for resumable vqs in the driver. This is a firmware feature
> > > > > > > that can be used for the following benefits:
> > > > > > > - Full device .suspend/.resume.
> > > > > > > - .set_map doesn't need to destroy and create new vqs anymore just to
> > > > > > >   update the map. When resumable vqs are supported it is enough to
> > > > > > >   suspend the vqs, set the new maps, and then resume the vqs.
> > > > > > > 
> > > > > > > The first patch exposes the relevant bits in mlx5_ifc.h. That means it
> > > > > > > needs to be applied to the mlx5-vhost tree [0] first.
> > > > > > 
> > > > > > I didn't get this. Why does this need to go through that tree?
> > > > > > Is there a dependency on some other commit from that tree?
> > > > > > 
> > > > > To avoid merge issues in Linus's tree in mlx5_ifc.h. The idea is the same as for
> > > > > the "vq descriptor mappings" patchset [1].
> > > > > 
> > > > > Thanks,
> > > > > Dragos
> > > > 
> > > > Are there other changes in that area that will cause non-trivial merge
> > > > conflicts?
> > > > 
> > > There are pending changes in mlx5_ifc.h for net-next. I haven't seen any changes
> > > around the touched structure but I would prefer not to take any risk.
> > > 
> > > Thanks,
> > > Dragos
> > 
> > This is exactly what linux-next is for.
> > 
> Not sure what the suggestion is here. Is it:
> 
> 1) To post patch 1/7 to net-next? Then we'd have to wait for a few weeks to make
> sure that it gets into the next tree.
> 
> or 
> 
> 2) To apply it into the vhost tree directly? Then we run the risk of having
> merge issues.
> 
> The "pull from branch" approach for cross subsystem changes was suggested by
> Linus this merge issue.
> 
> [0]
> https://lore.kernel.org/all/CA+55aFxxoO=i7neGBRGW_afHsSZ7K-x6fMO8v-8po3Ls_Ew0Rg@mail.gmail.com/
> 
> Thanks,
> Dragos

I will park this in my tree for now so it can get testing in linux next.
When it's available in some other tree as well, let me know and
I'll figure it out.

-- 
MST

