Return-Path: <linux-kernel+bounces-48562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBCC845DE7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DEC91C28E53
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976F833CC3;
	Thu,  1 Feb 2024 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLU5qaP4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562662940A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806654; cv=none; b=ctj1I2HpB80GFd4XewDnRhtXyGtiMd93eX9CKubWjsCt7OmdZN/8ccDRRJ8bAVC8YFCaZ/aMsdZXvqu2xltGSg233cjMRigbDxqYeIosXoBIB6anCKgnMrOtDin3ZRJWjUa3zaDOgcICe9UBx2ZqwISdj+YQr3TvE43aNKKOeI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806654; c=relaxed/simple;
	bh=tmPBxHFCmPRXsppuDaRw8WdccO/bTonrGAJ/uaLSFhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GoYaQZ9q22M6Zv7l7uzLv0H/5ps1HCen/oSIc7cEl2WSbTEQYjoZbNW0tSa7SMx+NWidqMWE6SMSPMPbIP5MpZA7a0hn/6b9n0FHEx3dHAhGVRWmuibZOpxTaVvGr8WHHteGKaPpChLq7zEkGbwm28Mz8WI8mXvCNecnoAbCWQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLU5qaP4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706806653; x=1738342653;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tmPBxHFCmPRXsppuDaRw8WdccO/bTonrGAJ/uaLSFhw=;
  b=WLU5qaP4dRnWUU/D7w+pCFupE+On+8HtEMtPQI9TcqpmgKiYmZ+RJLsi
   8H9FtAdYKUYKl2H02vwQUs6wPjvKSHSELP9SleqYjeOgaCj3gpYbSH8c5
   qNobDbRQSJ67VLMfG2RCJU+hLz28tUBFOPM8UGeZsX7aWjulVEdxYokqT
   sg+tFvCBG8+eQsVJ/or1SKgfMg7gvnf34yty1+AUREemyv+WDvlft+JVa
   ZpWmGLERU1PvFWEvRKAkSdChYuwILofZsOmqxD+C57r0IKaMWwwgTYxRK
   JxFkGoykT2aV/+BB5sm3Byp2lwNojb4C4r13umbUxsJloeTt+fCJJIYpU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2874627"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="2874627"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 08:57:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="908299477"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="908299477"
Received: from arbartma-mobl.amr.corp.intel.com (HELO [10.212.155.10]) ([10.212.155.10])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 08:57:29 -0800
Message-ID: <b2d1e806-5bb0-44f9-a1be-498ddadd37a3@intel.com>
Date: Thu, 1 Feb 2024 08:57:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] x86/kexec(): Reset TDX private memory on platforms
 with TDX erratum
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Huang, Kai" <kai.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
 bp@alien8.de, mingo@redhat.com, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, thomas.lendacky@amd.com, chao.gao@intel.com,
 bhe@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com
References: <cover.1706698706.git.kai.huang@intel.com>
 <b52ed259e0d487b3a968b98da91cb4f55a28ae82.1706698706.git.kai.huang@intel.com>
 <12a927df-e437-40ff-ba4d-ceca5446c5b1@intel.com>
 <l3uo3n3li27czehll2wz34xxkcv5j2vcshgp5a6w7u4h4aidpu@4oe2cwye2e6z>
 <0c990c7d-4df9-45c1-8c03-980d9842b963@intel.com>
 <ixp6wj4763kc5vgpmipyrijddwnxblhdn2v7hio7ze756w5f2x@6uyc7hwtrbbn>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <ixp6wj4763kc5vgpmipyrijddwnxblhdn2v7hio7ze756w5f2x@6uyc7hwtrbbn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/24 06:39, Kirill A. Shutemov wrote:
>> On 1/02/2024 6:03 am, Kirill A. Shutemov wrote:
>>> On Wed, Jan 31, 2024 at 01:21:39PM -0800, Dave Hansen wrote:
>>>>>   #ifdef CONFIG_KEXEC_JUMP
>>>>>   	if (image->preserve_context)
>>>>>   		save_processor_state();
>>>>> +	else
>>>>> +		tdx_reset_memory();
>>>>> +#else
>>>>> +	tdx_reset_memory();
>>>>>   #endif
..
> +void save_processor_state(void);
> +void restore_processor_state(void);
> +
>  #ifdef CONFIG_SUSPEND
>  extern suspend_state_t pm_suspend_target_state;
>  extern suspend_state_t mem_sleep_current;
> @@ -491,8 +494,6 @@ static inline int is_hibernate_resume_dev(dev_t dev) { return 0; }
>  extern struct mutex system_transition_mutex;
>  
>  #ifdef CONFIG_PM_SLEEP
> -void save_processor_state(void);
> -void restore_processor_state(void);

It's a little funky that we've got a #ifdef CONFIG_KEXEC_JUMP in the .c
file and then we're dodging around an #ifdef CONFIG_PM_SLEEP in the
header.  This is one of the reasons we shouldn't be putting #ifdefs in
c files in the first place.  But I digress...

Either way, if you focus on getting the dang #ifdef out of the main code
flow, the rest will fall in place easily.  Heck, if you even do this in
the x86 kexec code:

static void kexec_save_processor_start(image)
{
#ifdef CONFIG_KEXEC_JUMP
	if (image->preserve_context)
		save_processor_state();
#endif
}

it'll leave you with:

	kexec_save_processor_start(image);

	/* Give a good reason here */
	if (!image->preserve_context)
		tdx_reset_memory();

which is *FINE*.  No funky #ifdefs, indentation or else's dangling about.



