Return-Path: <linux-kernel+bounces-42147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D697D83FD09
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84EB41F2484C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2989111C85;
	Mon, 29 Jan 2024 03:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="keS0dqRx"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C5A10A0C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706500651; cv=none; b=ST1JLaNj3WrWcbBv1tQk7zrDYBBXKcpZD8lEtZgb1+g7CjtMJlsmjb+/XQSDAGnyJ5bzdTsrXm1GaFqFgttQdI+1sivD2iu+dqyz0GzPHHxJQEYsP1y7b33EGW3xFcFX3VYzOk4GoAJKzrE5u6klkcDFwcOzv6ndl+qHENbVf/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706500651; c=relaxed/simple;
	bh=R+zR3Df4qnNIL3eTw7MA45glaoiZPZ+jeMBPXhiX3BY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Eog7QWHutOyBKhnwRf6yWS5W6E4PI063E0lrj5gRZB/s4nyhXTIbn3hC/vddvHyEkJA2b469c9w8t6QQOnaqwVYiyvivg4mgg76igFAxL2+X0Kol0HslXbezxj2vbJ2t3BEiuOwliZmY0SVw/SZSj+P0I7Lt4Lx3AuYg4ZJA01Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=keS0dqRx; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706500646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/U+6Jt6zzN7t+CXKZ0VQY8dQzU9nAL3RP8JSzq+IHo=;
	b=keS0dqRxPRiAngPQAcoYA4v9E9NxoosVyBsFbPKXyOYV2m8GyqSoDOLfoKbfTOfzlOvlGv
	uTeZA6bChIQj0LYaEuIZUSLHlYK1cG8a/dIxM/q+6fGKhNe+rNYzrEs1hK1Dpb0pdm+KWE
	9xKuf64mOSTs/mZs6LMRu/XpYs1Wnr8=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v5 7/7] hugetlb: parallelize 1G hugetlb initialization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240126152411.1238072-8-gang.li@linux.dev>
Date: Mon, 29 Jan 2024 11:56:47 +0800
Cc: David Hildenbrand <david@redhat.com>,
 David Rientjes <rientjes@google.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 ligang.bdlg@bytedance.com
Content-Transfer-Encoding: 7bit
Message-Id: <AB9131A0-F9D7-4FF2-9882-A7CBCFC582F2@linux.dev>
References: <20240126152411.1238072-1-gang.li@linux.dev>
 <20240126152411.1238072-8-gang.li@linux.dev>
To: Gang Li <gang.li@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Jan 26, 2024, at 23:24, Gang Li <gang.li@linux.dev> wrote:
> 
> Optimizing the initialization speed of 1G huge pages through
> parallelization.
> 
> 1G hugetlbs are allocated from bootmem, a process that is already
> very fast and does not currently require optimization. Therefore,
> we focus on parallelizing only the initialization phase in
> `gather_bootmem_prealloc`.
> 
> Here are some test results:
>      test case       no patch(ms)   patched(ms)   saved
> ------------------- -------------- ------------- --------
>  256c2T(4 node) 1G           4745          2024   57.34%
>  128c1T(2 node) 1G           3358          1712   49.02%
>     12T         1G          77000         18300   76.23%
> 
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> Tested-by: David Rientjes <rientjes@google.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


