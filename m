Return-Path: <linux-kernel+bounces-52874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6136849DAF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52D21C22357
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376752C85D;
	Mon,  5 Feb 2024 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8K0fpAO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585524B50;
	Mon,  5 Feb 2024 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145720; cv=none; b=JJBINrLxKUiZ6LLum3sVS5VXlg8mHGCTMEAJ5suwgCJN4YZQWxFrWbQdEzHz+0ayjGwmE1gS2/oOKjjGPtaGmQAehCwSGu2QL8GE4/wrDzOgybhjbRosWw6sFIBx9jP/xvQaL2jA5vHWkjU0CD/jYgn4KmAD/sy8fKBsISJsnOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145720; c=relaxed/simple;
	bh=R1O30Os6ncIReZnfo4sDU46nxhgxKyi/5Cr1MDh1cEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYzymi06j1zNlrVlDAkNFOWnBFYjuT0IJi7TMStsqGInB46F4xVLNL1SSUDVpGPAYZstm+36FcpkwowFirrzhyelU4zCnLuqsXy3wzTWYZTDy7Q4eFTXnwXTD3mvYBjaY1Zh5t2qw+Hg43kd5eOyDhxOf2q2q/nClS4RFPocnKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8K0fpAO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707145718; x=1738681718;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R1O30Os6ncIReZnfo4sDU46nxhgxKyi/5Cr1MDh1cEI=;
  b=K8K0fpAOIF7sD0K7iOACkMli20wb3SPQn93E/6UFaU5tcGTKl6HqvBkC
   pN/slB3pb+aZl2ALE+KGWB05rlYhAJMt7Ih8ZScpdnA5RyaFeZpTDbkeA
   GT9OmL+/AmuIEXmCpQCKM6iwBBWvgqIx+wekP0Q+36FkL6Jpvu1kQsy5f
   YdDJwmWPqcGqwj6ZU+56xpRGMX17I6Ju1PJ7ktwb8ugkDqrW9BlRq0MyN
   I+TSe2TT6ulGS31nosVNFqbENHNGS6i4FEajLVs3LGHbua2lKr7HmCyP4
   wb0QbkkY8vk68Q/9mvHdHWPI37tx4Rx1fwfCD0Fs9TIS/mbtMoaQ2Ao8G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="686568"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="686568"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 07:08:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="1048740"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 07:08:30 -0800
Received: from [10.212.74.66] (kliang2-mobl1.ccr.corp.intel.com [10.212.74.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 1A7EC580D9C;
	Mon,  5 Feb 2024 07:08:28 -0800 (PST)
Message-ID: <a5e8e3fe-a8c2-45e7-9139-84967cba06eb@linux.intel.com>
Date: Mon, 5 Feb 2024 10:08:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/uncore: avoid null-ptr-deref on error in
 pmu_alloc_topology
To: Fedor Pchelkin <pchelkin@ispras.ru>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, x86@kernel.org,
 Alexander Antonov <alexander.antonov@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240204134841.80003-1-pchelkin@ispras.ru>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240204134841.80003-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-04 8:48 a.m., Fedor Pchelkin wrote:
> If topology[die] array allocation fails then topology[die][idx] elements
> can't be accessed on error path.
> 
> Checking this on the error path probably looks more readable than
> decrementing the counter in the allocation loop.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 4d13be8ab5d4 ("perf/x86/intel/uncore: Generalize IIO topology support")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---

It seems the code just jumps to the wrong kfree on the error path.
Does the below patch work?

diff --git a/arch/x86/events/intel/uncore_snbep.c
b/arch/x86/events/intel/uncore_snbep.c
index 8250f0f59c2b..5481fd00d861 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3808,7 +3808,7 @@ static int pmu_alloc_topology(struct
intel_uncore_type *type, int topology_type)
 	for (die = 0; die < uncore_max_dies(); die++) {
 		topology[die] = kcalloc(type->num_boxes, sizeof(**topology), GFP_KERNEL);
 		if (!topology[die])
-			goto clear;
+			goto free_topology;
 		for (idx = 0; idx < type->num_boxes; idx++) {
 			topology[die][idx].untyped = kcalloc(type->num_boxes,
 							     topology_size[topology_type],
@@ -3827,6 +3827,7 @@ static int pmu_alloc_topology(struct
intel_uncore_type *type, int topology_type)
 			kfree(topology[die][idx].untyped);
 		kfree(topology[die]);
 	}
+free_topology:
 	kfree(topology);
 err:
 	return -ENOMEM;

Thanks,
Kan

>  arch/x86/events/intel/uncore_snbep.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index a96496bef678..7d4deb9126be 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3831,9 +3831,11 @@ static int pmu_alloc_topology(struct intel_uncore_type *type, int topology_type)
>  	return 0;
>  clear:
>  	for (; die >= 0; die--) {
> -		for (idx = 0; idx < type->num_boxes; idx++)
> -			kfree(topology[die][idx].untyped);
> -		kfree(topology[die]);
> +		if (topology[die]) {
> +			for (idx = 0; idx < type->num_boxes; idx++)
> +				kfree(topology[die][idx].untyped);
> +			kfree(topology[die]);
> +		}
>  	}
>  	kfree(topology);
>  err:

