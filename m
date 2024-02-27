Return-Path: <linux-kernel+bounces-82862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 943E1868ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E962881C7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528A65FF08;
	Tue, 27 Feb 2024 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Up/grDd8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D85EE98
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022410; cv=none; b=E+iO9ys47yqR1D+RMaoG1av44CSY89v1JT5T8wfg75Pm1YzGAZxlw2aEOQAw8qPuH4a4oaKa8IGR7AvcZO71L5Q5WaCREPEULVrVfdkI7mX506u2bJaUu8x7ehy5lfiZxxsAsKqTrn+lnXuUgswFftsKPdb58PHyDVGwDrY4T6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022410; c=relaxed/simple;
	bh=o2XMkzXMkwPFel/APz6jVJp+QxaW7CBccneLWcc1hPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mAH2UKHYiVSJUZGXJnYl6PbaYDRC4xzzk6JgcDf2NTjDe9fzsGq5ieDDwBwieSC2VieEnfAS2K/1cZXLbta68FrEYm3SuNiQdK3FF9njuuiR0PRZqSqyaByfhg3kpCbsC6va9tuEq5QWYcO4i/1HTmWHI+xx7+evmx9mHkSpqaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Up/grDd8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709022409; x=1740558409;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=o2XMkzXMkwPFel/APz6jVJp+QxaW7CBccneLWcc1hPY=;
  b=Up/grDd8f9sBt6le306w2tufo7JtDty3qrd2I4Q8TfkEXo0KzNrq4yDV
   Wwwq5w+8BNjsbE/ltwg0d0/w5d8G2tGxBa0vDkKiiNmZcslXozU4f1MVQ
   vwkKhKqbyLXsvgqL8OOM/9sMibjmYlhedTCP4xtTitCOWEuF4h/LziB3u
   +l9dgRjhGfisOKDlp6HM7XrT2Kx/S/RZPX+uVlG0wbc/2Zl7JQ2sCXBPZ
   Sd96sg0Y+xxPjtF6m/XELDqC0qBeBRrrbwA+qRIv0L+CRfCgATSGiQRDF
   wKNhkye1bV3OvvLZB2vkJ85zv5nZ8owTYx/644SdejT4cjCwjilay7/pA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3510488"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3510488"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 00:26:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7112705"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 00:26:44 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  <hannes@cmpxchg.org>,
  <dan.j.williams@intel.com>,  <dave.jiang@intel.com>
Subject: Re: [RFC 1/1] mm/mempolicy: introduce system default interleave
 weights
In-Reply-To: <Zd19JvKrhMho20Fg@memverge.com> (Gregory Price's message of "Tue,
	27 Feb 2024 01:11:50 -0500")
References: <20240220202529.2365-1-gregory.price@memverge.com>
	<20240220202529.2365-2-gregory.price@memverge.com>
	<87wmqxht4c.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZdgxaLSBznupVmJK@memverge.com>
	<87sf1jh7es.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZdygZ8ZidfaORg8F@memverge.com>
	<87edcyeo78.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Zd10+G4XIrPoojJE@memverge.com>
	<87a5nme9c1.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Zd19JvKrhMho20Fg@memverge.com>
Date: Tue, 27 Feb 2024 16:24:49 +0800
Message-ID: <875xyae2lq.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Tue, Feb 27, 2024 at 01:59:26PM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> > I have to press this issue: Is this an actual, practical, concern?
>> 
>> I don't know who have large machine like that.  But I guess that it's
>> possible in the long run.
>>
>
> Certainly possible, although that seems like a hyper-specialized case of
> a supercomputer.  I suppose still worth considering for a bit.
>
>> > I suppose another strategy is to calculate the interleave weights
>> > un-bounded from the raw bandwidth - but continuously force reductions
>> > (through some yet-undefined algorithm) until at least one node reaches a
>> > weight of `1`.  This suffers from the opposite problem: what if the top
>> > node has a value greater than 255? Do we just cap it at 255? That seems
>> > the opposite form of problematic.
>> >
>> > (Large numbers are quite pointless, as it is essentially the antithesis
>> > of interleave)
>> 
>> Yes.  So I suggest to use a relative small number as the default weight
>> to start with for normal DRAM.  We will have to floor/ceiling the weight
>> value.
>
> Yeah more concretely, I was thinking something like
>
> unsigned int *temp_weights; /* sizeof nr_node_ids */
>
> memcpy(temp_weights, node_bandwidth);
> while min(temp_weights) > 1:
>     - attempt GCD reduction
>     - if failed (GCD=1), adjust all odd numbers to be even (+1), try again
>
> for weight in temp_weights:
>     iw_table[N] = (weight > 255) ? 255 : (unsigned char)weight;
>
> Something like this.  Of course this breaks if you have two nodes with a
> massively different bandwidth ratio (> 255:1), but that seems
> unrealistic given the intent of the devices.

Better to evaluate the maximum error introduced.  For example, for 3:2
bandwidth, the result could be 2:1.  That appears not necessary.

--
Best Regards,
Huang, Ying

