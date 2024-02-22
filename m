Return-Path: <linux-kernel+bounces-75953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B105185F115
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1D97B23557
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6C31774E;
	Thu, 22 Feb 2024 05:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d/E2nTcb"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F76015AF6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708580768; cv=none; b=maJ/KRE2i1E67vKIqgdMdkf/dR0YB0HW+sGD8/uNFNA4jtOYT5VLS1Rv/07O6Us1McOLQIOn1CXBwFjuatkZgg+efp+R1LRLoM3nJZvCXY5Aa3f/tYzY7gAZLIPiE3coZSsz3KmYc+4/km71n1rRgeQ3G4apGNksIfwy5XKhAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708580768; c=relaxed/simple;
	bh=ZMWA+xjhMXcZlG0tp8S0tyyExBIoKtSFzAoHXSvOup8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=hYTAu3gGjS8R4YxS1gKn7fcLlWpUmQVuVI1OijBQecEZy39NNIjMtg3HZ+Y//LdQAGP5GXMlbK3aY2Ppl9H3S1YRg3rUsSmNO9Oa65J3+8uqdb8YZPn0edobo3eKChmCIDbv51qdHYOWq7739YvMmc6XzemYlMBQJ24TgscNEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=d/E2nTcb; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240222054555epoutp0367a656a24acbaa183aaa45e2bf63fe68~2GSUHtATm3225932259epoutp03I
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:45:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240222054555epoutp0367a656a24acbaa183aaa45e2bf63fe68~2GSUHtATm3225932259epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708580755;
	bh=zekTG7a+QpHp556+l4AER1uxUJtHoyjsl/pJ4hDgm28=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=d/E2nTcblhvJvEfOIh6w8WjpifujA9UimdkQcP1zQICkPUZVXooS2dDx7EB8EO9Wb
	 Bp5zHlQ9Qxm5aWZ0FvvuUwg3Eu/2EmN/apbngDaCqtPIc1C03H9Av103QeIJJgzBz9
	 fZzFiySeAA0i591vn/spOgqzeUDtZR7x1VYPUtFk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240222054554epcas1p2864a3c441fe5674636e3d55284e10f67~2GSTPqn5-2318523185epcas1p2M;
	Thu, 22 Feb 2024 05:45:54 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.232]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TgMZ91gHZz4x9Pw; Thu, 22 Feb
	2024 05:45:53 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	84.D6.09731.F8FD6D56; Thu, 22 Feb 2024 14:45:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240222054551epcas1p42157432a7a23601812090b57264e4447~2GSQY4qYK3151831518epcas1p40;
	Thu, 22 Feb 2024 05:45:51 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240222054551epsmtrp10f071773362979948f86e06f905f5407~2GSQYTdrg0145601456epsmtrp1a;
	Thu, 22 Feb 2024 05:45:51 +0000 (GMT)
X-AuditID: b6c32a36-cebfd70000002603-75-65d6df8fe924
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BF.20.07368.F8FD6D56; Thu, 22 Feb 2024 14:45:51 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240222054551epsmtip2e0e68b936b4cf9ea4522bd1e82bcc630~2GSQMnuDP1266112661epsmtip2l;
	Thu, 22 Feb 2024 05:45:51 +0000 (GMT)
From: "Chanwoo Choi" <cw00.choi@samsung.com>
To: "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
Cc: "'MyungJoo Ham'" <myungjoo.ham@samsung.com>
In-Reply-To: <ZdYOPISUzbjid9l8@smile.fi.intel.com>
Subject: RE: [PATCH v1 1/1] extcon: intel-mrfld: Switch to use
 dev_err_probe()
Date: Thu, 22 Feb 2024 14:45:51 +0900
Message-ID: <001001da6552$64c02a90$2e407fb0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQIZbbb4NxCFElceNX1rjBu1XU7E9wHLKjyIAma/wZ0BdNL9L7Bqk11w
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmrm7//WupBg/7dSx6m6YzWVzeNYfN
	4nbjCjYHZo95JwM9+rasYvT4vEkugDkq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ
	0sJcSSEvMTfVVsnFJ0DXLTMHaI+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C0
	QK84Mbe4NC9dLy+1xMrQwMDIFKgwITuj4/ZE9oK7bBXPzlxgamDcw9rFyMkhIWAicWPXdvYu
	Ri4OIYEdjBI7vk1nhHA+MUr8X/KLDcL5xihx9/dKNpiWjqXbWCASexklpp9YyQiSEBJ4ySix
	5pVlFyMHB5uAjsSCH6EgYRGBWIlzTz4yg9jMAvoSqz/cBivnFDCSeP/kJthMYYEAiUPNF5lA
	bBYBVYlFyy4zgYzhFbCUWH7dAyTMKyAocXLmExaIMfIS29/OYYY4R0Hi59NlrBBxEYnZnW3M
	EGvdJPq/nAH7TELgJbvE98NPWSAaXCTeP3sJ9YuwxKvjW9ghbCmJl/1tUA2TGSUuvn7NDOGs
	Z5TYuLIFap2xxP6lk8GuYxbQlFi/Sx9iM5/Eu689rCBhCQFeiY42IYhqZYnLD+4yQdiSEovb
	O6H2ekjsm3OReQKj4iwkv81C8tssJP/MQli2gJFlFaNYakFxbnpqsWGBETyyk/NzNzGCk6CW
	2Q7GSW8/6B1iZOJgPMQowcGsJMLLUn4lVYg3JbGyKrUoP76oNCe1+BCjKTCwJzJLiSbnA9Nw
	Xkm8oYmlgYmZkbGJhaGZoZI475krZalCAumJJanZqakFqUUwfUwcnFINTPG3pjOGbE1/fClV
	0p+Z28+GfaOO73uOc+eTbwrtfbolwWVLfVniiz9vqmYyvFz+lGF+ePc6jdS+zHPn7d8y81yX
	XVz15xt3+apQVhPRxD0Me3hOPL397Tr/vZqZk5jMP9ka6imm8+x95SS1MmlXbuLqG5P8rab/
	cmqa5CItyyzSlJ7ZK1b8VrtxyadDNRGCbuevWr5VPxT/222X+xfDVHWDBKsHX89s5pxyi8/K
	WPN4qNA7Jqcrgo3d99U0zl5x/XJyzvSTK2ZIMcy0cI9Pj4jO6/z870349pqJ7B8ZVW6umGKr
	fVKT7dEBm59RyusM7+f1Tks6/mGGrffJR7J8CjbfjhdNZdWTbGlri7TwUGIpzkg01GIuKk4E
	AHoC4fYLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvG7//WupBvOfiln0Nk1nsri8aw6b
	xe3GFWwOzB7zTgZ69G1ZxejxeZNcAHMUl01Kak5mWWqRvl0CV0bH7YnsBXfZKp6ducDUwLiH
	tYuRk0NCwESiY+k2li5GLg4hgd2MElfffWWGSEhKTLt4FMjmALKFJQ4fLoaoec4o8eDuXxaQ
	OJuAjsSCH6Eg5SICsRLnnnwEa2UW0JdY/eE2I0T9M0aJvp1HwBKcAkYS75/cZAOxhQX8JA6f
	fMwEYrMIqEosWnaZCWQmr4ClxPLrHiBhXgFBiZMzn4CtYhbQk2jbyAgxXl5i+9s5UFcqSPx8
	uowVIi4iMbuzjRniHDeJ/i9n2CcwCs9CMmkWwqRZSCbNQtK9gJFlFaNkakFxbnpusmGBYV5q
	uV5xYm5xaV66XnJ+7iZGcCRoaexgvDf/n94hRiYOxkOMEhzMSiK8LOVXUoV4UxIrq1KL8uOL
	SnNSiw8xSnOwKInzGs6YnSIkkJ5YkpqdmlqQWgSTZeLglGpg8vj9PTnsf9N+4enOX2dPaFx8
	bZFB1OZvahVxKRu7T824nZ72IqD82XqZdRtWBEQnL1NRzHFjfd9za7WzJvupXHGzJE7T9pgT
	rc3RHzK+7xJM1QoI/i3ZdWL576OTlYOfzmBj09vT1FTQF3m+mlnpYfrUWxtfqUxV3d/IlHru
	bI3oWp3CefZ71k/8eHC2XKBUh6Ril19l32spCWZeG+HsEwHqBvrPzz4TO51+Wz7w8PoimYIz
	SlxaHhdyV6Qope6bOcm/aVWfiPlLjZPVN2/P+7hfSCbqxM15r8zd3kmVLdJ9tqnvhfPjZqG7
	ifJHu9gZ2Se9l3vSssSm+O4Zjrjm3k9vwmb7B6j6RO4ViNinxFKckWioxVxUnAgAkCefqPMC
	AAA=
X-CMS-MailID: 20240222054551epcas1p42157432a7a23601812090b57264e4447
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240221145253epcas1p181803bdcfac50532a85ae191fe2e85f0
References: <20231222161954.2955905-1-andriy.shevchenko@linux.intel.com>
	<ZbuJ8zCEfU-ORmk_@smile.fi.intel.com>
	<CGME20240221145253epcas1p181803bdcfac50532a85ae191fe2e85f0@epcas1p1.samsung.com>
	<ZdYOPISUzbjid9l8@smile.fi.intel.com>



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Wednesday, February 21, 2024 11:53 PM
> To: linux-kernel@vger.kernel.org
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>; Chanwoo Choi
> <cw00.choi@samsung.com>
> Subject: Re: [PATCH v1 1/1] extcon: intel-mrfld: Switch to use
dev_err_probe()
> 
> On Thu, Feb 01, 2024 at 02:09:23PM +0200, Andy Shevchenko wrote:
> > On Fri, Dec 22, 2023 at 06:19:54PM +0200, Andy Shevchenko wrote:
> > > Switch to use dev_err_probe() to simplify the error path and unify a
> > > message template.
> >
> > Any comments? Can these two patches (with
> > 20231222161854.2955859-1-andriy.shevchenko@linux.intel.com) be applied?
> 
> Ping?
> 
> It's more than two months passed...
> 

I'm sorry for late reply. I applied it. Thanks.

Best Regards,
Chanwoo Choi


