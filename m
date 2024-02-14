Return-Path: <linux-kernel+bounces-65685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F973855060
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6761F222C3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885617E0EA;
	Wed, 14 Feb 2024 17:32:07 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C132C60DFD;
	Wed, 14 Feb 2024 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931927; cv=none; b=RkJPvgmE58Yq3l7CWLj0MeWrDbj7zkwo8C7WZELWhkEz4TqMySjw30Avs49hyKSYmbzCKV71pHUu+ED3EecZcksL3kKgch+CyJZCjYeJBr1AkdwSgiVQm8XKDUDzJDVHzdhhVmLXDLHeOrQHQMb8MB+q1NAQyjdtsP3wVq5rwNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931927; c=relaxed/simple;
	bh=JvVUCvD9rZWJkutZ9VbgQuNUGsPYpHJDPvCtsBtapMs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZfMES0GmXBTJCuSasnB8Sf1HAstWWVh3dgFvKNxT5AP99jhO/A0aNDgHIpqPwx9KStdp/BjuXbWvbBFxS9KVcE0bVkgZcggITZBMvw0g1mcCgPRl7Tyb4uIBUN1ZjHY7yMLoEIBb5jaX6r+OYOaHuxfp019dQiqBBNWB/cU554=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZlWz5QNhz67pJF;
	Thu, 15 Feb 2024 01:27:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CE5D4140D26;
	Thu, 15 Feb 2024 01:31:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 17:31:59 +0000
Date: Wed, 14 Feb 2024 17:31:58 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>, Fan Ni
	<nifan.cxl@gmail.com>
Subject: Re: [PATCH v3 2/3] cxl/pci: Get rid of pointer arithmetic reading
 CDAT table
Message-ID: <20240214173158.000005c0@Huawei.com>
In-Reply-To: <20240209192647.163042-3-rrichter@amd.com>
References: <20240209192647.163042-1-rrichter@amd.com>
	<20240209192647.163042-3-rrichter@amd.com>
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

On Fri, 9 Feb 2024 20:26:46 +0100
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

Hi Robert,

I like this in general.  A few comments inline though.

> ---
>  drivers/cxl/core/pci.c | 75 ++++++++++++++++++++++--------------------
>  drivers/cxl/cxlpci.h   | 20 +++++++++++
>  2 files changed, 59 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 39366ce94985..569354a5536f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -544,55 +544,55 @@ static int cxl_cdat_get_length(struct device *dev,
>  
>  static int cxl_cdat_read_table(struct device *dev,
>  			       struct pci_doe_mb *doe_mb,
> -			       void *cdat_table, size_t *cdat_length)
> +			       struct cdat_doe_rsp *rsp, size_t *length)

Nitpick, but rsp isn't a response, it's the whole table.
Maybe it's worth a 
#define cdat_doe_table cdat_doe_rsp
or a typedef so the two are different in name at least whilst sharing
same structure definition?

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

I guess it's not really worth using struct_size here.
It's main advantage is making it clear we are dealing with a
trailing [] 

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
> +			return -EIO;
> +
> +		data = (void *)rsp->data;

Nicer to cast to (union cdat_data *) than rely on bounce via a void *

> +		received = rc - sizeof(*rsp);
> +
> +		if ((!entry_handle &&

Prefer == 0 for this because 0 is a magic value here.

> +		     received != sizeof(data->header)) ||
> +		    (entry_handle &&
> +		     (received < sizeof(data->entry) ||
> +		      received != le16_to_cpu(data->entry.length))))
>  			return -EIO;

Given it's two rather involved conditions maybe better to do.

		if (entry_handle == 0) {
			if (received != sizeof(data->header)
				return -EIO;
		} else {
			if (received < sizeof(data->entry) ||
			    received != le16_to_cpu(data->entry.length))
				return -EIO;
		}

More code but easier to see the header vs entry checks.
Could even define a little utility function / macro.

		cdat_is_head_handle(val) entry_handle == 0
so you get somewhat more self documenting code.

		if (cdat_is_head_handle(entry_handle)) {
		} else {
		}

>  
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

I'm not keen on this looking like we are writing the doe header
as we are writing the tail of the last response.

Maybe the comment is enough.  I don't have a better idea on how
to make this more obvious.

> +		remaining -= received;
> +		rsp = (void *)rsp + received;

Was a potential problem with previous code, but this could
in theory become unaligned and we should be using unaligned accessors
for it as a result, or maybe adding a check that it doesn't ever become so.
The check is probably the easier path given CDAT entries are thankfully
(I think) all dword multiples as are the two headers.

> +		saved_dw = rsp->doe_header;
>  	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
>  
>  	/* Length in CDAT header may exceed concatenation of CDAT entries */
> -	*cdat_length -= length - sizeof(__le32);
> +	*length -= remaining;
>  
>  	return 0;
>  }



