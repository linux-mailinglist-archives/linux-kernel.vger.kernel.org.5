Return-Path: <linux-kernel+bounces-72995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA9885BBB5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F541F22312
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5999B67E75;
	Tue, 20 Feb 2024 12:17:59 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793BA67C6A;
	Tue, 20 Feb 2024 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431478; cv=none; b=tOokqXlwA7ScLXMuxYa30ZsS3oC8fBAj4Z0PMpcmhf394HRDH/Mppv2JY1UnY6Sm/Mf4Mq+gzwznCYV3yeneZKlWKeNVaNLQPy7Ysdjg9cfRI4JZdwDz/UVUAQJGrutTH39h6lx45rCq0mppOznme7t+BrlEK2SiChJD4ndFDVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431478; c=relaxed/simple;
	bh=Tq6DUkyR5imvfkPUHcyhI5W4vjhP5+FiFbG7Al6XCko=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaQqY2ahFh68q8fnR0yNZeVtf7eXUEs9nkTfgaWwvBuI4viUByBY2Vvbmn77U9zSBWKAnhjKJ6upbUbQVuv5Bo97spqidrv7JuE0P9ulfA2MIf1SEyq4tYqwWnCHXyxgdhnj6UJGzFi6u26Mo+/VLg1OTAGcIZpz7QbvRiobRrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TfJHF1KWsz6K98Z;
	Tue, 20 Feb 2024 20:14:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BDBD4140B30;
	Tue, 20 Feb 2024 20:17:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 12:17:50 +0000
Date: Tue, 20 Feb 2024 12:17:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>
Subject: Re: [RFC PATCH v6 05/12] cxl/memscrub: Add CXL device ECS control
 feature
Message-ID: <20240220121749.00000d27@Huawei.com>
In-Reply-To: <20240215111455.1462-6-shiju.jose@huawei.com>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
	<20240215111455.1462-6-shiju.jose@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Feb 2024 19:14:47 +0800
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check
> Scrub (ECS) control feature.
> 
> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
> Specification (JESD79-5) and allows the DRAM to internally read, correct
> single-bit errors, and write back corrected data bits to the DRAM array
> while providing transparency to error counts. The ECS control feature
> allows the request to configure ECS input configurations during system
> boot or at run-time.
> 
> The ECS control allows the requester to change the log entry type, the ECS
> threshold count provided that the request is within the definition
> specified in DDR5 mode registers, change mode between codeword mode and
> row count mode, and reset the ECS counter.
> 
> Open Question:
> Is cxl_mem_ecs_init() invoked in the right function in cxl/core/region.c?
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Hi Shiju,

I'd missed the placement of declarations with __free in the previous code.
For these general agreement is just put the declaration where if is first
assigned. 2 reasons:
1) Makes it obvious right unwind is being provided.
2) Avoids ordering issues as cleanup entries run in reverse order when we
   leave the scope.  There aren't problems with that here, but we want
   to make it as easy as possible for reviewers to see that.

> +/* CXL DDR5 ECS control functions */
> +static int cxl_mem_ecs_get_attrs(struct device *dev, int fru_id,
> +				 struct cxl_memdev_ecs_params *params)
> +{
> +	struct cxl_memdev_ecs_feat_read_attrs *rd_attrs __free(kvfree) = NULL;
See below.

> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev->parent);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_mbox_get_feat_in pi = {
> +		.uuid = cxl_ecs_uuid,
> +		.offset = 0,
> +		.selection = CXL_GET_FEAT_SEL_CURRENT_VALUE,
> +	};
> +	struct cxl_ecs_context *cxl_ecs_ctx;
> +	u8 threshold_index;
> +	int ret;
> +
> +	if (!mds)
> +		return -EFAULT;
> +	cxl_ecs_ctx = dev_get_drvdata(dev);
> +
> +	pi.count = cxl_ecs_ctx->get_feat_size;
> +	rd_attrs = kvmalloc(pi.count, GFP_KERNEL);
> +	if (!rd_attrs)
> +		return -ENOMEM;
> +
> +	ret = cxl_get_feature(mds, &pi, rd_attrs);
> +	if (ret) {
> +		params->log_entry_type = 0;
> +		params->threshold = 0;
As in previous, I'd expect this to be side effect free so leave these alone.

> +		params->mode = 0;
> +		return ret;
> +	}
> +	params->log_entry_type = FIELD_GET(CXL_MEMDEV_ECS_LOG_ENTRY_TYPE_MASK,
> +					   rd_attrs[fru_id].ecs_log_cap);
> +	threshold_index = FIELD_GET(CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
> +				    rd_attrs[fru_id].ecs_config);
> +	params->threshold = ecs_supp_threshold[threshold_index];
> +	params->mode = FIELD_GET(CXL_MEMDEV_ECS_MODE_MASK,
> +				 rd_attrs[fru_id].ecs_config);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused
> +cxl_mem_ecs_set_attrs(struct device *dev, int fru_id,
> +		      struct cxl_memdev_ecs_params *params, u8 param_type)
> +{
> +	struct cxl_memdev_ecs_feat_read_attrs *rd_attrs __free(kvfree) = NULL;
> +	struct cxl_memdev_ecs_set_feat_pi *set_pi __free(kvfree) = NULL;

Linus Torvalds is very much against this pattern for __free.
The declaration should be at the point of allocation.

> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev->parent);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_mbox_get_feat_in pi = {
> +		.uuid = cxl_ecs_uuid,
> +		.offset = 0,
> +		.selection = CXL_GET_FEAT_SEL_CURRENT_VALUE,
> +	};
> +	struct cxl_memdev_ecs_feat_wr_attrs *wr_attrs;
> +	struct cxl_memdev_ecs_params rd_params;
> +	struct cxl_ecs_context *cxl_ecs_ctx;
> +	u16 nmedia_frus, count;
> +	u32 set_pi_size;
> +	int ret;
> +
> +	if (!mds)
> +		return -EFAULT;
> +
> +	cxl_ecs_ctx = dev_get_drvdata(dev);

I'm not sure exactly which dev this is, but using drvdata
probably not appropriate here.  Embed the struct in the memdev.

> +	nmedia_frus = cxl_ecs_ctx->nregions;
> +
Have this here and similar cases.

	stuct cxl_memdev_ecs_feat_read_attrs *rd_attrs __free(kvfree) =
		kvmalloc();

Though some of these are small and if they are just use malloc() and
kfree.

> +	rd_attrs = kvmalloc(cxl_ecs_ctx->get_feat_size, GFP_KERNEL);
> +	if (!rd_attrs)
> +		return -ENOMEM;
> +
> +	pi.count = cxl_ecs_ctx->get_feat_size;
> +	ret = cxl_get_feature(mds, &pi, rd_attrs);
> +	if (ret)
> +		return ret;
> +	set_pi_size = sizeof(struct cxl_mbox_set_feat_in) +
> +				cxl_ecs_ctx->set_feat_size;
> +	set_pi = kvmalloc(set_pi_size, GFP_KERNEL);
As aboe. Drag the declaration and free logic down here.

> +	if (!set_pi)
> +		return -ENOMEM;
> +
> +	set_pi->pi.uuid = cxl_ecs_uuid;
> +	set_pi->pi.flags = CXL_SET_FEAT_FLAG_MOD_VALUE_SAVED_ACROSS_RESET |
> +				CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER;
> +	set_pi->pi.offset = 0;
> +	set_pi->pi.version = CXL_MEMDEV_ECS_SET_FEAT_VERSION;
> +	/* Fill writable attributes from the current attributes read for all the media FRUs */
> +	wr_attrs = set_pi->wr_attrs;
> +	for (count = 0; count < nmedia_frus; count++) {
> +		wr_attrs[count].ecs_log_cap = rd_attrs[count].ecs_log_cap;
> +		wr_attrs[count].ecs_config = rd_attrs[count].ecs_config;
> +	}
> +
> +	/* Fill attribute to be set for the media FRU */
> +	switch (param_type) {
> +	case CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE:
> +		if (params->log_entry_type != ECS_LOG_ENTRY_TYPE_DRAM &&
> +		    params->log_entry_type != ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU) {
> +			dev_err(dev->parent,
> +				"Invalid CXL ECS scrub log entry type(%d) to set\n",
> +			       params->log_entry_type);
> +			dev_err(dev->parent,
> +				"Log Entry Type 0: per DRAM  1: per Memory Media FRU\n");
> +			return -EINVAL;
> +		}
> +		wr_attrs[fru_id].ecs_log_cap = FIELD_PREP(CXL_MEMDEV_ECS_LOG_ENTRY_TYPE_MASK,
> +							  params->log_entry_type);
> +		break;
> +	case CXL_MEMDEV_ECS_PARAM_THRESHOLD:
> +		wr_attrs[fru_id].ecs_config &= ~CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK;
> +		switch (params->threshold) {
> +		case 256:
> +			wr_attrs[fru_id].ecs_config |= FIELD_PREP(
> +						CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
> +						ECS_THRESHOLD_256);
> +			break;
> +		case 1024:
> +			wr_attrs[fru_id].ecs_config |= FIELD_PREP(
> +						CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
> +						ECS_THRESHOLD_1024);
> +			break;
> +		case 4096:
> +			wr_attrs[fru_id].ecs_config |= FIELD_PREP(
> +						CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
> +						ECS_THRESHOLD_4096);
> +			break;
> +		default:
> +			dev_err(dev->parent,
> +				"Invalid CXL ECS scrub threshold count(%d) to set\n",
> +				params->threshold);
> +			dev_err(dev->parent,
> +				"Supported scrub threshold count: 256,1024,4096\n");
> +			return -EINVAL;
> +		}
> +		break;
> +	case CXL_MEMDEV_ECS_PARAM_MODE:
> +		if (params->mode != ECS_MODE_COUNTS_ROWS &&
> +		    params->mode != ECS_MODE_COUNTS_CODEWORDS) {
> +			dev_err(dev->parent,
> +				"Invalid CXL ECS scrub mode(%d) to set\n",
> +				params->mode);
> +			dev_err(dev->parent,
> +				"Mode 0: ECS counts rows with errors"
> +				" 1: ECS counts codewords with errors\n");
> +			return -EINVAL;
> +		}
> +		wr_attrs[fru_id].ecs_config &= ~CXL_MEMDEV_ECS_MODE_MASK;
> +		wr_attrs[fru_id].ecs_config |= FIELD_PREP(CXL_MEMDEV_ECS_MODE_MASK,
> +							  params->mode);
> +		break;
> +	case CXL_MEMDEV_ECS_PARAM_RESET_COUNTER:
> +		wr_attrs[fru_id].ecs_config &= ~CXL_MEMDEV_ECS_RESET_COUNTER_MASK;
> +		wr_attrs[fru_id].ecs_config |= FIELD_PREP(CXL_MEMDEV_ECS_RESET_COUNTER_MASK,
> +							  params->reset_counter);
> +		break;
> +	default:
> +		dev_err(dev->parent, "Invalid CXL ECS parameter to set\n");
> +		return -EINVAL;
> +	}
> +	ret = cxl_set_feature(mds, set_pi, set_pi_size);
> +	if (ret) {
> +		dev_err(dev->parent, "CXL ECS set feature fail ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Verify attribute is set successfully */
> +	ret = cxl_mem_ecs_get_attrs(dev, fru_id, &rd_params);
> +	if (ret) {
> +		dev_err(dev->parent, "Get cxlmemdev ECS params fail ret=%d\n", ret);
> +		return ret;
> +	}
> +	switch (param_type) {
> +	case CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE:
> +		if (rd_params.log_entry_type != params->log_entry_type)
> +			return -EFAULT;
> +		break;
> +	case CXL_MEMDEV_ECS_PARAM_THRESHOLD:
> +		if (rd_params.threshold != params->threshold)
> +			return -EFAULT;
> +		break;
> +	case CXL_MEMDEV_ECS_PARAM_MODE:
> +		if (rd_params.mode != params->mode)
> +			return -EFAULT;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +int cxl_mem_ecs_init(struct cxl_memdev *cxlmd, int region_id)
> +{
> +	struct cxl_mbox_supp_feat_entry feat_entry;
> +	struct cxl_ecs_context *cxl_ecs_ctx;
> +	int nmedia_frus;
> +	int ret;
> +
> +	ret = cxl_mem_get_supported_feature_entry(cxlmd, &cxl_ecs_uuid, &feat_entry);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!(feat_entry.attr_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
> +		return -ENOTSUPP;
> +	nmedia_frus = feat_entry.get_feat_size/
> +				sizeof(struct cxl_memdev_ecs_feat_read_attrs);
> +	if (nmedia_frus) {

Flip logic and this ends up simpler (don't think this changes much in later patches).

	if (!nmedia_frus)
		return -ENODEV; or similar.

> +		cxl_ecs_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ecs_ctx), GFP_KERNEL);
> +		if (!cxl_ecs_ctx)
> +			return -ENOMEM;
> +
> +		cxl_ecs_ctx->nregions = nmedia_frus;
> +		cxl_ecs_ctx->get_feat_size = feat_entry.get_feat_size;
> +		cxl_ecs_ctx->set_feat_size = feat_entry.set_feat_size;
> +		cxl_ecs_ctx->region_id = region_id;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_ecs_init, CXL);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ce0e2d82bb2b..35b57f0d85fa 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2913,6 +2913,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  			dev_err(&cxlr->dev, "failed to enable, range: %pr\n",
>  				p->res);
>  	}
> +	cxl_mem_ecs_init(cxlmd, atomic_read(&cxlrd->region_id));
Add debug message her eif it fails.

>  
>  	put_device(region_dev);
>  out:
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 7025c4fd66f3..06965ba89085 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -951,9 +951,12 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  /* cxl memory scrub functions */
>  #ifdef CONFIG_CXL_SCRUB
>  int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd);
> +int cxl_mem_ecs_init(struct cxl_memdev *cxlmd, int region_id);
>  #else
>  static inline int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
>  { return -ENOTSUPP; }
> +static inline int cxl_mem_ecs_init(struct cxl_memdev *cxlmd, int region_id)
> +{ return -ENOTSUPP; }

As in previous - don't use this error code.

>  #endif
>  
>  #ifdef CONFIG_CXL_SUSPEND


