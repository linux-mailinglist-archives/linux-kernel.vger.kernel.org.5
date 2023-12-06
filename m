Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FA7807B1F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377278AbjLFWIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346663AbjLFWII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:08:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E50C93
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 14:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701900493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3cM3G3IxJYLM5tCOwlfSEThSnIq2Ia0o8pmJScU+oeA=;
        b=c65bQ25bX9wEkBptRM48Sq0Y4u2VsCkmZ4JmFdDidgIZRoytkDU7GMpeF5DT9NU/W42N8m
        2b256vZrMcH8f8AxGRpkDuQFtkZ3pxLKIM3JcVgh5NUYd7u2Guabzy+znJfzSegf6ABts3
        +SFrXa0rsG8ChS7IB5F4s3Tq+aYBx6I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-72gbw_7uPpuFkI3Y5phPNg-1; Wed, 06 Dec 2023 17:08:10 -0500
X-MC-Unique: 72gbw_7uPpuFkI3Y5phPNg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1db7b26269so14429266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 14:08:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701900488; x=1702505288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cM3G3IxJYLM5tCOwlfSEThSnIq2Ia0o8pmJScU+oeA=;
        b=kjuoLQgXgm4e2c6YbuFLBvCpFkRZVt0i2YAmxf6NmIa9uotqfZy2bWfvlACml8HcwL
         LMZC417RlHBxZ9ppROhNbgu9uCsRmGdV44Ie44cBNKzDwd91/JEIn4uePGYT1dMgmTHU
         Ck9/TWF+JBYmT7nkinTyEF05vbxEJZezf8zAk80OoxQy7ZOpAlbz30OnhDHaE+3B7BOJ
         Rc+Ve3IjKluGLEpDXAgBx3g1rDJq9JWEhX+nUizu6jULH+Ov54c8pZMd3VrVyrYiAAB7
         qrG/tA4b8DiugnMK6Rum3kfhde2A7bxqnhEkjBbMnj4IXXA+nmgXW3G2XeiGyFK+63nq
         4Rxw==
X-Gm-Message-State: AOJu0YzDnlCJj9gqLl+kGmszpgylHLU/zZpbOCJB3OwZaOQ8PP1Cmz6q
        k2e9Mt+ZbvplX6O2hy6OK3enyE9fxFy0UYkH6Ax76wUreVrm+Que1HdPocFOUTT152RzZfDwQEJ
        bhuZm1vYjmL4/9PoyISqNz4ZI
X-Received: by 2002:a17:906:225a:b0:a01:9d8b:db17 with SMTP id 26-20020a170906225a00b00a019d8bdb17mr1089772ejr.15.1701900488769;
        Wed, 06 Dec 2023 14:08:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELc1CseN/Lgd5NWinZpBx+NzuVrz10mseWrWKMVnwyTe6bCu+laowzD1kdbkuuvmu6nxMTFQ==
X-Received: by 2002:a17:906:225a:b0:a01:9d8b:db17 with SMTP id 26-20020a170906225a00b00a019d8bdb17mr1089759ejr.15.1701900488420;
        Wed, 06 Dec 2023 14:08:08 -0800 (PST)
Received: from redhat.com ([2.55.11.67])
        by smtp.gmail.com with ESMTPSA id d25-20020a170906371900b00a1d754b30a9sm462436ejc.86.2023.12.06.14.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 14:08:07 -0800 (PST)
Date:   Wed, 6 Dec 2023 17:08:02 -0500
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
Subject: Re: [PATCH net-next v7 3/4] virtio/vsock: fix logic which reduces
 credit update messages
Message-ID: <20231206170640-mutt-send-email-mst@kernel.org>
References: <20231206211849.2707151-1-avkrasnov@salutedevices.com>
 <20231206211849.2707151-4-avkrasnov@salutedevices.com>
 <20231206165045-mutt-send-email-mst@kernel.org>
 <d9d1ec6a-dd9b-61d9-9211-52e9437cbb1f@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9d1ec6a-dd9b-61d9-9211-52e9437cbb1f@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 12:52:51AM +0300, Arseniy Krasnov wrote:
> 
> 
> On 07.12.2023 00:53, Michael S. Tsirkin wrote:
> > On Thu, Dec 07, 2023 at 12:18:48AM +0300, Arseniy Krasnov wrote:
> >> Add one more condition for sending credit update during dequeue from
> >> stream socket: when number of bytes in the rx queue is smaller than
> >> SO_RCVLOWAT value of the socket. This is actual for non-default value
> >> of SO_RCVLOWAT (e.g. not 1) - idea is to "kick" peer to continue data
> >> transmission, because we need at least SO_RCVLOWAT bytes in our rx
> >> queue to wake up user for reading data (in corner case it is also
> >> possible to stuck both tx and rx sides, this is why 'Fixes' is used).
> >> Also handle case when 'fwd_cnt' wraps, while 'last_fwd_cnt' is still
> >> not.
> >>
> >> Fixes: b89d882dc9fc ("vsock/virtio: reduce credit update messages")
> >> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> >> ---
> >>  Changelog:
> >>  v6 -> v7:
> >>   * Handle wrap of 'fwd_cnt'.
> >>   * Do to send credit update when 'fwd_cnt' == 'last_fwd_cnt'.
> >>
> >>  net/vmw_vsock/virtio_transport_common.c | 18 +++++++++++++++---
> >>  1 file changed, 15 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >> index e137d740804e..39f8660d825d 100644
> >> --- a/net/vmw_vsock/virtio_transport_common.c
> >> +++ b/net/vmw_vsock/virtio_transport_common.c
> >> @@ -558,6 +558,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> >>  	struct virtio_vsock_sock *vvs = vsk->trans;
> >>  	size_t bytes, total = 0;
> >>  	struct sk_buff *skb;
> >> +	u32 fwd_cnt_delta;
> >> +	bool low_rx_bytes;
> >>  	int err = -EFAULT;
> >>  	u32 free_space;
> >>  
> >> @@ -601,7 +603,15 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> >>  		}
> >>  	}
> >>  
> >> -	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
> >> +	/* Handle wrap of 'fwd_cnt'. */
> >> +	if (vvs->fwd_cnt < vvs->last_fwd_cnt)
> >> +		fwd_cnt_delta = vvs->fwd_cnt + (U32_MAX - vvs->last_fwd_cnt);
> > 
> > Are you sure there's no off by one here? for example if fwd_cnt is 0
> > and last_fwd_cnt is 0xfffffffff then apparently delta is 0.
> 
> Seems yes, I need +1 here

And then you will get a nop, because assigning U32_MAX + 1 to u32
gives you 0. Adding () does nothing to change the result,
+ and - are commutative.


> > 
> > 
> >> +	else
> >> +		fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
> > 
> > I actually don't see what is wrong with just
> > 	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt
> > 32 bit unsigned math will I think handle wrap around correctly.
> > 
> > And given buf_alloc is also u32 - I don't see where the bug is in
> > the original code.
> 
> I think problem is when fwd_cnt wraps, while last_fwd_cnt is not. In this
> case fwd_cnt_delta will be too big, so we won't send credit update which
> leads to stall for sender
> 
> Thanks, Arseniy

Care coming up with an example?


> > 
> > 
> >> +
> >> +	free_space = vvs->buf_alloc - fwd_cnt_delta;
> >> +	low_rx_bytes = (vvs->rx_bytes <
> >> +			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
> >>  
> >>  	spin_unlock_bh(&vvs->rx_lock);
> >>  
> >> @@ -611,9 +621,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> >>  	 * too high causes extra messages. Too low causes transmitter
> >>  	 * stalls. As stalls are in theory more expensive than extra
> >>  	 * messages, we set the limit to a high value. TODO: experiment
> >> -	 * with different values.
> >> +	 * with different values. Also send credit update message when
> >> +	 * number of bytes in rx queue is not enough to wake up reader.
> >>  	 */
> >> -	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> >> +	if (fwd_cnt_delta &&
> >> +	    (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE || low_rx_bytes))
> >>  		virtio_transport_send_credit_update(vsk);
> >>  
> >>  	return total;
> >> -- 
> >> 2.25.1
> > 

