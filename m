Return-Path: <linux-kernel+bounces-110885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 585BD88653B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B86285DAB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDF84A3E;
	Fri, 22 Mar 2024 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvAwU9GN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF873D6D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711075220; cv=none; b=F9KCX5fx5AHnpA2En/mdjoPUSh8cVYS30tp+/2sfxWqjyMUb96ZB1xvyU439A3gvDc/GRSD0OSFsiDgghmkUHbrdyr7NNydLmu/fCZqyLwl5LPIaDrQU3FbYksOrR4nVF5VuTa2HYYRTglRrqnbhwsSN+M0dClqQp+j+H7K4BPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711075220; c=relaxed/simple;
	bh=SKFE/yv9BlwXNs2v+wBuGnWL2pZl/FThKVv5URfkHyA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c4gH/iwCL7wB0IeKYjcbMOWPT1cujCiTnl52/OrAQaHERW5Hh7oQzUI7UBloyfDlAuhvnEboh3veY75MmFeSZ1pvOVKwy6mx9VJhIvj5hFjuf/ILOcFGXgpBFp/Cy5cwCuX2cpMApFcqtCsovixYL8NoglVlbfa5FlLBEOYpuec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvAwU9GN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711075219; x=1742611219;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SKFE/yv9BlwXNs2v+wBuGnWL2pZl/FThKVv5URfkHyA=;
  b=hvAwU9GN2Ctzfa8Xiy50uDfajRa5UJVNn2/Dv9fMW7yn+fK/5GiuQHLU
   AaxFCqTXRCs87iPdDR8FY2hOzkHtpMBHw/H06BBkSIX8fNL0QmRAuIfRw
   OGHEzKxxOz+S+yJWBbQeIoDAsHOIiWPPp9us0J6jjHbeKsKSQsSGXgg/1
   wjejCwLHmUvKnHyLph/5G1L0K74b3yD5fLKjTjx7TMoHTzpn+E+fx/RKw
   edpZQicfrC/BL+yzOw1zs48Dte5a50Wrw5YCdhl8hRX7u182qO/NASX8m
   nUngysibrBdEXl0L4g/bEdZKvz++UxmJe9Wk6OBk/m5ED4HBqLayg3eyQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="5972581"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="5972581"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 19:40:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="15151100"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 19:40:14 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>,  David Hildenbrand <david@redhat.com>,
  Matthew Wilcox <willy@infradead.org>,  Gao Xiang <xiang@kernel.org>,  Yu
 Zhao <yuzhao@google.com>,  Yang Shi <shy828301@gmail.com>,  Michal Hocko
 <mhocko@suse.com>,  Kefeng Wang <wangkefeng.wang@huawei.com>,  Barry Song
 <21cnbao@gmail.com>,  Chris Li <chrisl@kernel.org>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>
Subject: Can you help us on memory barrier usage? (was Re: [PATCH v4 4/6]
 mm: swap: Allow storage of all mTHP orders)
In-Reply-To: <b22a222b-7fd8-4648-84a7-21d35f529f27@arm.com> (Ryan Roberts's
	message of "Thu, 21 Mar 2024 12:21:46 +0000")
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
	<20240311150058.1122862-5-ryan.roberts@arm.com>
	<87jzm751n3.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<d6ac1097-2ca3-4e6d-902d-1b942cacf0fb@arm.com>
	<8734skryev.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<b22a222b-7fd8-4648-84a7-21d35f529f27@arm.com>
Date: Fri, 22 Mar 2024 10:38:20 +0800
Message-ID: <87r0g3q9cz.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Paul,

Can you help us on WRITE_ONCE()/READ_ONCE()/barrier() usage as follows?
For some example kernel code as follows,

"
unsigned char x[16];

void writer(void)
{
        memset(x, 1, sizeof(x));
        /* To make memset() take effect ASAP */
        barrier();
}

unsigned char reader(int n)
{
        return READ_ONCE(x[n]);
}
"

where, writer() and reader() may be called on 2 CPUs without any lock.
It's acceptable for reader() to read the written value a little later.
Our questions are,

1. because it's impossible for accessing "unsigned char" to cause
tearing.  So, WRITE_ONCE()/READ_ONCE()/barrier() isn't necessary for
correctness, right?

2. we use barrier() and READ_ONCE() in writer() and reader(), because we
want to make writing take effect ASAP.  Is it a good practice?  Or it's
a micro-optimization that should be avoided?

--
Best Regards,
Huang, Ying

