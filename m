Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D810E7D3952
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjJWOat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjJWOar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A56D6E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698071401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kySDKR+e82Dq0GbnFVXWHHRylAyqPYM5YM7Pq4ou10o=;
        b=YPPKTLEWMz71VJKf26TeTMDeP4qvLICfa21XHMJqyqdMKvGE4MYbOPjkbbnZzQdmGheWir
        TTxBclWYyAfHgFiu+vpNDntXsmvdEzQavmo1bja+20/BnqdhhHTnM46o9u6W1+TEH5CkPv
        3qjG+6o9cKj+kXPj1hpQ+9moLTvXtlE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-n_AbYufFMGuO3vhS5WyqNw-1; Mon, 23 Oct 2023 10:29:58 -0400
X-MC-Unique: n_AbYufFMGuO3vhS5WyqNw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7789577b582so452512085a.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698071397; x=1698676197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kySDKR+e82Dq0GbnFVXWHHRylAyqPYM5YM7Pq4ou10o=;
        b=kSUPKdpf+8DiSOrMTWr6A798XsW9s636SzyeGi1u3oaeArMo6CCb6pQaIZBFezTyIv
         peUMvHPQHfCPtmUaccyVBsIcwZTCVnG6/jfuiSTz7o3N8RTDsikfv6l1P7qHgtbOwdT4
         7q3iRFlQaxVD4JlCACOz20tMghsaDQkRx97uQV32q8cyRoBVBwyJ8IdmMNKkCY+BoFXH
         OxgeFv9dA/9jjyG+IgsB6P/qRBegsSmL1etRH+j2AB1Tf4VySaQgp2PcHhwX5LeyOucC
         p1gpUqf8idrZNHFR1zKui4ZWGvkR1umsq/xtt9eo/+Ggmnr2gEFLJ+FAzGiWeBmesKfz
         6wJw==
X-Gm-Message-State: AOJu0YwSa/2WhOk+goxEEQMSFrw4A6bZ6rYP6Mq63vb2LjwAEPxNYYuR
        OeTfQrFjlzczZisr7OCcpLrnIDNQXHokc0IcnjMLVdl5Yhm4Kt+Hzewmn+uiM47weNnxyL1B+GJ
        aA0L3AUeM0CCRhHV+HSnCCo5m
X-Received: by 2002:a05:620a:c4c:b0:778:b0f5:d4e7 with SMTP id u12-20020a05620a0c4c00b00778b0f5d4e7mr8747572qki.46.1698071397508;
        Mon, 23 Oct 2023 07:29:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoIEdB7iELDRun3hsVSPuymnAKtgjwualgCraxWcYPHJJfqhEETtyAiBCcLGcgIIkq3BUmLg==
X-Received: by 2002:a05:620a:c4c:b0:778:b0f5:d4e7 with SMTP id u12-20020a05620a0c4c00b00778b0f5d4e7mr8747549qki.46.1698071397203;
        Mon, 23 Oct 2023 07:29:57 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it. [87.12.185.56])
        by smtp.gmail.com with ESMTPSA id k22-20020a05620a143600b00774350813ccsm2736609qkj.118.2023.10.23.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:29:56 -0700 (PDT)
Date:   Mon, 23 Oct 2023 16:29:48 +0200
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
Subject: Re: [PATCH v2] vsock/virtio: initialize the_virtio_vsock before
 using VQs
Message-ID: <2tc56vwgs5xwqzfqbv5vud346uzagwtygdhkngdt3wjqaslbmh@zauky5czyfkg>
References: <20231023140833.11206-1-alexandru.matei@uipath.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231023140833.11206-1-alexandru.matei@uipath.com>
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

On Mon, Oct 23, 2023 at 05:08:33PM +0300, Alexandru Matei wrote:
>Once VQs are filled with empty buffers and we kick the host,
>it can send connection requests.  If 'the_virtio_vsock' is not
>initialized before, replies are silently dropped and do not reach the host.
>
>Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
>Signed-off-by: Alexandru Matei <alexandru.matei@uipath.com>
>---
>v2:
>- split virtio_vsock_vqs_init in vqs_init and vqs_fill and moved
>  the_virtio_vsock initialization after vqs_init
>
> net/vmw_vsock/virtio_transport.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index e95df847176b..92738d1697c1 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -559,6 +559,11 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> 	vsock->tx_run = true;
> 	mutex_unlock(&vsock->tx_lock);
>
>+	return 0;
>+}
>+
>+static void virtio_vsock_vqs_fill(struct virtio_vsock *vsock)

What about renaming this function in virtio_vsock_vqs_start() and move 
also the setting of `tx_run` here?

Thanks,
Stefano

>+{
> 	mutex_lock(&vsock->rx_lock);
> 	virtio_vsock_rx_fill(vsock);
> 	vsock->rx_run = true;
>@@ -568,8 +573,6 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> 	virtio_vsock_event_fill(vsock);
> 	vsock->event_run = true;
> 	mutex_unlock(&vsock->event_lock);
>-
>-	return 0;
> }
>
> static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>@@ -664,6 +667,7 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 		goto out;
>
> 	rcu_assign_pointer(the_virtio_vsock, vsock);
>+	virtio_vsock_vqs_fill(vsock);
>
> 	mutex_unlock(&the_virtio_vsock_mutex);
>
>@@ -736,6 +740,7 @@ static int virtio_vsock_restore(struct virtio_device *vdev)
> 		goto out;
>
> 	rcu_assign_pointer(the_virtio_vsock, vsock);
>+	virtio_vsock_vqs_fill(vsock);
>
> out:
> 	mutex_unlock(&the_virtio_vsock_mutex);
>-- 
>2.34.1
>

