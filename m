Return-Path: <linux-kernel+bounces-65730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B668550E9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300FC1F21391
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6766512881A;
	Wed, 14 Feb 2024 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkxJZ8+7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E961170F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933345; cv=none; b=ktluBHusr1BETjeG7JGNf0KIneTX5XGq+EiRpk2lC49X+k+rixKA+0w69offRSs0u5H7T1k/bx8amQVGVrgg1gZkFhX7AmQXS4+IepcOTywYca50Mvx4Jh+FZ0yUFwPBwNZsy1WFVhET9iaNudcYrKI+mUaxkAVoHH52op7VuXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933345; c=relaxed/simple;
	bh=9VyRFRNE9YCdWhGu7VV0kydy/quU4V7g4ktmBCXYdLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErB88X51SQANAUUjFrFmIw2g7iIi19KskA6hj9XEyHuMxpRJcN/2ysVGJtK1V4Vuxws1+M7n8q2dnYifp4DaOPEB4IwVhrva+QkVXdx7BW8B29Yo8ur9MwptMtocZmCLHXcXUjlafG+k+7kgrRUXv0kqOKqvxvUi8Oz57WhPnBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkxJZ8+7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707933343; x=1739469343;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9VyRFRNE9YCdWhGu7VV0kydy/quU4V7g4ktmBCXYdLQ=;
  b=ZkxJZ8+7BfSIe2eYCbTfvGCm+zq3xiZUScrW7HzrEUOw/9zOAT9lGBea
   /d6oCh08D3Ckq1CgFW78h2iA3+3EctRmrlAs5pyUvbENbnqrUeCuF6f9a
   bXUflDibBp6Xxkb82DoawC/wJWhR/k34tKRGncTb6gX0SmcPNR+LSeAXC
   0zcEl5TM4fRh65r40fjJBkBtn1TeV/Ef8fh/rxJTwscmHLuhPi2wrhWhV
   1QRNZMDYTZctnTNIOrHNZ85C8/fIlbvZrWcRQLvpZBvJ6l2vt01332Apj
   Wh2ifECaDZDD6kP0kTJ+DLLyDg9UO2x+QSsFIeHVvyQw3Mglz7oSPXsa/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1862237"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1862237"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:55:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="34325208"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 14 Feb 2024 09:55:41 -0800
Received: from [10.249.138.241] (mwajdecz-MOBL.ger.corp.intel.com [10.249.138.241])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 83FFC12429;
	Wed, 14 Feb 2024 17:55:39 +0000 (GMT)
Message-ID: <53297b2e-b7ff-4b92-b937-116cadaf8b6d@intel.com>
Date: Wed, 14 Feb 2024 18:55:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] include/linux/make_type.h: Helpers for making u16/u32/u64
 values
Content-Language: en-US
To: Alexey Dobriyan <adobriyan@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Jani Nikula <jani.nikula@intel.com>
References: <ffa107dd-23dd-47e0-b3bb-06c60ca3e2e2@p183>
 <Zcz5GmAtPbdInWJU@smile.fi.intel.com>
 <cee345b1-a5aa-41bb-acb7-9b2aaef5bfb5@p183>
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <cee345b1-a5aa-41bb-acb7-9b2aaef5bfb5@p183>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14.02.2024 18:39, Alexey Dobriyan wrote:
> On Wed, Feb 14, 2024 at 07:32:10PM +0200, Andy Shevchenko wrote:
>> On Wed, Feb 14, 2024 at 08:20:55PM +0300, Alexey Dobriyan wrote:

..

> 
> Thirdly, there were no users posted.

for make_u64() there is already one at [1]
and Jani pointed other potential candidates [2]


[1]
https://elixir.bootlin.com/linux/v6.8-rc4/source/drivers/gpu/drm/xe/xe_gt_pagefault.c#L555

[2]
https://lore.kernel.org/intel-xe/87cysz6ud7.fsf@intel.com/T/#md6577722f9226258c8eb99119707e12db4dd3b79

