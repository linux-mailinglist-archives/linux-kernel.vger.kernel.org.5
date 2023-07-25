Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794E1761F97
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjGYQwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjGYQwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:52:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D38A2698;
        Tue, 25 Jul 2023 09:51:51 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so33440b3a.1;
        Tue, 25 Jul 2023 09:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690303906; x=1690908706;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A+r2r5mfvosFn/xncTREw8QjIuYYBGolcffweMnuptc=;
        b=G3NJvYKBwDkkjAdxaM/bYSjXav5fGSAHj1L3ZB/WDRvgXq2v3ZLKnRJerKyYQYOVhe
         6vvKfFNiLTM06apWFW8pnmgTPRs5oBS3fXA0D95hZrY6Oeia7/uxbpkoguO+XkgZgrtf
         bwsI7wj+8palBoasNdsJ3EjlQ57WHiQPUNcZ0/BvGu4cqD9pT7JCWf4sdkIVhab/g36o
         n3fxcqCEKTT93YfCW1uhK1vVCRfBEMKa+Kvaqt9+/8CT+ApKxidzMvAbhxEIdABfML6n
         wQlDN+W3OiS0inSpeWMGwTJqSdRTzt58SVOqyBMt4YcpGtGKzMQWhdWKaPCNJjUCg5VN
         c51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690303906; x=1690908706;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+r2r5mfvosFn/xncTREw8QjIuYYBGolcffweMnuptc=;
        b=LZU1jQ/a8aOn6OgYGi79kXTN7ihTVxoHu670OwQn+8JDHtgK4e+LBalq8RjHFPKmZ2
         ec2bdY2a8SRntBETsq/uJL0CMnaTk/GDikE+m0nfKSf701eGXAIJCF2jX6Huzy1HcaEi
         8ZSwUZErPgjs4DH6zUFUNPdAT2FKwiiwgg56HGTF2JSU68HSTjOiiK0wL8At6ulN05mL
         HudoXAm3PME9Gwyg9wc9ovWcqSynn047FcnzRQz14s6qJbDiSMbMjctaXjphFbO+H+rM
         F8nCCC40Y0QqXFaUpkkxmhPfr/m1mFfGZNHhjdQSGf5dxZQ0yDdiCH+9qnj16SZdd+yW
         FZtw==
X-Gm-Message-State: ABy/qLZ0Dcb/M/J7WJsvjLhT+cinBuGTAKorRcDpIk/p++Mrx46QQb0Y
        oeEZ5LjlYFsm07d191nKKHg=
X-Google-Smtp-Source: APBJJlF0cwPMn0q7z3jjxEhagRb/CzXUXSeAY/nagVwlcA0j1JzqnmpHqJq6Aww9fIbZaFfcudLc5g==
X-Received: by 2002:a05:6a21:998e:b0:12b:40d3:aeb1 with SMTP id ve14-20020a056a21998e00b0012b40d3aeb1mr1407749pzb.25.1690303906284;
        Tue, 25 Jul 2023 09:51:46 -0700 (PDT)
Received: from ?IPv6:2605:59c8:448:b800:82ee:73ff:fe41:9a02? ([2605:59c8:448:b800:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id a20-20020a637f14000000b0055fedbf1938sm4722537pgd.31.2023.07.25.09.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:51:45 -0700 (PDT)
Message-ID: <70b71e7bb8a7dff2dacab99b0746e7bf2bee9344.camel@gmail.com>
Subject: Re: [PATCH net] net: fec: tx processing does not call XDP APIs if
 budget is 0
From:   Alexander H Duyck <alexander.duyck@gmail.com>
To:     Wei Fang <wei.fang@nxp.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, shenwei.wang@nxp.com,
        xiaoning.wang@nxp.com, pabeni@redhat.com, netdev@vger.kernel.org
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org
Date:   Tue, 25 Jul 2023 09:51:44 -0700
In-Reply-To: <20230725074148.2936402-1-wei.fang@nxp.com>
References: <20230725074148.2936402-1-wei.fang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-25 at 15:41 +0800, Wei Fang wrote:
> According to the clarification [1] in the latest napi.rst, the tx
> processing cannot call any XDP (or page pool) APIs if the "budget"
> is 0. Because NAPI is called with the budget of 0 (such as netpoll)
> indicates we may be in an IRQ context, however, we cannot use the
> page pool from IRQ context.
>=20
> [1] https://lore.kernel.org/all/20230720161323.2025379-1-kuba@kernel.org/
>=20
> Fixes: 20f797399035 ("net: fec: recycle pages for transmitted XDP frames"=
)
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethe=
rnet/freescale/fec_main.c
> index 073d61619336..66b5cbdb43b9 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1372,7 +1372,7 @@ fec_enet_hwtstamp(struct fec_enet_private *fep, uns=
igned ts,
>  }
> =20
>  static void
> -fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
> +fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  {
>  	struct	fec_enet_private *fep;
>  	struct xdp_frame *xdpf;
> @@ -1416,6 +1416,14 @@ fec_enet_tx_queue(struct net_device *ndev, u16 que=
ue_id)
>  			if (!skb)
>  				goto tx_buf_done;
>  		} else {
> +			/* Tx processing cannot call any XDP (or page pool) APIs if
> +			 * the "budget" is 0. Because NAPI is called with budget of
> +			 * 0 (such as netpoll) indicates we may be in an IRQ context,
> +			 * however, we can't use the page pool from IRQ context.
> +			 */
> +			if (unlikely(!budget))
> +				break;
> +
>  			xdpf =3D txq->tx_buf[index].xdp;
>  			if (bdp->cbd_bufaddr)
>  				dma_unmap_single(&fep->pdev->dev,

This statement isn't correct. There are napi enabled and non-napi
versions of these calls. This is the reason for things like the
"allow_direct" parameter in page_pool_put_full_page and the
"napi_direct" parameter in __xdp_return.

By blocking on these cases you can end up hanging the Tx queue which is
going to break netpoll as you are going to stall the ring on XDP
packets if they are already in the queue.

From what I can tell your driver is using xdp_return_frame in the case
of an XDP frame which doesn't make use of the NAPI optimizations in
freeing from what I can tell. The NAPI optimized version is
xdp_return_frame_rx.

> @@ -1508,14 +1516,14 @@ fec_enet_tx_queue(struct net_device *ndev, u16 qu=
eue_id)
>  		writel(0, txq->bd.reg_desc_active);
>  }
> =20
> -static void fec_enet_tx(struct net_device *ndev)
> +static void fec_enet_tx(struct net_device *ndev, int budget)
>  {
>  	struct fec_enet_private *fep =3D netdev_priv(ndev);
>  	int i;
> =20
>  	/* Make sure that AVB queues are processed first. */
>  	for (i =3D fep->num_tx_queues - 1; i >=3D 0; i--)
> -		fec_enet_tx_queue(ndev, i);
> +		fec_enet_tx_queue(ndev, i, budget);
>  }
> =20
>  static void fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
> @@ -1858,7 +1866,7 @@ static int fec_enet_rx_napi(struct napi_struct *nap=
i, int budget)
> =20
>  	do {
>  		done +=3D fec_enet_rx(ndev, budget - done);
> -		fec_enet_tx(ndev);
> +		fec_enet_tx(ndev, budget);
>  	} while ((done < budget) && fec_enet_collect_events(fep));
> =20
>  	if (done < budget) {

Since you are passing budget, one optimization you could make use of
would be napi_consume_skb in your Tx path instead of dev_kfree_skb_any.
