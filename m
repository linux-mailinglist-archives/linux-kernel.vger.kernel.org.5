Return-Path: <linux-kernel+bounces-153790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D21FC8AD334
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B356B23A95
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D52153BDF;
	Mon, 22 Apr 2024 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ktNv6d5O"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBF72EB11
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713806145; cv=none; b=uL0+x8KuTKbB2A1ThY58CluDYsqJgNegX5/iWyP91YTJafKbTIC94J8bfM9YF8unmQraKWeZlbBTOxphZZy+22qFN0kUjshB6svO1F/r3/K3p0fTqnd90+WYPDKfNdh+KlXAl3NDVdgr927HX7aCpztVXPfIfPWsL0FDccUHEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713806145; c=relaxed/simple;
	bh=RvtvAb8VvmVlvxNaACOBvlflPCF10iUZ1zCt9p5N8P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9kp/kltmSL+qQ2R3k6zKV+BVUMHHMD7VYB4PGzx7IGDU7snrchklRzpYvGbR0lLkQAyg4k4ER8sfkXboWZNviF6AQBMEGvkWkZlSyF5zCAyPCxnuu3BQHpu0Vy4ThCtkumU+LGNvfoiIjJyLLcdt9EUnYsUIlIGcN9Lw/0596E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ktNv6d5O; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dfa3124d-f2e0-4a57-ae1b-618552711b8d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713806142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+HLUjf4Ec921cDOe34OXWrTEtib0L9ZdmgXujdfGBQ=;
	b=ktNv6d5OL7NoonVORzxhzZasbuDFvJvHYczqImWOGZYQPCcgBpOQCgEOoqkjXM6afPa2DS
	vEFiG1pTZqOhQE9/Aco6VqEHR0o3bC3ag16tCJBFgUw5pygFtmmzUAhWnufe4o3tG4l4KI
	bgI1JmZtJZhcV10KsnCZTTixhrwCD2g=
Date: Mon, 22 Apr 2024 13:15:38 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] nvme-pci: Add quirk for broken MSIs
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240422162822.3539156-1-sean.anderson@linux.dev>
 <ZiaVEfdUXO97eWzV@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <ZiaVEfdUXO97eWzV@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/22/24 12:49, Keith Busch wrote:
> On Mon, Apr 22, 2024 at 12:28:23PM -0400, Sean Anderson wrote:
>> Sandisk SN530 NVMe drives have broken MSIs. On systems without MSI-X
>> support, all commands time out resulting in the following message:
>> 
>> nvme nvme0: I/O tag 12 (100c) QID 0 timeout, completion polled
>> 
>> These timeouts cause the boot to take an excessively-long time (over 20
>> minutes) while the initial command queue is flushed.
>> 
>> Address this by adding a quirk for drives with buggy MSIs. The lspci
>> output for this device (recorded on a system with MSI-X support) is:
> 
> Based on your description, the patch looks good. This will fallback to
> legacy emulated pin interrupts, and that's better than timeout polling,
> but will still appear sluggish compared to MSI's. Is there an errata
> from the vendor on this? I'm just curious if the bug is at the Device ID
> level, and not something we could constrain to a particular model or
> firmware revision. 

I wasn't able to find any errata for this drive. I wasn't able to
determine if there are any firmware updates for this drive (FWIW I have
version "21160001"). I'll contact WD and see if they know about this
issue.

[1] https://www.westerndigital.com/products/internal-drives/pc-sn530-ssd

>> 02:00.0 Non-Volatile memory controller: Sandisk Corp Device 5008 (rev 01) (prog-if 02 [NVM Express])
>> 	Subsystem: Sandisk Corp Device 5008
>> 	Flags: bus master, fast devsel, latency 0, IRQ 16, NUMA node 0
>> 	Memory at f7e00000 (64-bit, non-prefetchable) [size=16K]
>> 	Memory at f7e04000 (64-bit, non-prefetchable) [size=256]
>> 	Capabilities: [80] Power Management version 3
>> 	Capabilities: [90] MSI: Enable- Count=1/32 Maskable- 64bit+
>> 	Capabilities: [b0] MSI-X: Enable+ Count=17 Masked-
> 
> Interesting, the MSI capability does look weird here. I've never seen
> MSI-x count smaller than the MSI's. As long as both work, though, I
> think nvme would actually prefer whichever is bigger!

--Sean

