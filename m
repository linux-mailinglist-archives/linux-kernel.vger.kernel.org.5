Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C4B7B6E73
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbjJCQ1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239387AbjJCQ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E7D9E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696350406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uQC0BP7YgGzddk6JoxXZteyIFRUQfQrHXDu0A5yDa1A=;
        b=TiyLl9332tQ+hjX2lGhe6ELFeksRjzd6CHee4sFAxSqutIa9kPKhAlIYVcFv4eW/nxmrcz
        XwInpQMkRAwFYGcWfMBwc1zWawsJWHcqCHwPYwnMJZK4EyRlJ8MMjJaxKUHmWaA/f9Q+Tq
        FpPU0IuGwKZsVGSbiTMwvUSKry1RbF0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-i4yik8YUOyOLI6gmO1UUbQ-1; Tue, 03 Oct 2023 12:26:40 -0400
X-MC-Unique: i4yik8YUOyOLI6gmO1UUbQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-418145b6579so12876351cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 09:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696350400; x=1696955200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQC0BP7YgGzddk6JoxXZteyIFRUQfQrHXDu0A5yDa1A=;
        b=fE15L0zwGEgrtP7+oMdqh4cXY0+WCl4W5zWducOdcEzbbkqRevb/ybEY+aUchoZDcr
         F02O7rqV8FHsBe73h3m2tuwiCcj6IpGah7YqBnqzcyuxPuQlEqBQU9Wf+UEOe+QL2X8J
         vtj1E36l1iRZQGktDHaHbDdcE/VXAsyYUs/CuPO3qHNBbtiu/SUNajE21DiRIL0Y86Fi
         9SVqnubfgDKZ9y5kCb61nBZCTdH7ypW79DMvOufQDgSJdaobT9uGf3c5jxn3FaKyXDrL
         ISPk6p2IFnOiwPvB6kJgS3rxQ4zhp7Xep9hqjljWxeBv4E3A9kYQRCC5m1i5MRvgfkm0
         qvsA==
X-Gm-Message-State: AOJu0YxQA5QFtLpGzQHw/BZNobG6wDPSr4QX//iuRJ2Lahr0eaXbtDvF
        PDFQWaBJDhmKwhXeN+W3DUkmwqH/Vx0m6FAhBZVqzSkA7qUh0OuCG4Ay+LQTC7C8UK722KIRmVQ
        RNN7hljrB6ugr9PhCBJdn5XE4
X-Received: by 2002:ac8:584b:0:b0:412:1e0a:772a with SMTP id h11-20020ac8584b000000b004121e0a772amr15546011qth.17.1696350399953;
        Tue, 03 Oct 2023 09:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFht7odWq29a5TBcW7tc++EJIJSk2vinTPEHJlpdDK6A2y2BG7b5sXjcJoBiiC5Txm/f/rEtA==
X-Received: by 2002:ac8:584b:0:b0:412:1e0a:772a with SMTP id h11-20020ac8584b000000b004121e0a772amr15545983qth.17.1696350399671;
        Tue, 03 Oct 2023 09:26:39 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it. [82.57.51.114])
        by smtp.gmail.com with ESMTPSA id e13-20020ac8130d000000b004196a813639sm557692qtj.17.2023.10.03.09.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:26:39 -0700 (PDT)
Date:   Tue, 3 Oct 2023 18:26:34 +0200
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
Subject: Re: [PATCH net-next v2 00/12] vsock/virtio: continue MSG_ZEROCOPY
 support
Message-ID: <4nwo6nd2ihjqsoqnjdjhuucqyc4fhfhxk52q6ulrs6sd2fmf7z@24hi65hbpl4i>
References: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
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

On Sun, Oct 01, 2023 at 12:02:56AM +0300, Arseniy Krasnov wrote:
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
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=236f3873b517acfaf949c23bb2d5dec13bfd2da2
>
>Link to v1:
>https://lore.kernel.org/netdev/20230922052428.4005676-1-avkrasnov@salutedevices.com/
>
>Changelog:
> v1 -> v2:
> * Patchset rebased and tested on new HEAD of net-next (see hash above).
> * See per-patch changelog after ---.

Thanks for this new version.
I started to include vsock_uring_test in my test suite and tests are
going well.

I reviewed code patches, I still need to review the tests.
I'll do that by the end of the week, but they looks good!

Thanks,
Stefano

