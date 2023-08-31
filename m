Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9D978F03C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346586AbjHaPZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346575AbjHaPZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:25:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3F510E5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693495409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T2qLYWseOqvE9giCpHzoh0LjB8ysce7C+TOetknN7JE=;
        b=SKnVrLSKLybIhGQDVtYXFDsXJQkb+9mGIQSjEgzgsR+cdsrBHejX6Fk4ed0VilVp6nDd8d
        CyzZ8a1fysV4VDAfKVDWVIvxb1uKpyNOo/SDQ5z4K9YF75Mw/hlb8NvxloFYZDlMHo3VDl
        1/XrqZaP9XRobncdEhXuS0t3XJUPP5o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-eNw341CEMy2iEgATU6V4RA-1; Thu, 31 Aug 2023 11:23:26 -0400
X-MC-Unique: eNw341CEMy2iEgATU6V4RA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-993d41cbc31so67946166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693495405; x=1694100205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2qLYWseOqvE9giCpHzoh0LjB8ysce7C+TOetknN7JE=;
        b=Pl1fzfdL5pDne+uR3mR5hxxP34FfD4shwe01P5f5aVlHG/voeaDJTZjU3SC5/1YAyy
         NHr9COSQWFYCkpJ4DD1xBYDbP3LD3NTa5W1v+80ZD7uH+OTEgTYJtignDQE8Q1J1W68T
         seQBfAdq/gyr081WvYpCY+wySsmLhVVmlfk8XKjZmYvlfCOzGNl3XfsuqZ6Jt3n3UVk+
         K7PDP/W1em2tZa2W/x5AnM5w7yu881FpDWOdaDAcxqWhGHdeE/kc0m/1B200tArzzUls
         LV92KTafcHwkeIr1jn2GdDVnD1vqiYmx0SQDuH6VKbHFUqG9a9Fh7HxyzAcbJyIWVRyA
         II9Q==
X-Gm-Message-State: AOJu0YyYud7+ktTLhzuCVsmSMGMXjqrzxCQkm0tn6cCQQnDtQ3tnUvsI
        cWW6/Kxbhj8KpDv714+/m9YMNL4m2ZriMAuaVBeVHEddXmIFTjzeTn4RTSt7aP/H9EwL297Bvvr
        gtbgAkJp6/bsSkpyLKY94Plrf
X-Received: by 2002:a17:907:270c:b0:99b:40b5:1c3b with SMTP id w12-20020a170907270c00b0099b40b51c3bmr4298759ejk.57.1693495404938;
        Thu, 31 Aug 2023 08:23:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqU32suFcax5N4zksCL5waYuwAr8trEmXcjLOBAuPXy6wP4BOWSV+IqSHWUR9lSPZ+Yzgs4w==
X-Received: by 2002:a17:907:270c:b0:99b:40b5:1c3b with SMTP id w12-20020a170907270c00b0099b40b51c3bmr4298742ejk.57.1693495404674;
        Thu, 31 Aug 2023 08:23:24 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it. [82.57.51.114])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709066b9200b009930308425csm859467ejr.31.2023.08.31.08.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:23:24 -0700 (PDT)
Date:   Thu, 31 Aug 2023 17:23:22 +0200
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
Subject: Re: [RFC PATCH v2 0/2] vsock: handle writes to shutdowned socket
Message-ID: <7byt3iwpo5ewpxkjwh6adlzq2nerrbv7trlreujuchsrkworxk@2jxzyul3o5cz>
References: <20230826175900.3693844-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230826175900.3693844-1-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

On Sat, Aug 26, 2023 at 08:58:58PM +0300, Arseniy Krasnov wrote:
>Hello,
>
>this small patchset adds POSIX compliant behaviour on writes to the
>socket which was shutdowned with 'shutdown()' (both sides - local with
>SHUT_WR flag, peer - with SHUT_RD flag). According POSIX we must send
>SIGPIPE in such cases (but SIGPIPE is not send when MSG_NOSIGNAL is set).
>
>First patch is implemented in the same way as net/ipv4/tcp.c:tcp_sendmsg_locked().
>It uses 'sk_stream_error()' function which handles EPIPE error. Another
>way is to use code from net/unix/af_unix.c:unix_stream_sendmsg() where
>same logic from 'sk_stream_error()' is implemented "from scratch", but
>it doesn't check 'sk_err' field. I think error from this field has more
>priority to be returned from syscall. So I guess it is better to reuse
>currently implemented 'sk_stream_error()' function.
>
>Test is also added.
>
>Head for this patchset is:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=b38460bc463c54e0c15ff3b37e81f7e2059bb9bb
>
>Link to v1:
>https://lore.kernel.org/netdev/20230801141727.481156-1-AVKrasnov@sberdevices.ru/
>
>Changelog:
>v1 -> v2:
> * 0001 stills the same - SIGPIPE is sent only for SOCK_STREAM as discussed in v1
>   with Stefano Garzarella <sgarzare@redhat.com>.
> * 0002 - use 'sig_atomic_t' instead of 'bool' for flag variables updated from
>   signal handler.
>
>Arseniy Krasnov (2):
>  vsock: send SIGPIPE on write to shutdowned socket
>  test/vsock: shutdowned socket test

Thanks for this series, I fully reviewed it, LGTM!

Please send it targeting net-next when it reopens.

Stefano

