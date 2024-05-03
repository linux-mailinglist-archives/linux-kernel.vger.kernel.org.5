Return-Path: <linux-kernel+bounces-167992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34578BB1FB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE2D282EF0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C95158216;
	Fri,  3 May 2024 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G2jsJzdv"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9580913B593
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714758930; cv=none; b=S4NibBJ7LRjOALG6FTSZzF55d3rmoJ+dQcoIJz7oDS6jRsF0XkFQPgXwHV6RWGI4guGqXiA4ygFnkG+OLvWnnq44r3Kbee5fRw84Gi37aLPjan3f8n/2bl7uT0q+2gXrGtEzaEx5RPq5hbfwlgRui7yfYQYbmb3zvYCEQVYbl7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714758930; c=relaxed/simple;
	bh=XThys+ktto6hQQOqPTl+PFdGrawJ1c4UzykbwV+R3xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXMyPFYj1JaxLtf8+T+kFNIRu6/Pfk/uWLEbnHIbKcWTMpCTlsH2JMp7b1wuimC1bw5qRk9UjIasEBjHsJJdbYLj4fOIsQkkKnbVh4JHyxPoKcJrRC9shbC4wf4WgFU7hHRe+L6Cxikj031P4R0NlKbsuLPUVthhOTRn1jE/m2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G2jsJzdv; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 3 May 2024 10:55:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714758925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cNuFKKqLOLJhX8SMJaQF7/ByglEMXWCW5PIO2/lIa4I=;
	b=G2jsJzdvuUZLp4eVhkc8hSzuT9z9bvTkl0J5Q0mseVFULP7/68+AzPCz89WfVZFXA9LVrc
	6LhE6NmD0yFvLnnUDePInuiyk3TBhDTnw/qv0m2zg+DHau2DtgaDKLsmCGlAZwTCs52jZo
	0ppd4S6dB02WPP20Vu4C7t0AMo3Ys5k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev
Subject: Re: [PATCH 3/4] selftests/cgroup: cpu_hogger init: use {} instead of
 {NULL}
Message-ID: <ZjUlBqTN1tmGj58q@P9FQF9L96D>
References: <20240503035105.93280-1-jhubbard@nvidia.com>
 <20240503035105.93280-4-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503035105.93280-4-jhubbard@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 02, 2024 at 08:51:04PM -0700, John Hubbard wrote:
> First of all, in order to build with clang at all, one must first apply
> Valentin Obst's build fix for LLVM [1]. Once that is done, then when
> building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftests
> 
> ...clang generates warning here, because struct cpu_hogger has multiple
> fields, and the code is initializing an array of these structs, and it
> is incorrect to specify a single NULL value as the initializer.
> 
> Fix this by initializing with {}, so that the compiler knows to use
> default initializer values for all fields in each array entry.
> 
> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

