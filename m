Return-Path: <linux-kernel+bounces-48423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768C4845BC4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF371F241FA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7791D62166;
	Thu,  1 Feb 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jgce6kue"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05614D9E8;
	Thu,  1 Feb 2024 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802092; cv=none; b=KIotKduXjAhpTTXkOID7X5+QorV7DDLxz1CpjGWzhRux6hGmqeJ7jrRUFGj7eYNzjFR0wOUenF9S0MyNzoqh+AtJjyXnifaSYml8qU23lB1QcGnAfUWIwtbkMB6cicXKm9+M8BOHYbQ9JRJm//ZoBYk4Q7llkr3XelF123AVd/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802092; c=relaxed/simple;
	bh=uOhLn9KGWSsPb/i3wVsc6qllskkS7kDtVG0rkTIgNCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhDFlPY3YSGhDeQWqCltiqacaIHzjE7Amn0k48/ULmonpOWtn6Ks2cpY4/+LiYzA1hQXoBDR/ZtJCRoJ7MvsmBJHTkBZ8nyzjbfSrMsv9EdCCu37Yml5jvAZiuf2ONydvIQWUEiFtYPhKWN4nwA/ZEVZY5MGLqtmjPCjZ2tFJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jgce6kue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18876C433F1;
	Thu,  1 Feb 2024 15:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706802092;
	bh=uOhLn9KGWSsPb/i3wVsc6qllskkS7kDtVG0rkTIgNCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jgce6kueTjW7XRyvtrePo8xS39zvtMxeRTwK65el9+Gf7MQpEnLDdMRu33TKtnK56
	 /RT+fTtHgBQTEWOZNf65lIb4CdqlsWYP5pGhcXNlhm2FZ6AFPUbv9MW26eGi8qFFEi
	 6Gg2gedX2zr19gPZk9R2twYUJXLjb1aK67wKUPDY=
Date: Thu, 1 Feb 2024 07:41:31 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Howard Yen <howardyen@google.com>, hch@lst.de, m.szyprowski@samsung.com,
	andriy.shevchenko@linux.intel.com, petr.tesarik.ext@huawei.com,
	rafael@kernel.org, broonie@kernel.org, james@equiv.tech,
	james.clark@arm.com, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-coherent: add support for multi coherent rmems per
 dev
Message-ID: <2024020156-reshuffle-salvaging-8161@gregkh>
References: <20240201093515.849873-1-howardyen@google.com>
 <f5b626ae-bda1-479f-bc14-b1fd7ba043cf@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5b626ae-bda1-479f-bc14-b1fd7ba043cf@arm.com>

On Thu, Feb 01, 2024 at 10:45:30AM +0000, Robin Murphy wrote:
> On 2024-02-01 9:35 am, Howard Yen wrote:
> > Add support for multiple coherent rmems per device. This patch addes
> > dma_mem_list to device structure to store multiple rmems.
> > 
> > These multiple rmems can be assigned to the device one by one by
> > of_reserved_mem_device_init_by_idx() with the memory-region
> > declaration in device tree as below and store the rmem to the dma_mem_list.
> > 
> > 	device1@0 {
> > 		...
> > 		memory-region = <&reserved_mem0>, <&reserved_mem1>;
> > 		...
> > 	};
> > 
> > When driver tries to allocate memory from the rmems, looks for the first
> > available rmem and allocates the memory from this rmem.
> > 
> > Then if driver removed, of_reserved_mem_device_release() needs to be
> > invoked to release all the rmems assigned to the device.
> > 
> > Signed-off-by: Howard Yen <howardyen@google.com>
> > ---
> >   include/linux/device.h |  1 +
> >   kernel/dma/coherent.c  | 66 +++++++++++++++++++++++++++++++++++-------
> >   2 files changed, 56 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 97c4b046c09d..c8682ee507cf 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -751,6 +751,7 @@ struct device {
> >   #ifdef CONFIG_DMA_DECLARE_COHERENT
> >   	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
> >   					     override */
> > +	struct list_head	dma_mem_list;
> 
> I'm not necessarily against the idea, but only if it's implemented sensibly.
> If we're going to have a list of these it should *replace* the existing
> pointer, not do this weird thing with both.

Agreed, it should be one pointer max for this structure for this type of
thing.  Why not move it into the dma_coherent_mem structure?

thanks,

greg k-h

