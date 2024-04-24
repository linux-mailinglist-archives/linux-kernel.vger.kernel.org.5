Return-Path: <linux-kernel+bounces-157523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE27C8B1254
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC021C23953
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2889A16F27C;
	Wed, 24 Apr 2024 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LXGY0R4O"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088F116E868
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982811; cv=none; b=Yhxx5P+NbW/s4aCU9zl8j9M4m6ZRomZDE0FK4RMgqRyORzKVr3h2S+Qmf45KGeyuTKPZbWrIR2AwllqIHQ5EhguMyng/IjxMQ/YPeQTDrW17JIT7AhJBixKzcrYI6CBJZ5Wrk8wNFvCf4k479Z3qBnA8rokUf5Pg7zeGirdfbtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982811; c=relaxed/simple;
	bh=bBAIBJsQ5GJsThi5boUOdskG5XZSazMGzcC7D+GxWPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2vsiSaOd/sOT1GEqtZhQ7V3txxK7fN72grAQ53G1EMuYlPxsIhNMtucjCWd57L3eoreQhNQPQ4c6/xA2Oijsk1AbrlRPyzDWVkfetwip73Bc0jE2nPhtZDSaWwzsq6GCi6lOUSlercb/8SkY+/dQOuOsoFNBxYBJTDCFDmlatk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LXGY0R4O; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <66b0f579-1406-4f9f-97b5-7d21171610b8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713982806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66hZfsJzzaPzAu4YPowed7j50esceCBieSOQ5CkBk6Q=;
	b=LXGY0R4OQw1TJoHsEsVMLetaStGhGUWYVv5m/va0F+pVOenUX8l/CcNm4Bce5yQN+DOCug
	3FqeoS4iEkPELgv18RihZYGg1BZPIRb3dR9JxR2JAnNsKon8Bsag2m2nMifPnD2To0kKCh
	rYDAOpcsmS/aq0QX263XJgetenboGhc=
Date: Thu, 25 Apr 2024 02:19:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] software node: Implement device_get_match_data fwnode
 callback
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240422164658.217037-1-sui.jingfeng@linux.dev>
 <Zie3ebHOEpWHj1qV@smile.fi.intel.com>
 <d5bc1e73-a553-451e-ab74-f5f0ca259c6b@linux.dev>
 <hcltp2bbxxg2t7ibmzgiib7mgbwgmvzwnnq6mochdh7c4h76r3@bxj6yk5zq64e>
 <ZikE4qOVO7rgIs9a@smile.fi.intel.com>
 <CAA8EJpr1FSjizAh6Dp5Bmux3NrGYh=BfHFL4D1fa87Og4ymY0w@mail.gmail.com>
 <Zikck2FJb4-PgXX0@smile.fi.intel.com>
 <kucey3jsydjye3ndflns3cqolcpizhnxgzz3fkmcatlnpbnwrk@22ulsqfh2vf6>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <kucey3jsydjye3ndflns3cqolcpizhnxgzz3fkmcatlnpbnwrk@22ulsqfh2vf6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/4/25 00:34, Dmitry Baryshkov wrote:
> On Wed, Apr 24, 2024 at 05:52:03PM +0300, Andy Shevchenko wrote:
>> On Wed, Apr 24, 2024 at 04:34:39PM +0300, Dmitry Baryshkov wrote:
>>> On Wed, 24 Apr 2024 at 16:11, Andy Shevchenko
>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>> On Wed, Apr 24, 2024 at 12:37:16AM +0300, Dmitry Baryshkov wrote:
>>>>> On Wed, Apr 24, 2024 at 12:49:18AM +0800, Sui Jingfeng wrote:
>>>>>> On 2024/4/23 21:28, Andy Shevchenko wrote:
>>>>>>> On Tue, Apr 23, 2024 at 12:46:58AM +0800, Sui Jingfeng wrote:
>> ...
>>
>>>>> But let me throw an argument why this patch (or something similar) looks
>>>>> to be necessary.
>>>>>
>>>>> Both on DT and non-DT systems the kernel allows using the non-OF based
>>>>> matching. For the platform devices there is platform_device_id-based
>>>>> matching.
>>>>>
>>>>> Currently handling the data coming from such device_ids requires using
>>>>> special bits of code, e.g. platform_get_device_id(pdev)->driver_data to
>>>>> get the data from the platform_device_id. Having such codepaths goes
>>>>> against the goal of unifying DT and non-DT paths via generic property /
>>>>> fwnode code.
>>>>>
>>>>> As such, I support Sui's idea of being able to use device_get_match_data
>>>>> for non-DT, non-ACPI platform devices.
>>>> I'm not sure I buy this. We have a special helpers based on the bus type to
>>>> combine device_get_match_data() with the respective ID table crawling, see
>>>> the SPI and I²C cases as the examples.
>>> I was thinking that we might be able to deprecate these helpers and
>>> always use device_get_match_data().
>> True, but that is orthogonal to swnode match_data support, right?
>> There even was (still is?) a patch series to do something like a new
>> member to struct device_driver (? don't remember) to achieve that.
> Maybe the scenario was not properly described in the commit message,

No thecommit message is very clear, just you don't clear. Can't you see that 
only you are out of scope here and complaining with wrong hypothesis?

> or
> maybe I missed something.


No, you miss and mess everything.

> The usecase that I understood from the commit
> message was to use instatiated i2c / spi devices, which means
> i2c_device_id / spi_device_id.

It can also be platform device with manually assigned software node.

> The commit message should describe why
> the usecase requires using 'compatible' property and swnode. Ideally it
> should describe how these devices are instantiated at the first place.
>
Yes, I admit it, its not the first time you do such a thing.  I know you might
good at debating and directing blindly. But those skills are not really helpful.
As it brings ZERO benefits to the developers and end user of Linux kernel. What
the end user need is a good DRM driver and infrastructure like i915, amdgpu,
radeon, vc4, ast, X server or wayland etc.

Its fine to keep quite if you don't understand something very well, especially,
the for the things that not directly maintained by you. As you don't have to
responsible for it and you don't need to pay for the obligation. You might
deceive yourself to believe that you are reviewing, actually, you are just
wasting your time as well as other people's time.
  
If the the commit message is really matters to you, then do you thing about
the following series [1][2][3] ?

[1] https://patchwork.freedesktop.org/series/123812/
[2] https://patchwork.freedesktop.org/patch/579730/?series=130021&rev=2
[3] https://patchwork.freedesktop.org/series/123737/

How about the witting of its commit message, very well, right?
Think before you type, and type with the brain not with the emotion.

-- 
Best regards,
Sui


