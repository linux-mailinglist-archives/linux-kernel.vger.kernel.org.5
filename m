Return-Path: <linux-kernel+bounces-91690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D667C871527
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061821C215D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C21945972;
	Tue,  5 Mar 2024 05:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="S3pAkncL"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645091805E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709615314; cv=none; b=H9waV/pYU9CNxRnSSHBNw7ZmHcQecMkP+822QzJaPXt6UKwN5yKK3chal/V6KGWhvTi2Jp9YNmCgVyFVbje4hVBhBuaP/rgbiksmserQTevm9VSFzVD0XwNawbQNm7h6jRVGhBnmlntE/8v4QQN/FEvExgddqN+EDFkebdpLZEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709615314; c=relaxed/simple;
	bh=ismEow/yzrkwwhiLcdfA0vL6WXF7q6z+dwtQGVXyiYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=FoxNy52aTsf+w3zL5pMweKjD7NNHHP3skZ2hWLZVW1VQrL4J03YmMHsj+tzMkkHGss/Aa/FCrEOngStRmbMkqaWI7/mfzpfC++wkxyJDfXh07x16KDckeXNWVtDOAf50R0oVzVMzSDAGYZCYUYxGJKB6pW6OH3i1yhTGrcTlKf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=S3pAkncL; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240305050828epoutp01be79766520e36584f707530e6c49c0ce~5xhC5E9ch3166731667epoutp01O
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 05:08:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240305050828epoutp01be79766520e36584f707530e6c49c0ce~5xhC5E9ch3166731667epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709615308;
	bh=7wgZcV4LIo7eZvvgGuVKjwfreOjSKEa/3J0B5NMANQ8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=S3pAkncLzX8LUhzUr3/Ce5YgzG802THvtWHLxyz+IsFYmbGpgfP3dPjohdUZMmz0A
	 ZXXM8GxgQvDgG7KKXBs/EgH/o79FnmhPLeF9Xf8Y06nDwpgVER9pXI2nl0eKk3BSPc
	 gOOnoiSAonyOJLmhmNfkuwGBZmcmU25fQu5faxo8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240305050828epcas2p2ac3a6297d2e062a8bea5d14784543827~5xhCgb0An2205322053epcas2p2L;
	Tue,  5 Mar 2024 05:08:28 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.100]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Tpk9R3vhrz4x9QD; Tue,  5 Mar
	2024 05:08:27 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	D3.A2.08648.BC8A6E56; Tue,  5 Mar 2024 14:08:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20240305050826epcas2p31f42fc40cecab0edc574ed7f57828e61~5xhBQLOAu0243002430epcas2p3_;
	Tue,  5 Mar 2024 05:08:26 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240305050826epsmtrp118557d5f7c0a2ef9936664afb357e53c~5xhBPRF_C0656106561epsmtrp1e;
	Tue,  5 Mar 2024 05:08:26 +0000 (GMT)
X-AuditID: b6c32a43-721fd700000021c8-2f-65e6a8cb384c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	60.74.08817.AC8A6E56; Tue,  5 Mar 2024 14:08:26 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240305050826epsmtip2bf1362dc7ebf93b71fea7ea1c5b9979e~5xhA6dbvN1460914609epsmtip2v;
	Tue,  5 Mar 2024 05:08:26 +0000 (GMT)
Message-ID: <cbbeec8c-45c7-0f62-8947-90511fdc1f25@samsung.com>
Date: Tue, 5 Mar 2024 14:08:19 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
	Thunderbird/102.11.0
Subject: Re: [PATCH] spi: dt-bindings: samsung: make dma properties not
 required
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>,
	Sam Protsenko <semen.protsenko@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, andi.shyti@kernel.org,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org,
	peter.griffin@linaro.org, willmcvicker@google.com, kernel-team@android.com
Content-Language: en-US
From: Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <0852a6bc-315c-49e2-84fe-7dadca71df3d@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmhe7pFc9SDb5OELe4/7WD0WLLq80s
	FlMfPmGzWLP3HJPF/CPnWC12bBex6HvxkNni8q45bBYzzu9jsmj8eJPdYsOMfywW//fsYLd4
	3gcU+3QrzmLVp/+MDvwe23ZvY/VYsKnUY9OqTjaPO9f2sHl83iQXwBqVbZORmpiSWqSQmpec
	n5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdKuSQlliTilQKCCxuFhJ386m
	KL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvjy4STjAX7FCqePP3P
	3MD4RbKLkZNDQsBE4tK7RexdjFwcQgI7GCX+LF3JBpIQEvjEKLFraj6E/Y1RYsO0ZJiGiZPO
	QTXsZZToffMbynnNKLG4cRYLSBWvgJ1E26QnTCA2i4CKxKafn9gg4oISJ2c+AasRFYiWaF12
	HyjOwSEsECTx6agRSFhEoFJiwcftYDOZBT4wSey5vZIVJMEsIC5x68l8sJlsAtoS39cvBotz
	Au06cucOG0SNvETz1tnMIM0SAkc4JCY0XANbICHgItH5yxXiA2GJV8e3sEPYUhIv+9ug7HyJ
	titnoOwaiY0LLjFC2PYSi878ZAcZwyygKbF+lz7ERGWJI7dYILbySXQc/ssOEeaV6GgTgmhU
	k7g/9RwbhC0jMenISiYI20Ni+YO77BMYFWchhcksJD/OQvLLLIS9CxhZVjGKpRYU56anJhsV
	GMJjOjk/dxMjOA1rOe9gvDL/n94hRiYOxkOMEhzMSiK8Nb+epArxpiRWVqUW5ccXleakFh9i
	NAXGzERmKdHkfGAmyCuJNzSxNDAxMzM0NzI1MFcS573XOjdFSCA9sSQ1OzW1ILUIpo+Jg1Oq
	gSnkz9sKCYur+/cmVr1YvvahcmOa26Ib25oXNdw7n74pWXbWlFAF5XVxLR+c34UHrVP4pyWp
	9z9uXqfWCjY3wXVyS5Yn+PBOuMXY5qM0nXehxrMtS7sMzadb7VpvuEnb2zyc8UqDxdWwS1te
	hS6xuiW7Q/U9V/uyysWJ/IueBBZzWgf8q+fIUF10x5dB27K/v9ZuWp/ZDZmNs+zWS7skvmPk
	yNcQ/3JQ4aQ+z5enycp58xYkTbbvenqVR+V85Qa+BXKCt07xbK8Qnrhu0757r5Ma6wOyOxb/
	CFg238Mwy5hp15JJBo4rbGZ8PpDsWWMRKnpj/r+ba29OqHy8dJay5uGZZ1/0iM1+eEL4mQvv
	gTtKLMUZiYZazEXFiQDNrvY+TAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSvO6pFc9SDV6dMrK4/7WD0WLLq80s
	FlMfPmGzWLP3HJPF/CPnWC12bBex6HvxkNni8q45bBYzzu9jsmj8eJPdYsOMfywW//fsYLd4
	3gcU+3QrzmLVp/+MDvwe23ZvY/VYsKnUY9OqTjaPO9f2sHl83iQXwBrFZZOSmpNZllqkb5fA
	lfFlwknGgn0KFU+e/mduYPwi2cXIySEhYCIxcdI5dhBbSGA3o0TbugyIuIzE8md9bBC2sMT9
	liOsEDUvGSX61+SB2LwCdhJtk54wgdgsAioSm35+YoOIC0qcnPmEBcQWFYiWWP35AlAvB4ew
	QJDEp6NGIGERgUqJrTM3ArVycTALfGCSOHJtPQuIIyTwhlli5dP7YMuYBcQlbj2ZD7aATUBb
	4vv6xWBxTqDFR+7cYYOoMZPo2trFCGHLSzRvnc08gVFoFpI7ZiEZNQtJyywkLQsYWVYxSqYW
	FOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgTHn5bWDsY9qz7oHWJk4mA8xCjBwawkwlvz60mq
	EG9KYmVValF+fFFpTmrxIUZpDhYlcd5vr3tThATSE0tSs1NTC1KLYLJMHJxSDUwp88PThGfK
	33/k21avV199v/LfLqcHV3euyxFbf1ZStfa0qvsjm/23Pxg+NHzGo9RvGKhx+8XpOQLdbRuO
	NrCmLjqVuW7S2otcS2/1d0reqEwN2DTT5s8F0ah1z/bzbPrNPZGJY16X1W6nfTZTGxZWXFj9
	ruLp1c47kQzrr3n+Slu/99Xeb3LneuWTb05Q8a2ziymYELdPPZBld45OokfRwxjzNZasH/9O
	LO40mVJsL8SsfEokUIXFdUrh0VxhZRHRCZu8ZgXtYX4Yk+a9Q3Z6rN7Z0OmBS3UvPexYebJf
	/L+QX7FF+4PrCXMWmve3nPb5/1ZSclHm1O+3J92MP78+0SMywUZyd9OvrIvXH3kqsRRnJBpq
	MRcVJwIARxyr/y4DAAA=
X-CMS-MailID: 20240305050826epcas2p31f42fc40cecab0edc574ed7f57828e61
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240304181554epcas2p19ce81f9801d4704862e76f785980213e
References: <20240301115546.2266676-1-tudor.ambarus@linaro.org>
	<CAPLW+4=6oYcs0NPXo4ffLiCvtNQ-tY1s_isaxTX8dcPkV56xMw@mail.gmail.com>
	<cb426fb0-2f27-4c9b-89f5-7139354ea425@sirena.org.uk>
	<f06328e4-b283-4302-b9c1-6473aa3cfa25@linaro.org>
	<CAPLW+4kjXK=EWx__h0bX0rJMrL33E=t4YDzSOfObmvtG9aS+jg@mail.gmail.com>
	<20240304165635.GA739022-robh@kernel.org>
	<CGME20240304181554epcas2p19ce81f9801d4704862e76f785980213e@epcas2p1.samsung.com>
	<0852a6bc-315c-49e2-84fe-7dadca71df3d@linaro.org>

Hello all,


On 24. 3. 5. 03:15, Tudor Ambarus wrote:
> Hi, Rob,
>
> On 3/4/24 16:56, Rob Herring wrote:
>> On Sat, Mar 02, 2024 at 10:23:16AM -0600, Sam Protsenko wrote:
>>> On Sat, Mar 2, 2024 at 3:36 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>>>
>>>>
>>>> On 01.03.2024 22:42, Mark Brown wrote:
>>>>> On Fri, Mar 01, 2024 at 01:28:35PM -0600, Sam Protsenko wrote:
>>>>>> On Fri, Mar 1, 2024 at 5:55 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>>>>>> Since the addition of the driver in 2009, the driver selects between DMA
>>>>>>> and polling mode depending on the transfer length - DMA mode for
>>>>>>> transfers bigger than the FIFO depth, polling mode otherwise. All
>>>>>>> versions of the IP support polling mode, make the dma properties not
>>>>>>> required.
>>>>>> AFAIU, the device tree has nothing to do with drivers, it's about
>>>>>> hardware description. Does making DMA properties not required here
>>>> correct
>>>>
>>>>>> mean that there are some HW out there which doesn't integrate DMA in
>>>> no, to me it means that the IP can work without DMA, only in PIO mode,
>>>> regardless if DMA is integrated or not. Not required means that the
>>>> property is not mandatory, which is what I'm trying to achieve here.
>>>>
>>>>>> SPI blocks? Even if this change is ok (I'm not sure), the
>>>>>> argumentation doesn't look sound to me.
>>>> switching to PIO mode in the driver for sizes smaller than FIFO depths
>>>> in the driver guarantees that all existing compatibles support PIO mode.
>>>>
>>>> Are you saying that if there is a physical line between an IP and DMA
>>>> controller, then the DMA properties must always be specified in dt? I
>>>> thought they can be marked as optional in this case, and that's what I
>>>> did with this patch.
>>>>
>>> No, I would wait for maintainers to clarify on that bit. Change itself
>>> can be ok. But the commit message shouldn't mention the driver,
>>> because the driver uses (depends on) device tree, not vice versa. The
>>> device tree can be used in other projects as well (like U-Boot and
>>> OP-TEE), so it should be designed to be universal and not depend on
>>> kernel drivers. The commit message should be based on particular HW
>>> layout features and how the patch makes the bindings describe that HW
>>> better. It shouldn't rely on driver implementations.
>> If the controller is DMA capable then it should have dma properties. The
> should have as in required/mandatory?
>
>> compatible should be enough to tell if it is a case of 'can only work
> yes, I agree
>
>> with DMA'. Otherwise, it is going to be up to a specific user. Even
>> within Linux, you may have a serial port that doesn't use DMA for the
>> console, but uses it for the tty or serdev.
>>
>> Of course, if a new device is added without DMA properties and they
>> are added later on, then they are going to be optional even though the
>> DMA support is always there. I can't fully understand everyone's h/w.
>>
> The SPI controller that I'm working with has a dedicated channel to the
> DMA controller. It can work without DMA too, just by polling registers
> or by interrupts.
>
> I can't get the DMA controller to work correctly yet, and since the SPI
> controller can work without DMA, I thought that I can mark the DMA
> properties as optional, add the SPI node in dt without DMA, and add the
> DMA properties later on, after I have the DMA controller working
> correctly. Is this approach wrong?
>
> Thanks,
> ta
>
>

I agree with this patch.

I don`t think DMA property needs to be "required" because it can operate 
well without DMA property.


Last year, I put a patch that makes dma property optional.

  - d1a7718ee8db (spi: s3c64xx: change polling mode to optional)

- https://lore.kernel.org/r/20230502062813.112434-2-jaewon02.kim@samsung.com


In the past, there was SoC without DMA, so it was a quirk that used 
polling mode.

Now, I want to change this to be optional to support cases where DMA is 
not available according to OS environment(Virtual Machine).


Thanks

Jaewon Kim


