Return-Path: <linux-kernel+bounces-94591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F57D8741D3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3301A1C2124D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104871BDDC;
	Wed,  6 Mar 2024 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PKntrcrH"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F45F1BDCE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709759838; cv=none; b=Q/CBl+NpFVu+zJ0f+v90RAnyl5dQjfmqd2DdVKKvZgvdoOwjDjlEz/PCq3tp8nxrDdsQCXnTv6uM3g/9RUJRI6UIO2ag2w16T8sxRHm0aXBjpxgK2K6Ekqczw+iOzgPUkuOcrdn9yljLtbCYH+pupjkvNL03S67T1J1as9r3IvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709759838; c=relaxed/simple;
	bh=3NYFhhT01FUdEcyk+FnkfBgB4GczQeG+bfnl3/XptWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bb/dHa3ALTu1Bfk0Zz1xxD8k38e0rPX/r8ull4X4O7VZF/6Crf8zISJ8FInQ52ZZT/uCdziqk26gIlyMmqEG/3/fgm4N1J4+wv3ESsMb28ufmQfPQnnn3BCGAD3OrQEFRzShJUXu1WkcmZH9bLf5BC6n7mfvAz8+Lk0EuYKMt5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PKntrcrH; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e5c0be115aso150187b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 13:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709759835; x=1710364635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4p9gHAsTorGntNJmsyBdgcnCbH71WEgz640QlCNFHUk=;
        b=PKntrcrH1irgrX987JWAHieaLDt8cPQ5L1IhE2b5R/iBxhdKzmDfYUtfJNKBEMk1wY
         HsCZ1AZO5dmlcRkoOCCC8W+QSzmYuFqwSoIXm29oYv1SQdcCsB0thJSAGX6TIjmeHMq8
         qPRXNV9u5krJFkBQ9w7AgECC9HDns3pLFD1/g1dtRQAIBTf0B9brnb8iYAk8+VsYqlJ8
         K0/1LKlhpA0Lwt4TJoV4Xsz9R/pTyHAni9ZIQIMDZT6gyWwsdhvO2IZvDQbMWxkvP0DK
         20AWF4Y5E3I4tEarRVp1PwDE3RIc34z91gnuS8taWxiE8LjoysF8BwVkp7EG0/HxIEb+
         cNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709759835; x=1710364635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4p9gHAsTorGntNJmsyBdgcnCbH71WEgz640QlCNFHUk=;
        b=krMs3DjPgLsw+fJEBJoPzf1U4pHKYysKjQ/zpOQx8nsY8d9ApGp1PdeMI51qkEAM/L
         sK9ABKLKgJg/Sqcnt4oYzuZzxO2Hs5UwZJliRu4ko6QI8mV198Rt//8igtlUumVktYvH
         KFBM+WTr2FBrJhGCJXbcGCgG2vK/PBs+v8eq195u1iQHCDmhL3mVn0TT4J6k89nvUlv7
         w4HeEgjCWdLPGqbQP1Q5dTygwLwAqy3xJUHq4gNrV+amt6A1H4sybSd3M7KPbHcPwJoB
         eBrz9k+ykbMnP3rx3R4bWYDTX2+ekmiVjR/BYQwRAw6kde6x4+8RJ3JdgfacqjjP/Dag
         g3OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVijQBgtIBS+02kdnRtuCXiCpqPFXt2uxK5/7QEDb183sIxMbk7gCTDYMaQLtwo8QqzNwBPuQ0H6eUNFcXvuV89aXsOs+on0ykcdpe5
X-Gm-Message-State: AOJu0Yyw9fFtOGrdtnZCtV1UwsZJ6yoy7ix2l2wwgr5zr2el4WzJ8F26
	q0nE2pPVPoH8daG+YWCZ333LXBfWS+EC1YPeQV751V0Yi5WSeBYiJq42+D6cIg==
X-Google-Smtp-Source: AGHT+IGnCnXNELiWj2GKO9e4qKNcy/GwrMnsxai7rAjNDTDS3b/TSac5QWwhDKfPUHjJfQdoYw8CEA==
X-Received: by 2002:a05:6a20:394f:b0:1a1:4e6b:185f with SMTP id r15-20020a056a20394f00b001a14e6b185fmr7143741pzg.25.1709759834701;
        Wed, 06 Mar 2024 13:17:14 -0800 (PST)
Received: from google.com ([2620:15c:2c5:13:9a91:c17:53d9:d156])
        by smtp.gmail.com with ESMTPSA id e3-20020aa79803000000b006e5667793d4sm11174635pfl.66.2024.03.06.13.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 13:17:14 -0800 (PST)
Date: Wed, 6 Mar 2024 13:17:09 -0800
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
Subject: Re: [PATCH v7 6/7] scsi: aic94xx: Add libsas SATA sysfs attributes
 group
Message-ID: <ZejdVf4fHVUPkMGr@google.com>
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-7-ipylypiv@google.com>
 <ZehLtGYczWmIvcwy@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZehLtGYczWmIvcwy@ryzen>

On Wed, Mar 06, 2024 at 11:55:48AM +0100, Niklas Cassel wrote:
> On Tue, Mar 05, 2024 at 05:22:25PM -0800, Igor Pylypiv wrote:
> > The added sysfs attributes group enables the configuration of NCQ Priority
> > feature for HBAs that rely on libsas to manage SATA devices.
> > 
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > Reviewed-by: Jason Yan <yanaijie@huawei.com>
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/scsi/aic94xx/aic94xx_init.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
> > index 8a3340d8d7ad..ccccd0eb6275 100644
> > --- a/drivers/scsi/aic94xx/aic94xx_init.c
> > +++ b/drivers/scsi/aic94xx/aic94xx_init.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/firmware.h>
> >  #include <linux/slab.h>
> >  
> > +#include <scsi/sas_ata.h>
> >  #include <scsi/scsi_host.h>
> >  
> >  #include "aic94xx.h"
> > @@ -34,6 +35,7 @@ MODULE_PARM_DESC(use_msi, "\n"
> >  static struct scsi_transport_template *aic94xx_transport_template;
> >  static int asd_scan_finished(struct Scsi_Host *, unsigned long);
> >  static void asd_scan_start(struct Scsi_Host *);
> > +static const struct attribute_group *asd_sdev_groups[];
> >  
> >  static const struct scsi_host_template aic94xx_sht = {
> >  	.module			= THIS_MODULE,
> > @@ -60,6 +62,7 @@ static const struct scsi_host_template aic94xx_sht = {
> >  	.compat_ioctl		= sas_ioctl,
> >  #endif
> >  	.track_queue_depth	= 1,
> > +	.sdev_groups		= asd_sdev_groups,
> >  };
> >  
> >  static int asd_map_memio(struct asd_ha_struct *asd_ha)
> > @@ -951,6 +954,11 @@ static void asd_remove_driver_attrs(struct device_driver *driver)
> >  	driver_remove_file(driver, &driver_attr_version);
> >  }
> >  
> > +static const struct attribute_group *asd_sdev_groups[] = {
> > +	&sas_ata_sdev_attr_group,
> > +	NULL
> > +};
> 
> If you move this in front of:
> static const struct scsi_host_template aic94xx_sht = { };
> 
> I think that you can remove the forward declaration.
> 

Same comment as for mvs_sht. Perhaps mvs_sht can be moved to the bottom
of the file (in a separate patch series) so that all forward declarations
can be removed?

> 
> > +
> >  static struct sas_domain_function_template aic94xx_transport_functions = {
> >  	.lldd_dev_found		= asd_dev_found,
> >  	.lldd_dev_gone		= asd_dev_gone,
> > -- 
> > 2.44.0.278.ge034bb2e1d-goog
> > 

