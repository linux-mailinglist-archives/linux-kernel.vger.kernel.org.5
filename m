Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156287D8778
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjJZRVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJZRVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C255CA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698340845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5kLaQtEOk7UbV1uqygBEcoktd0GtHWmaS2i+eVzn0zA=;
        b=Dt/R5TXJgdqWET+LJDJ+frQ2F2d3xhZronVe2NzUm3o9dIyxU/iWo4K9NJSIZjXtOx60Ix
        M+Yhs0bqbaUdl3wnXBSm3RyIC89yIUWrKgZidwQ+prOpFdFvt8wKXxipfIwKiXyABvu6Tz
        rb80uDxtP/4qwxmTv4FCd8KnGbn5r+c=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-FLfEon22N6GaKnWoSYrh2A-1; Thu, 26 Oct 2023 13:20:44 -0400
X-MC-Unique: FLfEon22N6GaKnWoSYrh2A-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507d2e150c2so1314119e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340842; x=1698945642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kLaQtEOk7UbV1uqygBEcoktd0GtHWmaS2i+eVzn0zA=;
        b=t4q1bef1kqKWFrjHW3FyL2RYUQwmL8zALFtbJDRw0kXnSYbysSJHZj8ltcKxy+FT+l
         /ecOhntATefEdLcoK/hD/397gRD3LLO7wcoJ7AUuBbvaxPXq5DaSo2ICn989rY5d56nX
         dIxtLWvRBEgUo7QiLxD0oGKfA4QRtROt3Nqfm6VUf0GaTzXtjFDuW6y8y421hfIAKBjQ
         NBSUSODvYu3SVVhMkz4Yk0u/Holu2+VKWNSJykJdX9KntZuTOFdJinhvVH+bQ+ppHDyn
         SMC7AnBb33yVstRIYXuzKQ0VCx+87RgFbhQ5cCwcuFcosgiGg6m/ECTwuL+zNZr2sVHD
         0ASQ==
X-Gm-Message-State: AOJu0YxgEglhaYb3JOS/OwkdFLdSD4NFflagVJ+WMCgccxgT/8qq+zHR
        LkomY7oPVw1xQ/Hiy0k5XGVoWABllZ0U8B09eS709xsqQDeeaJa6vEQwqs10Bqg147W5w4iVk3K
        nunZbF/w1dIbMbvDducpd5OE/
X-Received: by 2002:a19:771a:0:b0:507:9784:644c with SMTP id s26-20020a19771a000000b005079784644cmr13653lfc.26.1698340842620;
        Thu, 26 Oct 2023 10:20:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBuY88F57kBvZ8DBFENBLOEu6PPi0md4h+oiVlvlZqcMwMkNddTglwsedLiad4JyDOl/3LWg==
X-Received: by 2002:a19:771a:0:b0:507:9784:644c with SMTP id s26-20020a19771a000000b005079784644cmr13641lfc.26.1698340842258;
        Thu, 26 Oct 2023 10:20:42 -0700 (PDT)
Received: from redhat.com ([2.52.26.119])
        by smtp.gmail.com with ESMTPSA id r6-20020a5d6946000000b00318147fd2d3sm14569272wrw.41.2023.10.26.10.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:20:41 -0700 (PDT)
Date:   Thu, 26 Oct 2023 13:20:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH v2] virtio_pci: Switch away from deprecated
 irq_set_affinity_hint
Message-ID: <20231026131830-mutt-send-email-mst@kernel.org>
References: <20231025145319.380775-1-jakub@cloudflare.com>
 <87wmv91h3p.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmv91h3p.fsf@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 06:25:08PM +0200, Jakub Sitnicki wrote:
> On Wed, Oct 25, 2023 at 04:53 PM +02, Jakub Sitnicki wrote:
> > Since commit 65c7cdedeb30 ("genirq: Provide new interfaces for affinity
> > hints") irq_set_affinity_hint is being phased out.
> >
> > Switch to new interfaces for setting and applying irq affinity hints.
> >
> > Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> > ---
> > v2:
> >  - Leave cpumask_copy as is. We can't pass pointer to stack memory as hint.
> >    Proposed a change to IRQ affinity interface to address this limitation:
> >    https://lore.kernel.org/r/20231025141517.375378-1-jakub@cloudflare.com
> 
> Just a note to the ^ - if we wanted to get rid of msix_affinity_masks,
> we could call irq_set_affinity directly, instead of calling it through
> irq_set_affinity[_and]_hint.
> 
> The hint wouldn't be available any more in /proc/irq/N/affinity_hint,
> but the same information can be gathered from /proc/irq/N/smp_affinity.
> 
> [...]


So we are potentially breaking some userspace - what's the value we
gain?  Is there some way we can make disable_irq/enable_irq work?
That would have a lot of value.
There is an actual need for that in virtio for coco but we can't use
these APIs with affinity managed IRQs.

-- 
MST

