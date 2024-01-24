Return-Path: <linux-kernel+bounces-37602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7746583B265
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255A728573A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C533E132C2F;
	Wed, 24 Jan 2024 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvAZaKGM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A10131E4E;
	Wed, 24 Jan 2024 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125243; cv=none; b=L40xsGpwFeb8c51l1DUUJwT3fe6gXqvl9o4SI6jWeUuHw3dXI3dJPSu/OHjiJ2+i3nGiqVNvT2srtWYL6PwrtTmSTl40UtsYivpCQWIj3LCS4gTdeTh15s7BVlsRSegS9VyIOAR9zBy/EK2LlJtsJ5eSxJQ9bNCsq13pJ2wfADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125243; c=relaxed/simple;
	bh=P0vOpbNw4GVLzVgwN2w4XERVFkiUNoGEFDynIiNskNI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NJVBbTan3PptYd+5UlvMX1sD4HAHlguRgdGxgZExc8Fvi0yJBrDWU4k8WekA1qK8wB6z8fCau8lCoO3KQxygo+T7ZAC4nlaguB7sVNSUrTcRQstfFQlkU5Nl2oOul6QIiZefsOsPMOpYgejAMC146kluyYzIrQGFchneOH1TSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MvAZaKGM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706125241; x=1737661241;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=P0vOpbNw4GVLzVgwN2w4XERVFkiUNoGEFDynIiNskNI=;
  b=MvAZaKGMBVefjmcEy5NCkYSLZwMoPw7Tb64/sJNXyZ51quzSsNsKJlCI
   XkGUq3ZHOMrVxa9x0MJdTT+kWhexNef609b91TCnuizOBi7OHPYwX3oBY
   7APPWGc/02qLHIXYE4qMBUND/fjTiU5A5G1eFnQkdh+1gBjvEC5Av3uPV
   fa67pjzuirAwXtKE1uOlieyQ/fOACbsv80uWZ0hlaCPIk7/Y6rwo3L/7X
   WKMz7/wQ4V0oE546je7BpqYrBwDFuyKFO1X/ILo+ytw+wwyxddA9bgzVl
   8KgC3JNjjwZ8SLTKnAm965P77clF8Bop+kamIM4RQQPVeQ+/RJncDT3OR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8719146"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8719146"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 11:40:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="736047002"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="736047002"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 11:40:39 -0800
Date: Wed, 24 Jan 2024 11:40:05 -0800 (PST)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Xu Yilun <yilun.xu@linux.intel.com>
cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com, 
    linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: afu: update initialization of port_hdr
 driver
In-Reply-To: <Za8ibeJc82Xkbpct@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2401241106550.77559@sj-4150-psse-sw-opae-dev2>
References: <20240122172433.537525-1-matthew.gerlach@linux.intel.com> <Za8ibeJc82Xkbpct@yilunxu-OptiPlex-7050>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Tue, 23 Jan 2024, Xu Yilun wrote:

> On Mon, Jan 22, 2024 at 09:24:33AM -0800, Matthew Gerlach wrote:
>> Revision 2 of the Device Feature List (DFL) Port feature has
>> slightly different requirements than revision 1. Revision 2
>> does not need the port to reset at driver startup. In fact,
>
> Please help illustrate what's the difference between Revision 1 & 2, and
> why revision 2 needs not.

I will update the commit message to clarify the differences between 
revision 1 and 2.

>
>> performing a port reset during driver initialization can cause
>> driver race conditions when the port is connected to a different
>
> Please reorganize this part, in this description there seems be a
> software racing bug and the patch is a workaround. But the fact is port
> reset shouldn't been done for a new HW.

Reorganizing the commit message a bit will help to clarify why port reset 
should not be performed during driver initialization with revision 2 of 
the hardware.

>
> BTW: Is there a way to tell whether the port is connected to a different
> PF? Any guarantee that revision 3, 4 ... would need a port reset or not?

The use of revision 2 of the port_hdr IP block indicates that the port can 
be connected multiple PFs, but there is nothing explicitly stating which 
PFs the port is connected to.

It is hard to predict the requirements and implementation of a future 
revision of an IP block. If a requirement of a future revision is to work 
with existing software, then the future revision would not require a port 
reset at driver initialization.

>
> Thanks,
> Yilun
>
>> PCIe Physical Function (PF) than the management PF performing
>> the actual port reset.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>>  drivers/fpga/dfl-afu-main.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
>> index c0a75ca360d6..7d7f80cd264f 100644
>> --- a/drivers/fpga/dfl-afu-main.c
>> +++ b/drivers/fpga/dfl-afu-main.c
>> @@ -417,7 +417,18 @@ static const struct attribute_group port_hdr_group = {
>>  static int port_hdr_init(struct platform_device *pdev,
>>  			 struct dfl_feature *feature)
>>  {
>> -	port_reset(pdev);
>> +	void __iomem *base;
>> +	u8 rev;
>> +
>> +	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
>> +
>> +	rev = dfl_feature_revision(base);
>> +
>> +	if (rev < 2)
>> +		port_reset(pdev);
>> +
>> +	if (rev > 2)
>> +		dev_info(&pdev->dev, "unexpected port feature revision, %u\n", rev);
>
> Remove the print. It is indicating an error but the function returns OK.

The message is intended to be informational, but I'll remove it because it 
could be confusing.

>
> Thanks,
> Yilun

Thanks for the feedback.

>
>>
>>  	return 0;
>>  }
>> --
>> 2.34.1
>>
>>
>

