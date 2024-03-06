Return-Path: <linux-kernel+bounces-93813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A5687354C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D44B2C47B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AA977A03;
	Wed,  6 Mar 2024 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOVI2+zd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714F60DC8;
	Wed,  6 Mar 2024 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722526; cv=none; b=QZioi3kKKepmoHlklpvLbl8cDj/PW3NiK/oiosE01uzh9+hVMk0n8A2nUdqS3dCGr/pqSpskMUALe79R4bT0VeGRH1XTuPspML5vaHmGNl3Ww/vrJBQe9dIOMgR3kgom6uTam3s74QbmQgxl4C0bn0L2d/q71BumEX+zZhGl89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722526; c=relaxed/simple;
	bh=W5X0vWVPBaZrpRgbR9tIzMlk0v2cDieEZesqxh75Wgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2QBlDz5Mw9Z+5izVxNsarBMZDqvbIh0+ISD2QI19JouFEHfXGV23nYKsHJioDdWzimc8W4rjMbOZHQgMdxY8tA0Mpo+GCRVWn5Gck9TffmFQeKR9JIjOq32HTVxQIsg3O+PT+HL7rQBy6j4ddvNF4V9rBuYUcy3RwtE7VRuUTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOVI2+zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3C3C433C7;
	Wed,  6 Mar 2024 10:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709722525;
	bh=W5X0vWVPBaZrpRgbR9tIzMlk0v2cDieEZesqxh75Wgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOVI2+zd3QEyjQqu+inRF6t8IioyfLZiU2MKnsYilQ7hj3gxguWi5rscYX0gkgywV
	 JIQ+IB97Ta975aNGp2XI+rMD/+T+ksk5KgtTb+3PlUOIrrA62Q8QnL8Z60nsJs2wSc
	 bkv7tdiSOjpPseddqVJZn73XfBLTdwQSeXEqJPcvneyt0tN42CO9bRHC+SYjxHIxZk
	 za0uBsuAq3AgYbIFCb/wJ+ntLjpmbZzuoCu6i+NB6JQsc+vnT3hwK6+K8tqM9c027C
	 z1nV9yGhpfjAU5fWImW5OUfz/6UbxJ0yGOmi1sVN/I3u8S5+3pjrKOhOUjBlP/uTCW
	 US7jKTSKcQfBQ==
Date: Wed, 6 Mar 2024 11:55:19 +0100
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
Subject: Re: [PATCH v7 4/7] scsi: mvsas: Add libsas SATA sysfs attributes
 group
Message-ID: <ZehLl4AymauIvYl8@ryzen>
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-5-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306012226.3398927-5-ipylypiv@google.com>

On Tue, Mar 05, 2024 at 05:22:23PM -0800, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/scsi/mvsas/mv_init.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> index 43ebb331e216..f1090bb5f2c9 100644
> --- a/drivers/scsi/mvsas/mv_init.c
> +++ b/drivers/scsi/mvsas/mv_init.c
> @@ -26,6 +26,7 @@ static const struct mvs_chip_info mvs_chips[] = {
>  };
>  
>  static const struct attribute_group *mvst_host_groups[];
> +static const struct attribute_group *mvst_sdev_groups[];

I think you can remove this line.


>  
>  #define SOC_SAS_NUM 2
>  
> @@ -53,6 +54,7 @@ static const struct scsi_host_template mvs_sht = {
>  	.compat_ioctl		= sas_ioctl,
>  #endif
>  	.shost_groups		= mvst_host_groups,
> +	.sdev_groups		= mvst_sdev_groups,
>  	.track_queue_depth	= 1,
>  };
>  
> @@ -779,6 +781,11 @@ static struct attribute *mvst_host_attrs[] = {
>  
>  ATTRIBUTE_GROUPS(mvst_host);
>  
> +static const struct attribute_group *mvst_sdev_groups[] = {
> +	&sas_ata_sdev_attr_group,
> +	NULL
> +};

.and move these lines up to be after:
static const struct attribute_group *mvst_host_groups[];


> +
>  module_init(mvs_init);
>  module_exit(mvs_exit);
>  
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 

