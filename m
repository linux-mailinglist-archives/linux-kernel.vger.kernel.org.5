Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF400761D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGYPkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjGYPkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:40:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB021FCA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690299561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bcCFU2Ivogkl7HFNHxFyEJm3ALVxSHEsRN1xT36+tVI=;
        b=b+RE0TxJ3AXuBTKXoIskLYhrcC0k7u/GJp6MHxYcdLmN3mSPVq5rY58+cjThdKXgvjK8PB
        LWr6zbVreDzojU7cEfK0xBlRbsSZF5dOxgJTHNb5ptsye2SYeZniMuRwXcS1P252Mxpbqp
        Piexk7WzaB1vEhFPUYCes85nIy9WOy0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-AApKS_XVMs62d-TxtsQWdg-1; Tue, 25 Jul 2023 11:39:17 -0400
X-MC-Unique: AApKS_XVMs62d-TxtsQWdg-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a5aa4a8fd6so6016957b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690299556; x=1690904356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcCFU2Ivogkl7HFNHxFyEJm3ALVxSHEsRN1xT36+tVI=;
        b=Womiwt2ULZpYdAW0kbvobbojQJek6CQzpQCGaa4EwdC6lNxGx/HmWzqulyzHAR4/fa
         /TLo4w+unWBihfm7YlSTzJVQxXG9gw064BSCU7v/Q5EieJHLA1pwguItwvk4FjNgPfBp
         L3SYVLZ0EAIbTWLo2IfwEc0JofDZddKDDse0MdUB4JCvfnqi4O5EDOBdE07j9qvuK51E
         k6vezdcCe+buBKO71Tm85Gw1yEqEKIcqRrtOJnw+zeltKsZ8hUWCuX4vMJzeDY/XLdy4
         8lqIM6JYXLDLF56jrOsGh5p0JiOV+qeeF0YgsNfiSlyFCj7MHU+t+3mn+/kHNs1duU+p
         R4Ww==
X-Gm-Message-State: ABy/qLa1Po5SZzCrs0nKzHvTAKMbMTolRKCT+ufExdqQdhFzAPvqAWIt
        TGmT5nfxcu5FurPSSD2/eWA9HxXOt+2gC5qpMkSFW7aAl1AK//pHLBFQ2TOWLqfiT4jgROlftGz
        qmKCaEKowKPYc/WGMcQduUyOE
X-Received: by 2002:aca:903:0:b0:3a4:2983:fae4 with SMTP id 3-20020aca0903000000b003a42983fae4mr13668672oij.16.1690299556759;
        Tue, 25 Jul 2023 08:39:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0TGaUqzi7xbyp+p32xHTznjTx8QeM+1IFMYrpqrtgsnqXajAIOZAP2vbA9ODUoVXO9/LaIw==
X-Received: by 2002:aca:903:0:b0:3a4:2983:fae4 with SMTP id 3-20020aca0903000000b003a42983fae4mr13668657oij.16.1690299556430;
        Tue, 25 Jul 2023 08:39:16 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.153.113])
        by smtp.gmail.com with ESMTPSA id z9-20020a0cf249000000b005ef81cc63ccsm4396365qvl.117.2023.07.25.08.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:39:15 -0700 (PDT)
Date:   Tue, 25 Jul 2023 17:39:09 +0200
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
Subject: Re: [RFC PATCH v2 1/4] virtio/vsock: rework MSG_PEEK for SOCK_STREAM
Message-ID: <p5sh4fskegski2l4d5jkziaun266mjnzfpig6qs5zsxg55rc4t@vfi2icif57pj>
References: <20230719192708.1775162-1-AVKrasnov@sberdevices.ru>
 <20230719192708.1775162-2-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230719192708.1775162-2-AVKrasnov@sberdevices.ru>
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

On Wed, Jul 19, 2023 at 10:27:05PM +0300, Arseniy Krasnov wrote:
>This reworks current implementation of MSG_PEEK logic:
>1) Replaces 'skb_queue_walk_safe()' with 'skb_queue_walk()'. There is
>   no need in the first one, as there are no removes of skb in loop.
>2) Removes nested while loop - MSG_PEEK logic could be implemented
>   without it: just iterate over skbs without removing it and copy
>   data from each until destination buffer is not full.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>Reviewed-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 41 ++++++++++++-------------
> 1 file changed, 19 insertions(+), 22 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index b769fc258931..2ee40574c339 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -348,37 +348,34 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
> 				size_t len)
> {
> 	struct virtio_vsock_sock *vvs = vsk->trans;
>-	size_t bytes, total = 0, off;
>-	struct sk_buff *skb, *tmp;
>-	int err = -EFAULT;
>+	struct sk_buff *skb;
>+	size_t total = 0;
>+	int err;
>
> 	spin_lock_bh(&vvs->rx_lock);
>
>-	skb_queue_walk_safe(&vvs->rx_queue, skb,  tmp) {
>-		off = 0;
>+	skb_queue_walk(&vvs->rx_queue, skb) {
>+		size_t bytes;
>
>-		if (total == len)
>-			break;
>+		bytes = len - total;
>+		if (bytes > skb->len)
>+			bytes = skb->len;
>
>-		while (total < len && off < skb->len) {
>-			bytes = len - total;
>-			if (bytes > skb->len - off)
>-				bytes = skb->len - off;
>+		spin_unlock_bh(&vvs->rx_lock);
>
>-			/* sk_lock is held by caller so no one else can dequeue.
>-			 * Unlock rx_lock since memcpy_to_msg() may sleep.
>-			 */
>-			spin_unlock_bh(&vvs->rx_lock);
>+		/* sk_lock is held by caller so no one else can dequeue.
>+		 * Unlock rx_lock since memcpy_to_msg() may sleep.
>+		 */
>+		err = memcpy_to_msg(msg, skb->data, bytes);
>+		if (err)
>+			goto out;
>
>-			err = memcpy_to_msg(msg, skb->data + off, bytes);
>-			if (err)
>-				goto out;
>+		total += bytes;
>
>-			spin_lock_bh(&vvs->rx_lock);
>+		spin_lock_bh(&vvs->rx_lock);
>
>-			total += bytes;
>-			off += bytes;
>-		}
>+		if (total == len)
>+			break;
> 	}
>
> 	spin_unlock_bh(&vvs->rx_lock);
>-- 
>2.25.1
>

