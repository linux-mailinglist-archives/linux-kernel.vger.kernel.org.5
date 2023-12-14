Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79761812C50
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443483AbjLNJ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443458AbjLNJ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:57:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD92F5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702547861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VbNgQOlqA6uJ+zRh1fYoyaXPvn6oHay0OVtTkel+hcE=;
        b=afl6yFNrcPSPQhR5d7Q5SiztbiWRVtiA3HdPD+6TRZo84J3kdvI8MqrJNxuRhnfGSvBTzv
        XRmNmeC4RPkavbeY8W/Kmt6TY2ITHY2t++u92/SH3iiOBsfQ5yDFmk3KjaN8ekHHDT3tqB
        bCdW7YBzJ8vVycxc7M1YcyLMHKCi4Sc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-DbT9u2H8O7ywFS9t4f7Bjw-1; Thu, 14 Dec 2023 04:57:38 -0500
X-MC-Unique: DbT9u2H8O7ywFS9t4f7Bjw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33608b14b3cso5643117f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702547857; x=1703152657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbNgQOlqA6uJ+zRh1fYoyaXPvn6oHay0OVtTkel+hcE=;
        b=gsh0BbMEytQbp71xpldxHA8Rg6e5WcYduti5LFxhslkAYjIk3Nq8+gWOUVrv2/Z9Hs
         vZinopiHnkfiiDYky5bEpOufO3/DsL84dmZK+VIbPMRMyX7bSMEGXWg2qOeENHoVZcgx
         6wWvDvIOvlyWRlj3t7KRr5ITrdwbUEl6ti8WnEbTSZaZQ4G6tqhFjYha6p2/9Mdkim+z
         2hOojrs+icfMFX4I6GM28lkNsXIvX9MOq0RQKv8DXvF4BB0COqRBIN9YcERXcHHtA4Wg
         RGg5BaxWAjQ710I5orS9uvleTWU95CUOG/Y65xOLFM8FlVjsY7gkS2SMZcH7BvS5KWKx
         b7sA==
X-Gm-Message-State: AOJu0YwVtewp52YRaa0cQMBga+iXOtuQ+ACffbir+Srle0bveVRb2Y4p
        +ZMo6f+GBhWDxGcSbDskj1NOdO1mL7hgwMxOG0AI3L820RSxwnIFTbLKtm3gP2NsDFLCXpro5KI
        FPhI+lD9diWEDB3k2kiwkV1Kb
X-Received: by 2002:a05:600c:b43:b0:40b:5e1e:cf2 with SMTP id k3-20020a05600c0b4300b0040b5e1e0cf2mr4879013wmr.45.1702547857609;
        Thu, 14 Dec 2023 01:57:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIMcrRPUr2M5N3AZHrTn2j7CFarP7ZToRtVz3Wt+VPt0vGWHfE5JUVAn5fPT1rWcRb4rxeWQ==
X-Received: by 2002:a05:600c:b43:b0:40b:5e1e:cf2 with SMTP id k3-20020a05600c0b4300b0040b5e1e0cf2mr4878999wmr.45.1702547857326;
        Thu, 14 Dec 2023 01:57:37 -0800 (PST)
Received: from sgarzare-redhat ([5.11.101.217])
        by smtp.gmail.com with ESMTPSA id s13-20020a05600c384d00b004030e8ff964sm26261376wmr.34.2023.12.14.01.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:57:36 -0800 (PST)
Date:   Thu, 14 Dec 2023 10:57:30 +0100
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
Subject: Re: [PATCH net-next v9 2/4] virtio/vsock: send credit update during
 setting SO_RCVLOWAT
Message-ID: <rambimqosesmdqnko3ttcntpzrq7cm376pln6qsohtz7phm3un@ln3ate7qmcp7>
References: <20231214091947.395892-1-avkrasnov@salutedevices.com>
 <20231214091947.395892-3-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231214091947.395892-3-avkrasnov@salutedevices.com>
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

On Thu, Dec 14, 2023 at 12:19:45PM +0300, Arseniy Krasnov wrote:
>Send credit update message when SO_RCVLOWAT is updated and it is bigger
>than number of bytes in rx queue. It is needed, because 'poll()' will
>wait until number of bytes in rx queue will be not smaller than
>SO_RCVLOWAT, so kick sender to send more data. Otherwise mutual hungup
>for tx/rx is possible: sender waits for free space and receiver is
>waiting data in 'poll()'.
>
>Fixes: b89d882dc9fc ("vsock/virtio: reduce credit update messages")
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>---
> Changelog:
> v1 -> v2:
>  * Update commit message by removing 'This patch adds XXX' manner.
>  * Do not initialize 'send_update' variable - set it directly during
>    first usage.
> v3 -> v4:
>  * Fit comment in 'virtio_transport_notify_set_rcvlowat()' to 80 chars.
> v4 -> v5:
>  * Do not change callbacks order in transport structures.
> v5 -> v6:
>  * Reorder callbacks in transport structures.
>  * Do to send credit update when 'fwd_cnt' == 'last_fwd_cnt'.
> v8 -> v9:
>  * Add 'Fixes' tag.
>
> drivers/vhost/vsock.c                   |  1 +
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport.c        |  1 +
> net/vmw_vsock/virtio_transport_common.c | 30 +++++++++++++++++++++++++
> net/vmw_vsock/vsock_loopback.c          |  1 +
> 5 files changed, 34 insertions(+)

As I already mentioned in the cover letter, this patch doesn't compile
unless we apply patch 3 before this one, so:

Nacked-by: Stefano Garzarella <sgarzare@redhat.com>

