Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0209B805161
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345018AbjLEK6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346880AbjLEKz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:55:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244B7D44
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701773686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KllSGKKQDmwXLtuWN3ZHoV9RXfPGuqYv1YKTnXjA8w8=;
        b=hBze05PlafW54rqtJi7Nad57gxtaEIPLp2T2QJdXODpB2HDNxvy+lahyECwXpAp/RjZdzl
        29NwiBgda3t4KGXeBz5gS9A8c/3+m4Lth1KPcm8Qhlu27ljd99+Rzate3amW8AR2NCaR04
        nETXurkjTyfxX8nNyb2bRc+weRK4NkY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-bIJIU9iMN6iwH-9yCzdWaw-1; Tue, 05 Dec 2023 05:54:45 -0500
X-MC-Unique: bIJIU9iMN6iwH-9yCzdWaw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ca0fb015d4so8774121fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 02:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701773684; x=1702378484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KllSGKKQDmwXLtuWN3ZHoV9RXfPGuqYv1YKTnXjA8w8=;
        b=nWH93Fcw+xuzxlL0oaYjjL2EDcalqJCyYDizvC3868CatnVpFj760LJmswFYl1wLAB
         IoSjnjvK/7avMiTac2XBsL0/gFnpjlvd7axAQ5+niWZ7c97OAbDtYvkbfANb7vMADrjH
         uC2npsNFqS4ppMRD0AIA8NxEz6G/9woR/Vngkc2XyWVRdk7Dqz9awUI4b4vyvdHtmu+8
         NthgzSs04M8dX5GTRA8DOan4hyxaffY4jb3j+kPd5pEIpQc5nQ+vmBSwXV2n2BalqYhN
         8KMh1UqFI0OBQsqhLEJCxN7AcwO3Gxtni/njGLRHeqg9EvgSCwpy3Bm80cQE5+ryf54O
         xdNw==
X-Gm-Message-State: AOJu0YzOgwWJq11q0K5qra4e1CInewuq9N4sXq2rhP6TUEPGMfSFTXq8
        A6m8knSvpXZ7UZueDKCOn6JFHDdvmT9gFQMYrbGkHJ5wHrU+kNAWU8fgJ5BkOwFIuk4MD3VVqo6
        wZ7HuJc1EGE2r/Yi1Skq7usrC
X-Received: by 2002:a2e:8488:0:b0:2ca:b91:6e0f with SMTP id b8-20020a2e8488000000b002ca0b916e0fmr1176639ljh.100.1701773683916;
        Tue, 05 Dec 2023 02:54:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1uczRGKwr7AEuhaoO8GRb1dLh2uTnNgWHFUpQaDfB0N2+1jhIW7CG1zbJ7bYnPIhI2iFz2w==
X-Received: by 2002:a2e:8488:0:b0:2ca:b91:6e0f with SMTP id b8-20020a2e8488000000b002ca0b916e0fmr1176626ljh.100.1701773683580;
        Tue, 05 Dec 2023 02:54:43 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-125.retail.telecomitalia.it. [79.46.200.125])
        by smtp.gmail.com with ESMTPSA id uz14-20020a170907118e00b00a0a2cb33ee0sm6450734ejb.203.2023.12.05.02.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:54:42 -0800 (PST)
Date:   Tue, 5 Dec 2023 11:54:37 +0100
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
Subject: Re: [PATCH net-next v6 3/4] virtio/vsock: fix logic which reduces
 credit update messages
Message-ID: <v335g4fjrn5f6tsw4nysztaklze2obnjwpezps3jgb2xickpge@ea5woxob52nc>
References: <20231205064806.2851305-1-avkrasnov@salutedevices.com>
 <20231205064806.2851305-4-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231205064806.2851305-4-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 09:48:05AM +0300, Arseniy Krasnov wrote:
>Add one more condition for sending credit update during dequeue from
>stream socket: when number of bytes in the rx queue is smaller than
>SO_RCVLOWAT value of the socket. This is actual for non-default value
>of SO_RCVLOWAT (e.g. not 1) - idea is to "kick" peer to continue data
>transmission, because we need at least SO_RCVLOWAT bytes in our rx
>queue to wake up user for reading data (in corner case it is also
>possible to stuck both tx and rx sides, this is why 'Fixes' is used).
>
>Fixes: b89d882dc9fc ("vsock/virtio: reduce credit update messages")
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index e137d740804e..461c89882142 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -558,6 +558,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	struct virtio_vsock_sock *vvs = vsk->trans;
> 	size_t bytes, total = 0;
> 	struct sk_buff *skb;
>+	bool low_rx_bytes;
> 	int err = -EFAULT;
> 	u32 free_space;
>
>@@ -602,6 +603,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	}
>
> 	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
>+	low_rx_bytes = (vvs->rx_bytes <
>+			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));

As in the previous patch, should we avoid the update it if `fwd_cnt` and 
`last_fwd_cnt` are the same?

Now I'm thinking if it is better to add that check directly in 
virtio_transport_send_credit_update().

Stefano

>
> 	spin_unlock_bh(&vvs->rx_lock);
>
>@@ -611,9 +614,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	 * too high causes extra messages. Too low causes transmitter
> 	 * stalls. As stalls are in theory more expensive than extra
> 	 * messages, we set the limit to a high value. TODO: experiment
>-	 * with different values.
>+	 * with different values. Also send credit update message when
>+	 * number of bytes in rx queue is not enough to wake up reader.
> 	 */
>-	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
>+	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
>+	    low_rx_bytes)
> 		virtio_transport_send_credit_update(vsk);
>
> 	return total;
>-- 
>2.25.1
>

