Return-Path: <linux-kernel+bounces-110917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5533C8865A8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5E01C22C39
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5A479DD;
	Fri, 22 Mar 2024 03:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c6OnnSu7"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8906FD5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711079495; cv=none; b=foFNHLaDUK3Brkeg/hojUSKK/e+oNoQJ75p+eL72K4OM+RtJSmV+B4GkP7yPJ682/3h+nH/MSupGBtS3QArAIuMqt/czR0rqkIE3tHaLMvES/5yx/3/zGEq6fPfW3ECz2FJoOYbXd5RvREp7KQoAG0aY0AfQgT4LqC/QOpWqkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711079495; c=relaxed/simple;
	bh=LS0IXVsPleK1aMN/6K6ybl1byGi+r7pZ03/ee8W/hBo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=r93sWvJMdsxy4QC43bQzGcjRxrhTM4WEXVSMRp1wz58q974FalXmNbETw/IAnd+Dq0MaPYIjTXZKg9ETsYEaw+/04/6YZRzJJgixQp+2mh3L4wD9VzNtWuP2fDS0kqLGo4WWqgEYGNjRkU0fcvnK2RdJOsoTI12NOgC29hI1ZHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c6OnnSu7; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711079489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UaIF2+8hQSieEX6d0uKpNA4HUIsEN1EiLTbb/fL8ZFE=;
	b=c6OnnSu7jEaq5y4PVZMLdPPPivACLp51RaEGGzzyElG8w60NAeJDf+ySg9Jz5dzZfTRFUb
	SZBgaRD8q9t7ZbJV6wlRMxk9kYqyC1ODoFB15GzxIlSpt0egR0tL0r56Pp/FdTruOfdu2m
	SLvKKRA0y+1czF54k4L5/tU+CucaKXY=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH] selftests/mm: run_vmtests.sh: Fix hugetlb mem size
 calculation
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240321215047.678172-1-peterx@redhat.com>
Date: Fri, 22 Mar 2024 11:50:50 +0800
Cc: Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 David Hildenbrand <david@redhat.com>,
 Nico Pache <npache@redhat.com>
Content-Transfer-Encoding: 7bit
Message-Id: <56CA06CD-3F37-4268-B1B1-9C376AF9B136@linux.dev>
References: <20240321215047.678172-1-peterx@redhat.com>
To: Peter Xu <peterx@redhat.com>
X-Migadu-Flow: FLOW_OUT



> On Mar 22, 2024, at 05:50, peterx@redhat.com wrote:
> 
> From: Peter Xu <peterx@redhat.com>
> 
> The script calculates a mininum required size of hugetlb memories, but
> it'll stop working with <1MB huge page sizes, reporting all zeros even if
> huge pages are available.
> 
> In reality, the calculation doesn't really need to be as comlicated either.

                                                               ^
                                                           complicated?

> Make it simpler and work for KB-level hugepages too.
> 
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.

