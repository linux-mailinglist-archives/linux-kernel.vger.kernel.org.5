Return-Path: <linux-kernel+bounces-468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D405981419D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0261C22458
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298D7748A;
	Fri, 15 Dec 2023 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="isdXMoLa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B339D275;
	Fri, 15 Dec 2023 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jobEC3jqWIpyDkINLFhovVaNZT5MWZEp2hewynNzNgs=; b=isdXMoLa/gQ7m5FXi3d/9OdoAg
	XaeBzpytEaWOOM1Rv6L6Sb2AU08uyb+vJzSd5WO8o4IZ76wJduYkmLgYA4YVfdSgaBEYPwZOhSu1k
	T18ZDxt4M5P2pDr/JqvW3DrRznqD3gcz8g92Hzl+tVjbHSHZ9CY+KSEPJ73NRQEPxHpProYcq5bHq
	0Tw4uB3Po+aKjUzhKgdCJURXmEkHYxxCfjAQJY9LYGAVYomrNiqzkIa1+7rtZmOcFNABFW2fS41xV
	GW2gV9vcxcoALFfII/YSkz/8Ghg4HUx9TdVvfsH5XQzCGM7NW2zzLWOY0bXu87XrmYDcCEGWORWAZ
	CMjym3+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rE1BU-00E4oM-QE; Fri, 15 Dec 2023 05:56:28 +0000
Date: Fri, 15 Dec 2023 05:56:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org,
	Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v6 2/4] dax/bus: Use guard(device) in sysfs attribute
 helpers
Message-ID: <ZXvqjIqvcGkumNXf@casper.infradead.org>
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
>  
> -	return sprintf(buf, "%llu\n", size);
> +	return sprintf(buf, "%llu\n", dax_region_avail_size(dax_region));
>  }

Is this an appropriate use of guard()?  sprintf is not the fastest of
functions, so we will end up holding the device_lock for longer than
we used to.

> @@ -908,9 +890,8 @@ static ssize_t size_show(struct device *dev,
>  	struct dev_dax *dev_dax = to_dev_dax(dev);
>  	unsigned long long size;
>  
> -	device_lock(dev);
> +	guard(device)(dev);
>  	size = dev_dax_size(dev_dax);
> -	device_unlock(dev);
>  
>  	return sprintf(buf, "%llu\n", size);
>  }

If it is appropriate, then you can do without the 'size' variable here.

> @@ -1137,21 +1117,20 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
>  	if (rc)
>  		return rc;
>  
> -	rc = -ENXIO;
> -	device_lock(dax_region->dev);
> -	if (!dax_region->dev->driver) {
> -		device_unlock(dax_region->dev);
> -		return rc;
> -	}
> -	device_lock(dev);
> +	guard(device)(dax_region->dev);
> +	if (!dax_region->dev->driver)
> +		return -ENXIO;
>  
> +	guard(device)(dev);
>  	to_alloc = range_len(&r);
> -	if (alloc_is_aligned(dev_dax, to_alloc))
> -		rc = alloc_dev_dax_range(dev_dax, r.start, to_alloc);
> -	device_unlock(dev);
> -	device_unlock(dax_region->dev);
> +	if (!alloc_is_aligned(dev_dax, to_alloc))
> +		return -ENXIO;
>  
> -	return rc == 0 ? len : rc;
> +	rc = alloc_dev_dax_range(dev_dax, r.start, to_alloc);
> +	if (rc)
> +		return rc;
> +
> +	return len;
>  }

Have I mentioned how much I hate the "rc" naming convention?  It tells
you nothing useful about the contents of the variable.  If you called it
'err', I'd know it was an error, and then the end of this function would
make sense.

	if (err)
		return err;
	return len;


