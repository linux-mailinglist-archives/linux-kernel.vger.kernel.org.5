Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE48A80D1D9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344630AbjLKQdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343947AbjLKQdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:33:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6618098
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702312427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bzIkbZpiRzJdrc6a6vDeJqlwsyKzW2Z5OW2xriwEAsQ=;
        b=IMw7ytCLi2monybRlcj8JSOMhfyBFpVdwa5MKXWH0QkExQlITZpPmU0y/JmYut2WGMJzJX
        RsLdMMMl+1J7z5rK9AtJQbSa33UNBge8OlZyqpXe5kgrWnagiGbGQKX7pIRXhdgR7bV6uu
        rK7w3p+xY0twgeYmuzIvWAeAELm6P2A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-9zal4XC4MWqozkqSOdlzJg-1; Mon, 11 Dec 2023 11:33:45 -0500
X-MC-Unique: 9zal4XC4MWqozkqSOdlzJg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c28da6667so28405735e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312425; x=1702917225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzIkbZpiRzJdrc6a6vDeJqlwsyKzW2Z5OW2xriwEAsQ=;
        b=fVzh2wEo+208ikC761JXtH6/BOhkq0FU5x4S+av7/n0digxCfZ62kuNX+ehB0PHjq0
         EFwTXLRUDDvWBm/rTAEHwwz9VLFjW6ZbFFK/1kLfrHwSKs4BTK8pdxVUC1xQIRa7ZPX9
         Mgv+SzJyZFHSts9AvffQPsyko7/9XAGMz9ebXThGzPSwbGc1y4T6IGMgm39L7bKkA28/
         gOw/Tr4JwE9O3wowsPOQitkq+/rW/M5aPBQDXKCNSgSBA1wRmiLjvDu7tpTGB9BqeirA
         Y29sHpOky8t6y/0sqqL31e+/0cNGQBjuNV7qnv6mYLZQokP8zoMG/RitfOVSqi8bVd31
         JNrA==
X-Gm-Message-State: AOJu0YzbUN+ao231g65ZDA0Xitamu5ni1Dfu16HKtdFuhu/j52Fnt7DS
        PFBEh6XYv92B5LYbJJDB5B/8ASpsMzotStnzlNQnqcNuoAy894LviHFG2RtUVSWkz/ehsHmHbGL
        TA4Q5lFoa0nS10mMHoK0prCx6
X-Received: by 2002:a05:600c:501e:b0:40c:25c7:b340 with SMTP id n30-20020a05600c501e00b0040c25c7b340mr1172680wmr.281.1702312424866;
        Mon, 11 Dec 2023 08:33:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVGkZ4+oYYezirnB3Q25N7aHGvQW9MmXB7XVlCjjG2JGiHt8ONICyX4hMLT/PJy3biQX9FqQ==
X-Received: by 2002:a05:600c:501e:b0:40c:25c7:b340 with SMTP id n30-20020a05600c501e00b0040c25c7b340mr1172674wmr.281.1702312424427;
        Mon, 11 Dec 2023 08:33:44 -0800 (PST)
Received: from sgarzare-redhat ([95.131.45.143])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00405c7591b09sm13524344wmo.35.2023.12.11.08.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:33:43 -0800 (PST)
Date:   Mon, 11 Dec 2023 17:33:39 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Nikolay Kuratov <kniv@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v2] vsock/virtio: Fix unsigned integer wrap around in
 virtio_transport_has_space()
Message-ID: <nuyxku7erp67jjs2uw4kpufwxcgdrevl2lqys5fyltzgz6ikgk@3db26gkjghjw>
References: <t6mnn7lyusvwt4knlxkgaajphhs6es5xr6hr7iixtwrfcljw67@foceocwkayk2>
 <20231211162317.4116625-1-kniv@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231211162317.4116625-1-kniv@yandex-team.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 07:23:17PM +0300, Nikolay Kuratov wrote:
>We need to do signed arithmetic if we expect condition
>`if (bytes < 0)` to be possible
>
>Found by Linux Verification Center (linuxtesting.org) with SVACE
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
>---
>
>V1 -> V2: Added Fixes section

Please, next time carry also R-b tags.

>
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index c8e162c9d1df..6df246b53260 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -843,7 +843,7 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
> 	struct virtio_vsock_sock *vvs = vsk->trans;
> 	s64 bytes;
>
>-	bytes = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>+	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
> 	if (bytes < 0)
> 		bytes = 0;
>
>-- 
>2.34.1
>
>

