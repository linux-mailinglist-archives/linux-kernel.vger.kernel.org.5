Return-Path: <linux-kernel+bounces-38854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7E083C748
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1702A1F2319B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C955745E6;
	Thu, 25 Jan 2024 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="n006/Zfo"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8539573175
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197822; cv=none; b=IUW+YxnQiJpCJw/ISrTHzQE8pNdKZuGERUZGevHRTLQ0PQ0jZ68pTT0py5HHmeCIRf/VS1Fkxlcdi+saXlLHg+rJWpcaAXyKpSfqVkhmJrrLFeMmjmH/Vgbdo3AW9PPkzxX4x85xKNVOn2zLNs4I9cHp9qQXz8lpgBxsadz3RVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197822; c=relaxed/simple;
	bh=7tI7GQWmIWcAMWk+voq5Jc5scUNIDQ1xSclcgqYcSmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP4+atdEsnwEqvI/ZpEUyJEwPRknF/fYmuyliBBaTudp3VNGs9kEnDu8YaBpLiE4MR715mAh2AMOTqKuRwIKhpesQbcT/3tPVT5CHsAqAChbHXyaBDLAeJuMMG/W7p4JzJlLYH9BhHOCzkdaG6CGhWF4442WT3pva3iC0VYXpXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=n006/Zfo; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-686aa9f0736so10520116d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706197819; x=1706802619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=58NyEZxlKioQHJ5VpckWrYBK4rieOl/YNYhuqxJjrTQ=;
        b=n006/ZfoKWORUU+NWeuczKsvPwALgfw5uIbbNMVQAe2ePv3DJaC0w/UfIPNJGTI5zH
         S4UC/vVB3VVIzTOxUDTQsSxeXN7U+/rKl5F4IhstTEQJ6xBC+HgHpjf/9WfHU0UoWTKw
         ZtdydTlcT4OWYp3er4LljhEmaRoa2PvJkI9tsAgrjFXrD53gBg7MnlK21AuplAksdUOs
         x8z0A/hfFN+JAV9KUyTqrncM8i+XLzknGmtCOQU+UyU/I7PWxEgxZXek2BqZFKuLHjzl
         GXEhe4PUB/i9CJpc/kWPijZFPHCY90siOg6cGL274VX+/V0h0D+VKiyiPUoJQGnLt665
         9Vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706197819; x=1706802619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58NyEZxlKioQHJ5VpckWrYBK4rieOl/YNYhuqxJjrTQ=;
        b=OR8/O1rHclxWbel6mFgBCirU4K0Cr49h0+lcWPVtgImffzFQyEgrL+dp8ugtGac/+K
         2hvuYYxdjTamM8CK5mzMKFFvpgXv9KbB/WKzWpKRV02YJs32mr176lYFMySFiR+c2QhI
         gzisrk5SgESP4AETqcKWB5RPQFxu2/CN5gNLrLh7l9P1eNDlz/aXuUOOM27mFV3hMiqQ
         jhGwj4WE2xqSHY9khuK2bo2JlPyS1SwAzdy+l5fp3XB9bKL09p6fx9EBRhzZQbhIvus2
         HZcSnIk63ecIxoprEEwRDxSJ4wXOPGSm/UXpUb4JSAOZ6JsI7wx1KuU4KsYlrKhsEzsS
         wpBg==
X-Gm-Message-State: AOJu0Ywj8n6A+ngecxiqOQp2o9uJyK8YOMqpZYg2fy6Z7wZOBbguWZ/N
	CbX1tZwAcSKQ4wOoZ4zGSvANV769Dm40XjpN9+q/nxjho4oxBoKw2i+oZrdfaXg=
X-Google-Smtp-Source: AGHT+IFLwvlLixMEJ8F1pWJryesPKscOkN+uPtiDwB9PKXC0aC3fby4A8RdctwHTaEij+xMpjf5IVw==
X-Received: by 2002:a05:6214:1c0c:b0:681:9a5e:c49f with SMTP id u12-20020a0562141c0c00b006819a5ec49fmr1240542qvc.118.1706197819189;
        Thu, 25 Jan 2024 07:50:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id dk13-20020a056214092d00b006852ff71ac2sm5578899qvb.30.2024.01.25.07.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:50:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rT1zd-0091pp-BV;
	Thu, 25 Jan 2024 11:50:17 -0400
Date: Thu, 25 Jan 2024 11:50:17 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com, jroedel@suse.de,
	tpearson@raptorengineering.com, aik@amd.com, bgray@linux.ibm.com,
	gregkh@linuxfoundation.org, gbatra@linux.vnet.ibm.com,
	vaibhav@linux.ibm.com
Subject: Re: [PATCH 1/2] powerpc: iommu: Bring back table group
 release_ownership() call
Message-ID: <20240125155017.GW50608@ziepe.ca>
References: <170618450592.3805.8216395093813382208.stgit@ltcd48-lp2.aus.stglab.ibm.com>
 <170618451433.3805.9015493852395837391.stgit@ltcd48-lp2.aus.stglab.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170618451433.3805.9015493852395837391.stgit@ltcd48-lp2.aus.stglab.ibm.com>

On Thu, Jan 25, 2024 at 06:08:39AM -0600, Shivaprasad G Bhat wrote:
> The commit 2ad56efa80db ("powerpc/iommu: Setup a default domain and
> remove set_platform_dma_ops") refactored the code removing the
> set_platform_dma_ops(). It missed out the table group
> release_ownership() call which would have got called otherwise
> during the guest shutdown via vfio_group_detach_container(). On
> PPC64, this particular call actually sets up the 32-bit TCE table,
> and enables the 64-bit DMA bypass etc. Now after guest shutdown,
> the subsequent host driver (e.g megaraid-sas) probe post unbind
> from vfio-pci fails like,
> 
> megaraid_sas 0031:01:00.0: Warning: IOMMU dma not supported: mask 0x7fffffffffffffff, table unavailable
> megaraid_sas 0031:01:00.0: Warning: IOMMU dma not supported: mask 0xffffffff, table unavailable
> megaraid_sas 0031:01:00.0: Failed to set DMA mask
> megaraid_sas 0031:01:00.0: Failed from megasas_init_fw 6539
> 
> The patch brings back the call to table_group release_ownership()
> call when switching back to PLATFORM domain.
> 
> Fixes: 2ad56efa80db ("powerpc/iommu: Setup a default domain and remove set_platform_dma_ops")
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  arch/powerpc/kernel/iommu.c |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index ebe259bdd462..ac7df43fa7ef 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1296,9 +1296,19 @@ spapr_tce_platform_iommu_attach_dev(struct iommu_domain *platform_domain,
>  	if (!grp)
>  		return -ENODEV;
>  
> -	table_group = iommu_group_get_iommudata(grp);
> -	ret = table_group->ops->take_ownership(table_group);
> -	iommu_group_put(grp);
> +	if (platform_domain->type == IOMMU_DOMAIN_PLATFORM) {
> +		ret = 0;
> +		table_group = iommu_group_get_iommudata(grp);
> +		/*
> +		 * The domain being set to PLATFORM from earlier
> +		 * BLOCKED. The table_group ownership has to be released.
> +		 */
> +		table_group->ops->release_ownership(table_group);
> +	} else if (platform_domain->type == IOMMU_DOMAIN_BLOCKED) {
> +		table_group = iommu_group_get_iommudata(grp);
> +		ret = table_group->ops->take_ownership(table_group);
> +		iommu_group_put(grp);
> +	}

Sure, but please split the function, don't test on the
platform->domain_type.

Also, is there any chance someone can work on actually fixing this to
be a proper iommu driver? I think that will become important for power
to use the common dma_iommu code in the next year...

Sort of like this:

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index ebe259bdd46298..0d6a7fea2bd9a5 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1287,20 +1287,20 @@ spapr_tce_platform_iommu_attach_dev(struct iommu_domain *platform_domain,
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct iommu_group *grp = iommu_group_get(dev);
 	struct iommu_table_group *table_group;
-	int ret = -EINVAL;
 
 	/* At first attach the ownership is already set */
 	if (!domain)
 		return 0;
 
-	if (!grp)
-		return -ENODEV;
-
 	table_group = iommu_group_get_iommudata(grp);
-	ret = table_group->ops->take_ownership(table_group);
+	/*
+	 * The domain being set to PLATFORM from earlier
+	 * BLOCKED. The table_group ownership has to be released.
+	 */
+	table_group->ops->release_ownership(table_group);
 	iommu_group_put(grp);
 
-	return ret;
+	return 0
 }
 
 static const struct iommu_domain_ops spapr_tce_platform_domain_ops = {
@@ -1312,13 +1312,33 @@ static struct iommu_domain spapr_tce_platform_domain = {
 	.ops = &spapr_tce_platform_domain_ops,
 };
 
-static struct iommu_domain spapr_tce_blocked_domain = {
-	.type = IOMMU_DOMAIN_BLOCKED,
+static int
+spapr_tce_platform_iommu_blocked_dev(struct iommu_domain *platform_domain,
+				     struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_group *grp = iommu_group_get(dev);
+	struct iommu_table_group *table_group;
+	int ret = -EINVAL;
+
 	/*
 	 * FIXME: SPAPR mixes blocked and platform behaviors, the blocked domain
 	 * also sets the dma_api ops
 	 */
-	.ops = &spapr_tce_platform_domain_ops,
+	table_group = iommu_group_get_iommudata(grp);
+	ret = table_group->ops->take_ownership(table_group);
+	iommu_group_put(grp);
+
+	return ret;
+}
+
+static const struct iommu_domain_ops spapr_tce_blocked_domain_ops = {
+	.attach_dev = spapr_tce_blocked_iommu_attach_dev,
+};
+
+static struct iommu_domain spapr_tce_blocked_domain = {
+	.type = IOMMU_DOMAIN_BLOCKED,
+	.ops = &spapr_tce_blocked_domain_ops,
 };
 
 static bool spapr_tce_iommu_capable(struct device *dev, enum iommu_cap cap)

