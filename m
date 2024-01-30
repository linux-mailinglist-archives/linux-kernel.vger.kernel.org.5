Return-Path: <linux-kernel+bounces-45073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 556F8842B62
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F291C214E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9513D1552F6;
	Tue, 30 Jan 2024 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFL+5f2P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E53157E80;
	Tue, 30 Jan 2024 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637619; cv=none; b=Q/daLKlE/mv84gkEHu1obiWuJZ4ixeKe/Er7Rcdzl2mH2+TvDykH/9lFnAkFcx1J6QKIxm3fk+UfKElorip0yge+ZiVd6RcjX5npO3fJUAojAQubmP2ZM9MOVkxRVfyA9aPpKLdhnZSFL/jbz5fU8s3IlvuaPy1TFo6tBKtdeS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637619; c=relaxed/simple;
	bh=lQZ/GbyZBd0xDNQpWfIqUsdS0F8dX+qiur/y3oKYous=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=twgchil86/Lev478EWf+ZnLRwi19RX/zTIXoPYPkW1llGOtL4N1Jj+ZVLTv7gWyrO2oCByjDACWNx3zLf4fUFZhbZGzGEt3grNDbSWLDgw0GniqJdRH1021qYmHFlGrvGWsrdJryPOBvgD21netfZSFLEwqCeBNycLLqUyZl3sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFL+5f2P; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706637618; x=1738173618;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lQZ/GbyZBd0xDNQpWfIqUsdS0F8dX+qiur/y3oKYous=;
  b=lFL+5f2PoJnLQp6fnt81EA8oxR++pSZ/DeQZfMVo7mjuoGvdSwo/shhU
   j/yd86HqflGnivNnprye9myI9fuIkbQ3MlAVwFCPe+eR7fb3orElmsF5h
   ZfUQpKRIbc+BUEevRmq6mXSGLkXbssDFEaUI/4enMt2aLRbgoK08Hu9ty
   Euiu0jh/kIjS/dsPckyYcI53K90QywDd8LL8eIS+QKnhRMcNlFN14aCXh
   q6uJN1EvLt7cQBHyPblk4Cs/jlHK4HD7EOkitim5tCrKB6Za/ptJTPEbI
   hDV1gCOLCInHQcm0Qh1iDSLxQpofjgpCzMEiB8muzwesBbI2JANO/G9lM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10104265"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="10104265"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 10:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="3875247"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 10:00:16 -0800
Date: Tue, 30 Jan 2024 10:00:16 -0800 (PST)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Xu Yilun <yilun.xu@linux.intel.com>
cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com, 
    linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: dfl: afu: support Rev 2 of DFL Port feature
In-Reply-To: <ZbjHl8ptQG5FdHvC@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2401300948590.112016@sj-4150-psse-sw-opae-dev2>
References: <20240125233715.861883-1-matthew.gerlach@linux.intel.com> <ZbjHl8ptQG5FdHvC@yilunxu-OptiPlex-7050>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Tue, 30 Jan 2024, Xu Yilun wrote:

> On Thu, Jan 25, 2024 at 03:37:15PM -0800, Matthew Gerlach wrote:
>> Revision 2 of the Device Feature List (DFL) Port feature
>> adds support for connecting the contents of the port to
>> multiple PCIe Physical Functions (PF).
>>
>> This new functionality requires changing the port reset
>> behavior during FPGA and software initialization from
>> revision 1 of the port feature. With revision 1, the initial
>> state of the logic inside the port was not guaranteed to
>> be valid until a port reset was performed by software during
>> driver initialization. With revision 2, the initial state
>> of the logic inside the port is guaranteed to be valid,
>> and a port reset is not required during driver initialization.
>>
>> This change in port reset behavior avoids a potential race
>> condition during PCI enumeration when a port is connected to
>> multiple PFs. Problems can occur if the driver attached to
>> the PF managing the port asserts reset in its probe function
>> when a driver attached to another PF accesses the port in its
>> own probe function. The potential problems include failed or hung
>
> Only racing during probe functions? I assume any time port_reset()
> would fail TLPs for the other PF. And port_reset() could be triggered
> at runtime by ioctl().

Yes, a port_reset() triggered by ioctl could result in failed TLP for the 
other PFs. The user space SW performing the ioctl needs to ensure all PFs 
involved are properly quiesced before the port_reset is performed.

Do you want me to update the commit message with this information?

Thanks,
Matthew

>
> Thanks,
> Yilun
>
>> transaction layer packet (TLP) transactions and invalid data
>> being returned.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> ---
>> v2:
>> - Update commit message for clarity
>> - Remove potentially confusing dev_info message.
>> ---
>>  drivers/fpga/dfl-afu-main.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
>> index c0a75ca360d6..42fe27660ab7 100644
>> --- a/drivers/fpga/dfl-afu-main.c
>> +++ b/drivers/fpga/dfl-afu-main.c
>> @@ -417,7 +417,15 @@ static const struct attribute_group port_hdr_group = {
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
>>
>>  	return 0;
>>  }
>> --
>> 2.34.1
>>
>>
>

