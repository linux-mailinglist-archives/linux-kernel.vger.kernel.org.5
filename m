Return-Path: <linux-kernel+bounces-124176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CC389136E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2DB1F22ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABA43D569;
	Fri, 29 Mar 2024 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VyOdHSFG"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154C63D0A4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 05:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711691638; cv=none; b=eGGBU846Gm+cMwWiH+ifI1j29FPfNVZU8jykjEz9rMUhscjqmjPdkLDv0oEtwIBQtdb2N9PXhHGZ9fxyUpfmHsBwkPSqSwY/n0bIa1vscznDan25zINscsKdkodhXSPAKB42g9c+aZmRaNVRwC5FfW+YjbY/NM3K4blTuM2xJgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711691638; c=relaxed/simple;
	bh=g2SnQTkcDJ4MHL5Cu1+rfTDJOSFbJDjPk0W0xUDtBKI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:In-Reply-To:
	 Content-Type:References; b=qKJRY6/CdXBkbUdk6UbH/1VI9V08ENoP7JEzeknanpa6VH7Z3ngMfUI5Gunj0SX3FI1M2alhrKdPWnd3+gCHekAAHnYptqye+Qwkj4C8WjnJ4ARfnyiw4+eOwW5qaL1aJ0lkWPtxbJPKFnG2oTXG3G8YtpoD8ABUgU5MSqKW9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VyOdHSFG; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240329055348epoutp02ccceb4ae62190b6abc45f826acb91ab6~BJnelDtwy2216522165epoutp02Q
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 05:53:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240329055348epoutp02ccceb4ae62190b6abc45f826acb91ab6~BJnelDtwy2216522165epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711691628;
	bh=PQUcA7QC3xHCPhhP5+dYZWwWhUzQV3dMsOt9Dcqdz4s=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=VyOdHSFGAb9tYw7AWiyJ1lE6o4HiixfSqoAL6soPNFDHSmw8J26DL8JabPakpvcd/
	 FQiTTHIa/aggv8ZDV1H8GtZHDxwlE1vM7pOkwHbHXCaf+7ooaf/5I8JLQaNTx4/SBO
	 El6mvSm11+SaN6K4dAdbrDLdjMZXwOexTUgTmnRI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240329055347epcas2p1fd2a6e7ac8451f541dc34651cd3bd209~BJndpBAsM2188521885epcas2p1L;
	Fri, 29 Mar 2024 05:53:47 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.102]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4V5V2f6mlqz4x9QH; Fri, 29 Mar
	2024 05:53:46 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	9C.8B.09673.A6756066; Fri, 29 Mar 2024 14:53:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240329055346epcas2p43987f15b85181ea5dafeb9c0883c224e~BJnclOo-q0505505055epcas2p4e;
	Fri, 29 Mar 2024 05:53:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240329055346epsmtrp215863283d5d0f39bb922a9814050280f~BJncjJ6pV0600906009epsmtrp2M;
	Fri, 29 Mar 2024 05:53:46 +0000 (GMT)
X-AuditID: b6c32a45-0aecca80000025c9-64-6606576a3469
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	40.96.08924.A6756066; Fri, 29 Mar 2024 14:53:46 +0900 (KST)
Received: from [10.229.18.66] (unknown [10.229.18.66]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240329055346epsmtip23c40f90f2bc7ab907c62bc1c9effd8d4~BJncSQ9ev1495514955epsmtip2o;
	Fri, 29 Mar 2024 05:53:46 +0000 (GMT)
Message-ID: <63355869-e679-7226-7719-36b62169db7e@samsung.com>
Date: Fri, 29 Mar 2024 14:53:36 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
	Thunderbird/102.11.0
From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: Re: [PATCH] spi: s3c64xx: Use DMA mode from fifo size
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
In-Reply-To: <CAPLW+4k4qh4ZYBufZoGbUZN0yxSE2X8bOdkEQVw1Zg9YUVpbug@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmhW5WOFuawZ5ZhhYP5m1js7j/tYPR
	YurDJ2wWe19vZbfY9Pgaq8XlXXPYLGac38dk0fjxJrvF8759TA6cHptWdbJ53Lm2h81j85J6
	j74tqxg9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
	8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeX
	WmJlaGBgZApUmJCdMXfjfaaCx7IVxxacZW5gXCHWxcjJISFgItGz4i9jFyMXh5DADkaJY28n
	MUE4nxglHm++wQLhfGOU2NLwgh2m5dGDOVAtexklXt54wgzhvGaUWHf5LDNIFa+AncTPSXNZ
	QWwWAVWJN393MkLEBSVOznzCAmKLCkRLtC67zwZiswloS3xfvxisXhiod+KOJ2D1IgJ6Eutm
	vmIHWcAssI5J4tnEq0wgCWYBcYlbT+aD2ZwCgRL3V56CistLNG+dDXaRhMBMDontLxtZIe52
	keje94ENwhaWeHV8C9Q/UhKf3+2FiudLtF05AxWvkdi44BIjhG0vsejMT6A4B9ACTYn1u/RB
	TAkBZYkjt1gg1vJJdBz+yw4R5pXoaBOCaFSTuD/1HNRwGYlJR1YyQdgeEi2NU5kmMCrOQgqV
	WUgem4XkmVkIexcwsqxiFEstKM5NTy02KjCEx3Zyfu4mRnBa1XLdwTj57Qe9Q4xMHIyHGCU4
	mJVEeHceZUkT4k1JrKxKLcqPLyrNSS0+xGgKjJuJzFKiyfnAxJ5XEm9oYmlgYmZmaG5kamCu
	JM57r3VuipBAemJJanZqakFqEUwfEwenVAPTrpa1uldXs004kfqvLdroaJTaxXeflK9eElzW
	mpmn8fYE+/Z8kUMrLOeFFR41qDnxdtXsqWv3SvoUxZ+5fL/j54Yfe7rTzFy+296T6A9k4st+
	rRbMln1SM43XJvrtQv0l4S4KLXVsex8r+bulTq6d/1e1+Ur1KwuV+4cO5i2Yc197/kvTP+1X
	s+Yd3eZaqbYxZMvptLUfox6dP5LXvdwlde/F7/qyy94HLvia8Wjh69lz/t/kyC7WdpdtWqoS
	NjvP2kuicp2Ab/DSmblCYod4jgZOaVl0zCAyp/Q4q1THVC/ruSXHslh3eMXLKvqvWTPNzXjT
	99D73ErybTHnNF58l8lvXu+1ynZtvvqd//ZPlViKMxINtZiLihMBmrbMTzQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJXjcrnC3N4OM6SYsH87axWdz/2sFo
	MfXhEzaLva+3sltsenyN1eLyrjlsFjPO72OyaPx4k93ied8+JgdOj02rOtk87lzbw+axeUm9
	R9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGXM3XifqeCxbMWxBWeZGxhXiHUxcnJICJhIPHow
	h7GLkYtDSGA3o8S/C8fYIRIyEsuf9bFB2MIS91uOsEIUvWSUePZ/OxNIglfATuLnpLmsIDaL
	gKrEm787GSHighInZz5hAbFFBaIlVn++AFbDJqAt8X39YjBbGKh34o4nYPUiAnoS62a+YgdZ
	wCywjkli5vJd7BDbbjBKLL76HuwMZgFxiVtP5oNt5hQIlLi/8hQTRNxMomtrFyOELS/RvHU2
	8wRGoVlIDpmFpH0WkpZZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjiYt
	zR2M21d90DvEyMTBeIhRgoNZSYR351GWNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK84i96U4QE
	0hNLUrNTUwtSi2CyTBycUg1MDXZeOzkvNvGwTvZMuc0nqGNb5CfEYvTnyjPhqHNfDiv7TJ6f
	z2owj7G00F5NbdfCFtanfr9KWpJfPL2Us3PmGqGcRZmxIa4akft5uP+r7M851jTF8WdNxMNX
	jHX69YXq06ckyjp0flxX/9/DU+245xrpAr3kWO7SbX6KFQkna5Zxp/QJXjxxtPptow73rqoS
	z/DWGQ07ussFJ+9lUNxXeK/++5Ff6SY75aeYBL5a2/T/RdT8Qo+k9KA5W18dmcS4LnwHA0MY
	N8sz68MN+eaLL0889Sf8t2+g7/xr6UXJwpP37Hki4h9R8E+C6Rvn6cRFfr4daalfSz5leMRu
	qZ1/s6ChQvnwShHOR38LViixFGckGmoxFxUnAgBJSJplFQMAAA==
X-CMS-MailID: 20240329055346epcas2p43987f15b85181ea5dafeb9c0883c224e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240327033501epcas2p2bbe21301da5584f7f3a073c51a363c00
References: <CGME20240327033501epcas2p2bbe21301da5584f7f3a073c51a363c00@epcas2p2.samsung.com>
	<20240327033041.83625-1-jaewon02.kim@samsung.com>
	<CAPLW+4k4qh4ZYBufZoGbUZN0yxSE2X8bOdkEQVw1Zg9YUVpbug@mail.gmail.com>

Hi Sam,

Thanks for your review.


On 3/29/24 02:58, Sam Protsenko wrote:
> On Tue, Mar 26, 2024 at 10:35 PM Jaewon Kim<jaewon02.kim@samsung.com>  wrote:
>> The SPI data size is smaller than FIFO, it operates in PIO mode,
> Spelling: "The" -> "If the"

Thanks, I will fix it v2.

>> and if it is larger than FIFO mode, DMA mode is selected.
>>
>> If the data size is the same as the FIFO size, it operates in PIO mode
>> and data is separated into two transfer. In order to prevent,
> Nit: "transfer" -> "transfers", "prevent" -> "prevent it"

Thanks, I will fix it v2.

>> DMA mode must be used from the case of FIFO and data size.
>>
> You probably mean this code (it occurs two times in the driver):
>
>      xfer->len = fifo_len - 1;
>
> Can you please elaborate on why it's done this way? Why can't we just
> do "xfer->len = fifo_len" and use the whole FIFO for the transfer
> instead? I don't understand the necessity to split the transfer into
> two chunks if its size is of FIFO length -- wouldn't it fit into FIFO
> in that case? (I'm pretty sure this change is correct, just want to
> understand how exactly it works).

In IRQ mode(S3C64XX_SPI_MODE_RX_RDY_LVL enable), TxOverrun/RxUnderrun 
irq occurs when FIFO is full.

To avoid FIFO full, it is transmitted in a smaller size than 
fifo_len.(fifo-len - 1)

However, in case of "fifo_len == data size" "fifo_len - 1" byte + "1" 
byte were transmitted separately.

This problem can be solved by starting DMA transmission start size from 
fifo_len.

>> Fixes: 1ee806718d5e ("spi: s3c64xx: support interrupt based pio mode")
> Just wonder if that fixes some throughput regression, or something
> worse (like failed transfers when the transfer size is the same as
> FIFO size)?

It is not a critical issue, but When I look at the actual waveform, it 
seems strange that only the last 1-byte is transmitted separately.

I thought it was "Fixes", but if not, I will remove it.

>> Signed-off-by: Jaewon Kim<jaewon02.kim@samsung.com>
>> ---
>>   drivers/spi/spi-s3c64xx.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 9fcbe040cb2f..81ed5fddf83e 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -430,7 +430,7 @@ static bool s3c64xx_spi_can_dma(struct spi_controller *host,
>>          struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
>>
>>          if (sdd->rx_dma.ch && sdd->tx_dma.ch)
>> -               return xfer->len > sdd->fifo_depth;
>> +               return xfer->len >= sdd->fifo_depth;
>>
>>          return false;
>>   }
>> @@ -826,11 +826,11 @@ static int s3c64xx_spi_transfer_one(struct spi_controller *host,
>>                          return status;
>>          }
>>
>> -       if (!is_polling(sdd) && (xfer->len > fifo_len) &&
>> +       if (!is_polling(sdd) && xfer->len >= fifo_len &&
>>              sdd->rx_dma.ch && sdd->tx_dma.ch) {
>>                  use_dma = 1;
>>
> Would be nice to remove this empty line, while at it.
Good, I will remove it also.
>> -       } else if (xfer->len >= fifo_len) {
>> +       } else if (xfer->len > fifo_len) {
> Below in the same function I can see similar code:
>
>              if (target_len >= fifo_len)
>                  xfer->len = fifo_len - 1;
>
> Shouldn't that 'if' condition be fixed too? Or it's ok as it is? (Just
> noticed it by searching, not sure myself, hence asking).

You are correct. This 'if' condition should not have been modified.

>>                  tx_buf = xfer->tx_buf;
>>                  rx_buf = xfer->rx_buf;
>>                  origin_len = xfer->len;
>> --
>> 2.43.2
>>
>>

Thanks

Jaewon Kim


