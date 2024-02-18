Return-Path: <linux-kernel+bounces-70592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CB085998A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CBE1C209C8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6147F74271;
	Sun, 18 Feb 2024 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Nbp/Ink4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C68573175
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708292333; cv=none; b=PlZM/UngM4tuZArtdusBWM9el5tvzk55Mad+YPKt2RHMwfBA1lgd1W2pGhIJt0a1L9ye3+Ra/ZM2PTTMqjx8QehyxjzwAbyIsivr2qhJkYbFdPCWuCT9zCDE51tliiOtJOpKSonwotsulK1qqQo4l2+WT8LMkQpaBE8isJgiWyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708292333; c=relaxed/simple;
	bh=KKc8FE2bdtNuk4G8An0mXCAzt6JMeCEm+SY5mrD71fU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=s9r+FUc8WaMuboNIxip2tUB2u2UYFMW3P0vbrC553DwQi1+1ds5tGfkmBiJdPqxFTBdAErsM83/4bOF394O1XGkUGR0M/Btd/o2RwUiDB6OVHzAquhXeIO2zTYT5WtvLExgAoxQeEFQQIQZ9FquKM5YhWZwpeOK/gXAVQH0rjbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Nbp/Ink4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695DAC433C7;
	Sun, 18 Feb 2024 21:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708292333;
	bh=KKc8FE2bdtNuk4G8An0mXCAzt6JMeCEm+SY5mrD71fU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nbp/Ink4ziA5vhwf0sUWh7CGnF72TQNaoyWHagIaLFeTUecm9hccCnqqciGQhjWKO
	 di5+uSUjSAvJEgiscCFr9wkhUdICeUCPnH0cecv0Xc1vrompSDxzq+IV/O95Vb0SGi
	 F3AkUjQkxE8izaOhvNFZiBan40lDCpm4Nnog/IGI=
Date: Sun, 18 Feb 2024 13:38:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Donet Tom <donettom@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Aneesh Kumar
 <aneesh.kumar@kernel.org>, Huang Ying <ying.huang@intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Mel Gorman <mgorman@suse.de>, Ben Widawsky
 <ben.widawsky@intel.com>, Feng Tang <feng.tang@intel.com>, Michal Hocko
 <mhocko@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Rik van Riel
 <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox
 <willy@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, Vlastimil
 Babka <vbabka@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Hugh
 Dickins <hughd@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Suren
 Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 1/3] mm/mempolicy: Use the already fetched local
 variable
Message-Id: <20240218133851.22c22b55460e866a099be5ce@linux-foundation.org>
In-Reply-To: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Feb 2024 01:31:33 -0600 Donet Tom <donettom@linux.ibm.com> wrote:

> Avoid doing a per cpu read and use the local variable thisnid. IMHO
> this also makes the code more readable.
> 
> ...
>
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2526,7 +2526,7 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
>  		if (node_isset(curnid, pol->nodes))
>  			goto out;
>  		z = first_zones_zonelist(
> -				node_zonelist(numa_node_id(), GFP_HIGHUSER),
> +				node_zonelist(thisnid, GFP_HIGHUSER),
>  				gfp_zone(GFP_HIGHUSER),
>  				&pol->nodes);
>  		polnid = zone_to_nid(z->zone);

	int thisnid = cpu_to_node(thiscpu);

Is there any dofference between numa_node_id() and
cpu_to_node(raw_smp_processor_id())?  And it it explicable that we're
using one here and not the other?


