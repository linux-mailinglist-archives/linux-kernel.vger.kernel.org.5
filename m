Return-Path: <linux-kernel+bounces-94574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28083874197
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D79282CCD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8B175AB;
	Wed,  6 Mar 2024 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TIEgxQWG"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F05E171B0
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709758582; cv=none; b=odaOQg0UA9CNhJWvpdxINMETI8FR6DIHck3USOQ4w92wOiTOO8ISKZwDcHMhdc1yX1AtY282GD9if7HDIWOQ+qFjEN/A9vKb39loi/FXBVMB1t5eJaxia3ISXaFDwvTh3t21SxAS7vqccfis7xgg5iC97OnkBoClzaMSy+/qUYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709758582; c=relaxed/simple;
	bh=chMLxuuJhus8RSm2D1A6/5wioNv3E3Jgtwtcd+vx6Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7JqOqZFCJg5KIk6xA7IJqZfyFaENwe5eHrXptbSTeqQRNDnlkhtzis8jvJFvWyhXdR9cCC7ofFDEtWRHUdFtun5dtuz5MPR51dpU/FWGJJ5GYWK9RHWC9sgytaE5VL9L82QdbhC5JQNmTTLx1mnHncvQavlB/HS6UU7xbylkQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TIEgxQWG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e09143c7bdso135326b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709758581; x=1710363381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=24sGFAKUTMlFkQcWZBTL9mXGCoHWah/p2w8E9U7LrWw=;
        b=TIEgxQWGUdZcgyAEg02NRIfvaCCwulC7zCXCg1AHb+9YobU/p5rsm/rIo1tasgARhp
         X/TvboIjVw2DlRcyhTOmRgBNjc9OBvLjIY7Ut4LDiykEE8yoNWDWtQYKrifaADDsh4kz
         cU+h/mDqjUL5QC3pg30iyxu4dzx/E0WCKKCmMomydBC0jwPPKjqiTmujLTd6+6pgXJy7
         vPvTio0T4eapBN1yG8a5zV2jkP+ovmRmOYx6tqjmfSh4mSWmg+rIURyB4Ou2x8QGHl1S
         bG2b2MuR5r2c6/Yrm9nLU9c3xkQY4BcKPSUtljuPQkHiFJwAufLvABh1nyuLZZsf1uMR
         z5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709758581; x=1710363381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24sGFAKUTMlFkQcWZBTL9mXGCoHWah/p2w8E9U7LrWw=;
        b=KsnwMmdKn6Xv1wzRJlfKIeyfVTBP+YzK/eP+wdMfGDIvvU3D/CRFFYpxowAcg2WWji
         CyGkJUrYprM+6kpXdRBoIZbvXq4FxJkXe1h+nmt6ygh90F/W531BIabtkfg0vn80+BIP
         DPMFQEQzGX6n43sSDuJo6Ueu0yYRDp22h7eWMHFZyxv/G0jIuqZlWxwh8/49ob8WZ4Yu
         V9mNtM1+G2xawl+xyRW8P0D2B4wNn4X2IJfgVaBnncYsAHXHlXMuIysouQXyoQ0NicSo
         MRKsXZ0IXsw/Zi0KY5nU50Y6ZGvfJlIdhLWJaMPo++BGafFiUVH6HS6+PId1SXedH7DP
         cMfg==
X-Forwarded-Encrypted: i=1; AJvYcCXdVRmA7XV3wjpZFncw85v6VXJ05UcmWlFpsOFGvMOmYLs2KLPohAPXzc0ISgQxKHsWwRnIL70OFh7RiHiO00kXcBLI+Ekk3UcEop5X
X-Gm-Message-State: AOJu0YyY6zktg3GTEumMpRY8vgdFKm4PEeDKB7B2vrJ25Ar5i665/xFD
	OS9jMjGmRvCN2yGZ/HA/s3siEuyI4JNgA13kdaqtkwQQZtXzMcvi7C09XqLbbw==
X-Google-Smtp-Source: AGHT+IHGAd/L7VB6xNYd1gWzlLG1X1+due696CWjKmT3T0LUK5z6Uf8B1dNIBpiddnRm1LGtygv1Gg==
X-Received: by 2002:a05:6a00:1915:b0:6e5:584d:8d17 with SMTP id y21-20020a056a00191500b006e5584d8d17mr18776495pfi.15.1709758580424;
        Wed, 06 Mar 2024 12:56:20 -0800 (PST)
Received: from google.com ([2620:15c:2c5:13:9a91:c17:53d9:d156])
        by smtp.gmail.com with ESMTPSA id s16-20020a62e710000000b006e5a6e83f8esm10313892pfh.134.2024.03.06.12.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:56:20 -0800 (PST)
Date: Wed, 6 Mar 2024 12:56:15 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
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
Message-ID: <ZejYb4ykeF7Qx5a5@google.com>
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-6-ipylypiv@google.com>
 <ZehLpV06mpHxjecc@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZehLpV06mpHxjecc@ryzen>

On Wed, Mar 06, 2024 at 11:55:33AM +0100, Niklas Cassel wrote:
> On Tue, Mar 05, 2024 at 05:22:24PM -0800, Igor Pylypiv wrote:
> > The added sysfs attributes group enables the configuration of NCQ Priority
> > feature for HBAs that rely on libsas to manage SATA devices.
> > 
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > Reviewed-by: Jason Yan <yanaijie@huawei.com>
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 ++++++
> >  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 6 ++++++
> 
> Is there a reason why you didn't patch:
> drivers/scsi/hisi_sas/hisi_sas_v1_hw.c ?
> 

I originally patched hisi_sas_v1_hw.c as well. John Garry pointed out
that v1 HW doesn't support SATA so I dropped the change.

> 
> >  2 files changed, 12 insertions(+)
> > 
> > diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> > index 73b378837da7..b5d379ebe05d 100644
> > --- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> > +++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> > @@ -3544,6 +3544,11 @@ static struct attribute *host_v2_hw_attrs[] = {
> >  
> >  ATTRIBUTE_GROUPS(host_v2_hw);
> >  
> > +static const struct attribute_group *sdev_groups_v2_hw[] = {
> > +	&sas_ata_sdev_attr_group,
> > +	NULL
> > +};
> > +
> >  static void map_queues_v2_hw(struct Scsi_Host *shost)
> >  {
> >  	struct hisi_hba *hisi_hba = shost_priv(shost);
> > @@ -3585,6 +3590,7 @@ static const struct scsi_host_template sht_v2_hw = {
> >  	.compat_ioctl		= sas_ioctl,
> >  #endif
> >  	.shost_groups		= host_v2_hw_groups,
> > +	.sdev_groups		= sdev_groups_v2_hw,
> >  	.host_reset		= hisi_sas_host_reset,
> >  	.map_queues		= map_queues_v2_hw,
> >  	.host_tagset		= 1,
> > diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> > index b56fbc61a15a..9b69ea16a1e6 100644
> > --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> > +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> > @@ -2929,6 +2929,11 @@ static struct attribute *host_v3_hw_attrs[] = {
> >  
> >  ATTRIBUTE_GROUPS(host_v3_hw);
> >  
> > +static const struct attribute_group *sdev_groups_v3_hw[] = {
> > +	&sas_ata_sdev_attr_group,
> > +	NULL
> > +};
> > +
> >  #define HISI_SAS_DEBUGFS_REG(x) {#x, x}
> >  
> >  struct hisi_sas_debugfs_reg_lu {
> > @@ -3340,6 +3345,7 @@ static const struct scsi_host_template sht_v3_hw = {
> >  	.compat_ioctl		= sas_ioctl,
> >  #endif
> >  	.shost_groups		= host_v3_hw_groups,
> > +	.sdev_groups		= sdev_groups_v3_hw,
> >  	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
> >  	.host_reset             = hisi_sas_host_reset,
> >  	.host_tagset		= 1,
> > -- 
> > 2.44.0.278.ge034bb2e1d-goog
> > 

