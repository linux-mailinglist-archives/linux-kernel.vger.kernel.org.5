Return-Path: <linux-kernel+bounces-93815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C930A87350F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D321F25AF2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FB77316F;
	Wed,  6 Mar 2024 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAI/RcvF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5F7605C6;
	Wed,  6 Mar 2024 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722554; cv=none; b=YMkPp9ug4OH9NlYzxr2pyeLjT8foPU7ZelNMOlUGfggERb+INAu4bjYjFMW52v5bmEgh4lpygDKpSsAxuSSBj1tFZWNxKIvwYufjieXYm8x5uvGx5FrIIPJpdlswIGS0FwsdyUkzSJ4W14d3YUMU1qx/832UxWejvWV8+3qSAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722554; c=relaxed/simple;
	bh=U3HZcuMiWMXwhFKV0QdClkWgEam86ZP/HCNY80dPevs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cowON8j3fhKZngEmBa5QMLCFRJ4IvMsFLen6wqBGLZpRz12sSF4f/mBjEXu8OrM2jXImWctKXF2Sh/Neelf+7lie0EToPnzUNxReMAiFQKdLaqLn8Opyam3EJI/nXide2a2DTFYFszs9WruPPDyQP1gj6zvinoC0TCIrzUdYf+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAI/RcvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14965C433F1;
	Wed,  6 Mar 2024 10:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709722554;
	bh=U3HZcuMiWMXwhFKV0QdClkWgEam86ZP/HCNY80dPevs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAI/RcvFPTT3Da1srJ6+lMZw5Wiwxz+qjVijLj/4KkdoKiofuTuJYvZXwfxWfilyv
	 1+RW0rXk1cypmrGAA6pPt7Gv99XDrB4s5hWAPtGiBeBh8ba7G/1RC0sadqFso/3zTv
	 GkKhWGSvwvDAQyLZxRMCMBXHZvwJhU+0f2+Hfbo6rhVXiz1D7GZFvfloy0LUNdI33h
	 wxqTLe388Z52SNox1k3r5lAREFGHM2fWvo0icx4tm2sSdtBETGTCDJTYfjYUReCivu
	 dlkBcTQxjJqGM8DPEbr7usL0e0/+22Kd/uA0Kig+dAi0M9g3v9Q5s2R789p4eGFTX1
	 PVJhqA28ZPikw==
Date: Wed, 6 Mar 2024 11:55:48 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Hannes Reinecke <hare@suse.de>,
	Xiang Chen <chenxiang66@hisilicon.com>,
	Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/7] scsi: aic94xx: Add libsas SATA sysfs attributes
 group
Message-ID: <ZehLtGYczWmIvcwy@ryzen>
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-7-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306012226.3398927-7-ipylypiv@google.com>

On Tue, Mar 05, 2024 at 05:22:25PM -0800, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/scsi/aic94xx/aic94xx_init.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
> index 8a3340d8d7ad..ccccd0eb6275 100644
> --- a/drivers/scsi/aic94xx/aic94xx_init.c
> +++ b/drivers/scsi/aic94xx/aic94xx_init.c
> @@ -14,6 +14,7 @@
>  #include <linux/firmware.h>
>  #include <linux/slab.h>
>  
> +#include <scsi/sas_ata.h>
>  #include <scsi/scsi_host.h>
>  
>  #include "aic94xx.h"
> @@ -34,6 +35,7 @@ MODULE_PARM_DESC(use_msi, "\n"
>  static struct scsi_transport_template *aic94xx_transport_template;
>  static int asd_scan_finished(struct Scsi_Host *, unsigned long);
>  static void asd_scan_start(struct Scsi_Host *);
> +static const struct attribute_group *asd_sdev_groups[];
>  
>  static const struct scsi_host_template aic94xx_sht = {
>  	.module			= THIS_MODULE,
> @@ -60,6 +62,7 @@ static const struct scsi_host_template aic94xx_sht = {
>  	.compat_ioctl		= sas_ioctl,
>  #endif
>  	.track_queue_depth	= 1,
> +	.sdev_groups		= asd_sdev_groups,
>  };
>  
>  static int asd_map_memio(struct asd_ha_struct *asd_ha)
> @@ -951,6 +954,11 @@ static void asd_remove_driver_attrs(struct device_driver *driver)
>  	driver_remove_file(driver, &driver_attr_version);
>  }
>  
> +static const struct attribute_group *asd_sdev_groups[] = {
> +	&sas_ata_sdev_attr_group,
> +	NULL
> +};

If you move this in front of:
static const struct scsi_host_template aic94xx_sht = { };

I think that you can remove the forward declaration.


> +
>  static struct sas_domain_function_template aic94xx_transport_functions = {
>  	.lldd_dev_found		= asd_dev_found,
>  	.lldd_dev_gone		= asd_dev_gone,
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 

