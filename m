Return-Path: <linux-kernel+bounces-517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8110781425C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF3F284100
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0FF107A4;
	Fri, 15 Dec 2023 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2ahsi3Z1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43985101F2;
	Fri, 15 Dec 2023 07:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165FBC433C8;
	Fri, 15 Dec 2023 07:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702625265;
	bh=VYMxaVjM6jwKEDyy8TIhlqese/qfmw3BV5SnzVRzTIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2ahsi3Z15c5odISV0SkywBPiGig9wTvX0Ka/UkXIVW+H/rOvFx2LjenR8JvmmJaVW
	 x/G8ctfg3uXuIWCVHQR+RDiIob8i7L/jkYvZ9TE+oVm5lMsWZUv+uYgILI0fjzBbL5
	 biGDqji/jICTM+7jBY/fqSfO35D/rROcaFI/wuJE=
Date: Fri, 15 Dec 2023 08:27:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
	Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v6 2/4] dax/bus: Use guard(device) in sysfs attribute
 helpers
Message-ID: <2023121515-litigate-finished-76dd@gregkh>
References: <20231214-vv-dax_abi-v6-0-ad900d698438@intel.com>
 <20231214-vv-dax_abi-v6-2-ad900d698438@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214-vv-dax_abi-v6-2-ad900d698438@intel.com>

On Thu, Dec 14, 2023 at 10:25:27PM -0700, Vishal Verma wrote:
> Use the guard(device) macro to lock a 'struct device', and unlock it
> automatically when going out of scope using Scope Based Resource
> Management semantics. A lot of the sysfs attribute writes in
> drivers/dax/bus.c benefit from a cleanup using these, so change these
> where applicable.

Wait, why are you needing to call device_lock() at all here?  Why is dax
special in needing this when no other subsystem requires it?

> 
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/dax/bus.c | 143 ++++++++++++++++++++++--------------------------------
>  1 file changed, 59 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 1ff1ab5fa105..6226de131d17 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -294,13 +294,10 @@ static ssize_t available_size_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
>  	struct dax_region *dax_region = dev_get_drvdata(dev);
> -	unsigned long long size;
>  
> -	device_lock(dev);
> -	size = dax_region_avail_size(dax_region);
> -	device_unlock(dev);
> +	guard(device)(dev);

You have a valid device here, why are you locking it?  How can it go
away?  And if it can, shouldn't you have a local lock for it, and not
abuse the driver core lock?

>  
> -	return sprintf(buf, "%llu\n", size);
> +	return sprintf(buf, "%llu\n", dax_region_avail_size(dax_region));

sysfs_emit() everywhere please.

But again, the issue is "why do you need a lock"?

thanks,

greg k-h

