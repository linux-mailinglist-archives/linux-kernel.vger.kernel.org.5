Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C5D7FD318
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjK2JrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjK2JrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:47:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1197219BB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701251236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8FUL7xaq2WNQBPHMTY8ZTJkkLmUhL7UnsbnYobOmCzM=;
        b=cF23uCnbDgtBVu/PFjh4DnfmKASshe8nXxLYBnt49brIdjx1mpRO8XsQ5JU9hk6zk1DC+z
        QDQzqCRUbBOooxBkQmXJDgBQ507MCo0KE3fB/HlsNX71mAbyu8ljKscxUr5X2ci8jEDb94
        bPZTxEFX9/tNzcRBfXaBGkUPwBuevZw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-ehgvcEH5Nvy-vKQH6U5XAg-1; Wed, 29 Nov 2023 04:47:14 -0500
X-MC-Unique: ehgvcEH5Nvy-vKQH6U5XAg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9fffa4c4f28so489684166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:47:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701251233; x=1701856033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FUL7xaq2WNQBPHMTY8ZTJkkLmUhL7UnsbnYobOmCzM=;
        b=gZ0T6Yzm8k2RFLfXrzFtU6BnqGMUVshQ0ujiP5N//JLYZQH8PjEEK3Km/U2kGapoTg
         0GV/dbrBio7OyaNsXwz+aSRR+DCkSf/oSjAQ2XedJ2D2H4ZhnbKSdfBnFyhVtN3nw90O
         mhyi7JLkz5ieRY0Iz/PoK2lgCtLVL7KDEgTtQiOpYIRxs6UlERhSMNJgZ8z0bedbuWGM
         t+5lV2FzqvRLsS8xfKzBHoainz6Z+F4R4sZnqp7tQ0QWruvzcSxrRmD+OLmz/uD9rm/d
         aUnet5qrQZ2MMdeHJk61Is8m+uYnCIllZ6B7XTzsVnq5n9LdGy1eLFpJ1XcB1g0X/yFr
         W6pg==
X-Gm-Message-State: AOJu0YyBdCZVi29yVNq3sW3+jdkqtJaKZMnlftnO5DZUCJNapRtpR1oR
        urLq8knYokmemNiPJ3az8Bf+cELLTxJBawIAU664WbslOnFep3UtdWyXfcLM5/G/H0V8L5yflif
        R5VQx90PWUzhiK05W8lxNkn/E
X-Received: by 2002:a17:906:5349:b0:a0a:391d:2dad with SMTP id j9-20020a170906534900b00a0a391d2dadmr13424741ejo.75.1701251233274;
        Wed, 29 Nov 2023 01:47:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcdjDb3B9JI1PiGSAemY+jsGIUrA/1PnJLVzsoGUWFBHqpyAnt/MTb5gBPxFzfJMBSJ9M+Hw==
X-Received: by 2002:a17:906:5349:b0:a0a:391d:2dad with SMTP id j9-20020a170906534900b00a0a391d2dadmr13424728ejo.75.1701251232928;
        Wed, 29 Nov 2023 01:47:12 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906454800b00997d7aa59fasm7810806ejq.14.2023.11.29.01.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:47:12 -0800 (PST)
Date:   Wed, 29 Nov 2023 04:47:08 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Cc:     xuanzhuo@linux.alibaba.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eperezma@redhat.com, jasowang@redhat.com, shannon.nelson@amd.com,
        yuanyaogoog@chromium.org, yuehaibing@huawei.com,
        kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [GIT PULL] virtio: features
Message-ID: <20231129044651-mutt-send-email-mst@kernel.org>
References: <20230903181338-mutt-send-email-mst@kernel.org>
 <647701d8-c99b-4ca8-9817-137eaefda237@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <647701d8-c99b-4ca8-9817-137eaefda237@linux.intel.com>
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

On Wed, Nov 29, 2023 at 05:03:50PM +0800, Ning, Hongyu wrote:
> 
> 
> On 2023/9/4 6:13, Michael S. Tsirkin wrote:
> > The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c:
> > 
> >    Linux 6.5 (2023-08-27 14:49:51 -0700)
> > 
> > are available in the Git repository at:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> > 
> > for you to fetch changes up to 1acfe2c1225899eab5ab724c91b7e1eb2881b9ab:
> > 
> >    virtio_ring: fix avail_wrap_counter in virtqueue_add_packed (2023-09-03 18:10:24 -0400)
> > 
> > ----------------------------------------------------------------
> > virtio: features
> > 
> > a small pull request this time around, mostly because the
> > vduse network got postponed to next relase so we can be sure
> > we got the security store right.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ----------------------------------------------------------------
> > Eugenio Pérez (4):
> >        vdpa: add VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK flag
> >        vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature
> >        vdpa: add get_backend_features vdpa operation
> >        vdpa_sim: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
> > 
> > Jason Wang (1):
> >        virtio_vdpa: build affinity masks conditionally
> > 
> > Xuan Zhuo (12):
> >        virtio_ring: check use_dma_api before unmap desc for indirect
> >        virtio_ring: put mapping error check in vring_map_one_sg
> >        virtio_ring: introduce virtqueue_set_dma_premapped()
> >        virtio_ring: support add premapped buf
> >        virtio_ring: introduce virtqueue_dma_dev()
> >        virtio_ring: skip unmap for premapped
> >        virtio_ring: correct the expression of the description of virtqueue_resize()
> >        virtio_ring: separate the logic of reset/enable from virtqueue_resize
> >        virtio_ring: introduce virtqueue_reset()
> >        virtio_ring: introduce dma map api for virtqueue
> >        virtio_ring: introduce dma sync api for virtqueue
> >        virtio_net: merge dma operations when filling mergeable buffers
> 
> Hi,
> above patch (upstream commit 295525e29a5b) seems causing a virtnet related
> Call Trace after WARNING from kernel/dma/debug.c.
> 
> details (log and test setup) tracked in
> https://bugzilla.kernel.org/show_bug.cgi?id=218204
> 
> it's recently noticed in a TDX guest testing since v6.6.0 release cycle and
> can still be reproduced in latest v6.7.0-rc3.
> 
> as local bisects results show, above WARNING and Call Trace is linked with
> this patch, do you mind to take a look?

Does your testing tree include the fixup
5720c43d5216b5dbd9ab25595f7c61e55d36d4fc ?

> > 
> > Yuan Yao (1):
> >        virtio_ring: fix avail_wrap_counter in virtqueue_add_packed
> > 
> > Yue Haibing (1):
> >        vdpa/mlx5: Remove unused function declarations
> > 
> >   drivers/net/virtio_net.c           | 230 ++++++++++++++++++---
> >   drivers/vdpa/mlx5/core/mlx5_vdpa.h |   3 -
> >   drivers/vdpa/vdpa_sim/vdpa_sim.c   |   8 +
> >   drivers/vhost/vdpa.c               |  15 +-
> >   drivers/virtio/virtio_ring.c       | 412 ++++++++++++++++++++++++++++++++-----
> >   drivers/virtio/virtio_vdpa.c       |  17 +-
> >   include/linux/vdpa.h               |   4 +
> >   include/linux/virtio.h             |  22 ++
> >   include/uapi/linux/vhost_types.h   |   4 +
> >   9 files changed, 625 insertions(+), 90 deletions(-)
> > 

