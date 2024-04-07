Return-Path: <linux-kernel+bounces-134231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 608BB89AF52
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2BF1F21D0F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F97107A8;
	Sun,  7 Apr 2024 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CF3DDT0+"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD6F7484
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712476995; cv=none; b=ttCQJbOK5/x8Tlcsr/UN53ajoRUnmekajPryZNgq1vmSA/9X9ZjUOjOXyPFrcPMWUEkCDd+Y8brtnobpCR6AAwqUmsFgj8aD+qEly40OWVJ4X2JeAuj/GgoesA4B+55vmx9fPUbptbS8LFs/MTnu1HNkTeISw/X4wTCHKd26fd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712476995; c=relaxed/simple;
	bh=VpCRfGVmAZH+eRewYKO1bd92dnbG0HP+33QgL9TtfzA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EK5F3jIg+3HjUuMtMJfF+Q0fpVdQlPq0ZP0jYCcrN4Cl1z/QhIf791IhwM2B7v8NIxGt/Hg757cccddj9Qj86FsxZ89bqi0Kg1nOp19oiBN8mXaz52usE/IyRCUF0I2gmFbDXx7c8YSutCITYX2dV32h0OaVE78OeXyXF98bkMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CF3DDT0+; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712476990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDol3Thk1zGuXnMJZM7JUv81lJKthEk370IWT+a5GiA=;
	b=CF3DDT0+NCXjui8lYn41GwetR5UjLID4XSWDzMloC8+rMpUZJAXTbXwgZ1V7Od+eXBCyBw
	CHC6cUUDnod1a53rMx9Oos0rmTBG73MVQg9Gzp51/dVh/sup81/srVTq0u3+8cp6E4Pa3+
	7//QRlZbmuPkEFfjnH9gn9fVGVFQhPc=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH 2/2] mm/hugetlb: pass correct order_per_bit to
 cma_declare_contiguous_nid
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240404162515.527802-2-fvdl@google.com>
Date: Sun, 7 Apr 2024 16:02:35 +0800
Cc: Linux-MM <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org,
 Roman Gushchin <roman.gushchin@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5037C21B-92A9-4125-B644-02CC6EBD7B08@linux.dev>
References: <20240404162515.527802-1-fvdl@google.com>
 <20240404162515.527802-2-fvdl@google.com>
To: Frank van der Linden <fvdl@google.com>
X-Migadu-Flow: FLOW_OUT



> On Apr 5, 2024, at 00:25, Frank van der Linden <fvdl@google.com> =
wrote:
>=20
> The hugetlb_cma code passes 0 in the order_per_bit argument to
> cma_declare_contiguous_nid (the alignment, computed using the
> page order, is correctly passed in).
>=20
> This causes a bit in the cma allocation bitmap to always represent
> a 4k page, making the bitmaps potentially very large, and slower.
>=20
> So, correctly pass in the order instead.
>=20
> Signed-off-by: Frank van der Linden <fvdl@google.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic =
hugepages using cma")
> ---
> mm/hugetlb.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 23ef240ba48a..6dc62d8b2a3a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7873,9 +7873,9 @@ void __init hugetlb_cma_reserve(int order)
> 		* huge page demotion.
> 		*/
> 		res =3D cma_declare_contiguous_nid(0, size, 0,
> - 						PAGE_SIZE << =
HUGETLB_PAGE_ORDER,
> - 						0, false, name,
> - 						&hugetlb_cma[nid], nid);
> +						PAGE_SIZE << =
HUGETLB_PAGE_ORDER,
> +						HUGETLB_PAGE_ORDER, =
false, name,

IIUC, we could make the optimization further to change order_per_bit to
'MAX_PAGE_ORDER + 1' since only gigantic hugetlb pages could allocated =
from
the CMA pool meaning any gigantic page is greater than or equal to the
size of two to the power of 'MAX_PAGE_ORDER + 1'.

Thanks.

> +						&hugetlb_cma[nid], nid);
> 		if (res) {
> 			pr_warn("hugetlb_cma: reservation failed: err =
%d, node %d",
> 				res, nid);
> --=20
> 2.44.0.478.gd926399ef9-goog
>=20


