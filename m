Return-Path: <linux-kernel+bounces-65707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A93D8550A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8221C21841
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3454E126F32;
	Wed, 14 Feb 2024 17:44:52 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01477E0EA;
	Wed, 14 Feb 2024 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932691; cv=none; b=GaBNsc4km9GXG2wMPAM3DW0lLv63Yg3G0VE5fOwcJo/mpyzLLU7M5d/OWQprqhHFRfnrE0q2P8tFTPF0nGzBLA/fw5u8f6d3jEfEo9gJKdVR/EVGqRBeSN9tOubzorEEjlxX+mrZJObyuoAI+obQE1kWgen2n5JIVESy5FfhNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932691; c=relaxed/simple;
	bh=x0pZy0YC1v0L4GBpZjCOiC6M7l8F0yAQyQ5cny4upp8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SA4NM6D9vAerMtAWak+KSI/D9Z1gE8y9jzzEqFqV5GDWHy+HUTngomTvL+mGXMbuuhdxDm4zi/EiqS+0CaEYy9LORmTbY68qOzpryszSOS1jvjTFKhkq4iKb95cGQ4jWoY9l4dffkRCkOWcaDwmj55U3tRcYQrYOKyb94Q4WXtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZlq43Nkdz67SWX;
	Thu, 15 Feb 2024 01:41:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 23EB41400D9;
	Thu, 15 Feb 2024 01:44:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 17:44:45 +0000
Date: Wed, 14 Feb 2024 17:44:44 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] lib/firmware_table: Provide buffer length
 argument to cdat_table_parse()
Message-ID: <20240214174444.00006c9f@Huawei.com>
In-Reply-To: <20240214173927.00002d20@Huawei.com>
References: <20240209192647.163042-1-rrichter@amd.com>
	<20240209192647.163042-4-rrichter@amd.com>
	<20240214173927.00002d20@Huawei.com>
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

On Wed, 14 Feb 2024 17:39:27 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 9 Feb 2024 20:26:47 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > There exists card implementations with a CDAT table using a fix  
> There exist ... fixed size buffer,
> > buffer, but with entries filled in that do not fill the whole table
> > length size. Then, the last entry in the CDAT table may not mark the
> > end of the CDAT table buffer specified by the length field in the CDAT
> > header. It can be shorter with trailing unused (zero'ed) data. The
> > actual table length is determined while reading all CDAT entries of
> > the table with DOE.
> > 
> > If the table is greater than expected (containing zero'ed trailing
> > data), the CDAT parser fails with:
> > 
> >  [   48.691717] Malformed DSMAS table length: (24:0)
> >  [   48.702084] [CDAT:0x00] Invalid zero length
> >  [   48.711460] cxl_port endpoint1: Failed to parse CDAT: -22
> > 
> > In addition, a check of the table buffer length is missing to prevent
> > an out-of-bound access then parsing the CDAT table.
> > 
> > Hardening code against device returning borked table. Fix that by
> > providing an optional buffer length argument to
> > acpi_parse_entries_array() that can be used by cdat_table_parse() to
> > propagate the buffer size down to its users to check the buffer
> > length. This also prevents a possible out-of-bound access mentioned.
> > 
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Len Brown <lenb@kernel.org>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>  
> 
> I think we should scream a bit about this if we see it
> as I'm unconvinced the spec allows for an implementation like this.
> 
> If the spec is unclear, lets seek a clarification.
> 
> I'm fine with this as a defensive measure, I just don't want
> device vendors to keep doing it! 
> 
Scrub that - I got around to checking the CDAT spec. It can
change length whilst we are reading it due to DSEMTS entry
counts being allowed to change.
https://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.03.pdf
(it's in the description of the Sequence field)

Sure we'll notice that the checksum fails and the sequence number
has updated but that doesn't help us if we went out of bounds
before we knew that.

Definitely good to check this as I think we can hit it even
if we don't have a potentially buggy device.
I'd still like to moan if we get inconsistent sizes and it
isn't a race though. Can we find a clean way to detect this
at a point where we know we have a valid complete table?

Jonathan

> Jonathan
> 
> 
> > ---
> >  drivers/acpi/tables.c    |  2 +-
> >  drivers/cxl/core/cdat.c  |  6 +++---
> >  include/linux/fw_table.h |  4 +++-
> >  lib/fw_table.c           | 15 ++++++++++-----
> >  4 files changed, 17 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> > index b07f7d091d13..b976e5fc3fbc 100644
> > --- a/drivers/acpi/tables.c
> > +++ b/drivers/acpi/tables.c
> > @@ -253,7 +253,7 @@ int __init_or_acpilib acpi_table_parse_entries_array(
> >  
> >  	count = acpi_parse_entries_array(id, table_size,
> >  					 (union fw_table_header *)table_header,
> > -					 proc, proc_num, max_entries);
> > +					 0, proc, proc_num, max_entries);
> >  
> >  	acpi_put_table(table_header);
> >  	return count;
> > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > index 6fe11546889f..012d8f2a7945 100644
> > --- a/drivers/cxl/core/cdat.c
> > +++ b/drivers/cxl/core/cdat.c
> > @@ -149,13 +149,13 @@ static int cxl_cdat_endpoint_process(struct cxl_port *port,
> >  	int rc;
> >  
> >  	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSMAS, cdat_dsmas_handler,
> > -			      dsmas_xa, port->cdat.table);
> > +			      dsmas_xa, port->cdat.table, port->cdat.length);
> >  	rc = cdat_table_parse_output(rc);
> >  	if (rc)
> >  		return rc;
> >  
> >  	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSLBIS, cdat_dslbis_handler,
> > -			      dsmas_xa, port->cdat.table);
> > +			      dsmas_xa, port->cdat.table, port->cdat.length);
> >  	return cdat_table_parse_output(rc);
> >  }
> >  
> > @@ -511,7 +511,7 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
> >  		return;
> >  
> >  	rc = cdat_table_parse(ACPI_CDAT_TYPE_SSLBIS, cdat_sslbis_handler,
> > -			      port, port->cdat.table);
> > +			      port, port->cdat.table, port->cdat.length);
> >  	rc = cdat_table_parse_output(rc);
> >  	if (rc)
> >  		dev_dbg(&port->dev, "Failed to parse SSLBIS: %d\n", rc);
> > diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
> > index 95421860397a..3ff4c277296f 100644
> > --- a/include/linux/fw_table.h
> > +++ b/include/linux/fw_table.h
> > @@ -40,12 +40,14 @@ union acpi_subtable_headers {
> >  
> >  int acpi_parse_entries_array(char *id, unsigned long table_size,
> >  			     union fw_table_header *table_header,
> > +			     unsigned long max_length,
> >  			     struct acpi_subtable_proc *proc,
> >  			     int proc_num, unsigned int max_entries);
> >  
> >  int cdat_table_parse(enum acpi_cdat_type type,
> >  		     acpi_tbl_entry_handler_arg handler_arg, void *arg,
> > -		     struct acpi_table_cdat *table_header);
> > +		     struct acpi_table_cdat *table_header,
> > +		     unsigned long length);
> >  
> >  /* CXL is the only non-ACPI consumer of the FIRMWARE_TABLE library */
> >  #if IS_ENABLED(CONFIG_ACPI) && !IS_ENABLED(CONFIG_CXL_BUS)
> > diff --git a/lib/fw_table.c b/lib/fw_table.c
> > index c3569d2ba503..16291814450e 100644
> > --- a/lib/fw_table.c
> > +++ b/lib/fw_table.c
> > @@ -127,6 +127,7 @@ static __init_or_fwtbl_lib int call_handler(struct acpi_subtable_proc *proc,
> >   *
> >   * @id: table id (for debugging purposes)
> >   * @table_size: size of the root table
> > + * @max_length: maximum size of the table (ignore if 0)
> >   * @table_header: where does the table start?
> >   * @proc: array of acpi_subtable_proc struct containing entry id
> >   *        and associated handler with it
> > @@ -148,18 +149,21 @@ static __init_or_fwtbl_lib int call_handler(struct acpi_subtable_proc *proc,
> >  int __init_or_fwtbl_lib
> >  acpi_parse_entries_array(char *id, unsigned long table_size,
> >  			 union fw_table_header *table_header,
> > +			 unsigned long max_length,
> >  			 struct acpi_subtable_proc *proc,
> >  			 int proc_num, unsigned int max_entries)
> >  {
> > -	unsigned long table_end, subtable_len, entry_len;
> > +	unsigned long table_len, table_end, subtable_len, entry_len;
> >  	struct acpi_subtable_entry entry;
> >  	enum acpi_subtable_type type;
> >  	int count = 0;
> >  	int i;
> >  
> >  	type = acpi_get_subtable_type(id);
> > -	table_end = (unsigned long)table_header +
> > -		    acpi_table_get_length(type, table_header);
> > +	table_len = acpi_table_get_length(type, table_header);
> > +	if (max_length && max_length < table_len)
> > +		table_len = max_length;  
> 	if (max_length)
> 		table_len = min(max_length, table_len);
> 
> > +	table_end = (unsigned long)table_header + table_len;
> >  
> >  	/* Parse all entries looking for a match. */
> >  
> > @@ -208,7 +212,8 @@ int __init_or_fwtbl_lib
> >  cdat_table_parse(enum acpi_cdat_type type,
> >  		 acpi_tbl_entry_handler_arg handler_arg,
> >  		 void *arg,
> > -		 struct acpi_table_cdat *table_header)
> > +		 struct acpi_table_cdat *table_header,
> > +		 unsigned long length)
> >  {
> >  	struct acpi_subtable_proc proc = {
> >  		.id		= type,
> > @@ -222,6 +227,6 @@ cdat_table_parse(enum acpi_cdat_type type,
> >  	return acpi_parse_entries_array(ACPI_SIG_CDAT,
> >  					sizeof(struct acpi_table_cdat),
> >  					(union fw_table_header *)table_header,
> > -					&proc, 1, 0);
> > +					length, &proc, 1, 0);
> >  }
> >  EXPORT_SYMBOL_FWTBL_LIB(cdat_table_parse);  
> 


