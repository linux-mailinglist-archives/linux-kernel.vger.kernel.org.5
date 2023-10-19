Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E2A7CF472
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345104AbjJSJvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJSJvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:51:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D241106
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697709061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=opD4K+lhLgpQnt4PMFVWJ2GlfEpmbjN6nDHAsiU0UgE=;
        b=N0Zqfao19RJIuocZmtBMXa+ojiC4mO+YvA3I2XtANh/2/ZDJxiJXXBdY/wjnGCh6uWigBK
        Un/Wz5rPDlbjQMxX5COSMzbGnSSS+TNWsOAoxO26IaxdVGTIOzIgbdUUS7Hbu3Ji8CcDJ7
        zQlX/7ixcrxP44LHsfFdVOZ2lQWrGBo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-MCzpY9yyOIGuJaIMDijpNw-1; Thu, 19 Oct 2023 05:50:59 -0400
X-MC-Unique: MCzpY9yyOIGuJaIMDijpNw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-534838150afso887490a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697709058; x=1698313858;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=opD4K+lhLgpQnt4PMFVWJ2GlfEpmbjN6nDHAsiU0UgE=;
        b=qphZTU0EsVN86k+d0i0RQ9pRazvywJYfXkFLlzVD9xlWZ5p14A/btM+mAq1H8WzSDX
         lG0lYeG1Xy3tELnPDeaLd/2bkJlrEew9vBnnt44ggd2ctde6oO/rv8qiHhv0Wg524ZZu
         x0Vhe+S6v/eMzTIqHhW+Vjb83GWcs2ApDzelxupnF91A/+C42TQOfHaJt0fDaAIeyzWG
         60KsFN3pRjKs5rKXamR1TjleYI4dFci1Zml6gVkHGJfc7i96hUgOynUr5uKQoSNnB2qH
         MMuorjssOqMdnpixx/go1ecP/B5cV9aikcIjnZHbtNSxVZm69/HjrCyYWWlOJJc1UuKC
         tbzQ==
X-Gm-Message-State: AOJu0YwOjVaWk3uQL1Oxh8BqhKFoTnrfzBwjo2apgZy4orw6c8z5PDst
        8kQQ4tT/x3sGuvqmY/5OZ6hObTeJyWqsp5uoh4bdxc/dF7pbo4Cenxs46Dy+pjKUq8DNjnjJ3ht
        P5RBV9iF52INpEOr6dJSqCX0x
X-Received: by 2002:aa7:df99:0:b0:53f:9311:6002 with SMTP id b25-20020aa7df99000000b0053f93116002mr898112edy.2.1697709058200;
        Thu, 19 Oct 2023 02:50:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERzrf2nVVATjtrHBX9UQAFHkPln439uEI+PP2ld4u3vfRp9uKaiPbReASQjl8OZKwsITQdrQ==
X-Received: by 2002:aa7:df99:0:b0:53f:9311:6002 with SMTP id b25-20020aa7df99000000b0053f93116002mr898089edy.2.1697709057816;
        Thu, 19 Oct 2023 02:50:57 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-142.dyn.eolo.it. [146.241.237.142])
        by smtp.gmail.com with ESMTPSA id ck25-20020a0564021c1900b0053dab756073sm4117338edb.84.2023.10.19.02.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 02:50:57 -0700 (PDT)
Message-ID: <582ccc0600aea90e32e4c6416d40d0a8047f9eae.camel@redhat.com>
Subject: Re: [PATCH net-next v8 3/3] net: axienet: Introduce dmaengine
 support
From:   Paolo Abeni <pabeni@redhat.com>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, michal.simek@amd.com, linux@armlinux.org.uk,
        f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@amd.com
Date:   Thu, 19 Oct 2023 11:50:55 +0200
In-Reply-To: <1697570274-798170-4-git-send-email-radhey.shyam.pandey@amd.com>
References: <1697570274-798170-1-git-send-email-radhey.shyam.pandey@amd.com>
         <1697570274-798170-4-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-18 at 00:47 +0530, Radhey Shyam Pandey wrote:
[...]
> @@ -727,6 +746,122 @@ static inline int axienet_check_tx_bd_space(struct =
axienet_local *lp,
>  	return 0;
>  }
> =20
> +/**
> + * axienet_dma_tx_cb - DMA engine callback for TX channel.
> + * @data:       Pointer to the axienet_local structure.
> + * @result:     error reporting through dmaengine_result.
> + * This function is called by dmaengine driver for TX channel to notify
> + * that the transmit is done.
> + */
> +static void axienet_dma_tx_cb(void *data, const struct dmaengine_result =
*result)
> +{
> +	struct axienet_local *lp =3D data;
> +	struct skbuf_dma_descriptor *skbuf_dma;

Minor nit: please use the reverse x-mas tree order

> +
> +	skbuf_dma =3D axienet_get_tx_desc(lp, lp->tx_ring_tail++);
> +	u64_stats_update_begin(&lp->tx_stat_sync);
> +	u64_stats_add(&lp->tx_bytes, skbuf_dma->skb->len);
> +	u64_stats_add(&lp->tx_packets, 1);
> +	u64_stats_update_end(&lp->tx_stat_sync);
> +	dma_unmap_sg(lp->dev, skbuf_dma->sgl, skbuf_dma->sg_len, DMA_TO_DEVICE)=
;
> +	dev_consume_skb_any(skbuf_dma->skb);
> +	if (CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX) > MAX=
_SKB_FRAGS + 1)
> +		netif_wake_queue(lp->ndev);
> +}
> +
> +/**
> + * axienet_start_xmit_dmaengine - Starts the transmission.
> + * @skb:        sk_buff pointer that contains data to be Txed.
> + * @ndev:       Pointer to net_device structure.
> + *
> + * Return: NETDEV_TX_OK on success or any non space errors.
> + *         NETDEV_TX_BUSY when free element in TX skb ring buffer
> + *         is not available.
> + *
> + * This function is invoked to initiate transmission. The
> + * function sets the skbs, register dma callback API and submit
> + * the dma transaction.
> + * Additionally if checksum offloading is supported,
> + * it populates AXI Stream Control fields with appropriate values.
> + */
> +static netdev_tx_t
> +axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *nde=
v)
> +{
> +	struct dma_async_tx_descriptor *dma_tx_desc =3D NULL;
> +	struct axienet_local *lp =3D netdev_priv(ndev);
> +	u32 app_metadata[DMA_NUM_APP_WORDS] =3D {0};
> +	struct skbuf_dma_descriptor *skbuf_dma;
> +	struct dma_device *dma_dev;
> +	u32 csum_start_off;
> +	u32 csum_index_off;
> +	int sg_len;
> +	int ret;
> +
> +	dma_dev =3D lp->tx_chan->device;
> +	sg_len =3D skb_shinfo(skb)->nr_frags + 1;
> +	if (CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX) <=3D =
sg_len) {
> +		netif_stop_queue(ndev);
> +		if (net_ratelimit())
> +			netdev_warn(ndev, "TX ring unexpectedly full\n");
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	skbuf_dma =3D axienet_get_tx_desc(lp, lp->tx_ring_head);
> +	if (!skbuf_dma) {
> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;

You can avoid some duplicate code with:
		goto drop_skb;

and adding at the bottom of this function:

drop_skb:
	dev_kfree_skb_any(skb);
	return NETDEV_TX_OK;

> +	}
> +
> +	lp->tx_ring_head++;
> +	sg_init_table(skbuf_dma->sgl, sg_len);
> +	ret =3D skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
> +	if (ret < 0) {
> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;

Same here and below.

> +	}
> +
> +	ret =3D dma_map_sg(lp->dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
> +	if (!ret) {
> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;
> +	}
> +
> +	/* Fill up app fields for checksum */
> +	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> +		if (lp->features & XAE_FEATURE_FULL_TX_CSUM) {
> +			/* Tx Full Checksum Offload Enabled */
> +			app_metadata[0] |=3D 2;
> +		} else if (lp->features & XAE_FEATURE_PARTIAL_TX_CSUM) {
> +			csum_start_off =3D skb_transport_offset(skb);
> +			csum_index_off =3D csum_start_off + skb->csum_offset;
> +			/* Tx Partial Checksum Offload Enabled */
> +			app_metadata[0] |=3D 1;
> +			app_metadata[1] =3D (csum_start_off << 16) | csum_index_off;
> +		}
> +	} else if (skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY) {
> +		app_metadata[0] |=3D 2; /* Tx Full Checksum Offload Enabled */
> +	}
> +
> +	dma_tx_desc =3D dma_dev->device_prep_slave_sg(lp->tx_chan, skbuf_dma->s=
gl,
> +			sg_len, DMA_MEM_TO_DEV,
> +			DMA_PREP_INTERRUPT, (void *)app_metadata);
> +	if (!dma_tx_desc)
> +		goto xmit_error_unmap_sg;

Are you leaking an skb here?

You forgot to add the netif_txq_maybe_stop() call, as suggested by
Jakub in the previous revision.

> +
> +	skbuf_dma->skb =3D skb;
> +	skbuf_dma->sg_len =3D sg_len;
> +	dma_tx_desc->callback_param =3D lp;
> +	dma_tx_desc->callback_result =3D axienet_dma_tx_cb;
> +	dmaengine_submit(dma_tx_desc);
> +	dma_async_issue_pending(lp->tx_chan);
> +
> +	return NETDEV_TX_OK;
> +
> +xmit_error_unmap_sg:
> +	dma_unmap_sg(lp->dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);

If you need to drop the skb (as I suspect), you can reuse the drop_skb
label here:

drop_skb:
	dev_kfree_skb_any(skb);
> +	return NETDEV_TX_OK;
> +}
> +
>  /**
>   * axienet_tx_poll - Invoked once a transmit is completed by the
>   * Axi DMA Tx channel.
> @@ -893,6 +1028,42 @@ axienet_start_xmit(struct sk_buff *skb, struct net_=
device *ndev)
>  	return NETDEV_TX_OK;
>  }
> =20
> +/**
> + * axienet_dma_rx_cb - DMA engine callback for RX channel.
> + * @data:       Pointer to the skbuf_dma_descriptor structure.
> + * @result:     error reporting through dmaengine_result.
> + * This function is called by dmaengine driver for RX channel to notify
> + * that the packet is received.
> + */
> +static void axienet_dma_rx_cb(void *data, const struct dmaengine_result =
*result)
> +{
> +	struct axienet_local *lp =3D data;
> +	struct skbuf_dma_descriptor *skbuf_dma;
> +	size_t meta_len, meta_max_len, rx_len;
> +	struct sk_buff *skb;
> +	u32 *app_metadata;

Minor nit: please respect the reverse x-mas tree order

> +
> +	skbuf_dma =3D axienet_get_rx_desc(lp, lp->rx_ring_tail++);
> +	skb =3D skbuf_dma->skb;
> +	app_metadata =3D dmaengine_desc_get_metadata_ptr(skbuf_dma->desc, &meta=
_len,
> +						       &meta_max_len);
> +	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
> +			 DMA_FROM_DEVICE);
> +	/* TODO: Derive app word index programmatically */
> +	rx_len =3D (app_metadata[LEN_APP] & 0xFFFF);
> +	skb_put(skb, rx_len);
> +	skb->protocol =3D eth_type_trans(skb, lp->ndev);
> +	skb->ip_summed =3D CHECKSUM_NONE;
> +
> +	__netif_rx(skb);

It's a pity you can't leverage NAPI here.

I think that could be doable as a follow-up, but I'm unsure if that
would fit the DMA engine model: in this callback you could cache the
ready dma index (a single range should suffice) and schedule the napi
instance. The actual dma processing will be done in napi poll.

Another possible follow-up could be introducing a "bulk" RX callback in
the DMA engine, to mitigate the indirect call overhead on a burst of RX
DMA completion - assuming the DMA engine actually generates such burst.

> +	u64_stats_update_begin(&lp->rx_stat_sync);
> +	u64_stats_add(&lp->rx_packets, 1);
> +	u64_stats_add(&lp->rx_bytes, rx_len);
> +	u64_stats_update_end(&lp->rx_stat_sync);
> +	axienet_rx_submit_desc(lp->ndev);
> +	dma_async_issue_pending(lp->rx_chan);
> +}
> +
>  /**
>   * axienet_rx_poll - Triggered by RX ISR to complete the BD processing.
>   * @napi:	Pointer to NAPI structure.
> @@ -1126,6 +1297,150 @@ static irqreturn_t axienet_eth_irq(int irq, void =
*_ndev)
> =20
>  static void axienet_dma_err_handler(struct work_struct *work);
> =20
> +/**
> + * axienet_rx_submit_desc - Submit the rx descriptors to dmaengine.
> + * allocate skbuff, map the scatterlist and obtain a descriptor
> + * and then add the callback information and submit descriptor.
> + *
> + * @ndev:	net_device pointer
> + *
> + *Return: 0, on success.
> + *          non-zero error value on failure
> + */
> +static int axienet_rx_submit_desc(struct net_device *ndev)
> +{
> +	struct dma_async_tx_descriptor *dma_rx_desc =3D NULL;
> +	struct axienet_local *lp =3D netdev_priv(ndev);
> +	struct skbuf_dma_descriptor *skbuf_dma;
> +	struct sk_buff *skb;
> +	dma_addr_t addr;
> +	int ret;
> +
> +	skbuf_dma =3D axienet_get_rx_desc(lp, lp->rx_ring_head);
> +	if (!skbuf_dma)
> +		return -ENOMEM;

Minor nit: here a newline would make the core more readable

> +	lp->rx_ring_head++;
> +	skb =3D netdev_alloc_skb(ndev, lp->max_frm_size);
> +	if (!skb)
> +		return -ENOMEM;

Another possible follow-up: usually the skb header is allocated just
before sending it to the network stack (e.g. just before the
__netif_rx() call) to be cache friendly. Here you could allocate just
the data part and later use e.g. build_skb_around()

> +
> +	sg_init_table(skbuf_dma->sgl, 1);
> +	addr =3D dma_map_single(lp->dev, skb->data, lp->max_frm_size, DMA_FROM_=
DEVICE);
> +	if (unlikely(dma_mapping_error(lp->dev, addr))) {
> +		if (net_ratelimit())
> +			netdev_err(ndev, "DMA mapping error\n");
> +		ret =3D -ENOMEM;
> +		goto rx_submit_err_free_skb;
> +	}
> +	sg_dma_address(skbuf_dma->sgl) =3D addr;
> +	sg_dma_len(skbuf_dma->sgl) =3D lp->max_frm_size;
> +	dma_rx_desc =3D dmaengine_prep_slave_sg(lp->rx_chan, skbuf_dma->sgl,
> +					      1, DMA_DEV_TO_MEM,
> +					      DMA_PREP_INTERRUPT);
> +	if (!dma_rx_desc) {
> +		ret =3D -EINVAL;
> +		goto rx_submit_err_unmap_skb;
> +	}
> +
> +	skbuf_dma->skb =3D skb;
> +	skbuf_dma->dma_address =3D sg_dma_address(skbuf_dma->sgl);
> +	skbuf_dma->desc =3D dma_rx_desc;
> +	dma_rx_desc->callback_param =3D lp;
> +	dma_rx_desc->callback_result =3D axienet_dma_rx_cb;
> +	dmaengine_submit(dma_rx_desc);
> +
> +	return 0;
> +
> +rx_submit_err_unmap_skb:
> +	dma_unmap_single(lp->dev, addr, lp->max_frm_size, DMA_FROM_DEVICE);
> +rx_submit_err_free_skb:
> +	dev_kfree_skb(skb);
> +	return ret;

It looks like the error code is ignored by the caller. Possibly you can
change this to a 'void' function.


Cheers,

Paolo

