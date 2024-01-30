Return-Path: <linux-kernel+bounces-45025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAE6842A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD58B2863F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFDC1292DB;
	Tue, 30 Jan 2024 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfuL+G1a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79304128368;
	Tue, 30 Jan 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634853; cv=none; b=Ge1Alt2aFkRQ7g6xMHV5CsYwIRfrphYgcdrqFlmcLlaFqC7sOr1Udh0gYBOKrWcr6Yja6zMsXWqUBaOtQANrq6v7/PHChgCnfyLOWXI8clpAKGoeBWSTQjp9WwqAMuUX6hwY/jCIZ28vyeqnYrkKKKFkbOw8gRu7ElM+MA0QwJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634853; c=relaxed/simple;
	bh=ZtnvKA0MBtljWKQs48hUXZdK7+kAzm5mqJcPPFEK4hI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kLGWu+9uStWVTiV6bqDwCU7ZUytWMZNKq8KABAmtEdPLqNBD5/jRci0+BdsFUfFgbtnS28SP84HYjy5gzoGRVALBDPKVPG/k2oe4VPyX5cvQyilK2meBP9spLDXWVfshHiS1odRJiwh2yqQMlSYx1ZVgg8fbg8zQsJtP7k+lhxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfuL+G1a; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706634851; x=1738170851;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZtnvKA0MBtljWKQs48hUXZdK7+kAzm5mqJcPPFEK4hI=;
  b=SfuL+G1atooWhXXw2MCktYFSWFtObasFYOj2LrDGYpTr+9Z3m99m2QiW
   8ujkvYqUuDkCkI4o1t2WtPpwnIE50aWHoMJOu/8u1FRYQ3OkZPY7B5Pno
   YBOmB/Kq3ZzmZxwMWaAbE5uKhN8P+iOzVFS9Sh+WbU/4KT+ovcEpWCqnu
   TSH/J1/PPomE7mJNklC3qXtRLdDruqDDqOxnJqqQpma0j7yTB2o/MrXVN
   PufpQqyDkp+WcD5v5qhN+lNmxOj2nK2dsF5gagoLrnydYPGivip1zpNxg
   cQUw3+9EBm6V0fIalwLdI0s7nw7BziQ2BbXAhGDPN1X1DDHghxshDAPlO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="16872223"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="16872223"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:14:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788259970"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="788259970"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:14:09 -0800
Date: Tue, 30 Jan 2024 09:13:56 -0800 (PST)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Xu Yilun <yilun.xu@linux.intel.com>
cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com, 
    linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: afu: update initialization of port_hdr
 driver
In-Reply-To: <ZbjC501oRClByual@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2401300825020.112016@sj-4150-psse-sw-opae-dev2>
References: <20240122172433.537525-1-matthew.gerlach@linux.intel.com> <Za8ibeJc82Xkbpct@yilunxu-OptiPlex-7050> <alpine.DEB.2.22.394.2401241106550.77559@sj-4150-psse-sw-opae-dev2> <ZbjC501oRClByual@yilunxu-OptiPlex-7050>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Tue, 30 Jan 2024, Xu Yilun wrote:

> On Wed, Jan 24, 2024 at 11:40:05AM -0800, matthew.gerlach@linux.intel.com wrote:
>>
>>
>> On Tue, 23 Jan 2024, Xu Yilun wrote:
>>
>>> On Mon, Jan 22, 2024 at 09:24:33AM -0800, Matthew Gerlach wrote:
>>>> Revision 2 of the Device Feature List (DFL) Port feature has
>>>> slightly different requirements than revision 1. Revision 2
>>>> does not need the port to reset at driver startup. In fact,
>>>
>>> Please help illustrate what's the difference between Revision 1 & 2, and
>>> why revision 2 needs not.
>>
>> I will update the commit message to clarify the differences between revision
>> 1 and 2.
>>
>>>
>>>> performing a port reset during driver initialization can cause
>>>> driver race conditions when the port is connected to a different
>>>
>>> Please reorganize this part, in this description there seems be a
>>> software racing bug and the patch is a workaround. But the fact is port
>>> reset shouldn't been done for a new HW.
>>
>> Reorganizing the commit message a bit will help to clarify why port reset
>> should not be performed during driver initialization with revision 2 of the
>> hardware.
>>
>>>
>>> BTW: Is there a way to tell whether the port is connected to a different
>>> PF? Any guarantee that revision 3, 4 ... would need a port reset or not?
>>
>> The use of revision 2 of the port_hdr IP block indicates that the port can
>> be connected multiple PFs, but there is nothing explicitly stating which PFs
>
> Sorry, I mean any specific indicator other than enumerate the revision
> number? As you said below, checking revision number may not make further
> things right, then you need to amend code each time.

Using a revision number to indicate the level of functionality for a 
particular IP block seems to be a widely used approach. What other 
indicator of functionality level did you have in mind?

The revision number of an IP block would change when new functionality is 
added to an IP block or the behavior of the IP block changes. It would be 
expected that SW might need to change in order to use the new functionality 
or to handle the change in behavior of the IP block. Ideally the 
new revision of an IP block would be compatible with existing SW, but that 
cannot be guaranteed.

Thanks,
Matthew

>
> Thanks,
> Yilun
>
>> the port is connected to.
>>
>> It is hard to predict the requirements and implementation of a future
>> revision of an IP block. If a requirement of a future revision is to work
>> with existing software, then the future revision would not require a port
>> reset at driver initialization.
>>
>

