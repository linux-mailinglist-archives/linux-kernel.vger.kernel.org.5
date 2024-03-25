Return-Path: <linux-kernel+bounces-116452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1736889F12
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747621C35E2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA53B155390;
	Mon, 25 Mar 2024 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SvhgNyGU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FBD13C68B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711336729; cv=none; b=I8zMWpwHPJ5yvlooJBIFJDR/DX7nNEP2AXoE+FQz8F58K7jXvSWtx2GPOTbNNtTOp7yW6f/9A9JT9NPeiGmRqEg1ST7JDtiy+XKpApkaSY46bFZtLX/XyDEriSghooX6CDFHp4JgDEV0Y2hjmsuYhNxOBOcrZPIXl5ewrRjhsoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711336729; c=relaxed/simple;
	bh=WvY/llrOOyyGpZRAhKAzslr8m+fAoMpt2YTsv1kupJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MK2F4rPdhFqic9ICIZAGj7q/Iv9X7fm1uYcorAMrAxpkCFAkoTB/uLfhppWmG3FlBJE8AF5jY5aO5G3cLII4L00b8TPrC74mpgz2gxb7FEAL7xPFSoCPUjAVD1B/VN+JyoGx7sbYNnj/k43D3npGCkL0EWn42IXuqjFLDGipp4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SvhgNyGU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711336728; x=1742872728;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=WvY/llrOOyyGpZRAhKAzslr8m+fAoMpt2YTsv1kupJQ=;
  b=SvhgNyGUE1mrAHQdOXI/FSN99fz6u4y1bIoIZowf4IDsDLmWJBy164ga
   r2SqLzIEMdNff+Mul73XcZjC1c2jMTpCl5bsoMYrqj0Xj4LfTjg5EQlyL
   558ww55JO2K6PpW3KoJHSNhGQy8VHhYoIWfrO6hG9ha/IYbMc8TMfA7fE
   uU0QQZrpzGrbV3rU+EgR+FLT6xSfsPXwJl8EQCbSnv5Nd+PF/YFPTbkqr
   oj4QNzIbaor5/zWS8YNj+P08Tf6ExucL23Q2eWdBsqAlGfwL3VS+rNABo
   MbL9+VaVC7V8ndY8w4IsFo+XX2jKooQkrjO3QKoHoa8w+SAdJKarkoEWu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6427282"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6427282"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 20:18:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="46606514"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 20:18:45 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Akira Yokosawa <akiyks@gmail.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  ryan.roberts@arm.com,  chrisl@kernel.org
Subject: Re: Can you help us on memory barrier usage? (was Re: [PATCH v4
 4/6] mm: swap: Allow storage of all mTHP orders)
In-Reply-To: <766cfb68-f82a-4163-9dc1-5f4483fa5a7a@paulmck-laptop> (Paul
	E. McKenney's message of "Sun, 24 Mar 2024 17:01:36 -0700")
References: <87r0g3q9cz.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
	<c56eae89-9559-4b1d-8249-d23281e466b4@gmail.com>
	<766cfb68-f82a-4163-9dc1-5f4483fa5a7a@paulmck-laptop>
Date: Mon, 25 Mar 2024 11:16:51 +0800
Message-ID: <87r0fzova4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Sat, Mar 23, 2024 at 11:11:09AM +0900, Akira Yokosawa wrote:
>> [Use Paul's reachable address in CC;
>>  trimmed CC list, keeping only those who have responded so far.]
>> 
>> Hello Huang,
>> Let me chime in.
>> 
>> On Fri, 22 Mar 2024 06:19:52 -0700, Huang, Ying wrote:
>> > Hi, Paul,
>> > 
>> > Can you help us on WRITE_ONCE()/READ_ONCE()/barrier() usage as follows?
>> > For some example kernel code as follows,
>> > 
>> > "
>> > unsigned char x[16];
>> > 
>> > void writer(void)
>> > {
>> >         memset(x, 1, sizeof(x));
>> >         /* To make memset() take effect ASAP */
>> >         barrier();
>> > }
>> > 
>> > unsigned char reader(int n)
>> > {
>> >         return READ_ONCE(x[n]);
>> > }
>> > "
>> > 
>> > where, writer() and reader() may be called on 2 CPUs without any lock.
>> > It's acceptable for reader() to read the written value a little later.
>
> What are your consistency requirements?  For but one example, if reader(3)
> gives the new value, is it OK for a later call to reader(2) to give the
> old value?

writer() will be called with a lock held (sorry, my previous words
aren't correct here).  After the racy checking in reader(), we will
acquire the lock and check "x[n]" again to confirm.  And, there are no
dependencies between different "n".  All in all, we can accept almost
all races between writer() and reader().

My question is, if there are some operations between writer() and
unlocking in its caller, whether does barrier() in writer() make any
sense?  Make write instructions appear a little earlier in compiled
code?  Mark the memory may be read racy?  Or doesn't make sense at all?

> Until we know what your requirements are, it is hard to say whether the
> above code meets those requirements.  In the meantime, I can imagine
> requirements that it meets and others that it does not.
>
> Also, Akira's points below are quite important.

Replied for his email.

--
Best Regards,
Huang, Ying

