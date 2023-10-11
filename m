Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0669A7C549D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346776AbjJKM7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346944AbjJKM6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8E091
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697029087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=srINTOA9TWB2isXW3Sgrz+IUFVxpno9ZCmYhECMZXz8=;
        b=YznvrzBAxFd9HeEr8zA/vdlev/B7Znsa/HCmIusic5uYUya7WIEzndlqf7je8e9dkk+2wN
        1eusof51YuMgvHTZVf4ZbG+dQk3F/HL8mh0AO5IhFUtQv/JjpJvQf188dlhvKaZVnlC+rL
        3gjWnxdy32rQaDLpAXVNBx9TbdEJUys=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-ihJFZDldPqyPKF8hdvwwXg-1; Wed, 11 Oct 2023 08:58:05 -0400
X-MC-Unique: ihJFZDldPqyPKF8hdvwwXg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-77409676d7dso742916285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697029085; x=1697633885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srINTOA9TWB2isXW3Sgrz+IUFVxpno9ZCmYhECMZXz8=;
        b=Nj4BYrMVvCNbz+x4EL8JPXPJ6I3e7cH5n+4Tm1cFe4w1RFB4f2BYqQIfnyP83SO7lf
         tY3bdae4xhRXTSts5Z6cKG9LZUxfuM91r9PZMqPdPD76X4VNipjnSaB6amXbOHs6N/L/
         L0Kmc9brucfgwN7s+NgC9bNfapucM4kYriUatooDg9j209Y2UzH71yCJ8Ug36/ZkrgbV
         GeDPgGmUCZpf4PV4aDeGsR8A7pqagFZd76BdBLhHZjh0zauIYOX+KmK/B8qRUraAFgCd
         prZeRKcwxr/so1qfGskzwzfqUlHKIbNVlTG746rjKIkdkbpFkq28XwoeZBhxiQurGyVa
         qocQ==
X-Gm-Message-State: AOJu0YzCoTUXW74Fxk0lOkMcv2z64wdsRlGnrLUWhKHUsPsqIHinuasD
        PDOTFmDf5oPF0SCHxbCyiDVHxqQa/GGXgvOGB0OTdZMEABP7glFOcMCWTcZm8N6nZl33s3VuEML
        IwUbOskEpcKAh1+M7JT2nKRdM
X-Received: by 2002:a05:620a:28c1:b0:772:64b3:889f with SMTP id l1-20020a05620a28c100b0077264b3889fmr23924383qkp.29.1697029085393;
        Wed, 11 Oct 2023 05:58:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEat3sMaNphExceyLByW9stmPTXf2ifIIJ9bDX8SUeZpYDbCXHEF5UpdzIbTW2PMO+Wgc/Bfg==
X-Received: by 2002:a05:620a:28c1:b0:772:64b3:889f with SMTP id l1-20020a05620a28c100b0077264b3889fmr23924364qkp.29.1697029085125;
        Wed, 11 Oct 2023 05:58:05 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-251.retail.telecomitalia.it. [79.46.200.251])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a121000b0076cdc3b5beasm5193811qkj.86.2023.10.11.05.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:58:04 -0700 (PDT)
Date:   Wed, 11 Oct 2023 14:57:57 +0200
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
Subject: Re: [PATCH net-next v4 00/12] vsock/virtio: continue MSG_ZEROCOPY
 support
Message-ID: <eey4hfz43popgwlwtheapjefzmxea7dk733y3v6aqsrewhq3mq@lcmmhdpwvvzc>
References: <20231010191524.1694217-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231010191524.1694217-1-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:15:12PM +0300, Arseniy Krasnov wrote:
>Hello,
>
>this patchset contains second and third parts of another big patchset
>for MSG_ZEROCOPY flag support:
>https://lore.kernel.org/netdev/20230701063947.3422088-1-AVKrasnov@sberdevices.ru/
>
>During review of this series, Stefano Garzarella <sgarzare@redhat.com>
>suggested to split it for three parts to simplify review and merging:
>
>1) virtio and vhost updates (for fragged skbs) (merged to net-next, see
>   link below)
>2) AF_VSOCK updates (allows to enable MSG_ZEROCOPY mode and read
>   tx completions) and update for Documentation/. <-- this patchset
>3) Updates for tests and utils. <-- this patchset
>
>Part 1) was merged:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=71b263e79370348349553ecdf46f4a69eb436dc7
>
>Head for this patchset is:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=19537e125cc7cf2da43a606f5bcebbe0c9aea4cc
>
>Link to v1:
>https://lore.kernel.org/netdev/20230922052428.4005676-1-avkrasnov@salutedevices.com/
>Link to v2:
>https://lore.kernel.org/netdev/20230930210308.2394919-1-avkrasnov@salutedevices.com/
>Link to v3:
>https://lore.kernel.org/netdev/20231007172139.1338644-1-avkrasnov@salutedevices.com/
>
>Changelog:
> v1 -> v2:
> * Patchset rebased and tested on new HEAD of net-next (see hash above).
> * See per-patch changelog after ---.
> v2 -> v3:
> * Patchset rebased and tested on new HEAD of net-next (see hash above).
> * See per-patch changelog after ---.
> v3 -> v4:
> * Patchset rebased and tested on new HEAD of net-next (see hash above).
> * See per-patch changelog after ---.

I think I fully reviewed the series ;-)

Tests are all passing here, including the new ones. I also added
vsock_perf and vsock_uring_test to my test suite!

So for vsock point of view everything looks fine.

Let's see if there is anything about net (MSG_ZEROCOPY flags, etc.)

Thanks,
Stefano

