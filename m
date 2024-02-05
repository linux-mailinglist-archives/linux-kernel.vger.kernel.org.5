Return-Path: <linux-kernel+bounces-52468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6704A84988F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6247F1C2074D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE30918AEE;
	Mon,  5 Feb 2024 11:11:57 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3E199BE;
	Mon,  5 Feb 2024 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131517; cv=none; b=AkYiJrYbBxMcuCbCLwVlS82SuMi4r/lWgXQCKEXJ8a6C/6pXp8BOxG594sTOtu1ZcD0/ovUZCQY+nythRAZ/h0s61pf1spT9fBNyJl+UQwu+8+EGPWvahGbrSHrblcUwvMoZx7t5NCeTLR2Zz0ApEpvFcqawKNX0OaL0BKRTUMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131517; c=relaxed/simple;
	bh=oEj10EjSR3BOukSIkBzeBzquHeEig0ocCSapGHfIwvw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CN3eBr7OXAJoFzap9p0cvw/XtRlrxH2ej/NVprjEh4GA3X4yDNoXbuwRmo6PrnQUA9V3Lg+qY//p+z1EmYOPyKs//Qg8KBP0MC7j3yA8+jvtBMbWVIIhdBy7vFrIpi2a8WtuPnXA9K/SIRG6dyjNRZpKxvScwFAotxNEXuaBc1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT3XS0n31z67bbM;
	Mon,  5 Feb 2024 19:08:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A18C11404F5;
	Mon,  5 Feb 2024 19:11:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 5 Feb
 2024 11:11:53 +0000
Date: Mon, 5 Feb 2024 11:11:52 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>, Ingo Molnar
	<mingo@kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH 2/2] cxl/region: Use cond_guard() in show_targetN()
Message-ID: <20240205111152.000030a3@Huawei.com>
In-Reply-To: <20240204173105.935612-3-fabio.maria.de.francesco@linux.intel.com>
References: <20240204173105.935612-1-fabio.maria.de.francesco@linux.intel.com>
	<20240204173105.935612-3-fabio.maria.de.francesco@linux.intel.com>
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

On Sun,  4 Feb 2024 18:31:05 +0100
"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com> wrote:

> Use cond_guard() in show_target() to not open code an up_read() in an 'out'
> block. If the down_read_interruptible() fails, the statement passed to the
> second argument of cond_guard() returns -EINTR.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>

LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 0f05692bfec3..bd3236786a25 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -666,28 +666,20 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled;
> -	int rc;
>  
> -	rc = down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> +	cond_guard(rwsem_read_intr, return -EINTR, &cxl_region_rwsem);
>  
>  	if (pos >= p->interleave_ways) {
>  		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
>  			p->interleave_ways);
> -		rc = -ENXIO;
> -		goto out;
> +		return -ENXIO;
>  	}
>  
>  	cxled = p->targets[pos];
>  	if (!cxled)
> -		rc = sysfs_emit(buf, "\n");
> +		return sysfs_emit(buf, "\n");
>  	else
> -		rc = sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
> -out:
> -	up_read(&cxl_region_rwsem);
> -
> -	return rc;
> +		return sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
>  }
>  
>  static int match_free_decoder(struct device *dev, void *data)


