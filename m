Return-Path: <linux-kernel+bounces-26931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D26C382E7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 03:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B58C1C22885
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FF7611F;
	Tue, 16 Jan 2024 02:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HpceYECQ"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE4C7E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 02:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705373020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JE2bpTRB25qTRW1JNAAUJiNRdS0O6dVGGU7CUmkrmSU=;
	b=HpceYECQKonmijXYZvgMuzJW8BGPvvYBFSKUy7G+Vxz6aNpQHVq7GNRW54DH1uFXMXobtm
	CtPGZYRVk1m+WaWCila1tubp/1F+HC/bNQVLPsymT8rpOYHC4YJj+7IT7Y1/BTfQiVcf6o
	BlHWuAD3vBaP0QqgpuJUb3omleih6Fk=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2] fs/hugetlbfs/inode.c: mm/memory-failure.c: fix
 hugetlbfs hwpoison handling
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240112180840.367006-1-sidhartha.kumar@oracle.com>
Date: Tue, 16 Jan 2024 10:43:00 +0800
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 usama.anjum@collabora.com,
 Jiaqi Yan <jiaqiyan@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <naoya.horiguchi@nec.com>,
 Yang Shi <shy828301@gmail.com>,
 James Houghton <jthoughton@google.com>,
 jane.chu@oracle.com,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1D4F7C82-92BA-4EFC-A082-B5FE30758E91@linux.dev>
References: <20240112180840.367006-1-sidhartha.kumar@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
X-Migadu-Flow: FLOW_OUT



> On Jan 13, 2024, at 02:08, Sidhartha Kumar =
<sidhartha.kumar@oracle.com> wrote:
>=20
> has_extra_refcount() makes the assumption that the page cache adds a =
ref
> count of 1 and subtracts this in the extra_pins case. Commit =
a08c7193e4f1
> (mm/filemap: remove hugetlb special casing in filemap.c) modifies
> __filemap_add_folio() by calling folio_ref_add(folio, nr); for all =
cases
> (including hugtetlb) where nr is the number of pages in the folio. We
> should adjust the number of references coming from the page cache by
> subtracing the number of pages rather than 1.
>=20
> In hugetlbfs_read_iter(), folio_test_has_hwpoisoned() is testing the =
wrong
> flag as, in the hugetlb case, memory-failure code calls
> folio_test_set_hwpoison() to indicate poison. folio_test_hwpoison() is =
the
> correct function to test for that flag.
>=20
> After these fixes, the hugetlb hwpoison read selftest passes all =
cases.
>=20
> Fixes: a08c7193e4f1 ("mm/filemap: remove hugetlb special casing in =
filemap.c")
> Closes: =
https://lore.kernel.org/linux-mm/20230713001833.3778937-1-jiaqiyan@google.=
com/T/#m8e1469119e5b831bbd05d495f96b842e4a1c5519
> Cc: <stable@vger.kernel.org> # 6.7+
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.


