Return-Path: <linux-kernel+bounces-126891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEA08943E4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3AAAB21899
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EDA48781;
	Mon,  1 Apr 2024 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RTj9Hu0D"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893447A5D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991366; cv=none; b=qKPiC5ntMnjtPG3soY1DzZgAzvGEmxfw+O5TuB3Sge9AzHQCPtYGYwawupagFyB7/4klESvvQihElM4tOOa6eeFyWR9SkEls/jMVdUAhlecvFteQ41YRsi6wgO7l68ya55B3UKNZKlN41yw1IA7e7L2U3d23E4qrB46IGXgr0ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991366; c=relaxed/simple;
	bh=ot6xw/EmgVnST3njxlFas/su5E7yZBlVuz8eV3G6UPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGKqWKGj0bDNF6RIB741FVKTLMaI7U1CyC8avcXM3eKgKLOxaNnA3JIvrMhp37F3dX6eT7WGGj4CjahNzkF3k9lHHpYwt1s2YER8DX5TuDe77uqL5h6O/xSeAkI288Lj9/KZ36PG05dzw9PmMRbYOATZYTq9Iy9J+zX5uZkAufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RTj9Hu0D; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 1 Apr 2024 10:09:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711991361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sexo4Zkg76Uel66nm+BJLgt6nMmfGgQ4IH7dkpFb5+A=;
	b=RTj9Hu0DT2ERBTjCK3MMs7EpeNZMfQ1BGeQtNAdS24hwlbCzJ5ciAmy40V9LkSJqVv+3Wv
	L5EdU9Qpu8tGgLjqCSDgn93dUlo6VJUUyWIQJfFduwPudROlxnZX4yWAuvllGPtdNorzCw
	5xWxaDgf5iYx6vnIQLqLHTLA5o+Mhh0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Peter Colberg <peter.colberg@intel.com>,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Lee Jones <lee@kernel.org>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org, Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH] mfd: intel-m10-bmc: Change staging size to a variable
Message-ID: <20240401170905.v2xin3fzoe3m3tmz@4VRSMR2-DT.corp.robot.car>
References: <20240328233559.6949-1-peter.colberg@intel.com>
 <ZgqCdfCSatazEkIj@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgqCdfCSatazEkIj@yilunxu-OptiPlex-7050>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 01, 2024 at 05:46:29PM +0800, Xu Yilun wrote:
> On Thu, Mar 28, 2024 at 07:35:59PM -0400, Peter Colberg wrote:
> > From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > 
> > The size of the staging area in FLASH for FPGA updates is dependent on the
> > size of the FPGA. Currently, the staging size is defined as a constant.
> > Larger FPGAs are coming soon and it will soon be necessary to support
> 
> Soon? When? You cannot add some feature without a user case. If you do
> have a use case, put the patch in the same patchset.

There may never be an up-streamed use-case. This is a very small
change intended to make it easier for a third-party vendor to
build a card that requires a larger staging area in FLASH. They
would have to add a new "struct m10bmc_csr_map", but they
wouldn't have to refactor this code as part of the change

This change does not introduce an unused function or variable.
It is more of a clean-up, making the code more flexible.

Can it not be taken as is?

- Russ

> 
> Thanks,
> Yilun
> 
> > different sizes for the staging area. Add a new staging_size member to the
> > csr_map structure to support a variable staging size.
> > 
> > The secure update driver does a sanity-check of the image size in
> > comparison to the size of the staging area in FLASH. Change the
> > staging size reference to a variable instead of a constant in order
> > to more readily support future, larger FPGAs.
> > 
> > Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> > ---
> >  drivers/fpga/intel-m10-bmc-sec-update.c | 3 ++-
> >  drivers/mfd/intel-m10-bmc-pmci.c        | 1 +
> >  drivers/mfd/intel-m10-bmc-spi.c         | 1 +
> >  include/linux/mfd/intel-m10-bmc.h       | 1 +
> >  4 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> > index 89851b133709..7ac9f9f5af12 100644
> > --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> > +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> > @@ -529,11 +529,12 @@ static enum fw_upload_err m10bmc_sec_prepare(struct fw_upload *fwl,
> >  					     const u8 *data, u32 size)
> >  {
> >  	struct m10bmc_sec *sec = fwl->dd_handle;
> > +	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
> >  	u32 ret;
> >  
> >  	sec->cancel_request = false;
> >  
> > -	if (!size || size > M10BMC_STAGING_SIZE)
> > +	if (!size || size > csr_map->staging_size)
> >  		return FW_UPLOAD_ERR_INVALID_SIZE;
> >  
> >  	if (sec->m10bmc->flash_bulk_ops)
> > diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
> > index 0392ef8b57d8..698c5933938b 100644
> > --- a/drivers/mfd/intel-m10-bmc-pmci.c
> > +++ b/drivers/mfd/intel-m10-bmc-pmci.c
> > @@ -370,6 +370,7 @@ static const struct m10bmc_csr_map m10bmc_n6000_csr_map = {
> >  	.pr_reh_addr = M10BMC_N6000_PR_REH_ADDR,
> >  	.pr_magic = M10BMC_N6000_PR_PROG_MAGIC,
> >  	.rsu_update_counter = M10BMC_N6000_STAGING_FLASH_COUNT,
> > +	.staging_size = M10BMC_STAGING_SIZE,
> >  };
> >  
> >  static const struct intel_m10bmc_platform_info m10bmc_pmci_n6000 = {
> > diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
> > index cbeb7de9e041..d64d28199df6 100644
> > --- a/drivers/mfd/intel-m10-bmc-spi.c
> > +++ b/drivers/mfd/intel-m10-bmc-spi.c
> > @@ -109,6 +109,7 @@ static const struct m10bmc_csr_map m10bmc_n3000_csr_map = {
> >  	.pr_reh_addr = M10BMC_N3000_PR_REH_ADDR,
> >  	.pr_magic = M10BMC_N3000_PR_PROG_MAGIC,
> >  	.rsu_update_counter = M10BMC_N3000_STAGING_FLASH_COUNT,
> > +	.staging_size = M10BMC_STAGING_SIZE,
> >  };
> >  
> >  static struct mfd_cell m10bmc_d5005_subdevs[] = {
> > diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> > index ee66c9751003..988f1cd90032 100644
> > --- a/include/linux/mfd/intel-m10-bmc.h
> > +++ b/include/linux/mfd/intel-m10-bmc.h
> > @@ -205,6 +205,7 @@ struct m10bmc_csr_map {
> >  	unsigned int pr_reh_addr;
> >  	unsigned int pr_magic;
> >  	unsigned int rsu_update_counter;
> > +	unsigned int staging_size;
> >  };
> >  
> >  /**
> > -- 
> > 2.44.0
> > 
> > 

