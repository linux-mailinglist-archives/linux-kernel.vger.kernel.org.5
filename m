Return-Path: <linux-kernel+bounces-68354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8F485792A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC59B228AC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532FC1BDE0;
	Fri, 16 Feb 2024 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMRg+Na/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A6C1BF28;
	Fri, 16 Feb 2024 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076840; cv=none; b=rJDWeRKmRns6iZufTzCWg+1uNZBr5yx0qiT8dHj/2mP3cb5UTb/Md/wGyc9gSEA5FHjy8wThNoyV475r8pcjWpkiL8W0rs7P5sgGjsNnZao/lvQuqkHOQgDljqTroyNewsIvgCe0lj18slTmZPVlFvsKGzSWvQ2AU0lh9dYNQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076840; c=relaxed/simple;
	bh=52oYAJx/bkBj6fjp/OHIlHLzNxTJ69+yLoxIJzbK3lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecaFBr6ypoXD4De+CFAzisQfvZn0X6Dy3u4Gg6XNPr2paXiNpv6Ek+9lRWgBW/dvPbVJpVq2mvrzuJSGgePqrT8WTjpLCLEIlMteSWMRH8glGBjkifrZtkpE9ScIAbXloXZTl0GU6qnPQkeTmkQ1BD9O7/16+l3uvVAuEmHqrAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMRg+Na/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708076838; x=1739612838;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=52oYAJx/bkBj6fjp/OHIlHLzNxTJ69+yLoxIJzbK3lo=;
  b=RMRg+Na/hvkTtrd12NOOJrbJyvxdwkNHE6bwGbVaQV0fi5H6AlxtX44d
   769HrkiD23yMTS0u43/v27Ec98NYkTJcNCf0k9xAWgU7nkcQdVkfQmeKD
   TfeW+HhLGAlBWSDySJe+kKlufcCZ+nuF+HNo1rtd9FBaDDcdHw3MvOATo
   0OTXDIJXv4YWjRu2c2p8cKKY6TogvX5XLXpm/RdAYUbNJFUwCJ68Y0RES
   qwTBPJ2lMYVidi3iRgkYAb3VP637ACqOOMTprlUCvrNcyjz85Njp6KUhf
   OK9aAgzr0lo18ZIOVEnpoG5/N9enlMkUVn982Xww8aQPCBKyQdcgKhMHh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="6028849"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="6028849"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 01:47:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="8475072"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.220.122])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 01:47:16 -0800
Message-ID: <c4d6a864-f1a6-47f0-ae03-c54556d34bc8@intel.com>
Date: Fri, 16 Feb 2024 11:47:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Enable Symbols test to work with a current
 module dso
Content-Language: en-US
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
References: <20240131192416.16387-1-adrian.hunter@intel.com>
 <CAP-5=fUrTzkAfXoto1P8SnTFApSSdt+mmWHCXSKVrr0kuphE0w@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fUrTzkAfXoto1P8SnTFApSSdt+mmWHCXSKVrr0kuphE0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/01/24 22:58, Ian Rogers wrote:
> On Wed, Jan 31, 2024 at 11:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> The test needs a struct machine and creates one for the current host,
>> but a side-effect is that struct machine has set up kernel maps
>> including module maps.
>>
>> If the 'Symbols' test --dso option specifies a current kernel module,
>> it will already be present as a kernel dso, and a map with kmaps needs
>> to be used otherwise there will be a segfault - see below.
>>
>> For that case, find the existing map and use that. In that case also,
>> the dso is split by section into multiple dsos, so test those dsos
>> also. That in turn, shows up that those dsos have not had overlapping
>> symbols removed, so the test fails.
>>
>> Example:
>>
>>   Before:
>>
>>     $ perf test -F -v Symbols --dso /lib/modules/$(uname -r)/kernel/arch/x86/kvm/kvm-intel.ko
>>      70: Symbols                                                         :
>>     --- start ---
>>     Testing /lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko
>>     Segmentation fault (core dumped)
>>
>>   After:
>>
>>     $ perf test -F -v Symbols --dso /lib/modules/$(uname -r)/kernel/arch/x86/kvm/kvm-intel.ko
>>      70: Symbols                                                         :
>>     --- start ---
>>     Testing /lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko
>>     Overlapping symbols:
>>      41d30-41fbb l vmx_init
>>      41d30-41fbb g init_module
>>     ---- end ----
>>     Symbols: FAILED!
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 

Thanks Ian!

This patch is still OK.


