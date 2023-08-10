Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C5C7780F7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbjHJTDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjHJTDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F28271B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691694172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cwKZd9kJdARYjGG+RNfCj3MbPwhouNi+dlJfp58+jtI=;
        b=esB5CoWpHAWgvtP+4prvps4Nl/uTpeiKf6IhHrGHZmy4U7j+rLZNFKL7bzlRxWZ8uRBpiX
        4ahjxWONK56RHJ1x8TbshpYcgISYJf398Dcx9CygH5Jd8mp9M97YXEgQQnHH2CgdlHred1
        cO7tphe+9n/I+lEeFwiGU0uVRAuKGFQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-BJq8deD6NkCOa9woqi5OgQ-1; Thu, 10 Aug 2023 15:02:51 -0400
X-MC-Unique: BJq8deD6NkCOa9woqi5OgQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe603e8054so8347195e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691694170; x=1692298970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwKZd9kJdARYjGG+RNfCj3MbPwhouNi+dlJfp58+jtI=;
        b=hROZ+e/vLZRxKAJPHfUQ4L8d/xaySzdHcW5/MhaQLm/ao2P+Tyn/PeotTs7EVG4ZjT
         plLt86Ujm2wDIqJxCsxLTQQBM4eG7lqiVgZhpyCM6ZvAVDQ6opH6AUpYAq4It0UtU1Pe
         VfygboicZChHzFBhb1JfNhKKZn7MAJL/ktmZb62ep2t0vnrwilbLEtCouvCOaEW7jBrh
         ZPY4hq90l1Ov6oIGn/xPe84SGhARoaN5kWOGBJ8AGTKbduTz/z+UQq8x4ISrFvZxEnRL
         98YOU8VV2VzsdrsCPZRBEWHda8TKNCt060hHpFUUDpuu8W+VWh5IIQxIVPp4+lz3V9rU
         YDCA==
X-Gm-Message-State: AOJu0YyZ/1+7EjSOBALMct0Y7tS8y87/fRyJypKo1xHnygjGfy7o6hOS
        S5B0vDmaqBUMtA7/6Mk/7zpGJSYv5jav8XnAQjHKA9qtfXyjKSX0Q0Om88WyjPAS4MoPjIU+Pb6
        tu+dVCxWMpHxZO1JNoV3LRwoG
X-Received: by 2002:a1c:7314:0:b0:3fa:973e:2995 with SMTP id d20-20020a1c7314000000b003fa973e2995mr2547791wmb.12.1691694169961;
        Thu, 10 Aug 2023 12:02:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUZ6F49Kczr81tfxKe4/wLYJAobKnso77Sg3Wp4JvIX7WMl/+GBlExXHBVr9v5j92CbJJyyw==
X-Received: by 2002:a1c:7314:0:b0:3fa:973e:2995 with SMTP id d20-20020a1c7314000000b003fa973e2995mr2547777wmb.12.1691694169592;
        Thu, 10 Aug 2023 12:02:49 -0700 (PDT)
Received: from redhat.com ([2.55.27.97])
        by smtp.gmail.com with ESMTPSA id y1-20020a05600c364100b003fbb06af219sm2911778wmq.32.2023.08.10.12.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:02:48 -0700 (PDT)
Date:   Thu, 10 Aug 2023 15:02:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     xieyongji@bytedance.com, jasowang@redhat.com,
        david.marchand@redhat.com, lulu@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
Message-ID: <20230810145938-mutt-send-email-mst@kernel.org>
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627113652.65283-1-maxime.coquelin@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 01:36:50PM +0200, Maxime Coquelin wrote:
> This small series enables virtio-net device type in VDUSE.
> With it, basic operation have been tested, both with
> virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> adding VDUSE support using split rings layout (merged in
> DPDK v23.07-rc1).
> 
> Control queue support (and so multiqueue) has also been
> tested, but requires a Kernel series from Jason Wang
> relaxing control queue polling [1] to function reliably.
> 
> [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/
> 
> RFC -> v1 changes:
> ==================
> - Fail device init if it does not support VERSION_1 (Jason)

So I can put this in next, the issue I think is
that of security: currently selinux can if necessary block
access to creating virtio block devices.
But if we have more than one type we need a way for selinux to
block specific types. Can be a patch on top but pls work to
address.

Another question is that with this userspace can inject
packets directly into net stack. Should we check CAP_NET_ADMIN
or such?


> Maxime Coquelin (2):
>   vduse: validate block features only with block devices
>   vduse: enable Virtio-net device type
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> -- 
> 2.41.0

