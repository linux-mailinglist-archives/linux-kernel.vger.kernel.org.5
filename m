Return-Path: <linux-kernel+bounces-48370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC7B845B12
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A312A1F218B2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8A06215B;
	Thu,  1 Feb 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThgMJo1o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8654862141
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800565; cv=none; b=JCGudWh90hkikaPlS/RQadDu4D+3Yjc6IiAoxUEAJ/uGcrWhwkvn3TNNYShgxaJf5ILWXyTtdQT2mUZaZOHQJY8i9sj0UVH4B8yEhYvPFEXy3KfBeDaegSGlDByCH2gkMMduJy+PhnHRIT42nqVrETlql5b/B+ASrWCRtH9hwao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800565; c=relaxed/simple;
	bh=2c2O8Cc9VKYP/y1ar4r+bdMh2y3qB+F8BIbxfjXxo4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXJaoq7ud4pTkUfFx52gaFMbmDXvIYrg6/oWmV1is0NEhNhLDaKNZlk9KG6iOinuVh2PgXUGJdlEKH07bKySIURmhpUL4lqTtULiGNf6yuWgIfzHAlL4+nmv6fo/dS45Y7AxSgp8Ubs8WG/4wKsTQq9lKzpqkoLtGR/AWWGO5Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ThgMJo1o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706800561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+qWz/DQvoXRtLaiUs+ygF3UhqzsPEEWrkmZUq5EmAU=;
	b=ThgMJo1owUli8s60jdOhEcifYMwG2/BuBx40H7oCtXukQ6/Kfd4YpBL2+ON79Ae/Aa1Rbt
	CPDW06P/wjxw1IhlluAQe5Kes3dWUMfEfpAvraGO6vRjVRW0cAo5sXYnQLxzJvXTyH0U35
	imiKvSFs59oVjm0HtId0tboeMjgNJU0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-SHjAwtzkO56Kf-9vhZXCOQ-1; Thu, 01 Feb 2024 10:14:22 -0500
X-MC-Unique: SHjAwtzkO56Kf-9vhZXCOQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33aebf85ce9so414019f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 07:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800458; x=1707405258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+qWz/DQvoXRtLaiUs+ygF3UhqzsPEEWrkmZUq5EmAU=;
        b=V8xRwbPVkJMoTbQVrZUmQDUnam0K/2AAdYuObEzotov3NWirPaXSmCt92K+JWY1b/r
         Qzl8mqiI/Vf+bGet97FpmDhPG4WeJWu71PwmjO/CkBBbEGH+Hylyx18sMNXNt1LSuMcr
         EVmfxFt6cUXXBassaC4k1guiY/vPm7uoi4V8IJ2liU5O24fX2VsBNt048adVf+63EmrL
         3/L0UShEX7QEavc9Iid7TBnJC02N7mhFWRnDnOXpSLsJHqgNCRq1hKx8ba+G2Rbt8JBz
         7QaRHpWaWNEG0Nakrt0Nb7Y8LYtIeWc27b9g3W+DqvFJAS90Hd3BG71bBLpnxOigcdLs
         d4OA==
X-Gm-Message-State: AOJu0Yy90nodXdn22TgsKbt85VEFiOQLTUMdBPvKMx1DfIJNwlZewhnt
	cHZ/0RNs7upTuxLPxTSl11ODIAmaYNPZ3JDN5Hh7SrRbnmoFYe+f2RZ/pIbfUMsT9IihkiNhWO1
	zUbr1WRhCbfRj8kB7zi3lOWKR9yIx1UYEvNz4eP6uCoORU5LFYdptZefBz8D4
X-Received: by 2002:adf:fec3:0:b0:33b:1ae4:10be with SMTP id q3-20020adffec3000000b0033b1ae410bemr656919wrs.46.1706800457805;
        Thu, 01 Feb 2024 07:14:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQ1LSSiNVgFItzWKTj0LfVmS5upYQ2eKQBxvYDmMDMD7a3/zefheP6gAwFbMonNNjA8rzILA==
X-Received: by 2002:adf:fec3:0:b0:33b:1ae4:10be with SMTP id q3-20020adffec3000000b0033b1ae410bemr656907wrs.46.1706800457493;
        Thu, 01 Feb 2024 07:14:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXaEwqOkI/VK9eNkoA4uPPbdatQOwtq1EPu0xJA7z2SWYUIWqy+ov7zZDoNulKSTiXoUR02WK++vXcyW3dU0M6SaRBhGyrdona8fTbFXXg6h/5CDcoicVaNzGGOT3Dq+E7irt+xb03koPH/lr13Dv/mESKncyMmLbTR7lbsWUeailm79/RQZ1JJhhfsEzgbmw2fW6uaGkrMX5wjRHu5T9Q=
Received: from [192.168.9.34] (net-2-34-24-75.cust.vodafonedsl.it. [2.34.24.75])
        by smtp.gmail.com with ESMTPSA id t8-20020adfe108000000b0033921c383b2sm16400154wrz.67.2024.02.01.07.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 07:14:17 -0800 (PST)
Message-ID: <985729eb-08c5-4c0d-9172-1642a45caffd@redhat.com>
Date: Thu, 1 Feb 2024 16:14:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: remove redundant checks for bridge ops
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240124152408.88068-1-marpagan@redhat.com>
 <Zbi+yJC7KNvl9med@yilunxu-OptiPlex-7050>
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <Zbi+yJC7KNvl9med@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-01-30 10:18, Xu Yilun wrote:
> On Wed, Jan 24, 2024 at 04:24:07PM +0100, Marco Pagani wrote:
>> Commit 0d70af3c2530 ("fpga: bridge: Use standard dev_release for class
>> driver") introduced a check in fpga_bridge_register() that prevents
>> registering a bridge without ops, making checking on every call
>> redundant.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/fpga-bridge.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
>> index a024be2b84e2..e0a5ef318f5e 100644
>> --- a/drivers/fpga/fpga-bridge.c
>> +++ b/drivers/fpga/fpga-bridge.c
>> @@ -30,7 +30,7 @@ int fpga_bridge_enable(struct fpga_bridge *bridge)
>>  {
>>  	dev_dbg(&bridge->dev, "enable\n");
>>  
>> -	if (bridge->br_ops && bridge->br_ops->enable_set)
>> +	if (bridge->br_ops->enable_set)
>>  		return bridge->br_ops->enable_set(bridge, 1);
>>  
>>  	return 0;
>> @@ -48,7 +48,7 @@ int fpga_bridge_disable(struct fpga_bridge *bridge)
>>  {
>>  	dev_dbg(&bridge->dev, "disable\n");
>>  
>> -	if (bridge->br_ops && bridge->br_ops->enable_set)
>> +	if (bridge->br_ops->enable_set)
>>  		return bridge->br_ops->enable_set(bridge, 0);
>>  
>>  	return 0;
>> @@ -401,7 +401,7 @@ void fpga_bridge_unregister(struct fpga_bridge *bridge)
>>  	 * If the low level driver provides a method for putting bridge into
>>  	 * a desired state upon unregister, do it.
>>  	 */
>> -	if (bridge->br_ops && bridge->br_ops->fpga_bridge_remove)
>> +	if (bridge->br_ops->fpga_bridge_remove)
>>  		bridge->br_ops->fpga_bridge_remove(bridge);
> 
> Also for state_show()?

Right, I missed that one. I'll remove it in v2

Thanks,
Marco

 


