Return-Path: <linux-kernel+bounces-15070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7C28226F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A72ECB209E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB0617980;
	Wed,  3 Jan 2024 02:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lNPDRige"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3931171C4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 02:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <958bf051-e776-4cbf-ae3c-76ee82d55bcc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704248570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zW0ynOCiWkqnAZ1LOZJ8b5gEX+aiqOQ8TMoqLnbStxU=;
	b=lNPDRigemVrcHRahrMfRuzKZcN7ZC/aiSMeb3lX894JA808MTBR3dEX2UTrJy1J0ABLOhn
	e4L/lhw4axnySR6p0F7vbjmY/qX5OG5dpVndfGIVB+lJNsyM+DUyNY0pbMtoioNatl6Jh9
	s3h4aGcE1i5zrmS7G2bDbo3UsWf9TfI=
Date: Wed, 3 Jan 2024 10:22:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/7] hugetlb: pass *next_nid_to_alloc directly to
 for_each_node_mask_to_alloc
Content-Language: en-US
To: David Rientjes <rientjes@google.com>
Cc: David Hildenbrand <david@redhat.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ligang.bdlg@bytedance.com
References: <20240102131249.76622-1-gang.li@linux.dev>
 <20240102131249.76622-5-gang.li@linux.dev>
 <19b08bb8-1fbd-557b-2684-5c29c5c783e6@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <19b08bb8-1fbd-557b-2684-5c29c5c783e6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/1/3 09:32, David Rientjes wrote:
> Same error as v2:
> 
> mm/hugetlb.c:3315:53: warning: variable 'node' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
>          for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node, &node_states[N_MEMORY]) {
>          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/hugetlb.c:1501:3: note: expanded from macro 'for_each_node_mask_to_alloc'
>                  nr_nodes > 0 &&                                         \
>                  ^~~~~~~~~~~~
> mm/hugetlb.c:3342:38: note: uninitialized use occurs here
>          list_add(&m->list, &huge_boot_pages[node]);
>                                              ^~~~
> mm/hugetlb.c:3315:53: note: remove the '&&' if its condition is always true
>          for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node, &node_states[N_MEMORY]) {
>                                                             ^
> mm/hugetlb.c:3310:7: warning: variable 'node' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>                  if (!m)
>                      ^~
> mm/hugetlb.c:3342:38: note: uninitialized use occurs here
>          list_add(&m->list, &huge_boot_pages[node]);
>                                              ^~~~
> mm/hugetlb.c:3310:3: note: remove the 'if' if its condition is always true
>                  if (!m)
>                  ^~~~~~~
> mm/hugetlb.c:3304:20: note: initialize the variable 'node' to silence this warning
>          int nr_nodes, node;
>                            ^
>                             = 0
> 2 warnings generated.
> 

How did you get those warnings? I got nothing in my compilation.

