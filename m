Return-Path: <linux-kernel+bounces-164413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4878E8B7D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4331F23023
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C18176FA8;
	Tue, 30 Apr 2024 16:45:48 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB8112C7FA;
	Tue, 30 Apr 2024 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495548; cv=none; b=KvNjd+4kuSbvpj/8WKGqH6W212v80hakT2XIQHGEtXyD2CcMArPhXEkrvkhPT1oV0PZWi9jGR4rkgPtPawGNjELCxSRXsVEe5xvRWloyEX14Ju6Ze6onh6zrL7e1JmIHd21rXzC4dG2wcDDYdLNm9NZkDAOTyMigs8RD4dtgeg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495548; c=relaxed/simple;
	bh=mfIY6Gne2tgJLNjHJkomMG8UMLhVXGCkif1Z7JBkoBs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WtHymQVfPZw5Mo4cois1PmIUfaz2srDAX8lhe/n9MclncN/NCunbOJvGpZqmjqL/NVi95inHUFjz1WqsppVWG80op+XavLKWtWIOy6TWizCs4kwuYcL211o26pha2iK012zrAUEXb2fUof8YTjddWeQf2Vx3JIfLe1Y6WkxAIqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTQx11kDYz6J6dN;
	Wed,  1 May 2024 00:43:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CF17140CF4;
	Wed,  1 May 2024 00:45:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 17:45:41 +0100
Date: Tue, 30 Apr 2024 17:45:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Li Zhijian <lizhijian@fujitsu.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix cxlr_pmem leaks
Message-ID: <20240430174540.000039ce@Huawei.com>
In-Reply-To: <20240428030748.318985-1-lizhijian@fujitsu.com>
References: <20240428030748.318985-1-lizhijian@fujitsu.com>
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

On Sun, 28 Apr 2024 11:07:48 +0800
Li Zhijian <lizhijian@fujitsu.com> wrote:

> Before this error path, cxlr_pmem pointed to a kzalloc() memory, free
> it to avoid this memory leaking.
> 
> Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Fix is good, but this looks like nice case for conversion to cleanup.h stuff
perhaps better to just do that?  Would need a small amount of dancing
on the final return to return cxlr->cxlr_pmem + pointer steal
when setting cxlr->cxlr_pmem a few lines up.

Also guard for the rwsem.

Dave, Dan, worth doing or take this minimal fix and spin around later?

If you think this is the way to go.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c186e0a39b9..812b2948b6c6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2719,6 +2719,7 @@ static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
>  		if (i == 0) {
>  			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd);
>  			if (!cxl_nvb) {
> +				kfree(cxlr_pmem);
>  				cxlr_pmem = ERR_PTR(-ENODEV);
>  				goto out;
>  			}


