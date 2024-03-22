Return-Path: <linux-kernel+bounces-111865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8FF8871DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63805283D55
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36335FBA8;
	Fri, 22 Mar 2024 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gtvQEbAh"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0BA41C70
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711128156; cv=none; b=NiSfOsnVjiuqUna/95IKzAhokB7GO2w2XMdVXDOkrlYI3aehMrsmc/KKwn39+VOyQEviZKGc7jngHsiRuOekxPgJYYx4jIDK9vPqzRFFTFyhwhmyMSPpNOcNdWelA8GjSm3GpYaRarEcedI258ixoC7yv54nMjLJlk+eVP76fGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711128156; c=relaxed/simple;
	bh=JRQSJkNbZDDh5hmntu8CppKCnDmLxnU8CBU620nL6DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMZNq2iYfPmH7r4yAHbI9hrLjtJKGxwZLamI2nFaUj7PQSE6iWJXLxhL8zyhgMEkrV7G3ykL/SS0BauD1LRKIwQFMoJ5FCop2y/RHMeTsPYyQAjV9zw/l5ItbKTrCN9PDiQcimdSY32ogmX61sCAHz6Nft/5K4kD66ym/DLhuzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gtvQEbAh; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6963c0c507eso25032116d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711128154; x=1711732954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2AQjZhkcpL+YcTkiIsVz9MRTBhpc8RMyyFuJbdJLXk=;
        b=gtvQEbAhChfG89/Dv91QB92uL4o/N+XGhdBzjTL/w6c6eX2dVap0jkuwI+7ldZtxsv
         e7mQZCBio0jV+ruXfsErls/zCRnBcOPkE+HSI0vS5ST355nz0GIYw/N/bo1Eduzz1xYK
         MCih9uLQSrsoNhvu5dH0woDbNQ3EqS8j+7hYLmMqvVXwjz7ugZaZf5Qg04RhcWtEIyBy
         9QAVfT2afFocnGyDcRZixkIPu31O0Z4JbPgS1h960eB8RDxzGVVEGW4FMhZRkJTXMfgT
         artTt12lSAVg28lMA5YNkkDVPsRs0+YCUmQIAtZVT6A/kB8qXu8PtsSW8x9h7HdV/k9b
         0IPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711128154; x=1711732954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2AQjZhkcpL+YcTkiIsVz9MRTBhpc8RMyyFuJbdJLXk=;
        b=FRzyRvqMP/rGjnlbSx1qvKP8PaMj6HOCaTuEIM2TdRgLOgeRjukYRs79znNOaEF/nj
         gyJhTAkBl0j6zQFRg+50GS+f39sMcC94aKli5UUsjTBdmZLdEXwe75qo/eTonNcpGJCN
         q/uED/P3DyqVYHoG1NmzP00q6Rh1pKYw1KSLxNz6J7OGXFO/I49pgKsYFJBTyQ02r0Ay
         AR8JweZSSeUUPNajTkCDNNKbmAy8WKE70nkT9zXmLeeomkPF4MnWI4rB7zv24qcFQjqD
         y9EsDz8sjCen2od/a//25dieGHC02WKeeOq7gJyzIiZ8Vpdaa3/L+SEBTqNPE0h+uK9K
         baRg==
X-Forwarded-Encrypted: i=1; AJvYcCWJizAVnMnFhajYUePx0Bh3B5hz73oISMz7va2iBOf7LIv6lrTZICVmMnwk8oz10+oPILF2wLVkUzM1zUthtlbROkLU3zWL7Eoc/Tfo
X-Gm-Message-State: AOJu0YzrKIyGcJyjbx8JSt0r6x8DWbDGkH1JiLh2mBof5POl4AAyJ/eJ
	JxjCNeQENcNS9XQJSJyqLL58KB+PQ7fefgDnt7+Ru3icJcsfeJY9BE/0as2KtE8=
X-Google-Smtp-Source: AGHT+IFkTNz9gzTcdcg16F0TwV7dxXOkqWGRizUzT+UpEdwSHdcAyu+RuzvoVxcbESzfseuHHEH9Lw==
X-Received: by 2002:a05:6214:1307:b0:690:b479:527e with SMTP id pn7-20020a056214130700b00690b479527emr4829755qvb.13.1711128153820;
        Fri, 22 Mar 2024 10:22:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id kl6-20020a056214518600b00691281bf661sm1267511qvb.5.2024.03.22.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:22:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rnibA-00CUem-JS;
	Fri, 22 Mar 2024 14:22:32 -0300
Date: Fri, 22 Mar 2024 14:22:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/8] iommufd: Add iommufd fault object
Message-ID: <20240322172232.GK66976@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-5-baolu.lu@linux.intel.com>
 <ad4575588dd247fa8beae60963f36404@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad4575588dd247fa8beae60963f36404@huawei.com>

On Wed, Mar 20, 2024 at 04:18:05PM +0000, Shameerali Kolothum Thodi wrote:
> 
> What I have noticed is that,
> -read interface works fine and I can receive struct tiommu_hwpt_pgfault data.
> -But once Guest handles the page faults and returns the page response,
>  the write to fault fd never reaches the kernel. The sequence is like below,
>  
>   sqe = io_uring_get_sqe(ring);
>   io_uring_prep_write(sqe, hwpt->fault_fd, resp, sizeof(*resp), 0);
>   io_uring_sqe_set_data(sqe, resp);
>   io_uring_submit(ring);
>   ret = io_uring_wait_cqe(ring, &cqe); 
>   ....
> Please find the function here[2]
> 
> The above cqe wait never returns and hardware times out without receiving
> page response. My understanding of io_uring default op is that it tries to 
> issue an sqe as non-blocking first. But it looks like the above write sequence
> ends up in kernel poll_wait() as well.Not sure how we can avoid that for
> write.

Ah, right, it is because poll can't be choosy about read/write, it has
to work equally for both directions. iommufd_fault_fops_poll() never
returns EPOLLOUT

It should just always return EPOLLOUT because we don't have any queue
to manage.

Jason

