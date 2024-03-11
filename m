Return-Path: <linux-kernel+bounces-99329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 695E28786B1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC461C210CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96C2524D6;
	Mon, 11 Mar 2024 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0tVV5DE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B203753E00;
	Mon, 11 Mar 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179531; cv=none; b=fC9sXT23iOHUJ0J3mRPFlTVp59rO1meDOIE5Ewj4g9g9LcyJvlCFW3hQev/hQiru8dZhBe2Q2+p9C1Pc+z4DpzflFBCNA3p8dezuoN43GSnvZapzRd58wb94T+9KVUOuo1bRogxl5PeQZoeubTeZojWcZcfRahSbj1gi3KzgzZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179531; c=relaxed/simple;
	bh=0xbA3b4MdRDSG9lBEC4D6pcd9ZmnWOomaUTYuVXJLnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrJx15oQ2IYtyH0LJGKrDVKiYE5i0Vttju2cGVUjrUBhmat4tKa9528xcgAed+Qmsq9zIZ6ZG3vUPa6M4rNzlESVI8aYH3bJA8jONPtt7KngBZD9AR1JgFaI+fVzhW1NNvmiNRIq9GOWCtbOSHQcqVy4rukis+N95Fjksebk1i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0tVV5DE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710179528; x=1741715528;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0xbA3b4MdRDSG9lBEC4D6pcd9ZmnWOomaUTYuVXJLnA=;
  b=F0tVV5DEKxMlhFjD6YP2yrIP4OVO8GtbDu7zoH587stxN9GuYnNbEqyz
   e0lpWkQkn9G3Mi53UdDuKj3/EQc2vWYJwUJFVeaXdYEAVag8blWsZdGFm
   NFuZ13OhQ8c0u7PygUCmdo9nNA5sTOE8cQHyamdO7VHuEmbnh0RYZhOLZ
   F3PxSwHHuLv32OPDyQh2tl92XT5FtzUdj7n06K4m1NE9uH9HMxeOEZMke
   KimK0MTysWkPVWvgyG/B6VRmfyvMX/Itnigl5QAdkE8EK80LTwU9LvJzm
   mPXnLE9FIv0NxSpIr0s9s5ebtWSrSAkWOzRQ8IfdHe21/AcvDhwwoApfY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4973442"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="4973442"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 10:52:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="15902421"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.52.80])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 10:52:06 -0700
Message-ID: <3a92ebdb-8923-46af-a020-0e12233262a9@intel.com>
Date: Mon, 11 Mar 2024 19:52:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python: Add a script to run instances of
 perf script in parallel
To: Andi Kleen <ak@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240310193502.2334-1-adrian.hunter@intel.com>
 <Ze8ttn4bxBrYi63h@tassilo>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Ze8ttn4bxBrYi63h@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/03/24 18:13, Andi Kleen wrote:
> On Sun, Mar 10, 2024 at 09:35:02PM +0200, Adrian Hunter wrote:
>> Add a Python script to run a perf script command multiple times in
>> parallel, using perf script options --cpu and --time so that each job
>> processes a different chunk of the data.
>>
>> Refer to the script's own help text at the end of the patch for more
>> details.
>>
>> The script is useful for Intel PT traces, that can be efficiently
>> decoded by perf script when split by CPU and/or time ranges. Running
>> jobs in parallel can decrease the overall decoding time.
> 
> This only optimizes for the run time of the decoder. Often when you do
> analysis you have a non trivial part of it in some analysis script too,
> but you currently have no directi / easy way to paralelize that. It would 
> be better to support parallel pipelines.

It will parallelize any scripts and / or dlfilters that perf script
itself executes.

> 
> TBH I'm not sure the script is worth it. If you need to do parallel
> pipelines (which imho is the common case) it's probably better to just
> write a custom shell script, which is not that difficult.

It can be a pain to figure out how best to split the data if it is not
evenly distributed.

The script also has value as a reference or starting point for
users.

>                                                           It might be
> better to have a helper that makes writing such scripts easier, 
> e.g. figuring out reasonable options for manual parallelization
> based on the input file. I think parts of your script do that, maybe
> it is usable for that.

The --dry-run option shows the perf script commands, but an option
to pipe through another command could be added.

> 
> Also as a default output it would be better to just merge the 
> original output in order and output it on stdout.

That assumes that the output comes from perf script printf
output and not a perf script _script_.

If the data is split by CPU, it will not be in time order
if it is simply concatenated back together.

> 
> You should probably limit the number of jobs to some minimum
> length, otherwise on systems with many CPUs there might be
> inefficiently short jobs.

That happens for Intel PT (64 PSB minimum), but could be added
for the normal case also.



