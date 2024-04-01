Return-Path: <linux-kernel+bounces-126900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8712889442B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F37B21A75
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036784C630;
	Mon,  1 Apr 2024 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m0ZaRqzZ"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74A021105
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992007; cv=none; b=egUA/fTmbgUw6bS261iuLC3ollQhFXGjXKf2qdhmhMW5YvIUAqaTlN16lp2kgIiGwEorcgrmsZvEd5w4ovestUwG2sYrkgMOwZ7mkn3N39tzmBJ3a6sQBrztO33ruV1e+G99UjyPV4Fn7B8npA+juA81lhGjck7Bn2OSjnaSXcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992007; c=relaxed/simple;
	bh=ZZkDx3+ivYoBkuPSMsuOjpvWPvcAKrM1VWZ9vIg86n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFZIQpYX8y0nQkxpsRvNuW8Wf38tYMIsCWbtiLGcLf6VvgnxOhDCN1Mg0iYXEShQ2fUyWD5emV2KJKyik1mgbBlp9pka7H5+jJSnJTUsgWnRZIWIfZkGMsLkl7LicLuRge7k5/UlsDSZQmhviB/9VCG81eXXxPevEcjczTSgQIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m0ZaRqzZ; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 1 Apr 2024 10:19:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711992001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5NrOmceP2tZ8VIirRS6Xm/Nx7HgAEOPOS/AdWr5fgo=;
	b=m0ZaRqzZv6itmDrjtxSBo/OSqKgnCdGvK8JhdumsJl26b8q/E9HvHDtvgmMJx/oX7gKtVG
	FeOM0l/KXOOJfGQAnBo2LSIOUMqCeANJ/n0ARXxb8pcz3DXMJzCNWaGdIWOXcELd39eV0C
	zIzgxM9r7FUbZG0qc0eNRI0uvjhe1cY=
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
Message-ID: <20240401171947.dncdvc3gxna33nxq@4VRSMR2-DT.corp.robot.car>
References: <20240328233559.6949-1-peter.colberg@intel.com>
 <ZgqCdfCSatazEkIj@yilunxu-OptiPlex-7050>
 <20240401170905.v2xin3fzoe3m3tmz@4VRSMR2-DT.corp.robot.car>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240401170905.v2xin3fzoe3m3tmz@4VRSMR2-DT.corp.robot.car>
X-Migadu-Flow: FLOW_OUT


On Mon, Apr 01, 2024 at 10:09:05AM -0700, Russ Weight wrote:
> On Mon, Apr 01, 2024 at 05:46:29PM +0800, Xu Yilun wrote:
> > On Thu, Mar 28, 2024 at 07:35:59PM -0400, Peter Colberg wrote:
> > > From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > 
> > > The size of the staging area in FLASH for FPGA updates is dependent on the
> > > size of the FPGA. Currently, the staging size is defined as a constant.
> > > Larger FPGAs are coming soon and it will soon be necessary to support
> > 
> > Soon? When? You cannot add some feature without a user case. If you do
> > have a use case, put the patch in the same patchset.
> 
> There may never be an up-streamed use-case. This is a very small
> change intended to make it easier for a third-party vendor to
> build a card that requires a larger staging area in FLASH. They
> would have to add a new "struct m10bmc_csr_map", but they
> wouldn't have to refactor this code as part of the change
> 
> This change does not introduce an unused function or variable.
> It is more of a clean-up, making the code more flexible.
> 
> Can it not be taken as is?

Would it be acceptable to just change the commit message to something
like:

Do not hardwire the staging size in the secure update driver. Move
the staging size to the m10bmc_csr_map structure to make the size
assignment more flexible.

> 
> - Russ
> 
> > 
> > Thanks,
> > Yilun
> > 
> > > different sizes for the staging area. Add a new staging_size member to the
> > > csr_map structure to support a variable staging size.
> > > 
> > > The secure update driver does a sanity-check of the image size in
> > > comparison to the size of the staging area in FLASH. Change the
> > > staging size reference to a variable instead of a constant in order
> > > to more readily support future, larger FPGAs.
> > > 
> > > Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> > > ---
> > >  drivers/fpga/intel-m10-bmc-sec-update.c | 3 ++-
> > >  drivers/mfd/intel-m10-bmc-pmci.c        | 1 +
> > >  drivers/mfd/intel-m10-bmc-spi.c         | 1 +
> > >  include/linux/mfd/intel-m10-bmc.h       | 1 +
> > >  4 files changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> > > index 89851b133709..7ac9f9f5af12 100644
> > > --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> > > +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> > > @@ -529,11 +529,12 @@ static enum fw_upload_err m10bmc_sec_prepare(struct fw_upload *fwl,
> > >  					     const u8 *data, u32 size)
> > >  {
> > >  	struct m10bmc_sec *sec = fwl->dd_handle;
> > > +	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
> > >  	u32 ret;
> > >  
> > >  	sec->cancel_request = false;
> > >  
> > > -	if (!size || size > M10BMC_STAGING_SIZE)
> > > +	if (!size || size > csr_map->staging_size)
> > >  		return FW_UPLOAD_ERR_INVALID_SIZE;
> > >  
> > >  	if (sec->m10bmc->flash_bulk_ops)
> > > diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
> > > index 0392ef8b57d8..698c5933938b 100644
> > > --- a/drivers/mfd/intel-m10-bmc-pmci.c
> > > +++ b/drivers/mfd/intel-m10-bmc-pmci.c
> > > @@ -370,6 +370,7 @@ static const struct m10bmc_csr_map m10bmc_n6000_csr_map = {
> > >  	.pr_reh_addr = M10BMC_N6000_PR_REH_ADDR,
> > >  	.pr_magic = M10BMC_N6000_PR_PROG_MAGIC,
> > >  	.rsu_update_counter = M10BMC_N6000_STAGING_FLASH_COUNT,
> > > +	.staging_size = M10BMC_STAGING_SIZE,
> > >  };
> > >  
> > >  static const struct intel_m10bmc_platform_info m10bmc_pmci_n6000 = {
> > > diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
> > > index cbeb7de9e041..d64d28199df6 100644
> > > --- a/drivers/mfd/intel-m10-bmc-spi.c
> > > +++ b/drivers/mfd/intel-m10-bmc-spi.c
> > > @@ -109,6 +109,7 @@ static const struct m10bmc_csr_map m10bmc_n3000_csr_map = {
> > >  	.pr_reh_addr = M10BMC_N3000_PR_REH_ADDR,
> > >  	.pr_magic = M10BMC_N3000_PR_PROG_MAGIC,
> > >  	.rsu_update_counter = M10BMC_N3000_STAGING_FLASH_COUNT,
> > > +	.staging_size = M10BMC_STAGING_SIZE,
> > >  };
> > >  
> > >  static struct mfd_cell m10bmc_d5005_subdevs[] = {
> > > diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> > > index ee66c9751003..988f1cd90032 100644
> > > --- a/include/linux/mfd/intel-m10-bmc.h
> > > +++ b/include/linux/mfd/intel-m10-bmc.h
> > > @@ -205,6 +205,7 @@ struct m10bmc_csr_map {
> > >  	unsigned int pr_reh_addr;
> > >  	unsigned int pr_magic;
> > >  	unsigned int rsu_update_counter;
> > > +	unsigned int staging_size;
> > >  };
> > >  
> > >  /**
> > > -- 
> > > 2.44.0
> > > 
> > > 

