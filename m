Return-Path: <linux-kernel+bounces-67935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD36857343
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E771C23EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31D0DDC6;
	Fri, 16 Feb 2024 01:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XVrQhvDn"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95912D528
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 01:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708046068; cv=none; b=jA0t1JuqF6cGCtwl9xm9llLmff/uk+MZQuTj3l0JXMlXA5Vg5Iyn+ltx9H4M5TZh3di6lX1cqY0OvysoxnsnmxmI+ElALfqlMYeXaCSyU8sQ1OmoirwQtnhLgwVwEFsKRhxMmVAAiGEzODTk8ssQTLQ4pE6NiwUGqG+AhibvVgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708046068; c=relaxed/simple;
	bh=/Ez4WLxWzRTcW5AIUDrJbf/oLXqSy8Y+OJF+Du1Q4Ys=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=rzaQAjzR5GhAFp1LcuPyg++C+ZcCxr9IaQGqrPINrAfo10x+K+Cnd+Stjj+M7Qv2N116S1te4uP2ZTXE+vFIXi2Wu+k1HTqzY3DdDarO1Ml5WP7gWnDMEMKieRACL7lDgEINB0ofA2fErzx1qSMc/RRO8sMVkFYYp55TgfvlTrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XVrQhvDn; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240216011417epoutp03d0bd40f7db32ee56cc299869c82536ea~0Mtb_anOE1988219882epoutp03g
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 01:14:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240216011417epoutp03d0bd40f7db32ee56cc299869c82536ea~0Mtb_anOE1988219882epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708046057;
	bh=/Ez4WLxWzRTcW5AIUDrJbf/oLXqSy8Y+OJF+Du1Q4Ys=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=XVrQhvDnnZ5FIvs+D8f+O1Bb3PGNnmxHHY8n/6mZ0KdEo/fFmYGyAkTKMyt6Mw913
	 +aFMrfywOfCHr6WFB1MLTyYwNDMkXLILm53QcZRKbfpEuNWdr5kjsU8s2jH0ZSoQRp
	 XWziUZDTP6wJBBsVRQUfMLmISxqWfHaeCxRl/sJk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240216011416epcas1p4cac7d9acf02a9af79cc53fe64369dbbe~0MtbOi-xq2870828708epcas1p4q;
	Fri, 16 Feb 2024 01:14:16 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.243]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TbYqX2bslz4x9Py; Fri, 16 Feb
	2024 01:14:16 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C7.D5.19104.8E6BEC56; Fri, 16 Feb 2024 10:14:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240216011415epcas1p3b43e189e496be0ecf8ec1b7218571ae1~0MtaTjexP2093420934epcas1p3M;
	Fri, 16 Feb 2024 01:14:15 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240216011415epsmtrp20dcbd47868188e20a74c90e8d84dbe30~0MtaSuBqw0980409804epsmtrp27;
	Fri, 16 Feb 2024 01:14:15 +0000 (GMT)
X-AuditID: b6c32a4c-559ff70000004aa0-02-65ceb6e8c092
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	39.40.08817.7E6BEC56; Fri, 16 Feb 2024 10:14:15 +0900 (KST)
Received: from sh043lee04 (unknown [10.253.101.72]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240216011415epsmtip2e02080efed05e9222d87f815ba82f25e~0MtaB5P7x0132101321epsmtip2M;
	Fri, 16 Feb 2024 01:14:15 +0000 (GMT)
From: =?utf-8?B?7J207Iq57Z2s?= <sh043.lee@samsung.com>
To: "'Ulf Hansson'" <ulf.hansson@linaro.org>
Cc: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <avri.altman@wdc.com>,
	<grant.jung@samsung.com>, <jt77.jang@samsung.com>,
	<dh0421.hwang@samsung.com>, <junwoo80.lee@samsung.com>,
	<jangsub.yi@samsung.com>, <cw9316.lee@samsung.com>,
	<sh8267.baek@samsung.com>, <wkon.kim@samsung.com>, <sh043.lee@samsung.com>
In-Reply-To: <CAPDyKFpOLU3nsQuXLRdK2KAaQqX=Vwe0+A3jZc7pP4XaMG7Wug@mail.gmail.com>
Subject: RE: [PATCH] mmc: sd: Add a variable to check a faulty device
Date: Fri, 16 Feb 2024 10:14:15 +0900
Message-ID: <000001da6075$754d6ee0$5fe84ca0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI2QrZr/hQwBfLmGOt++EZEApv72gJjevE2AeL7/EgCVM+otwFeU4YKsBSKSrA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmvu6LbedSDa6v5rN4+fMqm8WMU22s
	FvuunWS3+PV3PbtF8+L1bBYdWyczWex4fobdYtffZiaLy7vmsFkc+d/PaNH0Zx+LxbUzJ1gt
	jq8Nt9h86RuLA5/HnWt72Dz2z13D7tG3ZRWjx+dNch7tB7qZAlijsm0yUhNTUosUUvOS81My
	89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgA5VUihLzCkFCgUkFhcr6dvZFOWX
	lqQqZOQXl9gqpRak5BSYFegVJ+YWl+al6+WlllgZGhgYmQIVJmRnTNmylKngtXTFrAXfmRsY
	v4l2MXJySAiYSPS83cQKYgsJ7GGUaG+26GLkArI/MUqsn/6MGcL5xihxsv0AC0zH189roRJ7
	GSW23N3GBOG8YJTYPvknUIaDg03ATOL5nSCQBhEBHYkZb5pZQWqYBV4ySfz58A5sEqdAoMT0
	tTvAbGEBV4nTZ9Yzg9gsAqoS/xbOAovzClhKvJ/wgR3CFpQ4OfMJWJxZQFti2cLXzBAXKUj8
	fLqMFWKZn8ScieugakQkZne2gV0qIXCCQ2LmpDlgx0kIuEhsboD6X1ji1fEt7BC2lMTnd3vZ
	IOqbGSXaGr6yQDgTGCVeLHjFBFFlL9Hc2swGMohZQFNi/S59iGV8Eu++9rBCzOeV6GgTgqhW
	lnj5aBlUp6TEkvZbUDd7SFxe38s2gVFxFpLXZiF5bRaSF2YhLFvAyLKKUSq1oDg3PTXZsMBQ
	Ny+1HB7jyfm5mxjBCVnLZwfj9/V/9Q4xMnEwHmKU4GBWEuGd1HsmVYg3JbGyKrUoP76oNCe1
	+BCjKTDAJzJLiSbnA3NCXkm8oYmlgYmZkYmFsaWxmZI475krZalCAumJJanZqakFqUUwfUwc
	nFINTLbzdTkWXug+Hf8oQj5o5xz5mT+bTtRyGyin7zbVTctVZt3RKz9td2uPZI2aYd+5Gxl7
	DzmVprffdF4168DF/OPtH+6H7n726n/AO86ucJfN3qf5ylb8YLRg+pAatljiEadYiI2p+MnD
	3eE6zJ0Hbtw/+mDTpNuvni+qvuwxlT2R/67017nXCjzSPGqPt2fcMVtqHbElt6U+JttLxkFo
	efT6EMUDXOftdaSStlka6OV3KL55/2ayu/vvjwsl325Xeqr/rEDldffCRzydDRPtJ5ubNuk0
	c0vdaWou9HZac9Ogp2Ldx28dpxcEblXr+N/+K4r55/930zQqbG4eUF2lkviZKS+yVFN13mfN
	ueoFSizFGYmGWsxFxYkABHst2FEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSvO7zbedSDR5917J4+fMqm8WMU22s
	FvuunWS3+PV3PbtF8+L1bBYdWyczWex4fobdYtffZiaLy7vmsFkc+d/PaNH0Zx+LxbUzJ1gt
	jq8Nt9h86RuLA5/HnWt72Dz2z13D7tG3ZRWjx+dNch7tB7qZAlijuGxSUnMyy1KL9O0SuDKW
	Hr/NWNAhUzHvnE8D40/RLkZODgkBE4mvn9cydzFycQgJ7GaUeHZ0NitEQlJi8aOHbF2MHEC2
	sMThw8UgYSGBZ4wS5/f7goTZBMwknt8JAgmLCOhIzHjTzAoyhlngO5NEz4o7TBAzDzNJ/Pv3
	iRmkilMgUGL62h0sILawgKvE6TPrweIsAqoS/xbOAovzClhKvJ/wgR3CFpQ4OfMJWJxZQFvi
	6c2ncPayha+ZIe5UkPj5dBkrxBV+EnMmroOqEZGY3dnGPIFReBaSUbOQjJqFZNQsJC0LGFlW
	MUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEx6OW1g7GPas+6B1iZOJgPMQowcGsJMI7
	qfdMqhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697U4QE0hNLUrNTUwtSi2CyTBycUg1MO8UO
	7GZh+qEY07PH+EHP0e5NEy4H6ChfjQn+oHHhXdWUteuVWzUmKxgGGionTJ8YINLd+L7inUMN
	626W35yWS/Q931zdGukXx2myacnEq2/m7PuuvUWE7bZQyRfWzg+3P/paSS3KaD5tGGO5JMTf
	P3rzXYMAr5vJC7mvqxg9Y4uNjfkyYft1Pcfc6nyui7WPV/7pDmPe5qjllmtyS8tX6/kJ//oL
	DYycmjdeLvneWS3YuSrljWDTwotBxoe33rFTlbuxNPi5DDOb4acz7ZXe6+/9+SLCq1t14cCh
	Q1fSzebP3iDA9uL2s+pl3gLrzju+Vog5VXRyw7YbnjJy7LKLnk+rz553PWyZX3iF4OHTSizF
	GYmGWsxFxYkApftk0DYDAAA=
X-CMS-MailID: 20240216011415epcas1p3b43e189e496be0ecf8ec1b7218571ae1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc
References: <CGME20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc@epcas1p1.samsung.com>
	<20240213051716.6596-1-sh043.lee@samsung.com>
	<CAPDyKFrjZ4jRHAfXsvrEvezuHTxbA3SAniF8CuObyLuW=AUoeA@mail.gmail.com>
	<000001da5faa$d34e1600$79ea4200$@samsung.com>
	<CAPDyKFpOLU3nsQuXLRdK2KAaQqX=Vwe0+A3jZc7pP4XaMG7Wug@mail.gmail.com>

> -----Original Message-----
> > > On Tue, 13 Feb 2024 at 06:13, Seunghui Lee <sh043.lee=40samsung.com>
> wrote:
> > > >
> > > > In mobile devices, suspend/resume situations are frequent.
> > > > In the case of a defective SD card in which initialization fails,
> > > > unnecessary initialization time is consumed for each resume.
> > > > A field is needed to check that SD card initialization has failed
> > > > on the host. It could be used to remove unnecessary initialization.
> > >
> > > It's not clear to me, under what circumstance you want to optimize fo=
r.
> > >
> > > Is the SD card ever getting properly initialized during boot?
> > >
> > > Kind regards
> > > Uffe
> > >
> > We receive a lot of reports about SD card issues in the market.
> > There was no problem with the first time at the time of use, and there
> are many cases where people recognize that it is not recognized later on.
> In most cases, this is a problem with the SD card itself.
>=20
> Right. Thanks for clarifying.
>=20
> A follow up question from me is then, do you know more exactly *why* the
> SD cards encounter problems?
>=20
> In the past people have told me that powering on/off an SD card during
> system suspend/resume, too frequently, could damage the card. For non-
> removable cards, the card stays powered-off even after a system resume,
> but instead gets powered-on (and re-initialized) when there is a new
> request for it.
>=20
> In other words, if the problem is related to too frequent powering on/off
> the card, my advice would be to test with having the card set non-
> removable (the DT property for this is =22non-removable=22), to see if th=
at
> can help. If that solves the problem, we can work towards another common
> solution instead.
>=20

I understand your focus on finding the root cause of the problem.
However, unlike internal storage, there is a limit to analyzing cards that =
have problems in the market.
This is because there are many different SD card manufacturers and many man=
ufacturers leave it to OEMs.

For deferred resume, a responsiveness problem occurs on the user side on mo=
bile devices.
The response time of the initializing SD card initialization in the applica=
tion seems to be slow.
Currently, it seems to be a good structure for the first initialization at =
runtime resume.

Regarding non-removable,
We will test if we are given an opportunity to further analyze the cards oc=
curring in the market.
However, SD card detection is also used as a wakeup source and must be inse=
rted/removed so I'll consider it for testing purposes.

Thank you for the good suggestions though.

> >
> > SD card users cannot determine whether or not an SD card is a problem,
> so they should be guided in this regard.
> > It is necessary to distinguish whether the SD card is inserted but
> unrecognized or the SD card itself is not inserted, and if there is a
> field that can check for initialization failure, it will facilitate
> guidance, so we considered the patch.
> >
> > The variable's usage is expected to be used through the sysfs node in
> the vendor module.
>=20
> As Greg said, please provide the complete code.
>=20
> Although, I want to stress already at this point, I don't see a solution
> with sysfs being the correct thing to do here. The kernel should be able
> to manage this problem itself.
>=20
> =5B...=5D
>=20
> Kind regards
> Uffe

I understand it and reconsider this commit.
Thank you for reviewing this.

Seunghui Lee.


