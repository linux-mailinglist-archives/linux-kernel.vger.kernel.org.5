Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D3E807ADD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377289AbjLFVxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377405AbjLFVxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:53:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E5CD5F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 13:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701899633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yOEpllxAwSl6tZ982lozHOqBhkjhw8aoaRRTDnS4iew=;
        b=GJk/280LlJst+5PdwtFNpIOq0peVUbLvvj/pF2CZUUd90M9ECfLGK2RwamDl1Yo8gUNWGk
        eX1ckphjB66zpSbJ6urLbmsKryoGm7ZUujH8D98YCU3t2Dg0L8KZAQfuiz/LaVMn3naiZL
        B8lLXXpL8pwDxx9xFtXsOGpnJ4+9YE4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-Ytu4njzBOpezLyfLTPS-6A-1; Wed, 06 Dec 2023 16:53:52 -0500
X-MC-Unique: Ytu4njzBOpezLyfLTPS-6A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33349915da5so209669f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 13:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701899631; x=1702504431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOEpllxAwSl6tZ982lozHOqBhkjhw8aoaRRTDnS4iew=;
        b=FkncL4Xb0csLyMMNlZjeLDJMF5MSkEZJttAagQVqxYXA1vgTbwp5Q0vtkIe6ayLjjM
         eA29hlGwEBFL++kJ2eVbq++YkuQW1K0Cp3kD7Ga7JLpnHKH/mV2lW9Yl+yWMKQEeUP3k
         bIgN43eod0vPPHwpfo3Fgo2FcquKygTes8VEvNzgEyGOuJlG28PsxMIRppGqzLpZ5lAs
         NaRrv8L7zVw/FNrNP9jmWNuSN3w5zj9JBqtqQd0yhjRE2kOEFyTau/eBuoMO/JDu2qII
         zbyPDp/EkQDfbyAOx05BvRu/UdvqWjz6fSAc1qzlcr2+MsPH/CD0lJGFqZha3PTPAdL5
         1ydg==
X-Gm-Message-State: AOJu0YwSLoBrBthxzkZDr0x1M2duS7nQjWVS74Uc2vrBsMnme9mek06a
        x3s6kVY6QZdrrqNLR0utVWOFCHjCIFXXDo3+QKt4bIfLy413Fw6N6Y8H3r8d/DknlUbPepImFJh
        v5/LcknMxJ77Wtk2y+QNkir8E
X-Received: by 2002:a1c:720c:0:b0:40c:25c7:b323 with SMTP id n12-20020a1c720c000000b0040c25c7b323mr416129wmc.125.1701899631157;
        Wed, 06 Dec 2023 13:53:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKupXK9Nk8V+FfPP14UqB6ekz3NO+3af+wasE4pH9WneljAze4p+zMe4/8H113wgoXLXea/w==
X-Received: by 2002:a1c:720c:0:b0:40c:25c7:b323 with SMTP id n12-20020a1c720c000000b0040c25c7b323mr416114wmc.125.1701899630826;
        Wed, 06 Dec 2023 13:53:50 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b00a1d8626d650sm435564ejr.208.2023.12.06.13.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:53:50 -0800 (PST)
Date:   Wed, 6 Dec 2023 16:53:44 -0500
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
Message-ID: <20231206165045-mutt-send-email-mst@kernel.org>
References: <20231206211849.2707151-1-avkrasnov@salutedevices.com>
 <20231206211849.2707151-4-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206211849.2707151-4-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 12:18:48AM +0300, Arseniy Krasnov wrote:
> Add one more condition for sending credit update during dequeue from
> stream socket: when number of bytes in the rx queue is smaller than
> SO_RCVLOWAT value of the socket. This is actual for non-default value
> of SO_RCVLOWAT (e.g. not 1) - idea is to "kick" peer to continue data
> transmission, because we need at least SO_RCVLOWAT bytes in our rx
> queue to wake up user for reading data (in corner case it is also
> possible to stuck both tx and rx sides, this is why 'Fixes' is used).
> Also handle case when 'fwd_cnt' wraps, while 'last_fwd_cnt' is still
> not.
> 
> Fixes: b89d882dc9fc ("vsock/virtio: reduce credit update messages")
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  Changelog:
>  v6 -> v7:
>   * Handle wrap of 'fwd_cnt'.
>   * Do to send credit update when 'fwd_cnt' == 'last_fwd_cnt'.
> 
>  net/vmw_vsock/virtio_transport_common.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index e137d740804e..39f8660d825d 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -558,6 +558,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>  	struct virtio_vsock_sock *vvs = vsk->trans;
>  	size_t bytes, total = 0;
>  	struct sk_buff *skb;
> +	u32 fwd_cnt_delta;
> +	bool low_rx_bytes;
>  	int err = -EFAULT;
>  	u32 free_space;
>  
> @@ -601,7 +603,15 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>  		}
>  	}
>  
> -	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
> +	/* Handle wrap of 'fwd_cnt'. */
> +	if (vvs->fwd_cnt < vvs->last_fwd_cnt)
> +		fwd_cnt_delta = vvs->fwd_cnt + (U32_MAX - vvs->last_fwd_cnt);

Are you sure there's no off by one here? for example if fwd_cnt is 0
and last_fwd_cnt is 0xfffffffff then apparently delta is 0.


> +	else
> +		fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;

I actually don't see what is wrong with just
	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt
32 bit unsigned math will I think handle wrap around correctly.

And given buf_alloc is also u32 - I don't see where the bug is in
the original code.


> +
> +	free_space = vvs->buf_alloc - fwd_cnt_delta;
> +	low_rx_bytes = (vvs->rx_bytes <
> +			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
>  
>  	spin_unlock_bh(&vvs->rx_lock);
>  
> @@ -611,9 +621,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>  	 * too high causes extra messages. Too low causes transmitter
>  	 * stalls. As stalls are in theory more expensive than extra
>  	 * messages, we set the limit to a high value. TODO: experiment
> -	 * with different values.
> +	 * with different values. Also send credit update message when
> +	 * number of bytes in rx queue is not enough to wake up reader.
>  	 */
> -	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> +	if (fwd_cnt_delta &&
> +	    (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE || low_rx_bytes))
>  		virtio_transport_send_credit_update(vsk);
>  
>  	return total;
> -- 
> 2.25.1

