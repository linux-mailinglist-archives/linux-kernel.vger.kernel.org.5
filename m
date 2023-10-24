Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D017D4F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjJXLq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjJXLq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:46:56 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37488F9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:46:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VuqJKun_1698148004;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VuqJKun_1698148004)
          by smtp.aliyun-inc.com;
          Tue, 24 Oct 2023 19:46:45 +0800
Message-ID: <1698147983.0338666-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/2] virtio_pci: Don't make an extra copy of cpu affinity mask
Date:   Tue, 24 Oct 2023 19:46:23 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Caleb Raitto <caraitto@google.com>,
        virtualization@lists.linux-foundation.org
References: <20231019101625.412936-1-jakub@cloudflare.com>
 <1697720122.49851-2-xuanzhuo@linux.alibaba.com>
 <87il6x2rj6.fsf@cloudflare.com>
 <1698114697.434748-1-xuanzhuo@linux.alibaba.com>
 <87edhk2z03.fsf@cloudflare.com>
 <1698144808.8577316-1-xuanzhuo@linux.alibaba.com>
 <87a5s82qig.fsf@cloudflare.com>
In-Reply-To: <87a5s82qig.fsf@cloudflare.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 13:26:49 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> On Tue, Oct 24, 2023 at 06:53 PM +08, Xuan Zhuo wrote:
> > On Tue, 24 Oct 2023 10:17:19 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> >> On Tue, Oct 24, 2023 at 10:31 AM +08, Xuan Zhuo wrote:
> >> > On Mon, 23 Oct 2023 18:52:45 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> >> >> On Thu, Oct 19, 2023 at 08:55 PM +08, Xuan Zhuo wrote:
> >> >> > On Thu, 19 Oct 2023 12:16:24 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> >> >> >> Since commit 19e226e8cc5d ("virtio: Make vp_set_vq_affinity() take a
> >> >> >> mask.") it is actually not needed to have a local copy of the cpu mask.
> >> >> >
> >> >> >
> >> >> > Could you give more info to prove this?
> >> >
> >> >
> >> > Actually, my question is that can we pass a val on the stack(or temp value) to
> >> > the irq_set_affinity_hint()?
> >> >
> >> > Such as the virtio-net uses zalloc_cpumask_var to alloc a cpu_mask, and
> >> > that will be released.
> >> >
> >> >
> >> >
> >> > 	int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
> >> > 				      bool setaffinity)
> >> > 	{
> >> > 		unsigned long flags;
> >> > 		struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
> >> >
> >> > 		if (!desc)
> >> > 			return -EINVAL;
> >> > ->		desc->affinity_hint = m;
> >> > 		irq_put_desc_unlock(desc, flags);
> >> > 		if (m && setaffinity)
> >> > 			__irq_set_affinity(irq, m, false);
> >> > 		return 0;
> >> > 	}
> >> > 	EXPORT_SYMBOL_GPL(__irq_apply_affinity_hint);
> >> >
> >> > The above code directly refers the mask pointer. If the mask is a temp value, I
> >> > think that is a bug.
> >>
> >> You are completely right. irq_set_affinity_hint stores the mask pointer.
> >> irq_affinity_hint_proc_show later dereferences it when user reads out
> >> /proc/irq/*/affinity_hint.
> >>
> >> I have failed to notice that. That's why we need cpumask_copy to stay.
> >>
> >> My patch is buggy. Please disregard.
> >>
> >> I will send a v2 to only migrate from deprecated irq_set_affinity_hint.
> >>
> >> > And I notice that many places directly pass the temp value to this API.
> >> > And I am a little confused. ^_^ Or I missed something.
> >>
> >> There seem two be two gropus of callers:
> >>
> >> 1. Those that use get_cpu_mask/cpumask_of/cpumask_of_node to produce a
> >>    cpumask pointer which is a preallocated constant.
> >>
> >>    $ weggli 'irq_set_affinity_hint(_, $func(_));' ~/src/linux
> >>
> >> 2. Those that pass a pointer to memory somewhere.
> >>
> >>    $ weggli 'irq_set_affinity_hint(_, $mask);' ~/src/linux
> >>
> >> (weggli tool can be found at https://github.com/weggli-rs/weggli)
> >>
> >> I've looked over the callers from group #2 but I couldn't find any
> >> passing a pointer memory on stack :-)
> >
> > Pls check stmmac_request_irq_multi_msi()
>
> Good catch. That one looks buggy.
>
> I should also checked for callers that take an address of a var/field:
>
>   $ weggli 'irq_set_affinity_hint(_, &$mask);' ~/src/linux

Do you find more?

Thanks.
