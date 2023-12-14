Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06240812CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443623AbjLNKYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443617AbjLNKYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:24:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9160E0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702549490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DSSH8LtzM2s/nHi8p5P1p50CtgKbNQDA/Xelk2DiA14=;
        b=HP4qSm2La8BFs5PuUsColw3oP1quGz6AGYQ2aYJlpJh2PJBuWU4OEaP/TRKryl0BZUkVdh
        BhIGb9+vW1f0Po2UKHiR2q++2nBFC73oqXJ9M2J2Dar2rWqfQK7B4BIdnkC0vJzF1kMYi3
        jriaGF59wNIiRKOPqnJNI9AllVvHl3g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-LALcHKd5N0Cj6DGEm-krGw-1; Thu, 14 Dec 2023 05:24:46 -0500
X-MC-Unique: LALcHKd5N0Cj6DGEm-krGw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1f99dd182dso260860666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702549485; x=1703154285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSSH8LtzM2s/nHi8p5P1p50CtgKbNQDA/Xelk2DiA14=;
        b=UhMp65D4TbWdOMbFcPR2M9oxF7kNPSBEKpxJscpShfSf0GoZQH7mMd7clSDRa10n3c
         2yK1JNz43s2UjguW8R1sbVjySHOVUblqdX6Z39b3uwduQw6ptoMUsV0FLwyvw0lDk2Y7
         arBSfd/yYSlB4wdspVrSWLPkPgu4St5tWxA9YToFwTJUBErAx6V4j0jDtxFKCgafz5WL
         tT6oi60yviqSSk+XjOMx1qLBAtCChUI8mhNvNJRN6M1XAd06CNYy/UtxTW4q5Gs2WcRz
         0wrE4fPjON3QQRRlKtmZjVutOX5DyXFVef/t5BKbEPKNHNbsMz6DwqlIqML9GgWS1nil
         cPrQ==
X-Gm-Message-State: AOJu0YxLlsy18utjuz9tGnzipH/69YltICo7cxvayAJGlcjdMsaNi5Dc
        UW48j2ACRvUBP2pW3WY/iTBlpP1atpVPCF6ch7keSQdQ/AvXEANEFjAwH7+/6ZW5csiwGUkj6TX
        SaQYS1LFkCI+Li731uS7t+/Fg
X-Received: by 2002:a17:907:3a97:b0:a1f:7352:3c0 with SMTP id fh23-20020a1709073a9700b00a1f735203c0mr4111140ejc.59.1702549485733;
        Thu, 14 Dec 2023 02:24:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ4mtbeRMe02kWwF6Hh+xBcu1mR/wHuPokTQ+4Rni40u2pBzA16VxW6ly8OowEf1SbmDDVig==
X-Received: by 2002:a17:907:3a97:b0:a1f:7352:3c0 with SMTP id fh23-20020a1709073a9700b00a1f735203c0mr4111122ejc.59.1702549485320;
        Thu, 14 Dec 2023 02:24:45 -0800 (PST)
Received: from redhat.com ([2.52.132.243])
        by smtp.gmail.com with ESMTPSA id vv6-20020a170907a68600b00a1dff479037sm9103575ejc.127.2023.12.14.02.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:24:44 -0800 (PST)
Date:   Thu, 14 Dec 2023 05:24:40 -0500
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
Subject: Re: [PATCH net-next v9 2/4] virtio/vsock: send credit update during
 setting SO_RCVLOWAT
Message-ID: <20231214052234-mutt-send-email-mst@kernel.org>
References: <20231214091947.395892-1-avkrasnov@salutedevices.com>
 <20231214091947.395892-3-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214091947.395892-3-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 12:19:45PM +0300, Arseniy Krasnov wrote:
> Send credit update message when SO_RCVLOWAT is updated and it is bigger
> than number of bytes in rx queue. It is needed, because 'poll()' will
> wait until number of bytes in rx queue will be not smaller than
> SO_RCVLOWAT, so kick sender to send more data. Otherwise mutual hungup
> for tx/rx is possible: sender waits for free space and receiver is
> waiting data in 'poll()'.
> 
> Fixes: b89d882dc9fc ("vsock/virtio: reduce credit update messages")
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  Changelog:
>  v1 -> v2:
>   * Update commit message by removing 'This patch adds XXX' manner.
>   * Do not initialize 'send_update' variable - set it directly during
>     first usage.
>  v3 -> v4:
>   * Fit comment in 'virtio_transport_notify_set_rcvlowat()' to 80 chars.
>  v4 -> v5:
>   * Do not change callbacks order in transport structures.
>  v5 -> v6:
>   * Reorder callbacks in transport structures.
>   * Do to send credit update when 'fwd_cnt' == 'last_fwd_cnt'.
>  v8 -> v9:
>   * Add 'Fixes' tag.
> 
>  drivers/vhost/vsock.c                   |  1 +
>  include/linux/virtio_vsock.h            |  1 +
>  net/vmw_vsock/virtio_transport.c        |  1 +
>  net/vmw_vsock/virtio_transport_common.c | 30 +++++++++++++++++++++++++
>  net/vmw_vsock/vsock_loopback.c          |  1 +
>  5 files changed, 34 insertions(+)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index f75731396b7e..ec20ecff85c7 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -449,6 +449,7 @@ static struct virtio_transport vhost_transport = {
>  		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
>  		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
>  		.notify_buffer_size       = virtio_transport_notify_buffer_size,
> +		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>  

This needs to be set_rcvlowat.

>  		.read_skb = virtio_transport_read_skb,
>  	},
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index ebb3ce63d64d..c82089dee0c8 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -256,4 +256,5 @@ void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
>  void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
>  int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
>  int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
> +int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
>  #endif /* _LINUX_VIRTIO_VSOCK_H */
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index af5bab1acee1..f495b9e5186b 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -537,6 +537,7 @@ static struct virtio_transport virtio_transport = {
>  		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
>  		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
>  		.notify_buffer_size       = virtio_transport_notify_buffer_size,
> +		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>  
>  		.read_skb = virtio_transport_read_skb,
>  	},


This, too.

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 7eabe5219ef7..9d2305fdc65c 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1690,6 +1690,36 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
>  }
>  EXPORT_SYMBOL_GPL(virtio_transport_read_skb);
>  
> +int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val)
> +{
> +	struct virtio_vsock_sock *vvs = vsk->trans;
> +	bool send_update;
> +
> +	spin_lock_bh(&vvs->rx_lock);
> +
> +	/* If number of available bytes is less than new SO_RCVLOWAT value,
> +	 * kick sender to send more data, because sender may sleep in its
> +	 * 'send()' syscall waiting for enough space at our side. Also
> +	 * don't send credit update when peer already knows actual value -
> +	 * such transmission will be useless.
> +	 */
> +	send_update = (vvs->rx_bytes < val) &&
> +		      (vvs->fwd_cnt != vvs->last_fwd_cnt);
> +
> +	spin_unlock_bh(&vvs->rx_lock);
> +
> +	if (send_update) {
> +		int err;
> +
> +		err = virtio_transport_send_credit_update(vsk);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(virtio_transport_notify_set_rcvlowat);
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Asias He");
>  MODULE_DESCRIPTION("common code for virtio vsock");

I think you need to set sk->sk_rcvlowat here, no?
Follow up patch will move it to transport independent code.


> diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
> index 048640167411..6dea6119f5b2 100644
> --- a/net/vmw_vsock/vsock_loopback.c
> +++ b/net/vmw_vsock/vsock_loopback.c
> @@ -96,6 +96,7 @@ static struct virtio_transport loopback_transport = {
>  		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
>  		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
>  		.notify_buffer_size       = virtio_transport_notify_buffer_size,
> +		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>  
>  		.read_skb = virtio_transport_read_skb,
>  	},
> -- 
> 2.25.1

