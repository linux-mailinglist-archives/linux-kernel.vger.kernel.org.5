Return-Path: <linux-kernel+bounces-145050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908DB8A4EC2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C86282FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C296A8DE;
	Mon, 15 Apr 2024 12:18:18 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7111374D3;
	Mon, 15 Apr 2024 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183497; cv=none; b=jys/fksxeQUsaUyb0zY0NUWaDcE6mtymEHBCQJQmULAhV5DBDgpQ/mv4Y9+7u4eRarGAOfKlIMe8FXdcV0S7lI4BCWr3UkuM8PWZyC+0iwTntm0tDWPg1wVqR0x6JJULnNcCbegiAtDrith6pOOvEm5IgzHDuemMvK4hjBFSEu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183497; c=relaxed/simple;
	bh=XqA2LV/Vgj6hO2qfNwHJuH7SArud/hAYbSJnEWlJaT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTuAae/t4P0XqQyDDxdtQBCueghKGItTTWYnv42rMoZaTb4g5PZioi6XrMHYCaBtv6x8gjGDxLRTFrkSCRTyhOGzSYuKUe7s6JINxCeZsotnOhq/bEDSNT/NRjDGdVlcBbh8YAFkmTRmmq7XDPbV6HTV0QJAb/6A++WiG2Dv9Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,203,1708354800"; 
   d="asc'?scan'208";a="205445324"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Apr 2024 21:18:13 +0900
Received: from [10.226.93.74] (unknown [10.226.93.74])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 17D01400BBFF;
	Mon, 15 Apr 2024 21:18:09 +0900 (JST)
Message-ID: <b1d0ca22-de75-4d76-90ba-62c2a57f4301@bp.renesas.com>
Date: Mon, 15 Apr 2024 13:18:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next RFC v3 3/7] net: ravb: Refactor RX ring refill
Content-Language: en-GB
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
 <20240415094804.8016-4-paul.barker.ct@bp.renesas.com>
 <20240415115755.GH3156415@ragnatech.se>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <20240415115755.GH3156415@ragnatech.se>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fQkLkeakaNyqS60iLBC7JGay"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fQkLkeakaNyqS60iLBC7JGay
Content-Type: multipart/mixed; boundary="------------yyWBol9nIQgOP00BSCcuE6Ee";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <b1d0ca22-de75-4d76-90ba-62c2a57f4301@bp.renesas.com>
Subject: Re: [net-next RFC v3 3/7] net: ravb: Refactor RX ring refill
References: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
 <20240415094804.8016-4-paul.barker.ct@bp.renesas.com>
 <20240415115755.GH3156415@ragnatech.se>
In-Reply-To: <20240415115755.GH3156415@ragnatech.se>

--------------yyWBol9nIQgOP00BSCcuE6Ee
Content-Type: multipart/mixed; boundary="------------23fTz8Sve8qVuAJGjspuhLgn"

--------------23fTz8Sve8qVuAJGjspuhLgn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 15/04/2024 12:57, Niklas S=C3=B6derlund wrote:
> Hi Paul,
>=20
> Thanks for your work, I really like this deduplication of code!
>=20
> On 2024-04-15 10:48:00 +0100, Paul Barker wrote:
>> To reduce code duplication, we add a new RX ring refill function which=

>> can handle both the initial RX ring population (which was split betwee=
n
>> ravb_ring_init() and ravb_ring_format()) and the RX ring refill after
>> polling (in ravb_rx()).
>>
>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> ---
>>  drivers/net/ethernet/renesas/ravb_main.c | 141 +++++++++-------------=
-
>>  1 file changed, 52 insertions(+), 89 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/et=
hernet/renesas/ravb_main.c
>> index 1ac599a044b2..baa01bd81f2d 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -317,35 +317,42 @@ static void ravb_ring_free(struct net_device *nd=
ev, int q)
>>  	priv->tx_skb[q] =3D NULL;
>>  }
>> =20
>> -static void ravb_rx_ring_format(struct net_device *ndev, int q)
>> +static u32
>> +ravb_rx_ring_refill(struct net_device *ndev, int q, u32 count, gfp_t =
gfp_mask)
>>  {
>>  	struct ravb_private *priv =3D netdev_priv(ndev);
>> +	const struct ravb_hw_info *info =3D priv->info;
>>  	struct ravb_rx_desc *rx_desc;
>> -	unsigned int rx_ring_size;
>>  	dma_addr_t dma_addr;
>> -	unsigned int i;
>> +	u32 i, entry;
>> =20
>> -	rx_ring_size =3D priv->info->rx_desc_size * priv->num_rx_ring[q];
>> -	memset(priv->rx_ring[q].raw, 0, rx_ring_size);
>> -	/* Build RX ring buffer */
>> -	for (i =3D 0; i < priv->num_rx_ring[q]; i++) {
>> -		/* RX descriptor */
>> -		rx_desc =3D ravb_rx_get_desc(priv, q, i);
>> -		rx_desc->ds_cc =3D cpu_to_le16(priv->info->rx_max_desc_use);
>> -		dma_addr =3D dma_map_single(ndev->dev.parent, priv->rx_skb[q][i]->d=
ata,
>> -					  priv->info->rx_max_frame_size,
>> -					  DMA_FROM_DEVICE);
>> -		/* We just set the data size to 0 for a failed mapping which
>> -		 * should prevent DMA from happening...
>> -		 */
>> -		if (dma_mapping_error(ndev->dev.parent, dma_addr))
>> -			rx_desc->ds_cc =3D cpu_to_le16(0);
>> -		rx_desc->dptr =3D cpu_to_le32(dma_addr);
>> +	for (i =3D 0; i < count; i++) {
>> +		entry =3D (priv->dirty_rx[q] + i) % priv->num_rx_ring[q];
>> +		rx_desc =3D ravb_rx_get_desc(priv, q, entry);
>> +		rx_desc->ds_cc =3D cpu_to_le16(info->rx_max_desc_use);
>> +
>> +		if (!priv->rx_skb[q][entry]) {
>> +			priv->rx_skb[q][entry] =3D ravb_alloc_skb(ndev, info, gfp_mask);
>> +			if (!priv->rx_skb[q][entry])
>> +				break;
>> +			dma_addr =3D dma_map_single(ndev->dev.parent,
>> +						  priv->rx_skb[q][entry]->data,
>> +						  priv->info->rx_max_frame_size,
>> +						  DMA_FROM_DEVICE);
>> +			skb_checksum_none_assert(priv->rx_skb[q][entry]);
>> +			/* We just set the data size to 0 for a failed mapping
>> +			 * which should prevent DMA from happening...
>> +			 */
>> +			if (dma_mapping_error(ndev->dev.parent, dma_addr))
>> +				rx_desc->ds_cc =3D cpu_to_le16(0);
>> +			rx_desc->dptr =3D cpu_to_le32(dma_addr);
>> +		}
>> +		/* Descriptor type must be set after all the above writes */
>> +		dma_wmb();
>>  		rx_desc->die_dt =3D DT_FEMPTY;
>>  	}
>> -	rx_desc =3D ravb_rx_get_desc(priv, q, i);
>> -	rx_desc->dptr =3D cpu_to_le32((u32)priv->rx_desc_dma[q]);
>> -	rx_desc->die_dt =3D DT_LINKFIX; /* type */
>> +
>> +	return i;
>>  }
>> =20
>>  /* Format skb and descriptor buffer for Ethernet AVB */
>> @@ -353,6 +360,7 @@ static void ravb_ring_format(struct net_device *nd=
ev, int q)
>>  {
>>  	struct ravb_private *priv =3D netdev_priv(ndev);
>>  	unsigned int num_tx_desc =3D priv->num_tx_desc;
>> +	struct ravb_rx_desc *rx_desc;
>>  	struct ravb_tx_desc *tx_desc;
>>  	struct ravb_desc *desc;
>>  	unsigned int tx_ring_size =3D sizeof(*tx_desc) * priv->num_tx_ring[q=
] *
>> @@ -364,8 +372,6 @@ static void ravb_ring_format(struct net_device *nd=
ev, int q)
>>  	priv->dirty_rx[q] =3D 0;
>>  	priv->dirty_tx[q] =3D 0;
>> =20
>> -	ravb_rx_ring_format(ndev, q);
>> -
>>  	memset(priv->tx_ring[q], 0, tx_ring_size);
>>  	/* Build TX ring buffer */
>>  	for (i =3D 0, tx_desc =3D priv->tx_ring[q]; i < priv->num_tx_ring[q]=
;
>> @@ -379,6 +385,14 @@ static void ravb_ring_format(struct net_device *n=
dev, int q)
>>  	tx_desc->dptr =3D cpu_to_le32((u32)priv->tx_desc_dma[q]);
>>  	tx_desc->die_dt =3D DT_LINKFIX; /* type */
>> =20
>> +	/* Regular RX descriptors have already been initialized by
>> +	 * ravb_rx_ring_refill(), we just need to initialize the final link
>> +	 * descriptor.
>> +	 */
>> +	rx_desc =3D ravb_rx_get_desc(priv, q, priv->num_rx_ring[q]);
>> +	rx_desc->dptr =3D cpu_to_le32((u32)priv->rx_desc_dma[q]);
>> +	rx_desc->die_dt =3D DT_LINKFIX; /* type */
>> +
>=20
> super-nit: Should you not move this addition up to where you removed th=
e=20
> call to ravb_rx_ring_format()? Before this change the order of things=20
> are,
>=20
>     /* Init RX ring */
>     /* Init TX ring */
>     /* Set RX descriptor base address */
>     /* Set TX descriptor base address */
>=20
>=20
> While after it is,
>=20
>     /* Init TX ring */
>     /* Init RX ring */
>     /* Set RX descriptor base address */
>     /* Set TX descriptor base address */
>=20
> My OCD is itching ;-)

Since I'll need to re-spin this series anyway, I may as well tidy that
up :)

>=20
>>  	/* RX descriptor base address for best effort */
>>  	desc =3D &priv->desc_bat[RX_QUEUE_OFFSET + q];
>>  	desc->die_dt =3D DT_LINKFIX; /* type */
>> @@ -408,11 +422,9 @@ static void *ravb_alloc_rx_desc(struct net_device=
 *ndev, int q)
>>  static int ravb_ring_init(struct net_device *ndev, int q)
>>  {
>>  	struct ravb_private *priv =3D netdev_priv(ndev);
>> -	const struct ravb_hw_info *info =3D priv->info;
>>  	unsigned int num_tx_desc =3D priv->num_tx_desc;
>>  	unsigned int ring_size;
>> -	struct sk_buff *skb;
>> -	unsigned int i;
>> +	u32 num_filled;
>> =20
>>  	/* Allocate RX and TX skb rings */
>>  	priv->rx_skb[q] =3D kcalloc(priv->num_rx_ring[q],
>> @@ -422,13 +434,6 @@ static int ravb_ring_init(struct net_device *ndev=
, int q)
>>  	if (!priv->rx_skb[q] || !priv->tx_skb[q])
>>  		goto error;
>> =20
>> -	for (i =3D 0; i < priv->num_rx_ring[q]; i++) {
>> -		skb =3D ravb_alloc_skb(ndev, info, GFP_KERNEL);
>> -		if (!skb)
>> -			goto error;
>> -		priv->rx_skb[q][i] =3D skb;
>> -	}
>> -
>>  	if (num_tx_desc > 1) {
>>  		/* Allocate rings for the aligned buffers */
>>  		priv->tx_align[q] =3D kmalloc(DPTR_ALIGN * priv->num_tx_ring[q] +
>> @@ -443,6 +448,13 @@ static int ravb_ring_init(struct net_device *ndev=
, int q)
>> =20
>>  	priv->dirty_rx[q] =3D 0;
>> =20
>> +	/* Populate RX ring buffer. */
>> +	ring_size =3D priv->info->rx_desc_size * priv->num_rx_ring[q];
>> +	memset(priv->rx_ring[q].raw, 0, ring_size);
>> +	num_filled =3D ravb_rx_ring_refill(ndev, q, priv->num_rx_ring[q], GF=
P_KERNEL);
>> +	if (num_filled !=3D priv->num_rx_ring[q])
>> +		goto error;
>> +
>=20
> Here you also change the order, but it make sense here as you first dea=
l=20
> with all TX and then all RX ;-)

The placement here is because we can't call ravb_rx_ring_refill() until
priv->dirty_rx[q] has been zero'd.

The init order right now is actually:
  RX page pool
  RX buffers
  TX SKBs
  RX descriptors
  RX ring buffer
  TX descriptors

So maybe this should be re-ordered.

I considered breaking this all apart, so ravb_ring_init() would call
ravb_rx_ring_init()/ravb_tx_ring_init() and ravb_ring_format() would
call ravb_rx_ring_format()/ravb_tx_ring_format(). There are several
steps happening for TX & RX in both init and format stages. Does that
sound cleaner to you?

Thanks,

--=20
Paul Barker
--------------23fTz8Sve8qVuAJGjspuhLgn
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------23fTz8Sve8qVuAJGjspuhLgn--

--------------yyWBol9nIQgOP00BSCcuE6Ee--

--------------fQkLkeakaNyqS60iLBC7JGay
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZh0bAAUDAAAAAAAKCRDbaV4Vf/JGvV1t
AQDbVYa27wuzuyhXLTIYLxYKrXyJmRrg1xBlezk/qJj2EQD/VQ5HYlx2taWhcuVFHvivkp+X5HqP
lkLEtKXQEVfF2Ak=
=m92X
-----END PGP SIGNATURE-----

--------------fQkLkeakaNyqS60iLBC7JGay--

