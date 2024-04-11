Return-Path: <linux-kernel+bounces-140441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1DD8A14B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994FB289A05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF28CBA49;
	Thu, 11 Apr 2024 12:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oPWMdhyL"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752A7633
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838873; cv=none; b=Q4mUnyyKJ0gECse2+r6GJ7yBJMODxhchr+So9Eby8VAGS+17qbp9db2X+wgpwx6QBaW8rI+sy10W69RI/nIC00ZKpMiUVw4QFcAC+MlxGrNi1Bd6i4K2M1+NqFpSNiIhYxJGSSGZwg1g+8cnvTLWUynCH5kNCoHvrt4E5VFDF6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838873; c=relaxed/simple;
	bh=CWuT0JYg/EjAXvaq2+5+8lvflEeg5Eg7XoxdIkmg4UY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=pnOh39cL9QyJxx1Y83e63eQCGJcLEaNFo4KrNQ70KS7mkDojMFoGndabvlmjINLKL1SXLXYMkAYCbgEfw4ZGzeONH4cjjuxf4OhugZw2PQzv+Nb/Yj4KFCA0NUSrppKDmInUVXUQaSogXCxwL9r0CXuZuYZyN5vWqpPs8nD+b9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oPWMdhyL; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240411123427epoutp01e8f15ad790eb6f5a2fa0314738a5a248~FOd-hCW7T1074410744epoutp01U
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:34:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240411123427epoutp01e8f15ad790eb6f5a2fa0314738a5a248~FOd-hCW7T1074410744epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712838867;
	bh=Ju63U5TlqqPDL5bwQRxtQV35ovfmmBUlGC4L8w6oZ0E=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=oPWMdhyLm+o6+7apYsTUHiLV8D3zEE1pCQqJR08JPTy/TFz72wk/EBSjKkH5GkKCc
	 uLF6FErdnXwIz/QIVkOLy7aQB35tS8zURCKFCPh8hqKaVaCNqnBpTrGcWzf0VGNnEu
	 OU+Ko3K7Fru9JV3Z69gSxlfVT1Pg9XFLj3+byqg4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240411123425epcas1p4cd3f9fd5bd57a679ed50c9a4f1e57936~FOd_MR51v0589805898epcas1p45;
	Thu, 11 Apr 2024 12:34:25 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.225]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VFfJx1bPHz4x9Pv; Thu, 11 Apr
	2024 12:34:25 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	8C.3A.10158.1D8D7166; Thu, 11 Apr 2024 21:34:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240411123424epcas1p332af61d4009555e32e277b70b31a411f~FOd9i_XzG1026910269epcas1p31;
	Thu, 11 Apr 2024 12:34:24 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240411123424epsmtrp11c5c2666a03035a68eb521a38ed7fd91~FOd9hyXBe0037700377epsmtrp1N;
	Thu, 11 Apr 2024 12:34:24 +0000 (GMT)
X-AuditID: b6c32a38-8e1ff700000027ae-1d-6617d8d1b627
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	EC.95.19234.0D8D7166; Thu, 11 Apr 2024 21:34:24 +0900 (KST)
Received: from sgsupark03 (unknown [10.252.69.53]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240411123424epsmtip1542d9c86fd41c04bbc7e5e8f7c69dddf~FOd9To7Zd2195321953epsmtip1l;
	Thu, 11 Apr 2024 12:34:24 +0000 (GMT)
From: "Seongsu Park" <sgsu.park@samsung.com>
To: "'Will Deacon'" <will@kernel.org>
Cc: <catalin.marinas@arm.com>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"'Leem	ChaeHoon'" <infinite.run@gmail.com>, "'Gyeonggeon Choi'"
	<gychoi@student.42seoul.kr>, "'Soomin Cho'" <to.soomin@gmail.com>, "'DaeRo
 Lee'" <skseofh@gmail.com>, "'kmasta'" <kmasta.study@gmail.com>
In-Reply-To: <20240410161217.GB25225@willie-the-truck>
Subject: RE: [PATCH v3] arm64: Cleanup __cpu_set_tcr_t0sz()
Date: Thu, 11 Apr 2024 21:34:24 +0900
Message-ID: <09b201da8c0c$95e8d050$c1ba70f0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHvwI0HeBmtypRhXs739VRw5VSDqAF0l7xGAY3KgECxIIKTQA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmru7FG+JpBndaWS3eL+thtNjUdp/R
	4s/G3UwWX/4uZbbY9Pgaq8XlXXPYLJZev8hkMenHFkaL9s8vWC1a7pg6cHmsmbeG0WPnrLvs
	HptWdbJ5bF5S73Ho7AJWj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0t
	zJUU8hJzU22VXHwCdN0yc4AOU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBXo
	FSfmFpfmpevlpZZYGRoYGJkCFSZkZyzuWsZWMEO54sOCeywNjIdluhg5OSQETCS+L2pm6mLk
	4hAS2MEo8X9LAwuE84lR4su/WcxwzsWzv1lhWnou/IRq2cko8XTWfaiq54wSd/+vYAapYhPQ
	kfj2bQoLiC0ioCqx7+cGRpAiZoELTBKd548wgiQ4Bcwk5rw6B2YLC1hLXPu6FqyZBaih99cX
	JhCbV8BS4tm9fkYIW1Di5MwnYEOZBeQltr+dwwxxkoLEz6fLWCGWOUncWrCTFaJGRGJ2ZxvY
	dRICSzkk3m5+AtXgIvF8RjMbhC0s8er4FnYIW0riZX8blF0sse/LGqj6GokH8/ZA2fYSHc/a
	gI7gAFqgKbF+lz7ELj6Jd197WEHCEgK8Eh1tQhCmssS5rY4QpqTEnwV6EDM8JD5uX8o6gVFx
	FpK/ZiH5axaS+2chrFrAyLKKUSy1oDg3PbXYsMAEHtnJ+bmbGMFpVstiB+Pctx/0DjEycTAe
	YpTgYFYS4ZXWEk0T4k1JrKxKLcqPLyrNSS0+xGgKDOmJzFKiyfnARJ9XEm9oYmlgYmZkYmFs
	aWymJM575kpZqpBAemJJanZqakFqEUwfEwenVAOTnDv/Ie3Dj/n39Pywy2c4aD/pV8CLh0ev
	z9647+zzf/xMJjdKNr1Zu6uv1yNxfV5FuoYU/yw+jYux2Rwuk41Fnu8pqA68FdDTuPraYtX3
	5y4mvHbcwnlBZK2Ii3Bl4rY3W+Q1D54p830U+VDL+q3NJQmJ9O1nk1M5V19oZbVsqShdW+ij
	NHU6b3f8ycXFT5Z9nCIeMWvFze/tmjMTTkf3VTbr6atuNJI2Sn33x+/R7Y2mPcldQfe/OGoc
	ti0PMlj5Ja72fmX6zquc+2erGN4vb9OwvNn0R+T7dvffXtXX4/8xTfjtKvLqpcmtli89n3cv
	Fdw68Xpt7rp3uWva+HoVpgQtii08287j03kq9FO0EktxRqKhFnNRcSIANvnRXzwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJTvfCDfE0gwsPdSzeL+thtNjUdp/R
	4s/G3UwWX/4uZbbY9Pgaq8XlXXPYLJZev8hkMenHFkaL9s8vWC1a7pg6cHmsmbeG0WPnrLvs
	HptWdbJ5bF5S73Ho7AJWj8+b5ALYorhsUlJzMstSi/TtErgyFnctYyuYoVzxYcE9lgbGwzJd
	jJwcEgImEj0XfjJ1MXJxCAlsZ5ToWHuNCSIhKdH+7jJLFyMHkC0scfhwMUTNU0aJZWdOsYHU
	sAnoSHz7NoUFxBYRUJXY93MDI4jNLHCDSeL7c1W4oU8+vQJLcAqYScx5dQ7MFhawlrj2dS0z
	iM0C1Nz76wvYYl4BS4ln9/oZIWxBiZMzn4AdwSygJ9G2EWq+vMT2t3OYIe5UkPj5dBkrxA1O
	ErcW7GSFqBGRmN3ZxjyBUXgWkkmzECbNQjJpFpKOBYwsqxhFUwuKc9NzkwsM9YoTc4tL89L1
	kvNzNzGC40wraAfjsvV/9Q4xMnEwHmKU4GBWEuGV1hJNE+JNSaysSi3Kjy8qzUktPsQozcGi
	JM6rnNOZIiSQnliSmp2aWpBaBJNl4uCUamBaXstkckji10/5b1cun3LPsLgTnOJ37avO/jaV
	iUd2fbdpzU+9rt2aYWCr7veVr+TsnneVz1MSQrxeLzEpY+jPnTIz/2LbS2f1i/MLUrce4+M5
	NimDy6pvSmfw8sad1ZHPLoQvmxFwynRW1x1GwTfbVLI89rGc6pDgcugXZnZZumDVBdW9Cp1v
	+kqa0rcwdu306ll597a7oWVDpNrn8yv29orej+SY8n7dhs0MLq83iC7e/C7hzbfsE4brHQLM
	zAXi3C40brs8c8O25cxfDW+x7etiylmcHCreeTao5pjJronqWvvNRDUenLn8rarTxTlcYa00
	F0Pa9S9ic/I6Or9WnGx99WPj2wXnufPEmPqUWIozEg21mIuKEwH7ysE3IgMAAA==
X-CMS-MailID: 20240411123424epcas1p332af61d4009555e32e277b70b31a411f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240408024022epcas1p176f9509f6f85fd8dbfa2dd17067a8aee
References: <CGME20240408024022epcas1p176f9509f6f85fd8dbfa2dd17067a8aee@epcas1p1.samsung.com>
	<20240408024016.490516-1-sgsu.park@samsung.com>
	<20240410161217.GB25225@willie-the-truck>



> 
> On Mon, Apr 08, 2024 at 11:40:16AM +0900, Seongsu Park wrote:
> > In cpu_set_default_tcr_t0sz(), it is an error to shift TCR_T0SZ_OFFSET
> > twice form TCR_T0SZ() and __cpu_set_tcr_t0sz().
> > Since TCR_T0SZ_OFFSET is 0, no error occurred.
> > We need to clarify whether the parameter of __cpu_set_tcr_t0sz is a
> > shifted value or an unshifted value.
> >
> > We have already shifted the value of t0sz in TCR_T0SZ by
TCR_T0SZ_OFFSET.
> > This is necessary for consistency with TCR_T1SZ.
> > Therefore, the parameter of __cpu_set_tcr_t0sz is clarified as a
> > shifted value.
> 
> This commit message needs reworking. I would suggest something like:
> 
>   The T0SZ field of TCR_EL1 occupies bits 0-5 of the register and
>   encodes the virtual address space translated by TTBR0_EL1. When
>   updating the field (for example, because we are switching to/from
>   the idmap page-table), __cpu_set_tcr_t0sz() erroneously treats its
>   't0sz' argument as unshifted, resulting in harmless but confusing
>   double shifts by 0 in the code.
> 
>   Remove the unnecessary shifts.
> 

Thank you for great feedback.
Please check title and description. 
If these are appropriate, I will write the same in v4.

[Title]
arm64: Cleanup __cpu_set_tcr_t0sz()

[Description]
The T0SZ field of TCR_EL1 occupies bits 0-5 of the register and
encodes the virtual address space translated by TTBR0_EL1. When
updating the field, for example because we are switching to/from
the idmap page-table, __cpu_set_tcr_t0sz() erroneously treats its
't0sz' argument as unshifted, resulting in harmless but confusing
double shifts by 0 in the code. Therefore, Remove the unnecessary
shifts.

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
> Honestly, although it's great that you all meet up to look at the kernel,
> this long list of credits is a little absurd for a trivial patch like
this.
> Please can you decide who did the most work and give them the credit?
> Hopefully there will be future opportunities for you all to contribute!
> 

Okay. I got it.
In v4, I'll leave only Leem ChaeHoon and me.

> > ---
> >
> > v2:
> >  - Condition is updated
> > v3:
> >  - Commit message is updated
> >  - cpu_set_tcr_t0sz macro is added
> >
> > ---
> >  arch/arm64/include/asm/mmu_context.h | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/mmu_context.h
> > b/arch/arm64/include/asm/mmu_context.h
> > index c768d16b81a4..fb603ec7f61f 100644
> > --- a/arch/arm64/include/asm/mmu_context.h
> > +++ b/arch/arm64/include/asm/mmu_context.h
> > @@ -72,15 +72,16 @@ static inline void __cpu_set_tcr_t0sz(unsigned
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
> >
> > +#define cpu_set_tcr_t0sz(t0sz)
> 	__cpu_set_tcr_t0sz(TCR_T0SZ(t0sz))
> >  #define cpu_set_default_tcr_t0sz()
> 	__cpu_set_tcr_t0sz(TCR_T0SZ(vabits_actual))
> >  #define cpu_set_idmap_tcr_t0sz()	__cpu_set_tcr_t0sz(idmap_t0sz)
> >
> > @@ -134,7 +135,7 @@ static inline void cpu_install_ttbr0(phys_addr_t
> > ttbr0, unsigned long t0sz)  {
> >  	cpu_set_reserved_ttbr0();
> >  	local_flush_tlb_all();
> > -	__cpu_set_tcr_t0sz(t0sz);
> > +	cpu_set_tcr_t0sz(t0sz);
> 
> Sorry, but this is wrong. Please have a look at how cpu_install_ttbr0() is
> called; specifically how trans_pgd_idmap_page() sets up 't0sz'.
> 
> So I don't think you should change cpu_install_ttbr0() at all and adding a
> cpu_set_tcr_t0sz() macro which calls TCR_T0SZ on the 't0sz' argument is a
> mistake.
> 
> Will

Oops. You're right. My mistake.
In v4, I'll remove this.


