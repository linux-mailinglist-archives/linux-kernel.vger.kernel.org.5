Return-Path: <linux-kernel+bounces-47395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8995844D69
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8691F244AC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07DC3B197;
	Wed, 31 Jan 2024 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GcFM99Ol"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47163B187;
	Wed, 31 Jan 2024 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706745216; cv=none; b=bqKVOdtAcpOLXH8a+nTxglMVIO08K7Ae31j6rUtrxxf03WGTnq6tQoOohKITmIEVr55sDaMPUhocrZAo9wDYtYdiWBLpazGBIn/QIdv64uaZVCMS+9xpp31blvE5HpZQkfiOtW9LW7bDtnrZiij1mqA8+zvwDfGr+5ZGPTRti3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706745216; c=relaxed/simple;
	bh=He45rS3/X09I0lLu/frI9lfYU+Wtb0SyCW45+MrWfsM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bW+Q5sPVe2ijYayrACDCC+PWGKWElOdUrJFicgntH1QYw2Gq+IG7iCvgjU3RoSeGlzESJUu7ZlqzMaX6JbKkocVw88pGpckjmW0qr80CqftNs38TuXhlcQRnrtMSe+Y7OC/mwd5/1Brz1n9jp7lPHYQ42ZxpC+nQojy7DgDMV90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GcFM99Ol; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706745214; x=1738281214;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=He45rS3/X09I0lLu/frI9lfYU+Wtb0SyCW45+MrWfsM=;
  b=GcFM99OlwGBQauar3QVVV4HPkSD5JZIvM/hy9xpKp88mXd6gK/xDWlGD
   gia2zG3P5ZvBdllSVLqlspaDb0ZgpEwcKxrbwpQIck7NP94BPgE+bzNyN
   YdzcfaXlPVeWpyJbQVJHvYq+UOeLo3bhajuKu1kIsZ2j0+q63CwviQDyM
   rdongsRz07hhqku2ABgfJ8f+EqJS4LAOWHtvOrkiirRTUHxxttHTi/O/6
   hjDw4GSXHEdFJC2gXc0HQ8c7qOubgaKGGquRYQ9i4BP7QIgPAJGBET6/x
   M6DRL7apRMMWPPumIEOx+UvKefaf0a5sfrk0khE8v04kWnfcJGXcpUju/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2697424"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="2697424"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:53:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4209873"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:53:24 -0800
Date: Wed, 31 Jan 2024 15:53:23 -0800 (PST)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Xu Yilun <yilun.xu@linux.intel.com>
cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com, 
    linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: afu: update initialization of port_hdr
 driver
In-Reply-To: <ZbnTwcomGXOGs9SG@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2401311433120.112016@sj-4150-psse-sw-opae-dev2>
References: <20240122172433.537525-1-matthew.gerlach@linux.intel.com> <Za8ibeJc82Xkbpct@yilunxu-OptiPlex-7050> <alpine.DEB.2.22.394.2401241106550.77559@sj-4150-psse-sw-opae-dev2> <ZbjC501oRClByual@yilunxu-OptiPlex-7050> <alpine.DEB.2.22.394.2401300825020.112016@sj-4150-psse-sw-opae-dev2>
 <ZbnTwcomGXOGs9SG@yilunxu-OptiPlex-7050>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Wed, 31 Jan 2024, Xu Yilun wrote:

> On Tue, Jan 30, 2024 at 09:13:56AM -0800, matthew.gerlach@linux.intel.com wrote:
>>
>>
>> On Tue, 30 Jan 2024, Xu Yilun wrote:
>>
>>> On Wed, Jan 24, 2024 at 11:40:05AM -0800, matthew.gerlach@linux.intel.com wrote:
>>>>
>>>>
>>>> On Tue, 23 Jan 2024, Xu Yilun wrote:
>>>>
>>>>> On Mon, Jan 22, 2024 at 09:24:33AM -0800, Matthew Gerlach wrote:
>>>>>> Revision 2 of the Device Feature List (DFL) Port feature has
>>>>>> slightly different requirements than revision 1. Revision 2
>>>>>> does not need the port to reset at driver startup. In fact,
>>>>>
>>>>> Please help illustrate what's the difference between Revision 1 & 2, and
>>>>> why revision 2 needs not.
>>>>
>>>> I will update the commit message to clarify the differences between revision
>>>> 1 and 2.
>>>>
>>>>>
>>>>>> performing a port reset during driver initialization can cause
>>>>>> driver race conditions when the port is connected to a different
>>>>>
>>>>> Please reorganize this part, in this description there seems be a
>>>>> software racing bug and the patch is a workaround. But the fact is port
>>>>> reset shouldn't been done for a new HW.
>>>>
>>>> Reorganizing the commit message a bit will help to clarify why port reset
>>>> should not be performed during driver initialization with revision 2 of the
>>>> hardware.
>>>>
>>>>>
>>>>> BTW: Is there a way to tell whether the port is connected to a different
>>>>> PF? Any guarantee that revision 3, 4 ... would need a port reset or not?
>>>>
>>>> The use of revision 2 of the port_hdr IP block indicates that the port can
>>>> be connected multiple PFs, but there is nothing explicitly stating which PFs
>>>
>>> Sorry, I mean any specific indicator other than enumerate the revision
>>> number? As you said below, checking revision number may not make further
>>> things right, then you need to amend code each time.
>>
>> Using a revision number to indicate the level of functionality for a
>> particular IP block seems to be a widely used approach. What other indicator
>
> If you still want to make the existing driver work, some capability indication
> would have more compatibility. That's more reasonable approach. Or you
> need to change existing behavior for each new revision, that's not
> actually widely used.

I understand some capability indication would be better for compatibility 
implementation. A revision number change is not as explicit or precise as 
capability lists.

>
>> of functionality level did you have in mind?
>
> I'm not trying to make the design. You tell me.

One could use parameter blocks introduced in version 1 of the Device 
Feature Header (DFH), or capability registers could be added the IP block.
In this particular case it seems the least impact to upstreamed software is
to keep the DFH and the register map unchanged, except for an incremented
revision number field.

>
> If finally no indicator could be used, we have to use revision number. That's
> OK but make SW work harder, so I'm asking if anything could be done to
> avoid that.

In this case, I don't think anything else can be done without bigger 
impacts to the SW.

>
>>
>> The revision number of an IP block would change when new functionality is
>> added to an IP block or the behavior of the IP block changes. It would be
>> expected that SW might need to change in order to use the new functionality
>> or to handle the change in behavior of the IP block. Ideally the new
>> revision of an IP block would be compatible with existing SW, but that
>> cannot be guaranteed.
>
> People make the IP block, and be compatible should be the concern if it
> want upstream support.

Agreed, and making sure some capability mechanism exists when an IP is 
created would be a great start.

Thanks,
Matthew

>
> Thanks,
> Yilun
>
>>
>> Thanks,
>> Matthew
>>
>>>
>>> Thanks,
>>> Yilun
>>>
>>>> the port is connected to.
>>>>
>>>> It is hard to predict the requirements and implementation of a future
>>>> revision of an IP block. If a requirement of a future revision is to work
>>>> with existing software, then the future revision would not require a port
>>>> reset at driver initialization.
>>>>
>>>
>
>

