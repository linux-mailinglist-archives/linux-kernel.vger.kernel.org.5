Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843A07D45AB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjJXCoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjJXCoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:44:15 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8071B10D4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:44:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VuoXqpk_1698115445;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VuoXqpk_1698115445)
          by smtp.aliyun-inc.com;
          Tue, 24 Oct 2023 10:44:05 +0800
Message-ID: <1698114697.434748-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/2] virtio_pci: Don't make an extra copy of cpu affinity mask
Date:   Tue, 24 Oct 2023 10:31:37 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Caleb Raitto <caraitto@google.com>,
        virtualization@lists.linux-foundation.org
References: <20231019101625.412936-1-jakub@cloudflare.com>
 <1697720122.49851-2-xuanzhuo@linux.alibaba.com>
 <87il6x2rj6.fsf@cloudflare.com>
In-Reply-To: <87il6x2rj6.fsf@cloudflare.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 18:52:45 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> On Thu, Oct 19, 2023 at 08:55 PM +08, Xuan Zhuo wrote:
> > On Thu, 19 Oct 2023 12:16:24 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> >> Since commit 19e226e8cc5d ("virtio: Make vp_set_vq_affinity() take a
> >> mask.") it is actually not needed to have a local copy of the cpu mask.
> >
> >
> > Could you give more info to prove this?


Actually, my question is that can we pass a val on the stack(or temp value) to
the irq_set_affinity_hint()?

Such as the virtio-net uses zalloc_cpumask_var to alloc a cpu_mask, and
that will be released.



	int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
				      bool setaffinity)
	{
		unsigned long flags;
		struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);

		if (!desc)
			return -EINVAL;
->		desc->affinity_hint = m;
		irq_put_desc_unlock(desc, flags);
		if (m && setaffinity)
			__irq_set_affinity(irq, m, false);
		return 0;
	}
	EXPORT_SYMBOL_GPL(__irq_apply_affinity_hint);

The above code directly refers the mask pointer. If the mask is a temp value, I
think that is a bug.

And I notice that many places directly pass the temp value to this API.
And I am a little confused. ^_^ Or I missed something.

Thanks.


> >
> > If you are right, I think you should delete all code about msix_affinity_masks?
>
> Sorry for the late reply. I've been away.
>
> It looks that msix_affinity_masks became unused - intentionally - in
> 2015, after commit 210d150e1f5d ("virtio_pci: Clear stale cpumask when
> setting irq affinity") [1].
>
> Originally introduced in 2012 in commit 75a0a52be3c2 ("virtio: introduce
> an API to set affinity for a virtqueue") [2]. As I understand, it was
> meant to make it possible to set VQ affinity to more than once CPU.
>
> Now that we can pass a CPU mask, listing all CPUs, to set_vq_affinity,
> msix_affinity_masks seems to no longer have a purpose.
>
> So, IMO, you're right. We can remove it.
>
> Happy to do that in a follow up series.
>
> That is - if you're okay with these two patches in the current form.
>
> Thanks for reviewing.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=210d150e1f5da506875e376422ba31ead2d49621
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75a0a52be3c27b58654fbed2c8f2ff401482b9a4
