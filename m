Return-Path: <linux-kernel+bounces-137831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6BC89E818
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A851C2360D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C598C09;
	Wed, 10 Apr 2024 02:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSBUiON5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B74120EB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712715430; cv=none; b=pL7/GnvVnWHC0j422ADSrVM88zGXSMpHy64Fndtk1/U+jQAVoib8CTSBrHAZ/z0Eb5lZ24mfghg8v1O3rp7uX8phf64eMyRfio1//aJohAGBMk7LHJppNwXLPFvT/BQYLzXLZlLpG428vn5+lnLTiGSMwzOxhiyxZxu8PcOUhzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712715430; c=relaxed/simple;
	bh=O6C6n9pybJTJLPJy1c8WzpgKVw+uUnnwKizzYQ7blj4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XBoGfB7QH6+x+G0evRgFs4kUhL1hVyuN8vsNfTmi46RK5GT1UVIqJYXUYEUFVnRrkMzRx0UrJO32hXm6Eh3pBzsSkAz97Ft72J5LPUjozcB9RGDQIpzcW6QQo8eJzQygt6CO+Hz7sfqYvHiHutORmOkv2XSSBDSQxGk0HPv0JNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSBUiON5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712715430; x=1744251430;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=O6C6n9pybJTJLPJy1c8WzpgKVw+uUnnwKizzYQ7blj4=;
  b=JSBUiON5P+HMBeBGx6j8oZByqAqn7X09CG+tkBbUQjNv2iJ32IQaJ3Lf
   bXBfSsbvGbwhZYZtyfgmpxZY3k+QtRJZAXksI3zzPyKbtJERN/yPw2woN
   FlrxZDhKZ2U0ks5488x50LpNfWTQMzmzKFknkeoJnic/Jvz6Rolm9fYQx
   bW/WA4PV+xMDyIPlFIdV1vgDb09N2IVC5gWeD0sa7/m1+hSHx5s6tGVUB
   hshL4jOMQtCPvPqPREuvEkocEPcMZWtd9HrMV/yeK3LazzdfIZcdD+KP0
   oRrDnpKHRrQ8OJ6qdZMBkbxN6hAZ45Uaz/XV1Ar5U7dY9NpoD+ENox5Xy
   w==;
X-CSE-ConnectionGUID: JNWCY562TVupDYaxbxsa4A==
X-CSE-MsgGUID: TTkrDxjfQCqYYBjVDUN1KA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8161293"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8161293"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:17:10 -0700
X-CSE-ConnectionGUID: TXOFrYDjTyiFtmhcOf1iKQ==
X-CSE-MsgGUID: PGZlSwBjSt+v7vtpIZ8YWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="24908586"
Received: from amatsuba-mobl2.amr.corp.intel.com (HELO [10.209.3.203]) ([10.209.3.203])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:17:10 -0700
Message-ID: <19a3c2890b18ce230a9e147c0eeee27caf0c4137.camel@linux.intel.com>
Subject: Re: [RFC] mm: get_mm_counter() get the total memory usage of the
 process
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Chen Taotao <chentt10@chinatelecom.cn>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Tue, 09 Apr 2024 19:17:08 -0700
In-Reply-To: <20240322151139.7417-1-chentt10@chinatelecom.cn>
References: <20240322151139.7417-1-chentt10@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-22 at 23:11 +0800, Chen Taotao wrote:
> Currently, the get_mm_counter() function returns only the value of
> the process memory counter percpu_counter ->count record, ignoring
> the memory usage count maintained by each CPU in the
> percpu_counter->counters array, which leads to an error in obtaining
> the memory usage count of a process, especially when there are many
> CPU cores. counts, especially when there are many CPU cores.
>=20
> It is now possible to have get_mm_counter() get the memory count of a
> process by adding the memory counts maintained by each cpu, thus getting
> an accurate memory count of the process.
>=20
> This patch is an unofficial version that simply fixes the above problem,
> as I'm not sure if it makes sense to do so.

Summing up the mm counts maintained in every cpu is expensive,
especially if we are doing the read often.  More so
when there are a large number of cores on large servers or
newer CPU with high core counts.

For mm counters,the count in fbc->count is good enough we
don't need to correct fbc->count with the the small counts
update (< percpu_counter_batch) cached in per cpu counts.

So do you have a mm count use case where you really need the precise
count with get_mm_counter?

I do not think we should make the change you suggested.

Tim


>=20
> Signed-off-by: Chen Taotao <chentt10@chinatelecom.cn>
> ---
>  include/linux/mm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f5a97dec5..5cf6443aa 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2569,7 +2569,7 @@ static inline bool get_user_page_fast_only(unsigned=
 long addr,
>   */
>  static inline unsigned long get_mm_counter(struct mm_struct *mm, int mem=
ber)
>  {
> -	return percpu_counter_read_positive(&mm->rss_stat[member]);
> +	return percpu_counter_sum_positive(&mm->rss_stat[member]);
>  }
> =20
>  void mm_trace_rss_stat(struct mm_struct *mm, int member);


