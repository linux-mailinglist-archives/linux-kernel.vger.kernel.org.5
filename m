Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2218880E6F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjLLI47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjLLI45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:56:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C260EC3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702371423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+DYsFoZHtER6WKTlmJtvh956H3bsUBDuNP4h+dQhswI=;
        b=b5n7yADBoDPIcN3mS/DJOo/9PTEPpZ1QO97GYXvK2mXvUtO34sEiE7HSaBF87MKIi9PIdM
        fcQW0JDyXvtMHxh0vKbmKS8yEbk2PyBpzRoDmCJNEXEoNGwkqEtvfGYSSPPhubfIwn2tPw
        tCujjUl+a/e7LmkfiiNWJ+pXCz1JYvE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-yzMAS6jsP8-go3E1HS9m_g-1; Tue, 12 Dec 2023 03:57:01 -0500
X-MC-Unique: yzMAS6jsP8-go3E1HS9m_g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40c33d8dfceso29176605e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702371420; x=1702976220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DYsFoZHtER6WKTlmJtvh956H3bsUBDuNP4h+dQhswI=;
        b=cZgcO03Kdory4Yr32oSohBiyxM4WGN1e9sM+J4Sry8DlQvbp1pbP8EN6ByvXc12G34
         FjoLNUtfIawznFqhtiRITVBJ4uQlrILMBVuiW5033MA+9I/5EPQv9PtjLMATOs9GiMXG
         de7L/x/ZygiuiE0c3wSEiQ0CBVAV4kDRik/q/Y7vpQavYWTnLe4/ND9dHc0MnJ8FiOR3
         MjM/zn69o+5hvTjIa1a1Tv/Aj2mgphS99UuivejoBMSM2fbm5eQK7b56C2Xh1FqS4R4Q
         GX+QDHBF+BbqGouwi4s8AdG4yaDr9o2MADLHZjILg1nUPrkm8SR7Irsw9OoX8RUXb9PF
         meYw==
X-Gm-Message-State: AOJu0YzaSDZ6cCRv9zn2kDcXqs0McyxuVyWOIjjLriVQI2mJVG37uOZU
        8a3Nszze5Z3iBDM/m+4kgKivCLy76U8b31/PJfNc8BgpYDZIkFvQzAS4nj80n0RdrRpjqv23fEH
        gtnagsdYTTbNpWtvnL2W/TtoU
X-Received: by 2002:a05:600c:3b26:b0:40c:224a:4450 with SMTP id m38-20020a05600c3b2600b0040c224a4450mr3229517wms.37.1702371420265;
        Tue, 12 Dec 2023 00:57:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIvN7jWx6yzro4Qv1kFQ+dgRjl2IrdvJ4STo7PXBwwt5ZmQf8etAfWpYSWHF1NH+upAURrYw==
X-Received: by 2002:a05:600c:3b26:b0:40c:224a:4450 with SMTP id m38-20020a05600c3b2600b0040c224a4450mr3229507wms.37.1702371419828;
        Tue, 12 Dec 2023 00:56:59 -0800 (PST)
Received: from sgarzare-redhat ([193.207.128.35])
        by smtp.gmail.com with ESMTPSA id d13-20020a05600c34cd00b0040c496c64cfsm5430442wmq.12.2023.12.12.00.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 00:56:59 -0800 (PST)
Date:   Tue, 12 Dec 2023 09:56:45 +0100
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
Subject: Re: [PATCH net-next v8 3/4] virtio/vsock: fix logic which reduces
 credit update messages
Message-ID: <5wewycputeafvvgehioon3j75hlwxeliyni6nt4qtw3ch5rlt4@o7yncdbcyoc4>
References: <20231211211658.2904268-1-avkrasnov@salutedevices.com>
 <20231211211658.2904268-4-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231211211658.2904268-4-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 12:16:57AM +0300, Arseniy Krasnov wrote:
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
> Changelog:
> v6 -> v7:
>  * Handle wrap of 'fwd_cnt'.
>  * Do to send credit update when 'fwd_cnt' == 'last_fwd_cnt'.
> v7 -> v8:
>  * Remove unneeded/wrong handling of wrap for 'fwd_cnt'.
>
> net/vmw_vsock/virtio_transport_common.c | 13 ++++++++++---
> 1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks!
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index e137d740804e..8572f94bba88 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -558,6 +558,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	struct virtio_vsock_sock *vvs = vsk->trans;
> 	size_t bytes, total = 0;
> 	struct sk_buff *skb;
>+	u32 fwd_cnt_delta;
>+	bool low_rx_bytes;
> 	int err = -EFAULT;
> 	u32 free_space;
>
>@@ -601,7 +603,10 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 		}
> 	}
>
>-	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
>+	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
>+	free_space = vvs->buf_alloc - fwd_cnt_delta;
>+	low_rx_bytes = (vvs->rx_bytes <
>+			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
>
> 	spin_unlock_bh(&vvs->rx_lock);
>
>@@ -611,9 +616,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	 * too high causes extra messages. Too low causes transmitter
> 	 * stalls. As stalls are in theory more expensive than extra
> 	 * messages, we set the limit to a high value. TODO: experiment
>-	 * with different values.
>+	 * with different values. Also send credit update message when
>+	 * number of bytes in rx queue is not enough to wake up reader.
> 	 */
>-	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
>+	if (fwd_cnt_delta &&
>+	    (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE || low_rx_bytes))
> 		virtio_transport_send_credit_update(vsk);
>
> 	return total;
>-- 
>2.25.1
>

