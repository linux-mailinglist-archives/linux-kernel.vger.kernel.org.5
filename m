Return-Path: <linux-kernel+bounces-134271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F3289AFD6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1AD1F222EA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8439111CA0;
	Sun,  7 Apr 2024 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MdmwthX0"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0461170F
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480396; cv=none; b=VhkJ5Oqco0PY4BKHubsMvLPZKs27gy3ML1KfTlOz1nYrQmAmBVnol7ePwGSaWdeGWis1gkfbTWLuMtawmjk9L8X2Ci/M4VGIg1CwU3Szf3mPfPm0ADqUN9wHGIyoFFavJNSQ4HkPKRpBnDEcTMzMe5ye031G37KCEBUGI7T7N54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480396; c=relaxed/simple;
	bh=mYiMrmaIyokARIueucoY2m3aHr6KLAVaPCElSdLYYLA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RY1tpIfe7cGd7NLUVNCVGJfgzyO/vAEohCwPtK+JS43g61C5DrIf4eWL+wFpS3tmcN12Cln3l6nzhxB97TazrNPZKY87QprDQR8KOSgqJzaXWZSPF3wltiZm0Prw9uTztmIq6IqHE4eBi7+e0OzK9weYLjUMbnF5gU+F007ZsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MdmwthX0; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712480390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmlsLVmLcxwali6owfZJlKAmm6iLSvM2+NU6gTc1Z9E=;
	b=MdmwthX0V3X6njLDOvp9NfaqxNSB6UBqMaxuwwdty+8Prq508dITZqvax/Nh+zoJ+Jw6y7
	sARASJGWygTtloekFRWTE+2xcwYbUBJj2xCaM+0d+3NCW6QkLBmhLp7mIoFlL+KQkzEcXl
	6yojE3HnZHJmbI4IQLsxfsnDNys4Kjo=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v2 2/3] hugetlb: Convert hugetlb_no_page() to use struct
 vm_fault
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <CAOzc2pyOusTc2xj2qF9MN8YeZp0dcbsrtPr96QhmJOJ+hX+CLw@mail.gmail.com>
Date: Sun, 7 Apr 2024 16:59:13 +0800
Cc: Oscar Salvador <osalvador@suse.de>,
 Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <73DFA2EE-0929-4801-9C7C-A393F7796CE8@linux.dev>
References: <20240401202651.31440-1-vishal.moola@gmail.com>
 <20240401202651.31440-3-vishal.moola@gmail.com>
 <Zg6iG8cxpopXuFCo@localhost.localdomain>
 <CAOzc2pyOusTc2xj2qF9MN8YeZp0dcbsrtPr96QhmJOJ+hX+CLw@mail.gmail.com>
To: Vishal Moola <vishal.moola@gmail.com>
X-Migadu-Flow: FLOW_OUT



> On Apr 5, 2024, at 03:58, Vishal Moola <vishal.moola@gmail.com> wrote:
>=20
> On Thu, Apr 4, 2024 at 5:49=E2=80=AFAM Oscar Salvador =
<osalvador@suse.de> wrote:
>>=20
>> On Mon, Apr 01, 2024 at 01:26:50PM -0700, Vishal Moola (Oracle) =
wrote:
>>> hugetlb_no_page() can use the struct vm_fault passed in from
>>> hugetlb_fault(). This alleviates the stack by consolidating 7
>>> variables into a single struct.
>>>=20
>>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>>> ---
>>> mm/hugetlb.c | 59 =
++++++++++++++++++++++++++--------------------------
>>> 1 file changed, 29 insertions(+), 30 deletions(-)
>>>=20
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 360b82374a89..aca2f11b4138 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -6189,9 +6189,7 @@ static bool hugetlb_pte_stable(struct hstate =
*h, struct mm_struct *mm,
>>>=20
>>> static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>>>                      struct vm_area_struct *vma,
>>> -                     struct address_space *mapping, pgoff_t idx,
>>> -                     unsigned long address, pte_t *ptep,
>>> -                     pte_t old_pte, unsigned int flags,
>>> +                     struct address_space *mapping,
>>=20
>> AFAICS all this can be self-contained in vm_fault struct.
>> vmf->vma->mm and vmf->vma.
>> I mean, if we want to convert this interface, why not going all the =
way?
>>=20
>> Looks a bit odd some fields yes while some others remain.
>>=20
>> Or am I missing something?
>=20
> Mainly just minimizing code churn, we would either unnecessarily
> change multiple lines using vma or have to declare the variables
> again anyways (or have extra churn I didn't like).

I don't think adding some variables is a problem. I suppose the compiler
could do some optimization for us. So I think it is better to pass
only one argument vmf to hugetlb_no_page(). Otherwise, LGTM.

Muchun,
Thanks.


