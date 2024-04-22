Return-Path: <linux-kernel+bounces-152730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343E78AC38F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BF11C20FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEACA179AA;
	Mon, 22 Apr 2024 05:01:32 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0689E14A8B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713762092; cv=none; b=bqM1G/TM3CvxNlpjM/mi49waAM87UxYPapPULx5Ov2+B8AdDmpzskHxMZcyvW1pktoQm/imxVSe4/93KM40ngINiYIovtibIAnbqXJMVIXak5D67f60xwRjVlWmSZdOkoITK2LQnsTN21baIt+dUahbsx8FbKIAjE7TnIXd7QqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713762092; c=relaxed/simple;
	bh=pA6jdIeParIDDslb0VbpOv9iLNAFp/mbNR9RFF6IuQA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umwVDBJ441p8CELULeqwrlBtTtXX5ws8vdkwzFNLQEPaQxWQYbZbL3aLfZF6UXmxHsoa1Ka5DJHYgMWCysD7zkjNY4x/K4MKz/QIqlY1wDBRqBt0SjHFiKTeXVv8MgqYglCmrWy+tCNUiNeSfjA0M/W493ubqdLj45PIg5vqYds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 3694bb42-0065-11ef-abf4-005056bdd08f;
	Mon, 22 Apr 2024 08:00:19 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Apr 2024 08:00:17 +0300
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 1/4] iommu: Resolve fwspec ops automatically
Message-ID: <ZiXu4Tk8lDroOKTA@surfacebook.localdomain>
References: <cover.1713523251.git.robin.murphy@arm.com>
 <ad80fed9800194f21c0fc581fec68ca3cfb5dac6.1713523251.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad80fed9800194f21c0fc581fec68ca3cfb5dac6.1713523251.git.robin.murphy@arm.com>

Fri, Apr 19, 2024 at 05:55:59PM +0100, Robin Murphy kirjoitti:
> There's no real need for callers to resolve ops from a fwnode in order
> to then pass both to iommu_fwspec_init() - it's simpler and more sensible
> for that to resolve the ops itself. This in turn means we can centralise
> the notion of checking for a present driver, and enforce that fwspecs
> aren't allocated unless and until we know they will be usable.
> 
> Also we've grown a generic fwnode_handle_get() since this code was first
> written, so may as well clear up that ugly mismatch while we're in here.

..

> +++ b/drivers/iommu/mtk_iommu_v1.c

>  	if (!fwspec) {
> -		ret = iommu_fwspec_init(dev, &args->np->fwnode, &mtk_iommu_v1_ops);
> +		ret = iommu_fwspec_init(dev, &args->np->fwnode);

I'm wondering, while at it, if can avoid direct dereference of fwnode by using of_fwnode_handle().

>  		if (ret)
>  			return ret;

..

> +++ b/drivers/iommu/of_iommu.c

> -	ret = iommu_fwspec_init(dev, fwnode, ops);
> +	ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode);

Ditto.

> +	if (ret == -EPROBE_DEFER)
> +		return driver_deferred_probe_check_state(dev);
>  	if (ret)
>  		return ret;

..

> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c

> -	err = iommu_fwspec_init(dev, &dev->of_node->fwnode, ops);
> +	err = iommu_fwspec_init(dev, &dev->of_node->fwnode);

Ditto.

>  	if (err < 0) {
>  		dev_err(dev, "failed to initialize fwspec: %d\n", err);
>  		return err;

-- 
With Best Regards,
Andy Shevchenko



