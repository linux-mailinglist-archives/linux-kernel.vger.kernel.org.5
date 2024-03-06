Return-Path: <linux-kernel+bounces-93812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81712873508
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35731C2332E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3763574E3F;
	Wed,  6 Mar 2024 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9iRPm0I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1E87316E;
	Wed,  6 Mar 2024 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722513; cv=none; b=C1YMnh/gylrMy0HoYhorzcmfvTnJZ+ivCOTvrclPSFlpliHil9uCT4kdvU0f+rAHJ1e3IkK9S+H+X1/thUidHNYwupX+CloN42Awfkg4cmCrZaIP3GJndZr0Lpn++qSFvOORn5QawQvP076GjmofJlREwn4maczWFaBr6WbBGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722513; c=relaxed/simple;
	bh=lzg4Pu+UfxsSSljft+0gBcLjz5gReuqDgoJRJcpkTpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Avm1PglzQXYRI8tFB49dpDFQIr7zBOh8sjTqOQP5NyAAF/g2dOXoe38Sce/hkr2Cdpv2Eu089RA3HwyaNYMWtnZ1/B+x9qzuQCGtQapmU0AXUhWE9JPr2eAjwT6vm34Yb/9OcbJx9P1z6zS5zdxWy6XiiOXcfjkGci0LRXVcB4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9iRPm0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C085C433F1;
	Wed,  6 Mar 2024 10:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709722512;
	bh=lzg4Pu+UfxsSSljft+0gBcLjz5gReuqDgoJRJcpkTpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S9iRPm0I1w6hnJJ3QQiY8cZxwkr/IMuCyQ6JpM3gDLV0L3MEANC2fu6/x7cQoQ1Bs
	 D+MTi1srK+hHGV0MJ+TnkKmvpKr9/Mhzy5eay+lDWwuzrh8P/lWD3JscSqtFS989fX
	 2qfobNiiO8JGL3ATn7d0uQBrlpYnvG/2xCJv8EGBc0a7MfYjj9j6GkXEyvfvHVim8U
	 A7RanepozCVFo9r7d3jh+X7Z38VYJ+R1QlM1fdIwfOt3O3YuGwJYkrqQdpeyffQL1C
	 cKBWLhvgVfJbmCK0c4CuNqRAMbFhsWiYgVvQTeRmGCj6sXcA85vduEIgY2XEoWM3KU
	 fsWsiOZk1Ic9A==
Date: Wed, 6 Mar 2024 11:55:06 +0100
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
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jack Wang <jinpu.wang@ionos.com>
Subject: Re: [PATCH v7 3/7] scsi: pm80xx: Add libsas SATA sysfs attributes
 group
Message-ID: <ZehLijR-9o4Mj8wb@ryzen>
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-4-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306012226.3398927-4-ipylypiv@google.com>

On Tue, Mar 05, 2024 at 05:22:22PM -0800, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Acked-by: Jack Wang <jinpu.wang@ionos.com>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/scsi/pm8001/pm8001_ctl.c  | 5 +++++
>  drivers/scsi/pm8001/pm8001_init.c | 1 +
>  drivers/scsi/pm8001/pm8001_sas.h  | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
> index 5c26a13ffbd2..9ffe1a868d0f 100644
> --- a/drivers/scsi/pm8001/pm8001_ctl.c
> +++ b/drivers/scsi/pm8001/pm8001_ctl.c
> @@ -1039,3 +1039,8 @@ const struct attribute_group *pm8001_host_groups[] = {
>  	&pm8001_host_attr_group,
>  	NULL
>  };
> +
> +const struct attribute_group *pm8001_sdev_groups[] = {
> +	&sas_ata_sdev_attr_group,
> +	NULL
> +};
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index ed6b7d954dda..e6b1108f6117 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -134,6 +134,7 @@ static const struct scsi_host_template pm8001_sht = {
>  	.compat_ioctl		= sas_ioctl,
>  #endif
>  	.shost_groups		= pm8001_host_groups,
> +	.sdev_groups		= pm8001_sdev_groups,
>  	.track_queue_depth	= 1,
>  	.cmd_per_lun		= 32,
>  	.map_queues		= pm8001_map_queues,
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
> index 3ccb7371902f..ced6721380a8 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -717,6 +717,7 @@ int pm80xx_fatal_errors(struct pm8001_hba_info *pm8001_ha);
>  void pm8001_free_dev(struct pm8001_device *pm8001_dev);
>  /* ctl shared API */
>  extern const struct attribute_group *pm8001_host_groups[];
> +extern const struct attribute_group *pm8001_sdev_groups[];
>  
>  #define PM8001_INVALID_TAG	((u32)-1)
>  
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

