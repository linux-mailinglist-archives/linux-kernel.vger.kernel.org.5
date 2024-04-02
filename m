Return-Path: <linux-kernel+bounces-128168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E30B8957CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FCCCB24D93
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B4A12BF27;
	Tue,  2 Apr 2024 14:39:07 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE94C12BF18;
	Tue,  2 Apr 2024 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068746; cv=none; b=KClQK4OLCtYxvH65Cebvp//fHCqys0pzYmFcI4w4/uEew+ZYKzL8GKtkh4P34abhvvtoRhcS+nTJtJBz9WkqW+Wl6Ai9oHHJSEscj7r10MR9bLDVZ3uy6HTQaaoq3s0ly9mozZBHfvGnkWeZats+oxq/r2pcHmlPMDouyQeRQaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068746; c=relaxed/simple;
	bh=UPhLYCHOSLLk3iAmzlBIGKnovteeEy0D7raJ7FQTrgU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwZD3TCnFImi2CMqKXY9GiqhsrT4wmW5c5SUD2u6eWU4GZE7aB2iks3zlgNj/Med81VaTJV/rHdF2vm+XUQ8GF1JlkxtwNLuLLHl8hA2mHNFLgvGV9bXAes3mVgyK7VolG9hj2iYjWCTycHAByc0h02Gd+RwoeazuYmsn/ApXgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V89TQ3pbbz6G9Pm;
	Tue,  2 Apr 2024 22:37:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EE130140518;
	Tue,  2 Apr 2024 22:38:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 2 Apr
 2024 15:38:59 +0100
Date: Tue, 2 Apr 2024 15:38:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Kwangjin Ko <kwangjin.ko@sk.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel_team@skhynix.com>
Subject: Re: [PATCH v2 1/1] cxl/core: Fix initialization of
 mbox_cmd.size_out in get event
Message-ID: <20240402153858.00007ce3@Huawei.com>
In-Reply-To: <20240402081404.1106-2-kwangjin.ko@sk.com>
References: <20240402081404.1106-1-kwangjin.ko@sk.com>
	<20240402081404.1106-2-kwangjin.ko@sk.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 2 Apr 2024 17:14:03 +0900
Kwangjin Ko <kwangjin.ko@sk.com> wrote:

> Since mbox_cmd.size_out is overwritten with the actual output size in
> the function below, it needs to be initialized every time.
> 
> cxl_internal_send_cmd -> __cxl_pci_mbox_send_cmd
> 
> Problem scenario:
> 
> 1) The size_out variable is initially set to the size of the mailbox.
> 2) Read an event.
>    - size_out is set to 160 bytes(header 32B + one event 128B).
>    - Two event are created while reading.
> 3) Read the new *two* events.
>    - size_out is still set to 160 bytes.
>    - Although the value of out_len is 288 bytes, only 160 bytes are
>      copied from the mailbox register to the local variable.
>    - record_count is set to 2.
>    - Accessing records[1] will result in reading incorrect data.
> 
> Signed-off-by: Kwangjin Ko <kwangjin.ko@sk.com>

Looks correct to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9adda4795eb7..a38531a055c8 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -958,13 +958,14 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  		.payload_in = &log_type,
>  		.size_in = sizeof(log_type),
>  		.payload_out = payload,
> -		.size_out = mds->payload_size,
>  		.min_out = struct_size(payload, records, 0),
>  	};
>  
>  	do {
>  		int rc, i;
>  
> +		mbox_cmd.size_out = mds->payload_size;
> +
>  		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>  		if (rc) {
>  			dev_err_ratelimited(dev,


