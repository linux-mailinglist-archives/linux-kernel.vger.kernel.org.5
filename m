Return-Path: <linux-kernel+bounces-134714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A644889B5EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC9828173F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9403963B8;
	Mon,  8 Apr 2024 02:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rbbl71Aq"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1495660
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 02:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712542777; cv=none; b=aUaBs7wgS1OLJMuwlTQwyUiBw3xmxyGyhnvIvlIAtmzGMReD9pclvETiao1cdeONaHyRAtFTB54a+T6mC9PgjfL50kbOtC3hxVOzHYBAVtT8rRR6p3r71MuJocMEq73Fjf+R/iuUF0enAZdGt8caOnYCVMSaSMRglsp6AM/Qeds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712542777; c=relaxed/simple;
	bh=C0U941vURb0ze0QtlAxgXqyHO59t+hLl+ZS2HOxrOEA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=IUcAIruQ5IQTI8MYgq4/hQUNkwkf8TQcDZYJEbmHwoFMfrSGWGAGFPQOA6/3oTIoRPgZKsq9ymSpeg5jmg8RVhjgeoEnlGIk706L/xC4LeA05e5xovxEnnlxYPM8ECE4P2eYhxcVfaF/zmMa+KWKkHOz3LMB2AeCwx2l9DaIjk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rbbl71Aq; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240408021926epoutp0289db8c1d473a7d2d5df4482e63f6956c~ELJKttY292716327163epoutp02x
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 02:19:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240408021926epoutp0289db8c1d473a7d2d5df4482e63f6956c~ELJKttY292716327163epoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712542766;
	bh=6z21GiTFcgH933n4iaXSqNPN9+/JmUWP0CRuM5wSe9c=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=rbbl71AqGrywr5TbEiaBrvE6FOVSLoPAVgi0TGJe1ELM9zvE5slhOx5u8Dktx2qiV
	 SFUOWNaIz0o7PC5sPm6PMfthns3xdRQZ31QiB/GWGKqxTb6luCoEDBOq048hGeh1O9
	 DNiljbtMNio06h+QR8wrISM+CADcnIWR7sCPproc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240408021926epcas1p4cb7652f8e2c646c500a059f98a143758~ELJKTEewJ2103021030epcas1p4r;
	Mon,  8 Apr 2024 02:19:26 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.227]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VCXpk1pCCz4x9QG; Mon,  8 Apr
	2024 02:19:26 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	A7.9A.10158.E2453166; Mon,  8 Apr 2024 11:19:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240408021925epcas1p3b607cf70b5fee481edec970e682dba1b~ELJJ48FL72956129561epcas1p3L;
	Mon,  8 Apr 2024 02:19:25 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240408021925epsmtrp27b9fa9239313ef81b229d5cbb5d7218e~ELJJ4A8XB2042120421epsmtrp2I;
	Mon,  8 Apr 2024 02:19:25 +0000 (GMT)
X-AuditID: b6c32a38-b41fa700000027ae-96-6613542e2356
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2A.A6.07541.D2453166; Mon,  8 Apr 2024 11:19:25 +0900 (KST)
Received: from sgsupark03 (unknown [10.252.69.53]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240408021925epsmtip1a75db1e7770f66e247a3afd9b0e36ce2~ELJJs2DM-2544725447epsmtip1b;
	Mon,  8 Apr 2024 02:19:25 +0000 (GMT)
From: "Seongsu Park" <sgsu.park@samsung.com>
To: "'Mark Rutland'" <mark.rutland@arm.com>
Cc: <will@kernel.org>, <catalin.marinas@arm.com>, <ardb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"'Leem	ChaeHoon'" <infinite.run@gmail.com>, "'Gyeonggeon Choi'"
	<gychoi@student.42seoul.kr>, "'Soomin Cho'" <to.soomin@gmail.com>, "'DaeRo
 Lee'" <skseofh@gmail.com>, "'kmasta'" <kmasta.study@gmail.com>
In-Reply-To: <Zg0pDYADt1YnlQaj@FVFF77S0Q05N>
Subject: RE: [PATCH v2] arm64: Fix double TCR_T0SZ_OFFSET shift
Date: Mon, 8 Apr 2024 11:19:25 +0900
Message-ID: <03fc01da895b$2d352da0$879f88e0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEDioMuMfHdTugzmv/rxcIOwvfVJwJDhwiMArk0WuCy47pJUA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmga5eiHCawdq3XBY/v7xntHi/rIfR
	YlPbfUaLPxt3M1l8+buU2WLT42usFpd3zWGzWHr9IpPFpB9bGC3aP79gtWi5Y+rA7bFm3hpG
	j52z7rJ7bFrVyeaxeUm9x6GzC1g9Pm+SC2CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUz
	MNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpOSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQ
	klNgVqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdMW1uecEUwYof91+xNTA+4e1i5OSQEDCRWPXk
	ESuILSSwg1Gi8T9PFyMXkP2JUaLh8CRWCOcbo8SHw1cYYTo+nrzCBJHYyygxYdtEFgjnOZDz
	/xZYFZuAjsS3b1NYQGwRAW2JP1N7wOLMAveYJBadzgKxOYFqHh7tYgexhQXsJdYcm8oEYrMI
	qEg8XziFGcTmFbCUmHb5M5QtKHFy5hMWiDnyEtvfzmGGuEhB4ufTZawQu5wkPp+8xgRRIyIx
	u7ONGeQ4CYE9HBIfb/yEesFFYumsqVDNwhKvjm9hh7ClJD6/28sGYRdL7PuyBqqmRuLBvD1Q
	tr1Ex7M2oCM4gBZoSqzfpQ+xi0/i3dceVpCwhACvREebEISpLHFuqyOEKSnxZ4EexAwPiRW3
	tjBOYFScheSvWUj+moXk/lkIqxYwsqxiFEstKM5NTy02LDCBx3Ryfu4mRnCq1bLYwTj37Qe9
	Q4xMHIyHGCU4mJVEeINNBdOEeFMSK6tSi/Lji0pzUosPMZoCQ3ois5Rocj4w2eeVxBuaWBqY
	mBmZWBhbGpspifOeuVKWKiSQnliSmp2aWpBaBNPHxMEp1cA0nbupQFj6glQT06arWV9VJ/TY
	32z65b0z0+bI5jTVs7KvZfTT/b5smrH1jvy3Lj3Tf2uF0/WNE1J+Tyt8va/krYWahv3xzkcv
	m6f5XJ73+mrw6Zt1Exbe0PS0SlLzEAl/ZiI467nr1QOaK/bJM59SMz/pYCbIYLM1K5p5Ykbr
	6rau4E0zvjJ0VzxOEw/j1C74MWvGkasTL1XVnSo7arPm/KKHRz+w1HPaFe0QP6HKGCossyTQ
	Unei/YlpC3kEZ64Tyn1z23XBtu+hSmGT1nuWB1S9SSr4FLf+veRW2TfvQrpeNKcWXrgSOy/T
	WX6hIE/m4cs37ju/KG8QPMuXdtDn7Uujtk+rD4h+W6B/fXmmEktxRqKhFnNRcSIAZecHKj4E
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnK5uiHCawYwpRhY/v7xntHi/rIfR
	YlPbfUaLPxt3M1l8+buU2WLT42usFpd3zWGzWHr9IpPFpB9bGC3aP79gtWi5Y+rA7bFm3hpG
	j52z7rJ7bFrVyeaxeUm9x6GzC1g9Pm+SC2CL4rJJSc3JLEst0rdL4MqYNre8YIpgxY/7r9ga
	GJ/wdjFyckgImEh8PHmFqYuRi0NIYDejxKoPHYwQCUmJ9neXWboYOYBsYYnDh4shap4ySmz+
	fYsdpIZNQEfi27cpLCC2iIC2xJ+pPYwgRcwCL5gkOpouQU1dyyixY+kiJpAqTqCOh0e7wLqF
	Bewl1hybChZnEVCReL5wCjOIzStgKTHt8mcoW1Di5MwnYFcwC+hJtG0EO45ZQF5i+9s5zBCH
	Kkj8fLqMFeIIJ4nPJ68xQdSISMzubGOewCg8C8mkWQiTZiGZNAtJxwJGllWMkqkFxbnpucmG
	BYZ5qeV6xYm5xaV56XrJ+bmbGMGRp6Wxg/He/H96hxiZOBgPMUpwMCuJ8AabCqYJ8aYkVlal
	FuXHF5XmpBYfYpTmYFES5zWcMTtFSCA9sSQ1OzW1ILUIJsvEwSnVwOTDdnerOl9qj9M1VrGE
	2yubWIRsV8yw8FTxXS23Jqt462/N4Kwkll8pa8WmJO5l2hK9o4M7S2/zkrLPpTOW2uypzJzF
	Krno7Pz/cQfSrz2b/XfDe7nZHWVJ13cVzbAz+5D0wV/50b1FizKuT5w3wcrs2qnfL6ruFXKv
	0pdZdKbpQsfuj6FLHZ6fNtoSatmRzrAusq6Bqb7kaTzj56oV94XmhEWyPq9oqtSRymusO3u5
	cIr33KX5j5V0799NPJEkP/GftP2kkk2ccxki5j7b42uYHiH385/e09Ozbh+L0GNLaHj2/UB2
	ZfU9ffl7HVOm1yUtbHM3Ci0VDhDimpCfJpcULfUoetPkf1+C9nOsXq7EUpyRaKjFXFScCAD0
	ewUUKwMAAA==
X-CMS-MailID: 20240408021925epcas1p3b607cf70b5fee481edec970e682dba1b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240403024240epcas1p155cd55ca8c1dae6114b970cf3f57084e
References: <CGME20240403024240epcas1p155cd55ca8c1dae6114b970cf3f57084e@epcas1p1.samsung.com>
	<20240403024236.193428-1-sgsu.park@samsung.com>
	<Zg0pDYADt1YnlQaj@FVFF77S0Q05N>



> On Wed, Apr 03, 2024 at 11:42:36AM +0900, Seongsu Park wrote:
> > We have already shifted the value of t0sz in TCR_T0SZ by
TCR_T0SZ_OFFSET.
> > So, the TCR_T0SZ_OFFSET shift here should be removed.
> 
> Can we please write a better commit message?
> 
> This doesn't explain:
> 
> * Where we have already shifted the value of t0sz, nor why it makes sense
> to do
>   that there.
> 
> * That the value of TCR_T0SZ_OFFSET is 0, and hence shifting this
> repeatedly is
>   beningn, and this patch is a cleanup rather than a fix.
> 
> Mark.
Thank you for feedback. I'll send v3 patch.
In v3, We will upgrade the commit message, and add the cpu_set_tcr_t0sz
macro.
Please check v3!
> 
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
> > ---
> >
> > Changes in v2:
> > - Condition is updated
> >
> > ---
> >  arch/arm64/include/asm/mmu_context.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/mmu_context.h
> > b/arch/arm64/include/asm/mmu_context.h
> > index c768d16b81a4..bd19f4c758b7 100644
> > --- a/arch/arm64/include/asm/mmu_context.h
> > +++ b/arch/arm64/include/asm/mmu_context.h
> > @@ -72,11 +72,11 @@ static inline void __cpu_set_tcr_t0sz(unsigned
> > long t0sz)  {
> >  	unsigned long tcr = read_sysreg(tcr_el1);
> >
> > -	if ((tcr & TCR_T0SZ_MASK) >> TCR_T0SZ_OFFSET == t0sz)
> > +	if ((tcr & TCR_T0SZ_MASK) == t0sz)
> >  		return;
> >
> >  	tcr &= ~TCR_T0SZ_MASK;
> > -	tcr |= t0sz << TCR_T0SZ_OFFSET;
> > +	tcr |= t0sz;
> >  	write_sysreg(tcr, tcr_el1);
> >  	isb();
> >  }
> > --
> > 2.34.1
> >


