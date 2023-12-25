Return-Path: <linux-kernel+bounces-10894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1369C81DE2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 06:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF71A28188A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 05:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08F7110B;
	Mon, 25 Dec 2023 05:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dy7j46Xj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A577510EE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 05:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-35ffc781b3bso106215ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 21:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703481665; x=1704086465; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTMbzj7ozG/NFL0qtSoENzSfcq7X8aUmLe01ANOMZhU=;
        b=dy7j46XjHpt3CNhwoBgx0rqRd7SMl1Ty4plfvMBeAjGrK4Z7qNMpkFTvFjf03Bxpfl
         +zbomv7KyAYJ07U+Y6NO3SFuROPsrP/m/gYjXTGaLbhS/zZFba4kigW+kAtHi1Smv9Kp
         R34CumOvVsle4XG/PYaSSR9F1K3nwJe2M96gzv2QrUmbSBqfQyaoM+H5NdyLaG2Rao/6
         hjz+aFivyEArXWvQ5PUp3zkkHry+RZ9s9I6wfy1t1ACqlR2iiIOZWL6vbA7cG2c9IaPC
         z03Uey52XdokI+934xV45ooJkj3/leD70nNIrXOWBvRqyqXAhFdR33O4wfk2UPwBFlZB
         7TZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703481665; x=1704086465;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTMbzj7ozG/NFL0qtSoENzSfcq7X8aUmLe01ANOMZhU=;
        b=ClJ5L3z/Z07W9C63a5lOEmNaNtCKVDP/mevZIDJuonDXVzgRzXLSQMONG5fl3jtu2N
         4SLweXjlA+3OruUfCtgVQZabVGMtWXqgyeL5Csmu7OZu8W1p1drATAB5EuPgcvFUOpXa
         xnCmoN2hg7RNv07s80plCk3Df2SIoniKTwBvOp71FZzoINkxewboCA01Jezb4y1ONgFb
         STlqgCeia/eVCmeGn9+hM11+nRPRq7WnZVU+E2iCQfU8ITdzD28sSorzGK+8o0ICOiKY
         mEHXC6d9dQrJZgmDvq8RY9x+MkoKY4NQj62I0Ubj7G/bs327tFBwFzZej3PNYU1TEEs0
         OoyA==
X-Gm-Message-State: AOJu0YyHT//tomo9Z2FUhYCEQr9RWF6AppWYwXzJt53pXrk8ru2g3Y9M
	Zshkmksl3vrQHYToXDfb1zzZ0Fw5i5j7
X-Google-Smtp-Source: AGHT+IGSKPMU74vf1sgsIw8ea8H5OTZUG/+a6Dc87BWf2D/h73XmwrsQjqU62nU/eoayj69tQUV2DA==
X-Received: by 2002:a05:6e02:d0c:b0:35f:79b5:b980 with SMTP id g12-20020a056e020d0c00b0035f79b5b980mr370882ilj.27.1703481664705;
        Sun, 24 Dec 2023 21:21:04 -0800 (PST)
Received: from [2620:0:1008:15:1457:193a:aad7:2606] ([2620:0:1008:15:1457:193a:aad7:2606])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090ac68c00b0028ae54d988esm7634768pjt.48.2023.12.24.21.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 21:21:03 -0800 (PST)
Date: Sun, 24 Dec 2023 21:21:03 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Gang Li <ligang.bdlg@bytedance.com>
cc: Mike Kravetz <mike.kravetz@oracle.com>, Gang Li <gang.li@linux.dev>, 
    David Hildenbrand <david@redhat.com>, Muchun Song <muchun.song@linux.dev>, 
    Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/5] hugetlb: parallelize hugetlb page init on
 boot
In-Reply-To: <4c6de257-ebb4-e9ad-4092-b81a8039aff4@google.com>
Message-ID: <76becfc1-e609-e3e8-2966-4053143170b6@google.com>
References: <20231208025240.4744-1-gang.li@linux.dev> <996ba32c-78f0-1807-5e64-af5841a820e7@google.com> <20231212230813.GB7043@monkey> <55c6c1f6-0792-61c3-86ed-4729d4a3fdf5@google.com> <46bc7aa3-4b08-4e5f-9563-485ee17e2785@bytedance.com>
 <4c6de257-ebb4-e9ad-4092-b81a8039aff4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 21 Dec 2023, David Rientjes wrote:

> > Hi,
> > 
> > On 2023/12/13 08:10, David Rientjes wrote:
> > > On 6.6 I measured "hugepagesz=1G hugepages=11776" on as 12TB host to be
> > > 77s this time around.
> > 
> > Thanks for your test! Is this the total kernel boot time, or just the
> > hugetlb initialization time?
> > 
> 
> Ah, sorry for not being specific.  It's just the hugetlb preallocation of 
> 11776 1GB hugetlb pages, total boot takes a few more minutes.
> 

I had to apply this to get the patch series to compile on 6.7-rc7:

diff --git a/kernel/padata.c b/kernel/padata.c
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -485,7 +485,7 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
 	struct padata_work my_work, *pw;
 	struct padata_mt_job_state ps;
 	LIST_HEAD(works);
-	int nworks, nid;
+	int nworks, nid = 0;
 
 	if (job->size == 0)
 		return;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3300,7 +3300,7 @@ int alloc_bootmem_huge_page(struct hstate *h, int nid)
 int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 {
 	struct huge_bootmem_page *m = NULL; /* initialize for clang */
-	int nr_nodes, node;
+	int nr_nodes, node = NUMA_NO_NODE;
 
 	/* do node specific alloc */
 	if (nid != NUMA_NO_NODE) {

With that, I compared "hugepagesz=1G hugepages=11776" before and after on 
a 12TB host with eight NUMA nodes.

Compared to 77s of total initialization time before, with this series I 
measured 18.3s.

Feel free to add this into the changelog once the initialization issues 
are fixed up and I'm happy to ack it.

Thanks!

