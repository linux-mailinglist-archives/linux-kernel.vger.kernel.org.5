Return-Path: <linux-kernel+bounces-93814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF37887350D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF2B1F257FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2757260DD2;
	Wed,  6 Mar 2024 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2icY1Up"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E38A605DA;
	Wed,  6 Mar 2024 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722540; cv=none; b=a3d1ZH+mFolP2v+bHJFACfd23LhCz8DisDlsNJeyD87JiYhY+j46ATNvwU/njmoTbdM8eNoUqq3tqMO2ZD/+dTOtLT8Ftf1Bdd/Jv0rU4JzdiT2pvhISpOLebbNc63XibtAQGXIsSnvv8AlYh8j681EPZyTBBqYCg0U3S7MYiks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722540; c=relaxed/simple;
	bh=A84FKy1rIIeJWNE/Zz6B9WivAp931tTSZjJqAyLw2qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYV0fB7SkQtSAgxnvpuI0zQni/RwjlgWGDd++8qCtGo1lFfwea9NGcVbNXtzCMFMrXSoefdRABwYcGlwlbKW2fqj96ZsuqdLtrCfouR85EXuIjtD4KsnTPSUqxmNcAYG6Y9lZN5Dzyrcr1dHuAh0kSOD3ZDdUJ+rTXllXTogA9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2icY1Up; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD558C433F1;
	Wed,  6 Mar 2024 10:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709722539;
	bh=A84FKy1rIIeJWNE/Zz6B9WivAp931tTSZjJqAyLw2qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2icY1UpJz2IPSqQBDIQaiKzl4a4CRrS96zl0E/sw6fe0AMHr6TgosT5cOlMzMWoe
	 59E+yE/gBY21ex5e/aL/psAMiJs+aSSGlK/7W+qm+zO/8y0vLarGD1OEmi9UIErVrl
	 sFydWpfvHnpRQDUbluTL6YLbSA+1QnjNV6fJzw0BlcImohijROP2pnUYh4ONf+eQ1w
	 WColZKZMYT/7bzt6m+85Ak/mRecx8aFg8wHwnsZOgkZJBglzLABzllzY5o1vllTFzn
	 HTf27ZdKBEU+hwKYUTsQ9VrEvOgYHXcjrQRVD7nw3gFxwj5sdJ+yoUqtkEKV7pzH9G
	 gXloDtS9uTFvg==
Date: Wed, 6 Mar 2024 11:55:33 +0100
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
Subject: Re: [PATCH v7 5/7] scsi: hisi_sas: Add libsas SATA sysfs attributes
 group
Message-ID: <ZehLpV06mpHxjecc@ryzen>
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-6-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306012226.3398927-6-ipylypiv@google.com>

On Tue, Mar 05, 2024 at 05:22:24PM -0800, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 ++++++
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 6 ++++++

Is there a reason why you didn't patch:
drivers/scsi/hisi_sas/hisi_sas_v1_hw.c ?


>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> index 73b378837da7..b5d379ebe05d 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> @@ -3544,6 +3544,11 @@ static struct attribute *host_v2_hw_attrs[] = {
>  
>  ATTRIBUTE_GROUPS(host_v2_hw);
>  
> +static const struct attribute_group *sdev_groups_v2_hw[] = {
> +	&sas_ata_sdev_attr_group,
> +	NULL
> +};
> +
>  static void map_queues_v2_hw(struct Scsi_Host *shost)
>  {
>  	struct hisi_hba *hisi_hba = shost_priv(shost);
> @@ -3585,6 +3590,7 @@ static const struct scsi_host_template sht_v2_hw = {
>  	.compat_ioctl		= sas_ioctl,
>  #endif
>  	.shost_groups		= host_v2_hw_groups,
> +	.sdev_groups		= sdev_groups_v2_hw,
>  	.host_reset		= hisi_sas_host_reset,
>  	.map_queues		= map_queues_v2_hw,
>  	.host_tagset		= 1,
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> index b56fbc61a15a..9b69ea16a1e6 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> @@ -2929,6 +2929,11 @@ static struct attribute *host_v3_hw_attrs[] = {
>  
>  ATTRIBUTE_GROUPS(host_v3_hw);
>  
> +static const struct attribute_group *sdev_groups_v3_hw[] = {
> +	&sas_ata_sdev_attr_group,
> +	NULL
> +};
> +
>  #define HISI_SAS_DEBUGFS_REG(x) {#x, x}
>  
>  struct hisi_sas_debugfs_reg_lu {
> @@ -3340,6 +3345,7 @@ static const struct scsi_host_template sht_v3_hw = {
>  	.compat_ioctl		= sas_ioctl,
>  #endif
>  	.shost_groups		= host_v3_hw_groups,
> +	.sdev_groups		= sdev_groups_v3_hw,
>  	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
>  	.host_reset             = hisi_sas_host_reset,
>  	.host_tagset		= 1,
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 

