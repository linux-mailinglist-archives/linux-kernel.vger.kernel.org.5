Return-Path: <linux-kernel+bounces-73086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB56485BD64
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A09B1C22C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625146BB35;
	Tue, 20 Feb 2024 13:40:06 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25BF6A335;
	Tue, 20 Feb 2024 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436405; cv=none; b=FnXPsr5mZALH14OjFSUsCF32tniNV0KS7DeLzWgYAOf3bCBIL1jq1BP9j3r1qYdb3blcQ3Zoi/xjNbNVuT2WmhLOrI59IO4wj84jfNIehsb+jWctKPqqj0rwY9r2oFS+n2nbPgcJwONSmZ1q8uyPYt2C6tYN4BY/kWvUC+RyOqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436405; c=relaxed/simple;
	bh=RqyAecBz4gdatYyS0Gw9MFoRwVagHCuhZhoMcCO0x84=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSn2pTtFAalxb/N/mrUgCoIs7WRmAzupE3DQ8jbvabOV4sh/Tx5y7pgl3sDRBDqyNTnO9QoiFpFuhoVwYuIa1kngiomzAv1jHNIiTMjt5cnzr81j8wAPFH5bjcYTGN85V1Zxx/RH2b5SEKTVAHvh0jdgXtiqFOBIWQyMG7h2pTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TfL5y4085z6K7MC;
	Tue, 20 Feb 2024 21:36:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C2E7140C72;
	Tue, 20 Feb 2024 21:39:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 13:39:56 +0000
Date: Tue, 20 Feb 2024 13:39:55 +0000
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
Subject: Re: [RFC PATCH v6 08/12] cxl/memscrub: Register CXL device ECS with
 scrub configure driver
Message-ID: <20240220133955.0000710b@Huawei.com>
In-Reply-To: <20240215111455.1462-9-shiju.jose@huawei.com>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
	<20240215111455.1462-9-shiju.jose@huawei.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Feb 2024 19:14:50 +0800
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Register with the scrub configure driver to expose the sysfs attributes
> to the user for configuring the CXL memory device's ECS feature.
> Add the static CXL ECS specific attributes to support configuring the
> CXL memory device ECS feature.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

The ABI in here needs documentation.  My key takeaway is that
it is very ECS specific.  I think one of the big challenges of a common scrub
control system is going to be trying to come up with some meaningful 
common ABI.

> ---
>  drivers/cxl/core/memscrub.c | 253 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 250 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
> index a1fb40f8307f..325084b22e7a 100644
> --- a/drivers/cxl/core/memscrub.c
> +++ b/drivers/cxl/core/memscrub.c
> @@ -464,6 +464,8 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_patrol_scrub_init, CXL);
>  #define CXL_MEMDEV_ECS_GET_FEAT_VERSION	0x01
>  #define CXL_MEMDEV_ECS_SET_FEAT_VERSION	0x01
>  
> +#define CXL_DDR5_ECS	"cxl_ecs"
I would just put these name defines inline.

> +enum cxl_mem_ecs_scrub_attributes {
> +	cxl_ecs_log_entry_type,
> +	cxl_ecs_log_entry_type_per_dram,
> +	cxl_ecs_log_entry_type_per_memory_media,
> +	cxl_ecs_mode,
> +	cxl_ecs_mode_counts_codewords,
> +	cxl_ecs_mode_counts_rows,
> +	cxl_ecs_reset,
> +	cxl_ecs_threshold,
> +	cxl_ecs_threshold_available,
> +	cxl_ecs_max_attrs,
This is pretty much all custom ABI.  Challenging to make it common with
the main scrub and RASF controls, but I think we do need to see if we can
come up with something that is at least vaguely consistent across
different forms of scrub control.

What the user cares about is how likely an error is to get past the
scrubbing that is running (I think - RAS folk speak up if I have
this wrong!)

So how do we go from the ECS parameters to that sort of info?
I think ECS is effectively scrubbing at a fixed rate (google suggests
all ram every 24 hours).  We are really controlling what info is
reported rather than what scrub is carried out.

Useful stuff to potentially control but different from the
other cases.


> +};

> +
>  int cxl_mem_ecs_init(struct cxl_memdev *cxlmd, int region_id)
>  {
> +	char scrub_name[CXL_MEMDEV_MAX_NAME_LENGTH];
>  	struct cxl_mbox_supp_feat_entry feat_entry;
>  	struct cxl_ecs_context *cxl_ecs_ctx;
> +	struct device *cxl_scrub_dev;

Make this more local as we don't need it out here?

>  	int nmedia_frus;
>  	int ret;
>  
> @@ -755,6 +993,15 @@ int cxl_mem_ecs_init(struct cxl_memdev *cxlmd, int region_id)
>  		cxl_ecs_ctx->get_feat_size = feat_entry.get_feat_size;
>  		cxl_ecs_ctx->set_feat_size = feat_entry.set_feat_size;
>  		cxl_ecs_ctx->region_id = region_id;
> +
> +		snprintf(scrub_name, sizeof(scrub_name), "%s_%s_region%d",
> +			 CXL_DDR5_ECS, dev_name(&cxlmd->dev), cxl_ecs_ctx->region_id);
> +		cxl_scrub_dev = devm_scrub_device_register(&cxlmd->dev, scrub_name,
> +							  cxl_ecs_ctx, NULL,
> +							  cxl_ecs_ctx->region_id,
> +							  &cxl_mem_ecs_attr_group);
> +		if (IS_ERR(cxl_scrub_dev))
> +			return PTR_ERR(cxl_scrub_dev);
>  	}
>  
>  	return 0;


