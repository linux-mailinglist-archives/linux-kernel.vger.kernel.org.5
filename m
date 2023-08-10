Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9B4777351
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbjHJIun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjHJIum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAB32107
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691657392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tr5wgmKh2lO7n8excjkJqlp64FQQtsDJMCPcsqi5jJ4=;
        b=a1511v8SNLPuL58gWvumAvDQwwKjEPfC0mRgaj2ZEbSXSr72N4+rF781G4nYNcRdy+iYxK
        FDzIPUuTS5jVp1NT+MWJnMV+VdVBAzy06F7hwSTpxEoaSLW0K9ID0YMCGalJWGi049VMIe
        LOWoslnha94Gebw6XCRsEUm5kGkKl+A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-5YXzhRm_NpWYS10XtfIc5w-1; Thu, 10 Aug 2023 04:49:50 -0400
X-MC-Unique: 5YXzhRm_NpWYS10XtfIc5w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe13881511so4023705e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691657389; x=1692262189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr5wgmKh2lO7n8excjkJqlp64FQQtsDJMCPcsqi5jJ4=;
        b=PKrV6OnangkSxdc8FtPoEIN8ahwEMd8Q+d0948ihiaKHuvDO5PIcDlnSBdS4MTpJWC
         snvMuxjMJUOOLnCkVfEnZNv8C6ZBFQiTY2ShqYGfzsm1y2VbKb4SWHzAJNfFCZ/ZXMmm
         r63lWv3lTZ3cCbYCJSMqDanv2dG+EOrtYQqORAdunhwJ4bWEXeDFQU5bNYm2L3MlgnMQ
         +rGucYccUsyoENtEJkK8yRRfqrq9+pmoiINZpO/nLFR2EKs14+FW8qs67xLJ0zdDvGsE
         IMP9aA80gCa7LO0Qz4Sm8i7f0FhAgzu6h3+35bxDxwIB9usLnFY3hidhHdMGemuovikE
         CYsA==
X-Gm-Message-State: AOJu0YxZEPcZ6dGMj0rMaOkxI5kdSoAq6M4qbE40p/SGtK4bfVlK+bLw
        zefjNrWOggV7ZklS8RT7VEdNRQrlBhcFZVN6wpAPm1GJW+U/oCJezc6UB/lPk7OGt6l2bU3K/92
        V0GQLI3M6fEydZ2Pzc1AMZ/5T
X-Received: by 2002:a05:600c:2a53:b0:3fa:96db:7b7c with SMTP id x19-20020a05600c2a5300b003fa96db7b7cmr1355750wme.35.1691657389738;
        Thu, 10 Aug 2023 01:49:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9G1uTIpyiFvUarklkAwC6rr28NspOp66gkgdxQBV3p3OYye0b+YHH4y0QncONpY4KIjuasg==
X-Received: by 2002:a05:600c:2a53:b0:3fa:96db:7b7c with SMTP id x19-20020a05600c2a5300b003fa96db7b7cmr1355731wme.35.1691657389380;
        Thu, 10 Aug 2023 01:49:49 -0700 (PDT)
Received: from redhat.com ([2.52.137.93])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bcbd8000000b003fbb0c01d4bsm1439523wmi.16.2023.08.10.01.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:49:48 -0700 (PDT)
Date:   Thu, 10 Aug 2023 04:49:44 -0400
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
Message-ID: <20230810044935-mutt-send-email-mst@kernel.org>
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

Fixes tag pls?

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

