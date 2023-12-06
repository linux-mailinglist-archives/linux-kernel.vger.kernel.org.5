Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C03C807790
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378356AbjLFS3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLFS3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:29:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C837122
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701887366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jnuem6msgUvZR/qtC3Ankzp7FYXj3vJHjUZIQQCp0oc=;
        b=T0UWAugJnsP5TV8zl9TjmQRbJXcKPZXPHLDYd2sBdRqp54+qrv086+SUtxgNnHQGI6g9wS
        6VRM2gtGvK6Y1DaKlV+/yEm+DQ8+C9L285r56M/Yiq5UpvTA2LNr1QoGRtyicFtjGpooyp
        ethlcj45YeArUCUY1iDQz62+0csaXdM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-5YG3lvnZPnSi3ZzsEOgZSQ-1; Wed, 06 Dec 2023 13:28:33 -0500
X-MC-Unique: 5YG3lvnZPnSi3ZzsEOgZSQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3334b1055fbso69182f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 10:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701887304; x=1702492104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnuem6msgUvZR/qtC3Ankzp7FYXj3vJHjUZIQQCp0oc=;
        b=E/VJXsNZJ+hH2YEblw/ZctS3iEPTYE4TRZZubvgJZFMjp5hIoMVVB9P3N1QU4VKsVq
         nt63TceTIw4vKmz0FXVjRTGXdJwS8aC9mNUWM6mI0MlIwLrXxK3tUHzD84yup/xgzLVS
         tcNopQnt3DUcf1MQTcq3c1oi1oquyXc665imOswiH6IKbYdpoHR4Y/BHq5YYDFZ4z0je
         x7mvBrF60caQ+oggDA2BVSU7+jiTTSHR89AMkicD8MIHg8MGCUKTL5yOu6kRMdhMRX3/
         wf834Td0sWFcCLtVqZfH91IKoZzCZPDLYTVWc/h4Y+OwsqUmCmfeFRzZTUOgOIGxv8YX
         +2NQ==
X-Gm-Message-State: AOJu0YzTIKCO9UDNNpTnocMLSCvVLSICvPGL4fsnfxpchbxBxPAqQZ9s
        mVcDj0XFjRP+V2REtpAvXvEI8VWNPAolon8ak9eqMf5gVKC6Z/2l9Yk/FBVygal4XU5D5YvFjs7
        Tvc9zJtH9llW5V+/FGQpe4saF
X-Received: by 2002:adf:f752:0:b0:333:2fd2:3be2 with SMTP id z18-20020adff752000000b003332fd23be2mr563995wrp.155.1701887303900;
        Wed, 06 Dec 2023 10:28:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPfF7salzTJo8Tl0XEOHa4Kq1FjBjVSq+If3zpML0Un6nfo5ZCrIh/61l68acpETq59NVYPA==
X-Received: by 2002:adf:f752:0:b0:333:2fd2:3be2 with SMTP id z18-20020adff752000000b003332fd23be2mr563984wrp.155.1701887303527;
        Wed, 06 Dec 2023 10:28:23 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id lg18-20020a170906f89200b00a1b7f4c22a7sm267591ejb.82.2023.12.06.10.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:28:22 -0800 (PST)
Date:   Wed, 6 Dec 2023 13:28:18 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux.dev,
        Arseniy Krasnov <avkrasnov@salutedevices.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: fix "comparison of distinct pointer
 types lacks a cast" warning
Message-ID: <20231206132803-mutt-send-email-mst@kernel.org>
References: <20231206164143.281107-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206164143.281107-1-sgarzare@redhat.com>
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

On Wed, Dec 06, 2023 at 05:41:43PM +0100, Stefano Garzarella wrote:
> After backporting commit 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY
> flag support") in CentOS Stream 9, CI reported the following error:
> 
>     In file included from ./include/linux/kernel.h:17,
>                      from ./include/linux/list.h:9,
>                      from ./include/linux/preempt.h:11,
>                      from ./include/linux/spinlock.h:56,
>                      from net/vmw_vsock/virtio_transport_common.c:9:
>     net/vmw_vsock/virtio_transport_common.c: In function ???virtio_transport_can_zcopy???:
>     ./include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast [-Werror]
>        20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>           |                                   ^~
>     ./include/linux/minmax.h:26:18: note: in expansion of macro ???__typecheck???
>        26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>           |                  ^~~~~~~~~~~
>     ./include/linux/minmax.h:36:31: note: in expansion of macro ???__safe_cmp???
>        36 |         __builtin_choose_expr(__safe_cmp(x, y), \
>           |                               ^~~~~~~~~~
>     ./include/linux/minmax.h:45:25: note: in expansion of macro ???__careful_cmp???
>        45 | #define min(x, y)       __careful_cmp(x, y, <)
>           |                         ^~~~~~~~~~~~~
>     net/vmw_vsock/virtio_transport_common.c:63:37: note: in expansion of macro ???min???
>        63 |                 int pages_to_send = min(pages_in_iov, MAX_SKB_FRAGS);
> 
> We could solve it by using min_t(), but this operation seems entirely
> unnecessary, because we also pass MAX_SKB_FRAGS to iov_iter_npages(),
> which performs almost the same check, returning at most MAX_SKB_FRAGS
> elements. So, let's eliminate this unnecessary comparison.
> 
> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> Cc: avkrasnov@salutedevices.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---


Acked-by: Michael S. Tsirkin <mst@redhat.com>

>  net/vmw_vsock/virtio_transport_common.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index f6dc896bf44c..c8e162c9d1df 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -59,8 +59,7 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>  	t_ops = virtio_transport_get_ops(info->vsk);
>  
>  	if (t_ops->can_msgzerocopy) {
> -		int pages_in_iov = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
> -		int pages_to_send = min(pages_in_iov, MAX_SKB_FRAGS);
> +		int pages_to_send = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
>  
>  		/* +1 is for packet header. */
>  		return t_ops->can_msgzerocopy(pages_to_send + 1);
> -- 
> 2.43.0

