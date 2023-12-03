Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E44802563
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 17:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjLCQXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 11:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjLCQXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 11:23:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB22B0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 08:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701620638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lnZvOG5O1XML8m5bdEgP0BLaNE6m6L+TFl+VYXFF/Gc=;
        b=ab++o12sFhMNsdMoEG4uQ5u68DU26VUfNwal9n72Ha1HHZzQcX+pqEZeIRXOOTvuCxacFp
        +7wxOTfJJ/tWbbHEKtMEwsot2inc7rh+w0jzTGhaa1YMLt39WicG7ammZP6PKAtPs/GQQy
        cOlI/lx0+AVZ731IGC/GxjCpicsPCoY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-ChLXa-OBNW-NblGto0vqdQ-1; Sun, 03 Dec 2023 11:23:57 -0500
X-MC-Unique: ChLXa-OBNW-NblGto0vqdQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33334e370d3so1308119f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 08:23:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701620636; x=1702225436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnZvOG5O1XML8m5bdEgP0BLaNE6m6L+TFl+VYXFF/Gc=;
        b=fBhe5DPTiCW4IKjkeYxGz4jcuHpvHdl9tkJgWFo10thtdZ1mJqOMzzpYXdopyvpL4J
         SfkxnWQOXgyB0csBtxbvbH2Op/4oJDD0bD3FwPDffwY67ErG4BLS9oYQIi6D7eXw2mUw
         bTYZnrzFXxJKftevOA4TjoHiJgSfkGKLxc+srlzC6TxdLrZeYl9Cl9oUuyOHdEFCxzud
         TGDl72SgjP0+7YlQx/06VB0dZXndMP7omLGxE+4OvSrJ3zVIN8YZseh3Nyupbo4gxL+p
         QAYUn2A8IoCgq+eKUo5Fuji/2RwikUuoJ72RbcwnaXA3mgC4MHk3o2xUHWf1odq3b792
         KlGg==
X-Gm-Message-State: AOJu0YynCtNSQgQrqBmA1IAGVw6gVrvQamiD48jl6Kb00AEmasI7ll9u
        +KU/J7LRcUmcaiy/yS5/fIp+yxtCxG88WkNYmstfOo3wSJjyXuntMPJALA/b8sTJNRycTENhpMg
        b8s/kcaDGSHVCrqLw8jUKj+4Q
X-Received: by 2002:a05:600c:705:b0:40b:5e21:dd4f with SMTP id i5-20020a05600c070500b0040b5e21dd4fmr1874536wmn.125.1701620635913;
        Sun, 03 Dec 2023 08:23:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKP9eXqXIJINqxrVU9tyc8Z3UHQwADTnS0+oYOUt7wpJ1p/7gUBKwhI0K0i3D0cbqq7yqUBw==
X-Received: by 2002:a05:600c:705:b0:40b:5e21:dd4f with SMTP id i5-20020a05600c070500b0040b5e21dd4fmr1874523wmn.125.1701620635528;
        Sun, 03 Dec 2023 08:23:55 -0800 (PST)
Received: from redhat.com ([2.55.11.133])
        by smtp.gmail.com with ESMTPSA id jg23-20020a05600ca01700b0040b30be6244sm12148007wmb.24.2023.12.03.08.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 08:23:54 -0800 (PST)
Date:   Sun, 3 Dec 2023 11:23:50 -0500
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
Message-ID: <20231203112324-mutt-send-email-mst@kernel.org>
References: <20231201104857.665737-1-dtatulea@nvidia.com>
 <20231202152523-mutt-send-email-mst@kernel.org>
 <aff0361edcb0fd0c384bf297e71d25fb77570e15.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aff0361edcb0fd0c384bf297e71d25fb77570e15.camel@nvidia.com>
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

On Sun, Dec 03, 2023 at 03:21:01PM +0000, Dragos Tatulea wrote:
> On Sat, 2023-12-02 at 15:26 -0500, Michael S. Tsirkin wrote:
> > On Fri, Dec 01, 2023 at 12:48:50PM +0200, Dragos Tatulea wrote:
> > > Add support for resumable vqs in the driver. This is a firmware feature
> > > that can be used for the following benefits:
> > > - Full device .suspend/.resume.
> > > - .set_map doesn't need to destroy and create new vqs anymore just to
> > >   update the map. When resumable vqs are supported it is enough to
> > >   suspend the vqs, set the new maps, and then resume the vqs.
> > > 
> > > The first patch exposes the relevant bits in mlx5_ifc.h. That means it
> > > needs to be applied to the mlx5-vhost tree [0] first.
> > 
> > I didn't get this. Why does this need to go through that tree?
> > Is there a dependency on some other commit from that tree?
> > 
> To avoid merge issues in Linus's tree in mlx5_ifc.h. The idea is the same as for
> the "vq descriptor mappings" patchset [1].
> 
> Thanks,
> Dragos

Are there other changes in that area that will cause non-trivial merge
conflicts?

> > > Once applied
> > > there, the change has to be pulled from mlx5-vhost into the vhost tree
> > > and only then the remaining patches can be applied. Same flow as the vq
> > > descriptor mappings patchset [1].
> > > 
> > > To be able to use resumable vqs properly, support for selectively modifying
> > > vq parameters was needed. This is what the middle part of the series
> > > consists of.
> > > 
> > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-vhost
> > > [1] https://lore.kernel.org/virtualization/20231018171456.1624030-2-dtatulea@nvidia.com/
> > > 
> > > Dragos Tatulea (7):
> > >   vdpa/mlx5: Expose resumable vq capability
> > >   vdpa/mlx5: Split function into locked and unlocked variants
> > >   vdpa/mlx5: Allow modifying multiple vq fields in one modify command
> > >   vdpa/mlx5: Introduce per vq and device resume
> > >   vdpa/mlx5: Mark vq addrs for modification in hw vq
> > >   vdpa/mlx5: Mark vq state for modification in hw vq
> > >   vdpa/mlx5: Use vq suspend/resume during .set_map
> > > 
> > >  drivers/vdpa/mlx5/core/mr.c        |  31 +++---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 172 +++++++++++++++++++++++++----
> > >  include/linux/mlx5/mlx5_ifc.h      |   3 +-
> > >  include/linux/mlx5/mlx5_ifc_vdpa.h |   4 +
> > >  4 files changed, 174 insertions(+), 36 deletions(-)
> > > 
> > > -- 
> > > 2.42.0
> > 
> 

