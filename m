Return-Path: <linux-kernel+bounces-73035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3705085BC6F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0931F243C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9700E6996E;
	Tue, 20 Feb 2024 12:43:26 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD6067E63;
	Tue, 20 Feb 2024 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708433006; cv=none; b=DYKoz/eP6W78VQJ8VpNOqnrCiFvsR3xaGgRjIdzRXe6y/ecR1mfJ5PWNnuEZfp5zY2GsXOOdJGxsuSU7eKOLhu6XV/VwuyPiPX6H7yVUstx0Hgh5yKI/qxtOHl027XRe0fp6k63WEIoKUZAHfNDaeonG8/ftMZNf/pkRLOBHj0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708433006; c=relaxed/simple;
	bh=2FEiZFwWmcbhWJlWx8Ag758ea764HjGaW8MolDwpGGU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSgJAJmqYQmlcJFwlaastr9u4WGrhTItIC33/RlsEalNlKqEnTILMKdmtsLoZuw7sMpACC5YkxqImEQgk04sgukXZ/ALYrM8fpMu/Su7TmcAH2Up9bnHsPYTdvIUAg7q0lBmJ6Q1qi16QIhxLRYeOaH9tk6j1SDKkpRUnRgKUYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TfJqr1qWVz6D94n;
	Tue, 20 Feb 2024 20:39:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 26DA0140C98;
	Tue, 20 Feb 2024 20:43:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 12:43:20 +0000
Date: Tue, 20 Feb 2024 12:43:19 +0000
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
Subject: Re: [RFC PATCH v6 07/12] cxl/memscrub: Register CXL device patrol
 scrub with scrub configure driver
Message-ID: <20240220124319.00005be0@Huawei.com>
In-Reply-To: <20240215111455.1462-8-shiju.jose@huawei.com>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
	<20240215111455.1462-8-shiju.jose@huawei.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Feb 2024 19:14:49 +0800
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Register with the scrub configure driver to expose the sysfs attributes
> to the user for configuring the CXL device memory patrol scrub. Add the
> callback functions to support configuring the CXL memory device patrol
> scrub.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Trivial comment inline.

> diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
> index a3a371c5aa7b..a1fb40f8307f 100644
> --- a/drivers/cxl/core/memscrub.c
> +++ b/drivers/cxl/core/memscrub.c
> @@ -6,14 +6,19 @@

> +
> +/**
> + * cxl_mem_patrol_scrub_is_visible() - Callback to return attribute visibility
> + * @dev: Pointer to scrub device
> + * @attr: Scrub attribute
> + * @region_id: ID of the memory region
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +static umode_t cxl_mem_patrol_scrub_is_visible(struct device *dev,
> +					       u32 attr_id, int region_id)
> +{
> +	const struct cxl_patrol_scrub_context *cxl_ps_ctx = dev_get_drvdata(dev);
> +
> +	if (attr_id == scrub_rate_available ||
> +	    attr_id == scrub_rate) {
> +		if (!cxl_ps_ctx->scrub_cycle_changeable)
> +			return 0;
> +	}
> +
> +	switch (attr_id) {
> +	case scrub_rate_available:
> +		return 0444;

Usual trick on these is to write back their default values if we support them.
If we can make this function take that as well then this bcomes
return mode; 
for all those supported.


> +	case scrub_enable:
> +	case scrub_rate:
> +		return 0644;
> +	default:
> +		return 0;
> +	}
> +}
> +


