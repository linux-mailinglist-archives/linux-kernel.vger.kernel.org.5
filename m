Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490767CF35A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345008AbjJSIzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjJSIzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:55:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB32129
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697705670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wEAJ+VDUrNVXU5xbHG/3Z3vLqN5pIVSHhZmt7Niw3wo=;
        b=NqtpNseF/ro67oDdwHxRPxrvti6lW2IjbvU708bshs34mJMSwCwyNsxtITXl6pZsztDbir
        stfhdd3ral3HkAQc6RDE8IO4LWHyV9z5Tt2bO+GOSV+F/A10qRgOZQaI5mkhG8xQRJGzBX
        V313ThuZdXz7h5TRrJzryxTWuaap6L4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-fU9XmV1pN3-jboGM3NMt-g-1; Thu, 19 Oct 2023 04:54:29 -0400
X-MC-Unique: fU9XmV1pN3-jboGM3NMt-g-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-53ec72af708so3315420a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697705668; x=1698310468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEAJ+VDUrNVXU5xbHG/3Z3vLqN5pIVSHhZmt7Niw3wo=;
        b=FQYjFl/7zj35Fb8FtBWUDkuVE3i09kJr10CRsoVICnXh6HLA7PrDW7ZMfWWW1JEZBf
         bQ4Mn5LXh5oCsc1Ge+r+VwPCyrqEvw5UZz8zXW9iEdGZpYVHltzajbKQIBPuj3JJCJVu
         w/MN1hwmu4jHuimKq5ErIvTciph2YZOoW1l5s08Dck/h3SmNZ9GFe2J/qQcg64bLvHAx
         8Kb4kNTFnqpANxiEUXHhId2Suaad88K1zOjLYuE9YVtfzezhXXzpo2FDkQ/896XoDE6r
         EOV6j5DfBo1QTzsLU1jj2XJCY3Jd9XQ3A/7MAJCjJi4FEfcAHObm7Fu1/pDdbsk/4SBm
         pxKQ==
X-Gm-Message-State: AOJu0Yy/hDddV5eSBV+aWrFXeaaoKMJN80WH+RN5WQGY5PL4XX9mHxOC
        20+jmi4GE9UyL+R5+Hc/zZZeTjI55OTuuqOen+SOs2gBmj/zFYPfmqHaXVOTvVaw9S7YMsLdu+H
        HalxEz1ySNF/Vl/5kdBf5f2y4
X-Received: by 2002:a05:6402:3483:b0:53e:3fce:251 with SMTP id v3-20020a056402348300b0053e3fce0251mr1126830edc.0.1697705668235;
        Thu, 19 Oct 2023 01:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFACpGM/rzsBWnQw0oghgETBEoNMcsod/FUAw+yf7qyqXIbwEBgi5TL8hRsdtikCm2vUW/WVg==
X-Received: by 2002:a05:6402:3483:b0:53e:3fce:251 with SMTP id v3-20020a056402348300b0053e3fce0251mr1126810edc.0.1697705667920;
        Thu, 19 Oct 2023 01:54:27 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it. [87.12.185.56])
        by smtp.gmail.com with ESMTPSA id v23-20020a50d597000000b0053e2a64b5f8sm4088664edi.14.2023.10.19.01.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 01:54:27 -0700 (PDT)
Date:   Thu, 19 Oct 2023 10:54:21 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Alexandru Matei <alexandru.matei@uipath.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mihai Petrisor <mihai.petrisor@uipath.com>,
        Viorel Canja <viorel.canja@uipath.com>
Subject: Re: [PATCH] vsock: initialize the_virtio_vsock before using VQs
Message-ID: <a5lw3t5uaqoeeu5j3ertyoprgsyxxrsfqawyuqxjkkbsuxjywh@vh7povjz2s2c>
References: <20231018183247.1827-1-alexandru.matei@uipath.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231018183247.1827-1-alexandru.matei@uipath.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 09:32:47PM +0300, Alexandru Matei wrote:
>Once VQs are filled with empty buffers and we kick the host, it can send
>connection requests. If 'the_virtio_vsock' is not initialized before,
>replies are silently dropped and do not reach the host.

Are replies really dropped or we just miss the notification?

Could the reverse now happen, i.e., the guest wants to send a connection 
request, finds the pointer assigned but can't use virtqueues because 
they haven't been initialized yet?

Perhaps to avoid your problem, we could just queue vsock->rx_work at the 
bottom of the probe to see if anything was queued in the meantime.

Nit: please use "vsock/virtio" to point out that this problem is of the 
virtio transport.

Thanks,
Stefano

>
>Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
>Signed-off-by: Alexandru Matei <alexandru.matei@uipath.com>
>---
> net/vmw_vsock/virtio_transport.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index e95df847176b..eae0867133f8 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -658,12 +658,13 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 		vsock->seqpacket_allow = true;
>
> 	vdev->priv = vsock;
>+	rcu_assign_pointer(the_virtio_vsock, vsock);
>
> 	ret = virtio_vsock_vqs_init(vsock);
>-	if (ret < 0)
>+	if (ret < 0) {
>+		rcu_assign_pointer(the_virtio_vsock, NULL);
> 		goto out;
>-
>-	rcu_assign_pointer(the_virtio_vsock, vsock);
>+	}
>
> 	mutex_unlock(&the_virtio_vsock_mutex);
>
>-- 
>2.34.1
>
>

