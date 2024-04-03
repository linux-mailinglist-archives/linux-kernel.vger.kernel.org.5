Return-Path: <linux-kernel+bounces-128961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D9489624E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C0DEB241BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6718017729;
	Wed,  3 Apr 2024 02:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aQIoUwMP"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429BF168A8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 02:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110117; cv=none; b=BI5fDUPlR/IamxMxyhi3LzGcUAlYR+uRrI1QfW73TqT05gnemYJRE0xQiMcZctRrS1JlNrPofpwQhL6TxbF9D8KUum9fURYzzPlrOFL/9pY5sSACNgTNlyWIrn2g+yQQOwscJQPY6ubAT2VmY5IZ2FOz+DeVG0JR5A4Eo4wweg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110117; c=relaxed/simple;
	bh=denbydM4OgFrlmck3lz/YFTBBzsKsWS8Z3PIPszpNUk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=PT/aIi6GhyBPj6849UR0hU2Ldoi5jpSKIr1kUM6wU+JZIl+vP5VcSMvOXY1E5Sn5rroYWe02crhDwWvha+xSnF+6P5XhOPrK4jb3iX3xEdLs/fUcHqE2Qxr3/gK0lfZeZTqos3xAfR80gUC/bcxOzQnSo520fOu70jMJt8M36Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aQIoUwMP; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240403020833epoutp013aa8dd7310ce0e1a7edb3af64b23399c~CoxOma_Lw1426814268epoutp01G
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 02:08:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240403020833epoutp013aa8dd7310ce0e1a7edb3af64b23399c~CoxOma_Lw1426814268epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712110113;
	bh=6aAlCwh36DxYyqqRLPW/CkqmSDRsRrrjCxjY+2Lohl0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=aQIoUwMPrq/UEhIUJ8Na/IewxZh6lhwkYbsIOGrJgRcQ0ZPmgLQhCUlXRa1cnIM0t
	 i/b9JnKlqRVeCD5Qfh4RIcYuX9C+ms71dCRtsn57vP4yj+guI9LqKdmxjI9qAzGBZi
	 dDJ2BKg/M+Sq6FBChvZMo6E0rQpamKZ/HFx85Xug=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240403020832epcas1p4ceaa211c97cb824c32041117feeb56c1~CoxOOhOa_1150311503epcas1p4X;
	Wed,  3 Apr 2024 02:08:32 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.243]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4V8SpS4WyLz4x9Q6; Wed,  3 Apr
	2024 02:08:32 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	15.A7.10076.02ABC066; Wed,  3 Apr 2024 11:08:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240403020832epcas1p23578fb643a6af77b4467e8ab0a882567~CoxNx2HCE0576005760epcas1p2h;
	Wed,  3 Apr 2024 02:08:32 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240403020832epsmtrp219eaeab6bca99a8c7b2b42e9084203dc~CoxNxK92C1861118611epsmtrp2a;
	Wed,  3 Apr 2024 02:08:32 +0000 (GMT)
X-AuditID: b6c32a39-7edf87000000275c-81-660cba20b7a8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9F.58.08390.02ABC066; Wed,  3 Apr 2024 11:08:32 +0900 (KST)
Received: from sgsupark03 (unknown [10.252.69.53]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240403020832epsmtip15132efaadb16880c685889b90e819fc8~CoxNlkJ2J3119931199epsmtip1G;
	Wed,  3 Apr 2024 02:08:32 +0000 (GMT)
From: "Seongsu Park" <sgsu.park@samsung.com>
To: "'Will Deacon'" <will@kernel.org>
Cc: <catalin.marinas@arm.com>, <ardb@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"'Leem	ChaeHoon'" <infinite.run@gmail.com>, "'Gyeonggeon Choi'"
	<gychoi@student.42seoul.kr>, "'Soomin Cho'" <to.soomin@gmail.com>, "'DaeRo
 Lee'" <skseofh@gmail.com>, "'kmasta'" <kmasta.study@gmail.com>
In-Reply-To: <20240402115841.GA16533@willie-the-truck>
Subject: RE: [PATCH] arm64: Fix double TCR_T0SZ_OFFSET shift
Date: Wed, 3 Apr 2024 11:08:31 +0900
Message-ID: <000001da856b$d37bed00$7a73c700$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG4lO0QCCmP+gAvhK58w9Ata5ns/QFI4YWxAYI4YrGxg1FpAA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmga7CLp40g1nvZS1+fnnPaPF+WQ+j
	xaa2+4wWfzbuZrL48ncps8Wmx9dYLS7vmsNmsfT6RSaLST+2MFq0f37BatFyx9SB22PNvDWM
	Hjtn3WX32LSqk81j85J6j0NnF7B6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
	YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
	JafArECvODG3uDQvXS8vtcTK0MDAyBSoMCE74+6Sa8wFHfwVH67sZGpgXMfTxcjBISFgIrGv
	NbKLkYtDSGAHo8SplpssEM4nRonWxkZ2COcbo8SOxX+Yuxg5wTq27+5jhUjsZZToXTIHquo5
	o8SuW3sYQarYBHQkvn2bwgJiiwioSuz7uYERpIhZ4DGTxO8nB8BGcQqYSWydtpAV5BBhARuJ
	DQ+9QMIsAioSy572MYHYvAKWEo/vfYWyBSVOznwCNpNZQF5i+9s5UBcpSPx8uowVYpeTxMZH
	N5kgakQkZne2MYPslRDYwyFxftcCqAYXielH1kLZwhKvjm9hh7ClJD6/28sGYRdL7PuyBqqm
	RuLBvD1Qtr1Ex7M2FpCbmQU0Jdbv0ofYxSfx7msPKyRMeSU62oQgTGWJc1sdIUxJiT8L9CBm
	eEh07G9jmcCoOAvJX7OQ/DULyf2zEFYtYGRZxSiWWlCcm55abFhgCo/q5PzcTYzgZKtluYNx
	+tsPeocYmTgYDzFKcDArifD+9OZME+JNSaysSi3Kjy8qzUktPsRoCgzpicxSosn5wHSfVxJv
	aGJpYGJmZGJhbGlspiTOe+ZKWaqQQHpiSWp2ampBahFMHxMHp1QD054377IexC364f7p75u0
	ZSeiup5fqTl93nI3b+I7qTC7gzNncvHX7W9PmGL2hudei8zHpavzf5j+ffBVssHgu3uVqcO/
	WYcq7+38CUwMdYsv5Gcu62Z/f9UmdFmc3vfX69iCw+s0rGKXzbn5o+q9+ouoWO2lwuaLT22v
	vcy0zzWmXVO/8MyWPSJnvxo7GASbvLqlFV3F8DJk3fkN9btyp6p9dd347ZBE5tXEtksyE0PS
	zf2v8FS7a8rMPWgkEvtVLc5uD+9jddbmcr+AJ+tZ95x9MmtH3oaLb/mu32mYUN7ld0bDy2en
	z9TT2XrV2x7q3lta7da70Sbj0VI+bzvpvprc2s7T2rLVy41SxBLtlViKMxINtZiLihMBwbjn
	Oz8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnK7CLp40g0u9XBY/v7xntHi/rIfR
	YlPbfUaLPxt3M1l8+buU2WLT42usFpd3zWGzWHr9IpPFpB9bGC3aP79gtWi5Y+rA7bFm3hpG
	j52z7rJ7bFrVyeaxeUm9x6GzC1g9Pm+SC2CL4rJJSc3JLEst0rdL4Mq4u+Qac0EHf8WHKzuZ
	GhjX8XQxcnJICJhIbN/dx9rFyMUhJLCbUeLY6qPMEAlJifZ3l1m6GDmAbGGJw4eLIWqeMkqs
	u3GbBaSGTUBH4tu3KWC2iICqxL6fGxhBipgF3jJJnJ65lQmiYzujxNpd3YwgVZwCZhJbpy1k
	BZkqLGAjseGhF0iYRUBFYtnTPiYQm1fAUuLxva9QtqDEyZlPwI5gFtCTaNsINoVZQF5i+9s5
	UHcqSPx8uowV4gYniY2PbjJB1IhIzO5sY57AKDwLyaRZCJNmIZk0C0nHAkaWVYySqQXFuem5
	xYYFRnmp5XrFibnFpXnpesn5uZsYwZGnpbWDcc+qD3qHGJk4GA8xSnAwK4nw/vTmTBPiTUms
	rEotyo8vKs1JLT7EKM3BoiTO++11b4qQQHpiSWp2ampBahFMlomDU6qBKfkgM7fX1a17d/4p
	+RDN1qxfcuW44Bum2WY2m9fIH/C6p8X03cp246SrmQLONTfl1LXiF9WfWmDedFbWaMK+ilrr
	Xwf3/dlYxmuv2MM2v6/YKHj53VOlKYKrlja0mHjnN8+U4/x/Y8PfOvUDz84WLEl+eYg1+lb3
	+gk9Nb+zXoc+uWCb+Ooa2xzN6d/2f47oDD6xJfGQopWzkUz5gXbZEwr7lN659Xz/ZbdJ4vH7
	f5vaO6Uk7pzqVEnXqrx4Xyg1a9eUYBubr9JLrZecXXN78qoH5Re/h9xmXLN/akr3OrmLP7oZ
	TCS+H3z2I0mju3d1h4BuxU0P/3UJxe5X1TwfNl+Qyj+p9ytqe9vcNY/0ypVYijMSDbWYi4oT
	AeELf1ErAwAA
X-CMS-MailID: 20240403020832epcas1p23578fb643a6af77b4467e8ab0a882567
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240402104955epcas1p3dd15334a1305b99f3e1b82000e3c7c42
References: <CGME20240402104955epcas1p3dd15334a1305b99f3e1b82000e3c7c42@epcas1p3.samsung.com>
	<20240402104950.170632-1-sgsu.park@samsung.com>
	<20240402115841.GA16533@willie-the-truck>



> On Tue, Apr 02, 2024 at 07:49:50PM +0900, Seongsu Park wrote:
> > We have already shifted the value of t0sz in TCR_T0SZ by
TCR_T0SZ_OFFSET.
> > So, the TCR_T0SZ_OFFSET shift here should be removed.
> >
> > Co-developed-by: Leem ChaeHoon <infinite.run@gmail.com>
> > Signed-off-by: Leem ChaeHoon <infinite.run@gmail.com>
> > Co-developed-by: Gyeonggeon Choi <gychoi@student.42seoul.kr>
> > Signed-off-by: Gyeonggeon Choi <gychoi@student.42seoul.kr>
> > Co-developed-by: Soomin Cho <to.soomin@gmail.com>
> > Signed-off-by: Soomin Cho <to.soomin@gmail.com>
> > Co-developed-by: DaeRo Lee <skseofh@gmail.com>
> > Signed-off-by: DaeRo Lee <skseofh@gmail.com>
> > Co-developed-by: kmasta <kmasta.study@gmail.com>
> > Signed-off-by: kmasta <kmasta.study@gmail.com>
> > Signed-off-by: Seongsu Park <sgsu.park@samsung.com>
> 
> heh, that's quite a lot of people. Did you remove three chars each? :p
We are studying the Linux kernel based on arm64 together every Saturday for
7 hours! :)
> 
> > ---
> >  arch/arm64/include/asm/mmu_context.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/mmu_context.h
> > b/arch/arm64/include/asm/mmu_context.h
> > index c768d16b81a4..58de99836d2e 100644
> > --- a/arch/arm64/include/asm/mmu_context.h
> > +++ b/arch/arm64/include/asm/mmu_context.h
> > @@ -76,7 +76,7 @@ static inline void __cpu_set_tcr_t0sz(unsigned long
> t0sz)
> >  		return;
> >
> >  	tcr &= ~TCR_T0SZ_MASK;
> > -	tcr |= t0sz << TCR_T0SZ_OFFSET;
> > +	tcr |= t0sz;
> 
> Thankfully, TCR_T0SZ_OFFSET is 0 so this isn't as alarming as it looks.
> Even so, if we're going to make the code consistent, then shouldn't the
> earlier conditional be updated too?
> 
> 	if ((tcr & TCR_T0SZ_MASK) >> TCR_T0SZ_OFFSET == t0sz)
> 		return;
> 
> seems to assume that t0sz is unshifted.
> 
> Will
Thank you for feedback. I'll send v2 patch.


