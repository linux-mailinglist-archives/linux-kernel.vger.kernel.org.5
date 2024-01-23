Return-Path: <linux-kernel+bounces-36050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE07839AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B3828DF45
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825A853BA;
	Tue, 23 Jan 2024 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NzusgAwU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA635250
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043559; cv=none; b=fSG4XKwvfdvu3jkq5WWvT/kboHmbqGSb1sr0pyiV+/lOX4sEX0ZBtanjk44K7ppnU+4S/18seNZvXjXyMr5W/FI37Dc7eEUyrWboN/9KGY2Qbt1vH4h4z7+J2NTibla5Gui3xdHG2IVGsxA65Uj3wh8hDEuLcoLbK01/b7Ez21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043559; c=relaxed/simple;
	bh=0/FI8p1SE6PzHzqOaW3ljzb4454vuzBBOrRuHNH4K9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxRWvWNmpGwO14lL/bWWWJFDpH6sqZMvgcH0QGFJXFSmRDPt6P/BqG0r6k/E6sRqKEioBNBkM4W+VyejCqL4/WZt7AALJeiEUjPc2Q6EAi2YUkiO0pGTNPIDFzsYysXvdx8kSyUMMQ4FROhZpxzrjpeVDLpZDj2/pRl5XRMYj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NzusgAwU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706043559; x=1737579559;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0/FI8p1SE6PzHzqOaW3ljzb4454vuzBBOrRuHNH4K9s=;
  b=NzusgAwUjmkIim3XYoDf95qtG2nxdnPNn+g8JpbLxGgVvx7etbB7atsE
   oSzWtZ2S1g9Tg93qAt0VLA/GRZ0eg+YFH9m0L6BviEgvD9Ph9HrBzS/w3
   kTXvCRNxPgB+gAiPkBtf5eug+STn0rh0pckPvs7TXM3mSq2Q1bwk8IEfs
   uQEVecbNkYHg14EjfridqqDdTLSKZnkGV4GRW1qJUrgWhkpJijKS8lusr
   wpvXIED0e+yNbbWL0BrBmujG7YglSlXjIXtilGHEssin+wHJ7UDYQy8l+
   aMYEjz+OTIyJM/U3f/djuG5TsIlD+qr0mLi70/6tkbnAp+ydan8qyG1oD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8764718"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="8764718"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 12:59:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="905367654"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="905367654"
Received: from weifeng1-mobl1.amr.corp.intel.com (HELO [10.212.171.111]) ([10.212.171.111])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 12:59:16 -0800
Message-ID: <85109de4-5832-4e14-8416-6443ac417c9d@linux.intel.com>
Date: Tue, 23 Jan 2024 12:59:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
Content-Language: en-US
To: "Xing, Cedric" <cedric.xing@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, "Yao, Jiewen"
 <jiewen.yao@intel.com>, Qinkun Bao <qinkun@google.com>,
 Samuel Ortiz <sameo@rivosinc.com>, "Lu, Ken" <ken.lu@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240114223532.290550-4-sameo@rivosinc.com>
 <1bbf8d3e-aa94-48c7-a1e4-76f9eefc4af7@linux.intel.com>
 <65a72c305291f_3b8e29484@dwillia2-xfh.jf.intel.com.notmuch>
 <5539c533-37b2-4b12-a5c5-056881cf8e3c@linux.intel.com>
 <Za1G9I+tYuIL9ser@vermeer> <CF3D8DE1-AD47-4A77-B8BD-8A12A6F7E9DB@google.com>
 <MW4PR11MB5872F46A2089C8C2D8EF7A008C752@MW4PR11MB5872.namprd11.prod.outlook.com>
 <65aecbbce09dd_107423294b7@dwillia2-xfh.jf.intel.com.notmuch>
 <c3b99264-233b-4997-9e20-c4c2693b8cdc@intel.com>
 <65aeecea827f0_37ad2948@dwillia2-xfh.jf.intel.com.notmuch>
 <14dffda2-f413-4304-9932-3ac8ddfb30e4@intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <14dffda2-f413-4304-9932-3ac8ddfb30e4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/23/24 10:48 AM, Xing, Cedric wrote:
> On 1/22/2024 2:32 PM, Dan Williams wrote:
>> Xing, Cedric wrote:
>> [..]
>>>> So, yes, the mapping should be allowed to specified by the low-level
>>>> driver, but at the same time every vendor should not reinvent their own
>>>> enumeration method when we have EFI for that.
>>>
>>> Given PCR->RTMR mapping is static, I just wonder why it needs to be kept
>>> in kernel. Given that PCRs can never be 1:1 mapped to RTMRs, and that
>>> TDX quotes are never TPM quotes, applications used to extend PCRs would
>>> have to be changed/recompiled. Then wouldn't it suffice to define the
>>> mappings as macros in an architecture specific header file?
>>
>> I think something is wrong if applications are exposed to the PCR->RTMR
>> mapping thrash. I would hope / expect that detail is hidden behind a TPM
>> proxy layer sitting in front of this mapping on behalf of TPM-client
>> applications.
>
> Hi Dan,
>
> My apology for the confusion! I think we are talking about 2 different scenarios - (1) this patch alone; and (2) this patch + vTPM.
>
> Scenario 1: This patch provides RTMR access only. My assumption is, there are existing application (and/or kernel modules) that extend to PCRs today and would like to work in TDs where only RTMRs are available. Changes are of course necessary in those applications as TPMs/PCRs are no longer available, but from security perspective they would like to keep the same activity log and just change to use RTMRs (in lieu of PCRs) as the secure storage. Hence a PCR->RTMR mapping is necessary and must be agreed upon by all those applications and relying parties. IIUC, this is the intention of having PCR->RTMR mapping config maintained by the kernel, as proposed by Sam O. originally.
>
> Scenario 2: A vTPM is implemented on top of this patch, in which case the existing applications don't have to change as they can continue extending to the same PCRs, which will then be emulated by the underlying vTPM implementation. PCR->RTMR mapping in this scenario is obviously internal to the vTPM and I agree with you completely that it should be hidden inside the vTPM.
>
> My comment in my previous email was regarding Scenario 1. I hope the clarification above helps.


IMO, we should adapt an approach with as minimal user changes as possible. So I think we should try to avoid scenario 1 if possible.


>
> -Cedric
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


