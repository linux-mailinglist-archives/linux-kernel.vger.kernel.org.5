Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFA1752F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjGNCMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjGNCMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:12:50 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669D92702;
        Thu, 13 Jul 2023 19:12:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VnJx2Sq_1689300763;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VnJx2Sq_1689300763)
          by smtp.aliyun-inc.com;
          Fri, 14 Jul 2023 10:12:44 +0800
Message-ID: <1689300651.6874406-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next V1 0/4] virtio_net: add per queue interrupt coalescing support
Date:   Fri, 14 Jul 2023 10:10:51 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        jiri@nvidia.com, dtatulea@nvidia.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Gavin Li <gavinl@nvidia.com>
References: <20230710092005.5062-1-gavinl@nvidia.com>
 <20230713074001-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230713074001-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 07:40:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Jul 10, 2023 at 12:20:01PM +0300, Gavin Li wrote:
> > Currently, coalescing parameters are grouped for all transmit and receive
> > virtqueues. This patch series add support to set or get the parameters for
> > a specified virtqueue.
> >
> > When the traffic between virtqueues is unbalanced, for example, one virtqueue
> > is busy and another virtqueue is idle, then it will be very useful to
> > control coalescing parameters at the virtqueue granularity.
>
> series:
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>


Why?

This series has the bug I reported.

Are you thinking that is ok? Or this is not a bug?

Thanks.



>
>
>
> > Example command:
> > $ ethtool -Q eth5 queue_mask 0x1 --coalesce tx-packets 10
> > Would set max_packets=10 to VQ 1.
> > $ ethtool -Q eth5 queue_mask 0x1 --coalesce rx-packets 10
> > Would set max_packets=10 to VQ 0.
> > $ ethtool -Q eth5 queue_mask 0x1 --show-coalesce
> >  Queue: 0
> >  Adaptive RX: off  TX: off
> >  stats-block-usecs: 0
> >  sample-interval: 0
> >  pkt-rate-low: 0
> >  pkt-rate-high: 0
> >
> >  rx-usecs: 222
> >  rx-frames: 0
> >  rx-usecs-irq: 0
> >  rx-frames-irq: 256
> >
> >  tx-usecs: 222
> >  tx-frames: 0
> >  tx-usecs-irq: 0
> >  tx-frames-irq: 256
> >
> >  rx-usecs-low: 0
> >  rx-frame-low: 0
> >  tx-usecs-low: 0
> >  tx-frame-low: 0
> >
> >  rx-usecs-high: 0
> >  rx-frame-high: 0
> >  tx-usecs-high: 0
> >  tx-frame-high: 0
> >
> > In this patch series:
> > Patch-1: Extract interrupt coalescing settings to a structure.
> > Patch-2: Extract get/set interrupt coalesce to a function.
> > Patch-3: Support per queue interrupt coalesce command.
> > Patch-4: Enable per queue interrupt coalesce feature.
> >
> > Gavin Li (4):
> >   virtio_net: extract interrupt coalescing settings to a structure
> >   virtio_net: extract get/set interrupt coalesce to a function
> >   virtio_net: support per queue interrupt coalesce command
> >   virtio_net: enable per queue interrupt coalesce feature
> >
> >  drivers/net/virtio_net.c        | 169 ++++++++++++++++++++++++++------
> >  include/uapi/linux/virtio_net.h |  14 +++
> >  2 files changed, 154 insertions(+), 29 deletions(-)
> >
> > --
> > 2.39.1
>
