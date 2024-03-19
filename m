Return-Path: <linux-kernel+bounces-106992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD5687F665
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86211F234F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDDC7C0BA;
	Tue, 19 Mar 2024 04:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZTAFK3kI"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53217C0BE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 04:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710822384; cv=none; b=UQtpsyfKMj4k1vidUS6bGNxRP50hvYhaMS/siVGzJpEsP2UHTW4WrblYSqmbPYbef26YlQtITun24z2A1+IVwB3JJQFomEQ1G4rlGneLbMEK+nqKLPzTsPeGAlyEOjzMG0XQ44UB1eBAsBxkkCIGGFnpc2LAbeZ0s943fcWfc8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710822384; c=relaxed/simple;
	bh=u02e9JnhtgF01wLoGi9eloHZoYbmUfQfrlrPML9EgIU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Dl0Ijahw1cpLwcvo7hsZs+tLSlCr4WjRO5+IzRYrQbGKkG+9h1NlNMTqYQLR8KorY10mFraC9HZ7r8ddVa9mc/ck87AujZxX6FfDfDPIiF3duCFwnWCbwYICiglU2N4tZj0K0p0AivtdZefhUGLNEsw98BQ29zBOUs/YJTfIEOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZTAFK3kI; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710822380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgOYrA8AEdh1woTHtD2vW3ca3PCtrZkdcZD77qbWikM=;
	b=ZTAFK3kIV8AKtSNFLFj4r5t0E2RLRk79ahMgFgMUh3jepMgCaS/mVJWw+RNCCrBHBN52gG
	NXM8ti3nDdYB1W5KBlYW6GIieZZXNfTfpKEBYqCv/yKV1dd9Ool2dQxzcp3DvEWHCDX49h
	rpX1jczrZg5j7IQxr3uyYzwVPdmEh3E=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2 05/14] mm/sparc: Change pXd_huge() behavior to exclude
 swap entries
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240318200404.448346-6-peterx@redhat.com>
Date: Tue, 19 Mar 2024 12:25:39 +0800
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 x86@kernel.org,
 Mike Rapoport <rppt@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 sparclinux@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>,
 linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-arm-kernel@lists.infradead.org,
 "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <744C19CB-4AE0-472B-ABD8-2064EB04FDA0@linux.dev>
References: <20240318200404.448346-1-peterx@redhat.com>
 <20240318200404.448346-6-peterx@redhat.com>
To: Peter Xu <peterx@redhat.com>
X-Migadu-Flow: FLOW_OUT



> On Mar 19, 2024, at 04:03, peterx@redhat.com wrote:
>=20
> From: Peter Xu <peterx@redhat.com>
>=20
> Please refer to the previous patch on the reasoning for x86.  Now =
sparc is
> the only architecture that will allow swap entries to be reported as
> pXd_huge().  After this patch, all architectures should forbid swap =
entries
> in pXd_huge().
>=20
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> arch/sparc/mm/hugetlbpage.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
> index b432500c13a5..d31c2cec35c9 100644
> --- a/arch/sparc/mm/hugetlbpage.c
> +++ b/arch/sparc/mm/hugetlbpage.c
> @@ -409,14 +409,12 @@ pte_t huge_ptep_get_and_clear(struct mm_struct =
*mm, unsigned long addr,
>=20
> int pmd_huge(pmd_t pmd)
> {
> - 	return !pmd_none(pmd) &&
> - 	(pmd_val(pmd) & (_PAGE_VALID|_PAGE_PMD_HUGE)) !=3D _PAGE_VALID;
> + 	return pmd_leaf(pmd);;

There is a redundant semicolon in the end.

Thanks.

> }
>=20
> int pud_huge(pud_t pud)
> {
> - 	return !pud_none(pud) &&
> - 	(pud_val(pud) & (_PAGE_VALID|_PAGE_PUD_HUGE)) !=3D _PAGE_VALID;
> + 	return pud_leaf(pud);
> }
>=20
> static void hugetlb_free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
> --=20
> 2.44.0
>=20


