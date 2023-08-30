Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19F378E259
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343882AbjH3WcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343894AbjH3WcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59696EE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693434666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3NjxVK/JrpkWvoiz6/GperXEOF12luau1rGvSVhj2Bc=;
        b=DagNexRkv/lyClhjaDMVaVJO++3XXjoOZTsNftZwI/Ai9xlNf8k+ownnLK+9l+ZjoWFuDu
        F/uPlAeG9ECPTAvkpeL3IPcDxdaOUjWdyk4ADhNis5xXMD6+NS5ryPqge6pORaDEBJ9JoL
        k4b4lZZnJOI4nVgRXB0Xaxx3arGko2I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-EidZ9Bd1MHutZdDdgxWWNg-1; Wed, 30 Aug 2023 16:08:39 -0400
X-MC-Unique: EidZ9Bd1MHutZdDdgxWWNg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31c5adb698aso3711053f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693426118; x=1694030918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NjxVK/JrpkWvoiz6/GperXEOF12luau1rGvSVhj2Bc=;
        b=KA2NPDZIz+Yrxcy74SnUBUcYNecFJthLuw0UkFYGVYtpXmmeLrWDaNsyhjYuRGup/v
         oAAqJo9DVWpYXyaQlADCZG+vz3YAVQAPrhcNfK/NeX2VIztw2hNC0iVSvS5mGAO7sOUV
         5XJgMULU+5wYxSBatCFMlMHmrVe5WwN7q46oBD7Q2R+ZtvRfXrDf6ioR/E7A/koAfFbE
         CTdBRRpjT5r9js2aUO3D3esoEtM6EPMV5dGVXLhHIPB7NpA3WrN9na+9IYNf6hz/Bv9v
         J909dzQRsW/XgVubNlrHz+odPDS3eXSu41dL3vkDfuSldThPEUmvJadzA24K7OLit/q9
         0Z8A==
X-Gm-Message-State: AOJu0Yxr8GB58JwfLvpWFicp75zfuLiOMyDdhbe4LuSwq4+PL5QigM0k
        1r/JeN10F+4GHODqs3jLs4Lb8zWfxxEL+/5N9iMdZvd/S2B4Lnmobvg8kipCAQmvN5zvg3XgL11
        zQCO8OdQtlpav6bIpIZmh4dW8
X-Received: by 2002:a17:906:18d:b0:9a2:16a7:fd0 with SMTP id 13-20020a170906018d00b009a216a70fd0mr2423111ejb.21.1693424537368;
        Wed, 30 Aug 2023 12:42:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPl2d8yog5OYYxnVfR719SFpTMzeSHrPCryTF2nxMjc68c11HQgd4yjH64I6CkiNALUEQ33w==
X-Received: by 2002:a17:906:18d:b0:9a2:16a7:fd0 with SMTP id 13-20020a170906018d00b009a216a70fd0mr2423093ejb.21.1693424537027;
        Wed, 30 Aug 2023 12:42:17 -0700 (PDT)
Received: from redhat.com ([2.55.167.22])
        by smtp.gmail.com with ESMTPSA id z3-20020a1709064e0300b009a19fa8d2e9sm7490757eju.206.2023.08.30.12.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:42:16 -0700 (PDT)
Date:   Wed, 30 Aug 2023 15:42:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     jasowang@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        jiri@nvidia.com, dtatulea@nvidia.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Gavin Li <gavinl@nvidia.com>
Subject: Re: [PATCH net-next V1 0/4] virtio_net: add per queue interrupt
 coalescing support
Message-ID: <20230830154200-mutt-send-email-mst@kernel.org>
References: <20230710092005.5062-1-gavinl@nvidia.com>
 <20230713074001-mutt-send-email-mst@kernel.org>
 <1689300651.6874406-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689300651.6874406-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 10:10:51AM +0800, Xuan Zhuo wrote:
> On Thu, 13 Jul 2023 07:40:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Jul 10, 2023 at 12:20:01PM +0300, Gavin Li wrote:
> > > Currently, coalescing parameters are grouped for all transmit and receive
> > > virtqueues. This patch series add support to set or get the parameters for
> > > a specified virtqueue.
> > >
> > > When the traffic between virtqueues is unbalanced, for example, one virtqueue
> > > is busy and another virtqueue is idle, then it will be very useful to
> > > control coalescing parameters at the virtqueue granularity.
> >
> > series:
> >
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> Why?
> 
> This series has the bug I reported.
> 
> Are you thinking that is ok? Or this is not a bug?
> 
> Thanks.
> 
> 


I missed that mail. What's the bug?

> >
> >
> >
> > > Example command:
> > > $ ethtool -Q eth5 queue_mask 0x1 --coalesce tx-packets 10
> > > Would set max_packets=10 to VQ 1.
> > > $ ethtool -Q eth5 queue_mask 0x1 --coalesce rx-packets 10
> > > Would set max_packets=10 to VQ 0.
> > > $ ethtool -Q eth5 queue_mask 0x1 --show-coalesce
> > >  Queue: 0
> > >  Adaptive RX: off  TX: off
> > >  stats-block-usecs: 0
> > >  sample-interval: 0
> > >  pkt-rate-low: 0
> > >  pkt-rate-high: 0
> > >
> > >  rx-usecs: 222
> > >  rx-frames: 0
> > >  rx-usecs-irq: 0
> > >  rx-frames-irq: 256
> > >
> > >  tx-usecs: 222
> > >  tx-frames: 0
> > >  tx-usecs-irq: 0
> > >  tx-frames-irq: 256
> > >
> > >  rx-usecs-low: 0
> > >  rx-frame-low: 0
> > >  tx-usecs-low: 0
> > >  tx-frame-low: 0
> > >
> > >  rx-usecs-high: 0
> > >  rx-frame-high: 0
> > >  tx-usecs-high: 0
> > >  tx-frame-high: 0
> > >
> > > In this patch series:
> > > Patch-1: Extract interrupt coalescing settings to a structure.
> > > Patch-2: Extract get/set interrupt coalesce to a function.
> > > Patch-3: Support per queue interrupt coalesce command.
> > > Patch-4: Enable per queue interrupt coalesce feature.
> > >
> > > Gavin Li (4):
> > >   virtio_net: extract interrupt coalescing settings to a structure
> > >   virtio_net: extract get/set interrupt coalesce to a function
> > >   virtio_net: support per queue interrupt coalesce command
> > >   virtio_net: enable per queue interrupt coalesce feature
> > >
> > >  drivers/net/virtio_net.c        | 169 ++++++++++++++++++++++++++------
> > >  include/uapi/linux/virtio_net.h |  14 +++
> > >  2 files changed, 154 insertions(+), 29 deletions(-)
> > >
> > > --
> > > 2.39.1
> >

