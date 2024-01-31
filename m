Return-Path: <linux-kernel+bounces-45814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF83C843690
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20DE71C26B27
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CBF3EA68;
	Wed, 31 Jan 2024 06:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g92sfM9Y"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFC53E485
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682126; cv=none; b=B6pUDjQbbFloLOdhfdhpmIF5B40D/1+av/SU/LugrfOtaeB12i4U3MgNXpDNKfHBXmaL+7FmbStgdzQi8T6F0u4SdJsZHOiWDW+9w1O0TGeGING2BItckkmCQPkQRmM/lDeVh3HJGent2INrHI6yUPdW0VSnncONmMFusxXVFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682126; c=relaxed/simple;
	bh=u1F+OL/6PYNx+FVYO52mlMno0kijyr/ditkmdFoW+R8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=I9MPjx699PKLf0ztIWnVJyVMa08Yb48fNURuITSSJoNC7R2zzV2qbvjtJpTMSIHsZOZC84TCxEvNgvGtdBb32i89kO7lWGkc/SHiGN9W2dgKOv4jih+K/arHOA0wHoYO1BTyMO6nlo4NPSeeaVQjJ79k/V2nPCVs7E7t/CEbJQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=g92sfM9Y; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240131062200epoutp03f0225699b618b39089ba7ac577745ed1~vWliv-tfM3121631216epoutp03j
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:22:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240131062200epoutp03f0225699b618b39089ba7ac577745ed1~vWliv-tfM3121631216epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706682120;
	bh=+RKD13BNunG5kxjS9Yb51An1Mqb6woru+4hsuyBagDA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=g92sfM9Y4BFhqEB91wjc31IRBk/IVXavqVHQIADAikdkGeqkrHnIC8gCR87U3GUv2
	 ATx66QvnfMiGt3yHU3lPVHAWZJ+8ZFiBEt/Mm55Awcud0O5r128BYyvN82iO6l+Htu
	 zyWYpl52T5c4yTp+N2O9K6oORrIP7VNyEv3eL0pk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240131062200epcas5p1020bf98ae6b4c882a21c60e7a2db5469~vWliFVMmv2137221372epcas5p1b;
	Wed, 31 Jan 2024 06:22:00 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TPsPy2tZfz4x9QB; Wed, 31 Jan
	2024 06:21:58 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.A3.10009.607E9B56; Wed, 31 Jan 2024 15:21:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240131060648epcas5p40670be153beb80e60b0676c6f75911c5~vWYRINvp70740307403epcas5p4f;
	Wed, 31 Jan 2024 06:06:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240131060648epsmtrp2b438ade56609b635b694d126b3a08ac4~vWYRCe-dH0826108261epsmtrp2r;
	Wed, 31 Jan 2024 06:06:48 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-7c-65b9e706c9a0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	51.51.08755.873E9B56; Wed, 31 Jan 2024 15:06:48 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240131060645epsmtip1d176db43cfcfb3e746c05b8cffbedff1~vWYOsY8D11677016770epsmtip1b;
	Wed, 31 Jan 2024 06:06:45 +0000 (GMT)
From: "Aakarsh Jain" <aakarsh.jain@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Cc: <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
	<mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
	<krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-samsung-soc@vger.kernel.org>,
	<andi@etezian.org>, <gost.dev@samsung.com>, <alim.akhtar@samsung.com>,
	<pankaj.dubey@samsung.com>
In-Reply-To: <bb6e3546-a596-4748-92d9-7cfc1f5e2db1@linaro.org>
Subject: RE: [PATCH] dt-bindings: media: s5p-mfc: Remove s5p-mfc.txt binding
Date: Wed, 31 Jan 2024 11:36:44 +0530
Message-ID: <010301da540b$accfe490$066fadb0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQI/PvU03lDO5YGArwDNxcQQAt8ooQHpnmsRAg4hmkMB/4tQ4q/53L+w
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDJsWRmVeSWpSXmKPExsWy7bCmli7b852pBi0/hSwezNvGZrH4x3Mm
	i/uLP7NYrNl7jsli/pFzrBY3D+xksrg48y6LRd+Lh8wWe19vZbfY9Pgaq8XlXXPYLHo2bGW1
	mHF+H5PF2iN32S2WbfrDZLFo6xd2i9a9R9gdBD2uL/nE7LF4z0smj02rOtk87lzbw+axeUm9
	R9+WVYwenzfJeZz6+pk9gCMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEv
	MTfVVsnFJ0DXLTMH6A0lhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5x
	aV66Xl5qiZWhgYGRKVBhQnbGhC0z2Ata+SrOHbrH0sB4i7uLkZNDQsBEYvf6d6xdjFwcQgK7
	GSXeTl/MDuF8YpT42tkF5XxjlPi+5wILTMuW9idMEIm9jBLTeh9BVT1nlDi5H6KKTUBf4v6p
	HrDBIgJHGSUebHnIDOIwC5xnkrj1bwNQhoODU8BOovdQFogpLOAj8eJSNEgvi4CqxKJbn1lB
	bF4BS4npMx6zQdiCEidnPgGbzywgL7H97RxmiIsUJH4+XcYKEReXOPqzBywuIuAmMefHTjaQ
	tRICPzgkjl5azgrR4CLxdN03qGZhiVfHt7BD2FISn9/tZYOwkyUeL3oJVZMjsX7PFKj37SUO
	XJnDAnIzs4CmxPpd+hBhWYmpp9YxQdzAJ9H7+wkTRJxXYsc8GFtNYs6dH1AnyEgcXr2UcQKj
	0iwkr81C8tosJO/MQti2gJFlFaNkakFxbnpqsWmBUV5qOTzGk/NzNzGCk7mW1w7Ghw8+6B1i
	ZOJgPMQowcGsJMK7Um5nqhBvSmJlVWpRfnxRaU5q8SFGU2B4T2SWEk3OB+aTvJJ4QxNLAxMz
	MzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamOIXTq4/w1krtFYyjfnGxs/T3izN
	rZ9dF+ZZHP3vxVO75b/vVnP+mSSeefmEwrfKU6Vrku8u2Hn406rn/zRPakec2cC2yfPC7bW/
	Jrkr97jKrlnQX3xE74ipiEmy9lw+ngk+d9+KiBWtf30nJ+d/dPfF9og1T7bvlblx4oiSxK4L
	lQInsrOXF5c+CvGVX9b5rE+468HFoyr5rh0Sy6tzkl+9Yw7fs3sdi/wy/znnb9rfl0lZyLar
	x0e8+6CHZpzAtSA1k3jl2FWJwfJSZe9O7XXXrVol/rfm2sGl34UluS8vU4pyqS/X1Y97mhlv
	qr97VcWpCRseuZy/IvtWfV/6wpsL/V6/mrLfy2S+9q3FnwKUWIozEg21mIuKEwETm53gbwQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWy7bCSnG7F452pBp+2CVg8mLeNzWLxj+dM
	FvcXf2axWLP3HJPF/CPnWC1uHtjJZHFx5l0Wi74XD5kt9r7eym6x6fE1VovLu+awWfRs2Mpq
	MeP8PiaLtUfuslss2/SHyWLR1i/sFq17j7A7CHpcX/KJ2WPxnpdMHptWdbJ53Lm2h81j85J6
	j74tqxg9Pm+S8zj19TN7AEcUl01Kak5mWWqRvl0CV8aELTPYC1r5Ks4dusfSwHiLu4uRk0NC
	wERiS/sTpi5GLg4hgd2MEi++3GKHSMhI/G87BmULS6z895wdougpo8TWN8vZQBJsAvoS90/1
	sIIkRAROMkr0n2kBc5gFbjNJLJ23hRWi5TOjxJxdbxi7GDk4OAXsJHoPZYGYwgI+Ei8uRYMM
	YhFQlVh06zMriM0rYCkxfcZjNghbUOLkzCcsIDazgLZE78NWRghbXmL72znMENcpSPx8uowV
	Ii4ucfRnD1hcRMBNYs6PnWwTGIVnIRk1C8moWUhGzULSvoCRZRWjZGpBcW56brFhgWFearle
	cWJucWleul5yfu4mRnBEa2nuYNy+6oPeIUYmDsZDjBIczEoivCvldqYK8aYkVlalFuXHF5Xm
	pBYfYpTmYFES5xV/0ZsiJJCeWJKanZpakFoEk2Xi4JRqYFo6P+2mVdEsaZurOWFXavvF+yQv
	vFBffCb8f8ifI7u/2cTs5loeaKUda80RHBq7WsdFefM6T36noCshMl18xhlT3ibEiO5d0Cyv
	es4qo/sok0Xc/GM1C1T/Vu4LZ3RttvBZ/CZChImloamqtvsCX+RU5q+Fctsiph63jMj5fCUv
	+I5ERuuGwMY9N/86XvsXPp29Wub+BZW54pcnnLxjbPXFRiDb94QTt2Hnu4C28P8uydFzyj/9
	vfjD5on0p2uvuH50yrxe0FS/r3+u8aP734vKekvZ9y35d6Su7OWeIrPHvkdiL57xTT/2X/z8
	x/MFfeF8PVPvv/8z4eoK5zezeP/fEj60rGOOtczEKqZ2ISWW4oxEQy3mouJEAACbbRpXAwAA
X-CMS-MailID: 20240131060648epcas5p40670be153beb80e60b0676c6f75911c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240130125754epcas5p2edd5cc52dc58add09299d3aa5985a9fd
References: <CGME20240130125754epcas5p2edd5cc52dc58add09299d3aa5985a9fd@epcas5p2.samsung.com>
	<20240130125748.54194-1-aakarsh.jain@samsung.com>
	<9a8cb901-8021-42a3-a13b-bae10a645011@linaro.org>
	<bb6e3546-a596-4748-92d9-7cfc1f5e2db1@linaro.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: 30 January 2024 19:57
> To: Aakarsh Jain <aakarsh.jain@samsung.com>; linux-arm-
> kernel@lists.infradead.org; linux-media@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
> krzysztof.kozlowski+dt@linaro.org; robh+dt@kernel.org;
> conor+dt@kernel.org; linux-samsung-soc@vger.kernel.org;
> andi@etezian.org; gost.dev@samsung.com; alim.akhtar@samsung.com;
> pankaj.dubey@samsung.com
> Subject: Re: [PATCH] dt-bindings: media: s5p-mfc: Remove s5p-mfc.txt
> binding
> 
> On 30/01/2024 15:25, Krzysztof Kozlowski wrote:
> > On 30/01/2024 13:57, Aakarsh Jain wrote:
> >> Commit "538af6e5856b" which convert s5p-mfc bindings to
> >
> > Please run scripts/checkpatch.pl and fix reported warnings. Some
> > warnings can be ignored, but the code here looks like it needs a fix.
> > Feel free to get in touch if the warning is not clear.
> >
I am getting below warning while running scripts/checkpatch.pl on this patch
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#18:
deleted file mode 100644

total: 0 errors, 1 warnings, 0 lines checked

I think this can be ignored.
> >> json-schema is already merged. Remove "s5p-mfc.txt" file.
> >>
> >> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> >> ---
> >>  Documentation/devicetree/bindings/media/s5p-mfc.txt | 0
> >
> > Why you did not remove it in the first place? Your diff from
> > 538af6e5856b is so confusing.
> 
I missed it before. Will add Fixes tag.

> Also, add fixes tag.
> 
Sure.

Thanks for review!
> Best regards,
> Krzysztof



