Return-Path: <linux-kernel+bounces-97494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B03876B06
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4591C212BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA6D58AC5;
	Fri,  8 Mar 2024 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bAatpVc+"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C479958123
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709924743; cv=none; b=FOSwmGhrF4sWv/2EQoET4WyuJ0wf9E4SwmywUYxs33/UQoVWM3MWz5vJwCD8fUqzRfYZV975LGUh5pgQAYV1LPJ5C2U++nYWtMdI59KJxIURFHKtsgzyIJFP2jwwbVMq+u4mt6Jbq4qTZc3sRQ7kKNcbP0tl1muKWH0/tTep9zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709924743; c=relaxed/simple;
	bh=ILaKu4J8rSQrN8d6WmZQitsoeFgh+zPlpkPgOdLz644=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEzS5nNdpcWixDRxgfL4wKwCxleB4zAuxH8oJkWDKZb+YwPIxvhwEmLTUwxjivi63UTPxTEoGPQ6dBVqIFQ/UQAIUS8zX+Vwdy2HAF35mo0yBBnbVVmvwfCe0YDBFJiR36vG7gxa+rNxvlQqQguycjF8RnbUF2AgoxVByVbvPz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bAatpVc+; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-221816e3ab9so970678fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 11:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709924740; x=1710529540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qMRR7sLkZVUANHdEsXoEoSh+RPGbp+63DXPrOksx9o=;
        b=bAatpVc+vOhV0VmHHIrK9SUqyLiFVcMU/JvhP3Vxv3lAiCXJ6ARUcWMojn3m9bIPWt
         NbZNG+Kx93Sw41lIKiA2FPzIiJFGiokN0WjcgecwANkXZnxrOZGrFKi61w/px7ag3zRV
         rlJWcb0sDyOtkPrxdq3W3XKD1P7rTdj2WRE/4WiATpSroEfBBYhzqI+vv8/xWZSSWRM7
         IAXJKl0BJJj3zgoUPRruiOq8XlExcJ7HUXrH9yYKSlbV62+N7hchKC7+i4K3o2ceKtbC
         mcxwTnX3c9NNz2+dG4YSZXKZ0vZkAW0eyThJ3Oo5I7O5+zkEFeJJwMoyqdLRuffskMkB
         Vlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709924740; x=1710529540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qMRR7sLkZVUANHdEsXoEoSh+RPGbp+63DXPrOksx9o=;
        b=Qs+mbFcBBJPx2x3F9nDHejk1wr89M9PCwIuVHXwaZtRzPAVimWFF+keJuMCqzDNnub
         I9XS7G2FKjU5N6RzFd7JpiMIcjEqvyDd4t3d/+TJfQDtsACPN28V71vrKdrBP2mrOlRx
         janlu0+FwL3vUTEEEFTFL4YnHua11ujeUVeyPTcTTu0pBBnNuCVkZUpHgWNdr8fythFn
         FkY42XjpP1MO3FEpagkKxPDu5xbTU5+p7M/AKTFhXzr97Q5OIzpl/wYEBGAeuloeWYjn
         Eqy6R5a5qPtFxE/2oHZTUXDVEQAfgI+ugwdlSjQYWb0HcT3B0pK6N9pw86EnhwN4rVvG
         k4HA==
X-Forwarded-Encrypted: i=1; AJvYcCX+UQT1EW+Wy/Cy+Mkn5azHbXaAQUkWDZ0yAzPKHNLLaXtBPlM9f+cLvEaGLvqVid4OFavnLHE1ZUEP7Nl18Gj/g4V3BxS7YNljIN84
X-Gm-Message-State: AOJu0YwrdEcGMpM0VAZ/orwq/iouDfle6RltJBB54yzeQ1cknXftS8sR
	5y8T9+ugNcmNdomR1cpYr7/0TgEG+P9+lvoxWeOOgK2r3drk9mzLdh/GVm+Zrjo=
X-Google-Smtp-Source: AGHT+IFDoglDB8jr4C0bRLZGs90q16mK5wPOyxs6caLbupPbYv27tZdKsh1cc0oiSg/2ojAvVJQeAA==
X-Received: by 2002:a05:6870:844f:b0:220:fc89:db73 with SMTP id n15-20020a056870844f00b00220fc89db73mr42008oak.0.1709924740712;
        Fri, 08 Mar 2024 11:05:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id la12-20020a056871410c00b00221847430e2sm1485oab.30.2024.03.08.11.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 11:05:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rifXH-007kGb-7w;
	Fri, 08 Mar 2024 15:05:39 -0400
Date: Fri, 8 Mar 2024 15:05:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <20240308190539.GY9225@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122073903.24406-6-baolu.lu@linux.intel.com>

On Mon, Jan 22, 2024 at 03:39:00PM +0800, Lu Baolu wrote:

> @@ -411,6 +414,8 @@ enum iommu_hwpt_data_type {
>   * @__reserved: Must be 0
>   * @data_type: One of enum iommu_hwpt_data_type
>   * @data_len: Length of the type specific data
> + * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
> + *            IOMMU_HWPT_FAULT_ID_VALID is set.
>   * @data_uptr: User pointer to the type specific data
>   *
>   * Explicitly allocate a hardware page table object. This is the same object
> @@ -441,6 +446,7 @@ struct iommu_hwpt_alloc {
>  	__u32 __reserved;
>  	__u32 data_type;
>  	__u32 data_len;
> +	__u32 fault_id;
>  	__aligned_u64 data_uptr;
>  };

?? We can't add fault_id in the middle of the struct??

> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> +		struct iommufd_fault *fault;
> +
> +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
> +		if (IS_ERR(fault)) {
> +			rc = PTR_ERR(fault);
> +			goto out_hwpt;
> +		}
> +		hwpt->fault = fault;
> +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
> +		hwpt->domain->fault_data = hwpt;
> +		hwpt->fault_capable = true;

I wonder if there should be an iommu API to make a domain fault
capable?

Jason

