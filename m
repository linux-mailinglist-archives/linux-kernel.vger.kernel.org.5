Return-Path: <linux-kernel+bounces-151143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 791578AA9AF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D01E6B21991
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E931A4EB5C;
	Fri, 19 Apr 2024 08:03:00 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87853FBB1;
	Fri, 19 Apr 2024 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513780; cv=none; b=m+R/5KWcsJxdo6+oTXuOMob0AMyfAXsZFNNCo3oku5lvP/1S+Cceh36NDPS0/Cy6R4pnI5yxuc8Ba8DLXB48UloQpDtO1KpY9GgyZTzjO4nM0Ubimn5/knb+UsbusBpC3DVskbcvu/IMyZ+s/e6mYBZEA61D3tXXrJyeREVCPiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513780; c=relaxed/simple;
	bh=g1GbZyttDCV26zMkE8lUVTnUdDzxmLQImVb6WbldqJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qURG+kkE2szH5mUrqw6LaKIk8CdZ/t6mSi0/dlilB/DEXq8GPLiTKhKOGsG3OVVrs+nfOUONaxFZ7WhwkbdeEWPhxz7D0ukhGOCgkbMwkaZAtRy2EJzQ+SiimepFIirtrGi3FIrhxgi8RpGflkeje6NudzgQTLKDOser60Lo31o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,213,1708354800"; 
   d="asc'?scan'208";a="205933952"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 19 Apr 2024 17:02:49 +0900
Received: from [10.226.93.210] (unknown [10.226.93.210])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4715440158C7;
	Fri, 19 Apr 2024 17:02:45 +0900 (JST)
Message-ID: <a7468b22-b262-4882-b8fe-0e2e95556719@bp.renesas.com>
Date: Fri, 19 Apr 2024 09:02:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next RFC v3 7/7] net: ravb: Allocate RX buffers via page
 pool
Content-Language: en-GB
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
 <20240415094804.8016-8-paul.barker.ct@bp.renesas.com>
 <20240415121621.GI3156415@ragnatech.se>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <20240415121621.GI3156415@ragnatech.se>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2Vt4708c0VOHBKWY8S6CoWsf"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------2Vt4708c0VOHBKWY8S6CoWsf
Content-Type: multipart/mixed; boundary="------------20Ymvqs3RyNHNuo5DYVhTcr0";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <a7468b22-b262-4882-b8fe-0e2e95556719@bp.renesas.com>
Subject: Re: [net-next RFC v3 7/7] net: ravb: Allocate RX buffers via page
 pool
References: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
 <20240415094804.8016-8-paul.barker.ct@bp.renesas.com>
 <20240415121621.GI3156415@ragnatech.se>
In-Reply-To: <20240415121621.GI3156415@ragnatech.se>

--------------20Ymvqs3RyNHNuo5DYVhTcr0
Content-Type: multipart/mixed; boundary="------------DdH6OajK38zifMJErAXI0ALo"

--------------DdH6OajK38zifMJErAXI0ALo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 15/04/2024 13:16, Niklas S=C3=B6derlund wrote:
> Hi Paul,
>=20
> I think using page pool is a good idea!
>=20
> On 2024-04-15 10:48:04 +0100, Paul Barker wrote:
>> This patch makes multiple changes that can't be separated:
>>
>>   1) Allocate plain RX buffers via a page pool instead of allocating
>>      SKBs, then use build_skb() when a packet is received.
>>   2) For GbEth IP, reduce the RX buffer size to 2kB.
>>   3) For GbEth IP, merge packets which span more than one RX descripto=
r
>>      as SKB fragments instead of copying data.
>>
>> Implementing (1) without (2) would require the use of an order-1 page
>> pool (instead of an order-0 page pool split into page fragments) for
>> GbEth.
>>
>> Implementing (2) without (3) would leave us no space to re-assemble
>> packets which span more than one RX descriptor.
>>
>> Implementing (3) without (1) would not be possible as the network stac=
k
>> expects to use put_page() or page_pool_put_page() to free SKB fragment=
s
>> after an SKB is consumed.
>>
>> This patch gives the following improvements during testing with iperf3=
=2E
>>
>>   * RZ/G2L:
>>     * TCP RX: same bandwidth at -43% CPU load (70% -> 40%)
>>     * UDP RX: same bandwidth at -17% CPU load (88% -> 74%)
>>
>>   * RZ/G2UL:
>>     * TCP RX: +30% bandwidth (726Mbps -> 941Mbps)
>>     * UDP RX: +417% bandwidth (108Mbps -> 558Mbps)
>>
>>   * RZ/G3S:
>>     * TCP RX: +64% bandwidth (562Mbps -> 920Mbps)
>>     * UDP RX: +420% bandwidth (90Mbps -> 468Mbps)
>>
>>   * RZ/Five:
>>     * TCP RX: +217% bandwidth (145Mbps -> 459Mbps)
>>     * UDP RX: +470% bandwidth (20Mbps -> 114Mbps)
>>
>> There is no significant impact on bandwidth or CPU load in testing on
>> RZ/G2H or R-Car M3N.
>>
>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> ---
>>  drivers/net/ethernet/renesas/ravb.h      |  10 +-
>>  drivers/net/ethernet/renesas/ravb_main.c | 209 +++++++++++++---------=
-
>>  2 files changed, 128 insertions(+), 91 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/etherne=
t/renesas/ravb.h
>> index 9c6392ade2f1..4348366c3dc7 100644
>> --- a/drivers/net/ethernet/renesas/ravb.h
>> +++ b/drivers/net/ethernet/renesas/ravb.h
>> @@ -1050,8 +1050,8 @@ struct ravb_hw_info {
>>  	netdev_features_t net_features;
>>  	int stats_len;
>>  	u32 tccr_mask;
>> +	u32 rx_buffer_size;
>>  	u32 rx_max_frame_size;
>> -	u32 rx_max_desc_use;
>>  	u32 rx_desc_size;
>>  	unsigned aligned_tx: 1;
>>  	unsigned needs_irq_coalesce:1;	/* Needs software IRQ coalescing */
>> @@ -1071,6 +1071,11 @@ struct ravb_hw_info {
>>  	unsigned half_duplex:1;		/* E-MAC supports half duplex mode */
>>  };
>> =20
>> +struct ravb_rx_buffer {
>> +	struct page *page;
>> +	unsigned int offset;
>> +};
>> +
>>  struct ravb_private {
>>  	struct net_device *ndev;
>>  	struct platform_device *pdev;
>> @@ -1094,7 +1099,8 @@ struct ravb_private {
>>  	struct ravb_tx_desc *tx_ring[NUM_TX_QUEUE];
>>  	void *tx_align[NUM_TX_QUEUE];
>>  	struct sk_buff *rx_1st_skb;
>> -	struct sk_buff **rx_skb[NUM_RX_QUEUE];
>> +	struct page_pool *rx_pool;
>=20
> Don't we need a page pool per queue? Else multiple calls to=20
> ravb_ring_init() and ravb_ring_free() for different queues will=20
> otherwise risk allocating over a previous queue and multiple free the=20
> same one.

Ack.

>=20
>> +	struct ravb_rx_buffer *rx_buffers[NUM_RX_QUEUE];
>>  	struct sk_buff **tx_skb[NUM_TX_QUEUE];
>>  	u32 rx_over_errors;
>>  	u32 rx_fifo_errors;
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/et=
hernet/renesas/ravb_main.c
>> index 7434faf0820c..892a3eadef1e 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -30,6 +30,7 @@
>>  #include <linux/reset.h>
>>  #include <linux/math64.h>
>>  #include <net/ip.h>
>> +#include <net/page_pool/helpers.h>
>> =20
>>  #include "ravb.h"
>> =20
>> @@ -113,25 +114,6 @@ static void ravb_set_rate_rcar(struct net_device =
*ndev)
>>  	}
>>  }
>> =20
>> -static struct sk_buff *
>> -ravb_alloc_skb(struct net_device *ndev, const struct ravb_hw_info *in=
fo,
>> -	       gfp_t gfp_mask)
>> -{
>> -	struct sk_buff *skb;
>> -	u32 reserve;
>> -
>> -	skb =3D __netdev_alloc_skb(ndev, info->rx_max_frame_size + RAVB_ALIG=
N - 1,
>> -				 gfp_mask);
>> -	if (!skb)
>> -		return NULL;
>> -
>> -	reserve =3D (unsigned long)skb->data & (RAVB_ALIGN - 1);
>> -	if (reserve)
>> -		skb_reserve(skb, RAVB_ALIGN - reserve);
>> -
>> -	return skb;
>> -}
>> -
>>  /* Get MAC address from the MAC address registers
>>   *
>>   * Ethernet AVB device doesn't have ROM for MAC address.
>> @@ -257,21 +239,10 @@ static void ravb_rx_ring_free(struct net_device =
*ndev, int q)
>>  {
>>  	struct ravb_private *priv =3D netdev_priv(ndev);
>>  	unsigned int ring_size;
>> -	unsigned int i;
>> =20
>>  	if (!priv->rx_ring[q].raw)
>>  		return;
>> =20
>> -	for (i =3D 0; i < priv->num_rx_ring[q]; i++) {
>> -		struct ravb_rx_desc *desc =3D ravb_rx_get_desc(priv, q, i);
>> -
>> -		if (!dma_mapping_error(ndev->dev.parent,
>> -				       le32_to_cpu(desc->dptr)))
>> -			dma_unmap_single(ndev->dev.parent,
>> -					 le32_to_cpu(desc->dptr),
>> -					 priv->info->rx_max_frame_size,
>> -					 DMA_FROM_DEVICE);
>> -	}
>>  	ring_size =3D priv->info->rx_desc_size * (priv->num_rx_ring[q] + 1);=

>>  	dma_free_coherent(ndev->dev.parent, ring_size, priv->rx_ring[q].raw,=

>>  			  priv->rx_desc_dma[q]);
>> @@ -298,13 +269,14 @@ static void ravb_ring_free(struct net_device *nd=
ev, int q)
>>  		priv->tx_ring[q] =3D NULL;
>>  	}
>> =20
>> -	/* Free RX skb ringbuffer */
>> -	if (priv->rx_skb[q]) {
>> -		for (i =3D 0; i < priv->num_rx_ring[q]; i++)
>> -			dev_kfree_skb(priv->rx_skb[q][i]);
>> +	/* Free RX buffers */
>> +	for (i =3D 0; i < priv->num_rx_ring[q]; i++) {
>> +		if (priv->rx_buffers[q][i].page)
>> +			page_pool_put_page(priv->rx_pool, priv->rx_buffers[q][i].page, 0, =
true);
>>  	}
>> -	kfree(priv->rx_skb[q]);
>> -	priv->rx_skb[q] =3D NULL;
>> +	kfree(priv->rx_buffers[q]);
>> +	priv->rx_buffers[q] =3D NULL;
>> +	page_pool_destroy(priv->rx_pool);
>> =20
>>  	/* Free aligned TX buffers */
>>  	kfree(priv->tx_align[q]);
>> @@ -317,35 +289,54 @@ static void ravb_ring_free(struct net_device *nd=
ev, int q)
>>  	priv->tx_skb[q] =3D NULL;
>>  }
>> =20
>> +static int
>> +ravb_alloc_rx_buffer(struct net_device *ndev, int q, u32 entry, gfp_t=
 gfp_mask,
>> +		     __le32 *dptr)
>=20
> Why not pass the struct ravb_rx_desc instead of a dptr? Then the=20
> function can deal with the error case and fill in rx_desc->dptr and=20
> rx_desc->ds_cc directly making the caller simpler.

Ack.

>=20
>> +{
>> +	struct ravb_private *priv =3D netdev_priv(ndev);
>> +	const struct ravb_hw_info *info =3D priv->info;
>> +	struct ravb_rx_buffer *rx_buff =3D &priv->rx_buffers[q][entry];
>> +	dma_addr_t dma_addr;
>> +	unsigned int size;
>> +
>> +	size =3D info->rx_buffer_size;
>> +	rx_buff->page =3D page_pool_alloc(priv->rx_pool, &rx_buff->offset, &=
size,
>> +					gfp_mask);
>> +	if (unlikely(!rx_buff->page))
>> +		return -ENOMEM;
>> +
>> +	dma_addr =3D page_pool_get_dma_addr(rx_buff->page) + rx_buff->offset=
;
>> +	dma_sync_single_for_device(ndev->dev.parent, dma_addr,
>> +				   info->rx_buffer_size, DMA_FROM_DEVICE);
>> +	*dptr =3D cpu_to_le32(dma_addr);
>> +	return 0;
>> +}
>> +
>>  static u32
>>  ravb_rx_ring_refill(struct net_device *ndev, int q, u32 count, gfp_t =
gfp_mask)
>>  {
>>  	struct ravb_private *priv =3D netdev_priv(ndev);
>>  	const struct ravb_hw_info *info =3D priv->info;
>>  	struct ravb_rx_desc *rx_desc;
>> -	dma_addr_t dma_addr;
>>  	u32 i, entry;
>> =20
>>  	for (i =3D 0; i < count; i++) {
>>  		entry =3D (priv->dirty_rx[q] + i) % priv->num_rx_ring[q];
>>  		rx_desc =3D ravb_rx_get_desc(priv, q, entry);
>> -		rx_desc->ds_cc =3D cpu_to_le16(info->rx_max_desc_use);
>> =20
>> -		if (!priv->rx_skb[q][entry]) {
>> -			priv->rx_skb[q][entry] =3D ravb_alloc_skb(ndev, info, gfp_mask);
>> -			if (!priv->rx_skb[q][entry])
>> -				break;
>> -			dma_addr =3D dma_map_single(ndev->dev.parent,
>> -						  priv->rx_skb[q][entry]->data,
>> -						  priv->info->rx_max_frame_size,
>> -						  DMA_FROM_DEVICE);
>> -			skb_checksum_none_assert(priv->rx_skb[q][entry]);
>> -			/* We just set the data size to 0 for a failed mapping
>> -			 * which should prevent DMA from happening...
>> -			 */
>> -			if (dma_mapping_error(ndev->dev.parent, dma_addr))
>> +		if (!priv->rx_buffers[q][entry].page) {
>> +			if (unlikely(ravb_alloc_rx_buffer(ndev, q, entry, gfp_mask,
>> +							  &rx_desc->dptr))) {
>> +				/* We just set the data size to 0 for a failed mapping
>> +				 * which should prevent DMA from happening...
>> +				 */
>>  				rx_desc->ds_cc =3D cpu_to_le16(0);
>> -			rx_desc->dptr =3D cpu_to_le32(dma_addr);
>> +				break;
>> +			}
>> +
>> +			rx_desc->ds_cc =3D cpu_to_le16(info->rx_buffer_size
>> +						     - SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
>> +						     - ETH_FCS_LEN + sizeof(__sum16));
>=20
> Can a comment be added to why we subtract and add things to the size?

Ack.

I'll address these in v4.

--=20
Paul Barker

--------------DdH6OajK38zifMJErAXI0ALo
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------DdH6OajK38zifMJErAXI0ALo--

--------------20Ymvqs3RyNHNuo5DYVhTcr0--

--------------2Vt4708c0VOHBKWY8S6CoWsf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZiIlJAUDAAAAAAAKCRDbaV4Vf/JGvY2E
AP9vYMXXNBm0NqX7CbFaWa74syQnQsy8TGdCExJbN1me8AEAt28BA5yvndtsAW806MYCma9OOc7O
72s98g1xtmxmdwA=
=rjUw
-----END PGP SIGNATURE-----

--------------2Vt4708c0VOHBKWY8S6CoWsf--

