Return-Path: <linux-kernel+bounces-91846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C21C87176D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFA31C21A9A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429077F7E4;
	Tue,  5 Mar 2024 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iu6e5690"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CA57F481
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625148; cv=none; b=iHhuzg8EXuEJQ0r1K9ZhuQmhptsp1dexSHKTpDyY3oceHJo6389CvwBpegUJY+d+DZJYYsJh5la/4LVsuDGrJMy3HWc3DXHjUBFxTJUtdYej783eiBfwCwQMM+MV+G7joIsVXLL4Ceo99hV5wBFkzCpArCRsRR4P+FluwAlobys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625148; c=relaxed/simple;
	bh=uHgoeLZ9f96H6Rn45kJcZOi5eaHyTx31J1M/+Tek47s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t3EEfx96zdWfNxC/lo/Mf13hyt92y5UFD0H8pbnGJ+/LH1ZFwdWRN7fsUTkR+wlwXeOruWmL1mioNtfoM7/L8nvFSxNSI4nwCwNo1xEjWIHphMNVeM7Tsmax200fgGszxiuENyBG1RqjqM+FuOfk4F1fm8wajNKEeS+zYy3Zpxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iu6e5690; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709625147; x=1741161147;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=uHgoeLZ9f96H6Rn45kJcZOi5eaHyTx31J1M/+Tek47s=;
  b=Iu6e5690yLvL9dQgJ0MeRXXTrV8KQIzHTjVcYkYzVTYSIHP2QQjMNAtm
   NvlEjRVVpzifESrfUDE/0IHxuamu2fy7Bfwtt3KX6ogRWPhcPF5JM14Cy
   FDfk6aBKx7w66lQJ5/MX/izyD0wskewvUN1bZ/NVZvDsfMg0qp6w0+oKd
   QRi6aX28ZSBZ6+EBRHWvAODCp+TLnmzIL/ytD540+XxZH0Tq7NZtZSI0E
   o4eS0nJL8cz1AahHxOeIkgIUwfGto0oVTU+hF3QWpGhmn90/84PDmoEcm
   M7n0/v6GQBYkfGEch4JIOfUKBc9QA+Honz6INnAPGVCxypacjgoHlJ2Cg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="26618243"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="26618243"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 23:52:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="32450825"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 23:52:20 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,  Barry Song <21cnbao@gmail.com>,
  akpm@linux-foundation.org,  linux-mm@kvack.org,  chrisl@kernel.org,
  yuzhao@google.com,  hanchuanhua@oppo.com,  linux-kernel@vger.kernel.org,
  willy@infradead.org,  xiang@kernel.org,  mhocko@suse.com,
  shy828301@gmail.com,  wangkefeng.wang@huawei.com,  Barry Song
 <v-songbaohua@oppo.com>,  Hugh Dickins <hughd@google.com>
Subject: Re: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a
 large folio
In-Reply-To: <37f1e6da-412b-4bb4-88b7-4c49f21f5fe9@redhat.com> (David
	Hildenbrand's message of "Mon, 4 Mar 2024 13:41:38 +0100")
References: <20240304103757.235352-1-21cnbao@gmail.com>
	<706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
	<37f1e6da-412b-4bb4-88b7-4c49f21f5fe9@redhat.com>
Date: Tue, 05 Mar 2024 15:50:23 +0800
Message-ID: <87v86186dc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:
>
> As we are seeing more such problems with lockless PT walks, maybe we
> really want some other special value (nonswap entry?) to indicate that
> a PTE this is currently ondergoing protection changes. So we'd avoid
> the pte_none() temporarily, if possible.

This sounds like a good idea.  This can solve other issue caused by
temporarily pte_none() issue too, like the following,

https://lore.kernel.org/linux-mm/20240229060907.836589-1-zhangpeng362@huawei.com/

--
Best Regards,
Huang, Ying

