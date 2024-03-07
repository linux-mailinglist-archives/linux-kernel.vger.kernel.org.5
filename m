Return-Path: <linux-kernel+bounces-95252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB2E874B50
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE431C214E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D9784FD2;
	Thu,  7 Mar 2024 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5+dmdhJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D0C657DA;
	Thu,  7 Mar 2024 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805135; cv=none; b=uiYqrjRpubOB8OGhjERHDSzphfz4utnXVKWHeAiFqmOTv+foebUJNEZh7ms1yGCsFQ4M2HyXM6k/z327DZaJlF3YIAViNsobBjlUo6hHxrBOCJfeaLBo5tUF26bGTndWke/UE28WzrVbi7dbhv0GY3rVkeUK/M/bCEZzfxMoIxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805135; c=relaxed/simple;
	bh=CKC1PcEhSEHy0nnIfWiAnTwsc5X3hKJXaOZ3NHLYk38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXg4pPZCPw7VeOp8BERXZf9N7jWDDP6Z2g41hKRbErRa/8z0Nl+1yvoxp07+bqwPYMEDIKB5PtjMgQ4S+9p8kttA1Lg5w99EqYLiGkxUZegT2YJgJIE7o23j0MDeKy7rwGCGEr3EGb4yWrmtS0MWXnjfej6MqX9ZwVAVVq0Q6MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5+dmdhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1ADFC433F1;
	Thu,  7 Mar 2024 09:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709805135;
	bh=CKC1PcEhSEHy0nnIfWiAnTwsc5X3hKJXaOZ3NHLYk38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5+dmdhJGSpnfvU0vSRcKQ+ahZ1OO7cloPoEj1+Ow1ewBUGu8KkRbjxU9Z5bIp6Iu
	 IckYuxvvaqBjO3BRskMWFh5Fjf6jnGsasTjU0dPVY8S15RjjzDpMzCjLsP1bD6kpKc
	 59O8JLGBpopiquHM/NYYWw+SxLTm/SQSxonow1D9+9KBKbro3W3j5vhThLpb3pCiYR
	 fFp9O027ADGWx5BDCTIj+2Bh0YRDvZUunPxIVcvx56U8z1MHNQeZoqGEtF0a0P8XXe
	 3iT8wBlX//QCBDhruSYeoRPy5H0nVXIkCKzP7HIZpsRgGS+9ZoNd4DECzSKFM87Yqx
	 +Tfb9NiEZdO1Q==
Date: Thu, 7 Mar 2024 10:52:08 +0100
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
Message-ID: <ZemOSKWkpatQzNlt@ryzen>
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-5-ipylypiv@google.com>
 <ZehLl4AymauIvYl8@ryzen>
 <ZejccpVEsQTHjltB@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZejccpVEsQTHjltB@google.com>

On Wed, Mar 06, 2024 at 01:13:22PM -0800, Igor Pylypiv wrote:
> On Wed, Mar 06, 2024 at 11:55:19AM +0100, Niklas Cassel wrote:
> > On Tue, Mar 05, 2024 at 05:22:23PM -0800, Igor Pylypiv wrote:
> > > The added sysfs attributes group enables the configuration of NCQ Priority
> > > feature for HBAs that rely on libsas to manage SATA devices.
> > > 
> > > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > > Reviewed-by: Jason Yan <yanaijie@huawei.com>
> > > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > > ---
> > >  drivers/scsi/mvsas/mv_init.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> > > index 43ebb331e216..f1090bb5f2c9 100644
> > > --- a/drivers/scsi/mvsas/mv_init.c
> > > +++ b/drivers/scsi/mvsas/mv_init.c
> > > @@ -26,6 +26,7 @@ static const struct mvs_chip_info mvs_chips[] = {
> > >  };
> > >  
> > >  static const struct attribute_group *mvst_host_groups[];
> > > +static const struct attribute_group *mvst_sdev_groups[];
> > 
> > I think you can remove this line.
> >
> I kept the forward declaration to match the mvst_host_groups style.
> 
> Perhaps mvs_sht can be moved to the bottom of the file so that all forward
> declarations can be removed? This can be done in a separate cleanup patch
> series.
> 
> I'll keep this and aic94xx patches as-is, unless there are objections.

Usually, you first do the cleanup, then you do your changes.
(That way, there are fewer lines changed, since each patch is smaller.)

But no objection from me.


Kind regards,
Niklas


> 
> > 
> > >  
> > >  #define SOC_SAS_NUM 2
> > >  
> > > @@ -53,6 +54,7 @@ static const struct scsi_host_template mvs_sht = {
> > >  	.compat_ioctl		= sas_ioctl,
> > >  #endif
> > >  	.shost_groups		= mvst_host_groups,
> > > +	.sdev_groups		= mvst_sdev_groups,
> > >  	.track_queue_depth	= 1,
> > >  };
> > >  
> > > @@ -779,6 +781,11 @@ static struct attribute *mvst_host_attrs[] = {
> > >  
> > >  ATTRIBUTE_GROUPS(mvst_host);
> > >  
> > > +static const struct attribute_group *mvst_sdev_groups[] = {
> > > +	&sas_ata_sdev_attr_group,
> > > +	NULL
> > > +};
> > 
> > ..and move these lines up to be after:
> > static const struct attribute_group *mvst_host_groups[];
> > 
> > 
> > > +
> > >  module_init(mvs_init);
> > >  module_exit(mvs_exit);
> > >  
> > > -- 
> > > 2.44.0.278.ge034bb2e1d-goog
> > > 

