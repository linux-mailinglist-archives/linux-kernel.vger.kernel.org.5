Return-Path: <linux-kernel+bounces-65610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E52D9854F64
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88EC9B2B49A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E15F60DC2;
	Wed, 14 Feb 2024 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUbUbcg+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7024E60BA9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930139; cv=none; b=rFBfjexNxvNhZ0EdAo1VUnl19Rt9Obe6ssg6vOeleoEzUxiSUN7wmAuKbg3D+IXyQo0L8YxG3BfQ5wNykV5NF1J12cVBxnhJjDj6tcnLDdl4WhCostCSy9x1IGDmuHKMoO35tjWrOgwJS0UalQohs2s0DnZ1Oq9zSbQ09OMRiIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930139; c=relaxed/simple;
	bh=Ho2RD7gdZfHfrpoZRRhRTcd0IgtIA1/lazjYqexOxfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOlYkh9Eo8F0prOUdnTMtaERwlCaOcPvPK+XtazZaC3ZqoQXQ54N9APk9+nUB8TSBEuRBcQ+7NzAkowg8tRGskFWwukveAn9hdyBl1yIKkpHio+EJo0Z3ylDKEKgIwnhYTyLv3/e6MKMGhse29DHB9TUf9rYGAQDFXAb4Fp3lAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUbUbcg+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707930137; x=1739466137;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ho2RD7gdZfHfrpoZRRhRTcd0IgtIA1/lazjYqexOxfc=;
  b=lUbUbcg+SGwruBTxXS9dDLnfYr3Ci9hOvdh/K2Ewtm9EkE4J8o8tyhFB
   brqqShck/iJr8qd1RNzNRJwkbih5SmAzrnb9bhGbNjy6LWS7eL7sBoeYL
   xNDxCn+FQv58wQelGqpFaVaKuW6M8bga6tow1DrYKzuOOIFJcPYYrW6Qx
   bn3gzzjmvjBlXH6omUFrKn/Jb0ZdkxJ1SReO2cBrBVTXB7EjrVcKWXumr
   oIiC04SKAi6DQNT/nfjgXA3hZr/RMoYR9SXjB1EtDQN5MZyyjQjXNmLXN
   5eoLq2fKZtyF/ZPGkYaNXu417AWTJst5FIjhu5DmtFvluMNavd8FX+HTX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1859183"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="1859183"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:02:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3158982"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa007.fm.intel.com with ESMTP; 14 Feb 2024 09:02:04 -0800
Received: from [10.249.138.241] (mwajdecz-MOBL.ger.corp.intel.com [10.249.138.241])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id CCB1B27BAB;
	Wed, 14 Feb 2024 17:02:03 +0000 (GMT)
Message-ID: <3cce5e9d-a79f-4b26-b758-45679b94b6ff@intel.com>
Date: Wed, 14 Feb 2024 18:02:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] include/linux/make_type.h: Helpers for making u16/u32/u64
 values
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Jani Nikula <jani.nikula@intel.com>
References: <20240214155408.1569-1-michal.wajdeczko@intel.com>
 <ZczkhqW5_vU_hDbg@smile.fi.intel.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <ZczkhqW5_vU_hDbg@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14.02.2024 17:04, Andy Shevchenko wrote:
> On Wed, Feb 14, 2024 at 04:54:08PM +0100, Michal Wajdeczko wrote:
>> It is quite common practice to make u16, u32 or u64 values from
>> smaller words.  Add simple helpers for that.
> 
> ...
> 
>> +++ b/include/linux/make_type.h
> 
> If we go with this, please make better name so we can combine this with
> upper/lower_*_bits() helpers which seems related semantically to this.
> 

what about "include/linux/uintops.h" like we have bitops.h ?

