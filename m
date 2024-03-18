Return-Path: <linux-kernel+bounces-106028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A99B87E7DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA46E28248A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EA9364DF;
	Mon, 18 Mar 2024 10:59:11 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3BD364A9;
	Mon, 18 Mar 2024 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759551; cv=none; b=hqf7Kyp8dq/wu7Hl1UVm+zwFcVtMBhshlQ6skjpYSHIs235hObzmnQkVM0Vtg854kEIDGG3V8MvFCFnePaRsFo/HponiXR+I4uaBmw+Ts2P6eyD1xsxqdS763XJsy8o8nilUdyov4blOP+g3WIQ3FIGGHTy/879XjjdmZD2yaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759551; c=relaxed/simple;
	bh=3HWVhv5FCQZGsoqeZ8uU7NkyNl7/wt+/4DunrTQoGyg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhGdeaUraBlv/iAUK7Aods/Iss3d26GZz9BM2VzQGJQEDZd+/bAvTRonoNH4zC5U56L6g7hyghiiLBhlB7cAKzDS8yanVjj6h5NVtKQIIdoMT9aEueAvvB9XdwUEbKT+/+hZvuMLNpikrdgwarryMPN3xAdYwh1hqh2mBY3gryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TysKR39Y6z6K6Pg;
	Mon, 18 Mar 2024 18:58:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E181E14322E;
	Mon, 18 Mar 2024 18:59:00 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Mar
 2024 10:57:48 +0000
Date: Mon, 18 Mar 2024 10:57:48 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<qemu-devel@nongnu.org>, <chenbaozi@phytium.com.cn>
Subject: Re: [PATCH v2 1/1] cxl/mem: Fix for the index of Clear Event Record
 Handle
Message-ID: <20240318105748.000072c5@Huawei.com>
In-Reply-To: <20240318022928.509130-2-wangyuquan1236@phytium.com.cn>
References: <20240318022928.509130-1-wangyuquan1236@phytium.com.cn>
	<20240318022928.509130-2-wangyuquan1236@phytium.com.cn>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 18 Mar 2024 10:29:28 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> The dev_dbg info for Clear Event Records mailbox command would report
> the handle of the next record to clear not the current one.
> 
> This was because the index 'i' had incremented before printing the
> current handle value.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>  drivers/cxl/core/mbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9adda4795eb7..b810a6aa3010 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -915,7 +915,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  
>  		payload->handles[i++] = gen->hdr.handle;
>  		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
> -			le16_to_cpu(payload->handles[i]));
> +			le16_to_cpu(payload->handles[i-1]));
Trivial but needs spaces around the -. e.g.  [i - 1] 

Maybe Dan can fix up whilst applying.

Otherwise

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>  
>  		if (i == max_handles) {
>  			payload->nr_recs = i;


