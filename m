Return-Path: <linux-kernel+bounces-33047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9F68363A6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C5728DAF8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C243D3CF48;
	Mon, 22 Jan 2024 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPuiptVV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAE939AC2;
	Mon, 22 Jan 2024 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927530; cv=none; b=K7TR/k1I7GvrSHaP1/cjEo7qRk4RWEA4tH4UVRXRZenTgQHxr4VV6J2QsJ//D9ptpJ7TZU/ilIhH6zQ+uYCozpSbMkimEOAXzJZr8pM+4RdCvLN3ARZoNj7tFuKvBQlk1Qt65gyXuH10l4Ko8axzAlkD3jPUNsV2uNM3aoBIbso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927530; c=relaxed/simple;
	bh=DyzSZNWh2Ba/umuO/PUNv5e1PhQc+iQeI/bcwl4Rl2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbeLqDi0Q9AxnbSfyrZX+rkbexIQoPMioUTllGZaT08DU1ktZTXlmI6JAQRaYzUMV1vBIM+1ikucmMuuhdTb3Bn+m8RSB69NrzN9asB2kzSH9+n1J9T1YDGdC5nZuYLkYx46VtCJkKqeczQlhASOx9e69hVIC0Noxxj+5uPHaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPuiptVV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705927529; x=1737463529;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DyzSZNWh2Ba/umuO/PUNv5e1PhQc+iQeI/bcwl4Rl2E=;
  b=XPuiptVV+Z774VNDYUb0PaOB4Ftgg0ErPryO2xqwnAAezoGBdXmg2Cr9
   U8hHwdeFPjPLQOpNQ43C+ajeMrJNcygXClU3lo5YxrAxoeEtIqHawDk/b
   fCoB/jcMtRFPwD91YcIpbFbhVQQ87zOBmH94jk1vP7u2ivnZ/A2IqNK4b
   mrtF8f/LayGatouvrJ/Vp6MyzKeJV526w0kpJ/BxCDAK3ENBeZ6gb6z+R
   nlmmttj2UaFlSOrSJQCX5ZAed14KP+wk6pz7UWZKguBbCMiU1waqBC4ob
   0G3YpcTkDnzmxpIP3BTazE12W6P2EThb3nF2Ia8YGLk7CJHNrGzGfsQgx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="14540580"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="14540580"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:45:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="735147261"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="735147261"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.213.79.229]) ([10.213.79.229])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:45:26 -0800
Message-ID: <edee10e8-92a4-4e82-bacb-fd2311add712@linux.intel.com>
Date: Mon, 22 Jan 2024 04:45:22 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: intel_pstate: Directly use stored ratios for max
 frequencies
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh.kumar@linaro.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240118120513.1018808-1-srinivas.pandruvada@linux.intel.com>
 <6021639.lOV4Wx5bFT@kreacher>
 <c961bae053da7287bfce49b2c1c2e7e6c754710a.camel@linux.intel.com>
 <CAJZ5v0iFAPW5x3gWFnjYKLQQvWoJ65gdpwRhnyEgLD2p2pWUcA@mail.gmail.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
In-Reply-To: <CAJZ5v0iFAPW5x3gWFnjYKLQQvWoJ65gdpwRhnyEgLD2p2pWUcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/22/24 03:46, Rafael J. Wysocki wrote:
> On Mon, Jan 22, 2024 at 12:35 PM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
>> On Mon, 2024-01-22 at 11:53 +0100, Rafael J. Wysocki wrote:
>>> On Thursday, January 18, 2024 1:05:13 PM CET Srinivas Pandruvada
>>> wrote:
>>>> Avoid unnecessary calculation for converting frequency to
>>>> performance
>>>> ratio by using a scaling factor for the maximum non turbo and turbo
>> [...]
>>
>>> ---
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Subject: [PATCH v1] cpufreq: intel_pstate: Refine computation of P-
>>> state for given frequency
>>>
>>> On systems using HWP, if a given frequency is equal to the maximum
>>> turbo
>>> frequency or the maximum non-turbo frequency, the HWP performance
>>> level
>>> corresponding to it is already known and can be used directly without
>>> any computation.
>>>
>>> Accordingly, adjust the code to use the known HWP performance levels
>>> in
>>> the cases mentioned above.
>>>
>>> This also helps to avoid limiting CPU capacity artificially in some
>>> cases when the BIOS produces the HWP_CAP numbers using a different
>>> E-core-to-P-core performance scaling factor than expected by the
>>> kernel.
>>>
>>> Fixes: f5c8cf2a4992 ("cpufreq: intel_pstate: hybrid: Use known
>>> scaling factor for P-cores")
>>> Cc: 6.1+ <stable@vger.kernel.org> # 6.1+
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>> Tested on the system which showed the issue, this patch work fine.
> So I'm going to add a Tested-by from you to it or please let me know
> if you don't want me to do so.

You can add.

Thanks,

Srinivas



