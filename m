Return-Path: <linux-kernel+bounces-85082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D39786B021
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A210A1F27E86
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A1C14EFC5;
	Wed, 28 Feb 2024 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2CrOEQD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2D11E493;
	Wed, 28 Feb 2024 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126515; cv=none; b=VmNRH1+w+DCisSP+Od64ourI/k51AjReKmOe44aNogOzi6N7VFLFODm0rVBYkARW6m8xVk3KUj7zx5zv5q8s3NuqonDswBqLi6vb+kpheR0mk73l/tJzQ8r9Mh/Muajgv0RwkYMASS8PjKmYsz+Hk1j8BtKrC+UZQg8Qjq2XbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126515; c=relaxed/simple;
	bh=7r4vZZPJYXmHBCI3JedHoQntu3Jc2TVJ9jZ97EA73XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y76yEyeMAnl/rfyJTPk5XewsGMIyQ6YTJn/zSQlux8i/1ikMLvuHVlmbsNoOOQUatnFMUNWsRnPUeRwB38ZreDwMKaNA0dhum0dTKc+w4oO7FWT1XOTRJ6mdT0/WmBp1d6USaxaN7s9t2w1lZVNT4x3aQ2FHirUKr6dyPH1qGhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2CrOEQD; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709126514; x=1740662514;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7r4vZZPJYXmHBCI3JedHoQntu3Jc2TVJ9jZ97EA73XI=;
  b=G2CrOEQDv8QAdfJahVysEP0tZc2Q/r4MwPP9oGg25Q9OUGz4Y4EX6zfb
   XC75PTcDxHm8FBAeDcd5y6q79Wp6ZF2awZBs+0juQSeC/4ORfHkLmWHfN
   51uGrvCgGjc3g+oMncTIzR2KDv2QQJD01qkzmYrdX2weziGxD/LxSBCLE
   ACCZ4AZAw1FepQ2lxuZJOs+8qiw01L5KsxeTTXx87hIOcNE501+rM6HnI
   OHeZwnzA+oK6lcXoT6cudNjbmh93wHVtFPMMVOBy1JJ07Ajl+WV647i1m
   aI732vnXm9u2TcpkAM6byPPY8amWoZgkxt0052oJuXtey+w4S5FoGroH8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3398010"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3398010"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 05:21:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="12100689"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.3])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 05:21:51 -0800
Message-ID: <4618f19d-0b7d-4844-83f7-ff2f4be083d9@intel.com>
Date: Wed, 28 Feb 2024 15:21:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] mmc: sdhci_am654: Add tuning algorithm for delay
 chain
Content-Language: en-US
To: Judith Mendez <jm@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20240207011520.3128382-1-jm@ti.com>
 <20240207011520.3128382-2-jm@ti.com>
 <461a19cd-36ce-4c34-890e-655a05a81c58@intel.com>
 <6d939482-9a3a-4923-b74b-ceb31b0ba7e9@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <6d939482-9a3a-4923-b74b-ceb31b0ba7e9@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/02/24 22:10, Judith Mendez wrote:
> On 2/16/24 11:09 AM, Adrian Hunter wrote:
>> On 7/02/24 03:15, Judith Mendez wrote:
>>> +
>>> +    if (!num_fails)
>>> +        return ITAPDLY_LAST_INDEX >> 1;
>>> +
>>> +    if (fail_window->length == ITAPDLY_LENGTH) {
>>> +        dev_err(dev, "No passing ITAPDLY, return 0\n");
>>> +        return 0;
>>> +    }
>>> +
>>> +    first_fail_start = fail_window->start;
>>> +    last_fail_end = fail_window[num_fails - 1].end;
>>> +
>>> +    for (i = 0; i < num_fails; i++) {
>>> +        start_fail = fail_window[i].start;
>>> +        end_fail = fail_window[i].end;
>>> +        pass_length = start_fail - (prev_fail_end + 1);
>>> +
>>> +        if (pass_length > pass_window.length) {
>>> +            pass_window.start = prev_fail_end + 1;
>>> +            pass_window.length = pass_length;
>>> +        }
>>> +        prev_fail_end = end_fail;
>>> +    }
>>> +
>>> +    if (!circular_buffer)
>>> +        pass_length = ITAPDLY_LAST_INDEX - last_fail_end;
>>> +    else
>>> +        pass_length = ITAPDLY_LAST_INDEX - last_fail_end + first_fail_start;
>>> +
>>> +    if (pass_length > pass_window.length) {
>>> +        pass_window.start = last_fail_end + 1;
>>> +        pass_window.length = pass_length;
>>> +    }
>>> +
>>> +    if (!circular_buffer)
>>> +        itap = pass_window.start + (pass_window.length >> 1);
>>> +    else
>>> +        itap = (pass_window.start + (pass_window.length >> 1)) % ITAPDLY_LENGTH;
>>> +
>>> +    return (itap < 0 || itap > ITAPDLY_LAST_INDEX ? 0 : itap);
>>
>> Parentheses are not needed where they are but putting
>> them around the condition would make it more readable e.g.
>>
>>     return (itap < 0 || itap > ITAPDLY_LAST_INDEX) ? 0 : itap;
>>
>> However (itap < 0) is not possible because itap is an unsigned type
>> and if (itap > ITAPDLY_LAST_INDEX) then maybe it would be better
>> to return ITAPDLY_LAST_INDEX
> 
> You are right about itap < 0, thanks will fix.
> 
> About itap > ITAPDLY_LAST_INDEX, this is an error. Why
> return ITAPDLY_LAST_INDEX instead of 0?

It doesn't matter.  Just if a value has a better chance to work
if the calculation fails, like maybe ITAPDLY_LAST_INDEX / 2, but
presumably it should not fail.


