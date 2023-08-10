Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AF877735B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjHJIw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjHJIw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE092103
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691657527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mcg6yJyopZb17WipDF8sP3EF15P+/x7wmZ52XLBWKYI=;
        b=H9ygZALS1JvHu22M9FYVPSVtoZ6OuliAbelI/d2daMq1NJNxX4WebInCEXoxhznMDuJF8Z
        f1hmr/vjLpa/Sxk4gCTWv2cHdqTHPUktJoxkTya1jzS49sO3MaLLXLmQaUCS8SDJsl/aJW
        +cviwOTQy6QseGK8hlDAf0LmjMu7KWM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-Wv0b_jqmNJGV3lWS8XpD-A-1; Thu, 10 Aug 2023 04:52:05 -0400
X-MC-Unique: Wv0b_jqmNJGV3lWS8XpD-A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31758708b57so485593f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691657524; x=1692262324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mcg6yJyopZb17WipDF8sP3EF15P+/x7wmZ52XLBWKYI=;
        b=gZQDWrie2ko+ZQrgDwEYeSRi37jBdPEycFWoAU/YA0X6MjL6Yct7E2LNAv/M5JX2zi
         pSv4QmXvHBURwEA9RujYCPaz57GcpSNvzF43fVb84pfCN6sIRx1k4Ysb3nBFu2Knbn87
         3PrStFTZLZ+a9x7nxAj9da14NnYOXhg6W/ozlI8iUbQSL4CtvoTCd9l/JyvK9R6LLoPA
         AmGckYkeAVfTbcIsntsq8yAYfpdHTstJP6+STZFADZCUeQTb/ajPAorEFiZowzssrmlF
         z9IQziz3JNiTfGePpxkZi1XlY5blvGeKqb1hRMW0SuME8TWn8+Jf/D37OuPDCAkz8yZK
         ZW+A==
X-Gm-Message-State: AOJu0Yy3fQLjyIGUUhJm5sNEAGoQSSLLa3kUwX54SOx5L3O7cl4YSsO2
        zFcAATxzRHgqNVQtosCEatN0ihcMdfNyBi3QkE35x44ULj0am5Ni2MqVsAtvdPVbg9Fn1N0n+DY
        zRwxvy39b+HdA0Z3wHHVsFxiO
X-Received: by 2002:a5d:44ca:0:b0:316:ef23:9276 with SMTP id z10-20020a5d44ca000000b00316ef239276mr1488187wrr.52.1691657524679;
        Thu, 10 Aug 2023 01:52:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiGdAa8VcflNuUlj48JmkKBjjk2b+xwDOn+rC9BIlHGKctdobOOWlznGHUPPPPdtwLJAtjxA==
X-Received: by 2002:a5d:44ca:0:b0:316:ef23:9276 with SMTP id z10-20020a5d44ca000000b00316ef239276mr1488175wrr.52.1691657524329;
        Thu, 10 Aug 2023 01:52:04 -0700 (PDT)
Received: from redhat.com ([2.52.137.93])
        by smtp.gmail.com with ESMTPSA id k7-20020adfe3c7000000b003176c6e87b1sm1427032wrm.81.2023.08.10.01.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:52:03 -0700 (PDT)
Date:   Thu, 10 Aug 2023 04:51:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, eperezma@redhat.com,
        18801353760@163.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-net: Zero max_tx_vq field for
 VIRTIO_NET_CTRL_MQ_HASH_CONFIG case
Message-ID: <20230810045106-mutt-send-email-mst@kernel.org>
References: <20230810031557.135557-1-yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810031557.135557-1-yin31149@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:15:57AM +0800, Hawkins Jiawei wrote:
> Kernel uses `struct virtio_net_ctrl_rss` to save command-specific-data
> for both the VIRTIO_NET_CTRL_MQ_HASH_CONFIG and
> VIRTIO_NET_CTRL_MQ_RSS_CONFIG commands.
> 
> According to the VirtIO standard, "Field reserved MUST contain zeroes.
> It is defined to make the structure to match the layout of
> virtio_net_rss_config structure, defined in 5.1.6.5.7.".
> 
> Yet for the VIRTIO_NET_CTRL_MQ_HASH_CONFIG command case, the `max_tx_vq`
> field in struct virtio_net_ctrl_rss, which corresponds to the
> `reserved` field in struct virtio_net_hash_config, is not zeroed,
> thereby violating the VirtIO standard.
> 
> This patch solves this problem by zeroing this field in
> virtnet_init_default_rss().
> 
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>



Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Cc: Andrew Melnychenko <andrew@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>

And this is stable material I believe.



> ---
> 
> TestStep
> ========
> 1. Boot QEMU with one virtio-net-pci net device with `mq` and `hash`
> feature on, command line like:
>       -netdev tap,vhost=off,...
>       -device virtio-net-pci,mq=on,hash=on,...
> 
> 2. Trigger VIRTIO_NET_CTRL_MQ_HASH_CONFIG command in guest, command
> line like:
> 	ethtool -K eth0 rxhash on
> 
> Without this patch, in virtnet_commit_rss_command(), we can see the
> `max_tx_vq` field is 1 in gdb like below:
> 
> 	pwndbg> p vi->ctrl->rss
> 	$1 = {
> 	  hash_types = 63,
> 	  indirection_table_mask = 0,
> 	  unclassified_queue = 0,
> 	  indirection_table = {0 <repeats 128 times>},
> 	  max_tx_vq = 1,
> 	  hash_key_length = 40 '(',
> 	  ...
> 	}
> 
> With this patch, in virtnet_commit_rss_command(), we can see the
> `max_tx_vq` field is 0 in gdb like below:
> 
> 	pwndbg> p vi->ctrl->rss
> 	$1 = {
> 	  hash_types = 63,
> 	  indirection_table_mask = 0,
> 	  unclassified_queue = 0,
> 	  indirection_table = {0 <repeats 128 times>},
> 	  max_tx_vq = 0,
> 	  hash_key_length = 40 '(',
> 	  ...
> 	}
> 
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1270c8d23463..8db38634ae82 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2761,7 +2761,7 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
>  		vi->ctrl->rss.indirection_table[i] = indir_val;
>  	}
>  
> -	vi->ctrl->rss.max_tx_vq = vi->curr_queue_pairs;
> +	vi->ctrl->rss.max_tx_vq = vi->has_rss ? vi->curr_queue_pairs : 0;
>  	vi->ctrl->rss.hash_key_length = vi->rss_key_size;
>  
>  	netdev_rss_key_fill(vi->ctrl->rss.key, vi->rss_key_size);
> -- 
> 2.34.1

