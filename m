Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36667BE476
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376683AbjJIPRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346587AbjJIPRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:17:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C1AE4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696864622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2gmTuRm7MgRiV0DIb6UC+zzg6xOoFVegXTF+vt6GHPY=;
        b=GTJdkheUvi73A8+Ne7eegStYMuy/XhmOpYP4fRORvXnaBiQkm4cgLTdLf7vkvlhlKUnCE7
        IRjRxXgi/TwBszQhYrmDzenUv8jfpmuCu8RqXq5aeJHaxGevjCp05sGbK0JY5G/3LdXIDW
        /Pj7cK1K94yeNuut/SOS2BYspq1iIB4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-jMTh0TT3OASqxHhUVbGCzQ-1; Mon, 09 Oct 2023 11:16:55 -0400
X-MC-Unique: jMTh0TT3OASqxHhUVbGCzQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-533d8a785a5so4041458a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 08:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696864614; x=1697469414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gmTuRm7MgRiV0DIb6UC+zzg6xOoFVegXTF+vt6GHPY=;
        b=cKdnYh+vrAlBvWNIh9Zx6+uJlMYqMUFuHnfWHS4f5x55gtcx8G7ixuWtULkxjuGQ9P
         /dRq9qUvccOW5BI6lbfv+CBymQ9leq/O7ZUDQOXpxkTO/uiuNBRUBHZ418l+2J9Tn4f8
         2/Q20suO6Z03Sv0GMNVXiY8y9HbgdrRjgWafJShn81FoDndCv7EzIqa8xk/Q8Q7XG7QZ
         wQyNeX2SpLcSyzLspccWjS91fvV9yCKwCopB79bvOxeu6d5yLbDAT3pTbtJNWF36XiJr
         VMDswSXTFhWmiNLparSS3oZPLscWqCv5Wv2fC+8KMe3u0exTD3VpIzymSVjLYG+DDEyQ
         ZKfQ==
X-Gm-Message-State: AOJu0YxfUnJJoMjKGRECAdgAzxSPEbhx68hGSR4nZvvaC5UzXecQtRDO
        zXs9EkUrKQ5iuXz26FTrHG3O0Cp0+V/0Vry1WVd/MzYMDhQkBK0k+aaO0I0FV/7aRaL/t9DhCTI
        12pGYWik6/kxvlLGhxokUCUfT
X-Received: by 2002:a05:6402:1ca5:b0:53b:3225:93b2 with SMTP id cz5-20020a0564021ca500b0053b322593b2mr7407137edb.29.1696864614023;
        Mon, 09 Oct 2023 08:16:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrMTn2vJyCRndP6TodZU0FVgeIan6pJGYPn2FrcveBY88ywUI+fm3YppJUOvDo92NN8Mz+WQ==
X-Received: by 2002:a05:6402:1ca5:b0:53b:3225:93b2 with SMTP id cz5-20020a0564021ca500b0053b322593b2mr7407123edb.29.1696864613643;
        Mon, 09 Oct 2023 08:16:53 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it. [82.57.51.114])
        by smtp.gmail.com with ESMTPSA id g18-20020a056402181200b0053782c81c69sm6187982edy.96.2023.10.09.08.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:16:52 -0700 (PDT)
Date:   Mon, 9 Oct 2023 17:16:49 +0200
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
Subject: Re: [PATCH net-next v3 02/12] vsock: read from socket's error queue
Message-ID: <v3w46qfwgi66omysu64ma3lac437wy3j47a6vdbtr4umxfcrvv@4y2ypaub2k22>
References: <20231007172139.1338644-1-avkrasnov@salutedevices.com>
 <20231007172139.1338644-3-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231007172139.1338644-3-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 08:21:29PM +0300, Arseniy Krasnov wrote:
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
> v2 -> v3:
>  * Add comments to describe 'SOL_VSOCK' and 'VSOCK_RECVERR' in the file
>    'vm_sockets.h'.
>  * Reorder includes in 'af_vsock.c' in alphabetical order.
>
> include/linux/socket.h          |  1 +
> include/uapi/linux/vm_sockets.h | 12 ++++++++++++
> net/vmw_vsock/af_vsock.c        |  6 ++++++
> 3 files changed, 19 insertions(+)
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
>index c60ca33eac59..d9d703b2d45a 100644
>--- a/include/uapi/linux/vm_sockets.h
>+++ b/include/uapi/linux/vm_sockets.h
>@@ -191,4 +191,16 @@ struct sockaddr_vm {
>
> #define IOCTL_VM_SOCKETS_GET_LOCAL_CID		_IO(7, 0xb9)
>
>+/* For reading completion in case of MSG_ZEROCOPY flag transmission.
>+ * This is value of 'cmsg_level' field of the 'struct cmsghdr'.
>+ */
>+
>+#define SOL_VSOCK	287
>+
>+/* For reading completion in case of MSG_ZEROCOPY flag transmission.
>+ * This is value of 'cmsg_type' field of the 'struct cmsghdr'.
>+ */
>+
>+#define VSOCK_RECVERR	1

I would suggest a bit more context here, something like this:

diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
index d9d703b2d45a..ed07181d4eff 100644
--- a/include/uapi/linux/vm_sockets.h
+++ b/include/uapi/linux/vm_sockets.h
@@ -191,14 +191,19 @@ struct sockaddr_vm {

  #define IOCTL_VM_SOCKETS_GET_LOCAL_CID         _IO(7, 0xb9)

-/* For reading completion in case of MSG_ZEROCOPY flag transmission.
- * This is value of 'cmsg_level' field of the 'struct cmsghdr'.
+/* MSG_ZEROCOPY notifications are encoded in the standard error format,
+ * sock_extended_err. See Documentation/networking/msg_zerocopy.rst in
+ * kernel source tree for more details.
+ */
+
+/* 'cmsg_level' field value of 'struct cmsghdr' for notification parsing
+ * when MSG_ZEROCOPY flag is used on transmissions.
   */

  #define SOL_VSOCK      287

-/* For reading completion in case of MSG_ZEROCOPY flag transmission.
- * This is value of 'cmsg_type' field of the 'struct cmsghdr'.
+/* 'cmsg_type' field value of 'struct cmsghdr' for notification parsing
+ * when MSG_ZEROCOPY flag is used on transmissions.
   */

  #define VSOCK_RECVERR  1

The rest LGTM.

Stefano

>+
> #endif /* _UAPI_VM_SOCKETS_H */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d841f4de33b0..38486efd3d05 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -89,6 +89,7 @@
> #include <linux/types.h>
> #include <linux/bitops.h>
> #include <linux/cred.h>
>+#include <linux/errqueue.h>
> #include <linux/init.h>
> #include <linux/io.h>
> #include <linux/kernel.h>
>@@ -110,6 +111,7 @@
> #include <linux/workqueue.h>
> #include <net/sock.h>
> #include <net/af_vsock.h>
>+#include <uapi/linux/vm_sockets.h>
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

