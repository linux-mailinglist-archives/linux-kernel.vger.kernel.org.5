Return-Path: <linux-kernel+bounces-163013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2648B6374
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11C32830B4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDBA1419B4;
	Mon, 29 Apr 2024 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="d9CmAftN"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919E512B14F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422303; cv=none; b=Qvkc8CUQfjyuwtFs+pIQGNqn0dHlI25+nHr8RkmA169d5eat/GPVTkx7imEyPX+31pPEc6tlpsFXF5oaK52STey088Tf1s+RX/9EzTFaqLPnDZy2k5CGK8KUxC8tuHOhoHsLcrIUMlrWbRLZ6C20K8EZHLqgAAUT5g0GwhZRAfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422303; c=relaxed/simple;
	bh=hGkJQ2hEBOMlcZ1QQLXlHGuMxkhZEnRo9lDvpVvAHME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQeYtHMtEonIK1XPurEDhTOsJ9eVxWZNEgDGUwT4V7223MEuFqVGjxrvdEq31PRQUrVlpHhfrwuS56yIp0/DwqGZj52Wchgh0jmaE3KPQ/DbkRiKMc057C1hUvJiOgYCgZbXXmveU3jotW21QmXie9FggyiT0ed3WsHfZIHOUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=d9CmAftN; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-69b9365e584so48269946d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714422300; x=1715027100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U10a+UAKqIg3J4+xTDrbP/nR0140IUjBUmVPbfPeBtU=;
        b=d9CmAftNogKIEaBqznIk/fYmW7YnCKJJznYipCwCLqxaRqTV+cVhKRAZzC0Bxo/W3P
         /E4F8D5T3UJqvJYApfk350nsxtJcnZISEZh5T9o8lNaZMbC+RaOMrTbT5QWpmGy8qAks
         3WcUnbHE37S/Ho2YQAS4RZhwuKd6ZeCLgYkO6AggAzzlW+WwLDeVkm7BXTpldJoC6Rcy
         VsrKXj6AE4R3mbC2LoUYKOBMl5GXyM/OkZPL2T7ouhD0NkM8kteUrnw14bOx1PJJiJ1b
         +u4R1a+zCol6U+zypZ49bLtkHbevMQB3XCMPq9K1b8hg001K0QCEX7k08RT307XIgtPE
         frTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714422300; x=1715027100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U10a+UAKqIg3J4+xTDrbP/nR0140IUjBUmVPbfPeBtU=;
        b=D/wdzQV6QoUFm6NjswL5FK/Y/yBqmbBH4BeHH2BD7DV2uMXIeDOqS1HecuTwuEgPil
         MYX82jYaQWCbsERY8IM9quMilK8fgyokfipVN4zyPJQ2LFjDDpdEGY2GzmoXi1kzAPGp
         WXzFwG93fM0wUtSbkqA+/zl04loXyFPY0H7oTWHoNG4JiOM9v/3hg+0PivRBNb7lLOcO
         dkeGbWj7S3QP9KAAvwjoav97tKR9zxpYXRi59+goJB/lYlYqyqd3frIiFPTXN9ZbayFN
         urbx9WL6kuSwLhE6wWZKFyxS3js4/7SF1xYgWCd4TUFnWo7pnYahhnzwgDdxAHOx0hCe
         xvxw==
X-Forwarded-Encrypted: i=1; AJvYcCVszzcbofAGwi/68brDvQt1GMIwptBOczkORGcnh4yBY82glkCY5VuDndUTb4T8z8/5uOw/Jwa4OD1a2rHGkfKtXEWA9XLmAAdsFtPt
X-Gm-Message-State: AOJu0YzxgJHxvxqJ2B6ZedzyE6WXra1b7Ru9dvIHxvtw+l9xAQYIurDg
	f7v9ljMJaZAhRxOGOutrSVwom7J9otw7dvwuH3ELhfgtAoIkKZ4OHSpIvlttJzM=
X-Google-Smtp-Source: AGHT+IF06oYaGQ5jj9Iw6KSync38cZEI2xitY/lo/JDJPZex4PeINFt5C+ktEksqHFLkO2LXKXqFgA==
X-Received: by 2002:a05:6214:170c:b0:6a0:c155:a650 with SMTP id db12-20020a056214170c00b006a0c155a650mr1291314qvb.23.1714422300544;
        Mon, 29 Apr 2024 13:25:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id x8-20020ad44588000000b0069b432df140sm3829579qvu.121.2024.04.29.13.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:25:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s1XYY-002rmm-3g;
	Mon, 29 Apr 2024 17:24:58 -0300
Date: Mon, 29 Apr 2024 17:24:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Message-ID: <20240429202458.GR231144@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
 <20240403115913.GC1363414@ziepe.ca>
 <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>
 <20240408141946.GB223006@ziepe.ca>
 <86e723e7-c3be-41b1-95d8-dbdf86bbdab5@linux.intel.com>
 <20240409234800.GD223006@ziepe.ca>
 <5871aaec-b81a-4ad4-8eb1-656a04d04bda@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5871aaec-b81a-4ad4-8eb1-656a04d04bda@linux.intel.com>

On Sun, Apr 28, 2024 at 06:22:28PM +0800, Baolu Lu wrote:

>         /* A bond already exists, just take a reference`. */
>         handle = iommu_attach_handle_get(group, iommu_mm->pasid);
>         if (handle) {
>                 if (handle->domain->iopf_handler != iommu_sva_iopf_handler)
> {
>                         ret = -EBUSY;
>                         goto out_unlock;
>                 }
> 
>                 refcount_inc(&handle->users);
>                 mutex_unlock(&iommu_sva_lock);
>                 return handle;
>         }
> 
> But it appears that this code is not lock safe. If the domain on the
> PASID is not a SVA domain, the check of "handle->domain->iopf_handler !=
> iommu_sva_iopf_handler" could result in a use-after-free issue as the
> other thread might detach the domain in between the fetch and check
> lines.

For the above you just need to pass in the iommu_sva_iopf_handler as
an argument to attach_handle_get() and have it check it under the
xa_lock.

The whole thing is already protected under the ugly sva_lock.

Ideally it would be protected by the group mutex..

Jason

