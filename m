Return-Path: <linux-kernel+bounces-36095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E01839B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A3128D0F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE4148CC6;
	Tue, 23 Jan 2024 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbtCkywT"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5EB3FB3E;
	Tue, 23 Jan 2024 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046788; cv=none; b=JPOXHqWoLhqAn7otk+UpDilyk1szWoVrL9AMGFJ8oxHLTQiqPm7B0XqERtrZe9pNq3g6a1dpi9L3KyYQ8lzLEvR0QjLRaR7JMuhpkTQibii8W4fqWQEJZBnJMFPrN57P7246RH78/tVSMyxpvYY0GR9mzaXsrKV0gW4GQh97dW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046788; c=relaxed/simple;
	bh=gVdLKDj2dZDA3KwdFONdM5uArJMMVngn7HnFmogD5EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZ+r+ScYSEciDPxzYG8NS6TkihFTc1EAgyDyZnhMGBqaklvC9Q2FtAM09F5cFcTFgrt/nhKKiXXz1pI9V5zeFZPhOTkuxFu6Rstg6+vGl/aVhYruvZ+BgQck/JwxUzNeLt06FrZzy5t8kKS63zsfsNxbyq6PdrTwZkX9TNYBmUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbtCkywT; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706046785; x=1737582785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gVdLKDj2dZDA3KwdFONdM5uArJMMVngn7HnFmogD5EE=;
  b=FbtCkywT/9m/ak371D6sjZX+CPXvUZe6KDGwksEXWkA7MBkvGbEEAwXw
   c+/F74b2DRQ+EDm2QT/T9MWMLBi32UQq5P8+A7Tj3DV/wxi5ttLeSbXrP
   oZuyxrRejd036eaJ1EIZToF2u/8TRHn3Nr62D6qPjAb+npFd15n6N7OWS
   GDk7C96OakVnl+3gnIkZNHFYLziZqTcAVv7CHzfpjN2uxmU7pj+HZx3Mv
   tlffXDa4mPYpJdx5dAsfMU2H2Xdx8LEihHFZvobAbH8ypk+VRgkQvu1TR
   e8i6g+LzGIdyxMF6uarNJnZSw5HQc3hvTO8s6EEU/A1acTKXwlYY9lKXM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400530127"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="400530127"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 13:53:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1117416990"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1117416990"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 13:53:04 -0800
Date: Tue, 23 Jan 2024 13:53:03 -0800
From: Tony Luck <tony.luck@intel.com>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	james.morse@arm.com, bp@alien8.de, linux-kernel@vger.kernel.org,
	yazen.ghannam@amd.com, Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH v3] ACPI: APEI: Skip initialization of GHES_ASSIST
 structures for Machine Check Architecture
Message-ID: <ZbA1P_34pUYe6aNX@agluck-desk3>
References: <20231204192549.1953029-1-avadhut.naik@amd.com>
 <b519a7e0-77a7-44b4-809b-caf96536fe1c@amd.com>
 <c86815fe-21dc-4dd7-bf10-74e3cc754413@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c86815fe-21dc-4dd7-bf10-74e3cc754413@amd.com>

On Tue, Jan 23, 2024 at 03:39:49PM -0600, Naik, Avadhut wrote:
> Hi,
> 
> Any further comments on this patch?

No. I like the comments you added to address my earlier
confusion/concerns.

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony

> 
> On 12/18/2023 11:13 AM, Avadhut Naik wrote:
> > Hi,
> > 
> > Any further feedback on this patch?
> > 
> > On 12/4/2023 13:25, Avadhut Naik wrote:
> >> To support GHES_ASSIST on Machine Check Architecture (MCA) error sources,
> >> a set of GHES structures is provided by the system firmware for each MCA
> >> error source. Each of these sets consists of a GHES structure for each MCA
> >> bank on each logical CPU, with all structures of a set sharing a common
> >> Related Source ID, equal to the Source ID of one of the MCA error source
> >> structures.[1] On SOCs with large core counts, this typically equates to
> >> tens of thousands of GHES_ASSIST structures for MCA under
> >> "/sys/bus/platform/drivers/GHES".
> >>
> >> Support for GHES_ASSIST however, hasn't been implemented in the kernel. As
> >> such, the information provided through these structures is not consumed by
> >> Linux. Moreover, these GHES_ASSIST structures for MCA, which are supposed
> >> to provide supplemental information in context of an error reported by
> >> hardware, are setup as independent error sources by the kernel during HEST
> >> initialization.
> >>
> >> Additionally, if the Type field of the Notification structure, associated
> >> with these GHES_ASSIST structures for MCA, is set to Polled, the kernel
> >> sets up a timer for each individual structure. The duration of the timer
> >> is derived from the Poll Interval field of the Notification structure. On
> >> SOCs with high core counts, this will result in tens of thousands of
> >> timers expiring periodically causing unnecessary preemptions and wastage
> >> of CPU cycles. The problem will particularly intensify if Poll Interval
> >> duration is not sufficiently high.
> >>
> >> Since GHES_ASSIST support is not present in kernel, skip initialization
> >> of GHES_ASSIST structures for MCA to eliminate their performance impact.
> >>
> >> [1] ACPI specification 6.5, section 18.7
> >>
> >> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> >> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> >> ---
> >> Changes in v2:
> >> 1.	Since is_ghes_assist_struct() returns if any of the conditions is hit
> >> if-else-if chain is redundant. Replace it with just if statements.
> >> 2.	Fix formatting errors.
> >> 3.	Add Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> >>
> >> Changes in v3:
> >> 1. Modify structure (mces) comment, per Tony's recommendation, to better
> >> reflect the structure's usage.
> >> ---
> >>  drivers/acpi/apei/hest.c | 51 ++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 51 insertions(+)
> >>
> >> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> >> index 6aef1ee5e1bd..20d757687e3d 100644
> >> --- a/drivers/acpi/apei/hest.c
> >> +++ b/drivers/acpi/apei/hest.c
> >> @@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hest_disable);
> >>  
> >>  static struct acpi_table_hest *__read_mostly hest_tab;
> >>  
> >> +/*
> >> + * Since GHES_ASSIST is not supported, skip initialization of GHES_ASSIST
> >> + * structures for MCA.
> >> + * During HEST parsing, detected MCA error sources are cached from early
> >> + * table entries so that the Flags and Source Id fields from these cached
> >> + * values are then referred to in later table entries to determine if the
> >> + * encountered GHES_ASSIST structure should be initialized.
> >> + */
> >> +static struct {
> >> +	struct acpi_hest_ia_corrected *cmc;
> >> +	struct acpi_hest_ia_machine_check *mc;
> >> +	struct acpi_hest_ia_deferred_check *dmc;
> >> +} mces;
> >> +
> >>  static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
> >>  	[ACPI_HEST_TYPE_IA32_CHECK] = -1,	/* need further calculation */
> >>  	[ACPI_HEST_TYPE_IA32_CORRECTED_CHECK] = -1,
> >> @@ -70,22 +84,54 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
> >>  		cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
> >>  		len = sizeof(*cmc) + cmc->num_hardware_banks *
> >>  			sizeof(struct acpi_hest_ia_error_bank);
> >> +		mces.cmc = cmc;
> >>  	} else if (hest_type == ACPI_HEST_TYPE_IA32_CHECK) {
> >>  		struct acpi_hest_ia_machine_check *mc;
> >>  		mc = (struct acpi_hest_ia_machine_check *)hest_hdr;
> >>  		len = sizeof(*mc) + mc->num_hardware_banks *
> >>  			sizeof(struct acpi_hest_ia_error_bank);
> >> +		mces.mc = mc;
> >>  	} else if (hest_type == ACPI_HEST_TYPE_IA32_DEFERRED_CHECK) {
> >>  		struct acpi_hest_ia_deferred_check *mc;
> >>  		mc = (struct acpi_hest_ia_deferred_check *)hest_hdr;
> >>  		len = sizeof(*mc) + mc->num_hardware_banks *
> >>  			sizeof(struct acpi_hest_ia_error_bank);
> >> +		mces.dmc = mc;
> >>  	}
> >>  	BUG_ON(len == -1);
> >>  
> >>  	return len;
> >>  };
> >>  
> >> +/*
> >> + * GHES and GHESv2 structures share the same format, starting from
> >> + * Source Id and ending in Error Status Block Length (inclusive).
> >> + */
> >> +static bool is_ghes_assist_struct(struct acpi_hest_header *hest_hdr)
> >> +{
> >> +	struct acpi_hest_generic *ghes;
> >> +	u16 related_source_id;
> >> +
> >> +	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
> >> +	    hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
> >> +		return false;
> >> +
> >> +	ghes = (struct acpi_hest_generic *)hest_hdr;
> >> +	related_source_id = ghes->related_source_id;
> >> +
> >> +	if (mces.cmc && mces.cmc->flags & ACPI_HEST_GHES_ASSIST &&
> >> +	    related_source_id == mces.cmc->header.source_id)
> >> +		return true;
> >> +	if (mces.mc && mces.mc->flags & ACPI_HEST_GHES_ASSIST &&
> >> +	    related_source_id == mces.mc->header.source_id)
> >> +		return true;
> >> +	if (mces.dmc && mces.dmc->flags & ACPI_HEST_GHES_ASSIST &&
> >> +	    related_source_id == mces.dmc->header.source_id)
> >> +		return true;
> >> +
> >> +	return false;
> >> +}
> >> +
> >>  typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
> >>  
> >>  static int apei_hest_parse(apei_hest_func_t func, void *data)
> >> @@ -114,6 +160,11 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
> >>  			return -EINVAL;
> >>  		}
> >>  
> >> +		if (is_ghes_assist_struct(hest_hdr)) {
> >> +			hest_hdr = (void *)hest_hdr + len;
> >> +			continue;
> >> +		}
> >> +
> >>  		rc = func(hest_hdr, data);
> >>  		if (rc)
> >>  			return rc;
> >>
> >> base-commit: 629a3b49f3f957e975253c54846090b8d5ed2e9b
> > 
> 
> -- 
> Thanks,
> Avadhut Naik

