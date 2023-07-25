Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE55761D82
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjGYPk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjGYPkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:40:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975CA1FD0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690299577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hl7TlGBY8KC9fCz4U38u+w32QQOwR9hjmIKn/+TtjDc=;
        b=Eqfenaznp7EdkrxatwpStZue6/oR7OfchzFM+38/JhlfXJWqoB37aqlmSSqpONUwwtso3U
        ikPZ6nzjWwnV+JzhgDj9kg5dm+Dg5I3An1M9l2QKOSWN4kvJccGHvkyAcm1HH2ATFmxuQ/
        4Tfi2/j1D8X8Bl3iD8HaNj6cY9JlykA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-IDLONoxKN9KgsCQefNg4zQ-1; Tue, 25 Jul 2023 11:39:36 -0400
X-MC-Unique: IDLONoxKN9KgsCQefNg4zQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-403ae7d56baso71164011cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690299576; x=1690904376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hl7TlGBY8KC9fCz4U38u+w32QQOwR9hjmIKn/+TtjDc=;
        b=HG7Mx7Alx7+4VXYLJBdLpAeLx3dysGloL9aY10ZnjDRzNXpwlo1ZZryTsGBp6o3idi
         YdImivsh0RiPjOWfQrEgi6cUVw1ErtbViKqQyi9ifevxIgYtyYJhwbSGIhMwZkHu/SfS
         Dt2qqaqVuKOMfVTBWqSJOcE9V83c/4FQAmqvhV3r5hTlBXVwxDyvj+NbRqXiOi8mGxn2
         QEht5V6sEQ/Gu1PN+gvOFsXYC7Fp/3C8XcydDyM0Faqo2hTvNjIo5mLcMcX7JcHPaQmo
         9mqwxpIqRhNu/CLC+mzIm+tPuPbVjpYDBn9ZNotzOx4cB8WABTOoh3UdAwBEUy1SwOjO
         2j6w==
X-Gm-Message-State: ABy/qLYPan2Hrbi3zpNQjnNISJDvYilTIll/ym1LsRTUrK4Ou9qSIltX
        CqxS5H08yP6yDVXwmK/Uwko7Ys9YOeS477UXf29drD4Dbob+Az4F4/ogc7V3rqoy0fG3aJjxicT
        acAxgMTWPglHO9ZFtkpGySuFc
X-Received: by 2002:a05:622a:1013:b0:402:76e3:59f6 with SMTP id d19-20020a05622a101300b0040276e359f6mr3746331qte.9.1690299576273;
        Tue, 25 Jul 2023 08:39:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFPTRjdLNSLA8c7aE0osG3x1L3hWBx5nQgehQrRb2Vj3GyGN/3UVxsy9bokM2ED6bC9iQzVnw==
X-Received: by 2002:a05:622a:1013:b0:402:76e3:59f6 with SMTP id d19-20020a05622a101300b0040276e359f6mr3746308qte.9.1690299576067;
        Tue, 25 Jul 2023 08:39:36 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.153.113])
        by smtp.gmail.com with ESMTPSA id s21-20020ac85ed5000000b00403b44bc230sm4085933qtx.95.2023.07.25.08.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:39:35 -0700 (PDT)
Date:   Tue, 25 Jul 2023 17:39:30 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
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
Subject: Re: [RFC PATCH v2 2/4] virtio/vsock: support MSG_PEEK for
 SOCK_SEQPACKET
Message-ID: <hwdcuy3wwlrirpgphlex6omdnrztz7hqhu4447nmqml5sjqx5x@7y45zuyto7yq>
References: <20230719192708.1775162-1-AVKrasnov@sberdevices.ru>
 <20230719192708.1775162-3-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230719192708.1775162-3-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 10:27:06PM +0300, Arseniy Krasnov wrote:
>This adds support of MSG_PEEK flag for SOCK_SEQPACKET type of socket.
>Difference with SOCK_STREAM is that this callback returns either length
>of the message or error.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 63 +++++++++++++++++++++++--
> 1 file changed, 60 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 2ee40574c339..352d042b130b 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -460,6 +460,63 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	return err;
> }
>
>+static ssize_t
>+virtio_transport_seqpacket_do_peek(struct vsock_sock *vsk,
>+				   struct msghdr *msg)
>+{
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+	struct sk_buff *skb;
>+	size_t total, len;
>+
>+	spin_lock_bh(&vvs->rx_lock);
>+
>+	if (!vvs->msg_count) {
>+		spin_unlock_bh(&vvs->rx_lock);
>+		return 0;
>+	}
>+
>+	total = 0;
>+	len = msg_data_left(msg);
>+
>+	skb_queue_walk(&vvs->rx_queue, skb) {
>+		struct virtio_vsock_hdr *hdr;
>+
>+		if (total < len) {
>+			size_t bytes;
>+			int err;
>+
>+			bytes = len - total;
>+			if (bytes > skb->len)
>+				bytes = skb->len;
>+
>+			spin_unlock_bh(&vvs->rx_lock);
>+
>+			/* sk_lock is held by caller so no one else can dequeue.
>+			 * Unlock rx_lock since memcpy_to_msg() may sleep.
>+			 */
>+			err = memcpy_to_msg(msg, skb->data, bytes);
>+			if (err)
>+				return err;
>+
>+			spin_lock_bh(&vvs->rx_lock);
>+		}
>+
>+		total += skb->len;
>+		hdr = virtio_vsock_hdr(skb);
>+
>+		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) {
>+			if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOR)
>+				msg->msg_flags |= MSG_EOR;
>+
>+			break;
>+		}
>+	}
>+
>+	spin_unlock_bh(&vvs->rx_lock);
>+
>+	return total;
>+}
>+
> static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> 						 struct msghdr *msg,
> 						 int flags)
>@@ -554,9 +611,9 @@ virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
> 				   int flags)
> {
> 	if (flags & MSG_PEEK)
>-		return -EOPNOTSUPP;
>-
>-	return virtio_transport_seqpacket_do_dequeue(vsk, msg, flags);
>+		return virtio_transport_seqpacket_do_peek(vsk, msg);
>+	else
>+		return virtio_transport_seqpacket_do_dequeue(vsk, msg, flags);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
>
>-- 
>2.25.1
>

