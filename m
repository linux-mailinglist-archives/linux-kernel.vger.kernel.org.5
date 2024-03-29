Return-Path: <linux-kernel+bounces-124308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DF2891566
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBBBBB22E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6683A1B6;
	Fri, 29 Mar 2024 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EZjegaAL"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F52C6AA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703356; cv=none; b=bVeXRnKSmiF9Sm2lezk9ScejkvQokHHu+4WQdnrVN5rZo0Ku23MyGVhs1IFm+w2Me9S40ti3T21FBhzmuEgDIfxyNoZ1BD4rpK7yVMEYXtNw/hqLnJqthNo7gj2ybjbFffypDyrsT7hJvE+2w8AY67FyeiAHzxX50HnvofQqm8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703356; c=relaxed/simple;
	bh=DguSPtcJAc5oXMw9WnXpCdxEanZNGF8uP8ucunTkLcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=lcp1oLaP/47Y9d2Fcs0bpRzLDcbJlpD4gADQfXmHfHylvXAx2wpU9NKhfNsMhC7miZ3Qt8tlQVpak1Ea8bY49SICeShRTb6tHij+2o4MnBTh/E3EOqp2Ebr6PuJPvxBn2GYQx5m6+Vjx1ENqM43/MdEQ+ZhYrVU+91d9PzbMwwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EZjegaAL; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240329090911epoutp0281477ac051c4ba7aafdd41d0f48c7f33~BMSEuoTo62732527325epoutp02M
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:09:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240329090911epoutp0281477ac051c4ba7aafdd41d0f48c7f33~BMSEuoTo62732527325epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711703352;
	bh=msVeALGB2MwJhW98PbV1MDBvX3BIhhy8ROse0PFtqLk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=EZjegaALOdgjIkjY7USWOtxnNZj16Gd9Xb5QPuK0Xs1SjrRN/mqyEegfTE3VQLGAz
	 Nz5Q39tGwYbmK/aAusQHdHI+y/GC317htRHso9RGwtANMJfvP1hk6pICsb8t8BGYQB
	 39cuC8jDTwiF5+pto+irwl57KhP2rNGk5pVbNeZs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240329090911epcas2p12ec814e535d194383ee2c35140e72681~BMSEgybdl2935429354epcas2p1C;
	Fri, 29 Mar 2024 09:09:11 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4V5ZN708T2z4x9Q8; Fri, 29 Mar
	2024 09:09:11 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	B7.42.09639.63586066; Fri, 29 Mar 2024 18:09:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20240329090910epcas2p2617aec2724c76180d02e80c9ab5e18d3~BMSDVHlp01080110801epcas2p2O;
	Fri, 29 Mar 2024 09:09:10 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240329090910epsmtrp2c1c334f13c44c8188388377b5977bcc1~BMSDUYQw60038100381epsmtrp2P;
	Fri, 29 Mar 2024 09:09:10 +0000 (GMT)
X-AuditID: b6c32a46-681ff700000025a7-6b-660685366d29
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	99.41.07541.63586066; Fri, 29 Mar 2024 18:09:10 +0900 (KST)
Received: from [10.229.18.66] (unknown [10.229.18.66]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240329090910epsmtip289a971388fb7c6521ebd55792e32b1f4~BMSDB2NTo1295712957epsmtip2u;
	Fri, 29 Mar 2024 09:09:10 +0000 (GMT)
Message-ID: <ac9d6afe-fd09-4311-d90c-d9caddd1b79b@samsung.com>
Date: Fri, 29 Mar 2024 18:09:00 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
	Thunderbird/102.11.0
Subject: Re: [PATCH] spi: s3c64xx: Use DMA mode from fifo size
Content-Language: en-US
To: Andi Shyti <andi.shyti@kernel.org>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>
Cc: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <20240329085840.65856-1-jaewon02.kim@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmua5ZK1uawctDVhYP5m1js7j/tYPR
	YurDJ2wWe19vZbfY9Pgaq8XlXXPYLGac38dk0fjxJrvF8759TA6cHptWdbJ53Lm2h81j85J6
	j74tqxg9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
	8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeX
	WmJlaGBgZApUmJCdsWPWD+aCBXwVhw7tZGxgXM3dxcjJISFgItF66jNLFyMXh5DADkaJu8d3
	s0E4nxglTvw8zwThfGOUOLN+ESNMy6f53cwQib2MEu9+7YTqf80oMfvQEVaQKl4BO4kJr26y
	gdgsAqoS39/fZ4KIC0qcnPmEBcQWFYiWaF12H6xGGKh+4o4nYBuYBcQlbj2ZD7ZaROAKo8SK
	b6vB1jELtDFKPGw7DlbFJqAt8X39YrBtnEDdZxfdYoHolpdo3jobrEFCYCaHxMHXh6AOd5G4
	sn8tK4QtLPHq+BZ2CFtK4vO7vWwQdr5E25UzUPEaiY0LLkH12kssOvMTKM4BtEBTYv0ufRBT
	QkBZ4gjMWj6JjsN/2SHCvBIdbUIQjWoS96eegxouIzHpyEomiBIPiderwyYwKs5CCpVZSL6f
	heSXWQhrFzCyrGIUSy0ozk1PLTYqMILHdnJ+7iZGcFrVctvBOOXtB71DjEwcjIcYJTiYlUR4
	dx5lSRPiTUmsrEotyo8vKs1JLT7EaAqMm4nMUqLJ+cDEnlcSb2hiaWBiZmZobmRqYK4kznuv
	dW6KkEB6YklqdmpqQWoRTB8TB6dUA9PZkitdtS0rEz+1qHa0yrCkS7RLhm2eYzZvf9LJRdLL
	JjNaLu9eH6AYteHkUVfG0A39+2ee8pvlU144+1lc0Rv9UzbbJvIGLWG8eobpgVLIs3vLbzYJ
	KLPpT2T23vzujD2DYpJevsaOWVe7vy97nBowT1XBS5nxxvszWeU+T4IiRaWM73MtdjJ95HG0
	ePKFPJ1Fog6i/CYbQvfcvO38c7Fc0MNzUvuDmF4vu993RN6hZ5Wb5/Gnvvs2bjpd1W+70iD5
	KvuKypufpgqmRl67zFlq6rmGtzwycP0Uu4tHt+/buG+pa7uKTyK/Wtc0a/vDLUmM3XPWHN5w
	vnzar+Nbd/PyLg85ytmqzGTOIau6gE+JpTgj0VCLuag4EQBuAWsRNAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJXteslS3NYMtJIYsH87axWdz/2sFo
	MfXhEzaLva+3sltsenyN1eLyrjlsFjPO72OyaPx4k93ied8+JgdOj02rOtk87lzbw+axeUm9
	R9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGXsmPWDuWABX8WhQzsZGxhXc3cxcnJICJhIfJrf
	zdzFyMUhJLCbUeLS5O2sEAkZieXP+tggbGGJ+y1HWCGKXjJKHDtziQUkwStgJzHh1U2wIhYB
	VYnv7+8zQcQFJU7OfAJWIyoQLbH68wWwocJA9RN3PGEEsZkFxCVuPZnPBDJUROAao8TaOefB
	zmAWaGOU+LHnOxPEuomMEt/PfgVbwSagLfF9/WKwUZxAo84uusUCMcpMomtrF9RYeYnmrbOZ
	JzAKzUJyySwkG2chaZmFpGUBI8sqRsnUguLc9NxkwwLDvNRyveLE3OLSvHS95PzcTYzgeNLS
	2MF4b/4/vUOMTByMhxglOJiVRHh3HmVJE+JNSaysSi3Kjy8qzUktPsQozcGiJM5rOGN2ipBA
	emJJanZqakFqEUyWiYNTqoHJnvFW+9WpOvOOqO5PNV3qfyt2jtByl+3n10e++x/Q2XFar89A
	QopHKGOBv3vIqh8nT7zaHLxi5Xo7cZfM+wKsZauypHWn3vxSsElm0ebOj+b/o/1nux6Lm6Ay
	4VJ4OPfjNa8PSKu77jq3q/jiFP66EOOwlcdnL0q+epzp3LfgPfN+/LxZZ7tC32SmZoCGp1P0
	FbHuWNZPvz6o796WqHQl5eSF9vm3V7ycqfn8w8ndh9dfZD13XfHFx+rU0kqGqqzrN8q+6Z2Z
	erZR5JnlnW9hMlZ/eebnlM4zDAh1z+UO4N+1dc9kphlM9ou39fM1l5pcP155NOLKIZ+TbcYt
	YdPZX+6JyFWa7DZlwcxcdqu4Y0osxRmJhlrMRcWJAK1zTfEWAwAA
X-CMS-MailID: 20240329090910epcas2p2617aec2724c76180d02e80c9ab5e18d3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240329090313epcas2p2cf95d22e44b6b1c120021622da68aeb8
References: <CGME20240329090313epcas2p2cf95d22e44b6b1c120021622da68aeb8@epcas2p2.samsung.com>
	<20240329085840.65856-1-jaewon02.kim@samsung.com>


On 3/29/24 17:58, Jaewon Kim wrote:
> If the SPI data size is smaller than FIFO, it operates in PIO mode,
> and if it is larger than FIFO size, it oerates in DMA mode.
>
> If the SPI data size is equal to fifo, it operates in PIO mode and it is
> separated to 2 transfers. To prevent it, it must operate in DMA mode
> from the case where the data size and the fifo size are the same.
>
> Fixes: 1ee806718d5e ("spi: s3c64xx: support interrupt based pio mode")
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>   drivers/spi/spi-s3c64xx.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 9fcbe040cb2f..f726d8670428 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -430,7 +430,7 @@ static bool s3c64xx_spi_can_dma(struct spi_controller *host,
>   	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
>   
>   	if (sdd->rx_dma.ch && sdd->tx_dma.ch)
> -		return xfer->len > sdd->fifo_depth;
> +		return xfer->len >= sdd->fifo_depth;
>   
>   	return false;
>   }
> @@ -826,10 +826,9 @@ static int s3c64xx_spi_transfer_one(struct spi_controller *host,
>   			return status;
>   	}
>   
> -	if (!is_polling(sdd) && (xfer->len > fifo_len) &&
> +	if (!is_polling(sdd) && xfer->len >= fifo_len &&
>   	    sdd->rx_dma.ch && sdd->tx_dma.ch) {
>   		use_dma = 1;
> -
>   	} else if (xfer->len >= fifo_len) {
>   		tx_buf = xfer->tx_buf;
>   		rx_buf = xfer->rx_buf;


Sorry, I didn't add v2 by mistake.

This is v1 mail thread.

  - 
https://lore.kernel.org/linux-arm-kernel/CAPLW+4k4qh4ZYBufZoGbUZN0yxSE2X8bOdkEQVw1Zg9YUVpbug@mail.gmail.com/T/


Thanks

Jaewon Kim


