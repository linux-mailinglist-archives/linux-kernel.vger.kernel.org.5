Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5C37FD191
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjK2JBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjK2JBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:01:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C16C111
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701248512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zwc9ieluISalwFh3TyYZ4gcQacsA94sf6qSa2kEUESI=;
        b=CBEYAc3gmLlyBM/98d4pekrgZPBKZIg2CM/IerqtQUVidKwt0zqMX1jUanmFCbRK8ueW+S
        Y5++Hp6PyfET+SvYmLzCxVnzdBxZ8OuHSQE/Gp5f4s/wgG2CRITSjyX1Hzfu3tH0PdTK18
        Lo/5zdyDX4Slfk5FiZ7CFNcmGQetFoE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-LX3xrrafP2CYnkhhSJv5Qg-1; Wed, 29 Nov 2023 04:01:51 -0500
X-MC-Unique: LX3xrrafP2CYnkhhSJv5Qg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33306c2a005so1862991f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701248510; x=1701853310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwc9ieluISalwFh3TyYZ4gcQacsA94sf6qSa2kEUESI=;
        b=mi5mVrLzNCQOanIvfiPfqS596/XiHxuCQkWjMokpWAgwiwHcnOdevrAf3X+LzYj3SJ
         pI/Nx8tgWBotFClIfo7aYjBqGh5H3jUGKkpCpJCITaJzYEWN8/2E/Yvl4AWxqjbdSlPD
         s6vuBGzVHEoCdvlhHsCj6bhMRmxFK4br6OQqNQvWMFw+/ZZEafp4GWnz8LoF4VmJAaSD
         WA+2bD41R4Mmq9xzlUHt3TfymPv6fbXY/Sjji991dpIB03C9JYI7sG5lPgyt0iiGy88h
         5juPoe4H+ivgk/HmJ3ekqiEh/l8jOZcufRAynniteHzm4YYZZdVUTgJJjy3QZefzlFA2
         0ayg==
X-Gm-Message-State: AOJu0Yyjfd6KI8w7qpJqFujntqgbFHE1j8YKOj4vl8AuopWvWJyxpcNF
        WyXxW15DbYVE3rwqc2T2R6W240xJikROohrQ7Ku2ZgZAWqqnZFKfmPcgGf0aGA00D+XR9rjbkSL
        YpFtrNyiFvKxbs+rJILRj1cQa
X-Received: by 2002:adf:b1d5:0:b0:332:c441:70aa with SMTP id r21-20020adfb1d5000000b00332c44170aamr13788907wra.26.1701248509922;
        Wed, 29 Nov 2023 01:01:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFP2F6dczPE089a3r9AZSuxONM+6MsCslUykG0rwB+wpDrF0PpgPS4SUfoLewfpzCdrG2iGkA==
X-Received: by 2002:adf:b1d5:0:b0:332:c441:70aa with SMTP id r21-20020adfb1d5000000b00332c44170aamr13788889wra.26.1701248509534;
        Wed, 29 Nov 2023 01:01:49 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-199.retail.telecomitalia.it. [79.46.200.199])
        by smtp.gmail.com with ESMTPSA id c14-20020a056000104e00b00332f95ab44esm10548348wrx.57.2023.11.29.01.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:01:48 -0800 (PST)
Date:   Wed, 29 Nov 2023 10:01:43 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v3 2/3] virtio/vsock: send credit update during
 setting SO_RCVLOWAT
Message-ID: <etuukjyedcdvkdxsql5qquvla6tuaaayph7vj2jdskqjwmkmoy@h2hkgjfyawyi>
References: <20231122180510.2297075-1-avkrasnov@salutedevices.com>
 <20231122180510.2297075-3-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231122180510.2297075-3-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 09:05:09PM +0300, Arseniy Krasnov wrote:
>Send credit update message when SO_RCVLOWAT is updated and it is bigger
>than number of bytes in rx queue. It is needed, because 'poll()' will
>wait until number of bytes in rx queue will be not smaller than
>SO_RCVLOWAT, so kick sender to send more data. Otherwise mutual hungup
>for tx/rx is possible: sender waits for free space and receiver is
>waiting data in 'poll()'.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v1 -> v2:
>  * Update commit message by removing 'This patch adds XXX' manner.
>  * Do not initialize 'send_update' variable - set it directly during
>    first usage.
>
> drivers/vhost/vsock.c                   |  2 ++
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport.c        |  2 ++
> net/vmw_vsock/virtio_transport_common.c | 28 +++++++++++++++++++++++++
> net/vmw_vsock/vsock_loopback.c          |  2 ++
> 5 files changed, 35 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index f75731396b7e..ecfa5c11f5ee 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -451,6 +451,8 @@ static struct virtio_transport vhost_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>
> 		.read_skb = virtio_transport_read_skb,
>+
>+		.set_rcvlowat             = virtio_transport_set_rcvlowat

Since now we don't set it anymore in the callback, what about following
the notify_* callbacks and rename it in `notify_set_rcvlowat`?

Eventually I think we can rename it in the previous patch.

> 	},
>
> 	.send_pkt = vhost_transport_send_pkt,
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index ebb3ce63d64d..97dc1bebc69c 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -256,4 +256,5 @@ void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
> void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
> int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
> int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
>+int virtio_transport_set_rcvlowat(struct vsock_sock *vsk, int val);
> #endif /* _LINUX_VIRTIO_VSOCK_H */
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index af5bab1acee1..cf3431189d0c 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -539,6 +539,8 @@ static struct virtio_transport virtio_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>
> 		.read_skb = virtio_transport_read_skb,
>+
>+		.set_rcvlowat             = virtio_transport_set_rcvlowat
> 	},
>
> 	.send_pkt = virtio_transport_send_pkt,
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index f6dc896bf44c..4acee21b4350 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1684,6 +1684,34 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> }
> EXPORT_SYMBOL_GPL(virtio_transport_read_skb);
>
>+int virtio_transport_set_rcvlowat(struct vsock_sock *vsk, int val)
>+{
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+	bool send_update;
>+
>+	spin_lock_bh(&vvs->rx_lock);
>+
>+	/* If number of available bytes is less than new
>+	 * SO_RCVLOWAT value, kick sender to send more
>+	 * data, because sender may sleep in its 'send()'
>+	 * syscall waiting for enough space at our side.
>+	 */

Let's try to use at least the full 80 characters so we can reduce the
lines in this comment block.

>+	send_update = vvs->rx_bytes < val;
>+
>+	spin_unlock_bh(&vvs->rx_lock);
>+
>+	if (send_update) {
>+		int err;
>+
>+		err = virtio_transport_send_credit_update(vsk);
>+		if (err < 0)
>+			return err;
>+	}
>+
>+	return 0;
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_set_rcvlowat);
>+
> MODULE_LICENSE("GPL v2");
> MODULE_AUTHOR("Asias He");
> MODULE_DESCRIPTION("common code for virtio vsock");
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 048640167411..388c157f6633 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -98,6 +98,8 @@ static struct virtio_transport loopback_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>
> 		.read_skb = virtio_transport_read_skb,
>+
>+		.set_rcvlowat             = virtio_transport_set_rcvlowat
> 	},
>
> 	.send_pkt = vsock_loopback_send_pkt,
>-- 
>2.25.1
>

