Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C1680F184
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376507AbjLLPyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjLLPyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:54:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323668E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702396463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y2h/9XzsjZfgK8E0eqXIAeotqgk7BYzOrlyS+4E0n94=;
        b=iaypeADoAvDWh0S6XsRoRnCKWJffEsjjmeRz4qtKSBxxOcxPD9+oGhd8Wmw3HDK/Mb+fAZ
        hpYtiygxZ5C2GWQnv4VdRqhbo+6du3VsY0J/N3yO3Ybu8H38TMGxw9OX2AGry/IKHx186E
        sfIcDMCMQpmFrX+PT53uFl6Ai/U6OYI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-CKLkwJ6PPj2mSBkbLdKSpQ-1; Tue, 12 Dec 2023 10:54:22 -0500
X-MC-Unique: CKLkwJ6PPj2mSBkbLdKSpQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c421f2686so19481225e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:54:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702396461; x=1703001261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2h/9XzsjZfgK8E0eqXIAeotqgk7BYzOrlyS+4E0n94=;
        b=luUwSmwjIImEgsphgDqWa3GGoi0Jtz73csEhnM3E8Hs8gcG1AgXVOhD5zgcI4lWKtp
         tdumhwolXpTwG/rbjE5FrMa2HSco6VvWXvzw/7oj0pBeDWgIoVw66S1CkHbwjzabFzbs
         eLGB4cWkhJGyC3VFH1dM/LhE6sDCwYV6GVs57CsOp/YBJYb9iN7nKwsCt1gTWGDuXbBa
         TBrOHuHCRM+FFW7qkgxWfTImE5MKLzIOeqlDF/fDWzdS04fY/spWZ8XJ6bQ+0+tiTOSJ
         acJZHKwHuvDroBiqThB2BKDi3CaOfStU+Jbyu7M9ZebB8eJggJPOWB5iRfpbmUyZDEWH
         0e8w==
X-Gm-Message-State: AOJu0YwGkaogT0NK5iGYIpQYYh3LzdaJtOcwYik66RBrLb50Yv3PlOts
        oD0hzgiTLd9mGb1fmTXJtkBISIrkmSbg9FNZHuJPD/M4sfd6CZu2FYXVwKYdbqqt7tzfxFI/uyx
        xnh1TvRTBm50lGYloGxOUoumq
X-Received: by 2002:a7b:cc82:0:b0:40c:30f8:dce1 with SMTP id p2-20020a7bcc82000000b0040c30f8dce1mr1732747wma.312.1702396460874;
        Tue, 12 Dec 2023 07:54:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJhhRdcg0sgg1jeVxvRyqhKBKMHuUOMmddLacHyE2JT7diifM1UwSyWcZzyvXaXPfNwmicBA==
X-Received: by 2002:a7b:cc82:0:b0:40c:30f8:dce1 with SMTP id p2-20020a7bcc82000000b0040c30f8dce1mr1732739wma.312.1702396460534;
        Tue, 12 Dec 2023 07:54:20 -0800 (PST)
Received: from redhat.com ([2.52.23.105])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d4b90000000b00336363f1608sm497847wrt.105.2023.12.12.07.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 07:54:19 -0800 (PST)
Date:   Tue, 12 Dec 2023 10:54:16 -0500
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
Subject: Re: [PATCH net-next v8 3/4] virtio/vsock: fix logic which reduces
 credit update messages
Message-ID: <20231212105322-mutt-send-email-mst@kernel.org>
References: <20231211211658.2904268-1-avkrasnov@salutedevices.com>
 <20231211211658.2904268-4-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211211658.2904268-4-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 12:16:57AM +0300, Arseniy Krasnov wrote:
> Add one more condition for sending credit update during dequeue from
> stream socket: when number of bytes in the rx queue is smaller than
> SO_RCVLOWAT value of the socket. This is actual for non-default value
> of SO_RCVLOWAT (e.g. not 1) - idea is to "kick" peer to continue data
> transmission, because we need at least SO_RCVLOWAT bytes in our rx
> queue to wake up user for reading data (in corner case it is also
> possible to stuck both tx and rx sides, this is why 'Fixes' is used).

I don't get what does "to stuck both tx and rx sides" mean.
Besides being agrammatical, is there a way to do this without
playing with SO_RCVLOWAT?

> 
> Fixes: b89d882dc9fc ("vsock/virtio: reduce credit update messages")
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  Changelog:
>  v6 -> v7:
>   * Handle wrap of 'fwd_cnt'.
>   * Do to send credit update when 'fwd_cnt' == 'last_fwd_cnt'.
>  v7 -> v8:
>   * Remove unneeded/wrong handling of wrap for 'fwd_cnt'.
> 
>  net/vmw_vsock/virtio_transport_common.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index e137d740804e..8572f94bba88 100644
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
> @@ -601,7 +603,10 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>  		}
>  	}
>  
> -	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
> +	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
> +	free_space = vvs->buf_alloc - fwd_cnt_delta;
> +	low_rx_bytes = (vvs->rx_bytes <
> +			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
>  
>  	spin_unlock_bh(&vvs->rx_lock);
>  
> @@ -611,9 +616,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
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

