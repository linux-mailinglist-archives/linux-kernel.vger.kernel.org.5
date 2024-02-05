Return-Path: <linux-kernel+bounces-54086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBE984AA88
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF82A1C23541
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E57948CF0;
	Mon,  5 Feb 2024 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtP491pU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683A1EF1D;
	Mon,  5 Feb 2024 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707175868; cv=none; b=tzOLciUWcK3HyOvfnTmFK1j+MJrwfpa4Xqj44TFzOoTTeMV33bwNOXNWawO7HgdT2XnHkth5jgVADJJT0LaUYBFdQMXOVNC8bF4xZmoywigO5PF1oM01oa04/ipYH24IOp0TLHh/uGcyjyUUG1baEYOl4naMDaWXsJrouwsig18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707175868; c=relaxed/simple;
	bh=JKQq0v2G4CXuGavU90HKWmX/FivxnNgkRXeV39/RDl0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qcHWdu0icf3CVlJgLh9xY3ZQPuOLSfEm8pJo0ArwIXaKOsrI2DsgCw8K0xaXz1RfnP9pVcDFW+DQtiCpM5h21p6IBiQWG32C68Tm7sfpG6tnw6YqgIBMfD+yIR+NrCJJk9Cd+KDfNjrmaiZWV7JuftvjZQDQDjMaF4aEhsAnJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WtP491pU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707175867; x=1738711867;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JKQq0v2G4CXuGavU90HKWmX/FivxnNgkRXeV39/RDl0=;
  b=WtP491pUyblL1cbLJWW+oCY82Es1jlgWl8rV22SI2l9VXM1HC9sRes0V
   tUhoGFVcYb7YWgKYcAZnqFBC7Ts88E6PpeAIKvxtJlz97gH/hXlOEHTEF
   AaFqU8OEWaPUi9Oj8kbVrhEatcDGS4llNT3gCTaQBcRp3NwMT+oMV4gHR
   5GS6bPzVwAzv3lMEXBwkX+ey5o+h1C13mjYm8fS0JE3MxuJ0ZVCa0xde+
   bjyXP6eVR0CAB1pb3ozT9gx18iwVzt2zzyvdTfXFfrDesLtvj9r/8TSZL
   Q0SY+LBAnHOa3p0Q/by7PQpQZQNuXxF8DLxZ8wQVOMuMdcZ52X+HGj0Lu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="18153696"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="18153696"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 15:31:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="909432355"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909432355"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 15:31:06 -0800
Date: Mon, 5 Feb 2024 15:30:55 -0800 (PST)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Xu Yilun <yilun.xu@linux.intel.com>
cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com, 
    linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: afu: update initialization of port_hdr
 driver
In-Reply-To: <ZcBNTdOulDvlIxmY@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2402051519340.122158@sj-4150-psse-sw-opae-dev2>
References: <20240122172433.537525-1-matthew.gerlach@linux.intel.com> <Za8ibeJc82Xkbpct@yilunxu-OptiPlex-7050> <alpine.DEB.2.22.394.2401241106550.77559@sj-4150-psse-sw-opae-dev2> <ZbjC501oRClByual@yilunxu-OptiPlex-7050> <alpine.DEB.2.22.394.2401300825020.112016@sj-4150-psse-sw-opae-dev2>
 <ZbnTwcomGXOGs9SG@yilunxu-OptiPlex-7050> <alpine.DEB.2.22.394.2401311433120.112016@sj-4150-psse-sw-opae-dev2> <ZcBNTdOulDvlIxmY@yilunxu-OptiPlex-7050>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Mon, 5 Feb 2024, Xu Yilun wrote:

> On Wed, Jan 31, 2024 at 03:53:23PM -0800, matthew.gerlach@linux.intel.com wrote:
>>
>>
>> On Wed, 31 Jan 2024, Xu Yilun wrote:
>>
>>> On Tue, Jan 30, 2024 at 09:13:56AM -0800, matthew.gerlach@linux.intel.com wrote:
>>>>
>>>>
>>>> On Tue, 30 Jan 2024, Xu Yilun wrote:
>>>>
>>>>> On Wed, Jan 24, 2024 at 11:40:05AM -0800, matthew.gerlach@linux.intel.com wrote:
>>>>>>
>>>>>>
>>>>>> On Tue, 23 Jan 2024, Xu Yilun wrote:
>>>>>>
>>>>>>> On Mon, Jan 22, 2024 at 09:24:33AM -0800, Matthew Gerlach wrote:
>>>>>>>> Revision 2 of the Device Feature List (DFL) Port feature has
>>>>>>>> slightly different requirements than revision 1. Revision 2
>>>>>>>> does not need the port to reset at driver startup. In fact,
>>>>>>>
>>>>>>> Please help illustrate what's the difference between Revision 1 & 2, and
>>>>>>> why revision 2 needs not.
>>>>>>
>>>>>> I will update the commit message to clarify the differences between revision
>>>>>> 1 and 2.
>>>>>>
>>>>>>>
>>>>>>>> performing a port reset during driver initialization can cause
>>>>>>>> driver race conditions when the port is connected to a different
>>>>>>>
>>>>>>> Please reorganize this part, in this description there seems be a
>>>>>>> software racing bug and the patch is a workaround. But the fact is port
>>>>>>> reset shouldn't been done for a new HW.
>>>>>>
>>>>>> Reorganizing the commit message a bit will help to clarify why port reset
>>>>>> should not be performed during driver initialization with revision 2 of the
>>>>>> hardware.
>>>>>>
>>>>>>>
>>>>>>> BTW: Is there a way to tell whether the port is connected to a different
>>>>>>> PF? Any guarantee that revision 3, 4 ... would need a port reset or not?
>>>>>>
>>>>>> The use of revision 2 of the port_hdr IP block indicates that the port can
>>>>>> be connected multiple PFs, but there is nothing explicitly stating which PFs
>>>>>
>>>>> Sorry, I mean any specific indicator other than enumerate the revision
>>>>> number? As you said below, checking revision number may not make further
>>>>> things right, then you need to amend code each time.
>>>>
>>>> Using a revision number to indicate the level of functionality for a
>>>> particular IP block seems to be a widely used approach. What other indicator
>>>
>>> If you still want to make the existing driver work, some capability indication
>>> would have more compatibility. That's more reasonable approach. Or you
>>> need to change existing behavior for each new revision, that's not
>>> actually widely used.
>>
>> I understand some capability indication would be better for compatibility
>> implementation. A revision number change is not as explicit or precise as
>> capability lists.
>>
>>>
>>>> of functionality level did you have in mind?
>>>
>>> I'm not trying to make the design. You tell me.
>>
>> One could use parameter blocks introduced in version 1 of the Device Feature
>> Header (DFH), or capability registers could be added the IP block.
>> In this particular case it seems the least impact to upstreamed software is
>> to keep the DFH and the register map unchanged, except for an incremented
>> revision number field.
>>
>>>
>>> If finally no indicator could be used, we have to use revision number. That's
>>> OK but make SW work harder, so I'm asking if anything could be done to
>>> avoid that.
>>
>> In this case, I don't think anything else can be done without bigger impacts
>> to the SW.
>
> Changing the existing SW is not a problem, repeat the same change every time
> is a problem. So if we make sure port reset is no longer needed after
> version 1, then this patch is OK. Otherwise, please re-evaluate.

The initial port reset will no longer be after version 1. The requirement 
for the initial state of the logic in side the port to be valid will remain.

Thanks,
Matthew

>
> Thanks,
> Yilun
>
>>
>>>
>>>>
>>>> The revision number of an IP block would change when new functionality is
>>>> added to an IP block or the behavior of the IP block changes. It would be
>>>> expected that SW might need to change in order to use the new functionality
>>>> or to handle the change in behavior of the IP block. Ideally the new
>>>> revision of an IP block would be compatible with existing SW, but that
>>>> cannot be guaranteed.
>>>
>>> People make the IP block, and be compatible should be the concern if it
>>> want upstream support.
>>
>> Agreed, and making sure some capability mechanism exists when an IP is
>> created would be a great start.
>>
>> Thanks,
>> Matthew
>>
>>>
>>> Thanks,
>>> Yilun
>>>
>>>>
>>>> Thanks,
>>>> Matthew
>>>>
>>>>>
>>>>> Thanks,
>>>>> Yilun
>>>>>
>>>>>> the port is connected to.
>>>>>>
>>>>>> It is hard to predict the requirements and implementation of a future
>>>>>> revision of an IP block. If a requirement of a future revision is to work
>>>>>> with existing software, then the future revision would not require a port
>>>>>> reset at driver initialization.
>>>>>>
>>>>>
>>>
>>>
>

