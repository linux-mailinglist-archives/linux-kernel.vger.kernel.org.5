Return-Path: <linux-kernel+bounces-94605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D35F787420B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C0FB22CBB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39291B80F;
	Wed,  6 Mar 2024 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aBdgnM2F"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8B1B299
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760843; cv=none; b=Pm4q5VrZEso5RgZyYfqQeBCtrtJVqnmp8WRWp0cfPJM/v4Gn5Wz9aWcRyRQ2lEiVPG91FPAelBxKjun83SHewj07rdRE84I7fVcdiP2yFNKXe04lc/6iW1xmEwnQl1TOtGAuZG8+hTzPQ2jWZ/83VeHLI1KLaY0tPUpUHM5X5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760843; c=relaxed/simple;
	bh=peAbg4zTIh+UTQtLUNXjdZERPwEBRspOqi/uvi47S5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIEhpbUgNKofjiEWzTRgefA3d1xNznU2F1Mueigc7QjXfBT2Ou4WD2553VUj1bUp0vbitzBfcXT7kyt0XjFZhbvGcUfwz0NB58X2PRMFeLzKqHTCa2cgjZi6xSuiNu2J8nJQl9qwm2pTUW11lEpEr8S6Hs6HsBdAfztcgPD7yLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aBdgnM2F; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d944e8f367so1785585ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 13:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709760841; x=1710365641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=spCvMYknEOhSMD+gnBZqeFH7EvzN91XDO9RNAyR+qps=;
        b=aBdgnM2FRSz5up/ufxvS4vnkA+O1A7l5yUQjsO2C0bddUGFfS/Sq+zkXazBIkLZZWw
         69d34eiOYxGf2XyarkMRtnZLY8ObsKJstBHO9YESvXrcSBMOblYus1/6orrBL+OIHsiK
         iWnWBBjoAZePkbeSPGVtXuVapbUFmcf/7g4WAPp61g/6pw8rpfkSGyI2viFyknPBfoqt
         2+7IsAdp6HqQlbLADDh0C7X6AOsxfhuho+3wQVYzgzsz/D4p2Y3Slps+ptx8xTIZhzZE
         imvOXb1H0QMQM4JJrFstYhsMPANO6R4GIfVgcdqZmRRbiXi3zkU1a14TuzGNfNuvo2ai
         atIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709760841; x=1710365641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spCvMYknEOhSMD+gnBZqeFH7EvzN91XDO9RNAyR+qps=;
        b=LiDxM717fucOgHMrS+R+MWVG5AJeEM+AZtJvOIY1Mn+HAr3Fy2R0ErUyZN+DKc+PTC
         2ZjN0AI1VZHd1x57hKcDF/ozlNAQn91f42VpdQmTR1odRQMKJgKdc1XWfIBStnySxCJd
         dJHIwntd850i4gZzpy9NbyMt0sW0mP4Ccg64V1oFCwgKETD527l5DhEPnhAldl3drBg4
         GMRZC4f+TrkrqRRpp8EaSZZUrTL9tc8h4TsceLn8xe25QhgqFYX+ekLnuZzSwXbhnk0m
         MsrOdpUMQXzbuK+EpWbeDgLDV41RhGOMAP4XlSncLCLNYDE0ExSbLyFb9TH/X9DBfe23
         P7DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUefAXlCcWeDdEsOfLLj97NSmVhgiYsuhBQArpeT6EmOVFSpr4pquucXholZtwn+K4V57SSkb6W6r3aGH+GYULvXWkF7p273sMbdBGY
X-Gm-Message-State: AOJu0Yxo6oYR3ajCZjTBHm8piQuSwlMxIJ5mN22Yb8FZoBikM0S4vhk9
	TEoT5/pVL9B730OuJRR3bZMAld8UBbsblnkHOnQCOKOzfrz29ByrKZQ0nMEGtg==
X-Google-Smtp-Source: AGHT+IFT59l4bms+SwWKG/vnM8EnnHFXormej4iFF9afmQhiVqbtqHArrM4el5GtDToqRrBwaMv3WQ==
X-Received: by 2002:a17:903:41cc:b0:1dc:499b:8e80 with SMTP id u12-20020a17090341cc00b001dc499b8e80mr7742894ple.54.1709760840505;
        Wed, 06 Mar 2024 13:34:00 -0800 (PST)
Received: from google.com ([2620:15c:2c5:13:9a91:c17:53d9:d156])
        by smtp.gmail.com with ESMTPSA id lc11-20020a170902fa8b00b001dc668e145asm13063705plb.200.2024.03.06.13.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 13:34:00 -0800 (PST)
Date: Wed, 6 Mar 2024 13:33:55 -0800
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
Subject: Re: [PATCH v7 0/7] NCQ Priority sysfs sttributes for libsas
Message-ID: <ZejhQ7PMFdYV_ktq@google.com>
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <ZehLXDoWQZiLzCTo@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZehLXDoWQZiLzCTo@ryzen>

On Wed, Mar 06, 2024 at 11:54:20AM +0100, Niklas Cassel wrote:
> Hello Igor,
> 
> On Tue, Mar 05, 2024 at 05:22:19PM -0800, Igor Pylypiv wrote:
> > This patch series adds sas_ncq_prio_supported and sas_ncq_prio_enable
> > sysfs sttributes for libsas managed SATA devices. Existing libata sysfs
> > attributes cannot be used directly because the ata_port location is
> > different for libsas.
> 
> As far as I can tell, you don't add sas_ncq_prio_supported and
> sas_ncq_prio_enable, but instead add ncq_prio_supported and
> ncq_prio_enable, so perhaps update this sentence.
> 
Thank you for catching this, Niklas! I've updated the sysfs naming in
the actual patch but forgot to update the cover letter.

Thanks,
Igor
> 
> Kind regards,
> Niklas
> 
> > 
> > Changes since v6:
> > - Replaced sas_ata_sdev_attr_group definition with a macro for
> >   the "CONFIG_SCSI_SAS_ATA is not set" case. The macro defines
> >   an empty rvalue struct eliminating the variable definition.
> > 
> > Changes since v5:
> > - Added __maybe_unused attribute to sas_ata_sdev_attr_group to prevent
> >   an unused-const-variable warning when CONFIG_SCSI_SAS_ATA is not set.
> > 
> > Changes since v4:
> > - Updated sas_ncq_prio_* sysfs functions to use WARN_ON_ONCE() instead
> >   of WARN_ON().
> > 
> > Changes since v3:
> > - Changed ata_ncq_prio_supported() and ata_ncq_prio_enabled() to store
> >   the result into a boolean variable passed by address.
> > - Removed the "usable with both libsas and libata" wording from
> >   ata_ncq_prio_* helper's function comments.
> > - Removed the unlikely() in ata_ncq_prio_enable() because the function
> >   is not in a fastpath.
> > - Dropped hisi_sas v1 HW driver changes because it doesn't support SATA.
> > 
> > Changes since v2:
> > - Added libsas SATA sysfs attributes to aic94xx and isci.
> > 
> > Changes since v1:
> > - Dropped the "sas_" prefix to align sysfs sttributes naming with AHCI.
> > - Dropped ternary operators to make the code more readable.
> > - Corrected the formatting %u -> %d in sysfs_emit().
> > - Changed kstrtol() to kstrtobool() in [ata|sas]_ncq_prio_enable_store().
> > - Changed comments to use the "/* */" style instead of "//".
> > - Added libsas SATA sysfs attributes to mvsas and hisi_sas.
> > - Dropped the 'Reviewed-by' tags because they were not sent in-reply
> >   to the patch emails.
> > 
> > Igor Pylypiv (7):
> >   ata: libata-sata: Factor out NCQ Priority configuration helpers
> >   scsi: libsas: Define NCQ Priority sysfs attributes for SATA devices
> >   scsi: pm80xx: Add libsas SATA sysfs attributes group
> >   scsi: mvsas: Add libsas SATA sysfs attributes group
> >   scsi: hisi_sas: Add libsas SATA sysfs attributes group
> >   scsi: aic94xx: Add libsas SATA sysfs attributes group
> >   scsi: isci: Add libsas SATA sysfs attributes group
> > 
> >  drivers/ata/libata-sata.c              | 140 ++++++++++++++++++-------
> >  drivers/scsi/aic94xx/aic94xx_init.c    |   8 ++
> >  drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   6 ++
> >  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |   6 ++
> >  drivers/scsi/isci/init.c               |   6 ++
> >  drivers/scsi/libsas/sas_ata.c          |  94 +++++++++++++++++
> >  drivers/scsi/mvsas/mv_init.c           |   7 ++
> >  drivers/scsi/pm8001/pm8001_ctl.c       |   5 +
> >  drivers/scsi/pm8001/pm8001_init.c      |   1 +
> >  drivers/scsi/pm8001/pm8001_sas.h       |   1 +
> >  include/linux/libata.h                 |   6 ++
> >  include/scsi/sas_ata.h                 |   6 ++
> >  12 files changed, 247 insertions(+), 39 deletions(-)
> > 
> > -- 
> > 2.44.0.278.ge034bb2e1d-goog
> > 

