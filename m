Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4344B7AED5D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbjIZM4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbjIZM4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B199120
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695732958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4iH3vwVxFoPswV3u1qhZq4zjltOD47zGEuJH78n1q8=;
        b=He8T1iUOw+/JiwJFI6AXLU8mK9wC2o1tBRe/v2RmRwkUW+naovHjUmznaLkIYfBmlpxKVa
        i6hH3zJbLjB5YwnLoEP39HaX10cXPUdnAvtJXt5MhdK0VhR9U8wzcn0vv8XmbMHDwfdWLF
        WKSE05Q1X5evFsuj+ubU1H6mfOMU9tE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-AhZA-KZ0P_-Tp9lMmgCqug-1; Tue, 26 Sep 2023 08:55:56 -0400
X-MC-Unique: AhZA-KZ0P_-Tp9lMmgCqug-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9adb6dd9e94so728872066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695732955; x=1696337755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4iH3vwVxFoPswV3u1qhZq4zjltOD47zGEuJH78n1q8=;
        b=HGdeUZvOuplEs06TkwiWSi+2L+y5/KSDfosFWIs5IQoF/IQTz9NJ1RB+sb1eUxSOe4
         W/vnO5voa8UoyIeVzD1lMuIAT1Q4EVKH5NptT1biTwNrzrx1pS0X7UVmO8rxrSQZC51o
         OjPK+PZfDlhd8AlEZVsL2V/IzkcCnFFyccQAi8ezXEiGxk3owuddlJ3Y6Lir/ca9EXtO
         1OMCfFJH+DTB06lr9NNhgHFomX/PSXslaViYFhaBbmxKTuIFj105QsHEUN/5S4ZyAURi
         d6mfoNqSZSBiKyWF2VnRWhzZrLy8zX3Wzs4z9UaWb7VZEXQULXSU9+iScImy1bgTL2tf
         iO3A==
X-Gm-Message-State: AOJu0YyVlwPLU4ZuXDE+nRzZUe/9GxNxKY5LigBtQg/VanF+CTsxiB6g
        7/w5n8I6SYJfKu3pM+4Dj/6uN+xQLZLUhVRQkKYMTbUEZ+Op7VEh7Db+xEEnM7+TWtxuz9mXGkm
        hFjz3yjJjMZlOMdbXb446s92g
X-Received: by 2002:a17:906:30d5:b0:9ad:c763:c3fd with SMTP id b21-20020a17090630d500b009adc763c3fdmr9300573ejb.28.1695732955240;
        Tue, 26 Sep 2023 05:55:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBoqKi4bGW4XT84p8pcKtRJrDw9HwrTduGHjeF7FIg3KEpK5irhsbqg/b4oWx2SfDz4/fEpA==
X-Received: by 2002:a17:906:30d5:b0:9ad:c763:c3fd with SMTP id b21-20020a17090630d500b009adc763c3fdmr9300558ejb.28.1695732954899;
        Tue, 26 Sep 2023 05:55:54 -0700 (PDT)
Received: from sgarzare-redhat ([46.6.146.182])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099cf840527csm7748029ejc.153.2023.09.26.05.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 05:55:54 -0700 (PDT)
Date:   Tue, 26 Sep 2023 14:55:50 +0200
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
Subject: Re: [PATCH net-next v1 02/12] vsock: read from socket's error queue
Message-ID: <3oys2ouhlkitsjx7q7utp7wkitnnl4kisl2r54wwa2addd644p@jzyu7ubfrcog>
References: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
 <20230922052428.4005676-3-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230922052428.4005676-3-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 08:24:18AM +0300, Arseniy Krasnov wrote:
>This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
>is used to read socket's error queue instead of data queue. Possible
>scenario of error queue usage is receiving completions for transmission
>with MSG_ZEROCOPY flag. This patch also adds new defines: 'SOL_VSOCK'
>and 'VSOCK_RECVERR'.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v5(big patchset) -> v1:
>  * R-b tag removed, due to added defines to 'include/uapi/linux/vsock.h'.
>    Both 'SOL_VSOCK' and 'VSOCK_RECVERR' are needed by userspace, so
>    they were placed to 'include/uapi/linux/vsock.h'. At the same time,
>    the same define for 'SOL_VSOCK' was placed to 'include/linux/socket.h'.
>    This is needed because this file contains SOL_XXX defines for different
>    types of socket, so it prevents situation when another new SOL_XXX
>    will use constant 287.
>
> include/linux/socket.h     | 1 +
> include/uapi/linux/vsock.h | 9 +++++++++
> net/vmw_vsock/af_vsock.c   | 6 ++++++
> 3 files changed, 16 insertions(+)
> create mode 100644 include/uapi/linux/vsock.h
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
>diff --git a/include/uapi/linux/vsock.h b/include/uapi/linux/vsock.h
>new file mode 100644
>index 000000000000..b25c1347a3b8
>--- /dev/null
>+++ b/include/uapi/linux/vsock.h

We already have include/uapi/linux/vm_sockets.h

Should we include these changes there instead of creating a new header?

>@@ -0,0 +1,9 @@
>+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>+#ifndef _UAPI_LINUX_VSOCK_H
>+#define _UAPI_LINUX_VSOCK_H
>+
>+#define SOL_VSOCK	287

Why we need to re-define this also here?

In that case, should we protect with some guards to avoid double
defines?

>+
>+#define VSOCK_RECVERR	1
>+
>+#endif /* _UAPI_LINUX_VSOCK_H */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d841f4de33b0..4fd11bf34bc7 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -110,6 +110,8 @@
> #include <linux/workqueue.h>
> #include <net/sock.h>
> #include <net/af_vsock.h>
>+#include <linux/errqueue.h>
>+#include <uapi/linux/vsock.h>
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

