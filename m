Return-Path: <linux-kernel+bounces-15053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71978226B1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146481C21CC6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B7317994;
	Wed,  3 Jan 2024 01:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DX4kW3vT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4675B17981
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 01:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 2 Jan 2024 17:53:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704246822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiVWBuGZIydpDJC/yno1hNw/poDUjUAbK2fa/TQ5+Y4=;
	b=DX4kW3vT1n+jkYbgYChJ+oqAtMuww/aSZPs+bccffY5xO8nFb5qkzqQW2oMZeWl9XSolAD
	8jW+SRw8TzJmqwOdcFaibdkamk5V6UUco2ssEl+zdnrb0sc8ccIlTz6wH30Abw2CM6MXV+
	GLYD7shtTkKdDQUOlbmcEvX99Xqey0M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	shakeelb@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: list_lru: disable memcg_aware when cgroup.memory
 is set to "nokmem"
Message-ID: <ZZS-IFA6TScotocU@P9FQF9L96D>
References: <20231228062715.338672-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228062715.338672-1-haifeng.xu@shopee.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 28, 2023 at 06:27:14AM +0000, Haifeng Xu wrote:
> Actually, when using a boot time kernel option "cgroup.memory=nokmem",
> all lru items are inserted to list_lru_node. But for those users who
> invoke list_lru_init_memcg() to initialize list_lru, list_lru_memcg_aware()
> returns true. And this brings unneeded operations related to memcg.
> 
> To make things more convenient, let's disable memcg_aware when
> cgroup.memory is set to "nokmem".

I guess it's not only more convenient, but also should save a bit of memory.
But _probably_ not enough to justify messing up with stable backports.
Do you have any data on memory savings?

> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

