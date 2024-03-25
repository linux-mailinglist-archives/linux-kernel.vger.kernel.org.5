Return-Path: <linux-kernel+bounces-116429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DF588A078
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B03AFB3E8C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1626F16D9D4;
	Mon, 25 Mar 2024 06:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHMBeZtu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFD726424F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335746; cv=none; b=X6a//RQ6d4yM2/2AbjVJ5GQOQM156gH4hVHsVJ1JSJoR9qHk8jgt9GqTTq8cHlboqaCuj1bCExTkFD1QyuURXyXCtRoIkxk73mJu4fSoWSsIXUyHadRg+RVdyQczkm6DC8MHAZsL3JxtlRi/lDqcoqnFHZmIm/4Kj5/2IP50Qt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335746; c=relaxed/simple;
	bh=T9lldniHRtKLEDe/H+EmLhHRUTPjZExPOnV/qvs4Qrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uTCFYU9nWJydb0p/EyxTV19IAbwQLaKHr7D4UlJmdderMkI2/S3gT6TUEyDKOeqBknzLDnpU5G2y//xOVzzG+YPxMrrsykkv2zLAl4NXk6QNyFKJqy22IqJ/udue5oh9qH4CyEHpqT/is398Y2Kjzl8qzJ1EODPaOrt5XnnlCF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHMBeZtu; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711335744; x=1742871744;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=T9lldniHRtKLEDe/H+EmLhHRUTPjZExPOnV/qvs4Qrw=;
  b=kHMBeZtuqKbyBzDguQHjo/0OnqiuEJU9XdlhH8GWHZlGYBWXaJoaWonY
   JYZRJonmf1HFT+qwX1Bpqszet5R6dZYXJ7w7tYr0APwsP33hkJqn7wRtN
   XRNX+5c7AfyYD0ZULtZ88GKs8q5BjShjv9ER9hoylsIr/ij/JEa0MeKFG
   /TGJxBVE4i9hGOJVklJO42cyQMN5VS2B38suwXq6tl1vOsClFHuhMPrPx
   lJirSA0I3BD5UqMyn9+Ulhc/cHcI4AwByWAxAtJSjgruPogDG/7o+8qEO
   qsIgU5AH5LtXcvlBXpz3ZUIqk2oHPXr1cg8s/jjtdAbaAdEWVW6nNa6/M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6445250"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6445250"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 20:02:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="20220682"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 20:02:21 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  "Paul E. McKenney"
 <paulmck@kernel.org>,  ryan.roberts@arm.com,  chrisl@kernel.org
Subject: Re: Can you help us on memory barrier usage? (was Re: [PATCH v4
 4/6] mm: swap: Allow storage of all mTHP orders)
In-Reply-To: <c56eae89-9559-4b1d-8249-d23281e466b4@gmail.com> (Akira
	Yokosawa's message of "Sat, 23 Mar 2024 11:11:09 +0900")
References: <87r0g3q9cz.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
	<c56eae89-9559-4b1d-8249-d23281e466b4@gmail.com>
Date: Mon, 25 Mar 2024 11:00:28 +0800
Message-ID: <87v85bow1f.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Akira Yokosawa <akiyks@gmail.com> writes:

> [Use Paul's reachable address in CC;
>  trimmed CC list, keeping only those who have responded so far.]

Thanks a lot!

> Hello Huang,
> Let me chime in.
>
> On Fri, 22 Mar 2024 06:19:52 -0700, Huang, Ying wrote:
>> Hi, Paul,
>> 
>> Can you help us on WRITE_ONCE()/READ_ONCE()/barrier() usage as follows?
>> For some example kernel code as follows,
>> 
>> "
>> unsigned char x[16];
>> 
>> void writer(void)
>> {
>>         memset(x, 1, sizeof(x));
>>         /* To make memset() take effect ASAP */
>>         barrier();
>> }
>> 
>> unsigned char reader(int n)
>> {
>>         return READ_ONCE(x[n]);
>> }
>> "
>> 
>> where, writer() and reader() may be called on 2 CPUs without any lock.
>> It's acceptable for reader() to read the written value a little later.
>> Our questions are,
>> 
>> 1. because it's impossible for accessing "unsigned char" to cause
>> tearing.  So, WRITE_ONCE()/READ_ONCE()/barrier() isn't necessary for
>> correctness, right?
>> 
>> 2. we use barrier() and READ_ONCE() in writer() and reader(), because we
>> want to make writing take effect ASAP.  Is it a good practice?  Or it's
>> a micro-optimization that should be avoided?
>
> Why don't you consult Documentation/memory-barriers.txt, especially
> the section titled "COMPILER BARRIER"?
>
> TL;DR:
>
> barrier(), WRITE_ONCE(), and READ_ONCE() are compiler barriers, not
> memory barriers.  They just restrict compiler optimizations and don't
> have any effect with regard to "make writing take effect ASAP".

Yes.  In theory, this is absolutely correct.

My question is, in practice, will compiler barriers make CPU runs (or
sees) memory read/write instructions a little earlier via avoiding to
reorder the operations after read/write (e.g., becomes before
read/write)?

> If you have further questions, please don't hesitate to ask.

--
Best Regards,
Huang, Ying

