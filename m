Return-Path: <linux-kernel+bounces-57056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E324784D378
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9F4283AA2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F7F127B6B;
	Wed,  7 Feb 2024 21:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MRVZbsNT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDDD127B46;
	Wed,  7 Feb 2024 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340138; cv=none; b=gyzDzSnOtqLtEkbBYLKuSMs3DTnurVuZT1rLbKsGcLpyPdYdpbcfvDtZxMNmmy/VLPqdt/SYRObleLFd8z9rPEp7BMEyKjAo9mBI8qiUyAFftZwX9lQysVzbhaUJmTp0h7JH/t1Ri0vwm6w7pd6tUQaX4NvNtkCGbIi5F6Icy7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340138; c=relaxed/simple;
	bh=ES++gTsdxdJ8gT+Nc5W70oPKKHmOzpvLYS1vBB9EanE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHfgmaKowuOJrEH58uro+LU40z0BIrHidvA3zCuKIk/DudzFLmTp1U5EbiEWKeA8rt2fIpQmrXYWo5MA3cOxHQOjJa0b8WX7O5gBykjh+3Tt9NJuMaBbr3HHDp304FsOyvWyg7XH+XNgfinfq2+MSNCyLmpMksXUPh53zmZZSFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MRVZbsNT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707340138; x=1738876138;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ES++gTsdxdJ8gT+Nc5W70oPKKHmOzpvLYS1vBB9EanE=;
  b=MRVZbsNTcXdM+gd8Y9wDUoBVh38tWoYg7HziLSbjSHwI03RdAB871ux2
   XZmIeg6+NP4GzeBd/WPPvztr0lIet7LfC6+h35O5Z2L7dqMFxsM4FhvKa
   HLAXPps4fFaa2bZSuqnnmRrEEbHBdd1fViWmvo7haSKLNPkppDNPyCRKR
   ofoBC2ZuYLs7pQPGfL8mRMnK1QSrezX5uBiwebm+7U/B7QPxwjWGJbUgP
   s8UkVRSufSPj8cny5ts2Sk18ce7wQBE/PtChWznOtK2xOIKK9iu6WioZu
   lMS0faY0HuePFBTjIujDPaKZkvKZxnoPXC9TUvZ+APmR8MFXLPhU5h1HK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="4947364"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="4947364"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 13:08:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="32526238"
Received: from srussjr-mobl1.amr.corp.intel.com (HELO [10.209.91.249]) ([10.209.91.249])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 13:08:55 -0800
Message-ID: <527da630-4952-4b1d-80c0-5a87997ff9fd@linux.intel.com>
Date: Wed, 7 Feb 2024 13:08:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
Content-Language: en-US
To: "Xing, Cedric" <cedric.xing@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Dan Middleton <dan.middleton@linux.intel.com>,
 Samuel Ortiz <sameo@rivosinc.com>
Cc: Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>,
 Dionna Amalie Glaze <dionnaglaze@google.com>, biao.lu@intel.com,
 linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240128212532.2754325-1-sameo@rivosinc.com>
 <c17a31e4fb30f5f9d4a337e5bd8d54cc6f99eef7.camel@HansenPartnership.com>
 <a255bc36-2438-41b7-b304-bcf7a6628bef@linux.intel.com>
 <42e14f74d3819c95fdb97cd2e9b2829dcb1b1563.camel@HansenPartnership.com>
 <1557f98a-3d52-4a02-992b-4401c7c85dd7@linux.intel.com>
 <85b7a4a679eada1d17b311bf004c2d9e18ab5cd3.camel@HansenPartnership.com>
 <b8140cc8-a56b-40f6-a593-7be49db14c77@intel.com>
 <fe1722c3618a8216cb53b8fd3f1b7cbb6fdff5a0.camel@HansenPartnership.com>
 <65c2e4aa54a0_d4122947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <22088ed3-51a4-415f-932c-db84c92a2812@intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <22088ed3-51a4-415f-932c-db84c92a2812@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/7/24 12:16 PM, Xing, Cedric wrote:
> On 2/6/2024 6:02 PM, Dan Williams wrote:
>> James Bottomley wrote:
>>> There isn't really anything more complex about an interface that takes
>>> a log entry, and does the record an extend, than an interface which
>>> takes a PCR extension value.  So best practice would say that you
>>> should create the ABI that you can't get wrong (log and record) rather
>>> than creating one that causes additional problems for userspace.
>>
>> Agree, there's no need for the kernel to leave deliberately pointy edges
>> for userspace to trip over.
>>
>> Cedric, almost every time we, kernel community, build an interface where
>> userspace says "trust us, we know what we are doing" it inevitably
>> results later in "whoops, turns out it would have helped if the kernel
>> enforced structure here". So the log ABI adds that structure for the
>> primary use cases.
>
> Dan, I agree with your statement generally. But with the precedent of TPM module not maintaining a log, I just wonder if the addition of log would cause problems or force more changes to existing usages than necessary. For example, IMA has its own log and if changed to use RTMR, how would those 2 logs interoperate? We would also need to decide on a log format that can accommodate all applications.


IIUC, CC event logging in firmware uses TCG2 format. Since IMA internally uses TPM calls, I assume it also uses the TCG2 format. I think we can follow the same format for RTMR extension.

I am wondering where will the event log be stored? Is it in the log_area region of CCEL table?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


