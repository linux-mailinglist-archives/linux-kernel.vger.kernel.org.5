Return-Path: <linux-kernel+bounces-82731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2110F8688D0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BE71C219E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B351F5336F;
	Tue, 27 Feb 2024 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3zRlg5e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71307EAD5
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709013685; cv=none; b=ZYIdfSJwmJWfq0WMMe7oiGyiwZaYTnkawmLW6Q2anX92N6QhfUjtPBsItUj4k8xUQ4KP8af6a4XYIrpYcm/7gql+ACDtDqXKLRu+01tHHJPi4m1WbtIPd2BUDuVxbdK6TCkOxfHxkh35FtBiRqo3XBgFCYiSALfFzWk7PzrVrn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709013685; c=relaxed/simple;
	bh=f+XMnM1XcruBid7lq4nTxNkSIDokV7reYLzRYZf65+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iLuy9UWvxXy9lU6kP95ayPdiZNceNDRJMxlz6Q1nuviPvkKD7J7UfUSzvti/fkssI1cXiubuNe6KJhQYTVq6fIr/ah4/PL16Do0DtQhAnLCZhTbhu8tG3NQJCzuakdPwiin8N5xnB80qDjbocJvLeCoAYw/DewscOtmNGTjcaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3zRlg5e; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709013684; x=1740549684;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=f+XMnM1XcruBid7lq4nTxNkSIDokV7reYLzRYZf65+U=;
  b=B3zRlg5eqJjBlklqhoVL6V3XSbmo0Z/ntRlBFrl5b511vX9Gbgv4Wftx
   L3JDm0oB9IXYJY2OVJ+Jx2XB01GJmh8IZoVBW3aXkwQFI5xjUdrqaZmRC
   64zbx/XLOKj++fXHorvUDWs1Hg+15dpIpitQ9LozUW0yyxQgx5sxfNmVO
   IlUk7e4VsdmVVlKBGjPcoju4Ix9t4Y8aluMVSGM1QNeQJ7NFJTRmZoo7n
   uivfoB5/0EU8bJvC9VAPp1U/kgoa4nxdO6F8IxuyaNwrVxyPFH+Wc4K8b
   wUHkAibLofsldeNj9MiwEwAfpo0l1L7fLVXtSzVGkIWx9hv1hUYOITNIv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6287504"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6287504"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 22:01:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="37954670"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 22:01:21 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  <hannes@cmpxchg.org>,
  <dan.j.williams@intel.com>,  <dave.jiang@intel.com>
Subject: Re: [RFC 1/1] mm/mempolicy: introduce system default interleave
 weights
In-Reply-To: <Zd10+G4XIrPoojJE@memverge.com> (Gregory Price's message of "Tue,
	27 Feb 2024 00:36:56 -0500")
References: <20240220202529.2365-1-gregory.price@memverge.com>
	<20240220202529.2365-2-gregory.price@memverge.com>
	<87wmqxht4c.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZdgxaLSBznupVmJK@memverge.com>
	<87sf1jh7es.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZdygZ8ZidfaORg8F@memverge.com>
	<87edcyeo78.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Zd10+G4XIrPoojJE@memverge.com>
Date: Tue, 27 Feb 2024 13:59:26 +0800
Message-ID: <87a5nme9c1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Tue, Feb 27, 2024 at 08:38:19AM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> > Where are the 100 nodes coming from?
>> 
>> If you have a real large machine with more than 100 nodes, and some of
>> them are CXL memory nodes, then it's possible that most nodes will have
>> interleave weight "1" because the sum of all interleave weights is
>> "100".  Then, even if you use only one socket, the interleave weight of
>> DRAM and CXL MEM could be all "1", lead to useless default value.  So, I
>> suggest don't cap the sum of interleave weights.
>
> I have to press this issue: Is this an actual, practical, concern?

I don't know who have large machine like that.  But I guess that it's
possible in the long run.

> It seems to me in this type of scenario, there are larger, more complex
> numa topology issues that make the use of the general, global weighted
> mempolicy system entirely impractical.  This is a bit outside the scope

It's possible to solve the problem step by step.  For example, add
per-task interleave weight at some time.

>> > So, long winded winded way of saying:
>> > - Could we use a larger default number? Yes.
>> > - Does that actually help us? Not really, we want smaller numbers.
>> 
>> The larger number will be reduced after GCD.
>>
>
> I suppose another strategy is to calculate the interleave weights
> un-bounded from the raw bandwidth - but continuously force reductions
> (through some yet-undefined algorithm) until at least one node reaches a
> weight of `1`.  This suffers from the opposite problem: what if the top
> node has a value greater than 255? Do we just cap it at 255? That seems
> the opposite form of problematic.
>
> (Large numbers are quite pointless, as it is essentially the antithesis
> of interleave)

Yes.  So I suggest to use a relative small number as the default weight
to start with for normal DRAM.  We will have to floor/ceiling the weight
value.

--
Best Regards,
Huang, Ying

