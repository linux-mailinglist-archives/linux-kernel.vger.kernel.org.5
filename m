Return-Path: <linux-kernel+bounces-40364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CA183DF07
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4FB1C239CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A9D1DA22;
	Fri, 26 Jan 2024 16:42:31 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353271D69B;
	Fri, 26 Jan 2024 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287351; cv=none; b=CGl5qCX1rqwdzu/Yn/5djdv6UWFm2hxFdebI0TpgXRXTzavUHfY+AwPgXlSDKoHogzAgZfdl0DmL7u0MNKZXLN1j0U6mxmlcpG0SHdgcUE5QIa7CYuTbQqvQ3/hapN/75wqy1Jf+3cS/yIfgxI1TcVNm6HWbsD1WAX2ihwxGBKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287351; c=relaxed/simple;
	bh=LP0F4OslFkEJrpXijvME2B9Xw9h75yar6t5vC0PaHQo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4bZSQuwcdSgVMQ23y74HSViiJ85AskcCwz+DsVIS5JHOPLwVQO5+/475sJQ2fDQKkiZpwv6cy5/s7JE7I265YuwE2mFMRbv7m1PIXChVKpvvOPqjx+U1mabz0/87/Ipk61Ala93GtvbWf97rOHyaCRj3UKRYYKJPCuEYyWAjt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TM3Lh3NSyz6K8wq;
	Sat, 27 Jan 2024 00:39:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EABA1400D3;
	Sat, 27 Jan 2024 00:42:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 16:42:23 +0000
Date: Fri, 26 Jan 2024 16:42:22 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>, Fan Ni
	<nifan.cxl@gmail.com>
Subject: Re: [PATCH v2 2/3] cxl/pci: Get rid of pointer arithmetic reading
 CDAT table
Message-ID: <20240126164222.000022b7@Huawei.com>
In-Reply-To: <20240108114833.241710-3-rrichter@amd.com>
References: <20240108114833.241710-1-rrichter@amd.com>
	<20240108114833.241710-3-rrichter@amd.com>
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

On Mon, 8 Jan 2024 12:48:32 +0100
Robert Richter <rrichter@amd.com> wrote:

> Reading the CDAT table using DOE requires a Table Access Response
> Header in addition to the CDAT entry. In current implementation this
> has caused offsets with sizeof(__le32) to the actual buffers. This led
> to hardly readable code and even bugs (see fix of devm_kfree() in
> read_cdat_data()).

Hi Robert,

Referring to a fix in this patch set or one in another patch?
If it's another patch a cross reference would be good. If it's in
here this should have a fixes tag.

> 
> Rework code to avoid calculations with sizeof(__le32). Introduce
> struct cdat_doe for this which contains the Table Access Response
> Header and a variable payload size for various data structures
> afterwards to access the CDAT table and its CDAT Data Structures
> without recalculating buffer offsets.

Comments inline, but I don't like using variable element arrays when
we know that they are of size 1 but then rely on their minimum in
the code being size 0.  Better I think to make it explicit that there
is one of each and use more complex offsetof() handling that doesn't
give the impression the number of elements varies.


> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Fan Ni <nifan.cxl@gmail.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/pci.c | 67 +++++++++++++++++++++---------------------
>  drivers/cxl/cxlpci.h   | 19 ++++++++++++
>  2 files changed, 53 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 89bab00bb291..75d8fa228879 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -544,55 +544,53 @@ static int cxl_cdat_get_length(struct device *dev,
>  
>  static int cxl_cdat_read_table(struct device *dev,
>  			       struct pci_doe_mb *doe_mb,
> -			       void *cdat_table, size_t *cdat_length)
> +			       struct cdat_doe_rsp *rsp, size_t *length)
>  {
> -	size_t length = *cdat_length + sizeof(__le32);
> -	__le32 *data = cdat_table;
> +	size_t received, remaining = *length;
>  	int entry_handle = 0;
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
> +		if (rc < sizeof(*rsp))
> +			return -EIO;
> +
> +		received = rc - sizeof(*rsp);

As mentioned below, I'd rather see this as offsetof() to get
to a real element in the structure rather that relying on a flex array
for a known single element array.

It is still a little messy because the offsetof() variable should be different
for the cdat header and the entries even though we know they are actually
in the same place.  

		if ((entry_handle == 0) {
			received = rc - offsetof(typeof(*rsp), header);
			if (received != sizeof(rsp->header))
				return -EIO;
		} else {
			received = rc - offsetof(typeof(*rsp), entry);
			if (received < sizeof(rsp->entry) ||
			    received != le16_to_cpu(rsp->entry->length))
				return -EIO;
		}	



> +
>  		if ((entry_handle == 0 &&
> -		     rc != sizeof(__le32) + sizeof(struct cdat_header)) ||
> +		     received != sizeof(rsp->header[0])) ||
>  		    (entry_handle > 0 &&

Why are we letting entry_handle go negative anyway?


> -		     (rc < sizeof(__le32) + sizeof(*entry) ||
> -		      rc != sizeof(__le32) + le16_to_cpu(entry->length))))
> +		     (received < sizeof(rsp->entry[0]) ||
> +		      received != le16_to_cpu(rsp->entry->length))))
>  			return -EIO;
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
> @@ -620,8 +618,8 @@ void read_cdat_data(struct cxl_port *port)
>  	struct pci_doe_mb *doe_mb;
>  	struct pci_dev *pdev = NULL;
>  	struct cxl_memdev *cxlmd;
> -	size_t cdat_length;
> -	void *cdat_table, *cdat_buf;
> +	struct cdat_doe_rsp *buf;
> +	size_t length;
>  	int rc;
>  
>  	if (is_cxl_memdev(uport)) {
> @@ -647,30 +645,33 @@ void read_cdat_data(struct cxl_port *port)
>  
>  	port->cdat_available = true;
>  
> -	if (cxl_cdat_get_length(dev, doe_mb, &cdat_length)) {
> +	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
>  		dev_dbg(dev, "No CDAT length\n");
>  		return;
>  	}
>  
> -	cdat_buf = devm_kzalloc(dev, cdat_length + sizeof(__le32), GFP_KERNEL);
> -	if (!cdat_buf)
> -		return;
> +	/*
> +	 * The begin of the CDAT buffer needs space for additional 4
> +	 * bytes for the DOE header. Table data starts afterwards.
> +	 */
> +	buf = devm_kzalloc(dev, sizeof(*buf) + length, GFP_KERNEL);

with below suggestion this would need to use offsetof(... table)
which isn't hugely obvious but there is definitely a trade off to be
figured out somewhere and I think this is less painful than implying
a variable number of entries etc.

The implied structure of the data here is also disagreeing with below as
I believe it's

struct {
	u32 doe_header;
	struct cdat_header cdat_table_header;
	struct cdat_entry entries[];
}
Which is not implied by the type you have below.

Hmm. I wonder if we should play games in the inner loop to avoid having
that outer stray DWord here.

Something like.

1. Assume that there is at least one CDAT entry of 4 bytes or more
   (seems reasonable).
2. Allocate the correct length and nothing more. Pass that into
   cxl_cdat_read_table()
3. Read the DOE header + the CDAT Header into that buffer.
4. Memmove result -4 bytes to drop the DOE header.
5. Rest as before complete with the stashing of the final DW
   each time so we can put it back when the next loop overwrites
   it by accident.

Your structure is still useful for within the function, but not
out here where it represents completely the wrong data layout.
Here we just want the raw CDAT table anyway so represent it
as u8 data[]; is fine as no odd offsets to deal with.


Jonathan






> +	if (!buf)
> +		goto err;
>  
> -	rc = cxl_cdat_read_table(dev, doe_mb, cdat_buf, &cdat_length);
> +	rc = cxl_cdat_read_table(dev, doe_mb, buf, &length);
>  	if (rc)
>  		goto err;
>  
> -	cdat_table = cdat_buf + sizeof(__le32);
> -	if (cdat_checksum(cdat_table, cdat_length))
> +	if (cdat_checksum(buf->table, length))
>  		goto err;
>  
> -	port->cdat.table = cdat_table;
> -	port->cdat.length = cdat_length;
> -	return;
> +	port->cdat.table = buf->table;
> +	port->cdat.length = length;
>  
> +	return;
>  err:
>  	/* Don't leave table data allocated on error */
> -	devm_kfree(dev, cdat_buf);
> +	devm_kfree(dev, buf);
>  	dev_err(dev, "Failed to read/validate CDAT.\n");
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 711b05d9a370..b40c571b2ab2 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -85,6 +85,25 @@ struct cdat_entry_header {
>  	__le16 length;
>  } __packed;
>  
> +/*
> + * Response contains the CDAT only response header of the DOE. The
> + * response payload is a CDAT structure (either CDAT header or entry),
> + * it may also mark the beginning of the CDAT table.
> + *
> + * Spec refs:
> + *
> + * CXL 3.1 Table 8-14: Read Entry Response
> + * CDAT Specification 1.03: 2 CDAT Data Structures
> + */
> +struct cdat_doe_rsp {
> +	__le32 doe_header;
> +	union {
> +		DECLARE_FLEX_ARRAY(u8, table);
> +		DECLARE_FLEX_ARRAY(struct cdat_header, header);
> +		DECLARE_FLEX_ARRAY(struct cdat_entry_header, entry);

I'm not understanding why these last two are flex arrays...
Each DOE resp only includes either 1 cdat_header or 1 cdat_entry_header
For table fair enough.

If you want a general response I think it needs to be something like

struct cdat_doe_rsp {
	union {
		DECLARE_FLEX_ARRAY(u8, table);
		struct cdat_header header;
		struct {
			struct cdat_entry_header entry;
			u8 entry_data[];
		};
	};
} __packed;

That doesn't make it useful for above unless you use
offsetof() to establish you are really interested in how far in to
get to the real data.


> +	};
> +} __packed;
> +
>  /*
>   * CXL v3.0 6.2.3 Table 6-4
>   * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits


