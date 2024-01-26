Return-Path: <linux-kernel+bounces-39634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF3E83D3E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 06:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2706D1F25E06
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1025BBA50;
	Fri, 26 Jan 2024 05:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n3iykupB"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA91B657
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 05:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706246224; cv=none; b=ZDMxecEyITOvPvthdAZlbwUoJS9kUNM4omhvfLv8zFogGzo0PcMCni463w0pflxOGzmX4VhoqkpRNTxGHZtUrCyXdzUIoiKOZCxeGcRfpHcsyfxQsTK2WumtmLq9ETWQjGd3gkhmm70Zzwh7+qCuU415T1kudW3+6HAHYybgGL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706246224; c=relaxed/simple;
	bh=dluYRm5dDqJX3x1PpybFwwjdGdtUDXPxQdQ+lhoK3K4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=LUe3lST/EbQ4hbGU4SpZY5U5mwTx0hIQcditFA1xPtT7LGrwUyS5c24vj8dAtVXQwPxnTNLQySc5cssSVe/7/IL2JaNyr5Zm1FOZd+Hpl27nB1lko/fB2+/x89OK7WOr/Ie/PeLJ1QypPOAdzFTFkW2V3TN/TNaHlt975AHrcAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=n3iykupB; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240126051659epoutp01e37fc6a27512576719ad08d6f4a0d298~tzeWGXHHY0983509835epoutp01W
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 05:16:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240126051659epoutp01e37fc6a27512576719ad08d6f4a0d298~tzeWGXHHY0983509835epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706246219;
	bh=hploZXGnvBGsUE/XjNOrpqF9wf/z30BTogioatvLJhE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=n3iykupBw4wDN9Xda5ayg6wtltgWC/i5zLIu6Flz+GbETCbOvk1kaAeLB3Z+e99Ix
	 WvlsZ1HWOQzdzjVjJQarErhVtve6YPuFc3HX6v8AfV2qF7cUmja50x1uYvYE5glqA3
	 mUTdxK4v6E9MXgNu6I18Fxp3jSdQVElkvzHWAJog=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240126051658epcas1p12b0f26fd1012c44dc30e496d7a85df07~tzeVdTCGC2708127081epcas1p16;
	Fri, 26 Jan 2024 05:16:58 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.247]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TLmCG2hm1z4x9Q4; Fri, 26 Jan
	2024 05:16:58 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	79.A3.10211.A4043B56; Fri, 26 Jan 2024 14:16:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240126051657epcas1p30a4936302e1fa9aa492fecccb83a9220~tzeUjJXSr2041220412epcas1p3x;
	Fri, 26 Jan 2024 05:16:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240126051657epsmtrp29f9e3866700f5ab4d8291a39a6f4d689~tzeUiOk1r1200812008epsmtrp25;
	Fri, 26 Jan 2024 05:16:57 +0000 (GMT)
X-AuditID: b6c32a38-463ff700000027e3-8c-65b3404ad8fa
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	00.9B.08755.94043B56; Fri, 26 Jan 2024 14:16:57 +0900 (KST)
Received: from sh043lee03 (unknown [10.253.101.72]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240126051657epsmtip1455d5a21e5c6d1dd44654bdeda62145b~tzeUTxayL3021230212epsmtip1F;
	Fri, 26 Jan 2024 05:16:57 +0000 (GMT)
From: "Seunghui Lee" <sh043.lee@samsung.com>
To: "'Greg KH'" <gregkh@linuxfoundation.org>
Cc: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ulf.hansson@linaro.org>, <avri.altman@wdc.com>, <grant.jung@samsung.com>,
	<jt77.jang@samsung.com>, <dh0421.hwang@samsung.com>,
	<junwoo80.lee@samsung.com>, <jangsub.yi@samsung.com>,
	<cw9316.lee@samsung.com>, <sh8267.baek@samsung.com>, <wkon.kim@samsung.com>
In-Reply-To: <2024011945-studio-smitten-300e@gregkh>
Subject: RE: [PATCH] mmc: core: Fix null pointer dereference in bus_shutdown
Date: Fri, 26 Jan 2024 14:16:57 +0900
Message-ID: <011a01da5016$e23f41f0$a6bdc5d0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGcsgXp9LDtdNDOGMR+ItI0KSVqWgF7z+l9ASFv/iSxTS4YIA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmvq6Xw+ZUg3/dAhYvf15ls5hxqo3V
	Yt+1k+wWv/6uZ7doXryezaJj62Qmix3Pz7Bb7PrbzGRxedccNosj//sZLa6dOcFqcXxtuMXm
	S99YHHg97lzbw+axf+4ado++LasYPT5vkvNoP9DNFMAalW2TkZqYklqkkJqXnJ+SmZduq+Qd
	HO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SjkkJZYk4pUCggsbhYSd/Opii/tCRVISO/
	uMRWKbUgJafArECvODG3uDQvXS8vtcTK0MDAyBSoMCE741XHFPaCp0IVE3f/ZW9g/MnXxcjJ
	ISFgIrHz0ReWLkYuDiGBHYwSK/YsgXI+MUp82fiMGcL5xiixc+VfZpiWy1tgWvYySnxvvgXl
	vGCUWLCnlRWkik1AR+LNp/9gtgiQ3XHmBFgRs8ApJombEzvYQBKcQKOe3HjLBGILC/hIzDg8
	B8xmEVCV+P7iFpjNK2ApsXz3cnYIW1Di5MwnLCA2s4CBxPtz85khbHmJ7W/nQJ2nIPHz6TKo
	xU4SE68tYoWoEZGY3dkGVXOAQ6LteQqE7SIx4cxsqLiwxKvjW9ghbCmJz+/2soEcLSHQzCjR
	1vCVBcKZwCjxYsErJogqe4nm1mY2iA18Eu++9gBt4wCK80p0tAlBlChLvHy0DKpcUmJJ+y2o
	ZR4SV5eeYJ7AqDgLyW+zkPw2C8lvs5D8sICRZRWjWGpBcW56arFhgQk8xpPzczcxgtOwlsUO
	xrlvP+gdYmTiYDzEKMHBrCTCa2K6MVWINyWxsiq1KD++qDQntfgQoykwuCcyS4km5wMzQV5J
	vKGJpYGJmZGJhbGlsZmSOO+ZK2WpQgLpiSWp2ampBalFMH1MHJxSDUy65R3LhfK3/22a/Z51
	/s7anm/F8Uf+ev86sDnu7sm57zg3y144an3h2SUny/kzffJW+26t3HWBgXdWf37kf2nPRSt+
	9jRLvNYX+aRXOnfNd+VtYb+Es2q3tO19dkAxYbZQe15fbW/BhxXv8vYWPw798sBDPsjS+q9O
	v5xZf6jIxNPWXNsFo3gUTb80B5gya74Qbs7onTlNlXXVg7kXirc/eiDX2Phs2pb38grBEz0j
	/p2Zdqp0ydE536xfdHXyB0n1HZJ0V9D4/eT24hqPuBKHLP6tApNfKalvmavc3eDTFv7zfOvn
	Ev6zvmX7gywj/HwmfBTuC3X/HP+4ushS9mbi7sPNh32z07hsOkN3pCuxFGckGmoxFxUnAgDq
	If9aTAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSnK6nw+ZUg+7VuhYvf15ls5hxqo3V
	Yt+1k+wWv/6uZ7doXryezaJj62Qmix3Pz7Bb7PrbzGRxedccNosj//sZLa6dOcFqcXxtuMXm
	S99YHHg97lzbw+axf+4ado++LasYPT5vkvNoP9DNFMAaxWWTkpqTWZZapG+XwJXxqmMKe8FT
	oYqJu/+yNzD+5Oti5OSQEDCRuLzlC0sXIxeHkMBuRokzyzuYIRKSEosfPWTrYuQAsoUlDh8u
	hqh5BlQz5wYbSA2bgI7Em0//WUFsESC748wJsEHMAjeYJK4t380G0bGZUaLvz3R2kCpOoHVP
	brxlArGFBXwkZhyeA2azCKhKfH9xC8zmFbCUWL57OTuELShxcuYTFhCbWcBI4tyh/WwQtrzE
	9rdzoC5VkPj5dBnUFU4SE68tYoWoEZGY3dnGPIFReBaSUbOQjJqFZNQsJC0LGFlWMUqmFhTn
	pucWGxYY5qWW6xUn5haX5qXrJefnbmIEx6KW5g7G7as+6B1iZOJgPMQowcGsJMJrYroxVYg3
	JbGyKrUoP76oNCe1+BCjNAeLkjiv+IveFCGB9MSS1OzU1ILUIpgsEwenVANT7PIZJaUL+uyL
	3OaW7ZVw1XhmcXFi5NQ77naegRcf5hln7U3Znzm/waTVaMsqz9uua+sMZJV3NDe7Kr2y0TqT
	++ff07qcWbvCtkslrNH59m377vVB30OsG5+fSsxbKXJp30Ux9y8vRWYs2rNf5SyTRHbsm8qA
	ctfH81sy1LfsPR/Mfm8+c+HbfLEiqxOKb85/cAznFG1XCUud0HMiYNnNn6tlumeKfc14tW7V
	eRtri6n7GiZP6sjwUvj50cN/xZLdFtu5cs9kGTdLxU94+pmt50SP0EU3tojqaobtGuYqrNmS
	JqfVIjw0X59dcvIDr7kQQ2jZ7Me7zyf5XlU4IvdHesnSoJusino/mT5t2s+lxFKckWioxVxU
	nAgAvKu7vTQDAAA=
X-CMS-MailID: 20240126051657epcas1p30a4936302e1fa9aa492fecccb83a9220
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240119073011epcas1p1841e79c8f673c3c69ef696edc9eb47b0
References: <CGME20240119073011epcas1p1841e79c8f673c3c69ef696edc9eb47b0@epcas1p1.samsung.com>
	<20240119073247.7441-1-sh043.lee@samsung.com>
	<2024011945-studio-smitten-300e@gregkh>

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, January 19, 2024 5:21 PM
> To: Seunghui Lee <sh043.lee@samsung.com>
> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> ulf.hansson@linaro.org; avri.altman@wdc.com; grant.jung@samsung.com;
> jt77.jang@samsung.com; dh0421.hwang@samsung.com; junwoo80.lee@samsung.com;
> jangsub.yi@samsung.com; cw9316.lee@samsung.com; sh8267.baek@samsung.com;
> wkon.kim@samsung.com
> Subject: Re: [PATCH] mmc: core: Fix null pointer dereference in
> bus_shutdown
> 
> On Fri, Jan 19, 2024 at 04:32:47PM +0900, Seunghui Lee wrote:
> > When shutting down removable device,
> > it can be occurred null pointer dereference.
> 
> How?
> 
> And please wrap your lines properly.
> 
> > To prevent null pointer dereference,
> > At first, check null pointer.
> > Next, block rescan worker to scan removable device during shutdown.
> 
> Why do two things?
> 
> >
> > Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>
> > ---
> >  drivers/mmc/core/bus.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c index
> > 0af96548e7da..4f370a6577aa 100644
> > --- a/drivers/mmc/core/bus.c
> > +++ b/drivers/mmc/core/bus.c
> > @@ -143,9 +143,17 @@ static void mmc_bus_shutdown(struct device *dev)
> > {
> >  	struct mmc_driver *drv = to_mmc_driver(dev->driver);
> >  	struct mmc_card *card = mmc_dev_to_card(dev);
> > -	struct mmc_host *host = card->host;
> > +	struct mmc_host *host;
> >  	int ret;
> >
> > +	if (!drv || !card) {
> > +		pr_debug("%s: drv or card is NULL.\n", dev_name(dev));
> 
> What is this going to help with?  And why not use dev_dbg()?
> 
> How can drv ever be NULL?  That looks impossible to me based on just the
> code shown here.
> 
> > +		return;
> > +	}
> > +
> > +	host = card->host;
> 
> Why is this change needed?  This line can go back to the top just fine,
> right?
> 
> > +	host->rescan_disable = 1;
> 
> Shouldn't this be a separate change?  And what happens if the check for
> this is right before you set it?  Where is the locking to prevent the
> issue you are attempting to solve?
> 
> thanks,
> 
> greg k-h

I've checked the issue again.
This patch is not the proper solution.
I'll reject this patch.
Hi, Thank you for your comment.



