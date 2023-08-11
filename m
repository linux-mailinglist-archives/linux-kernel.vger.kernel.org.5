Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289D9778BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjHKKO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjHKKOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082E930FD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691748737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CddEPgIRt1Ku7GcBFRFd157gUsqIuqtTKrEsPcsv/hA=;
        b=cEwSui+z5IL1rEjQuxASRbf1Bm9ReKzPVCl2TFsX6Bbgff3CE6N1lhWyoXXNh0nCK3wqkT
        IE5zXqTt1DMYBb74ikuEaClfeU5LY1aOznuFu3yTDa678jTjubcApa8niBXSqvHNWmn/hB
        c2Sec4793hmb0eukhpGbbwkbTAposhY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-HDzZlVNyNyS-dPYsnpJmzg-1; Fri, 11 Aug 2023 06:12:15 -0400
X-MC-Unique: HDzZlVNyNyS-dPYsnpJmzg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fe2477947eso11323725e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691748734; x=1692353534;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CddEPgIRt1Ku7GcBFRFd157gUsqIuqtTKrEsPcsv/hA=;
        b=EVOwEa/bRGz7LWSJxvzudrWcBMTe5xWMGB+TgF7aNhzO1PLxMOwncfh075WKWHefSK
         itKeLi+gBnUvK4+RJSCFEJASOPYySAQSTL1QdB+iGahFf5XwrfotU6Xludr5q62EnRnr
         0jNU9iFgFvABWsPFN8t+7vjACh/j6ognHrm9bWqkI3tEt7lQyy6iRFa57bLGomZq9S3Z
         hG65tcxNxD6v7UubhuNv434dSIn6ms/V0SCNUwBEQPzii9oIqbhhp0ufv58p9KcGFON0
         QkjctT8doaXTFA6eGC4F3RHzUl3WJ3iJXIltpA1N/1mkBc3YNCwSroz+F3gljioC+HXi
         QAwg==
X-Gm-Message-State: AOJu0YyIPdO1anP6rS86dvULk+3jmCYA+krfw8pYgXZ613ZRHzKjIxOh
        LrbWsxsRkLRIDDmclnKHuwoKkeSkX14L8idqvy3EFt26NiqGNGOocX3BkSRbp5EGx283cOOoC/t
        7FqZ6N8V9LxZPViX2TUnHWkES
X-Received: by 2002:a05:600c:260d:b0:3f9:c0f2:e1a4 with SMTP id h13-20020a05600c260d00b003f9c0f2e1a4mr1193032wma.34.1691748734704;
        Fri, 11 Aug 2023 03:12:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM5FGYsQHTTB71fOI6oOQ2krq+vNUiUvYyUmMCppHrD4n8O065CZj4UeV7oBaakw1EYZmQmA==
X-Received: by 2002:a05:600c:260d:b0:3f9:c0f2:e1a4 with SMTP id h13-20020a05600c260d00b003f9c0f2e1a4mr1193010wma.34.1691748734372;
        Fri, 11 Aug 2023 03:12:14 -0700 (PDT)
Received: from redhat.com ([2.55.27.97])
        by smtp.gmail.com with ESMTPSA id q5-20020a7bce85000000b003fe17e04269sm4717370wmj.40.2023.08.11.03.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 03:12:13 -0700 (PDT)
Date:   Fri, 11 Aug 2023 06:12:10 -0400
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
Message-ID: <20230811060909-mutt-send-email-mst@kernel.org>
References: <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
 <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
 <20230810153744-mutt-send-email-mst@kernel.org>
 <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
 <20230811012147-mutt-send-email-mst@kernel.org>
 <CACGkMEu8gCJGa4aLTrrNdCRYrZXohF0Pdx3a9kBhrhcHyt05-Q@mail.gmail.com>
 <20230811052102-mutt-send-email-mst@kernel.org>
 <CACGkMEuSGQqipR-XT-JWDt8T8KRXVpvDZsrQ6fEcaE4AfOyfwg@mail.gmail.com>
 <20230811054859-mutt-send-email-mst@kernel.org>
 <CACGkMEujbuQRuBBzSdVYah2ZcfRgxLbEKjZjPBeFhLxj5quFhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEujbuQRuBBzSdVYah2ZcfRgxLbEKjZjPBeFhLxj5quFhw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 05:54:15PM +0800, Jason Wang wrote:
> On Fri, Aug 11, 2023 at 5:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Aug 11, 2023 at 05:43:25PM +0800, Jason Wang wrote:
> > > On Fri, Aug 11, 2023 at 5:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Aug 11, 2023 at 05:18:51PM +0800, Jason Wang wrote:
> > > > > On Fri, Aug 11, 2023 at 1:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Aug 11, 2023 at 10:23:15AM +0800, Jason Wang wrote:
> > > > > > > On Fri, Aug 11, 2023 at 3:41 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Aug 08, 2023 at 10:30:56AM +0800, Jason Wang wrote:
> > > > > > > > > On Mon, Jul 31, 2023 at 2:30 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Jul 27, 2023 at 5:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Jul 27, 2023 at 04:59:33PM +0800, Jason Wang wrote:
> > > > > > > > > > > > > They really shouldn't - any NIC that takes forever to
> > > > > > > > > > > > > program will create issues in the networking stack.
> > > > > > > > > > > >
> > > > > > > > > > > > Unfortunately, it's not rare as the device/cvq could be implemented
> > > > > > > > > > > > via firmware or software.
> > > > > > > > > > >
> > > > > > > > > > > Currently that mean one either has sane firmware with a scheduler that
> > > > > > > > > > > can meet deadlines, or loses ability to report errors back.
> > > > > > > > > > >
> > > > > > > > > > > > > But if they do they can always set this flag too.
> > > > > > > > > > > >
> > > > > > > > > > > > This may have false negatives and may confuse the management.
> > > > > > > > > > > >
> > > > > > > > > > > > Maybe we can extend the networking core to allow some device specific
> > > > > > > > > > > > configurations to be done with device specific lock without rtnl. For
> > > > > > > > > > > > example, split the set_channels to
> > > > > > > > > > > >
> > > > > > > > > > > > pre_set_channels
> > > > > > > > > > > > set_channels
> > > > > > > > > > > > post_set_channels
> > > > > > > > > > > >
> > > > > > > > > > > > The device specific part could be done in pre and post without a rtnl lock?
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Would the benefit be that errors can be reported to userspace then?
> > > > > > > > > > > Then maybe.  I think you will have to show how this works for at least
> > > > > > > > > > > one card besides virtio.
> > > > > > > > > >
> > > > > > > > > > Even for virtio, this seems not easy, as e.g the
> > > > > > > > > > virtnet_send_command() and netif_set_real_num_tx_queues() need to
> > > > > > > > > > appear to be atomic to the networking core.
> > > > > > > > > >
> > > > > > > > > > I wonder if we can re-consider the way of a timeout here and choose a
> > > > > > > > > > sane value as a start.
> > > > > > > > >
> > > > > > > > > Michael, any more input on this?
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > >
> > > > > > > > I think this is just mission creep. We are trying to fix
> > > > > > > > vduse - let's do that for starters.
> > > > > > > >
> > > > > > > > Recovering from firmware timeouts is far from trivial and
> > > > > > > > just assuming that just because it timed out it will not
> > > > > > > > access memory is just as likely to cause memory corruption
> > > > > > > > with worse results than an infinite spin.
> > > > > > >
> > > > > > > Yes, this might require support not only in the driver
> > > > > > >
> > > > > > > >
> > > > > > > > I propose we fix this for vduse and assume hardware/firmware
> > > > > > > > is well behaved.
> > > > > > >
> > > > > > > One major case is the re-connection, in that case it might take
> > > > > > > whatever longer that the kernel virito-net driver expects.
> > > > > > > So we can have a timeout in VDUSE and trap CVQ then VDUSE can return
> > > > > > > and fail early?
> > > > > >
> > > > > > Ugh more mission creep. not at all my point. vduse should cache
> > > > > > values in the driver,
> > > > >
> > > > > What do you mean by values here? The cvq command?
> > > > >
> > > > > Thanks
> > > >
> > > > The card status generally.
> > >
> > > Just to make sure I understand here. The CVQ needs to be processed by
> > > the userspace now. How could we cache the status?
> > >
> > > Thanks
> >
> > vduse will have to process it in kernel.
> 
> Right, that's my understanding (trap CVQ).
> 
> Thanks

oh this what you mean by trap. ok. I don't see a new
for a timeout then though.


> >
> > > >
> > > > > > until someone manages to change
> > > > > > net core to be more friendly to userspace devices.
> > > > > >
> > > > > > >
> > > > > > > > Or maybe not well behaved firmware will
> > > > > > > > set the flag losing error reporting ability.
> > > > > > >
> > > > > > > This might be hard since it means not only the set but also the get is
> > > > > > > unreliable.
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > /me shrugs
> > > > > >
> > > > > >
> > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > --
> > > > > > > > > > > MST
> > > > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> >

