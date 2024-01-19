Return-Path: <linux-kernel+bounces-30816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53502832497
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9601C22EED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8337BBA31;
	Fri, 19 Jan 2024 06:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BdUxOKmk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C586944E;
	Fri, 19 Jan 2024 06:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705645757; cv=none; b=R+2RFEMbHlM3smOlQ6E/aaM/SzNh0FscKBDGc9VszGtWOyQZu5IdvH5dNBGHkGGrdY72XMpRHm4cQV/SMgT9EwKInG0f1kxRmscy4m6qJimLeXpgv1WTJxmLC/s/sj42ql9+4Ubdxd+GdeTJTcnzEpEnIDVuTKXK+APHLKh/9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705645757; c=relaxed/simple;
	bh=KpM91AaUX8HFXOLN3PW3rJonDM4bBrfk7asugj1BqkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+F7S/upkkm4QmcK2Ugil+Z6qtgMHmYe3khRjmUMueQvvUyqN+P7wGNhwHYgOUugG7sA5e59hlkcDP4hn4rMIK9TPD7fLjd1YCXPR5jUW1E4gDMBjnPgIks4Mnm0VIGLqcTzPDYtNuutZY5G8IJE1i0YHODRnLizuizzA/F4ydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BdUxOKmk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705645756; x=1737181756;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KpM91AaUX8HFXOLN3PW3rJonDM4bBrfk7asugj1BqkQ=;
  b=BdUxOKmkCnz9G4/t96N4WCgj0KE87CT/YuYLXVpgYm0RyozOlzwlBQ0N
   /cVOI7ArFXc+/UaiEdxyz/1yEjGp/6X+AK8NRfxXEyAHC3+jT9pFUhjGu
   kHKwUpK6NnGKCBCCTy0EzFBrkCTwFpqlf/i+w4wexnoP53DbXYZ59zEUI
   5cFWj+ibhpStS3l8SUaIXddD7/xNheuUWsbdywFMrNTlJ2gU9wKGrI98K
   3Ft9kAqQiRW+8hwyTzvYxg8nT8y0SYQuplPb0+ZXEQBUEByE32WluDAps
   ASyEaO9uAFZoaaVnEFX09/KX4PcfzRLukbajwIPG+lM6yGAWvasAZ8jSB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="22166515"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="22166515"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 22:29:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="572091"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.39.208])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 22:29:12 -0800
Message-ID: <3d5266d5-e5e1-49f9-8fb3-b736dc79e5e6@intel.com>
Date: Fri, 19 Jan 2024 08:29:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] perf: script: add field 'insn_disam' to display
 mnemonic instructions
To: Changbin Du <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, changbin.du@gmail.com
References: <20240118041224.2799393-1-changbin.du@huawei.com>
 <20240118041224.2799393-4-changbin.du@huawei.com>
 <5766b575-e2db-4a56-9808-31a64bc72402@intel.com>
 <20240119035735.y427wcmsm7dow6h4@M910t>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240119035735.y427wcmsm7dow6h4@M910t>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/24 05:57, Changbin Du wrote:
> On Thu, Jan 18, 2024 at 09:49:41PM +0200, Adrian Hunter wrote:
>> On 18/01/24 06:12, Changbin Du wrote:
>>> In addition to the 'insn' field, this adds a new field 'insn_disam' to
>>> display mnemonic instructions instead of the raw code.
>>
>> 'disam' seems an unusual abbreviation, and the 'insn' part seems a bit
>> redundant.  Could this be just 'disasm' instead of 'insn_disam'?
> 
> Personally, I'd preserve the insn_ prefix. So we have two related fields 'insn'
> and 'insn_disasm'.
> 

'ip', 'sym' 'dso' are all related but do not have a common prefix.  Also
most of the field names lean towards abbreviation.

