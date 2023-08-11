Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B821F778706
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjHKFnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjHKFm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCD210C7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691732531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FeOvN75tWxQhwMQjRUNg3DV6YRE1tdWFw7PsggN2KNo=;
        b=dXux5zX1BRBHG4u7IHxTKtEL8Cay8sHgbeWEWJ/vBBgMqtzsXqcpphh+0A+XvLcgC200kN
        5EU/eCrkm4WTMdiyLvlbDCMmSzOfStS+E3iCmAWR56JrG3lTT8mB1/mjlt9SfRIpnUTC1/
        fvDZu6q6vlPyyF7cT8BEq3EwozXebzc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-l6xNwuPHNgy53ba7GfjufQ-1; Fri, 11 Aug 2023 01:42:09 -0400
X-MC-Unique: l6xNwuPHNgy53ba7GfjufQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30e3ee8a42eso988989f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691732528; x=1692337328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeOvN75tWxQhwMQjRUNg3DV6YRE1tdWFw7PsggN2KNo=;
        b=B3VkveOcBbgiliHfj7UYNz3N9SJAqlv0bLt/BtqDNZMSRpqGd4bAodD1QUSNL+7jNr
         QA91azZuu7uu5tE3ppaXFzIHDn0+YD2Pl4VlWR//Ty0sLTZqj2NfscZOvNYkxDbpyaMe
         I2BI/R200bDdt6VMlbS5qVClfaGiMXqdhLOmNhLMJGYPOWcXy6tZ6zb7Tx6arCRjKO3Q
         /SVH1gyG7qTZXliv0/C8gP1MJ00QRswdE9mlboNJl3GUz7KHJSGfVzLOr67nKYGnhK0h
         6zD77n81Fy1fF72AOzMyhPJywpXGzmMRwByymI4Hw1wKfWqtBwVthDCz7/U2rocJ91mh
         /Nhg==
X-Gm-Message-State: AOJu0YwnmaqPDNM9Pb/pctg9UvphPGo1RoNNMccBrlv14WWLuBN1w9mp
        iSG5Ru+HiLKCvr9RACA1UaUABISj3fRcHmG43wDaXo8GxsetoebhJh3LOrg7gry+fHSqrVG2M6e
        p7jn/FMBN2ji8owdoGV28EsAj
X-Received: by 2002:a5d:4dce:0:b0:315:ad1a:5abc with SMTP id f14-20020a5d4dce000000b00315ad1a5abcmr560343wru.5.1691732528059;
        Thu, 10 Aug 2023 22:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGChBTfjXHd170xzQjiykK6EKOoZmHX+FMr/7ZWK7WQpPsGbiHHN5KVtW18EcCe7s909p9kg==
X-Received: by 2002:a5d:4dce:0:b0:315:ad1a:5abc with SMTP id f14-20020a5d4dce000000b00315ad1a5abcmr560328wru.5.1691732527474;
        Thu, 10 Aug 2023 22:42:07 -0700 (PDT)
Received: from redhat.com ([2.55.42.146])
        by smtp.gmail.com with ESMTPSA id r10-20020a5d52ca000000b003140fff4f75sm4279428wrv.17.2023.08.10.22.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 22:42:06 -0700 (PDT)
Date:   Fri, 11 Aug 2023 01:42:02 -0400
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
Message-ID: <20230811012147-mutt-send-email-mst@kernel.org>
References: <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org>
 <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org>
 <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org>
 <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
 <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
 <20230810153744-mutt-send-email-mst@kernel.org>
 <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:23:15AM +0800, Jason Wang wrote:
> On Fri, Aug 11, 2023 at 3:41 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Aug 08, 2023 at 10:30:56AM +0800, Jason Wang wrote:
> > > On Mon, Jul 31, 2023 at 2:30 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Thu, Jul 27, 2023 at 5:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Thu, Jul 27, 2023 at 04:59:33PM +0800, Jason Wang wrote:
> > > > > > > They really shouldn't - any NIC that takes forever to
> > > > > > > program will create issues in the networking stack.
> > > > > >
> > > > > > Unfortunately, it's not rare as the device/cvq could be implemented
> > > > > > via firmware or software.
> > > > >
> > > > > Currently that mean one either has sane firmware with a scheduler that
> > > > > can meet deadlines, or loses ability to report errors back.
> > > > >
> > > > > > > But if they do they can always set this flag too.
> > > > > >
> > > > > > This may have false negatives and may confuse the management.
> > > > > >
> > > > > > Maybe we can extend the networking core to allow some device specific
> > > > > > configurations to be done with device specific lock without rtnl. For
> > > > > > example, split the set_channels to
> > > > > >
> > > > > > pre_set_channels
> > > > > > set_channels
> > > > > > post_set_channels
> > > > > >
> > > > > > The device specific part could be done in pre and post without a rtnl lock?
> > > > > >
> > > > > > Thanks
> > > > >
> > > > >
> > > > > Would the benefit be that errors can be reported to userspace then?
> > > > > Then maybe.  I think you will have to show how this works for at least
> > > > > one card besides virtio.
> > > >
> > > > Even for virtio, this seems not easy, as e.g the
> > > > virtnet_send_command() and netif_set_real_num_tx_queues() need to
> > > > appear to be atomic to the networking core.
> > > >
> > > > I wonder if we can re-consider the way of a timeout here and choose a
> > > > sane value as a start.
> > >
> > > Michael, any more input on this?
> > >
> > > Thanks
> >
> > I think this is just mission creep. We are trying to fix
> > vduse - let's do that for starters.
> >
> > Recovering from firmware timeouts is far from trivial and
> > just assuming that just because it timed out it will not
> > access memory is just as likely to cause memory corruption
> > with worse results than an infinite spin.
> 
> Yes, this might require support not only in the driver
> 
> >
> > I propose we fix this for vduse and assume hardware/firmware
> > is well behaved.
> 
> One major case is the re-connection, in that case it might take
> whatever longer that the kernel virito-net driver expects.
> So we can have a timeout in VDUSE and trap CVQ then VDUSE can return
> and fail early?

Ugh more mission creep. not at all my point. vduse should cache
values in the driver, until someone manages to change
net core to be more friendly to userspace devices.

> 
> > Or maybe not well behaved firmware will
> > set the flag losing error reporting ability.
> 
> This might be hard since it means not only the set but also the get is
> unreliable.
> 
> Thanks

/me shrugs



> >
> >
> >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > >
> > > > > --
> > > > > MST
> > > > >
> >

