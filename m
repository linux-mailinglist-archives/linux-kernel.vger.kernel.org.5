Return-Path: <linux-kernel+bounces-70685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4D4859B21
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B56328219C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA7C46B7;
	Mon, 19 Feb 2024 03:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fK5FuTD1"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDDA442F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708314377; cv=none; b=mU3fBFmOAvhZSxwjEjogK3W85onucfJFgm6uHs2Kgqtmw9DmjGkbtaoXSOHlLCw1MhHjfjSOh12bcFM4XVClZ+9QBH/5N3oS6ewJH7baKp3GWLfuX3d5lfc0W2oyeY7OvikJFcnTovgQEMit6lkBj41PgX1jlhEW2vJsbS8fcFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708314377; c=relaxed/simple;
	bh=CTeiRfrgWM0ByxLGTzu9SEF9wISQC+DJlWXuws2Y374=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=LplP48lMj76Qf9tAjVht8QpMpjYDc6mivhoOHq8kRDT/Tqj+LHTQ/LFl3CYq4sN7/Gba4NHwry+voR+geieKid/nCjJ3fJ5lxagtHczhrDWEGablgL+hqvwhi/q9kZDOKP0+ApsKXngNzF9nAa8nXD4U+6/02b7KZxVro61omP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fK5FuTD1; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240219034608epoutp02343ef0df0cd8e477c0d5f75f6d4d9a2d~1Jt33NpcV1473714737epoutp02G
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:46:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240219034608epoutp02343ef0df0cd8e477c0d5f75f6d4d9a2d~1Jt33NpcV1473714737epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708314368;
	bh=ej5sTsbG7EG8qGJIYejeXO6eVpl5MOeHcT8Ydx697Fg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fK5FuTD1+vEbOB8vFASPGsNTe8IfIAm7MxFIGrrkcTBGTcFUhk9g5jYh6jJlV9Ndm
	 NWTrEV67nmIk1ulDHmpjW2T8nLKzuW1iW/UYfxv1FgyuIVGtb41S7UAadeM+r3i0Tr
	 FX4kIx3AUAMKoCs0KlF25Xhh7kHeuK/2pKhmwV10=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240219034607epcas2p3b65fe3c873b66629b3068be28fda9ba3~1Jt3WD7aM1373713737epcas2p3X;
	Mon, 19 Feb 2024 03:46:07 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.98]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TdT3M3tDcz4x9Q2; Mon, 19 Feb
	2024 03:46:07 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	89.45.18994.FFEC2D56; Mon, 19 Feb 2024 12:46:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240219034606epcas2p4f1cd412efcb12d3b0e6ea0377f8aceae~1Jt2Mb2ts0619106191epcas2p4d;
	Mon, 19 Feb 2024 03:46:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240219034606epsmtrp1998fd1b9a886d710b13e866a90809bc2~1Jt2LqBIO3033630336epsmtrp18;
	Mon, 19 Feb 2024 03:46:06 +0000 (GMT)
X-AuditID: b6c32a4d-743ff70000004a32-58-65d2ceff5061
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A7.EC.08755.EFEC2D56; Mon, 19 Feb 2024 12:46:06 +0900 (KST)
Received: from calab-Precision-7920-Tower (unknown [10.229.83.132]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240219034606epsmtip1f0a54a78bb5d79170488dd60374071f2~1Jt1_n-SI1159511595epsmtip1q;
	Mon, 19 Feb 2024 03:46:06 +0000 (GMT)
Date: Mon, 19 Feb 2024 12:46:35 +0900
From: Hojin Nam <hj96.nam@samsung.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, "Rafael J . Wysocki"
	<rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, ks0204.kim@samsung.com, wj28.lee@samsung.com,
	alison.schofield@intel.com
Subject: Re: [PATCH] ACPI: Fix CXL 3.0 structure (RDPAS) in the CEDT table
Message-ID: <ZdLPG2J0jVgRo5/s@calab-Precision-7920-Tower>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gusbAKRQVCgbvK7A6G8KQ5piNdUS=Sm3H2tWiSp-beGQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmqe7/c5dSDRbelbV4Nvcdi8XdxxfY
	LI7u4bDY+fAtm8Xyff2MFpd3zWGzeLziLbvF3C9TmS1WfprCYrHx/js2By6PxXteMnlsWtXJ
	5vFi80xGj74tqxg9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LI
	S8xNtVVy8QnQdcvMATpKSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhb
	XJqXrpeXWmJlaGBgZApUmJCd0f4luuABf0XvsXPsDYxHeboYOTkkBEwkVq97zQhiCwnsYZR4
	sVCli5ELyP7EKPHnw3UWCOcbo8TsSQfZuxg5wDqaOysg4nsZJaa8fMoK4fxglHj8awELyCgW
	AVWJOe0PWUFsNgE1iYX3LzGD2CIC2hJLFl0Fs5kFFjNJdLdmgtjCAl4Sb3b3gPXyClhKPFvX
	BGULSpyc+QTM5hQIlLhyfBs7yDIJgakcEvvuTmGE+MFF4sjKOcwQtrDEq+Nb2CFsKYmX/W1Q
	V+dLfNrJAhEukJjVs5YJwjaWeHfzOSvEPRkS7yffYoIoV5Y4cosFIswn0XH4L9QUXomONiGI
	TiWJ/R2tUEslJO6cuAx1jIfEgT9H2SFBcoVRonXZCsYJjHKzkHwzC8m2WUBjmQU0Jdbv0ocI
	y0s0b53NDBGWllj+jwNJxQJGtlWMUqkFxbnpqclGBYa6eanl8MhOzs/dxAhOr1q+Oxhfr/+r
	d4iRiYPxEKMEB7OSCK9704VUId6UxMqq1KL8+KLSnNTiQ4ymwJiayCwlmpwPTPB5JfGGJpYG
	JmZmhuZGpgbmSuK891rnpggJpCeWpGanphakFsH0MXFwSjUwcfS9nB6UwV/PWnvqKNu2p7dM
	Th/j8nVOifr7skV5geOih/nRXIumlV9477a2z7jqd9qfGb3HLY9cPvxTYsf5abUGB/6dLD8b
	tifkPYND1invs7q7+BkSjj5mknts4LvuvlHaPiWLwtlenyseH5BdI7/7kLRhbyDXxXPKconT
	97075qkd2W2ZsqdWi2Hif4/tz2/Za7MeWvVlXdWMPyX+8ufeVRyN+PxVvHLaotSHl1TLtp8S
	EfiWkjNj0Z5o7mmKL++unPPY7QjX39VBq4MeNvSUbF5vaTS/17axpVra4+QPpYUZz9vMawJk
	rnMEnX3HMe3nO7Nj1U+msPB0Kh8sWyoWsK535+Rbv5c/viTHUavEUpyRaKjFXFScCAAIgKL+
	OAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSnO6/c5dSDZbMU7B4Nvcdi8XdxxfY
	LI7u4bDY+fAtm8Xyff2MFpd3zWGzeLziLbvF3C9TmS1WfprCYrHx/js2By6PxXteMnlsWtXJ
	5vFi80xGj74tqxg9Pm+SC2CN4rJJSc3JLEst0rdL4MqYvGwzW0ETb8XxjzwNjM1cXYwcHBIC
	JhLNnRVdjFwcQgK7GSVWbP3A3MXICRSXkFj8eCcThC0scb/lCCtE0TdGiUfbjjGCJFgEVCXm
	tD9kBbHZBNQkFt6/BNYsIqAtsWTRVWaQBmaBpUwSvZfWgBUJC3hJvNndwwJi8wpYSjxb18QC
	MfUKo0TLvCVQCUGJkzOfgNnMAuoSf+aBTOUAsqUllv/jgAjLSzRvnQ22jFMgUOLK8W3sExgF
	ZyHpnoWkexZC9ywk3QsYWVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgTHjZbmDsbt
	qz7oHWJk4mA8xCjBwawkwuvedCFViDclsbIqtSg/vqg0J7X4EKM0B4uSOK/4i94UIYH0xJLU
	7NTUgtQimCwTB6dUA1PS1MefE7gCAg8zmLnpH/vSFlCb6zsj/rkq55GH4WWlb8s2LDm43iDM
	PfTyVlvjtysO/2EvmPzTXHHP6pOMHrMfPJ70hedVVbEV/78TMztCVj6vKZ9eacN6ft8Nn8qK
	m90izpa+7998u8NgJn/gfEXQjbgltnzSMoeFnq5vsv/Rs+xhdHz/dI1FhnOvx/GfWKT/6uHG
	TEW+lrO/t9a90H0qWf1LZeXNy4fkLXarqdX+C12zSyFMbZnknp9Och7lCgxlukF3XVVXTuEr
	/c456+OdD5s9v27YN3Mtp9/OKM9iqQNzWMyeh0U488/KXHVlraLJQ9tPBg/PpsoHJnTOFRMt
	uW/wJeGh7RqlJUt23lqmxFKckWioxVxUnAgAUvtKAgoDAAA=
X-CMS-MailID: 20240219034606epcas2p4f1cd412efcb12d3b0e6ea0377f8aceae
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----BUp_ENxb-nhquF.XJ9b44EtHNmvLAWOaNa9oXIBU2Tjzxkvf=_e9aa1_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240216072906epcas2p407a2f85aca1b9b8677fb8aa458c53aa6
References: <CGME20240216072906epcas2p407a2f85aca1b9b8677fb8aa458c53aa6@epcas2p4.samsung.com>
	<20240216072931.34305-1-hj96.nam@samsung.com>
	<CAJZ5v0gusbAKRQVCgbvK7A6G8KQ5piNdUS=Sm3H2tWiSp-beGQ@mail.gmail.com>

------BUp_ENxb-nhquF.XJ9b44EtHNmvLAWOaNa9oXIBU2Tjzxkvf=_e9aa1_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Fri, Feb 16, 2024 at 07:39:15PM +0100, Rafael J. Wysocki wrote:
> On Fri, Feb 16, 2024 at 8:29 AM <hj96.nam@samsung.com> wrote:
> >
> > From: Hojin Nam <hj96.nam@samsung.com>
> >
> > struct acpi_cedt_rdpas does not match with CXL r3.0 9.17.1.5
> > Table 9-24. reserved1 and length fields are already added by
> > struct acpi_cedt_header.
> >
> > Signed-off-by: Hojin Nam <hj96.nam@samsung.com>
> > ---
> >  include/acpi/actbl1.h | 2 --
> 
> This file is part of ACPICA which is a separate project whose code is
> used by the Linux kernel.  In order to make changes in the ACPICA
> code, please submit a pull request to the upstream ACPICA project on
> GitHub.  Once this pull request is merged, you can send a
> corresponding Linux patch with a Link: tag pointing to it.  However,
> it is not necessary to do so, as the changes will be automatically
> included into the ACPICA code in the kernel once a new version of
> ACPICA is out.
>

I submitted PR to the ACPICA project on Github[1].
Thanks for the guide!

Link: https://github.com/acpica/acpica/pull/928 [1]
 
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> > index a33375e055ad..7aff8c39dbd6 100644
> > --- a/include/acpi/actbl1.h
> > +++ b/include/acpi/actbl1.h
> > @@ -571,8 +571,6 @@ struct acpi_cedt_cxims {
> >
> >  struct acpi_cedt_rdpas {
> >         struct acpi_cedt_header header;
> > -       u8 reserved1;
> > -       u16 length;
> >         u16 segment;
> >         u16 bdf;
> >         u8 protocol;
> >
> > base-commit: d37e1e4c52bc60578969f391fb81f947c3e83118
> > --
> > 2.34.1
> >
> 

------BUp_ENxb-nhquF.XJ9b44EtHNmvLAWOaNa9oXIBU2Tjzxkvf=_e9aa1_
Content-Type: text/plain; charset="utf-8"


------BUp_ENxb-nhquF.XJ9b44EtHNmvLAWOaNa9oXIBU2Tjzxkvf=_e9aa1_--

