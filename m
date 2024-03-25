Return-Path: <linux-kernel+bounces-116454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24184889F18
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC321F38590
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EFC4F890;
	Mon, 25 Mar 2024 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RpJQRZcQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7190C171E4A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711336949; cv=none; b=pOxBPT5bVX5ezPwpez6fIqKA446gjHfnFgqU1bsJyVRuS/VVaCZEMGMB5NwWVoS6ttRig5Q4FXy7/RHup/jwWuiy63JUjPbMQIK89hPH3Vio7ghJBDVfz0147NLor486R3QuDWSOg8Kr5nsfK9wdDhPqCDkoNHH9n3Wfhz0SVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711336949; c=relaxed/simple;
	bh=I+3wkBv9F0Dvv3jkm6wQ0tu8JHoT7LbkDLXylu/D83I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ic4GHofk+lnVJkkE7X5OcStD1rNUQAMsNpTU+1au2KDaTsWdUXZuEDeHM3ANmmBmUgIXrr4/GCJj162hpxezWwHneao+4uvlv9s0ARkHU5Pv06XXJs2maw7aXJyKthpCERtfk56ejnj3kK0GdroAckFjOOV1SFFJq6c1i1c/7SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RpJQRZcQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711336948; x=1742872948;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=I+3wkBv9F0Dvv3jkm6wQ0tu8JHoT7LbkDLXylu/D83I=;
  b=RpJQRZcQoCiZBisBPZYcXsJYB5zKmZwvRFyNdyS91pPlbzYbCtDw1z1a
   tKn6B3qi0vx3gjniGby6Mn3u0IdpUVfX613QSt69FCkexbRJkQvXJCO2e
   G86xi6vCegzhgf++C2a8HGUZO9DZx/MgnHDsZpAqxOOns4iv3JBouN1kS
   rHM+u/TSMTMZd02JWVqym9usbVQ1i5dxk1QwlhoFd2qQKxAMMNWQD85va
   SFBOqt5+G7Wvnxv6tEX0pxm4LgNJn/pX2OJMhGzHuKd/Ad92BhLws8siK
   70+kIMx8PQiOIbZ6JxixOueXU6CGovM0ysVUIf7HLpg6WtA7x0Wj1w7QJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17052178"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="17052178"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 20:22:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15464078"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 20:22:22 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  David Hildenbrand <david@redhat.com>,
  Matthew Wilcox <willy@infradead.org>,  Gao Xiang <xiang@kernel.org>,  Yu
 Zhao <yuzhao@google.com>,  Yang Shi <shy828301@gmail.com>,  Michal Hocko
 <mhocko@suse.com>,  Kefeng Wang <wangkefeng.wang@huawei.com>,  Barry Song
 <21cnbao@gmail.com>,  Chris Li <chrisl@kernel.org>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: Can you help us on memory barrier usage? (was Re: [PATCH v4
 4/6] mm: swap: Allow storage of all mTHP orders)
In-Reply-To: <44b2cf99-7d87-42ac-8446-fe0822c89c97@arm.com> (Ryan Roberts's
	message of "Fri, 22 Mar 2024 09:23:44 +0000")
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
	<20240311150058.1122862-5-ryan.roberts@arm.com>
	<87jzm751n3.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<d6ac1097-2ca3-4e6d-902d-1b942cacf0fb@arm.com>
	<8734skryev.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<b22a222b-7fd8-4648-84a7-21d35f529f27@arm.com>
	<87r0g3q9cz.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
	<44b2cf99-7d87-42ac-8446-fe0822c89c97@arm.com>
Date: Mon, 25 Mar 2024 11:20:29 +0800
Message-ID: <87msqnov42.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 22/03/2024 02:38, Huang, Ying wrote:
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
>
> For the situation we are discussing, writer() is always called with a spin lock
> held. So spin_unlock() will act as the barrier in this case; that's my argument
> for not needing the explicit barrier(), anyway. Happy to be told I'm wrong.

Yes.  spin_unlock() is a barrier too.  There are some operations between
writer() and spin_unlock(), so I want to check whether it make any sense
to add a barrier earlier.

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

--
Best Regards,
Huang, Ying

