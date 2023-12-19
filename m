Return-Path: <linux-kernel+bounces-5485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE67C818B39
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E8D28166D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AB71CA80;
	Tue, 19 Dec 2023 15:27:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F211CA83;
	Tue, 19 Dec 2023 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SvgWG1tStz6K8vt;
	Tue, 19 Dec 2023 23:25:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 064A0140F80;
	Tue, 19 Dec 2023 23:27:30 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Dec
 2023 15:27:28 +0000
Date: Tue, 19 Dec 2023 15:27:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Vishal Verma <vishal.l.verma@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Oscar
 Salvador" <osalvador@suse.de>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>, David Hildenbrand
	<david@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Huang Ying
	<ying.huang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-mm@kvack.org>, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v6 2/4] dax/bus: Use guard(device) in sysfs attribute
 helpers
Message-ID: <20231219152726.0000228f@Huawei.com>
In-Reply-To: <20231214-vv-dax_abi-v6-2-ad900d698438@intel.com>
References: <20231214-vv-dax_abi-v6-0-ad900d698438@intel.com>
	<20231214-vv-dax_abi-v6-2-ad900d698438@intel.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 14 Dec 2023 22:25:27 -0700
Vishal Verma <vishal.l.verma@intel.com> wrote:

> Use the guard(device) macro to lock a 'struct device', and unlock it
> automatically when going out of scope using Scope Based Resource
> Management semantics. A lot of the sysfs attribute writes in
> drivers/dax/bus.c benefit from a cleanup using these, so change these
> where applicable.
> 
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Hi Vishal,

A few really minor suggestions inline if you happen to be doing a v7.
Either way
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>  
> @@ -481,12 +466,9 @@ static int __free_dev_dax_id(struct dev_dax *dev_dax)
>  static int free_dev_dax_id(struct dev_dax *dev_dax)
>  {
>  	struct device *dev = &dev_dax->dev;
> -	int rc;
>  
> -	device_lock(dev);
> -	rc = __free_dev_dax_id(dev_dax);
> -	device_unlock(dev);
> -	return rc;
> +	guard(device)(dev);

	guard(device)(&dev_dax->dev); /* Only one user now */
	
> +	return __free_dev_dax_id(dev_dax);
>  }
>  
>  static int alloc_dev_dax_id(struct dev_dax *dev_dax)
> @@ -908,9 +890,8 @@ static ssize_t size_show(struct device *dev,
>  	struct dev_dax *dev_dax = to_dev_dax(dev);
>  	unsigned long long size;
>  
> -	device_lock(dev);
> +	guard(device)(dev);
>  	size = dev_dax_size(dev_dax);
> -	device_unlock(dev);
>  
>  	return sprintf(buf, "%llu\n", size);
Might as well make this

	guard(device)(dev);
	return sprintf(buf, "%llu\n", dev_dax_size(to_dev_dax(dev));

>  }





