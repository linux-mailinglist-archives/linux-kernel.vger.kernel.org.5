Return-Path: <linux-kernel+bounces-40368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC41383DF1A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E88281DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E93D1DDF4;
	Fri, 26 Jan 2024 16:46:11 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8910517565;
	Fri, 26 Jan 2024 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287571; cv=none; b=bv00RsEU4QyxxDiXYz2X4TtwKDTX0CCi0fVOj3T1/18bShBL4v1aAFNfD7KTLm+0m95k/z6iEsHCUWrelAelNRlLaB0xR+xQuuNqTHIcVjbWmCAnbDIpiln5Alg1n1pZOoR/dHMBo/uCEfi6lLKV1oODccpsBMlgH8FhjBS+/gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287571; c=relaxed/simple;
	bh=dU2O7jrbFnFCbgUiCpiNtwgswX6F92IR62D/O8qwkjw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeKYj1VJ/UyJWs8nIhB5jfPMmycl+hHnDpzWzbLx8x2WPxXp4qNiB3B2xb+JepqUIofR25vtXRHgFHqBdtunMGXJKhxfR1nI4OLQ2ENtR8n2rrEc3cRubG0hr5VvWz58JegyaWTaVcAeo0286CpFs9OLoag2RXgzXwgysiKo7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TM3Qp5BTvz6J9f2;
	Sat, 27 Jan 2024 00:42:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C50DB140A36;
	Sat, 27 Jan 2024 00:46:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 16:46:04 +0000
Date: Fri, 26 Jan 2024 16:46:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, "Rafael J. Wysocki" <rafael@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] lib/firmware_table: Provide buffer length
 argument to cdat_table_parse()
Message-ID: <20240126164603.000040fd@Huawei.com>
In-Reply-To: <20240108114833.241710-4-rrichter@amd.com>
References: <20240108114833.241710-1-rrichter@amd.com>
	<20240108114833.241710-4-rrichter@amd.com>
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

On Mon, 8 Jan 2024 12:48:33 +0100
Robert Richter <rrichter@amd.com> wrote:

> The last entry in the CDAT table may not mark the end of the CDAT
> table buffer specified by the length field in the CDAT header. It can
> be shorter with trailing unused (zero'ed) data. The actual table
> length is determined when reading all CDAT entries of the table with
> DOE.

Can you give some reasons why this would occur?

Need to be clear if this is:
1) Hardening against device returning borked table.
2) Hardening against in flight update of CDAT racing with the readout
   (not sure table can change size, but maybe.. I haven't checked).
3) DW read back vs packed structures?

Patch seems reasonable to me, I'd just like a clear statement of why
it happens!

Jonathan

> 
> If the table is greater than expected (containing zero'ed trailing
> data), the CDAT parser fails with:
> 
>  [   48.691717] Malformed DSMAS table length: (24:0)
>  [   48.702084] [CDAT:0x00] Invalid zero length
>  [   48.711460] cxl_port endpoint1: Failed to parse CDAT: -22
> 
> In addition, the table buffer size can be different from the size
> specified in the length field. This may cause out-of-bound access then
> parsing the CDAT table.
> 
> Fix that by providing an optonal buffer length argument to
> acpi_parse_entries_array() that can be used by cdat_table_parse() to
> propagate the buffer size down to its users.
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/tables.c    |  2 +-
>  drivers/cxl/core/cdat.c  |  6 +++---
>  include/linux/fw_table.h |  4 +++-
>  lib/fw_table.c           | 15 ++++++++++-----
>  4 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index b07f7d091d13..b976e5fc3fbc 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -253,7 +253,7 @@ int __init_or_acpilib acpi_table_parse_entries_array(
>  
>  	count = acpi_parse_entries_array(id, table_size,
>  					 (union fw_table_header *)table_header,
> -					 proc, proc_num, max_entries);
> +					 0, proc, proc_num, max_entries);
>  
>  	acpi_put_table(table_header);
>  	return count;
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 6fe11546889f..012d8f2a7945 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -149,13 +149,13 @@ static int cxl_cdat_endpoint_process(struct cxl_port *port,
>  	int rc;
>  
>  	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSMAS, cdat_dsmas_handler,
> -			      dsmas_xa, port->cdat.table);
> +			      dsmas_xa, port->cdat.table, port->cdat.length);
>  	rc = cdat_table_parse_output(rc);
>  	if (rc)
>  		return rc;
>  
>  	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSLBIS, cdat_dslbis_handler,
> -			      dsmas_xa, port->cdat.table);
> +			      dsmas_xa, port->cdat.table, port->cdat.length);
>  	return cdat_table_parse_output(rc);
>  }
>  
> @@ -511,7 +511,7 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
>  		return;
>  
>  	rc = cdat_table_parse(ACPI_CDAT_TYPE_SSLBIS, cdat_sslbis_handler,
> -			      port, port->cdat.table);
> +			      port, port->cdat.table, port->cdat.length);
>  	rc = cdat_table_parse_output(rc);
>  	if (rc)
>  		dev_dbg(&port->dev, "Failed to parse SSLBIS: %d\n", rc);
> diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
> index 95421860397a..3ff4c277296f 100644
> --- a/include/linux/fw_table.h
> +++ b/include/linux/fw_table.h
> @@ -40,12 +40,14 @@ union acpi_subtable_headers {
>  
>  int acpi_parse_entries_array(char *id, unsigned long table_size,
>  			     union fw_table_header *table_header,
> +			     unsigned long max_length,
>  			     struct acpi_subtable_proc *proc,
>  			     int proc_num, unsigned int max_entries);
>  
>  int cdat_table_parse(enum acpi_cdat_type type,
>  		     acpi_tbl_entry_handler_arg handler_arg, void *arg,
> -		     struct acpi_table_cdat *table_header);
> +		     struct acpi_table_cdat *table_header,
> +		     unsigned long length);
>  
>  /* CXL is the only non-ACPI consumer of the FIRMWARE_TABLE library */
>  #if IS_ENABLED(CONFIG_ACPI) && !IS_ENABLED(CONFIG_CXL_BUS)
> diff --git a/lib/fw_table.c b/lib/fw_table.c
> index 1e5e0b2f7012..ddb67853b7ac 100644
> --- a/lib/fw_table.c
> +++ b/lib/fw_table.c
> @@ -132,6 +132,7 @@ static __init_or_fwtbl_lib int call_handler(struct acpi_subtable_proc *proc,
>   *
>   * @id: table id (for debugging purposes)
>   * @table_size: size of the root table
> + * @max_length: maximum size of the table (ignore if 0)
>   * @table_header: where does the table start?
>   * @proc: array of acpi_subtable_proc struct containing entry id
>   *        and associated handler with it
> @@ -153,10 +154,11 @@ static __init_or_fwtbl_lib int call_handler(struct acpi_subtable_proc *proc,
>  int __init_or_fwtbl_lib
>  acpi_parse_entries_array(char *id, unsigned long table_size,
>  			 union fw_table_header *table_header,
> +			 unsigned long max_length,
>  			 struct acpi_subtable_proc *proc,
>  			 int proc_num, unsigned int max_entries)
>  {
> -	unsigned long table_end, subtable_len, entry_len;
> +	unsigned long table_len, table_end, subtable_len, entry_len;
>  	struct acpi_subtable_entry entry;
>  	enum acpi_subtable_type type;
>  	int count = 0;
> @@ -164,8 +166,10 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>  	int i;
>  
>  	type = acpi_get_subtable_type(id);
> -	table_end = (unsigned long)table_header +
> -		    acpi_table_get_length(type, table_header);
> +	table_len = acpi_table_get_length(type, table_header);
> +	if (max_length && max_length < table_len)
> +		table_len = max_length;
> +	table_end = (unsigned long)table_header + table_len;
>  
>  	/* Parse all entries looking for a match. */
>  
> @@ -220,7 +224,8 @@ int __init_or_fwtbl_lib
>  cdat_table_parse(enum acpi_cdat_type type,
>  		 acpi_tbl_entry_handler_arg handler_arg,
>  		 void *arg,
> -		 struct acpi_table_cdat *table_header)
> +		 struct acpi_table_cdat *table_header,
> +		 unsigned long length)
>  {
>  	struct acpi_subtable_proc proc = {
>  		.id		= type,
> @@ -234,6 +239,6 @@ cdat_table_parse(enum acpi_cdat_type type,
>  	return acpi_parse_entries_array(ACPI_SIG_CDAT,
>  					sizeof(struct acpi_table_cdat),
>  					(union fw_table_header *)table_header,
> -					&proc, 1, 0);
> +					length, &proc, 1, 0);
>  }
>  EXPORT_SYMBOL_FWTBL_LIB(cdat_table_parse);


