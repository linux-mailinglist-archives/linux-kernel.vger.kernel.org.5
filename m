Return-Path: <linux-kernel+bounces-10902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA9481DE99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250C61C20AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 06:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D910139E;
	Mon, 25 Dec 2023 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="edZvnBr8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268151106
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 06:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3592af35-83c6-4941-a4fc-e8a5ff06218d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703485458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYyeA7lnwVX2F2rNMF4VNboxU63hQ2V7WPBxBA8y4Z4=;
	b=edZvnBr8nHc/em2PYLG8ck+pIwqi+qej4mDEBr3WhQzxWNlNjmMr74gNQbDzuGsUrfOIK0
	Un5MObPo4yurXNu3AE5p0apCz0k3RnPSxbTzDsdXeDyRwD5/VoF6cYUisxV14wtiR34EA9
	a+2QtmxUnzM72tQurQFrRM6+ZOFZKys=
Date: Mon, 25 Dec 2023 14:24:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 0/5] hugetlb: parallelize hugetlb page init on boot
To: David Rientjes <rientjes@google.com>, Gang Li <ligang.bdlg@bytedance.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>,
 David Hildenbrand <david@redhat.com>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20231208025240.4744-1-gang.li@linux.dev>
 <996ba32c-78f0-1807-5e64-af5841a820e7@google.com>
 <20231212230813.GB7043@monkey>
 <55c6c1f6-0792-61c3-86ed-4729d4a3fdf5@google.com>
 <46bc7aa3-4b08-4e5f-9563-485ee17e2785@bytedance.com>
 <4c6de257-ebb4-e9ad-4092-b81a8039aff4@google.com>
 <76becfc1-e609-e3e8-2966-4053143170b6@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <76becfc1-e609-e3e8-2966-4053143170b6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2023/12/25 13:21, David Rientjes wrote:
> With that, I compared "hugepagesz=1G hugepages=11776" before and after on
> a 12TB host with eight NUMA nodes.
> 
> Compared to 77s of total initialization time before, with this series I
> measured 18.3s.
> 
> Feel free to add this into the changelog once the initialization issues
> are fixed up and I'm happy to ack it.
> 
> Thanks!

Cool! Thank you ;)

