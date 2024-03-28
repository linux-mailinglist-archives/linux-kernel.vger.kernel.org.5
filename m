Return-Path: <linux-kernel+bounces-122300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C7E88F4D5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F702A2F55
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DF139ADD;
	Thu, 28 Mar 2024 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5UTL4+u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E18D3B78D;
	Thu, 28 Mar 2024 01:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589844; cv=none; b=boWQJ93deih9txvM9+2L2XX8q6Q97wcG9/6GqF6GbwIqbaFdzum7VkFa2KrWE++U/uY0xks5TkBfBOtxpXMV0nD0YSYq0ui0Yvhoc/Z1eIHdzE05cFW6KS0Q7Zxkqj+m5TwDC5vZykSY63XUYW6p1pklbYaWO5L42Jmp+347x0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589844; c=relaxed/simple;
	bh=O1k80KbUBNPKN2Cz8jdjH7/l3Qy2e0v1DTF3Pf8/QLU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X265d6Si8vdY6Ma9QUjTEOWS79pa1fyI1proTnXSCvwAx1hOtYtmJqZnApGItTAMMj5uJZm7IMO7Zh2asxjn6cPrM+VIaR5QahguyypUnVLIw2g/SEIjK209gNzdTBrfQDPNEGjYkraR2q2FQs89qSpb+F1OEKCQqPbLCVDBz0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5UTL4+u; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711589842; x=1743125842;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=O1k80KbUBNPKN2Cz8jdjH7/l3Qy2e0v1DTF3Pf8/QLU=;
  b=T5UTL4+uStMhzDgcPiCs8oAn/41vs7sG+DK5YYeyjQnMhUwJlg9dgSak
   kAH/ZTXZ434C3Kj8sea1FqoY8NWKpEahbKNA9jw9vjd7Yik5FVD0grVRW
   fEhmRRT/Z+NF0zjGEYVRBNbtBvpeYLNS0wxbEjJG2skT/b6htDuFBwNry
   htgLp87OcCaAbHHJt5mTP3Qp6jYabJEj8Gh6B9dxSa0+IlAyy+Tx/T2eP
   EurNztHH3d5wtFfyZYKNiLSXJG106ZMBuIcGJq/LEzqecL8YwCo6K9ltF
   t5BDD1eRw9quGMH7QudpfFqBcvHhf2rqhyptTftp5beVBzCl1I5VwyudX
   w==;
X-CSE-ConnectionGUID: hSbVUFz+SFeectUF/MTEUQ==
X-CSE-MsgGUID: eJTocNEYTrGkvdtjEtOKhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17453695"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="17453695"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 18:37:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="21131863"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 18:37:16 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: "Gregory Price" <gourry.memverge@gmail.com>,
  aneesh.kumar@linux.ibm.com,  mhocko@suse.com,  tj@kernel.org,
  john@jagalactic.com,  "Eishan Mirakhur" <emirakhur@micron.com>,
  "Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,  "Ravis OpenSrc"
 <Ravis.OpenSrc@micron.com>,  "Alistair Popple" <apopple@nvidia.com>,
  "Srinivasulu Thanneeru" <sthanneeru@micron.com>,  Dan Williams
 <dan.j.williams@intel.com>,  Vishal Verma <vishal.l.verma@intel.com>,
  Dave Jiang <dave.jiang@intel.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  nvdimm@lists.linux.dev,
  linux-cxl@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,  "Ho-Ren
 (Jack) Chuang" <horenchuang@gmail.com>,  qemu-devel@nongnu.org,  Hao Xiang
 <hao.xiang@bytedance.com>
Subject: Re: [PATCH v6 2/2] memory tier: create CPUless memory tiers after
 obtaining HMAT info
In-Reply-To: <20240327072729.3381685-3-horenchuang@bytedance.com> (Ho-Ren
	Chuang's message of "Wed, 27 Mar 2024 07:27:28 +0000")
References: <20240327072729.3381685-1-horenchuang@bytedance.com>
	<20240327072729.3381685-3-horenchuang@bytedance.com>
Date: Thu, 28 Mar 2024 09:35:22 +0800
Message-ID: <87v857kujp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:

[snip]

> @@ -655,6 +672,34 @@ void mt_put_memory_types(struct list_head *memory_types)
>  }
>  EXPORT_SYMBOL_GPL(mt_put_memory_types);
>  
> +/*
> + * This is invoked via `late_initcall()` to initialize memory tiers for
> + * CPU-less memory nodes after driver initialization, which is
> + * expected to provide `adistance` algorithms.
> + */
> +static int __init memory_tier_late_init(void)
> +{
> +	int nid;
> +
> +	mutex_lock(&memory_tier_lock);
> +	for_each_node_state(nid, N_MEMORY)
> +		if (!node_state(nid, N_CPU) &&
> +			node_memory_types[nid].memtype == NULL)

Think about this again.  It seems that it is better to check
"node_memory_types[nid].memtype == NULL" only here.  Because for all
node with N_CPU in memory_tier_init(), "node_memory_types[nid].memtype"
will be !NULL.  And it's possible (in theory) that some nodes becomes
"node_state(nid, N_CPU) == true" between memory_tier_init() and
memory_tier_late_init().

Otherwise, Looks good to me.  Feel free to add

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

in the future version.

> +			/*
> +			 * Some device drivers may have initialized memory tiers
> +			 * between `memory_tier_init()` and `memory_tier_late_init()`,
> +			 * potentially bringing online memory nodes and
> +			 * configuring memory tiers. Exclude them here.
> +			 */
> +			set_node_memory_tier(nid);
> +
> +	establish_demotion_targets();
> +	mutex_unlock(&memory_tier_lock);
> +
> +	return 0;
> +}
> +late_initcall(memory_tier_late_init);
> +

[snip]

--
Best Regards,
Huang, Ying

