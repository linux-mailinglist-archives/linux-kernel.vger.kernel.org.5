Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AA5778A60
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjHKJwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjHKJwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:52:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AECB273E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691747506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=75rSna6DzYfcTF9jaKfqJtBw3nqCSolFXF00msNxr1E=;
        b=Qlr9Y5R47Uvl6GI4jzjJHOHOfcw8JdUkFsHL0eqenZnEHUXPbVHtI6JjLZdoHoZO8kjFTb
        IA8XxftyErt9ucLyhEq4hS1/rQX3jGgEuabtNvfUy+OZf6LdvBnaCuGUecUXxkNtgcoIUi
        Cik8ILuOweGi8JoPXn+/w40mDXptKKM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-LXe3jrClMdiVBRr5NdU7WA-1; Fri, 11 Aug 2023 05:51:45 -0400
X-MC-Unique: LXe3jrClMdiVBRr5NdU7WA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so11456555e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691747504; x=1692352304;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75rSna6DzYfcTF9jaKfqJtBw3nqCSolFXF00msNxr1E=;
        b=NTVpQaXBUTLL575zJ/rU3tQCIT3iWZBc2JXZu9CB81PD3QuX021SHZwOvfzHU4KqNj
         MmBs+DkaMkZDNn6LrBel5Z5OIpHC/epgYJvqNTyn7TuE4IN3xUw8ceuxMqOJ0Jj6LA5/
         ZleuJiKLKOr5it3dV0deuLSzAth44CxEamcVr0/qaY4tSPxtWE+yFMVUEv6JfAHHrBWM
         NElKvqYpIePgSOP3ZkrRxch3VDTiJQc+ITe1f5plH6IXMrx0JFgwiGI9tEfvqMhYeO/G
         E6almodkJdIq42R4zhSzllgKpcayk1tpqmG9DCTPasDnzts7WfRZBM6BEXdDgyLWweZ2
         0cBA==
X-Gm-Message-State: AOJu0Yx3HS+NjnXEiKRx557COnPLuE9RPECcdm0aIDMxWmf7QKzYGiVH
        YNRcoBb5AP2H83VBdViKsQqHf+F8FMQtHmxBifgDS19Xh1RjksbOnkRxHdOionmWrVjP46Sicvv
        Kqy8pMDq/nAHXSZb9B4RBHhYM
X-Received: by 2002:a7b:c3d6:0:b0:3fe:29e0:5dad with SMTP id t22-20020a7bc3d6000000b003fe29e05dadmr1140838wmj.34.1691747504442;
        Fri, 11 Aug 2023 02:51:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA198YY0xgEGy8+3z1yxBa6f19jkcuo/4if9Wj0f4OcPhAZIbk5Q0G/vSZurrQnPJwZNM5zQ==
X-Received: by 2002:a7b:c3d6:0:b0:3fe:29e0:5dad with SMTP id t22-20020a7bc3d6000000b003fe29e05dadmr1140821wmj.34.1691747504059;
        Fri, 11 Aug 2023 02:51:44 -0700 (PDT)
Received: from redhat.com ([2.55.27.97])
        by smtp.gmail.com with ESMTPSA id y24-20020a05600c365800b003fe2b081661sm7520672wmq.30.2023.08.11.02.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 02:51:43 -0700 (PDT)
Date:   Fri, 11 Aug 2023 05:51:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230811054859-mutt-send-email-mst@kernel.org>
References: <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org>
 <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
 <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
 <20230810153744-mutt-send-email-mst@kernel.org>
 <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
 <20230811012147-mutt-send-email-mst@kernel.org>
 <CACGkMEu8gCJGa4aLTrrNdCRYrZXohF0Pdx3a9kBhrhcHyt05-Q@mail.gmail.com>
 <20230811052102-mutt-send-email-mst@kernel.org>
 <CACGkMEuSGQqipR-XT-JWDt8T8KRXVpvDZsrQ6fEcaE4AfOyfwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuSGQqipR-XT-JWDt8T8KRXVpvDZsrQ6fEcaE4AfOyfwg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 05:43:25PM +0800, Jason Wang wrote:
> On Fri, Aug 11, 2023 at 5:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Aug 11, 2023 at 05:18:51PM +0800, Jason Wang wrote:
> > > On Fri, Aug 11, 2023 at 1:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Aug 11, 2023 at 10:23:15AM +0800, Jason Wang wrote:
> > > > > On Fri, Aug 11, 2023 at 3:41 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 08, 2023 at 10:30:56AM +0800, Jason Wang wrote:
> > > > > > > On Mon, Jul 31, 2023 at 2:30 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jul 27, 2023 at 5:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Jul 27, 2023 at 04:59:33PM +0800, Jason Wang wrote:
> > > > > > > > > > > They really shouldn't - any NIC that takes forever to
> > > > > > > > > > > program will create issues in the networking stack.
> > > > > > > > > >
> > > > > > > > > > Unfortunately, it's not rare as the device/cvq could be implemented
> > > > > > > > > > via firmware or software.
> > > > > > > > >
> > > > > > > > > Currently that mean one either has sane firmware with a scheduler that
> > > > > > > > > can meet deadlines, or loses ability to report errors back.
> > > > > > > > >
> > > > > > > > > > > But if they do they can always set this flag too.
> > > > > > > > > >
> > > > > > > > > > This may have false negatives and may confuse the management.
> > > > > > > > > >
> > > > > > > > > > Maybe we can extend the networking core to allow some device specific
> > > > > > > > > > configurations to be done with device specific lock without rtnl. For
> > > > > > > > > > example, split the set_channels to
> > > > > > > > > >
> > > > > > > > > > pre_set_channels
> > > > > > > > > > set_channels
> > > > > > > > > > post_set_channels
> > > > > > > > > >
> > > > > > > > > > The device specific part could be done in pre and post without a rtnl lock?
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Would the benefit be that errors can be reported to userspace then?
> > > > > > > > > Then maybe.  I think you will have to show how this works for at least
> > > > > > > > > one card besides virtio.
> > > > > > > >
> > > > > > > > Even for virtio, this seems not easy, as e.g the
> > > > > > > > virtnet_send_command() and netif_set_real_num_tx_queues() need to
> > > > > > > > appear to be atomic to the networking core.
> > > > > > > >
> > > > > > > > I wonder if we can re-consider the way of a timeout here and choose a
> > > > > > > > sane value as a start.
> > > > > > >
> > > > > > > Michael, any more input on this?
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > I think this is just mission creep. We are trying to fix
> > > > > > vduse - let's do that for starters.
> > > > > >
> > > > > > Recovering from firmware timeouts is far from trivial and
> > > > > > just assuming that just because it timed out it will not
> > > > > > access memory is just as likely to cause memory corruption
> > > > > > with worse results than an infinite spin.
> > > > >
> > > > > Yes, this might require support not only in the driver
> > > > >
> > > > > >
> > > > > > I propose we fix this for vduse and assume hardware/firmware
> > > > > > is well behaved.
> > > > >
> > > > > One major case is the re-connection, in that case it might take
> > > > > whatever longer that the kernel virito-net driver expects.
> > > > > So we can have a timeout in VDUSE and trap CVQ then VDUSE can return
> > > > > and fail early?
> > > >
> > > > Ugh more mission creep. not at all my point. vduse should cache
> > > > values in the driver,
> > >
> > > What do you mean by values here? The cvq command?
> > >
> > > Thanks
> >
> > The card status generally.
> 
> Just to make sure I understand here. The CVQ needs to be processed by
> the userspace now. How could we cache the status?
> 
> Thanks

vduse will have to process it in kernel.

> >
> > > > until someone manages to change
> > > > net core to be more friendly to userspace devices.
> > > >
> > > > >
> > > > > > Or maybe not well behaved firmware will
> > > > > > set the flag losing error reporting ability.
> > > > >
> > > > > This might be hard since it means not only the set but also the get is
> > > > > unreliable.
> > > > >
> > > > > Thanks
> > > >
> > > > /me shrugs
> > > >
> > > >
> > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > MST
> > > > > > > > >
> > > > > >
> > > >
> >

