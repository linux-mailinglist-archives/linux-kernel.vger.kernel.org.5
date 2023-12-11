Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4743B80CF73
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343899AbjLKPYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343865AbjLKPYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:24:52 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85C7DF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:24:57 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5906df1d2adso1807733eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702308297; x=1702913097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3xtaErerlt4nlnnOzSlabRBtDSO5G3MlJlaHfuuRQ8=;
        b=UohwAyJmU+Kj9oPGjLSbDNlsjNYf3kkih/ccgSBZ4ow6gwDGBIxWh00uyeG3ArqVt+
         I7+7mw9JMgO3fRC6OtK9gJnheo814dvWavnX3uLyYwkeWUl8QPhM9ZBlBRZxAi0WVA6R
         gJGrI0HKrg/Pm88HEqUIzmXaWMXtEfv81/1jrw/GsOobuJzWRCpJP3ImEE3O687aQe9V
         12vQJqPrTkUO6OUqCuFUuxJiLzNPiyzKIi7BY+frlOSLqNCvXaaF264ZhlVWrh7aD7ad
         I5jXz4RfhKqJHW1dwSYUgxsD9gZPynbtIOzs9CPj3zM6CyUXJhLUfD5P4k4Zp072wJ1J
         bWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308297; x=1702913097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3xtaErerlt4nlnnOzSlabRBtDSO5G3MlJlaHfuuRQ8=;
        b=iFvu2Ly2j9o+cH8Zd55O3/ji1DnicmEqe8ohIVx9sbBr/9vQt8n2lik3nOz/IWBMeG
         gWMIsYwYVSdbNfGjmDsW66Phdm1yADwrYOrcuVV2cEmRvAiDXQjEMOlsFsDCHQO1j+aU
         FMDXMHtNrrCb8vcYacaUk9vs+FYPXn58H31YRsxa8xiKRJgbMssXaesY3/EM+yKp0axT
         dMyxbAE8A6TnBRm0ZesBbcJZYOuP+JLnOy3nCx9lmMAkufq23VdpTAlYeIUWipgqc4FK
         0Xl0hD3e0ONIxI41xMTAquy0IP9GdLhnxsjQj4HJHgN9AWWRXHhr8zFu+Y/flYp+K3i4
         WgkA==
X-Gm-Message-State: AOJu0Yx2OfKvC+HiRL+4lbDL2CV0hAMFwXvCEskYOKey9PRBDPMHmI1Q
        rBe74aC32hiL3WnsQrpCJNjGLg==
X-Google-Smtp-Source: AGHT+IE0Zf78g8ypnJBYnHHcuYVxNHlZOXYBWbQ4OhuKwmXbnnnqqiXckwuMpS1xSNOWaCdBv28c9A==
X-Received: by 2002:a05:6359:628c:b0:170:17eb:2fc6 with SMTP id se12-20020a056359628c00b0017017eb2fc6mr834223rwb.63.1702308297235;
        Mon, 11 Dec 2023 07:24:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id t11-20020a056214154b00b0065b13180892sm3375747qvw.16.2023.12.11.07.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:24:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rCi9Q-00CcQj-Ag;
        Mon, 11 Dec 2023 11:24:56 -0400
Date:   Mon, 11 Dec 2023 11:24:56 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/12] iommu: Use refcount for fault data access
Message-ID: <20231211152456.GB1489931@ziepe.ca>
References: <20231207064308.313316-1-baolu.lu@linux.intel.com>
 <20231207064308.313316-13-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207064308.313316-13-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 02:43:08PM +0800, Lu Baolu wrote:
> @@ -217,12 +250,9 @@ int iommu_page_response(struct device *dev,
>  	if (!ops->page_response)
>  		return -ENODEV;
>  
> -	mutex_lock(&param->lock);
> -	fault_param = param->fault_param;
> -	if (!fault_param) {
> -		mutex_unlock(&param->lock);
> +	fault_param = iopf_get_dev_fault_param(dev);
> +	if (!fault_param)
>  		return -EINVAL;
> -	}

The refcounting should work by passing around the fault_param object,
not re-obtaining it from the dev from a work.

The work should be locked to the iommu_fault_param that was active
when the work was launched.

When we get to iommu_page_response it does this:

	/* Only send response if there is a fault report pending */
	mutex_lock(&fault_param->lock);
	if (list_empty(&fault_param->faults)) {
		dev_warn_ratelimited(dev, "no pending PRQ, drop response\n");
		goto done_unlock;
	}

Which determines that the iommu_fault_param is stale and pending
free..

Also iopf_queue_remove_device() is messed up - it returns an error
code but nothing ever does anything with it :( Remove functions like
this should never fail.

Removal should be like I explained earlier:
 - Disable new PRI reception
 - Ack all outstanding PRQ to the device
 - Disable PRI on the device
 - Tear down the iopf infrastructure

So under this model if the iopf_queue_remove_device() has been called
it should be sort of a 'disassociate' action where fault_param is
still floating out there but iommu_page_response() does nothing.

IOW pass the refcount from the iommu_report_device_fault() down into
the fault handler, into the work and then into iommu_page_response()
which will ultimately put it back.

> @@ -282,22 +313,15 @@ EXPORT_SYMBOL_GPL(iommu_page_response);
>   */
>  int iopf_queue_flush_dev(struct device *dev)
>  {
> -	int ret = 0;
> -	struct iommu_fault_param *iopf_param;
> -	struct dev_iommu *param = dev->iommu;
> +	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
>  
> -	if (!param)
> +	if (!iopf_param)
>  		return -ENODEV;

And this also seems unnecessary, it is a bug to call this after
iopf_queue_remove_device() right? Just
rcu_derefernce(param->fault_param, true) and WARN_ON NULL.

Jason
