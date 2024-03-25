Return-Path: <linux-kernel+bounces-117699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2213D88AE95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3595629F294
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F412E82C69;
	Mon, 25 Mar 2024 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pEhhLUwA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DFE82877
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391064; cv=none; b=KN/pR2uifgchhiSTwwMIT2VmP0WWt78xJ5JvQlJNvokqPCllEyfxF9fpJYH/xjyjmVjUkU0EX7RvL/6nBZW6jgSyO3beJ67cRg/UZATETEZp4SoolypFRCYyYMnqK6OiIGx6yx+6Zxj7P7sjnvviNcrLbKWqAvbKS+/TrPFjAws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391064; c=relaxed/simple;
	bh=j80BcY2Zkn21OowuqDrofIC9hVMehNU1ENYULjuQbBE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nveavmAflZd7ybpfF7k34r3umfH1boWHLu6jqECuaxeKDKDL2xQGvo5OltuadwbPT+eLr7I1dGVrb7JYCQZWFhlnfyhEQ8sRw84jYwfdTedKvkU1sP29DV5LwXUHePh0pc1cogg0rsEILFM4ZzWO92uOdeUo3C+aBXibg8LlsK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pEhhLUwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B8AC433C7;
	Mon, 25 Mar 2024 18:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711391063;
	bh=j80BcY2Zkn21OowuqDrofIC9hVMehNU1ENYULjuQbBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pEhhLUwA51PGLAAMnxNU6v6huBSqTsJBGz5Qk6lk6DT5/TmO0jylq5BevwFg2jYVB
	 X6cUxO5d9gInKRupWdt5dFyT5y+5bRZFJpCIXTe1X8ViWfk/w4wvLGwDp/rDy8r355
	 VHGqAXzwo/A746SZj+43kO1BZzhwsuPdUP4fwRTE=
Date: Mon, 25 Mar 2024 11:24:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Donet Tom <donettom@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Aneesh Kumar
 <aneesh.kumar@kernel.org>, Huang Ying <ying.huang@intel.com>, Michal Hocko
 <mhocko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Mel Gorman
 <mgorman@suse.de>, Feng Tang <feng.tang@intel.com>, Andrea Arcangeli
 <aarcange@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Rik van Riel <riel@surriel.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Vlastimil Babka
 <vbabka@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Hugh Dickins
 <hughd@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Suren
 Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 0/2] Allow migrate on protnone reference with
 MPOL_PREFERRED_MANY policy
Message-Id: <20240325112422.7d52c9ba4b00ac2e5a125d89@linux-foundation.org>
In-Reply-To: <cover.1711373653.git.donettom@linux.ibm.com>
References: <cover.1711373653.git.donettom@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 09:24:12 -0500 Donet Tom <donettom@linux.ibm.com> wrote:

> V4
> - Added an example in the "PATCH 2/2" commit message as per the discussion
>   from V3.

Thanks, I updated the changelogs in place.

