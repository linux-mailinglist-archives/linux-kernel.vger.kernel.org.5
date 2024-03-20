Return-Path: <linux-kernel+bounces-109251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477F88816CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9B91C212D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0246A353;
	Wed, 20 Mar 2024 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDZdxhVJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F21E516;
	Wed, 20 Mar 2024 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710956873; cv=none; b=K8WNIE9s1tv5ZCAvnivAXR3m5zZTkqwohRZf0fYwR4xOuQttIDy1Xe8kkIF8am4j/oHYjhDFVu9FmqrrbObVg06P+BK9WoOO8HBQV/kHXENyLGMhxROe5YilXh7suOwtVHXsga5we+Z8v03wKBekESMfbSZJ6MZaMBS0DoPzRCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710956873; c=relaxed/simple;
	bh=CMBlbJgjppACUd333kEyt8jk0aVlQl5rJKnSNrUS5Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmHoCuE4MwdHW628uJYoSVNULHZ5iihXuo0s/n1BWidP6loSKlivVZR51cvx3NG6Zepjvah79IJpwY2nEVhXE5himqaZYzK/SW4PkKsfY9deVpoG1uz3xGMeYhTOB/H7YN636VQl0h1k3Iu5Wlm/0yI2TryqaHGPk9GtNSsrCE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDZdxhVJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710956872; x=1742492872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CMBlbJgjppACUd333kEyt8jk0aVlQl5rJKnSNrUS5Hg=;
  b=UDZdxhVJI6XfagxHeOQxFAzTGkEjWXDWpLgyonVYsxv0YdNSFnDpv9bp
   LGDON681D7h/18YkkzblXV2Mj7/P4/7u0mdFJpktKmRGc6A2lj+I+dsNg
   hDT3REKop2jOPOpz3FXknoBZS74cd+4e7SRfdz2qo1hfZYM35hPVE+Hvr
   HraW0wAqPOohG+v0N/Pg2JxCKW/d0Z66xUbX6HzKvjEL+G8cVuQpk6+wA
   JkGVCrf/N7sA+ahJq2/IlUxatw1uXCnvJHhSa9DtfiwGMpn9xdNX9Uh91
   a7qBUgcyg9jEPBUBRZP2MdvQ62r0HhXruoHPAYuYit2ppsfOFJZ3j1aqE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="16540592"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="16540592"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 10:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="14207930"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.72.188])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 10:47:50 -0700
Date: Wed, 20 Mar 2024 10:47:48 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 2/3] ACPI/NUMA: Print CXL Early Discovery Table (CEDT)
Message-ID: <ZfshRI/xAbSLJDQT@aschofie-mobl2>
References: <20240319120026.2246389-1-rrichter@amd.com>
 <20240319120026.2246389-3-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319120026.2246389-3-rrichter@amd.com>

On Tue, Mar 19, 2024 at 01:00:24PM +0100, Robert Richter wrote:
> The CEDT contains similar entries as the SRAT. For diagnostic reasons
> print the CEDT same style as the SRAT.

Richard,

Acpitools is not properly handling the CFMWS at the moment. When
that gets fixed up, might you be good using acpidump/extract.

If you're going to dump, how about dumping it all? Add the fields
interleave arithmetic, qtg_id, xormap_list[].

While debugging issues in this space I have wished for more info
like this:

1) acpi_parse_cfmws()  pr_warn's upon failure to add a node but is 
quiet on success. A pr_info on success, showing that a new memblk
and node was added would be useful.

2) numa_add_memblks() if memblk was extended pr_info the info.

If you can incorporate here, great!

Thanks,
Alison


> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/numa/srat.c | 112 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index e45e64993c50..50ae8557e8d1 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -300,6 +300,114 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
>  	return -EINVAL;
>  }
>  
> +static int __init
> +__acpi_table_print_cedt_entry(union acpi_subtable_headers *__header,
> +			      void *arg, const unsigned long table_end)
> +{
> +	struct acpi_cedt_header *header = (struct acpi_cedt_header *)__header;
> +
> +	switch (header->type) {
> +	case ACPI_CEDT_TYPE_CHBS:
> +		{
> +			struct acpi_cedt_chbs *p =
> +				(struct acpi_cedt_chbs *)header;
> +
> +			if (header->length < sizeof(struct acpi_cedt_chbs)) {
> +				pr_warn("CEDT: unsupported CHBS entry: size %d\n",
> +					 header->length);
> +				break;
> +			}
> +
> +			pr_info("CEDT: CHBS (0x%llx length 0x%llx uid %lu) %s (%d)\n",
> +				 (unsigned long long)p->base,
> +				 (unsigned long long)p->length,
> +				 (unsigned long)p->uid,
> +				 (p->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) ?
> +				 "cxl11" :
> +				 (p->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL20) ?
> +				 "cxl20" :
> +				 "unsupported version",
> +				 p->cxl_version);
> +		}
> +		break;
> +	case ACPI_CEDT_TYPE_CFMWS:
> +		{
> +			struct acpi_cedt_cfmws *p =
> +				(struct acpi_cedt_cfmws *)header;
> +			int eiw_to_ways[] = {1, 2, 4, 8, 16, 3, 6, 12};
> +			int targets = -1;
> +
> +			if (header->length < sizeof(struct acpi_cedt_cfmws)) {
> +				pr_warn("CEDT: unsupported CFMWS entry: size %d\n",
> +					header->length);
> +				break;
> +			}
> +
> +			if (p->interleave_ways < ARRAY_SIZE(eiw_to_ways))
> +				targets = eiw_to_ways[p->interleave_ways];
> +			if (header->length < struct_size(
> +					p, interleave_targets, targets))
> +				targets = -1;
> +
> +			pr_info("CEDT: CFMWS (0x%llx length 0x%llx) with %d target%s",
> +				(unsigned long long)p->base_hpa,
> +				(unsigned long long)p->window_size,
> +				targets, targets > 1 ? "s" : "");
> +			for (int i = 0; i < targets; i++)
> +				pr_cont("%s%lu", i ? ", " : " (",
> +					(unsigned long)p->interleave_targets[i]);
> +			pr_cont("%s%s%s%s%s%s\n",
> +				targets > 0 ? ")" : "",
> +				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2) ?
> +				" type2" : "",
> +				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3) ?
> +				" type3" : "",
> +				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE) ?
> +				" volatile" : "",
> +				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_PMEM) ?
> +				" pmem" : "",
> +				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED) ?
> +				" fixed" : "");
> +		}
> +		break;
> +	case ACPI_CEDT_TYPE_CXIMS:
> +		{
> +			struct acpi_cedt_cxims *p =
> +				(struct acpi_cedt_cxims *)header;
> +
> +			if (header->length < sizeof(struct acpi_cedt_cxims)) {
> +				pr_warn("CEDT: unsupported CXIMS entry: size %d\n",
> +					header->length);
> +				break;
> +			}
> +
> +			pr_info("CEDT: CXIMS (hbig %u nr_xormaps %u)\n",
> +				 (unsigned int)p->hbig,
> +				 (unsigned int)p->nr_xormaps);
> +		}
> +		break;
> +	default:
> +		pr_warn("CEDT: Found unsupported entry (type = 0x%x)\n",
> +			header->type);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __init acpi_table_print_cedt_entry(enum acpi_cedt_type id)
> +{
> +	acpi_table_parse_cedt(id, __acpi_table_print_cedt_entry, NULL);
> +}
> +
> +static void __init acpi_table_print_cedt(void)
> +{
> +	/* Print only implemented CEDT types */
> +	acpi_table_print_cedt_entry(ACPI_CEDT_TYPE_CHBS);
> +	acpi_table_print_cedt_entry(ACPI_CEDT_TYPE_CFMWS);
> +	acpi_table_print_cedt_entry(ACPI_CEDT_TYPE_CXIMS);
> +}
> +
>  static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  				   void *arg, const unsigned long table_end)
>  {
> @@ -341,6 +449,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	return 0;
>  }
>  #else
> +static inline void acpi_table_print_cedt(void) {}
>  static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  				   void *arg, const unsigned long table_end)
>  {
> @@ -526,6 +635,9 @@ int __init acpi_numa_init(void)
>  	/* SLIT: System Locality Information Table */
>  	acpi_table_parse(ACPI_SIG_SLIT, acpi_parse_slit);
>  
> +	/* CEDT: CXL Early Discovery Table */
> +	acpi_table_print_cedt();
> +
>  	/*
>  	 * CXL Fixed Memory Window Structures (CFMWS) must be parsed
>  	 * after the SRAT. Create NUMA Nodes for CXL memory ranges that
> -- 
> 2.39.2
> 

