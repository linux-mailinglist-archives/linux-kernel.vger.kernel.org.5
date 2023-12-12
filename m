Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE9B80E8BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346100AbjLLKKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjLLKKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:10:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEE7D2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702375808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2qrZxP2ac93pT6YGUui4NzQE6+RjwLeXcnutigWb1E=;
        b=aHZvhNYoeX2tHlqvnQ+zfbTuJMnWLSYwLidwh0M5UykZGrJvCNCONGETKgtSHsiaN5bMul
        2N51NzZayu67lKC/3ov61HY1nqyIK/m55RXInrK1snFwdjSZiRkrY2YyYycW531HDCvWie
        Wl1KNE5fXY8GyWn1XHtKnE6fMTSgJOI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-VOcCwo4nPKSLKH09Cv3YIg-1; Tue, 12 Dec 2023 05:10:06 -0500
X-MC-Unique: VOcCwo4nPKSLKH09Cv3YIg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1fae8cca5bso33449066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702375494; x=1702980294;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N2qrZxP2ac93pT6YGUui4NzQE6+RjwLeXcnutigWb1E=;
        b=gtDSorF8magbEOoDRJhUVbW5dxYbSZ9cRZCeb1SsfyC0kmvseoc3Lc4uwAEq7Lwlwm
         Aks1L9LvXfcIYyIq/m1a9g2EzuW+vhdvxvXk6EzRhKcck2j/1ElSmKMZwjN+KRCI500Y
         V3LLYlaUl1p0uuKhxirZWG6alM70/WZNloFvfMHcpcG/NZGT1rzjNxMh6wLYAxAHtB2o
         qQ0TY0uh7G6mo4tURUFHhU+fNpWXNy8qGVEZk0g2xL8pBSjyDQDAy4lvjmJaeaEnZ71P
         he6X2+aNBZL5f+4Sxn3FTIsy6ye4RpB6zpVkc2qnl4zKcNU5OLiJ2x110qnHDqW83lG1
         MNGQ==
X-Gm-Message-State: AOJu0YyIqAndv7jBO/elWBvAbeOOBn6TuNZ7HJb20xwUL0bjAZIIwWgy
        zuTIVVAwzabZ3wI8KT4oPQr8n2i/i95H+oRUNHqnlA2LoJ4+Cfy4plokfaPchqJyGLsvPUJ0UVQ
        gYMmzkOb3qcmlwfpwl98FKfiY
X-Received: by 2002:a17:907:d404:b0:a19:6a79:2d3f with SMTP id vi4-20020a170907d40400b00a196a792d3fmr6406029ejc.1.1702375494302;
        Tue, 12 Dec 2023 02:04:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNLmDK0LntFpfQyTxBGq5iBngVThe6Flhn8iBAKDAdFkx2IrX7xyD1bHIG7Sm6lIMpdOJKNw==
X-Received: by 2002:a17:907:d404:b0:a19:6a79:2d3f with SMTP id vi4-20020a170907d40400b00a196a792d3fmr6406020ejc.1.1702375493991;
        Tue, 12 Dec 2023 02:04:53 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id tp25-20020a170907c49900b00a1f7c502736sm4760617ejc.164.2023.12.12.02.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:04:53 -0800 (PST)
Message-ID: <18552cff6fe32d4c21b4751cd6be4ff4757c63e8.camel@redhat.com>
Subject: Re: [PATCH net-next v14 07/13] rtase: Implement a function to
 receive packets
From:   Paolo Abeni <pabeni@redhat.com>
To:     Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        andrew@lunn.ch, pkshih@realtek.com, larry.chiu@realtek.com
Date:   Tue, 12 Dec 2023 11:04:52 +0100
In-Reply-To: <20231208094733.1671296-8-justinlai0215@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
         <20231208094733.1671296-8-justinlai0215@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-08 at 17:47 +0800, Justin Lai wrote:
> Implement rx_handler to read the information of the rx descriptor,
> thereby checking the packet accordingly and storing the packet
> in the socket buffer to complete the reception of the packet.
>=20
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 148 ++++++++++++++++++
>  1 file changed, 148 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/ne=
t/ethernet/realtek/rtase/rtase_main.c
> index eee792ea4760..83a119389110 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -451,6 +451,154 @@ static void rtase_rx_ring_clear(struct rtase_ring *=
ring)
>  	}
>  }
> =20
> +static int rtase_fragmented_frame(u32 status)
> +{
> +	return (status & (RX_FIRST_FRAG | RX_LAST_FRAG)) !=3D
> +		(RX_FIRST_FRAG | RX_LAST_FRAG);
> +}
> +
> +static void rtase_rx_csum(const struct rtase_private *tp, struct sk_buff=
 *skb,
> +			  const union rx_desc *desc)
> +{
> +	u32 opts2 =3D le32_to_cpu(desc->desc_status.opts2);
> +
> +	/* rx csum offload */
> +	if (((opts2 & RX_V4F) && !(opts2 & RX_IPF)) || (opts2 & RX_V6F)) {
> +		if (((opts2 & RX_TCPT) && !(opts2 & RX_TCPF)) ||
> +		    ((opts2 & RX_UDPT) && !(opts2 & RX_UDPF))) {
> +			skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +		} else {
> +			skb->ip_summed =3D CHECKSUM_NONE;
> +		}
> +	} else {
> +		skb->ip_summed =3D CHECKSUM_NONE;
> +	}
> +}
> +
> +static void rtase_rx_vlan_skb(union rx_desc *desc, struct sk_buff *skb)
> +{
> +	u32 opts2 =3D le32_to_cpu(desc->desc_status.opts2);
> +
> +	if (!(opts2 & RX_VLAN_TAG))
> +		return;
> +
> +	__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), swab16(opts2 & VLAN_TAG=
_MASK));
> +}
> +
> +static void rtase_rx_skb(const struct rtase_ring *ring, struct sk_buff *=
skb)
> +{
> +	struct rtase_int_vector *ivec =3D ring->ivec;
> +
> +	napi_gro_receive(&ivec->napi, skb);
> +}
> +
> +static int rx_handler(struct rtase_ring *ring, int budget)
> +{
> +	const struct rtase_private *tp =3D ring->ivec->tp;
> +	u32 pkt_size, cur_rx, delta, entry, status;
> +	union rx_desc *desc_base =3D ring->desc;
> +	struct net_device *dev =3D tp->dev;
> +	struct sk_buff *skb;
> +	union rx_desc *desc;
> +	int workdone =3D 0;
> +
> +	if (!ring->desc)
> +		return workdone;

Why is the above test required? How can be ring->desc NULL here?

> +
> +	cur_rx =3D ring->cur_idx;
> +	entry =3D cur_rx % NUM_DESC;
> +	desc =3D &desc_base[entry];
> +
> +	do {
> +		/* make sure discriptor has been updated */
> +		rmb();
> +		status =3D le32_to_cpu(desc->desc_status.opts1);
> +
> +		if (status & DESC_OWN)
> +			break;
> +
> +		if (unlikely(status & RX_RES)) {
> +			if (net_ratelimit())
> +				netdev_warn(dev, "Rx ERROR. status =3D %08x\n",
> +					    status);
> +
> +			dev->stats.rx_errors++;
> +
> +			if (status & (RX_RWT | RX_RUNT))
> +				dev->stats.rx_length_errors++;

The device has a single RX queue, right? Otherwise this kind of stats
accounting is going to be costly.

Cheers,

Paolo

