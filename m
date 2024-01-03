Return-Path: <linux-kernel+bounces-15459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7187A822C47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E75A1F240C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1179218EA5;
	Wed,  3 Jan 2024 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G2gwt3l3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66118E31
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <52ea5dbf-2d60-7a23-e525-9dcae2809554@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704281893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fWtlIAOzUvDm9M4JJeNbJAd3af9ZIm0GtuZrj7wr4/0=;
	b=G2gwt3l3L4osQhnnysqyLT3YLCLl6GHz5vJT7X83GvaVHeq2VWmghkeOJ7a24SRwe3Aw6s
	mIp10JeJYu9LiuVYg/FnNlRSakB0DuEqJEhmEvLFOWg71oNJyaHvYu8IjNa37RcVF6XYZh
	eQoxUsN8eQhmmMVZn8weTS/il/O1UrQ=
Date: Wed, 3 Jan 2024 19:38:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: phy: Cleanup struct mdio_driver_common
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, olteanv@gmail.com, hkallweit1@gmail.com,
 kabel@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org
References: <20231228072350.1294425-1-yajun.deng@linux.dev>
 <ZZRJLg6U0G5CNRQ0@shell.armlinux.org.uk>
 <a5aca886-ca0a-8170-417f-a189ec28c87f@linux.dev>
 <ZZU8I5wwH+y1VsIy@shell.armlinux.org.uk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <ZZU8I5wwH+y1VsIy@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2024/1/3 18:51, Russell King (Oracle) wrote:
> On Wed, Jan 03, 2024 at 10:03:14AM +0800, Yajun Deng wrote:
>> On 2024/1/3 01:34, Russell King (Oracle) wrote:
>>> I'm not sure why this consistency is even desired, the commit message
>>> doesn't properly say _why_ this change is being proposed.
>> Most drivers use device_driver directly. This should be added to the commit.
>>
>> Like this:
>>
>> struct sdio_driver {
>>
>> ... ...
>>
>>          struct device_driver drv;
>> };
>>
>>
>> struct pcie_port_service_driver {
>>
>> ... ...
>>
>>          struct device_driver driver;
>> };
>>
>> and so on ...
> ... which is fine for those other drivers because they don't share the
> same bus. That is not the case here - we have two different classes
> of drivers on the same bus.


Yes, that's true. But we can implement it with is_phy_driver(). I don't 
think we need a flag for that.

>
> I don't like a justification that just because other subsystems do
> something in one particular way, that is the only way things should be
> done. I think there is good reason to have the structure we have, and
> thus there needs to be a good reason to change it.

Its purpose is to clean up struct mdio_driver_common, and make the code 
cleaner.


> Maybe Andrew has a different opinion, but I think we need a better
> justification for this change.
>

