Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA2B7B6E57
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240417AbjJCQYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240305AbjJCQYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:24:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EBAA7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696350200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K8nJSyCd6Mj6/uVIoeX6vSBcbL415T2j/UKJhN/9HxQ=;
        b=ey/sGDDoSMh/Jnq134elEYvVGlNJ8rd82E2OTPDd9t092CFk/+cym9Y3tpMdIptUZBcYIR
        9nzHSDx8ijoSxSl1rEuMPV8kV4W2CmGyuZeXiMFi5u4ygXZKGZe4rR2zKH7y2AzV4YhgYm
        bH9eq7iYJSLT5Jq8R0qAbITwcXBJ7aY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-MtG91WCCNZy8k5Va3iUcwA-1; Tue, 03 Oct 2023 12:23:19 -0400
X-MC-Unique: MtG91WCCNZy8k5Va3iUcwA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-65b23c40cefso11266656d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 09:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696350199; x=1696954999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8nJSyCd6Mj6/uVIoeX6vSBcbL415T2j/UKJhN/9HxQ=;
        b=VYIAuN93IM8BEa3v+SPAIEtGzNFsvqIrFszsk/Wou3AMqyO78bCSugMk6HnMGorPle
         t9v/1RHSF9W++c0Z3rQpG65h25DHS61n92Kt6dZUY+NAuy3Y4nKK0HdqVaw2CtQjHV3f
         72f/PkkiPeXJ1IYtWSPYCO0HvYS+N4kQXKZ5Q1rWHJMYoz2ntccfVhfFaJTkrFB7J4R/
         5RjhAhGS0sDaO4co5TvvedW2CqGlH4lHFTvPvkZ14iduj3vppGtx71JUdJG1Db/SmcaN
         x259fUl4wDn5QzQgyAMFNkxlzhGr/Ca/fgRKiPHMaZL8nUU/nIP5ACWcWu5xKK7Gzx/3
         8INQ==
X-Gm-Message-State: AOJu0YxNnwCNJtQUdx675b6vz6ZDDc8pxpiFoLWiXTaUGvsBheAUGetA
        7zjkxrd242itvQmXvogtfk9eAH0X6qL5ArdEiJBq3C+K6dOS7TfOtYKFwK035AlBvsv/Owfwefz
        d2cGvdXBgYtI5LPBSIqcJCGnP
X-Received: by 2002:a0c:f04c:0:b0:658:a29a:e297 with SMTP id b12-20020a0cf04c000000b00658a29ae297mr12037762qvl.49.1696350198902;
        Tue, 03 Oct 2023 09:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8uQkWWDZB3h/ubLuDg4GpK42nrIzlPUoFwtgf5CmfllU3UftYG/UPLqG6M4Qulj6QX9ZOAw==
X-Received: by 2002:a0c:f04c:0:b0:658:a29a:e297 with SMTP id b12-20020a0cf04c000000b00658a29ae297mr12037737qvl.49.1696350198592;
        Tue, 03 Oct 2023 09:23:18 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it. [82.57.51.114])
        by smtp.gmail.com with ESMTPSA id vv22-20020a05620a563600b0076ca9f79e1fsm580607qkn.46.2023.10.03.09.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:23:18 -0700 (PDT)
Date:   Tue, 3 Oct 2023 18:23:13 +0200
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
Subject: Re: [PATCH net-next v2 02/12] vsock: read from socket's error queue
Message-ID: <2o6wtfwxa3xeurri2tomed3zkdginsgu7gty7bvf5solgyheck@45pkpcol2xb3>
References: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
 <20230930210308.2394919-3-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230930210308.2394919-3-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 12:02:58AM +0300, Arseniy Krasnov wrote:
>This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
>is used to read socket's error queue instead of data queue. Possible
>scenario of error queue usage is receiving completions for transmission
>with MSG_ZEROCOPY flag. This patch also adds new defines: 'SOL_VSOCK'
>and 'VSOCK_RECVERR'.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v1 -> v2:
>  * Place new defines for userspace to the existing file 'vm_sockets.h'
>    instead of creating new one.
>
> include/linux/socket.h          | 1 +
> include/uapi/linux/vm_sockets.h | 4 ++++
> net/vmw_vsock/af_vsock.c        | 6 ++++++
> 3 files changed, 11 insertions(+)
>
>diff --git a/include/linux/socket.h b/include/linux/socket.h
>index 39b74d83c7c4..cfcb7e2c3813 100644
>--- a/include/linux/socket.h
>+++ b/include/linux/socket.h
>@@ -383,6 +383,7 @@ struct ucred {
> #define SOL_MPTCP	284
> #define SOL_MCTP	285
> #define SOL_SMC		286
>+#define SOL_VSOCK	287
>
> /* IPX options */
> #define IPX_TYPE	1
>diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
>index c60ca33eac59..b1a66c1a7054 100644
>--- a/include/uapi/linux/vm_sockets.h
>+++ b/include/uapi/linux/vm_sockets.h
>@@ -191,4 +191,8 @@ struct sockaddr_vm {
>
> #define IOCTL_VM_SOCKETS_GET_LOCAL_CID		_IO(7, 0xb9)
>
>+#define SOL_VSOCK	287
>+
>+#define VSOCK_RECVERR	1

Please add good documentation for both of them. This is an header
exposed to the user space.

>+
> #endif /* _UAPI_VM_SOCKETS_H */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d841f4de33b0..0365382beab6 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -110,6 +110,8 @@
> #include <linux/workqueue.h>
> #include <net/sock.h>
> #include <net/af_vsock.h>
>+#include <linux/errqueue.h>
>+#include <uapi/linux/vm_sockets.h>

Let's keep the alphabetic order as it was before this change.

`net/af_vsock.h` already includes the `uapi/linux/vm_sockets.h`,
and we also use several defines from it in this file, so you can also
skip it.

On the other end it would be better to directly include the headers that
we use, so it's also okay to keep it. As you prefer.

>
> static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
> static void vsock_sk_destruct(struct sock *sk);
>@@ -2137,6 +2139,10 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	int err;
>
> 	sk = sock->sk;
>+
>+	if (unlikely(flags & MSG_ERRQUEUE))
>+		return sock_recv_errqueue(sk, msg, len, SOL_VSOCK, VSOCK_RECVERR);
>+
> 	vsk = vsock_sk(sk);
> 	err = 0;
>
>-- 
>2.25.1
>

