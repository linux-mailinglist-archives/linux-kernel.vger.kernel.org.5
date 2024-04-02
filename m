Return-Path: <linux-kernel+bounces-128552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F04895C55
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB49280C2B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED5D15B98B;
	Tue,  2 Apr 2024 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="1cQ1X5a9"
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20E12C9D;
	Tue,  2 Apr 2024 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085373; cv=none; b=lmH21WdVLTXHZr4pdPdB02FQtLfE3sdBc4KBqlM77ZfgWfXr8qr72KkCXzyEGcQp9T0Y2EkxNnJ4sFes6c8Le3otvDAQ90V4nolzCqtQlP3l9mZGyUxi8lAORnyQrm7+LofV6MgWsDBXsydSZp5DbsHpJ9eQoyomrPn9wj66aqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085373; c=relaxed/simple;
	bh=9JIPjNr0peSxZTcP+6cQZbMtmxMOiiyJXzs2wV8FEds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uk0QIBZzwzaaG+3EwFxoyRy7xp2kC0TOn/xytMQaXKusPrRFPc1HympfxPRXr1hA7/7jeLz1lyFiZTVD+CQxtEfZdjWQbPnHp5Ypwj59W6zI2wFiFoQucrj/kZoEozoIrA6dEo30wP/UNECHgvaml7JYVmnhJ5uyQzC2j7yGE84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=1cQ1X5a9; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1712084798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8YOkmEuC9pUsK+tk/6J60XipwO318aL0a2KtV/Z5R7c=;
	b=1cQ1X5a9FEnn7pUky3k2RC1MLWAVUsKjHvXV+ap0gIexfmavkuZDqhuJ1HK0vnBpvWmjhB
	GwucBct323m5dXolJ/m+ZkFKfFNvdKgC/Laa7Zj59EKZWfHYEmnVuO7JS+isgTu2Xf0pWS
	oABPA6SEHeL4iEo/8WK4zGw1cJ+c8Vk=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Erick Archer <erick.archer@outlook.com>
Cc: Erick Archer <erick.archer@outlook.com>, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] batman-adv: Add flex array to struct batadv_tvlv_tt_data
Date: Tue, 02 Apr 2024 21:06:35 +0200
Message-ID: <5466543.Sb9uPGUboI@sven-l14>
In-Reply-To:
 <AS8PR02MB7237987BF9DFCA030B330F658B3E2@AS8PR02MB7237.eurprd02.prod.outlook.com>
References:
 <AS8PR02MB7237987BF9DFCA030B330F658B3E2@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1984222.yKVeVyVuyW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart1984222.yKVeVyVuyW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 02 Apr 2024 21:06:35 +0200
Message-ID: <5466543.Sb9uPGUboI@sven-l14>
MIME-Version: 1.0

On Tuesday, 2 April 2024 19:23:01 CEST Erick Archer wrote:
> The "struct batadv_tvlv_tt_data" uses a dynamically sized set of
> trailing elements. Specifically, it uses an array of structures of type
> "batadv_tvlv_tt_vlan_data". So, use the preferred way in the kernel
> declaring a flexible array [1].
> 
> The order in which the structure batadv_tvlv_tt_data and the structure
> batadv_tvlv_tt_vlan_data are defined must be swap to avoid an incomplete
> type error.
> 
> Also, avoid the open-coded arithmetic in memory allocator functions [2]
> using the "struct_size" macro and use the "flex_array_size" helper to
> clarify some calculations, when possible.
> 
> Moreover, the new structure member also allow us to avoid the open-coded
> arithmetic on pointers in some situations. Take advantage of this.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

> ---
> Hi,
> 
> I would like to add the "__counted_by(num_vlan)" tag to the new flex member
> but I don't know if this line can affect it.
> 
> ntohs(tt_data->num_vlan)


Yes, num_vlan is a __be16. I could only identify the kernel-doc related 
scripts as consumer. But maybe they are more - so I would defer this question 
to kernel-hardening.


And with this change, I get a lot of additional warnings (-Wsparse-all)


cfg: BLA=n DAT=y DEBUG=y TRACING=n NC=y MCAST=n BATMAN_V=n
    net/batman-adv/translation-table.c:574:21: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:859:25: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:859:25: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:938:25: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:938:25: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:2932:16: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:2932:16: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:3378:21: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:3378:21: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:3982:30: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:3986:27: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:4026:30: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:4030:27: warning: using sizeof on a flexible structure
    net/batman-adv/translation-table.c:4032:23: warning: cast from restricted __be16
    net/batman-adv/translation-table.c:4032:23: warning: restricted __be16 degrades to integer
    net/batman-adv/translation-table.c:4032:23: warning: incorrect type in argument 1 (different base types)
    net/batman-adv/translation-table.c:4032:23:    expected unsigned long [usertype] factor1
    net/batman-adv/translation-table.c:4032:23:    got restricted __be16 [usertype] num_vlan

[...]
>  	num_vlan = ntohs(tt_data->num_vlan);
>  
> -	if (tvlv_value_len < sizeof(*tt_vlan) * num_vlan)
> +	flex_size = flex_array_size(tt_data, vlan_data, num_vlan);
> +	if (tvlv_value_len < flex_size)
>  		return;

This helper would need an #include of <linux/overflow.h> in 
net/batman-adv/translation-table.c

[....]
>  /**
> @@ -4039,8 +4029,7 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
>  	tt_data = tvlv_value;
>  	tvlv_value_len -= sizeof(*tt_data);
>  
> -	tt_vlan_len = sizeof(struct batadv_tvlv_tt_vlan_data);
> -	tt_vlan_len *= ntohs(tt_data->num_vlan);
> +	tt_vlan_len = flex_array_size(tt_data, vlan_data, tt_data->num_vlan);

This is definitely wrong on little endian systems. You first need to convert 
num_vlan from network (big endian) to host order.

Kind regards,
	Sven

--nextPart1984222.yKVeVyVuyW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmYMVzsACgkQXYcKB8Em
e0aCQBAAj3anzJhaGazYsoqA2U/5qDV64DoNdrlYz34rT3lYX3DTJKcA11cuSvN+
aDVUaOi8G7Gn4sE+Ql8FGsBmXoCMvwyLJ/eQ6mrr1MGSWLodaZbvmjRxwPRzFbou
wAK5ZE25usWliJxf2ds7gpSjm6TBFnsNIRAtQ2zz7b8dAhXOe79ASRsrl0P9QBiE
fM8QeT6hB0gLY5RXmsugrRUfCpqQOfTS44b9siyICMN+mKbRG7GpDj4Ruf/6koNo
Qy1Unmm+qhyuPUtoYBASGVzC/Gm3pDh7UXuiptY0vgU/o0yjyTHi683cFBtmD30V
d+pNZDCa2YS0+j0N8Nh/oS3fOWb36I/eKiEaCdmgx9awQ4dO3CxZE5TsLeohNNUO
OpTdwucSLW8gEo+r+BQI0G2y3+TPCtGv8vLRIXF1frSWjE7EPbXH3BjbcvoDaaYO
uO1a7tyAAbZ4zZO9wO6qIcRjz1q3E0V8Dx9LRolzC5EA4IvnNa+WQ7OZdTGe8zu3
GRlIYG/sedhar8Wla+bh8wi8oeInErE4k4pDFI6o1AS5GHTcpTR7Plp/vpnrAEPF
LAjEHTQT1LOIRLIrzvGBWC/KNnjXd3q2TluOKRBxsNYAnn+nHL3aBmYSp8gCOg9g
Sta4U5Vrs2QpAT3mk8CoAhQSujqZaOkM+fy63PcaWrhCMDh9mGo=
=CYsH
-----END PGP SIGNATURE-----

--nextPart1984222.yKVeVyVuyW--




