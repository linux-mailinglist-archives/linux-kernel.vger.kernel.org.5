Return-Path: <linux-kernel+bounces-47825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB75845360
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD372286C12
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3E715AAD6;
	Thu,  1 Feb 2024 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g19CADUd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A30159571;
	Thu,  1 Feb 2024 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778270; cv=none; b=VeKCMafNKb38g2QPJNBRdZkY4pj8zKmgSn7LZ02zfzrUFUYaASF3mzywa1j5u5BjXjaFxliSZLWPph/ZS839QvCUKeSx7e2fqFHuUBbzZyVwh6aolNcxdpbvdknXIYU6ET8/PKhEd38AQA+Hus4oDAxU8DJ+7T3NZcTUbKTGJNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778270; c=relaxed/simple;
	bh=WEHuLNNIYqe3ayWos7yXk/oWPTdphOv3MXqYZro4v7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZjXtHRDum2wMrZNxwY1SL33q12vzAYBDiWAdtEHP9Qm8FqNo9fCJQSkky6w9uM7qGx3GhaaJGQLxPOV9fDWtMBxzddZJbsC3zr72eJWHXHttCtroBKpMR0PisbcxE6Wy27yFA9VH/abs1pdd2twIyX7x8W23smqFbHrsEj7y+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g19CADUd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706778269; x=1738314269;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WEHuLNNIYqe3ayWos7yXk/oWPTdphOv3MXqYZro4v7A=;
  b=g19CADUdW82uaxad2aW6jy+n1Ed6wEMGPXkh0Ai09aKdXbPd0UrKNAeR
   eWQ1KLlCh5nZ8zlOCStNlGQplJXElN2d1v5jlh1I5FRAmqCC1e4ab4IIp
   Glm1uHQeEXcATC9es8HpTbZhdiUOG9mizQNZRljFy1opWy+zathnUhnsy
   ovn+2VGdmi3tdKdExD9U6iW+caPlhFNqfqy1OB6kh4MHC+Zoetie3zq4r
   d9oEjOrlwGz0eE/D3zOw2ipnTEiijGz3z9uiJ2fA4f+BXO46V0TIKLest
   9FAt+KgmSr6LP0VPav+6wwLV4jGTN/NYCEvVHh6ugmjUU6LOVJwFUwu7S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="60331"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="60331"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 01:04:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4366156"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 01:04:25 -0800
Message-ID: <dde96dd7-eb33-41ca-9b08-3a2788164d02@linux.intel.com>
Date: Thu, 1 Feb 2024 10:04:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sound: soc: wcd934x: fix an incorrect use of kstrndup()
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, srinivas.kandagatla@linaro.org,
 bgoswami@quicinc.com, tiwai@suse.com, Fullway Wang <fullwaywang@outlook.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 fullwaywang@tencent.com
References: <PH7PR20MB59255EF9DFFB022CB1BBB574BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
 <170662942110.37296.1277489815994094565.b4-ty@kernel.org>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <170662942110.37296.1277489815994094565.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/2024 4:43 PM, Mark Brown wrote:
> On Thu, 18 Jan 2024 15:52:49 +0800, Fullway Wang wrote:
>> In wcd934x_codec_enable_dec(), kstrndup() is used to alloc memory.
>> However, kmemdup_nul() should be used instead with the size known.
>>
>> This is similar to CVE-2019-12454 which was fixed in commit
>> a549881.
>>
>>
>> [...]
> 
> Applied to
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 

Hi,

Mark, my other comment was meant to stop this patch from being applied 
;), perhaps I could have been more clear? kmemdup_nul() in this case 
will copy bytes behind the end of widget name when copying. Widgets to 
which it applies are named: "ADX MUX0", "ADC MUX1" and so on, until "ADC 
MUX 8", which is 10 bytes including '\0', and kmemdup_nul() will copy 15 
using memcpy().

