Return-Path: <linux-kernel+bounces-101028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CBC87A0E0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A852862D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA4EAD54;
	Wed, 13 Mar 2024 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chS61YAC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4B9444
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293789; cv=none; b=GtNXvdemENpXdz+Ffp08IQUMSfLqDrE+iUjsDUtnr7kzPa2xQ1HUi00A405ZG1wrcc2yteCNDm3OPNZpMjpD0poXOjkEOZnBoYX47eZVwW+CkkT7qYrWckG1xbPjde1BQUhOCGN/QoBH68Je2+drX63VmsCtphYKDycxFUlzr5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293789; c=relaxed/simple;
	bh=oFDwWocpbPxkR5yivk+zblxm9GFLekim2vygWThKv48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mT/jV1Pm5iMIZ2cMK/NtNL6N28GHacSPGyGIqvGHMJNSkXeWr8Inbtjr0RHOtwsVU3O+EGl5i6mZaGN1ZrltW/Q7Mi+Js8nWN+xRfwMlZnpOaW8qcI+XtmN7SvlYNsrxArj6nTaJYMJlO9VRSNDOVTlhtdkodKkpESLxhP+E6qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chS61YAC; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710293787; x=1741829787;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=oFDwWocpbPxkR5yivk+zblxm9GFLekim2vygWThKv48=;
  b=chS61YAC8fi7Pc6amALYWOrYa8V5plOlTgAl335OJ0U6kywPJM5WB2MG
   5s+hAejYgrlHcLbx1OAWBtKoQKphlZ880un1IBTYh2+8roPR7fWmfoEnM
   5g0kN7z+UIIcpaPCygv+8EPeeBlQLdTLG4IZJ6oStbsCPRgO3RaSj7RdT
   bt+q9/rcKgAeJ7b1626+KjfvIpye1olUCmgjMpXMn2r4OQ6VaC6WhKmK9
   YLkrI4aKzue9sTTameIzZGEsa+MYJ3bJAvgrzfswAWJH9culGkq+ey3ZI
   tEvPuntqzO6DkbTYWJ19uazTxHPZTAzTXuvv+AwWOAYZXyzLXa3lR5tg6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22491013"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22491013"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 18:36:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12196777"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 18:36:24 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@redhat.com>,  Matthew Wilcox <willy@infradead.org>,  Gao Xiang
 <xiang@kernel.org>,  Yu Zhao <yuzhao@google.com>,  Yang Shi
 <shy828301@gmail.com>,  Michal Hocko <mhocko@suse.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  Barry Song <21cnbao@gmail.com>,  Chris Li
 <chrisl@kernel.org>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/6] mm: swap: Simplify struct percpu_cluster
In-Reply-To: <2e236d6b-e6fc-428a-ad06-c2fb1dbf5c8b@arm.com> (Ryan Roberts's
	message of "Tue, 12 Mar 2024 08:51:23 +0000")
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
	<20240311150058.1122862-4-ryan.roberts@arm.com>
	<87cyrz51lj.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<2e236d6b-e6fc-428a-ad06-c2fb1dbf5c8b@arm.com>
Date: Wed, 13 Mar 2024 09:34:29 +0800
Message-ID: <87r0ge3oey.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 12/03/2024 07:52, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> 
>>> struct percpu_cluster stores the index of cpu's current cluster and the
>>> offset of the next entry that will be allocated for the cpu. These two
>>> pieces of information are redundant because the cluster index is just
>>> (offset / SWAPFILE_CLUSTER). The only reason for explicitly keeping the
>>> cluster index is because the structure used for it also has a flag to
>>> indicate "no cluster". However this data structure also contains a spin
>>> lock, which is never used in this context, as a side effect the code
>>> copies the spinlock_t structure, which is questionable coding practice
>>> in my view.
>>>
>>> So let's clean this up and store only the next offset, and use a
>>> sentinal value (SWAP_NEXT_INVALID) to indicate "no cluster".
>>> SWAP_NEXT_INVALID is chosen to be 0, because 0 will never be seen
>>> legitimately; The first page in the swap file is the swap header, which
>>> is always marked bad to prevent it from being allocated as an entry.
>>> This also prevents the cluster to which it belongs being marked free, so
>>> it will never appear on the free list.
>>>
>>> This change saves 16 bytes per cpu. And given we are shortly going to
>>> extend this mechanism to be per-cpu-AND-per-order, we will end up saving
>>> 16 * 9 = 144 bytes per cpu, which adds up if you have 256 cpus in the
>>> system.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> 
>> LGTM, Thanks!
>
> Thanks! What's a guy got to do to get Rb or Ack? :)

Feel free to add

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

in the future version.

--
Best Regards,
Huang, Ying

