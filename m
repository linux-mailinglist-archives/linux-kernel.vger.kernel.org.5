Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F4C777681
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjHJLIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjHJLIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:08:06 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56282127;
        Thu, 10 Aug 2023 04:08:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VpTYPv4_1691665679;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VpTYPv4_1691665679)
          by smtp.aliyun-inc.com;
          Thu, 10 Aug 2023 19:08:00 +0800
Message-ID: <1691665672.3006196-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2] virtio-net: Zero max_tx_vq field for VIRTIO_NET_CTRL_MQ_HASH_CONFIG case
Date:   Thu, 10 Aug 2023 19:07:52 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     eperezma@redhat.com, 18801353760@163.com,
        Andrew Melnychenko <andrew@daynix.com>, stable@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, yin31149@gmail.com
References: <20230810110405.25558-1-yin31149@gmail.com>
In-Reply-To: <20230810110405.25558-1-yin31149@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 19:04:05 +0800, Hawkins Jiawei <yin31149@gmail.com> wro=
te:
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
> Cc: Andrew Melnychenko <andrew@daynix.com>
> Cc: stable@vger.kernel.org
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1270c8d23463..8db38634ae82 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2761,7 +2761,7 @@ static void virtnet_init_default_rss(struct virtnet=
_info *vi)
>  		vi->ctrl->rss.indirection_table[i] =3D indir_val;
>  	}
>
> -	vi->ctrl->rss.max_tx_vq =3D vi->curr_queue_pairs;
> +	vi->ctrl->rss.max_tx_vq =3D vi->has_rss ? vi->curr_queue_pairs : 0;
>  	vi->ctrl->rss.hash_key_length =3D vi->rss_key_size;
>
>  	netdev_rss_key_fill(vi->ctrl->rss.key, vi->rss_key_size);
> --
> 2.34.1
>
