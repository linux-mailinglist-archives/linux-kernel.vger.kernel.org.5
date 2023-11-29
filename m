Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE717FDFB4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjK2Swg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjK2Swf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:52:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B03C12A;
        Wed, 29 Nov 2023 10:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701283961; x=1732819961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jb00QUCUfnkNo5XLpr7mA45wNEUA/9Y9QPTCp4lOcAI=;
  b=nQmo3yJiBO1nZ6AWiBsGHp0H3UwzpFXdZrUuS5/Qe4G4VUhInzXo4GjI
   EuKtZdPo6P5eWWwFqs2jxbC68AIG+K7sNG4UEadeOP41nrWAsodcTQ+K7
   Mql6CBPsVit+imIpX4DRL4NJLMjYpTs363WPVCd2ADSCtat20+0XX/fOw
   0/wUkC6pbzEXtHiPJBvG0Dj68UftUnMxM9IoHXlzPmQ6uFFkOTzgkTrp0
   u6A/HoL9UkbPfV817/PCuLMaqeBIGngY4rKKAtbdNi+ZeRH/wJ4NkC1B/
   n3sX2c61Zk5Ay3FoNZ9KQskUNURsOyxfngyx6XBK4fc3qUIu+kKM35MRY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="383604020"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="383604020"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 10:52:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="942423252"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="942423252"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 10:52:40 -0800
Date:   Wed, 29 Nov 2023 10:52:39 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Avadhut Naik <avadnaik@amd.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        yazen.ghannam@amd.com, Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [RESEND v2] ACPI: APEI: Skip initialization of GHES_ASSIST
 structures for Machine Check Architecture
Message-ID: <ZWeId332wmrdLycH@agluck-desk3>
References: <20231106201340.434878-1-avadhut.naik@amd.com>
 <c09243d9-b725-49b0-a6ac-163d015ff441@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c09243d9-b725-49b0-a6ac-163d015ff441@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:29:16PM -0600, Avadhut Naik wrote:
> Hi,
> 
> Any further feedback on this patch?

Yes. See below.
> 
> On 11/6/2023 14:13, Avadhut Naik wrote:
> > To support GHES_ASSIST on Machine Check Architecture (MCA) error sources,
> > a set of GHES structures is provided by the system firmware for each MCA
> > error source. Each of these sets consists of a GHES structure for each MCA
> > bank on each logical CPU, with all structures of a set sharing a common
> > Related Source ID, equal to the Source ID of one of the MCA error source
> > structures.[1] On SOCs with large core counts, this typically equates to
> > tens of thousands of GHES_ASSIST structures for MCA under
> > "/sys/bus/platform/drivers/GHES".
> > 
> > Support for GHES_ASSIST however, hasn't been implemented in the kernel. As
> > such, the information provided through these structures is not consumed by
> > Linux. Moreover, these GHES_ASSIST structures for MCA, which are supposed
> > to provide supplemental information in context of an error reported by
> > hardware, are setup as independent error sources by the kernel during HEST
> > initialization.
> > 
> > Additionally, if the Type field of the Notification structure, associated
> > with these GHES_ASSIST structures for MCA, is set to Polled, the kernel
> > sets up a timer for each individual structure. The duration of the timer
> > is derived from the Poll Interval field of the Notification structure. On
> > SOCs with high core counts, this will result in tens of thousands of
> > timers expiring periodically causing unnecessary preemptions and wastage
> > of CPU cycles. The problem will particularly intensify if Poll Interval
> > duration is not sufficiently high.
> > 
> > Since GHES_ASSIST support is not present in kernel, skip initialization
> > of GHES_ASSIST structures for MCA to eliminate their performance impact.
> > 
> > [1] ACPI specification 6.5, section 18.7
> > 
> > Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> > Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> > Changes in v2:
> > 1.	Since is_ghes_assist_struct() returns if any of the conditions is hit
> > if-else-if chain is redundant. Replace it with just if statements.
> > 2.	Fix formatting errors.
> > 3.	Add Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> >  drivers/acpi/apei/hest.c | 51 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> > 
> > diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> > index 6aef1ee5e1bd..99db7621adb7 100644
> > --- a/drivers/acpi/apei/hest.c
> > +++ b/drivers/acpi/apei/hest.c
> > @@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hest_disable);
> >  
> >  static struct acpi_table_hest *__read_mostly hest_tab;
> >  
> > +/*
> > + * Since GHES_ASSIST is not supported, skip initialization
> > + * of GHES_ASSIST structures for MCA.
> > + * During HEST parsing, detected MCA error sources are cached.
> > + * Flags and Source Id fields from these cached values are
> > + * then referred to determine if the encountered GHES_ASSIST
> > + * structure should be initialized.
> > + */
> > +static struct {
> > +	struct acpi_hest_ia_corrected *cmc;
> > +	struct acpi_hest_ia_machine_check *mc;
> > +	struct acpi_hest_ia_deferred_check *dmc;
> > +} mces;

You are using this static structure to save values while computing
the length of the HEST structure in hest_esrc_len() to be used later
when is_ghes_assist_struct() checks to see if it should be skipped.

But you don't clear it between iterations in apei_hest_parse(). So if
the assist structure was early in the array of HEST structures, your
is_ghes_assist_struct() will keep looking at stale mces.{cmc,mc,dmc}
values.

It may not break because the related_source_id in the subsequent
structures won't match the one you saved. But this seems wrong.

On the other hand, if this caching of values from some structures
to be compared against values in later structures is intended. Then
you need a comment on this structure to say that's what you are
doing.

> > +
> >  static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
> >  	[ACPI_HEST_TYPE_IA32_CHECK] = -1,	/* need further calculation */
> >  	[ACPI_HEST_TYPE_IA32_CORRECTED_CHECK] = -1,
> > @@ -70,22 +84,54 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
> >  		cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
> >  		len = sizeof(*cmc) + cmc->num_hardware_banks *
> >  			sizeof(struct acpi_hest_ia_error_bank);
> > +		mces.cmc = cmc;
> >  	} else if (hest_type == ACPI_HEST_TYPE_IA32_CHECK) {
> >  		struct acpi_hest_ia_machine_check *mc;
> >  		mc = (struct acpi_hest_ia_machine_check *)hest_hdr;
> >  		len = sizeof(*mc) + mc->num_hardware_banks *
> >  			sizeof(struct acpi_hest_ia_error_bank);
> > +		mces.mc = mc;
> >  	} else if (hest_type == ACPI_HEST_TYPE_IA32_DEFERRED_CHECK) {
> >  		struct acpi_hest_ia_deferred_check *mc;
> >  		mc = (struct acpi_hest_ia_deferred_check *)hest_hdr;
> >  		len = sizeof(*mc) + mc->num_hardware_banks *
> >  			sizeof(struct acpi_hest_ia_error_bank);
> > +		mces.dmc = mc;
> >  	}
> >  	BUG_ON(len == -1);
> >  
> >  	return len;
> >  };
> >  
> > +/*
> > + * GHES and GHESv2 structures share the same format, starting from
> > + * Source Id and ending in Error Status Block Length (inclusive).
> > + */
> > +static bool is_ghes_assist_struct(struct acpi_hest_header *hest_hdr)
> > +{
> > +	struct acpi_hest_generic *ghes;
> > +	u16 related_source_id;
> > +
> > +	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
> > +	    hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
> > +		return false;
> > +
> > +	ghes = (struct acpi_hest_generic *)hest_hdr;
> > +	related_source_id = ghes->related_source_id;
> > +
> > +	if (mces.cmc && mces.cmc->flags & ACPI_HEST_GHES_ASSIST &&
> > +	    related_source_id == mces.cmc->header.source_id)
> > +		return true;
> > +	if (mces.mc && mces.mc->flags & ACPI_HEST_GHES_ASSIST &&
> > +	    related_source_id == mces.mc->header.source_id)
> > +		return true;
> > +	if (mces.dmc && mces.dmc->flags & ACPI_HEST_GHES_ASSIST &&
> > +	    related_source_id == mces.dmc->header.source_id)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> >  typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
> >  
> >  static int apei_hest_parse(apei_hest_func_t func, void *data)
> > @@ -114,6 +160,11 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
> >  			return -EINVAL;
> >  		}
> >  
> > +		if (is_ghes_assist_struct(hest_hdr)) {
> > +			hest_hdr = (void *)hest_hdr + len;
> > +			continue;
> > +		}
> > +
> >  		rc = func(hest_hdr, data);
> >  		if (rc)
> >  			return rc;
> 
> -- 
> Thanks,
> Avadhut Naik

-Tony
