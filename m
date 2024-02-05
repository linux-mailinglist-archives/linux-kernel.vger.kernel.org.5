Return-Path: <linux-kernel+bounces-52884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B52849DD2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA20828393C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA21A2D046;
	Mon,  5 Feb 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="eya33dR4"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AF52C861;
	Mon,  5 Feb 2024 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146341; cv=none; b=DEmEGDWgDaigcHoJW9B8iFUy3OZPThZfrsk4i9Zka5avzJQb9tLahyD/MKIHhPKRdMCXZzJa3iaKEoDkWeKVoIt3lLyCs/0c3OqTtjtUDxU0QHwmYV5XHdvcgd8PlpBnVNbZntGpA5mlOUsIW3p42rUs4bAsev/PbnypcjNDA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146341; c=relaxed/simple;
	bh=/oDW4VkCzBttrAvBPA7G49GfJJ6qlbRu0FSR1olVBxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K98gRf9iVTACCxuOetiC8k/cP4obGjzCNOxoDi/swyjPybO+9nfigjSL84HtsCMndpBlPPghhOIEiBn+B1CeDtO8JiUrOgx28A5Tb0x6k2L/rxLqE5734tMYEbq+acsbmZTPFUF1bcJYgd2+1C2z39CcdIfsNfyrAqMZ5SBXFWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=eya33dR4; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id AA50C4017243;
	Mon,  5 Feb 2024 15:18:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru AA50C4017243
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1707146336;
	bh=zLU8L9M1HzCeEuXoR+1c7zl0qLtECLfP/n7spRh3ewM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eya33dR4PSlpytfdtydfdJpDJY9s0lP7QUrwuZgSPvkZC5plV2BRqLrBUPvQdBgwK
	 9fZBGYFeo3/Yn5jqt9C/YqB0mgo53ZAsKdRNSSaNlQJGeLstcIyrAB6e9rIVfOlrl+
	 PHYlkCPz2RpWLsA5JTXu1a/eLWDMWvcsmSljEVic=
Date: Mon, 5 Feb 2024 18:18:56 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, x86@kernel.org, 
	Alexander Antonov <alexander.antonov@linux.intel.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Subject: Re: Re: [PATCH] perf/x86/uncore: avoid null-ptr-deref on error in
 pmu_alloc_topology
Message-ID: <2b5c4fbc-67c8-42f6-84a0-2adb4fbb0a2a-pchelkin@ispras.ru>
References: <20240204134841.80003-1-pchelkin@ispras.ru>
 <a5e8e3fe-a8c2-45e7-9139-84967cba06eb@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5e8e3fe-a8c2-45e7-9139-84967cba06eb@linux.intel.com>

Hello,

On 24/02/05 10:08AM, Liang, Kan wrote:
> 
> 
> On 2024-02-04 8:48 a.m., Fedor Pchelkin wrote:
> > If topology[die] array allocation fails then topology[die][idx] elements
> > can't be accessed on error path.
> > 
> > Checking this on the error path probably looks more readable than
> > decrementing the counter in the allocation loop.
> > 
> > Found by Linux Verification Center (linuxtesting.org).
> > 
> > Fixes: 4d13be8ab5d4 ("perf/x86/intel/uncore: Generalize IIO topology support")
> > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> > ---
> 
> It seems the code just jumps to the wrong kfree on the error path.
> Does the below patch work?
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c
> b/arch/x86/events/intel/uncore_snbep.c
> index 8250f0f59c2b..5481fd00d861 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3808,7 +3808,7 @@ static int pmu_alloc_topology(struct
> intel_uncore_type *type, int topology_type)
>  	for (die = 0; die < uncore_max_dies(); die++) {
>  		topology[die] = kcalloc(type->num_boxes, sizeof(**topology), GFP_KERNEL);
>  		if (!topology[die])
> -			goto clear;
> +			goto free_topology;
>  		for (idx = 0; idx < type->num_boxes; idx++) {
>  			topology[die][idx].untyped = kcalloc(type->num_boxes,
>  							     topology_size[topology_type],
> @@ -3827,6 +3827,7 @@ static int pmu_alloc_topology(struct
> intel_uncore_type *type, int topology_type)
>  			kfree(topology[die][idx].untyped);
>  		kfree(topology[die]);
>  	}
> +free_topology:
>  	kfree(topology);
>  err:
>  	return -ENOMEM;
> 
> Thanks,
> Kan
> 

In this way the already allocated topology[die] elements won't be freed.

--
Fedor

