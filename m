Return-Path: <linux-kernel+bounces-47429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BA9844DCD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672881C21F29
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D28A38;
	Thu,  1 Feb 2024 00:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgWG9fUv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB61A47;
	Thu,  1 Feb 2024 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706747191; cv=none; b=kpxeSZacnR+R8i2Sv/CIG1wM7soz+8tDe6wDth69X7cws8l3jk+uCxpYKv1IH3aF2soQNSTgzQJguAw7L7Yuj2ZfiYlQP9a3K/tbyL3aIV4HWSVxQkGV2Ap5HrV6xl1PVu5e1rrH8C1av8abqtNy1TqMRYeDUB1l0fbOZkNp9+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706747191; c=relaxed/simple;
	bh=qdnqAPbbknE1XK+gc+6AwQ/uKL55CyVGkPj7KCOXSd8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AV1wkw/5g2eMvh0J2jJWG6WbmPjtcROpAHX4D/fx6IonV+wDQOll0FA8GeV8pqIPzx2V4J78aKBBd+b69YkJkr53fo1O8FnmH7wOzk4HGptfgm5w+V8DOQ6Jgh2IBI5ocygpvRzuHPMlBNC3UK5J1eigigglUnBhnEraIvMOrhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgWG9fUv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706747188; x=1738283188;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qdnqAPbbknE1XK+gc+6AwQ/uKL55CyVGkPj7KCOXSd8=;
  b=kgWG9fUvl/T9D20xaTYcr8zlr4h5PzhDhAf2U6zV1ncgodIyvHsBdDjv
   gJCDqyX6Dfs62stLSSFzKLy8drn2uAuAXmOlvjZcqKCMDdgNqV+cviV4z
   LOvrO6MyIxmrnS4qELVeSQY8Zf2cys4CWWyvoA95bSMAt0ouryo9EmuPm
   ww0hse0gAAuHFmoscdMc20AJDLMbxAgvcUQwCNBnq2vMvpuiBnHM00Uf4
   SB/csZwY6i893Be87e+HCZ+1XDGMtm2y8dlfKZFT73tZL8Pqh2aQ1eg24
   xsc3SHttDpl5OFMkWQuc4vKnCSvK7qjRCtxsNrSZrRPf/KFzDgd2FPvZu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10403458"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="10403458"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 16:26:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4252558"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 16:26:27 -0800
Date: Wed, 31 Jan 2024 16:26:27 -0800 (PST)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Xu Yilun <yilun.xu@linux.intel.com>
cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com, 
    linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: dfl: afu: support Rev 2 of DFL Port feature
In-Reply-To: <Zbnd8W1ciTKeoKc4@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2401311610020.112016@sj-4150-psse-sw-opae-dev2>
References: <20240125233715.861883-1-matthew.gerlach@linux.intel.com> <ZbjHl8ptQG5FdHvC@yilunxu-OptiPlex-7050> <alpine.DEB.2.22.394.2401300948590.112016@sj-4150-psse-sw-opae-dev2> <Zbnd8W1ciTKeoKc4@yilunxu-OptiPlex-7050>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Wed, 31 Jan 2024, Xu Yilun wrote:

> On Tue, Jan 30, 2024 at 10:00:16AM -0800, matthew.gerlach@linux.intel.com wrote:
>>
>>
>> On Tue, 30 Jan 2024, Xu Yilun wrote:
>>
>>> On Thu, Jan 25, 2024 at 03:37:15PM -0800, Matthew Gerlach wrote:
>>>> Revision 2 of the Device Feature List (DFL) Port feature
>>>> adds support for connecting the contents of the port to
>>>> multiple PCIe Physical Functions (PF).
>>>>
>>>> This new functionality requires changing the port reset
>>>> behavior during FPGA and software initialization from
>>>> revision 1 of the port feature. With revision 1, the initial
>>>> state of the logic inside the port was not guaranteed to
>>>> be valid until a port reset was performed by software during
>>>> driver initialization. With revision 2, the initial state
>>>> of the logic inside the port is guaranteed to be valid,
>>>> and a port reset is not required during driver initialization.
>>>>
>>>> This change in port reset behavior avoids a potential race
>>>> condition during PCI enumeration when a port is connected to
>>>> multiple PFs. Problems can occur if the driver attached to
>>>> the PF managing the port asserts reset in its probe function
>>>> when a driver attached to another PF accesses the port in its
>>>> own probe function. The potential problems include failed or hung
>>>
>>> Only racing during probe functions? I assume any time port_reset()
>>> would fail TLPs for the other PF. And port_reset() could be triggered
>>> at runtime by ioctl().
>>
>> Yes, a port_reset() triggered by ioctl could result in failed TLP for the
>> other PFs. The user space SW performing the ioctl needs to ensure all PFs
>> involved are properly quiesced before the port_reset is performed.
>
> How would user get an insight into other PF drivers to know everything
> is quiesced?  I mean do we need driver level management for this?

Since this is an FPGA, the number of other PFs and the drivers bound to 
those PFs depends on the FPGA image. There would also be user space 
software stacks involved with the other PFs as well. The user would have 
to ensure all the SW stacks and drivers are quiesced as appropriate for the 
FPGA image. I don't think the driver performing the port_reset() can know 
all the components to be able to provide any meaningful management.

Thanks,
Matthew

>
> Thanks,
> Yilun
>
>>
>> Do you want me to update the commit message with this information?
>>
>> Thanks,
>> Matthew
>
>

