Return-Path: <linux-kernel+bounces-17951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6591B8255F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DF9287634
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C465D2E408;
	Fri,  5 Jan 2024 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ys44esDy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242692E3F0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB6BC433C7;
	Fri,  5 Jan 2024 14:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465871;
	bh=WHReJ1bSfa2mxvrLYhiXvKLQEuwXiGcE3S4qN1VHlRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ys44esDyGCpGbjC4+l+oJhsNiRGb959STP1eabqdTcr5zcuWcJFOHAQK+GZVohGKg
	 1sG7g/eXt6jV2dm359ABGGXaTqfKClgxumeWypkjgyO1+G0HoL1fVBcU4tGRm7dONx
	 4ot2zSBmCcxSSXMGwiN9x7mTv49GVxm/4Z/TC3KA=
Date: Fri, 5 Jan 2024 15:40:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] coresight: make coresight_bustype const
Message-ID: <2024010544-framing-cinema-91a7@gregkh>
References: <2024010531-tinfoil-avert-4a57@gregkh>
 <fc74c447-a15b-4fda-bc36-fa39894946e6@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc74c447-a15b-4fda-bc36-fa39894946e6@arm.com>

On Fri, Jan 05, 2024 at 02:22:43PM +0000, Suzuki K Poulose wrote:
> On 05/01/2024 12:33, Greg Kroah-Hartman wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the coresight_bustype variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> > 
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: James Clark <james.clark@arm.com>
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: coresight@lists.linaro.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   drivers/hwtracing/coresight/coresight-core.c | 2 +-
> >   include/linux/coresight.h                    | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> > index 9fabe00a40d6..24c49e581737 100644
> > --- a/drivers/hwtracing/coresight/coresight-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-core.c
> > @@ -1796,7 +1796,7 @@ char *coresight_alloc_device_name(struct coresight_dev_list *dict,
> >   }
> >   EXPORT_SYMBOL_GPL(coresight_alloc_device_name);
> > -struct bus_type coresight_bustype = {
> > +const struct bus_type coresight_bustype = {
> >   	.name	= "coresight",
> >   };
> > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > index a269fffaf991..8fe75a0d7693 100644
> > --- a/include/linux/coresight.h
> > +++ b/include/linux/coresight.h
> > @@ -35,7 +35,7 @@
> >   #define CORESIGHT_UNLOCK	0xc5acce55
> > -extern struct bus_type coresight_bustype;
> > +extern const struct bus_type coresight_bustype;
> 
> Thanks, for the patch. I will queue this for v6.8.

Thanks!

