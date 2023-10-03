Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BAB7B6E62
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbjJCQYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240209AbjJCQYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADBEAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696350240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BApKczrxEPgLzQsQyB3wpnpVoMtABSfbJmV036In4jc=;
        b=hyaS2aEZeMxOpuScysmywA2Ijcg0blza9qbXf3RrPr//LW8rQD6h7hKNYnyNtPcRVVQQC7
        ub5EbYRsU5V79r3hOl3V5iFgtZywadF5qqZl8ENpOXku0+d2o47T+m4FRwNNmqI/qCZXCf
        zOyMSnpA9bMQ5tRt8yMcqCLLHBUe0Yg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-Ee5zEWXOMKG96Wfq9zdwCw-1; Tue, 03 Oct 2023 12:23:53 -0400
X-MC-Unique: Ee5zEWXOMKG96Wfq9zdwCw-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-d8943298013so1255961276.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 09:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696350233; x=1696955033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BApKczrxEPgLzQsQyB3wpnpVoMtABSfbJmV036In4jc=;
        b=B2IrdOzftCCvNnQsYlkM1xl/BgDyxRKEIXfwjg++oF6hWeplY2e+MEZSifMhv58rZt
         /e8u9y6LWdN5taSG9lcmu/vxcAUbZorDHAkjtdqiJw0MlJs25vzcjUnz363Z6XbqwEHK
         ppljZZRrUgSEyiuJzcCLWV4VOD3Wk0jv/b3GHUF0jKIm7qgcsdStAj36Ga81QQFWcXz1
         4CZup85Zm+Tt63YbTip/gKWDbnNOgP7/wbLsWbYoqJNhqPUbApNj8qlw1h+WcVTWgaJ7
         tvdl1hBf3L3yoxtghxBhkhRkBExuEB7sVkLF2JzIZ9INaCzHUae4Al7lsk7XsV3YFxQ0
         UPwA==
X-Gm-Message-State: AOJu0YyJNhnvewiehJ888okEt4FDP2NZUhb44V+B76um+3pgx69A5b5W
        PV5zNHVv27CElo/B65vJFPUNhlTzZGldFN3W3jy7Q8ZsPOPtflZkmpohl9gHNlle/Rx3gn4ti6S
        nuNcSkfuepxofDfIFFm4anMwr
X-Received: by 2002:a25:6fc1:0:b0:d74:62df:e802 with SMTP id k184-20020a256fc1000000b00d7462dfe802mr13099902ybc.0.1696350233389;
        Tue, 03 Oct 2023 09:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFA4CkY3jrhTI4v/yIBb1i8/xVZlYFpMjG1ENvBNmWm2bYF1ZcRT0YuJJUdqErnU00bMgI0g==
X-Received: by 2002:a25:6fc1:0:b0:d74:62df:e802 with SMTP id k184-20020a256fc1000000b00d7462dfe802mr13099882ybc.0.1696350233091;
        Tue, 03 Oct 2023 09:23:53 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it. [82.57.51.114])
        by smtp.gmail.com with ESMTPSA id y6-20020a0ce046000000b0065823d20381sm596479qvk.8.2023.10.03.09.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:23:52 -0700 (PDT)
Date:   Tue, 3 Oct 2023 18:23:48 +0200
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
Subject: Re: [PATCH net-next v2 09/12] docs: net: description of MSG_ZEROCOPY
 for AF_VSOCK
Message-ID: <waco5sx7dxzvb7ogs3nnxugrt7afppk3432wc2fwwovic5y4pa@wmdi3tis36rz>
References: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
 <20230930210308.2394919-10-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230930210308.2394919-10-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 12:03:05AM +0300, Arseniy Krasnov wrote:
>This adds description of MSG_ZEROCOPY flag support for AF_VSOCK type of
>socket.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Documentation/networking/msg_zerocopy.rst | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/Documentation/networking/msg_zerocopy.rst b/Documentation/networking/msg_zerocopy.rst
>index b3ea96af9b49..78fb70e748b7 100644
>--- a/Documentation/networking/msg_zerocopy.rst
>+++ b/Documentation/networking/msg_zerocopy.rst
>@@ -7,7 +7,8 @@ Intro
> =====
>
> The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
>-The feature is currently implemented for TCP and UDP sockets.
>+The feature is currently implemented for TCP, UDP and VSOCK (with
>+virtio transport) sockets.
>
>
> Opportunity and Caveats
>@@ -174,7 +175,9 @@ read_notification() call in the previous snippet. A notification
> is encoded in the standard error format, sock_extended_err.
>
> The level and type fields in the control data are protocol family
>-specific, IP_RECVERR or IPV6_RECVERR.
>+specific, IP_RECVERR or IPV6_RECVERR (for TCP or UDP socket).
>+For VSOCK socket, cmsg_level will be SOL_VSOCK and cmsg_type will be
>+VSOCK_RECVERR.
>
> Error origin is the new type SO_EE_ORIGIN_ZEROCOPY. ee_errno is zero,
> as explained before, to avoid blocking read and write system calls on
>@@ -235,12 +238,15 @@ Implementation
> Loopback
> --------
>
>+For TCP and UDP:
> Data sent to local sockets can be queued indefinitely if the receive
> process does not read its socket. Unbound notification latency is not
> acceptable. For this reason all packets generated with MSG_ZEROCOPY
> that are looped to a local socket will incur a deferred copy. This
> includes looping onto packet sockets (e.g., tcpdump) and tun devices.
>
>+For VSOCK:
>+Data path sent to local sockets is the same as for non-local sockets.
>
> Testing
> =======
>@@ -254,3 +260,6 @@ instance when run with msg_zerocopy.sh between a veth pair across
> namespaces, the test will not show any improvement. For testing, the
> loopback restriction can be temporarily relaxed by making
> skb_orphan_frags_rx identical to skb_orphan_frags.
>+
>+For VSOCK type of socket example can be found in
>+tools/testing/vsock/vsock_test_zerocopy.c.
>-- 
>2.25.1
>

