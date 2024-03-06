Return-Path: <linux-kernel+bounces-93807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111E58734FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E51289360
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2406086E;
	Wed,  6 Mar 2024 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfOBlZye"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669C5605B4;
	Wed,  6 Mar 2024 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722467; cv=none; b=cTJMhu1QeXJgo3Oq+PaqmeFmGP8806qtWyqg4PceOAht+e5bVJT3oPOMNYFBvRbEUBiSYOjm2v4Na0h51oRcEAGBQUGin9DD52Eio5GfZ1rwjJVrbCGRQPkSe97LOQhE3ucMfs9tKV80i/ZDfEQYdABDkRFKCPuefd4yKRVp6ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722467; c=relaxed/simple;
	bh=tNVnFoiAMQ5QeMVMqZGqNlm8+sdvCROQkfknzCEfqIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSEeA6s0TuXFeMh11oZIh7tzAyj/DcDtCaJvzpd8sFnqbJhg7TcGbDrfOrkgtOttTMnoHjMIOfby/OKAj1gkbyMzUGAd8N0YIewS0BV8lQ87/SQ74akQg70L07kYGQZRadZtIYexfTGQWUEK49tqCx11a0/AYn1hR1dVWBk2lyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfOBlZye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1428FC433C7;
	Wed,  6 Mar 2024 10:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709722467;
	bh=tNVnFoiAMQ5QeMVMqZGqNlm8+sdvCROQkfknzCEfqIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nfOBlZyeqBHPAr5+5y1Br4CmyNoSEbpTx7c11qnnscZF/V9wZKDBd8VkYZfSIvAaQ
	 /W1gDJhctcoet3zqt997+qergIeLSHVLVlVfVv7+PGEMD0Xd7YDr929Z09/fyplhRC
	 gEZbICqjkJonllN68zmyhgnoOGtQVftzjBiN4poo3tNM0FkmEAb5vNk2AntutRGyqO
	 lql4igMg+iwW7Lnoq2uS5iSQfM31XKMZSlfu/CkS2aXu9tFDD4uF+tdRCIi5HreLQM
	 ItD7zyTcQ5q53zm83EonjVSkbb96AmeH3utNTD8DbqZdqbmMTiade250dO/a52lSHF
	 CXhh/yYNMvJlA==
Date: Wed, 6 Mar 2024 11:54:20 +0100
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
Subject: Re: [PATCH v7 0/7] NCQ Priority sysfs sttributes for libsas
Message-ID: <ZehLXDoWQZiLzCTo@ryzen>
References: <20240306012226.3398927-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306012226.3398927-1-ipylypiv@google.com>

Hello Igor,

On Tue, Mar 05, 2024 at 05:22:19PM -0800, Igor Pylypiv wrote:
> This patch series adds sas_ncq_prio_supported and sas_ncq_prio_enable
> sysfs sttributes for libsas managed SATA devices. Existing libata sysfs
> attributes cannot be used directly because the ata_port location is
> different for libsas.

As far as I can tell, you don't add sas_ncq_prio_supported and
sas_ncq_prio_enable, but instead add ncq_prio_supported and
ncq_prio_enable, so perhaps update this sentence.


Kind regards,
Niklas

> 
> Changes since v6:
> - Replaced sas_ata_sdev_attr_group definition with a macro for
>   the "CONFIG_SCSI_SAS_ATA is not set" case. The macro defines
>   an empty rvalue struct eliminating the variable definition.
> 
> Changes since v5:
> - Added __maybe_unused attribute to sas_ata_sdev_attr_group to prevent
>   an unused-const-variable warning when CONFIG_SCSI_SAS_ATA is not set.
> 
> Changes since v4:
> - Updated sas_ncq_prio_* sysfs functions to use WARN_ON_ONCE() instead
>   of WARN_ON().
> 
> Changes since v3:
> - Changed ata_ncq_prio_supported() and ata_ncq_prio_enabled() to store
>   the result into a boolean variable passed by address.
> - Removed the "usable with both libsas and libata" wording from
>   ata_ncq_prio_* helper's function comments.
> - Removed the unlikely() in ata_ncq_prio_enable() because the function
>   is not in a fastpath.
> - Dropped hisi_sas v1 HW driver changes because it doesn't support SATA.
> 
> Changes since v2:
> - Added libsas SATA sysfs attributes to aic94xx and isci.
> 
> Changes since v1:
> - Dropped the "sas_" prefix to align sysfs sttributes naming with AHCI.
> - Dropped ternary operators to make the code more readable.
> - Corrected the formatting %u -> %d in sysfs_emit().
> - Changed kstrtol() to kstrtobool() in [ata|sas]_ncq_prio_enable_store().
> - Changed comments to use the "/* */" style instead of "//".
> - Added libsas SATA sysfs attributes to mvsas and hisi_sas.
> - Dropped the 'Reviewed-by' tags because they were not sent in-reply
>   to the patch emails.
> 
> Igor Pylypiv (7):
>   ata: libata-sata: Factor out NCQ Priority configuration helpers
>   scsi: libsas: Define NCQ Priority sysfs attributes for SATA devices
>   scsi: pm80xx: Add libsas SATA sysfs attributes group
>   scsi: mvsas: Add libsas SATA sysfs attributes group
>   scsi: hisi_sas: Add libsas SATA sysfs attributes group
>   scsi: aic94xx: Add libsas SATA sysfs attributes group
>   scsi: isci: Add libsas SATA sysfs attributes group
> 
>  drivers/ata/libata-sata.c              | 140 ++++++++++++++++++-------
>  drivers/scsi/aic94xx/aic94xx_init.c    |   8 ++
>  drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   6 ++
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |   6 ++
>  drivers/scsi/isci/init.c               |   6 ++
>  drivers/scsi/libsas/sas_ata.c          |  94 +++++++++++++++++
>  drivers/scsi/mvsas/mv_init.c           |   7 ++
>  drivers/scsi/pm8001/pm8001_ctl.c       |   5 +
>  drivers/scsi/pm8001/pm8001_init.c      |   1 +
>  drivers/scsi/pm8001/pm8001_sas.h       |   1 +
>  include/linux/libata.h                 |   6 ++
>  include/scsi/sas_ata.h                 |   6 ++
>  12 files changed, 247 insertions(+), 39 deletions(-)
> 
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 

