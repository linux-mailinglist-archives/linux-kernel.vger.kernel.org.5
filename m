Return-Path: <linux-kernel+bounces-109337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413B98817CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C551C2162B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E418563D;
	Wed, 20 Mar 2024 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nWJh5EdR"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418356AFAE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710962539; cv=none; b=XS/c8VHXaAY4VZx5zt+aJbDXKPdtv2LE2urY0+xWSIbWwleYFARePQK6BdGGNUmW+hIf7HIGiTicrW889qpQ6eXCQETVGRSk1hqSGYkW354qBLS+ORuSfvIfjDrJ0p/PLC0VmpaVaB16Ri41t3j3oym7JKqKZ/oZ4OgA9Wu6Was=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710962539; c=relaxed/simple;
	bh=bJsr6GmD+N1RSONGR4sqICG/kfmdwzIcSNAniUL48D8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QzAtvlS0tiVrCvX7xBJjuA1LVupZiJJM+nxLc9aZlGZ0aj8V2NtimbYhw8y+sbNkksX+IS7yItx3KFAhwGFxIRQYtMYRoN5XlcF8ZAmNt2ZlqOJxaZiAskxgwVqZnkA0hy0T6TfY+rVo3ZIqKlOs6PMZa2Z8XqW4m8844+umYbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nWJh5EdR; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9ced20e0-dfbd-4337-b5df-223b7baffd9e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710962535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4sLgrJY1ZHs50/OMosMO/w2/lI0zobbFbhfe2FQeSiw=;
	b=nWJh5EdR/NoeKbO6ajZVjvEdcrTpbnjzliR8Vg196YIG+UjS7Qjc4OZ7PidoKBChgAHQMo
	EeJhjVQv30LZq8FySDzflVzZEwmatx5h71eEX4JQkM+vFk5naj9XT9KJhrUJwWrphTiRPk
	KO7KxKja8+lBqyKn/Nx+A/HTKxw3OSY=
Date: Thu, 21 Mar 2024 03:22:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] software node: Implement device_get_match_data fwnode
 callback
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20240318234222.1278882-1-sui.jingfeng@linux.dev>
 <Zfq85f-Dp1S3CKuG@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <Zfq85f-Dp1S3CKuG@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/3/20 18:39, Andy Shevchenko wrote:
> +Cc: Vladimir
>
> On Tue, Mar 19, 2024 at 07:42:22AM +0800, Sui Jingfeng wrote:
>> This makes it possible to support (and/or test) a few drivers that
>> originates from DT World on the x86-64 platform. Originally, those
>> drivers using the of_device_get_match_data() function to get match
>> data. For example, drivers/gpu/drm/bridge/simple-bridge.c and
>> drivers/gpu/drm/bridge/display-connector.c. Those drivers works very
>> well in the DT world, however, there is no counterpart to
>> of_device_get_match_data() when porting them to the x86 platform,
>> because x86 CPUs lack DT support.
> This is not true.
>
> First of all, there is counter part that called device_get_match_data().

Are you means that the acpi_fwnode_device_get_match_data() implementation?
As the fwnode API framework has three backend: OF, ACPI, and software node.
If you are hinting me that the acpi backend has the .device_get_match_data
implemented. Then you are right.


> Second, there *is* DT support for the _selected_ x86 based platforms.

Yeah, you maybe right again here. I guess you means that some special
hardware or platform may have a *limited* support?

Can you pointed it out for study of learning purpose?

To speak precisely, there are some drm display bridges drivers are
lack of the DT support on X86. Those display bridges belong to the
device drivers catalogs.

OK, I will update my commit message at the next version if possible,
and try my best to describe the problem precisely.

>> By replacing it with device_get_match_data() and creating a software
>> graph that mimics the OF graph, everything else works fine, except that
>> there isn't an out-of-box replacement for the of_device_get_match_data()
>> function. Because the software node backend of the fwnode framework lacks
>> an implementation for the device_get_match_data callback.
> .device_get_match_data
>
>> Implement device_get_match_data fwnode callback fwnode callback to fill
> .device_get_match_data


OK, thanks a lot.

>> this gap. Device drivers or platform setup codes are expected to provide
>> a "compatible" string property. The value of this string property is used
>> to match against the compatible entries in the of_device_id table. Which
>> is consistent with the original usage style.
> Why do you need to implement the graph in the board file?

It can be inside the chip, there is no clear cut.  I means that
the graph(including fwnode graph, OF graph or swnode graph) can
be used at anywhere. The examples given here may lead you to
think it is board specific, but it is not limited to board specific.

fwnode graph, OF graph and swnode graph, all of them are implements
of the graph. Its common that different hardware vendors bought the
some IP and has been integrated it into their SoC. So it can be inside
of the chip if you want *code sharing*.


Back to the patch itself, we want to keep the three backends aligned as 
much as possible. Is this reasonable enough?

> ...
>
> Have you seen this discussion?
> https://lore.kernel.org/lkml/20230223203713.hcse3mkbq3m6sogb@skbuf/
>

I really didn't have seen that thread before this patch is sent,
I'm a graphic developer, I'm mainly focus on graphics domain.

Previously, I have implemented similar functionality at the drivers
layer [1][2]. But as the instances grows,  I realized there is a
risk to introducing *boilerplate*.  So I send this patch. [1][2] can
be drop if this patch could be merged.

[1] https://patchwork.freedesktop.org/patch/575414/?series=129040&rev=1

[2] https://patchwork.freedesktop.org/patch/575411/?series=129040&rev=1


After a brief skim,  I guess we encounter similar problems. Oops!
In a nutshell, there is a need to *emulation* on X86 platform,
to suit the need of device-driver coding style of DT world.

Besides, at the swnode backend layer, we should not call
fwnode_property_read_string(), instead, we should usethe property_entry_read_string_array() function. Because the 
fwnode_property_read_string() is belong to upper layer.
While backend implementations should call functions from
bottom layer only.


-- 
Best regards,
Sui


