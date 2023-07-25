Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E527618AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjGYMqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjGYMqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71788E1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690289157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+eENG+rkrOZJfNjBoNDuehMjca3+lXf+FSwHNM6NvM=;
        b=Q3pwxsYRht1bCByV9HELu/I91IdD81Sk+XIsr7DdhbOgv7uFoCVyFwUiAnzals8ylM1nmH
        FF6StlMXBn+KmBYviChmxpLR/SSzMHOwpcXopOqMu8Nj9zeRrDizmOszN5P+9FQX7pGBuI
        49cL7xSsx0rCTES2Po3tWzjfaRp3ah8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-Ie5kUHW_ObCDOAkePNDzIA-1; Tue, 25 Jul 2023 08:45:54 -0400
X-MC-Unique: Ie5kUHW_ObCDOAkePNDzIA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-98df34aa83aso283336766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690289153; x=1690893953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+eENG+rkrOZJfNjBoNDuehMjca3+lXf+FSwHNM6NvM=;
        b=W8/DjGZk4SDEroUYZP/HCAE7hsbWUUMg83c4iqIh6GjT72UF0NSv3nQetJcEWkHZyN
         oJddgHtDOplSJoHLf7ESjr07lmMnVjH9gtznrAcEqTcewsn8v38jqx+CR3Zz7s2b/gUP
         li3YXtQ0YoEqZV4Ue7AEHCU2ltr2eTc5wUd+i4jD4Xku2QOLvZezjFVcrdpxITmadTKB
         yyMuotm1OGiPp3HDVWzxloItXU2WmLLW7U9OerGwNw9+eNpdjN4+GDAP7QrJnfDinI+E
         JgzF8BjL3RCms+kf3R45FlzD2gX4gDY0xkQSsKjxL5rDdnC51Dy/AmHMTqTD8DFMsTjQ
         h1Ug==
X-Gm-Message-State: ABy/qLavII95ZTgjlxDX/930/FpeR6yEb9lAB/nkgXv/StnkxPRWNz+o
        an4UKVleAfGPi2pDqbi3NKV7Yz5Oyz2IdGvVy5KdEr0jFa++W+QI4RBMdU1v1yTt1Qt/8nGotZ0
        YJRux5I361O2kqg1e5yZ4y2wR
X-Received: by 2002:a17:906:3f1a:b0:998:de72:4c8c with SMTP id c26-20020a1709063f1a00b00998de724c8cmr2222694ejj.35.1690289153283;
        Tue, 25 Jul 2023 05:45:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGeHiAYNGInnQAlVCX6nTI06/NOjTDYIJ/hUEthWuPlIk7sS6sNyToq0hN/g++ZIu00x02Vnw==
X-Received: by 2002:a17:906:3f1a:b0:998:de72:4c8c with SMTP id c26-20020a1709063f1a00b00998de724c8cmr2222669ejj.35.1690289152923;
        Tue, 25 Jul 2023 05:45:52 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.201.198])
        by smtp.gmail.com with ESMTPSA id se10-20020a170906ce4a00b0098dfec235ccsm8106374ejb.47.2023.07.25.05.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:45:52 -0700 (PDT)
Date:   Tue, 25 Jul 2023 14:45:48 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH net-next v3 4/4] vsock/virtio: MSG_ZEROCOPY flag support
Message-ID: <fwtkhndptzz42r23p622zggr5yxyfms7ymylelahmofw2zr26z@ygd7wyhfi7fs>
References: <20230720214245.457298-1-AVKrasnov@sberdevices.ru>
 <20230720214245.457298-5-AVKrasnov@sberdevices.ru>
 <091c067b-43a0-da7f-265f-30c8c7e62977@sberdevices.ru>
 <2k3cbz762ua3fmlben5vcm7rs624sktaltbz3ldeevwiguwk2w@klggxj5e3ueu>
 <51022d5f-5b50-b943-ad92-b06f60bef433@sberdevices.ru>
 <3d1d76c9-2fdb-3dfe-222a-b2184cf17708@sberdevices.ru>
 <o6axh6mxd6mxai2zrpax6wa25slns7ysz5xsegntskvfxl53mt@wowjgb3jazt6>
 <20230725083823-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725083823-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:39:17AM -0400, Michael S. Tsirkin wrote:
>On Tue, Jul 25, 2023 at 02:28:02PM +0200, Stefano Garzarella wrote:
>> On Tue, Jul 25, 2023 at 12:16:11PM +0300, Arseniy Krasnov wrote:
>> >
>> >
>> > On 25.07.2023 11:46, Arseniy Krasnov wrote:
>> > >
>> > >
>> > > On 25.07.2023 11:43, Stefano Garzarella wrote:
>> > > > On Fri, Jul 21, 2023 at 08:09:03AM +0300, Arseniy Krasnov wrote:
>> > > > >
>> > > > >
>> > > > > On 21.07.2023 00:42, Arseniy Krasnov wrote:
>> > > > > > This adds handling of MSG_ZEROCOPY flag on transmission path: if this
>> > > > > > flag is set and zerocopy transmission is possible (enabled in socket
>> > > > > > options and transport allows zerocopy), then non-linear skb will be
>> > > > > > created and filled with the pages of user's buffer. Pages of user's
>> > > > > > buffer are locked in memory by 'get_user_pages()'. Second thing that
>> > > > > > this patch does is replace type of skb owning: instead of calling
>> > > > > > 'skb_set_owner_sk_safe()' it calls 'skb_set_owner_w()'. Reason of this
>> > > > > > change is that '__zerocopy_sg_from_iter()' increments 'sk_wmem_alloc'
>> > > > > > of socket, so to decrease this field correctly proper skb destructor is
>> > > > > > needed: 'sock_wfree()'. This destructor is set by 'skb_set_owner_w()'.
>> > > > > >
>> > > > > > Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> > > > > > ---
>> > > > > >  Changelog:
>> > > > > >  v5(big patchset) -> v1:
>> > > > > >   * Refactorings of 'if' conditions.
>> > > > > >   * Remove extra blank line.
>> > > > > >   * Remove 'frag_off' field unneeded init.
>> > > > > >   * Add function 'virtio_transport_fill_skb()' which fills both linear
>> > > > > >     and non-linear skb with provided data.
>> > > > > >  v1 -> v2:
>> > > > > >   * Use original order of last four arguments in 'virtio_transport_alloc_skb()'.
>> > > > > >  v2 -> v3:
>> > > > > >   * Add new transport callback: 'msgzerocopy_check_iov'. It checks that
>> > > > > >     provided 'iov_iter' with data could be sent in a zerocopy mode.
>> > > > > >     If this callback is not set in transport - transport allows to send
>> > > > > >     any 'iov_iter' in zerocopy mode. Otherwise - if callback returns 'true'
>> > > > > >     then zerocopy is allowed. Reason of this callback is that in case of
>> > > > > >     G2H transmission we insert whole skb to the tx virtio queue and such
>> > > > > >     skb must fit to the size of the virtio queue to be sent in a single
>> > > > > >     iteration (may be tx logic in 'virtio_transport.c' could be reworked
>> > > > > >     as in vhost to support partial send of current skb). This callback
>> > > > > >     will be enabled only for G2H path. For details pls see comment
>> > > > > >     'Check that tx queue...' below.
>> > > > > >
>> > > > > >  include/net/af_vsock.h                  |   3 +
>> > > > > >  net/vmw_vsock/virtio_transport.c        |  39 ++++
>> > > > > >  net/vmw_vsock/virtio_transport_common.c | 257 ++++++++++++++++++------
>> > > > > >  3 files changed, 241 insertions(+), 58 deletions(-)
>> > > > > >
>> > > > > > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>> > > > > > index 0e7504a42925..a6b346eeeb8e 100644
>> > > > > > --- a/include/net/af_vsock.h
>> > > > > > +++ b/include/net/af_vsock.h
>> > > > > > @@ -177,6 +177,9 @@ struct vsock_transport {
>> > > > > >
>> > > > > >      /* Read a single skb */
>> > > > > >      int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
>> > > > > > +
>> > > > > > +    /* Zero-copy. */
>> > > > > > +    bool (*msgzerocopy_check_iov)(const struct iov_iter *);
>> > > > > >  };
>> > > > > >
>> > > > > >  /**** CORE ****/
>> > > > > > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>> > > > > > index 7bbcc8093e51..23cb8ed638c4 100644
>> > > > > > --- a/net/vmw_vsock/virtio_transport.c
>> > > > > > +++ b/net/vmw_vsock/virtio_transport.c
>> > > > > > @@ -442,6 +442,43 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
>> > > > > >      queue_work(virtio_vsock_workqueue, &vsock->rx_work);
>> > > > > >  }
>> > > > > >
>> > > > > > +static bool
>> > > > > > virtio_transport_msgzerocopy_check_iov(const struct
>> > > > > > iov_iter *iov)
>> > > > > > +{
>> > > > > > +    struct virtio_vsock *vsock;
>> > > > > > +    bool res = false;
>> > > > > > +
>> > > > > > +    rcu_read_lock();
>> > > > > > +
>> > > > > > +    vsock = rcu_dereference(the_virtio_vsock);
>> > > > > > +    if (vsock) {
>>
>> Just noted, what about the following to reduce the indentation?
>>
>>         if (!vsock) {
>>             goto out;
>>         }
>
>no {} pls

ooops, true, too much QEMU code today, but luckily checkpatch would have
spotted it ;-)

>
>>             ...
>>             ...
>>     out:
>>         rcu_read_unlock();
>>         return res;
>
>indentation is quite modest here. Not sure goto is worth it.

It's a pattern we follow a lot in this file, and I find the early
return/goto more readable.
Anyway, I don't have a strong opinion, it's fine the way it is now,
actually we don't have too many indentations for now in this function.

Thanks,
Stefano

