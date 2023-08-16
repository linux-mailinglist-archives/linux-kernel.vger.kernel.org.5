Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5B677EAE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346207AbjHPUlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346210AbjHPUkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:40:52 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336FE2727
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:40:41 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-UVej7SCuNTaMZOsoaiiO-A-1; Wed, 16 Aug 2023 16:40:24 -0400
X-MC-Unique: UVej7SCuNTaMZOsoaiiO-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF6A2185A78B;
        Wed, 16 Aug 2023 20:40:23 +0000 (UTC)
Received: from hog (unknown [10.39.192.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C9E9140E962;
        Wed, 16 Aug 2023 20:40:21 +0000 (UTC)
Date:   Wed, 16 Aug 2023 22:40:20 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v1 4/5] net: macsec: introduce mdo_insert_tx_tag
Message-ID: <ZN00NB7RayXAl80f@hog>
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
 <20230811153249.283984-5-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811153249.283984-5-radu-nicolae.pirea@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-08-11, 18:32:48 +0300, Radu Pirea (NXP OSS) wrote:
> Offloading MACsec in PHYs requires inserting the SecTAG and the ICV in
> the ethernet frame. This operation will increase the frame size with 32
> bytes.

"up to 32 bytes"?

The SecTAG and ICV can both be shorter, at least with the software
implementation.


[...]
> +static struct sk_buff *insert_tx_tag(struct sk_buff *skb,
> +				     struct net_device *dev)
> +{
[...]
> +
> +	ctx.secy = &macsec->secy;
> +	ctx.skb = skb;

I think it would be a bit more readable to just pass the skb to
 ->mdo_insert_tx_tag instead of adding it to the context.

> +
> +	err = ops->mdo_insert_tx_tag(&ctx);
> +	if (err)
> +		goto cleanup;

[...]
> @@ -3403,6 +3470,13 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
>  		skb_dst_drop(skb);
>  		dst_hold(&md_dst->dst);
>  		skb_dst_set(skb, &md_dst->dst);
> +
> +		skb = insert_tx_tag(skb, dev);
> +		if (IS_ERR(skb)) {
> +			dev->stats.tx_dropped++;

That should probably use DEV_STATS_INC (see commit
32d0a49d36a2 ("macsec: use DEV_STATS_INC()")).

> +			return NETDEV_TX_OK;
> +		}
> +
>  		skb->dev = macsec->real_dev;
>  		return dev_queue_xmit(skb);
>  	}
> @@ -4137,6 +4211,11 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
>  			if (err)
>  				goto del_dev;
>  		}
> +
> +		dev->needed_headroom -= MACSEC_NEEDED_HEADROOM;
> +		dev->needed_headroom += ops->needed_headroom;
> +		dev->needed_tailroom -= MACSEC_NEEDED_TAILROOM;
> +		dev->needed_tailroom += ops->needed_tailroom;

If the driver doesn't set ops->needed_headroom, we'll subtract
MACSEC_NEEDED_HEADROOM and not add anything back. Is that correct for
all existing drivers? (and same for tailroom)

You set needed_tailroom to 0 in your driver, but the commit message
for this patch says that the HW needs space for the ICV. I'm a bit
puzzled by this, especially since MACSEC_NEEDED_TAILROOM already
reserves space for the ICV.

Also, since this is pattern repeated twice more (with a sign change)
in macsec_update_offload, we could probably stuff this into a helper
(either modifying dev->needed_headroom directly, or returning the
value to add/subtract).

>  	}
>  

[...]
> @@ -302,6 +303,10 @@ struct macsec_ops {
>  	int (*mdo_get_tx_sa_stats)(struct macsec_context *ctx);
>  	int (*mdo_get_rx_sc_stats)(struct macsec_context *ctx);
>  	int (*mdo_get_rx_sa_stats)(struct macsec_context *ctx);
> +	/* Offload tag */
> +	int (*mdo_insert_tx_tag)(struct macsec_context *ctx);
> +	int needed_headroom;
> +	int needed_tailroom;

unsigned?

>  };

-- 
Sabrina

