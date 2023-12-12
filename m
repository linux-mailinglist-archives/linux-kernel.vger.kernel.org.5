Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5444380F208
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjLLQMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjLLQMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:12:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D94AA1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702397562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73Y77tPLmgg9X166NzbyHTwHM16bRnjvtwZKK18ICnw=;
        b=W5avMkIJCQIMJ4epsFZXexFeGDLwoZO6rrlroHzzeBG66YfZ7JGOKhQ198NWsIGXFQCzNg
        7IhsTqsixED6la1AZeWE5Td/RKSBUX5WnTi9dJ/XwDkSL8zMMkkBXwCx9ZtLG7hzm/zRGd
        NTw6hSR2tjQnEAn9JlWe5jv1MJg7uBU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-XdPFtulIOW20bLhIVwQsaA-1; Tue, 12 Dec 2023 11:12:41 -0500
X-MC-Unique: XdPFtulIOW20bLhIVwQsaA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c412c62d8so22590035e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397560; x=1703002360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73Y77tPLmgg9X166NzbyHTwHM16bRnjvtwZKK18ICnw=;
        b=iYnexHrLGQGdOlEwJOSQ81UXQAZ12WqF2Q8A1kQpLOjpg1rFBY6o9nGJKqmAjhsiLQ
         xeoydfVQu+0QEsQ1IGhcSA5m96nD2qwECdji208yX8oN+uA2N3u5d8KFnXwu1f3WIgaj
         qPVZed1K9W+1m+yvyGwTMOwKdCyn/VdIgT0WYGwpMSXTkNzmybMvh13Cp61LWDKq4jqR
         64CuJasoVD7aT5/vtU+0NULtyDawqtqvY36v7VL1VHVIzsfP9qyLraZzUSA9o+U7wYZp
         xecdXlt81rRn8d53ofnAgEF2DqzrWDsukbuH4aveWMIm1PUMdf+Gt3CTzj1mmRHbnlaa
         lIDA==
X-Gm-Message-State: AOJu0Yy618XEU8p4NQlV4FCRh2TegNgj2PXrEQnOcXLFeEahKK1Ugn0e
        yTTYWVzR8B34OWDYKZjK6xfk1r2GC4Dnft1v8J2yaUA3+Gv0sFG6fL5Da9fYS5Yu5Bazml2m5vh
        XP4lR+ztzc+38Xi9yWr0EMryr
X-Received: by 2002:a7b:cc0c:0:b0:40c:3e8c:74fa with SMTP id f12-20020a7bcc0c000000b0040c3e8c74famr3240809wmh.70.1702397559976;
        Tue, 12 Dec 2023 08:12:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyb1/I2wKTLMi+hetTQnpC0FPFzMqzR4AJJQa8dDCJSD0J7Uw3hfcLHdSCE9DDEEdCK5s0fA==
X-Received: by 2002:a7b:cc0c:0:b0:40c:3e8c:74fa with SMTP id f12-20020a7bcc0c000000b0040c3e8c74famr3240796wmh.70.1702397559537;
        Tue, 12 Dec 2023 08:12:39 -0800 (PST)
Received: from redhat.com ([2.52.23.105])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d5641000000b00333dbecdce3sm11134355wrw.62.2023.12.12.08.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:12:38 -0800 (PST)
Date:   Tue, 12 Dec 2023 11:12:35 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH net-next v8 0/4] send credit update during setting
 SO_RCVLOWAT
Message-ID: <20231212111131-mutt-send-email-mst@kernel.org>
References: <20231211211658.2904268-1-avkrasnov@salutedevices.com>
 <20231212105423-mutt-send-email-mst@kernel.org>
 <d27f22f0-0f1e-e1bb-5b13-a524dc6e94d7@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d27f22f0-0f1e-e1bb-5b13-a524dc6e94d7@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 06:59:03PM +0300, Arseniy Krasnov wrote:
> 
> 
> On 12.12.2023 18:54, Michael S. Tsirkin wrote:
> > On Tue, Dec 12, 2023 at 12:16:54AM +0300, Arseniy Krasnov wrote:
> >> Hello,
> >>
> >>                                DESCRIPTION
> >>
> >> This patchset fixes old problem with hungup of both rx/tx sides and adds
> >> test for it. This happens due to non-default SO_RCVLOWAT value and
> >> deferred credit update in virtio/vsock. Link to previous old patchset:
> >> https://lore.kernel.org/netdev/39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru/
> > 
> > 
> > Patchset:
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Thanks!
> 
> > 
> > 
> > But I worry whether we actually need 3/8 in net not in net-next.
> 
> Because of "Fixes" tag ? I think this problem is not critical and reproducible
> only in special cases, but i'm not familiar with netdev process so good, so I don't
> have strong opinion. I guess @Stefano knows better.
> 
> Thanks, Arseniy

Fixes means "if you have that other commit then you need this commit
too". I think as a minimum you need to rearrange patches to make the
fix go in first. We don't want a regression followed by a fix.

> > 
> > Thanks!
> > 
> >> Here is what happens step by step:
> >>
> >>                                   TEST
> >>
> >>                             INITIAL CONDITIONS
> >>
> >> 1) Vsock buffer size is 128KB.
> >> 2) Maximum packet size is also 64KB as defined in header (yes it is
> >>    hardcoded, just to remind about that value).
> >> 3) SO_RCVLOWAT is default, e.g. 1 byte.
> >>
> >>
> >>                                  STEPS
> >>
> >>             SENDER                              RECEIVER
> >> 1) sends 128KB + 1 byte in a
> >>    single buffer. 128KB will
> >>    be sent, but for 1 byte
> >>    sender will wait for free
> >>    space at peer. Sender goes
> >>    to sleep.
> >>
> >>
> >> 2)                                     reads 64KB, credit update not sent
> >> 3)                                     sets SO_RCVLOWAT to 64KB + 1
> >> 4)                                     poll() -> wait forever, there is
> >>                                        only 64KB available to read.
> >>
> >> So in step 4) receiver also goes to sleep, waiting for enough data or
> >> connection shutdown message from the sender. Idea to fix it is that rx
> >> kicks tx side to continue transmission (and may be close connection)
> >> when rx changes number of bytes to be woken up (e.g. SO_RCVLOWAT) and
> >> this value is bigger than number of available bytes to read.
> >>
> >> I've added small test for this, but not sure as it uses hardcoded value
> >> for maximum packet length, this value is defined in kernel header and
> >> used to control deferred credit update. And as this is not available to
> >> userspace, I can't control test parameters correctly (if one day this
> >> define will be changed - test may become useless). 
> >>
> >> Head for this patchset is:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=021b0c952f226236f2edf89c737efb9a28d1422d
> >>
> >> Link to v1:
> >> https://lore.kernel.org/netdev/20231108072004.1045669-1-avkrasnov@salutedevices.com/
> >> Link to v2:
> >> https://lore.kernel.org/netdev/20231119204922.2251912-1-avkrasnov@salutedevices.com/
> >> Link to v3:
> >> https://lore.kernel.org/netdev/20231122180510.2297075-1-avkrasnov@salutedevices.com/
> >> Link to v4:
> >> https://lore.kernel.org/netdev/20231129212519.2938875-1-avkrasnov@salutedevices.com/
> >> Link to v5:
> >> https://lore.kernel.org/netdev/20231130130840.253733-1-avkrasnov@salutedevices.com/
> >> Link to v6:
> >> https://lore.kernel.org/netdev/20231205064806.2851305-1-avkrasnov@salutedevices.com/
> >> Link to v7:
> >> https://lore.kernel.org/netdev/20231206211849.2707151-1-avkrasnov@salutedevices.com/
> >>
> >> Changelog:
> >> v1 -> v2:
> >>  * Patchset rebased and tested on new HEAD of net-next (see hash above).
> >>  * New patch is added as 0001 - it removes return from SO_RCVLOWAT set
> >>    callback in 'af_vsock.c' when transport callback is set - with that
> >>    we can set 'sk_rcvlowat' only once in 'af_vsock.c' and in future do
> >>    not copy-paste it to every transport. It was discussed in v1.
> >>  * See per-patch changelog after ---.
> >> v2 -> v3:
> >>  * See changelog after --- in 0003 only (0001 and 0002 still same).
> >> v3 -> v4:
> >>  * Patchset rebased and tested on new HEAD of net-next (see hash above).
> >>  * See per-patch changelog after ---.
> >> v4 -> v5:
> >>  * Change patchset tag 'RFC' -> 'net-next'.
> >>  * See per-patch changelog after ---.
> >> v5 -> v6:
> >>  * New patch 0003 which sends credit update during reading bytes from
> >>    socket.
> >>  * See per-patch changelog after ---.
> >> v6 -> v7:
> >>  * Patchset rebased and tested on new HEAD of net-next (see hash above).
> >>  * See per-patch changelog after ---.
> >> v7 -> v8:
> >>  * See per-patch changelog after ---.
> >>
> >> Arseniy Krasnov (4):
> >>   vsock: update SO_RCVLOWAT setting callback
> >>   virtio/vsock: send credit update during setting SO_RCVLOWAT
> >>   virtio/vsock: fix logic which reduces credit update messages
> >>   vsock/test: two tests to check credit update logic
> >>
> >>  drivers/vhost/vsock.c                   |   1 +
> >>  include/linux/virtio_vsock.h            |   1 +
> >>  include/net/af_vsock.h                  |   2 +-
> >>  net/vmw_vsock/af_vsock.c                |   9 +-
> >>  net/vmw_vsock/hyperv_transport.c        |   4 +-
> >>  net/vmw_vsock/virtio_transport.c        |   1 +
> >>  net/vmw_vsock/virtio_transport_common.c |  43 +++++-
> >>  net/vmw_vsock/vsock_loopback.c          |   1 +
> >>  tools/testing/vsock/vsock_test.c        | 175 ++++++++++++++++++++++++
> >>  9 files changed, 229 insertions(+), 8 deletions(-)
> >>
> >> -- 
> >> 2.25.1
> > 

