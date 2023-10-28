Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A117DA4B4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 03:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjJ1Brd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 21:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjJ1Brc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 21:47:32 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF12C4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 18:47:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vv05X6g_1698457645;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vv05X6g_1698457645)
          by smtp.aliyun-inc.com;
          Sat, 28 Oct 2023 09:47:26 +0800
Message-ID: <1698457540.127802-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2] virtio_pci: Switch away from deprecated irq_set_affinity_hint
Date:   Sat, 28 Oct 2023 09:45:40 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, "Michael S. Tsirkin" <mst@redhat.com>
References: <20231025145319.380775-1-jakub@cloudflare.com>
 <87wmv91h3p.fsf@cloudflare.com>
 <20231026131830-mutt-send-email-mst@kernel.org>
 <87sf5w1ica.fsf@cloudflare.com>
In-Reply-To: <87sf5w1ica.fsf@cloudflare.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 12:03:17 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> On Thu, Oct 26, 2023 at 01:20 PM -04, Michael S. Tsirkin wrote:
> > On Thu, Oct 26, 2023 at 06:25:08PM +0200, Jakub Sitnicki wrote:
> >> On Wed, Oct 25, 2023 at 04:53 PM +02, Jakub Sitnicki wrote:
> >> > Since commit 65c7cdedeb30 ("genirq: Provide new interfaces for affinity
> >> > hints") irq_set_affinity_hint is being phased out.
> >> >
> >> > Switch to new interfaces for setting and applying irq affinity hints.
> >> >
> >> > Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> >> > ---
> >> > v2:
> >> >  - Leave cpumask_copy as is. We can't pass pointer to stack memory as hint.
> >> >    Proposed a change to IRQ affinity interface to address this limitation:
> >> >    https://lore.kernel.org/r/20231025141517.375378-1-jakub@cloudflare.com
> >>
> >> Just a note to the ^ - if we wanted to get rid of msix_affinity_masks,
> >> we could call irq_set_affinity directly, instead of calling it through
> >> irq_set_affinity[_and]_hint.
> >>
> >> The hint wouldn't be available any more in /proc/irq/N/affinity_hint,
> >> but the same information can be gathered from /proc/irq/N/smp_affinity.
> >>
> >> [...]
> >
> >
> > So we are potentially breaking some userspace - what's the value we
> > gain?  Is there some way we can make disable_irq/enable_irq work?
> > That would have a lot of value.
> > There is an actual need for that in virtio for coco but we can't use
> > these APIs with affinity managed IRQs.
>
> Sorry, that is beyond my ken today.
>
> I saw the comment in vp_modern_disable_vq_and_reset:
>
> 	/* For the case where vq has an exclusive irq, call synchronize_irq() to
> 	 * wait for completion.
> 	 *
> 	 * note: We can't use disable_irq() since it conflicts with the affinity
> 	 * managed IRQ that is used by some drivers.
> 	 */
>
> ... but I fail to follow how the two conflict.
>
> Perhaps Xuah could shed some light here.

I forgot which device that manages the irq by it self. If we disable the irq,
then the device will lost the irq, so we must not call disable_irq().

Thanks.
