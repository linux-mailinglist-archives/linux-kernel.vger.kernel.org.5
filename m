Return-Path: <linux-kernel+bounces-111948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8436488731F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E9A1C22AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A15067A10;
	Fri, 22 Mar 2024 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p3kx2f52"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21A84174F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132221; cv=none; b=uS3egmqIbZg5kjUN1vLh10cgz03IhK4u/KfD5zEInnneaLZ8hyYDfs5mlAVsMr1ddpMdmJrN2hym+4O5gLr/J9iJdVlv4ZpP8zVedR+rkhxHn5/J9BwUcxLwJ0MVI8+/YjT1X5xOjfBgvehrbgYhgwjWkY6pEct90wjaCxj3YIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132221; c=relaxed/simple;
	bh=fbvUdHjQMr9QM8LbKobKsg5CEzA3UsAcRecYH4GoWFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojU0JZGe3GLTaPfB62YeQy1+vWA66AqJmN7SgXVpJggRwhBXMHU2fOt6quuemZflI5okmL2CuLCRPBbvKSLzA9jF4YLABBihPfM/9CrpiBS4VfALL7XUIdRmlPesaJkAHOm1mpVR9ga6EE4NJefiwNaQIxJaqjHrlZIYBKoxyFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p3kx2f52; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <839a7448-b958-402e-862a-fc3f7d86e797@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711132217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbmcNXR4M4wRC+ClOsomWLe4oemdmZUUssvEnkGlvp0=;
	b=p3kx2f52xDB3YwKuEFEml3CfCh9PqKqt8ttYlH7lbRq8hf+yWMWgo1bhVAK/ydG1IivSS1
	k+M/YOj2D9rGh0WABb6zWje1+UiyCuC+GCsresFqLllU5YcQcq9JLu1LeuBbYZL/O/mOiD
	nDArjQ46uG6nqO+xEfdhs0nfEqAtj04=
Date: Sat, 23 Mar 2024 02:30:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] software node: Implement device_get_match_data fwnode
 callback
Content-Language: en-US
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
 <9ced20e0-dfbd-4337-b5df-223b7baffd9e@linux.dev>
 <ZftG6Q5AaG71dhWq@smile.fi.intel.com>
 <9644da91-f367-4083-a3e4-4d0677c8cbca@linux.dev>
 <Zf2uUwcMgIpo6rVh@smile.fi.intel.com>
 <6bf102a4-6419-4083-8918-4f7c76cfa9a1@linux.dev>
 <Zf3IWyrW8IZLTg4x@smile.fi.intel.com>
 <8afe3f27-fc8e-4c20-ba28-74a0a2937e55@linux.dev>
 <Zf3LBvJEJF9xr2fv@smile.fi.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <Zf3LBvJEJF9xr2fv@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/3/23 02:16, Andy Shevchenko wrote:
> On Sat, Mar 23, 2024 at 02:12:14AM +0800, Sui Jingfeng wrote:
>> On 2024/3/23 02:05, Andy Shevchenko wrote:
>>>    Besides that, the kernel project rule is "we do not add
>>> the dead (unused) code".
>> This rule is good an correct and I admit.
>>
>> But the problem is that it is chicken-and-egg problem,
>> it probably have at least two user now.
> Then show them! Convert in the same series and show that.

I believe that Vladimir has show enough to you. I have read that thread,
I think Vladimit have explained very well.




-- 
Best regards,
Sui


