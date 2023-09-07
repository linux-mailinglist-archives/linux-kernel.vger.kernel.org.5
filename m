Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78376797B36
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbjIGSJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241136AbjIGSJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:09:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BA4199
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:08:50 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso10770995ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694110129; x=1694714929; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1WA7nSSX03R+7PZDRdySk15Ri5tD4cJkX4Tu5hOXZTU=;
        b=MPAhnH0WQg01oSsEvDD1aqj2YsdOadfGZ6HCh9Z8XYpGMyrNSMG5JuxxcdFVAveqmj
         cbBR2HvWyZ2e0Lr90NTqRTxy5S2/8Pgm36B1u0KH0TUGBGjXqAireRwFWVZUe4I2OOtn
         nBfQdy+dBzYj9YqMUhdaD2os+vF+N4LIdlZdX78fls1MXhgDA/+LCaCrIhf8FJmBp3aO
         VdWwtBVF90JXL3xtJ1n4fXAIl+TH9aYG5Uyq0293Ctqr7Uv5rmMfc41wqTZdfa604N1N
         RzMV9yjLXYfkUG6RIypbSacety+VvobTGRyaeCwAM/oY7v/75vrmvCn6lk6oNGwX2UuQ
         vGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694110129; x=1694714929;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WA7nSSX03R+7PZDRdySk15Ri5tD4cJkX4Tu5hOXZTU=;
        b=IGAPT0+KN0BV2ZCGAhuZUMwbVrPIWtY7wF76HqA7fxY7zWH8o5Wsq0uNtnwgCxgtk1
         8ge0QVjs3K2G8PGCXLEmVQSopyc3NrrWwlKShj24X99eo6CVIB1WQ3dqvm4w7NIDKARe
         xLNCRYQ5Qp/CwM+ObStKpef7QSZkchTGjjfhSjrGTqUaet4iCOotpx583VYZEtbek1v3
         SURZEjMo8UH3i7bZVHXOsl0vT5j4wMJcXO0uPHHwRfPaAygTdwMLvDWk5Ju8CcY56hkv
         MM1YPlTF3oq0hCFZjdmE6PF8NZCpvcCzgC+RQKxYEtCt/f6jCr2EMxYIXi2QMy4tp906
         Ou0g==
X-Gm-Message-State: AOJu0Ywx4g/ksolzPqYIbXxcF1eBYbhw57c08e1cicVKI4CqmsZkyQIk
        wa2qqoYCfjjpqwaDym/D9K/gCvwhqn6fKuly3Y4=
X-Google-Smtp-Source: AGHT+IGpxyyboM/L/zgGhHQFaXQnsWarAVOvpbAUvZlAdvzzajFVDv/KMuQZTDNBj8y83kls2kWv8g==
X-Received: by 2002:a17:903:124f:b0:1bf:73ec:b977 with SMTP id u15-20020a170903124f00b001bf73ecb977mr422072plh.46.1694110129153;
        Thu, 07 Sep 2023 11:08:49 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:e988:55e1:682d:801f])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709026b4200b001b8a00d4f7asm66327plt.9.2023.09.07.11.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 11:08:48 -0700 (PDT)
Date:   Thu, 7 Sep 2023 12:08:44 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>
Subject: Re: [PATCH v4 3/3] remoteproc: zynqmp: get TCM from device-tree
Message-ID: <ZPoRrLJEKwSGv+jR@p14s>
References: <20230829181900.2561194-1-tanmay.shah@amd.com>
 <20230829181900.2561194-4-tanmay.shah@amd.com>
 <ZPjXTTGHb4ZG0GqN@p14s>
 <ff56ae0f-48b5-492b-bbb3-713d457e8514@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff56ae0f-48b5-492b-bbb3-713d457e8514@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:02:40PM -0500, Tanmay Shah wrote:
> HI Mathieu,
> 
> Thanks for reviews. Please find my comments below.
>

I took another look after reading your comment and found more problems...

> 
> On 9/6/23 2:47 PM, Mathieu Poirier wrote:
> > Hi Tanmay,
> >
> > On Tue, Aug 29, 2023 at 11:19:00AM -0700, Tanmay Shah wrote:
> > > Use new dt bindings to get TCM address and size
> > > information. Also make sure that driver stays
> > > compatible with previous device-tree bindings.
> > > So, if TCM information isn't available in device-tree
> > > for zynqmp platform, hard-coded address of TCM will
> > > be used.
> > > 
> > > New platforms that are compatible with this
> > > driver must add TCM support in device-tree as per new
> > > bindings.
> > > 
> > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > ---
> > >  drivers/remoteproc/xlnx_r5_remoteproc.c | 279 +++++++++++++++++++-----
> > >  1 file changed, 221 insertions(+), 58 deletions(-)
> > > 
> > > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > index feca6de68da2..4eb62eb545c2 100644
> > > --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > @@ -39,15 +39,19 @@ enum zynqmp_r5_cluster_mode {
> > >   * struct mem_bank_data - Memory Bank description
> > >   *
> > >   * @addr: Start address of memory bank
> > > + * @da: device address for this tcm bank
> > >   * @size: Size of Memory bank
> > >   * @pm_domain_id: Power-domains id of memory bank for firmware to turn on/off
> > > + * @pm_domain_id2: second core's corresponding TCM's pm_domain_id
> > >   * @bank_name: name of the bank for remoteproc framework
> > >   */
> > >  struct mem_bank_data {
> > > -	phys_addr_t addr;
> > > -	size_t size;
> > > +	u32 addr;
> > > +	u32 da;
> > > +	u32 size;
> >
> > Why are the types of @addr and @size changed?
> 
> So, R5 can access 32-bit address range only. Before I had missed this.
> 
> In Devce-tree bindings I am keeping address-cells and size-cells as 2.
> 
> So, out of 64-bits only 32-bits will be used to get address of TCM. Same for size.
> 
> This motivated me to change the type of @addr and @size fields. It doesn't have any side effects.

It doesn't have an effect but it also doesn't need to be in this patch,
especially since it is not documented. 


This patch needs to be broken in 3 parts:

1) One patch that deals with the addition of the static mem_bank_data for
lockstep mode.

2) One patch that deals with the addition of ->pm_domain_id2 and the potential
bug I may have highlighted below.

3) One patch that deals with extracting the TCM information from the DT.
Everything else needs to be in another patch.

> 
> 
> >
> > >  	u32 pm_domain_id;
> > > -	char *bank_name;
> > > +	u32 pm_domain_id2;
> > > +	char bank_name[32];
> >
> > Same
> 
> Now we have "reg-names" property in dts so, when that is available, I try to use it.
> 
> So, instead of keeping simple pointer, I copy name from "struct resources". So, I changed bank_name
> 
> from pointer to array.
>

I'll look at that part again when the rest of may comments are addressed.

> 
> >
> > >  };
> > >  
> > >  /**
> > > @@ -75,11 +79,17 @@ struct mbox_info {
> > >   * Hardcoded TCM bank values. This will be removed once TCM bindings are
> > >   * accepted for system-dt specifications and upstreamed in linux kernel
> > >   */
> > > -static const struct mem_bank_data zynqmp_tcm_banks[] = {
> > > -	{0xffe00000UL, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> > > -	{0xffe20000UL, 0x10000UL, PD_R5_0_BTCM, "btcm0"},
> > > -	{0xffe90000UL, 0x10000UL, PD_R5_1_ATCM, "atcm1"},
> > > -	{0xffeb0000UL, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
> > > +static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
> > > +	{0xffe00000, 0x0, 0x10000, PD_R5_0_ATCM, 0, "atcm0"}, /* TCM 64KB each */
> > > +	{0xffe20000, 0x20000, 0x10000, PD_R5_0_BTCM, 0, "btcm0"},
> >
> > Here the device address for btcm0 is 0x20000 while in the cover letter it is
> > 0x2000.
> 
> Thanks for catching this. This is actually typo in cover-letter. It should be 0x20000 in cover-letter.
> 
> >
> > > +	{0xffe90000, 0x0, 0x10000, PD_R5_1_ATCM, 0, "atcm1"},
> > > +	{0xffeb0000, 0x20000, 0x10000, PD_R5_1_BTCM, 0, "btcm1"},
> >
> > Same
> 
> Same here: It should be 0x20000 in cover-letter.
> 
> >
> > > +};
> > > +
> > > +/* TCM 128KB each */
> > > +static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> > > +	{0xffe00000, 0x0, 0x20000, PD_R5_0_ATCM, PD_R5_1_ATCM, "atcm0"},
> > > +	{0xffe20000, 0x20000, 0x20000, PD_R5_0_BTCM, PD_R5_1_BTCM, "btcm0"},
> > >  };
> > >  
> > >  /**
> > > @@ -422,6 +432,7 @@ static int zynqmp_r5_mem_region_unmap(struct rproc *rproc,
> > >  				      struct rproc_mem_entry *mem)
> > >  {
> > >  	iounmap((void __iomem *)mem->va);
> > > +
> >
> > Spurious change
> Sure,  I will remove it.
> >
> > >  	return 0;
> > >  }
> > >  
> > > @@ -526,30 +537,6 @@ static int tcm_mem_map(struct rproc *rproc,
> > >  	/* clear TCMs */
> > >  	memset_io(va, 0, mem->len);
> > >  
> > > -	/*
> > > -	 * The R5s expect their TCM banks to be at address 0x0 and 0x2000,
> > > -	 * while on the Linux side they are at 0xffexxxxx.
> > > -	 *
> > > -	 * Zero out the high 12 bits of the address. This will give
> > > -	 * expected values for TCM Banks 0A and 0B (0x0 and 0x20000).
> > > -	 */
> > > -	mem->da &= 0x000fffff;
> > > -
> > > -	/*
> > > -	 * TCM Banks 1A and 1B still have to be translated.
> > > -	 *
> > > -	 * Below handle these two banks' absolute addresses (0xffe90000 and
> > > -	 * 0xffeb0000) and convert to the expected relative addresses
> > > -	 * (0x0 and 0x20000).
> > > -	 */
> > > -	if (mem->da == 0x90000 || mem->da == 0xB0000)
> > > -		mem->da -= 0x90000;
> > > -
> > > -	/* if translated TCM bank address is not valid report error */
> > > -	if (mem->da != 0x0 && mem->da != 0x20000) {
> > > -		dev_err(&rproc->dev, "invalid TCM address: %x\n", mem->da);
> > > -		return -EINVAL;
> > > -	}
> > >  	return 0;
> > >  }
> > >  
> > > @@ -571,6 +558,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> > >  	u32 pm_domain_id;
> > >  	size_t bank_size;
> > >  	char *bank_name;
> > > +	u32 da;
> > >  
> > >  	r5_core = rproc->priv;
> > >  	dev = r5_core->dev;
> > > @@ -586,6 +574,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> > >  		bank_name = r5_core->tcm_banks[i]->bank_name;
> > >  		bank_size = r5_core->tcm_banks[i]->size;
> > >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > > +		da = r5_core->tcm_banks[i]->da;
> > >  
> > >  		ret = zynqmp_pm_request_node(pm_domain_id,
> > >  					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > > @@ -599,7 +588,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> > >  			bank_name, bank_addr, bank_size);
> > >  
> > >  		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> > > -						 bank_size, bank_addr,
> > > +						 bank_size, da,
> > >  						 tcm_mem_map, tcm_mem_unmap,
> > >  						 bank_name);
> > >  		if (!rproc_mem) {
> > > @@ -632,14 +621,14 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> > >   */
> > >  static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > >  {
> > > +	u32 pm_domain_id, da, pm_domain_id2;
> > >  	struct rproc_mem_entry *rproc_mem;
> > >  	struct zynqmp_r5_core *r5_core;
> > >  	int i, num_banks, ret;
> > > -	phys_addr_t bank_addr;
> > > -	size_t bank_size = 0;
> > > +	u32 bank_size = 0;

Why is this changed to a u32 when rproc_mem_entry_init() takes a size_t for
@len?  This is especially concerning since add_tcm_carveout_split_mode() still
uses a size_t.

> > >  	struct device *dev;
> > > -	u32 pm_domain_id;
> > >  	char *bank_name;
> > > +	u32 bank_addr;
> > >  
> > >  	r5_core = rproc->priv;
> > >  	dev = r5_core->dev;
> > > @@ -653,12 +642,16 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > >  	 * So, Enable each TCM block individually, but add their size
> > >  	 * to create contiguous memory region.
> > >  	 */
> > > -	bank_addr = r5_core->tcm_banks[0]->addr;
> > > -	bank_name = r5_core->tcm_banks[0]->bank_name;
> > > -
> > >  	for (i = 0; i < num_banks; i++) {
> > > -		bank_size += r5_core->tcm_banks[i]->size;
> > > +		bank_addr = r5_core->tcm_banks[i]->addr;
> > > +		bank_name = r5_core->tcm_banks[i]->bank_name;
> > > +		bank_size = r5_core->tcm_banks[i]->size;
> > >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > > +		pm_domain_id2 = r5_core->tcm_banks[i]->pm_domain_id2;
> > > +		da = r5_core->tcm_banks[i]->da;
> > > +
> > > +		dev_dbg(dev, "TCM %s addr=0x%x, size=0x%x",
> > > +			bank_name, bank_addr, bank_size);
> > >  
> > >  		/* Turn on each TCM bank individually */
> > >  		ret = zynqmp_pm_request_node(pm_domain_id,
> > > @@ -668,23 +661,28 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > >  			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> > >  			goto release_tcm_lockstep;
> > >  		}
> > > -	}
> > >  
> > > -	dev_dbg(dev, "TCM add carveout lockstep mode %s addr=0x%llx, size=0x%lx",
> > > -		bank_name, bank_addr, bank_size);
> > > -
> > > -	/* Register TCM address range, TCM map and unmap functions */
> > > -	rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> > > -					 bank_size, bank_addr,
> > > -					 tcm_mem_map, tcm_mem_unmap,
> > > -					 bank_name);
> > > -	if (!rproc_mem) {
> > > -		ret = -ENOMEM;
> > > -		goto release_tcm_lockstep;
> > > -	}
> > > +		/* Turn on each TCM bank individually */
> > > +		ret = zynqmp_pm_request_node(pm_domain_id2,
> > > +					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > > +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > > +		if (ret < 0) {
> > > +			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id2);
> > > +			goto release_tcm_lockstep;
> > > +		}
> > >  
> > > -	/* If registration is success, add carveouts */
> > > -	rproc_add_carveout(rproc, rproc_mem);
> > > +		/* Register TCM address range, TCM map and unmap functions */
> > > +		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> > > +						 bank_size, da,
> > > +						 tcm_mem_map, tcm_mem_unmap,
> > > +						 bank_name);

The original code adds a single carveout while this code is adding one for each
memory bank?  Is this done on purpose or is it a bug?  No comment is provided.

> > > +		if (!rproc_mem) {
> > > +			ret = -ENOMEM;
> > > +			goto release_tcm_lockstep;
> > > +		}
> > > +
> > > +		rproc_add_carveout(rproc, rproc_mem);
> > > +	}
> > >  
> > >  	return 0;
> > >  
> > > @@ -693,7 +691,12 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > >  	for (i--; i >= 0; i--) {
> > >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > >  		zynqmp_pm_release_node(pm_domain_id);
> > > +		if (pm_domain_id2) {
> > > +			pm_domain_id2 = r5_core->tcm_banks[i]->pm_domain_id2;
> > > +			zynqmp_pm_release_node(pm_domain_id2);
> > > +		}
> > >  	}
> > > +
> > >  	return ret;
> > >  }
> > >  
> > > @@ -800,17 +803,23 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
> > >   */
> > >  static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
> > >  {
> > > +	u32 pm_domain_id, pm_domain_id2;
> > >  	struct zynqmp_r5_core *r5_core;
> > > -	u32 pm_domain_id;
> > >  	int i;
> > >  
> > >  	r5_core = rproc->priv;
> > >  
> > >  	for (i = 0; i < r5_core->tcm_bank_count; i++) {
> > >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > > +		pm_domain_id2 = r5_core->tcm_banks[i]->pm_domain_id2;
> > >  		if (zynqmp_pm_release_node(pm_domain_id))
> > >  			dev_warn(r5_core->dev,
> > >  				 "can't turn off TCM bank 0x%x", pm_domain_id);
> > > +		if (pm_domain_id2 && zynqmp_pm_release_node(pm_domain_id2))
> > > +			dev_warn(r5_core->dev,
> > > +				 "can't turn off TCM bank 0x%x", pm_domain_id2);
> > > +		dev_dbg(r5_core->dev, "pm_domain_id=%d, pm_domain_id2=%d\n",
> > > +			pm_domain_id, pm_domain_id2);
> > >  	}
> > >  
> > >  	return 0;
> > > @@ -883,6 +892,137 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> > >  	return ERR_PTR(ret);
> > >  }
> > >  
> > > +static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
> > > +{
> > > +	int i, j, tcm_bank_count, ret = -EINVAL;
> > > +	struct zynqmp_r5_core *r5_core;
> > > +	struct of_phandle_args out_arg;
> > > +	struct platform_device *cpdev;
> > > +	struct resource *res = NULL;
> > > +	u64 abs_addr = 0, size = 0;
> > > +	struct mem_bank_data *tcm;
> > > +	struct device_node *np, *np1 = NULL;
> > > +	struct device *dev;

As far as I can tell @ret, @res and @np1 don't need initilisation.  It may also
be the case for @abs_addr and @size.  

> > > +
> > > +	for (i = 0; i < cluster->core_count; i++) {
> > > +		r5_core = cluster->r5_cores[i];
> > > +		dev = r5_core->dev;
> > > +		np = dev_of_node(dev);
> > > +
> > > +		/* we have address cell 2 and size cell as 2 */
> > > +		ret = of_property_count_elems_of_size(np, "reg",
> > > +						      4 * sizeof(u32));
> > > +		if (ret <= 0) {
> > > +			ret = -EINVAL;
> > > +			goto fail_tcm;
> > > +		}
> > > +
> > > +		tcm_bank_count = ret;
> > > +
> > > +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
> > > +						  sizeof(struct mem_bank_data *),
> > > +						  GFP_KERNEL);
> > > +		if (!r5_core->tcm_banks) {
> > > +			ret = -ENOMEM;
> > > +			goto fail_tcm;
> > > +		}
> > > +
> > > +		r5_core->tcm_bank_count = tcm_bank_count;
> > > +		for (j = 0; j < tcm_bank_count; j++) {
> > > +			tcm = kzalloc(sizeof(struct mem_bank_data *), GFP_KERNEL);
> > > +			if (!tcm) {
> > > +				ret = -ENOMEM;
> > > +				goto fail_tcm;
> > > +			}
> > > +
> > > +			r5_core->tcm_banks[j] = tcm;
> > > +			/* get tcm address without translation */
> > > +			ret = of_property_read_reg(np, j, &abs_addr, &size);
> > > +			if (ret) {
> > > +				dev_err(dev, "failed to get reg property\n");
> > > +				goto fail_tcm;
> > > +			}
> > > +
> > > +			/*
> > > +			 * remote processor can address only 32 bits
> > > +			 * so convert 64-bits into 32-bits. This will discard
> > > +			 * any unwanted upper 32-bits.
> > > +			 */
> > > +			tcm->da = (u32)abs_addr;
> > > +			tcm->size = (u32)size;
> > > +
> > > +			cpdev = to_platform_device(dev);
> > > +			res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
> > > +			if (!res) {
> > > +				dev_err(dev, "failed to get tcm resource\n");
> > > +				ret = -EINVAL;
> > > +				goto fail_tcm;
> > > +			}
> > > +
> > > +			tcm->addr = (u32)res->start;
> > > +			res = devm_request_mem_region(dev, tcm->addr, tcm->size, res->name);
> > > +			if (!res) {
> > > +				dev_err(dev, "failed to request tcm resource\n");
> > > +				ret = -EINVAL;
> > > +				goto fail_tcm;
> > > +			}
> > > +
> > > +			memcpy(tcm->bank_name, res->name, ARRAY_SIZE(tcm->bank_name));
> > > +			np = of_node_get(dev_of_node(dev));
> > > +			/*
> > > +			 * In dt power-domains are described in this order:
> > > +			 * <RPU core>, <atcm>,  <btcm>
> > > +			 * parse power domains for tcm accordingly
> > > +			 */
> > > +			of_parse_phandle_with_args(np, "power-domains",
> > > +						   "#power-domain-cells",
> > > +						   j + 1, &out_arg);
> > > +			tcm->pm_domain_id = out_arg.args[0];
> > > +			of_node_put(out_arg.np);
> > > +
> > > +			dev_dbg(dev, "TCM: %s, dma=0x%x, da=0x%x, size=0x%x\n",
> > > +				tcm->bank_name, tcm->addr, tcm->da, tcm->size);
> > > +			dev_dbg(dev, "tcm pm domain id %d\n", tcm->pm_domain_id);
> > > +
> > > +			if (cluster->mode == SPLIT_MODE)
> > > +				continue;
> > > +
> > > +			/* Turn on core-1's TCM as well */
> > > +			np1 = of_get_next_child(dev_of_node(cluster->dev),
> > > +						r5_core->np);
> > > +			if (!np1) {
> > > +				of_node_put(np1);
> > > +				np1 = NULL;
> > > +				goto fail_tcm;
> > > +			}
> > > +
> > > +			of_parse_phandle_with_args(np1, "power-domains",
> > > +						   "#power-domain-cells",
> > > +						   j + 1, &out_arg);
> > > +			tcm->pm_domain_id2 = out_arg.args[0];
> > > +			of_node_put(out_arg.np);
> > > +			dev_dbg(dev, "tcm pm domain id %d\n", tcm->pm_domain_id2);
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +fail_tcm:
> > > +	while (i >= 0) {
> > > +		r5_core = cluster->r5_cores[i];
> > > +		for (j = 0; j < r5_core->tcm_bank_count; j++) {
> > > +			if (!r5_core->tcm_banks)
> > > +				continue;
> > > +			tcm = r5_core->tcm_banks[j];
> > > +			kfree(tcm);
> > > +		}
> > > +		kfree(r5_core->tcm_banks);
> > > +		i--;
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  /**
> > >   * zynqmp_r5_get_tcm_node()
> > >   * Ideally this function should parse tcm node and store information
> > > @@ -895,12 +1035,20 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> > >   */
> > >  static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
> > >  {
> > > +	const struct mem_bank_data *zynqmp_tcm_banks;
> > >  	struct device *dev = cluster->dev;
> > >  	struct zynqmp_r5_core *r5_core;
> > >  	int tcm_bank_count, tcm_node;
> > >  	int i, j;
> > >  
> > > -	tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks);
> > > +	if (cluster->mode == SPLIT_MODE) {
> > > +		zynqmp_tcm_banks = zynqmp_tcm_banks_split;
> > > +		tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks_split);
> > > +	} else {
> > > +		zynqmp_tcm_banks = zynqmp_tcm_banks_lockstep;
> > > +		tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks_lockstep);
> > > +	}
> >
> > Why are the changes to get TCM bank information from the DT and enhancement to
> > support lockstep mode in the same patch?
> 
> Actually TCM in lockstep mode was supported before as well. It's just I was using same table in lockstep mode before.
> 
> However, now I am having two tables for split mode and lockstep mode.
> 
> I had to do this as I have introduced "da" field in "struct mem_bank_data" object.  This makes it easy to process
> 
> "device address" derived from device-tree.
> 
> And as I have introduced "u32 da", I had to modify table as well and remove hardcoding of "da" calculation in "tcm_mem_map" function.
> 
> As all of this is connected, I have them in same patch. No new functionality is added, but just code refactoring.
> 
> > > +
> > >  
> > >  	/* count per core tcm banks */
> > >  	tcm_bank_count = tcm_bank_count / cluster->core_count;
> > > @@ -951,10 +1099,25 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
> > >  			       enum rpu_tcm_comb tcm_mode)
> > >  {
> > >  	struct device *dev = cluster->dev;
> > > +	struct device_node *np;
> > >  	struct zynqmp_r5_core *r5_core;
> > >  	int ret, i;
> > >  
> > > -	ret = zynqmp_r5_get_tcm_node(cluster);
> > > +	/*
> > > +	 * try to get tcm nodes from dt but if fail, use hardcode addresses only
> > > +	 * for zynqmp platform. New platforms must use dt bindings for TCM.
> > > +	 */
> > > +	ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
> > > +	if (ret) {
> > > +		np = of_get_compatible_child(dev_of_node(dev), "xlnx,zynqmp-r5f");
> > > +		if (np) {
> >
> > Why was this check added?
> 
> We want to maintain backward compatibility with previous bindings only for zynqmp platform.
> 

That check has nothing to do with backward compatibility.

> So, hardcode table is used only for "zynqmp" platform if getting "reg" information from device-tree fails.
> 
> If node is not compatible with "xlnx,zynqmp-r5f" then it is new platform and we must not use hardcode
> 
> table instead we should fail.
> 

So this is the real reason for the check, but zynqmp-r5f is still the only
platform supported by this driver.  Please remove and re-introduce if/when a new
platform is added.

> 
> > So far there are too many unanswered questions with this patchset and as such I
> > will stop here.
> 
> No problem. Please let me know if you have any further questions.
> 
> 
> > Mathieu
> >
> > > +			ret = zynqmp_r5_get_tcm_node(cluster);
> > > +		} else {
> > > +			dev_err(dev, "tcm not found\n");
> > > +			return -EINVAL;
> > > +		}
> > > +	}
> > > +
> > >  	if (ret < 0) {
> > >  		dev_err(dev, "can't get tcm node, err %d\n", ret);
> > >  		return ret;
> > > -- 
> > > 2.25.1
> > > 
