Return-Path: <linux-kernel+bounces-120523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAE188D8B9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63AC1C22E31
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE1D2D627;
	Wed, 27 Mar 2024 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bzECDQ3H"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FBD2D608
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527784; cv=none; b=LZhhoL63w98oYvr1Coht8ES0PXEhQCP4sfBoTZ8mE8zNs9SVWQQEqkCEEhwyv5XMvDatysi9m3jsfd/FW3mr5SB4VNWTM96cEcdabqnF/cBBP8gBVMc3xIvrfG9WX6X2gCp+djrxlxb9kDbsCyqCrw9xjw6CDhsk3vdoB02J5+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527784; c=relaxed/simple;
	bh=0wxrOxqIYdf4MXJwwuzvImG2e/us/u6zEDSUjxq+9KY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nmSXeWALktGKwVWI77oLZGWYtSGtiNdv16AWPrrJVla0iFEw2cSEktJxs8mrNqFai+czi2h+hy7L/DdtkjJe3chzU7I9Mg5AtmZ2oGL0uua7ffqec9XYxjjIU9YZGqiqdef8EXGTXq5uJRmNkkwXGLjyomnatfhpJmmquhxJ0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bzECDQ3H; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711527782; x=1743063782;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=0wxrOxqIYdf4MXJwwuzvImG2e/us/u6zEDSUjxq+9KY=;
  b=bzECDQ3Hb3Ae4AcrXS4SHoK2b4uZhwrklFXCm46fIZZeFSAOj0bifG5E
   bWOA9HTL2G7izhPedEZeDQwVL5Mcq2n0Xb8gu5/y4FZ1le9RcqvbZdViU
   jpYw/WBjLOJ+mExzQngCFXYTEU6sg+giY+fCsUYKsqBhz66qc1HpUU7kA
   mufQaZaor9Ni6gy2HXZcmbeHiexWsnKjxyRLDByqzAfIYNjUwOI7/Sbe5
   gopJmteTjKLxDe+iLWT+maZDhK3lQ8wQHaB/9g3iYI7fxa3wEGMGqOdxN
   ar6T19RnZ2ZD0CTk7XzAeZSgvcCXKUsGxieDS2R8ilyYbu6gbI0gumTet
   g==;
X-CSE-ConnectionGUID: qOiXfiPsRtGSe4QMvnR/fw==
X-CSE-MsgGUID: MuKYe+aeT0Susyg+fMvhUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10415497"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="10415497"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 01:23:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="39333337"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 01:22:59 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: <akpm@linux-foundation.org>,  <david@redhat.com>,
  <mgorman@techsingularity.net>,  <wangkefeng.wang@huawei.com>,
  <jhubbard@nvidia.com>,  <21cnbao@gmail.com>,  <ryan.roberts@arm.com>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: support multi-size THP numa balancing
In-Reply-To: <bc671388-f398-4776-af15-c144f2c39d78@linux.alibaba.com> (Baolin
	Wang's message of "Wed, 27 Mar 2024 16:09:23 +0800")
References: <cover.1711453317.git.baolin.wang@linux.alibaba.com>
	<dee4268f1797f31c6bb6bdab30f8ad3df9053d3d.1711453317.git.baolin.wang@linux.alibaba.com>
	<87cyrgo2ez.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<bc671388-f398-4776-af15-c144f2c39d78@linux.alibaba.com>
Date: Wed, 27 Mar 2024 16:21:06 +0800
Message-ID: <87edbwm6fh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 2024/3/27 10:04, Huang, Ying wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>> 
>>> Now the anonymous page allocation already supports multi-size THP (mTHP),
>>> but the numa balancing still prohibits mTHP migration even though it is an
>>> exclusive mapping, which is unreasonable.
>>>
>>> Allow scanning mTHP:
>>> Commit 859d4adc3415 ("mm: numa: do not trap faults on shared data section
>>> pages") skips shared CoW pages' NUMA page migration to avoid shared data
>>> segment migration. In addition, commit 80d47f5de5e3 ("mm: don't try to
>>> NUMA-migrate COW pages that have other uses") change to use page_count()
>>> to avoid GUP pages migration, that will also skip the mTHP numa scaning.
>>> Theoretically, we can use folio_maybe_dma_pinned() to detect the GUP
>>> issue, although there is still a GUP race, the issue seems to have been
>>> resolved by commit 80d47f5de5e3. Meanwhile, use the folio_likely_mapped_shared()
>>> to skip shared CoW pages though this is not a precise sharers count. To
>>> check if the folio is shared, ideally we want to make sure every page is
>>> mapped to the same process, but doing that seems expensive and using
>>> the estimated mapcount seems can work when running autonuma benchmark.
>> Because now we can deal with shared mTHP, it appears even possible
>> to
>> remove folio_likely_mapped_shared() check?
>
> IMO, the issue solved by commit 859d4adc3415 is about shared CoW
> mapping, and I prefer to measure it in another patch:)

I mean we can deal with shared mTHP (by multiple threads or multiple
processes) with this patch.  Right?

[snip]

--
Best Regards,
Huang, Ying


