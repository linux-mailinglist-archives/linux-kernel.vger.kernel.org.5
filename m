Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49ED800DB3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379245AbjLAOvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379195AbjLAOvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:51:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369ED10F4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701442283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F6+fTNyVfQbvpv0mXBsvFlerCoSqluEuKgG50iz8c2Q=;
        b=gtOBrj030a1bxEoGeAchjZY27qCQK/ybYlFg4niH4lNwrYB17XEuu4UgxXA4LEAxC2cIqj
        XX2fGP2pi9Eduhj8F+817l4hxNspdOHrlOpWPhrI8cAW3J427BJ3DX0rRcDHsJQZYBiK5q
        vn1DN9EloXkJEtivEiEiY5Q4moU1nUI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-G7vM5W9LMUqUb3y1aux6-A-1; Fri, 01 Dec 2023 09:51:22 -0500
X-MC-Unique: G7vM5W9LMUqUb3y1aux6-A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b3d81399dso15124175e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 06:51:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701442281; x=1702047081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6+fTNyVfQbvpv0mXBsvFlerCoSqluEuKgG50iz8c2Q=;
        b=qHcLiRx0Wejcgsv1K/sdEl7E811ds/npOBAurI/rlnR5gYIiGMfnu0Lj9SPPowY954
         05L4YDPYTlLCuRmFGME3iqNNyy64vIvHZoOaivZu19X6JbSfXWCW/WjEf6rWNzcpz1+W
         R56xcJ6kvx9m/RPLhyE2cJs0DSfpsn0SCeGhF/VsO7uSWWr8/lAmfYmYCMcFlN7Z9sr6
         9a+WMlXNsX6Rw6e6dy1IIIXQ1ATsBHYDvfRR41eR8yodk588YpYCIQFNuESoVq0XQ0u2
         ocioagj8kh9kufThJvvuOPwdSMtxi1FLvIJIDOPCdPyf2ZLrJV0bUYK1RnEp0EAOf6D0
         c9IA==
X-Gm-Message-State: AOJu0Yyi7TWUacEwZ5v4x1VHhYbxdJbervGR7P4E+lNYYdfv5bqJt+ch
        ZMe79a6St+oQYlXh3ZbyHjZZ9QvET0So1VJHPIrgUYlgx+0HVaDG0GfWUECTv+saG2TEzthGBHD
        vi8lhMpf09rFsRm/AJN81N8MP
X-Received: by 2002:a05:600c:20cb:b0:40b:5e59:f747 with SMTP id y11-20020a05600c20cb00b0040b5e59f747mr254913wmm.185.1701442281102;
        Fri, 01 Dec 2023 06:51:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHncDO0+zubuDh1bCnaDyIbO8GXaUPF25vZ6m/789yYxQkh40rx+2WA/B7iuPeVv2rjMudyJw==
X-Received: by 2002:a05:600c:20cb:b0:40b:5e59:f747 with SMTP id y11-20020a05600c20cb00b0040b5e59f747mr254905wmm.185.1701442280788;
        Fri, 01 Dec 2023 06:51:20 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e1:6f00:c7ce:b553:4096:d504])
        by smtp.gmail.com with ESMTPSA id fs20-20020a05600c3f9400b0040b5517ae31sm8521738wmb.6.2023.12.01.06.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:51:19 -0800 (PST)
Date:   Fri, 1 Dec 2023 09:51:17 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wangyangxin <wangyangxin1@huawei.com>
Subject: Re: [PATCH] crypto: virtio-crypto: Handle dataq logic  with tasklet
Message-ID: <20231201095024-mutt-send-email-mst@kernel.org>
References: <b2fe5c6a60984a9e91bd9dea419c5154@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2fe5c6a60984a9e91bd9dea419c5154@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 11:49:45AM +0000, Gonglei (Arei) wrote:
> Doing ipsec produces a spinlock recursion warning.
> This is due to crypto_finalize_request() being called in the upper half.
> Move virtual data queue processing of virtio-crypto driver to tasklet.
> 
> Fixes: dbaf0624ffa57 ("crypto: add virtio-crypto driver")
> Reported-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: wangyangxin <wangyangxin1@huawei.com>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
>  drivers/crypto/virtio/virtio_crypto_common.h |  2 ++
>  drivers/crypto/virtio/virtio_crypto_core.c   | 23 +++++++++++++----------
>  2 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
> index 59a4c02..5c17c6e 100644
> --- a/drivers/crypto/virtio/virtio_crypto_common.h
> +++ b/drivers/crypto/virtio/virtio_crypto_common.h
> @@ -10,6 +10,7 @@
>  #include <linux/virtio.h>
>  #include <linux/crypto.h>
>  #include <linux/spinlock.h>
> +#include <linux/interrupt.h>
>  #include <crypto/aead.h>
>  #include <crypto/aes.h>
>  #include <crypto/engine.h>
> @@ -28,6 +29,7 @@ struct data_queue {
>  	char name[32];
>  
>  	struct crypto_engine *engine;
> +	struct tasklet_struct done_task;
>  };
>  
>  struct virtio_crypto {
> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
> index 1198bd3..e747f4f 100644
> --- a/drivers/crypto/virtio/virtio_crypto_core.c
> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> @@ -72,27 +72,28 @@ int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterl
>  	return 0;
>  }
>  
> -static void virtcrypto_dataq_callback(struct virtqueue *vq)
> +static void virtcrypto_done_task(unsigned long data)
>  {
> -	struct virtio_crypto *vcrypto = vq->vdev->priv;
> +	struct data_queue *data_vq = (struct data_queue *)data;
> +	struct virtqueue *vq = data_vq->vq;
>  	struct virtio_crypto_request *vc_req;
> -	unsigned long flags;
>  	unsigned int len;
> -	unsigned int qid = vq->index;
>  
> -	spin_lock_irqsave(&vcrypto->data_vq[qid].lock, flags);
>  	do {
>  		virtqueue_disable_cb(vq);
>  		while ((vc_req = virtqueue_get_buf(vq, &len)) != NULL) {
> -			spin_unlock_irqrestore(
> -				&vcrypto->data_vq[qid].lock, flags);
>  			if (vc_req->alg_cb)
>  				vc_req->alg_cb(vc_req, len);
> -			spin_lock_irqsave(
> -				&vcrypto->data_vq[qid].lock, flags);
>  		}
>  	} while (!virtqueue_enable_cb(vq));
> -	spin_unlock_irqrestore(&vcrypto->data_vq[qid].lock, flags);
> +}
> +
> +static void virtcrypto_dataq_callback(struct virtqueue *vq)
> +{
> +	struct virtio_crypto *vcrypto = vq->vdev->priv;
> +	struct data_queue *dq = &vcrypto->data_vq[vq->index];
> +
> +	tasklet_schedule(&dq->done_task);
>  }
>

Don't we then need to wait for tasklet to complete on
device remove?

  
>  static int virtcrypto_find_vqs(struct virtio_crypto *vi)
> @@ -150,6 +151,8 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
>  			ret = -ENOMEM;
>  			goto err_engine;
>  		}
> +		tasklet_init(&vi->data_vq[i].done_task, virtcrypto_done_task,
> +				(unsigned long)&vi->data_vq[i]);
>  	}
>  
>  	kfree(names);
> -- 
> 1.8.3.1
> 
> 

