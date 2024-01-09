Return-Path: <linux-kernel+bounces-21531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CA88290D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9D71F265B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFC33E483;
	Tue,  9 Jan 2024 23:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fa1EW/89"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561F3E478;
	Tue,  9 Jan 2024 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704842986; x=1736378986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t2u3vnCnSzBZl1Tbs5JZmoi/P+epXaSxC9m93kmML2c=;
  b=Fa1EW/89egH0gK2SRCOmn4/yKVs1wjtF/v9fdSaTYK5g00C4zNP1JiGz
   xqCKY95/jx4Kg4zxNI/Ji2lwII3ZupEz4GC3/oaG83K0zWgQFHSG1OnFN
   b9jZGOlbul03xP/9nIRQ4pQ7TBIZOL7+3dkacF+i1CcAzrJBPhdibgZ7n
   ePM5WmYrWXrdpj7GcUhv4pparSnnpJWohb1wJGO7oUK3Ow9d/EABUGy+k
   vYc00yzKCyhjJvE2S3EeTZcoI/Nb/qM3s/Yw1oFKrrX/r5cQR1ZDlLHPm
   0iuKtG22bXz38Dxu1sbx4wQIobzwaRKfBHPkZG4yTbs9ELlu1KFSKHI7q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="395513766"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="395513766"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 15:29:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="731643767"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="731643767"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.199.109])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 15:29:43 -0800
Date: Tue, 9 Jan 2024 15:29:42 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] cxl/pci: Skip irq features if irq's are not supported
Message-ID: <ZZ3W5q4UzvLJ9kG+@aschofie-mobl2>
References: <20240108-dont-fail-irq-v1-1-4407228debd2@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108-dont-fail-irq-v1-1-4407228debd2@intel.com>

On Mon, Jan 08, 2024 at 11:51:13PM -0800, Ira Weiny wrote:
> CXL 3.1 Section 3.1.1 states:
> 
> 	"A Function on a CXL device must not generate INTx messages if
> 	that Function participates in CXL.cache protocol or CXL.mem
> 	protocols."
> 
> The generic CXL memory driver only supports devices which use the
> CXL.mem protocol.  The current driver attempts to allocate MSI/MSI-X
> vectors in anticipation of their need for mailbox interrupts or event
> processing.  However, the above requirement does not require a device to
> support interrupts at all.  A device may not use mailbox interrupts and
> may be configured for firmware first event processing.
> 
> Rather than fail device probe if interrupts are not supported; flag such
> that irqs are not supported and do not enable features which require
> interrupts.  dev_warn() in those cases which require interrupts but they
> were not supported.
> 
> It is possible for a device to have host based event processing through
> polling but this patch does not support the addition of such polling.
> Leave that to the future if such a device comes along.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Compile tested only.
> 
> This is an RFC based on errors seen by Dave Larson and reported on
> discord.  Dan requested that the driver not fail if irqs are not
> required.
> ---
>  drivers/cxl/cxlmem.h |  2 ++
>  drivers/cxl/pci.c    | 25 +++++++++++++++++++------
>  2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index a2fcbca253f3..422bc9657e5c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -410,6 +410,7 @@ enum cxl_devtype {
>   * @ram_res: Active Volatile memory capacity configuration
>   * @serial: PCIe Device Serial Number
>   * @type: Generic Memory Class device or Vendor Specific Memory device
> + * @irq_supported: Flag if irqs are supported by the device
>   */
>  struct cxl_dev_state {
>  	struct device *dev;
> @@ -424,6 +425,7 @@ struct cxl_dev_state {
>  	struct resource ram_res;
>  	u64 serial;
>  	enum cxl_devtype type;
> +	bool irq_supported;
>  };
>  
>  /**
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0155fb66b580..bb90ac011290 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -443,6 +443,12 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
>  	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ))
>  		return 0;
>  
> +	if (!cxlds->irq_supported) {
> +		dev_err(cxlds->dev, "Mailbox interrupts enabled but device indicates no interrupt vectors supported.\n");
> +		dev_err(cxlds->dev, "Skip mailbox iterrupt configuration.\n");
> +		return 0;
> +	}
> +

Commit msg says dev_warn() yet here it is dev_err()

Can you fit in one msg, something like:
	"Device does not support mailbox interrupts\n"

Perhaps skip the hard stops. No other dev_*() in this file adds them.
Documentation/process/coding-style.rst

Spellcheck


>  	msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
>  	irq = pci_irq_vector(to_pci_dev(cxlds->dev), msgnum);
>  	if (irq < 0)
> @@ -587,7 +593,8 @@ static int cxl_mem_alloc_event_buf(struct cxl_memdev_state *mds)
>  	return devm_add_action_or_reset(mds->cxlds.dev, free_event_buf, buf);
>  }
>  
> -static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
> +static void cxl_alloc_irq_vectors(struct pci_dev *pdev,
> +				  struct cxl_dev_state *cxlds)
>  {
>  	int nvecs;
>  
> @@ -604,9 +611,10 @@ static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
>  				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
>  	if (nvecs < 1) {
>  		dev_dbg(&pdev->dev, "Failed to alloc irq vectors: %d\n", nvecs);
> -		return -ENXIO;
> +		return;
>  	}
> -	return 0;
> +
> +	cxlds->irq_supported = true;
>  }
>  
>  static irqreturn_t cxl_event_thread(int irq, void *id)
> @@ -754,6 +762,13 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	if (!host_bridge->native_cxl_error)
>  		return 0;
>  
> +	/* Polling not supported */

I understand this comment while reading it in the context of this patch.
Lacking that context, maybe it deserves a bit more like you wrote in
the commit log. Be clear that it's the driver that is not supporting
polling, and when if or when the driver does add polling support they'll
be an alternative method for processing events. IIUC  ;)


> +	if (!mds->cxlds.irq_supported) {
> +		dev_err(mds->cxlds.dev, "Host events enabled but device indicates no interrupt vectors supported.\n");
> +		dev_err(mds->cxlds.dev, "Event polling is not supported, skip event processing.\n");
> +		return 0;
> +	}

Similar to above


> +
>  	rc = cxl_mem_alloc_event_buf(mds);
>  	if (rc)
>  		return rc;
> @@ -845,9 +860,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	else
>  		dev_warn(&pdev->dev, "Media not active (%d)\n", rc);
>  
> -	rc = cxl_alloc_irq_vectors(pdev);
> -	if (rc)
> -		return rc;
> +	cxl_alloc_irq_vectors(pdev, cxlds);
>  
>  	rc = cxl_pci_setup_mailbox(mds);
>  	if (rc)
> 
> ---
> base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> change-id: 20240108-dont-fail-irq-a96310368f0f
> 
> Best regards,
> -- 
> Ira Weiny <ira.weiny@intel.com>
> 

