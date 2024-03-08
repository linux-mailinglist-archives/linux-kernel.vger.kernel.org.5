Return-Path: <linux-kernel+bounces-97515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0122876B4D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0971C210D7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537565A7B6;
	Fri,  8 Mar 2024 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3UjhDmWZ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2066058101
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709926905; cv=none; b=kMQoqzhEYm6JEAPuTXdflJCploTjK9MFGrvtRZ1nco35uD24BgGpPLW/YeipMNcQDy7oEHCiBYhVgZ3zj3RF6brsDQfG8pkCXu51ds+nn9j/hYzkl2UMGeKe70zt/dGJ8+rHstps8Wn7rdZ70CwmkcbSkKIt+hSToBAEKBlCSkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709926905; c=relaxed/simple;
	bh=6Ccado+7fTNCrTIVsJle4IYobU2lLARj/d+Hs9ns0Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XypIPovv9rCzkbQmKbolGl0AJ65WbScamIYsj1uOIVDg7pueWjLywEWuNgQ4AHmpuZrg0Wsr/y1i7fkbogWjAXK8ev/ft+5Cyvzl/dqIy+RGRTLinQN0i9ed3idZZvC0Uy0q9CQXAsuWA1cgxuAoR/hqR88fxtnFulFtDV6eWLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3UjhDmWZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6092a84f4so1996120b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 11:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709926903; x=1710531703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7Fse3QrTOuTSu6oOGHjMUM7d92RQbiAqK9kY+ki5S0=;
        b=3UjhDmWZLzTXNLUwjP2diwlGDicFI+a3eAcuOxg/bLpMWei1gUgZe5uBFfuQ332P1S
         /FcugolCmCF5/Cu+HFUs+aGB3JLGDenChR0sghIWgrOZbzlLBuBg0u1/f+5heCq7Yc56
         WuBM9q1/lOWxaARhlG5ijE8Lo1ZOlk9BJGdpJ+aqW4OXXv/ABbPrpUH7oGHEiIQcXzy6
         jgG8ThJk2zXpJNgfTp4Vs8cc3xJ8+mjfOFPTqVt9S8qopmLmmruUXf6V0e2G4mioB1SV
         9y8XoK/2k29YkbKgCta0d3Qu9IPpxGeicvm2Lihm43nJFkR9DMe5eMlaYOnLOJ7utC+k
         8UQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709926903; x=1710531703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7Fse3QrTOuTSu6oOGHjMUM7d92RQbiAqK9kY+ki5S0=;
        b=MOJLtKghj+HiGzfDkwvMb3KHyS7iNl2gyZ5VRQLZj1bDw/rDi/zX/uKmRnRHxstx9k
         6G+3F1hBwp2vFvd/V6l039OhYDfD6KCYgU0kyNB6fncclh/8NMLWbPFZwP2dKgiGlA8A
         YcryuAHJc0CtzekRKif1DDQAPEaJfUC/BKJdKPNDa5hPU/dDyu9bsexvtBHrJh0Ogjk/
         4JflfyNG6b/ommJTnMv0AmjdSSbNT5nPZT6Idx7BRCo74NYXGEu7kDUyrV8PT3IHhgpt
         13pZumgHR7c8lvN91Je5GXw4LUSZZBDMhrwH0q+jwPxRPHt5mHjTNxrNQfsAdRoPVNdh
         12nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL/hkMTDxAIdaKlfh4rDoxpvSjq/u4yVOC0H3vWmVM3pUeuTieLZxwjLbiCdT3/swL6KE50gTYpgOtexfw6sU4BduGnLOGvNQtF4Gj
X-Gm-Message-State: AOJu0Yy6cXFaDjrEnUP8l6jiZZNCEz4a2CWod08SJxc6zMfguk7fV9Cq
	EIWhMJgkjFcpqV8WvIiYA3sgH8vbmiB1Dl0VXVIvpqKPUMqJkXyp+PtVh7UaNA==
X-Google-Smtp-Source: AGHT+IF2QUGIFTFWhcLdhuzr3B8ltK/RgVGdsfAQvH5CgB5TVFx2FaPtxLn0l+RMqAoD9ICqPF8e/A==
X-Received: by 2002:a05:6a00:3c86:b0:6e4:fc2b:62d5 with SMTP id lm6-20020a056a003c8600b006e4fc2b62d5mr21424pfb.0.1709926903141;
        Fri, 08 Mar 2024 11:41:43 -0800 (PST)
Received: from google.com ([2620:15c:2c5:13:5598:405c:5e3b:f1be])
        by smtp.gmail.com with ESMTPSA id o12-20020a62f90c000000b006e053e98e1csm62460pfh.136.2024.03.08.11.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 11:41:42 -0800 (PST)
Date: Fri, 8 Mar 2024 11:41:38 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: John Garry <john.g.garry@oracle.com>
Cc: jejb@linux.ibm.com, martin.petersen@oracle.com,
	chenxiang66@hisilicon.com, jinpu.wang@cloud.ionos.com,
	artur.paszkiewicz@intel.com, yanaijie@huawei.com,
	dlemoal@kernel.org, cassel@kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] scsi: libsas: Add LIBSAS_SHT_BASE
Message-ID: <Zetp8ufVfxxo6DOF@google.com>
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
 <20240308114339.1340549-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308114339.1340549-2-john.g.garry@oracle.com>

On Fri, Mar 08, 2024 at 11:43:34AM +0000, John Garry wrote:
> There is much duplication in the scsi_host_template structure for the
> drivers which use libsas.
> 
> Similar to how a standard template is used in libata with __ATA_BASE_SHT,
> create a standard template in LIBSAS_SHT_BASE.
> 
> Don't set a default for max_sectors at SCSI_DEFAULT_MAX_SECTORS, as
> scsi_host_alloc() will default to this value automatically.
> 
> Even though some drivers don't set proc_name, it won't make much difference
> to set as DRV_NAME.
> 
> Also add LIBSAS_SHT_BASE_NO_SLAVE_INIT for the hisi_sas drivers which have
> custom .slave_alloc and .slave_configure methods.

Looks like libata drivers have no problem overriding default values that were
set by __ATA_BASE_SHT. For example __ATA_BASE_SHT sets .can_queue .sdev_attrs
and then AHCI_SHT overrides those with AHCI specific values: 

#define AHCI_SHT(drv_name)                                              \       
        ATA_NCQ_SHT(drv_name),                                          \       
        .can_queue              = AHCI_MAX_CMDS,                        \       
        .sg_tablesize           = AHCI_MAX_SG,                          \       
        .dma_boundary           = AHCI_DMA_BOUNDARY,                    \       
        .shost_attrs            = ahci_shost_attrs,                     \       
        .sdev_attrs             = ahci_sdev_attrs 

Perhaps there is no need for LIBSAS_SHT_BASE_NO_SLAVE_INIT since hisi_sas
can use LIBSAS_SHT_BASE with .slave_alloc and .slave_configure overrides?

Similarly hisi_sas and pm8001 can override the default ".sg_tablesize = SG_ALL".

Thanks,
Igor

> 
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  include/scsi/libsas.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index f5257103fdb6..de842602f47e 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -726,4 +726,33 @@ void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
>  void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
>  			   gfp_t gfp_flags);
>  
> +#define __LIBSAS_SHT_BASE						\
> +	.module				= THIS_MODULE,			\
> +	.name				= DRV_NAME,			\
> +	.proc_name			= DRV_NAME,			\
> +	.queuecommand			= sas_queuecommand,		\
> +	.dma_need_drain			= ata_scsi_dma_need_drain,	\
> +	.target_alloc			= sas_target_alloc,		\
> +	.change_queue_depth		= sas_change_queue_depth,	\
> +	.bios_param			= sas_bios_param,		\
> +	.this_id			= -1,				\
> +	.eh_device_reset_handler	= sas_eh_device_reset_handler, 	\
> +	.eh_target_reset_handler	= sas_eh_target_reset_handler,	\
> +	.target_destroy			= sas_target_destroy,		\
> +	.ioctl				= sas_ioctl,			\
> +
> +#ifdef CONFIG_COMPAT
> +#define _LIBSAS_SHT_BASE		__LIBSAS_SHT_BASE		\
> +	.compat_ioctl			= sas_ioctl,
> +#else
> +#define _LIBSAS_SHT_BASE		__LIBSAS_SHT_BASE
> +#endif
> +
> +#define LIBSAS_SHT_BASE			_LIBSAS_SHT_BASE		\
> +	.slave_configure		= sas_slave_configure,		\
> +	.slave_alloc			= sas_slave_alloc,		\
> +
> +#define LIBSAS_SHT_BASE_NO_SLAVE_INIT	_LIBSAS_SHT_BASE
> +
> +
>  #endif /* _SASLIB_H_ */
> -- 
> 2.31.1
> 

