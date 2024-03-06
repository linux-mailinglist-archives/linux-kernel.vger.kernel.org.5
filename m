Return-Path: <linux-kernel+bounces-93613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02167873259
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20F2290640
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4C45EE65;
	Wed,  6 Mar 2024 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zam5zLmi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848D5C05F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716692; cv=none; b=ESvNlkpsiuatxCDZOQiWzUmVkwqP7q/zQ7FeE1HSEDR/6AbKIfhvMQLY10w7k8EQV2ZDQg6ePvIhwlMN3y/2Otv6IeLi13fOn4GRky2vMYdv1yfvB8ko/0aseqXXpcyKhDV1mF9gX857stxNsKGk5aeSJ8PkyFz1cAb7Xeqj/qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716692; c=relaxed/simple;
	bh=WI+zXa7b+ZGTxolUk2ZlHXMgfJyQxF83bONh/z1C4iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeUEm+hxapikd2xSP3qjLWxdnZuJ51jnWfHdqeNq2Axdf/VdxoGEbYdXIFyRRB3jTVjbq3sRlxGl+MFqZ1hR+T9UjP8O4f0kxEtOpH4zBIm4rOk5Q/1usxrVftXQNibaV+1LOKdqwKuvy/eZIofg+UF0LT6qLbdTADlIzWdoNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zam5zLmi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709716691; x=1741252691;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WI+zXa7b+ZGTxolUk2ZlHXMgfJyQxF83bONh/z1C4iQ=;
  b=Zam5zLmiOFjZbSXOByJC8hIISzAJX0sQ7K6hUYoS9orKyNn/+gmFWdDl
   N3WgzGfJfWB1I4EChxU1jsk7VdRbFlJHoDcfKWvs9ncl5Y6G/8MWRaSof
   inSNb8z7I0f5vOTu11Mcje4k/PQhU2FIFBFwTN7SO8+K87nc+fFjNVHxX
   ifLXmNTjNqjyIU+9Sq4XgWWYnsQ1Afr5HaswqFh2LIoqRmGO2NQ/VdHxe
   QpUI83gqnHgCscmXUEwOR2X4sKBRu/K2Qk+6ZGTiDT+qvbtD40JlH3qUY
   T+L1GtiT+opACG/KcsdKo2q1wSEtyWuQyWwpxAlOI/4n+fnj1pEBcG4Be
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4180218"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="4180218"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 01:18:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="14250309"
Received: from rulin.ccr.corp.intel.com (HELO [10.124.227.114]) ([10.124.227.114])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 01:18:07 -0800
Message-ID: <2c48e41a-2ff4-4b31-9212-e7fd7d4c5bb0@intel.com>
Date: Wed, 6 Mar 2024 17:18:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] mm/vmalloc: lock contention optimization under
 multi-threading
Content-Language: en-US
To: urezki@gmail.com, bhe@redhat.com
Cc: akpm@linux-foundation.org, colin.king@intel.com, hch@infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, lstoakes@gmail.com,
 tianyou.li@intel.com, tim.c.chen@intel.com, wangyang.guo@intel.com,
 zhiguo.zhou@intel.com, rulin.huang@intel.com
References: <20240301155417.1852290-1-rulin.huang@intel.com>
From: "Huang, Rulin" <rulin.huang@intel.com>
In-Reply-To: <20240301155417.1852290-1-rulin.huang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello, are there any issues with this patch that need to be modified? If
there is any, we will modify it as soon as possible, thank you.

On 2024/3/1 23:54, rulinhuang wrote:
> Hi,
> 
> This version has the rearrangement of macros from the previous one.
> 
> We are not sure whether we have completely moved these macros and 
> their corresponding helper to the correct position. Could you please 
> help to check whether they are correct?
> 
> ~
> 
> 1. Motivation
> 
> When allocating a new memory area where the mapping address range is 
> known, it is observed that the vmap_node->busy.lock is acquired twice 
> but one of the acquisitions is actually unnecessary.
> 
> 2. Design
> 
> Among the two acquisitions, the first one occurs in the 
> alloc_vmap_area() function when inserting the vm area into the vm 
> mapping red-black tree, and the second one occurs in the 
> setup_vmalloc_vm() function when updating the properties of the vm, 
> such as flags and address, etc.
> 
> Combine these two operations together in alloc_vmap_area(), which 
> improves scalability when the vmap_node->busy.lock is contended.
> By doing so, the need to acquire the lock twice can also be eliminated 
> to once.
> 
> 3. Test results
> 
> With the above change, tested on intel sapphire rapids
> platform(224 vcpu), a 4% performance improvement is gained on 
> stress-ng/pthread(https://github.com/ColinIanKing/stress-ng),
> which is the stress test of thread creations.
> 
> rulinhuang
> 
> [v1] https://lore.kernel.org/all/20240207033059.1565623-1-rulin.huang@intel.com/
> [v2] https://lore.kernel.org/all/20240220090521.3316345-1-rulin.huang@intel.com/
> [v3] https://lore.kernel.org/all/20240221032905.11392-1-rulin.huang@intel.com/
> [v4] https://lore.kernel.org/all/20240222120536.216166-1-rulin.huang@intel.com/
> [v5] https://lore.kernel.org/all/20240223130318.112198-2-rulin.huang@intel.com/
> [v6] https://lore.kernel.org/lkml/aa8f0413-d055-4b49-bcd3-401e93e01c6d@intel.com/
> 
> 
> rulinhuang (2):
>   mm/vmalloc: Moved macros with no functional change happened
>   mm/vmalloc: Eliminated the lock contention from twice to once
> 
>  mm/vmalloc.c | 314 +++++++++++++++++++++++++--------------------------
>  1 file changed, 155 insertions(+), 159 deletions(-)
> 
> 
> base-commit: 10c2cf5fe97647d68ee89b1f921e982e71519f20

