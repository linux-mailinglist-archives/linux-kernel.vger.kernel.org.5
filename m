Return-Path: <linux-kernel+bounces-71348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C36A85A3CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B831F226FC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710CB2E856;
	Mon, 19 Feb 2024 12:51:07 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192892E642;
	Mon, 19 Feb 2024 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347067; cv=none; b=Kd0/wYHRUabZe/vQCtkehlgNb8SlO+TnI5YaaIxDkvje/fFEMvm4NhzgNnDacl+HlElL15MhU5ZyvXxF3LYB9dF2nPuMwfy7oYfMdRzGhz+Y54BnHwqDS3Qv80bgUGe5DYWeZCsXgJ0ftQMxjQMQA2mRSrkF4IjC1RxkJTvEy+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347067; c=relaxed/simple;
	bh=EtnFnWlbUp7GLgtNCRTR1C0TuQakJARn5ciOH4S/YTw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfcAiQEaBFkikCrJ2GMUprGAmM7qfonPvXgV/rXaRoJIctqz2aP3Bxq4sTi1pEI8BdjincXlk8k0mLNe4/U7kJYvkx0S7iJyEVsIhPszDCPpNDJDzELo5ut18l7V7HiCcCEsqVIRYcuNqoCxIEAMHTUTyH+YbmN3mh3u+J6eZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tdj4023tbz6K8fY;
	Mon, 19 Feb 2024 20:47:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7623B140B38;
	Mon, 19 Feb 2024 20:51:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 12:51:00 +0000
Date: Mon, 19 Feb 2024 12:50:59 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>, Fan Ni
	<nifan.cxl@gmail.com>
Subject: Re: [PATCH v4 2/3] cxl/pci: Get rid of pointer arithmetic reading
 CDAT table
Message-ID: <20240219125059.0000737c@Huawei.com>
In-Reply-To: <20240216155844.406996-3-rrichter@amd.com>
References: <20240216155844.406996-1-rrichter@amd.com>
	<20240216155844.406996-3-rrichter@amd.com>
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

On Fri, 16 Feb 2024 16:58:43 +0100
Robert Richter <rrichter@amd.com> wrote:

> Reading the CDAT table using DOE requires a Table Access Response
> Header in addition to the CDAT entry. In current implementation this
> has caused offsets with sizeof(__le32) to the actual buffers. This led
> to hardly readable code and even bugs. E.g., see fix of devm_kfree()
> in read_cdat_data():
> 
>  c65efe3685f5 cxl/cdat: Free correct buffer on checksum error
> 
> Rework code to avoid calculations with sizeof(__le32). Introduce
> struct cdat_doe_rsp for this which contains the Table Access Response
> Header and a variable payload size for various data structures
> afterwards to access the CDAT table and its CDAT Data Structures
> without recalculating buffer offsets.
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Fan Ni <nifan.cxl@gmail.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
Ok. I suspect we could fine tune this for ever but changes here look good
enough to me and definitely nicer than the original ;)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/pci.c | 77 ++++++++++++++++++++++--------------------
>  drivers/cxl/cxlpci.h   | 24 +++++++++++++
>  2 files changed, 65 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 39366ce94985..763c39456228 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -544,55 +544,57 @@ static int cxl_cdat_get_length(struct device *dev,
>  
>  static int cxl_cdat_read_table(struct device *dev,
>  			       struct pci_doe_mb *doe_mb,
> -			       void *cdat_table, size_t *cdat_length)
> +			       struct cdat_doe_rsp *rsp, size_t *length)
>  {
> -	size_t length = *cdat_length + sizeof(__le32);
> -	__le32 *data = cdat_table;
> -	int entry_handle = 0;
> +	size_t received, remaining = *length;
> +	unsigned int entry_handle = 0;
> +	union cdat_data *data;
>  	__le32 saved_dw = 0;
>  
>  	do {
>  		__le32 request = CDAT_DOE_REQ(entry_handle);
> -		struct cdat_entry_header *entry;
> -		size_t entry_dw;
>  		int rc;
>  
>  		rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
>  			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
>  			     &request, sizeof(request),
> -			     data, length);
> +			     rsp, sizeof(*rsp) + remaining);
>  		if (rc < 0) {
>  			dev_err(dev, "DOE failed: %d", rc);
>  			return rc;
>  		}
>  
> -		/* 1 DW Table Access Response Header + CDAT entry */
> -		entry = (struct cdat_entry_header *)(data + 1);
> -		if ((entry_handle == 0 &&
> -		     rc != sizeof(__le32) + sizeof(struct cdat_header)) ||
> -		    (entry_handle > 0 &&
> -		     (rc < sizeof(__le32) + sizeof(*entry) ||
> -		      rc != sizeof(__le32) + le16_to_cpu(entry->length))))
> +		if (rc < sizeof(*rsp))
>  			return -EIO;
>  
> +		data = (union cdat_data *)rsp->data;
> +		received = rc - sizeof(*rsp);
> +
> +		if (entry_handle == 0) {
> +			if (received != sizeof(data->header))
> +				return -EIO;
> +		} else {
> +			if (received < sizeof(data->entry) ||
> +			    received != le16_to_cpu(data->entry.length))
> +				return -EIO;
> +		}
> +
>  		/* Get the CXL table access header entry handle */
>  		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
> -					 le32_to_cpu(data[0]));
> -		entry_dw = rc / sizeof(__le32);
> -		/* Skip Header */
> -		entry_dw -= 1;
> +					 le32_to_cpu(rsp->doe_header));
> +
>  		/*
>  		 * Table Access Response Header overwrote the last DW of
>  		 * previous entry, so restore that DW
>  		 */
> -		*data = saved_dw;
> -		length -= entry_dw * sizeof(__le32);
> -		data += entry_dw;
> -		saved_dw = *data;
> +		rsp->doe_header = saved_dw;
> +		remaining -= received;
> +		rsp = (void *)rsp + received;
> +		saved_dw = rsp->doe_header;
>  	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
>  
>  	/* Length in CDAT header may exceed concatenation of CDAT entries */
> -	*cdat_length -= length - sizeof(__le32);
> +	*length -= remaining;
>  
>  	return 0;
>  }


