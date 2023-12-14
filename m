Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB49812CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443637AbjLNK3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443599AbjLNK3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:29:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB82115
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702549788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mNaidnArOatG5DPMZgGUNeTPrppTOu1ght+u2+9nPgo=;
        b=Bo7FbkhBee1ZsvFqeKV7xlwzV5nF0IJGhAJx6U2JV8Z+ctcFplytgVYwjJX4sN88q9f9sZ
        cC4huT7To850WW0hMa+JESjiJSw+r4Pb9KOIHxEMIZmDf2vmrTQrqZfhd8tGsX69bUN0rz
        wS0wp8XDJQ+CwYqVBd6rbncnzCrFeao=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-CTDXJDGqMkSVcPwJOp2I2g-1; Thu, 14 Dec 2023 05:29:46 -0500
X-MC-Unique: CTDXJDGqMkSVcPwJOp2I2g-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ca29454857so73217361fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:29:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702549785; x=1703154585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNaidnArOatG5DPMZgGUNeTPrppTOu1ght+u2+9nPgo=;
        b=twwVBl/3cCwEHIy73a5Z2fsM/SHqYmJO4KZ/3DXqnA2G5iPtTRj1wTkjOn84H4RqnG
         +8NwhriGX9jWQ8UOjTcMVXItSW6iuoWo3vwihPDNepy97RpyeoBIiwE4h5P2E3tk8lfO
         mSnb7O5VZP3VcEliFNrr/93Frm+naUqxjD1A2k2K4bZnp74+4fSnlyCigCrF8rhwmnrT
         ZX/5YhtZc9iETofvSwAu7rNIeMEjhE/4A5/MxFFvGKVsVtwIVFA6S8cZPnLPjfRFNqjM
         oQAFw66SLD+b5LeqpCCvPh1z1W0qGlG6QUk8pq479d9BraIwc6kn4zcYnrHtDDWw4cVi
         r+xg==
X-Gm-Message-State: AOJu0YwBABpt+8OpsAGgP3v770K08e1miGX0MI93NiRV2Z5jAMz/69rE
        ZaBsl9JB2HiVTrQqBT2focgwQVLQchT3zEBm6lo954C9H64gSmjOg8SwWEm+PPBgsueXiNzsmB4
        ah3H177NylEDS096HfReKOsKB
X-Received: by 2002:a2e:b88a:0:b0:2cc:1c21:f729 with SMTP id r10-20020a2eb88a000000b002cc1c21f729mr3199479ljp.60.1702549785337;
        Thu, 14 Dec 2023 02:29:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjkT5w/kdScbgQ5jnlJ/iNq1v76LhwoQiz85pVMwCHKmLvFjAg9HfOnqm6pisPjZpcYg0XYw==
X-Received: by 2002:a2e:b88a:0:b0:2cc:1c21:f729 with SMTP id r10-20020a2eb88a000000b002cc1c21f729mr3199467ljp.60.1702549784912;
        Thu, 14 Dec 2023 02:29:44 -0800 (PST)
Received: from redhat.com ([2.52.132.243])
        by smtp.gmail.com with ESMTPSA id v21-20020a2e9615000000b002c9f1316121sm2098658ljh.36.2023.12.14.02.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:29:43 -0800 (PST)
Date:   Thu, 14 Dec 2023 05:29:38 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH net-next v9 3/4] vsock: update SO_RCVLOWAT setting
 callback
Message-ID: <20231214052502-mutt-send-email-mst@kernel.org>
References: <20231214091947.395892-1-avkrasnov@salutedevices.com>
 <20231214091947.395892-4-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214091947.395892-4-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 12:19:46PM +0300, Arseniy Krasnov wrote:
> Do not return if transport callback for SO_RCVLOWAT is set (only in
> error case). In this case we don't need to set 'sk_rcvlowat' field in
> each transport - only in 'vsock_set_rcvlowat()'. Also, if 'sk_rcvlowat'
> is now set only in af_vsock.c, change callback name from 'set_rcvlowat'
> to 'notify_set_rcvlowat'.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Maybe squash this with patch 2/4?

> ---
>  Changelog:
>  v3 -> v4:
>   * Rename 'set_rcvlowat' to 'notify_set_rcvlowat'.
>   * Commit message updated.
> 
>  include/net/af_vsock.h           | 2 +-
>  net/vmw_vsock/af_vsock.c         | 9 +++++++--
>  net/vmw_vsock/hyperv_transport.c | 4 ++--
>  3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index e302c0e804d0..535701efc1e5 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -137,7 +137,6 @@ struct vsock_transport {
>  	u64 (*stream_rcvhiwat)(struct vsock_sock *);
>  	bool (*stream_is_active)(struct vsock_sock *);
>  	bool (*stream_allow)(u32 cid, u32 port);
> -	int (*set_rcvlowat)(struct vsock_sock *vsk, int val);
>  
>  	/* SEQ_PACKET. */
>  	ssize_t (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
> @@ -168,6 +167,7 @@ struct vsock_transport {
>  		struct vsock_transport_send_notify_data *);
>  	/* sk_lock held by the caller */
>  	void (*notify_buffer_size)(struct vsock_sock *, u64 *);
> +	int (*notify_set_rcvlowat)(struct vsock_sock *vsk, int val);
>  
>  	/* Shutdown. */
>  	int (*shutdown)(struct vsock_sock *, int);
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 816725af281f..54ba7316f808 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2264,8 +2264,13 @@ static int vsock_set_rcvlowat(struct sock *sk, int val)
>  
>  	transport = vsk->transport;
>  
> -	if (transport && transport->set_rcvlowat)
> -		return transport->set_rcvlowat(vsk, val);
> +	if (transport && transport->notify_set_rcvlowat) {
> +		int err;
> +
> +		err = transport->notify_set_rcvlowat(vsk, val);
> +		if (err)
> +			return err;
> +	}
>  
>  	WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
>  	return 0;



I would s

> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index 7cb1a9d2cdb4..e2157e387217 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -816,7 +816,7 @@ int hvs_notify_send_post_enqueue(struct vsock_sock *vsk, ssize_t written,
>  }
>  
>  static
> -int hvs_set_rcvlowat(struct vsock_sock *vsk, int val)
> +int hvs_notify_set_rcvlowat(struct vsock_sock *vsk, int val)
>  {
>  	return -EOPNOTSUPP;
>  }
> @@ -856,7 +856,7 @@ static struct vsock_transport hvs_transport = {
>  	.notify_send_pre_enqueue  = hvs_notify_send_pre_enqueue,
>  	.notify_send_post_enqueue = hvs_notify_send_post_enqueue,
>  
> -	.set_rcvlowat             = hvs_set_rcvlowat
> +	.notify_set_rcvlowat      = hvs_notify_set_rcvlowat
>  };
>  
>  static bool hvs_check_transport(struct vsock_sock *vsk)
> -- 
> 2.25.1

