Return-Path: <linux-kernel+bounces-15057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC9C8226BC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06A01C21C82
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F92539E;
	Wed,  3 Jan 2024 02:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AvNSM4tn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A184A16
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 02:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a5aca886-ca0a-8170-417f-a189ec28c87f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704247402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOagWnUDEoE7GjMOwjXwuSws8DvWaGldfOWW9LSOez0=;
	b=AvNSM4tnQjbmv09Q1fefRqvvAEFSK5ZhpSZAjwRz+IznlQ9HIvGN6vebT2KRCNVc2kXoDb
	8V2X5cSMaxQ74W/QoFqrQry++k5XYKI2eaYqE6gbJc0X8is3X/WQs5o+1OJiFbOZLwiKc9
	+y3C32PXtTMm0avn2LH0rjW3cwsFm58=
Date: Wed, 3 Jan 2024 10:03:14 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <ZZRJLg6U0G5CNRQ0@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2024/1/3 01:34, Russell King (Oracle) wrote:
> On Thu, Dec 28, 2023 at 03:23:50PM +0800, Yajun Deng wrote:
>> The struct mdio_driver_common is a wrapper for driver-model structure,
>> it contains device_driver and flags. There are only struct phy_driver
>> and mdio_driver that use it. The flags is used to distinguish between
>> struct phy_driver and mdio_driver.
>>
>> We can test that if probe of device_driver is equal to phy_probe. This
>> way, the struct mdio_driver_common is no longer needed, and struct
>> phy_driver and usb_mdio_driver will be consistent with other driver
>> structs.
> usb_mdio_driver?

This is a mistake. It should be 'mdio_driver'.

>
> I'm not sure why this consistency is even desired, the commit message
> doesn't properly say _why_ this change is being proposed.

Most drivers use device_driver directly. This should be added to the commit.

Like this:

struct sdio_driver {

... ...

         struct device_driver drv;
};


struct pcie_port_service_driver {

... ...

         struct device_driver driver;
};

and so on ...


>
>> +bool is_phy_driver(struct device_driver *driver)
>> +{
>> +	return driver->probe == phy_probe;
>> +}
>> +EXPORT_SYMBOL_GPL(is_phy_driver);
> Do we really need this exported? It doesn't seem like something anything
> other than core MDIO/phylib code should know about, and all that becomes
> a single module when building it in a modular way - phylib can't be a
> separate module from mdio stuff.
I think this exported can be removed.

