Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898177D3BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjJWQPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbjJWQPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:15:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EDA10E;
        Mon, 23 Oct 2023 09:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698077739; x=1729613739;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DxxNhBXgQp4ZWfJVx10BBIGtzohOy5sWX4vR/cTpJFE=;
  b=A77BxqvYQGZc9InKhrFT/PGTYtOXHY+JEeYe3+3g0HU/Be8zzZCzU6lw
   bBRQEbScbI044Rl6ATH0gkvR+QQlGDnUmWjbYZXiCrr4Qac+vPx66j68M
   RJQgrRiPNl2raIQwNl3MFaa6UVR361FoDlGQxw/j9HDp/h5eeOaPJhpu9
   XVR0zzhM0OYDcaMgyqqAD403s3rgJqwJEg3D0o2Y1NwA29qqLcoXeKsnH
   UzEq8yaQPgR5gUmovtGfKC1EKEXEeNwYR1V/KecfHJA9UxCwlFvpPlWGA
   X07T/9x4NYGzPY7CzK0VXsuzhbO1kvb5JRYNsqWt4TDGrUhl7vIJpbMj/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="389721528"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="389721528"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 09:15:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="751679802"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="751679802"
Received: from foliveix-mobl5.amr.corp.intel.com ([10.251.211.194])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 09:15:37 -0700
Date:   Mon, 23 Oct 2023 19:15:34 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V4 13/17] platform/x86/intel/pmc: Display LPM requirements
 for multiple PMCs
In-Reply-To: <20231018231624.1044633-14-david.e.box@linux.intel.com>
Message-ID: <78f6742-af1e-4a33-a52a-b01dd69847d1@linux.intel.com>
References: <20231018231624.1044633-1-david.e.box@linux.intel.com> <20231018231624.1044633-14-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023, David E. Box wrote:

> From: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> 
> Update the substate_requirements attribute to display the requirements for
> all the PMCs on a package.
> 
> Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V4 - No change
> 
> V3 - Add missing submitter signoff
> 
> V2 - no change
> 
>  drivers/platform/x86/intel/pmc/core.c | 129 ++++++++++++++------------
>  1 file changed, 71 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 3894119d61b0..fcb0dc702aea 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -728,7 +728,7 @@ static int pmc_core_substate_l_sts_regs_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_l_sts_regs);
>  
> -static void pmc_core_substate_req_header_show(struct seq_file *s)
> +static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index)
>  {
>  	struct pmc_dev *pmcdev = s->private;
>  	int i, mode;
> @@ -743,68 +743,81 @@ static void pmc_core_substate_req_header_show(struct seq_file *s)
>  static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>  {
>  	struct pmc_dev *pmcdev = s->private;
> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
> -	const struct pmc_bit_map **maps = pmc->map->lpm_sts;
> -	const struct pmc_bit_map *map;
> -	const int num_maps = pmc->map->lpm_num_maps;
> -	u32 sts_offset = pmc->map->lpm_status_offset;
> -	u32 *lpm_req_regs = pmc->lpm_req_regs;
> -	int mp;
> -
> -	/* Display the header */
> -	pmc_core_substate_req_header_show(s);
> -
> -	/* Loop over maps */
> -	for (mp = 0; mp < num_maps; mp++) {
> -		u32 req_mask = 0;
> -		u32 lpm_status;
> -		int mode, idx, i, len = 32;
> -
> -		/*
> -		 * Capture the requirements and create a mask so that we only
> -		 * show an element if it's required for at least one of the
> -		 * enabled low power modes
> -		 */
> -		pmc_for_each_mode(idx, mode, pmcdev)
> -			req_mask |= lpm_req_regs[mp + (mode * num_maps)];
> -
> -		/* Get the last latched status for this map */
> -		lpm_status = pmc_core_reg_read(pmc, sts_offset + (mp * 4));
> -
> -		/*  Loop over elements in this map */
> -		map = maps[mp];
> -		for (i = 0; map[i].name && i < len; i++) {
> -			u32 bit_mask = map[i].bit_mask;
> -
> -			if (!(bit_mask & req_mask))
> -				/*
> -				 * Not required for any enabled states
> -				 * so don't display
> -				 */
> -				continue;
> -
> -			/* Display the element name in the first column */
> -			seq_printf(s, "%30s |", map[i].name);
> -
> -			/* Loop over the enabled states and display if required */
> -			pmc_for_each_mode(idx, mode, pmcdev) {
> -				if (lpm_req_regs[mp + (mode * num_maps)] & bit_mask)
> -					seq_printf(s, " %9s |",
> -						   "Required");
> +	u32 sts_offset;
> +	u32 *lpm_req_regs;
> +	int num_maps, mp, pmc_index;
> +
> +	for (pmc_index = 0; pmc_index < ARRAY_SIZE(pmcdev->pmcs); ++pmc_index) {
> +		struct pmc *pmc = pmcdev->pmcs[pmc_index];
> +		const struct pmc_bit_map **maps;
> +
> +		if (!pmc)
> +			continue;
> +
> +		maps = pmc->map->lpm_sts;
> +		num_maps = pmc->map->lpm_num_maps;
> +		sts_offset = pmc->map->lpm_status_offset;
> +		lpm_req_regs = pmc->lpm_req_regs;
> +
> +		if (!lpm_req_regs)
> +			continue;
> +
> +		/* Display the header */
> +		pmc_core_substate_req_header_show(s, pmc_index);
> +
> +		/* Loop over maps */
> +		for (mp = 0; mp < num_maps; mp++) {
> +			u32 req_mask = 0;
> +			u32 lpm_status;
> +			const struct pmc_bit_map *map;
> +			int mode, idx, i, len = 32;
> +
> +			/*
> +			 * Capture the requirements and create a mask so that we only
> +			 * show an element if it's required for at least one of the
> +			 * enabled low power modes
> +			 */
> +			pmc_for_each_mode(idx, mode, pmcdev)
> +				req_mask |= lpm_req_regs[mp + (mode * num_maps)];
> +
> +			/* Get the last latched status for this map */
> +			lpm_status = pmc_core_reg_read(pmc, sts_offset + (mp * 4));
> +
> +			/*  Loop over elements in this map */
> +			map = maps[mp];
> +			for (i = 0; map[i].name && i < len; i++) {
> +				u32 bit_mask = map[i].bit_mask;
> +
> +				if (!(bit_mask & req_mask)) {
> +					/*
> +					 * Not required for any enabled states
> +					 * so don't display
> +					 */
> +					continue;
> +				}
> +
> +				/* Display the element name in the first column */
> +				seq_printf(s, "pmc%d: %26s |", pmc_index, map[i].name);
> +
> +				/* Loop over the enabled states and display if required */
> +				pmc_for_each_mode(idx, mode, pmcdev) {
> +					if (lpm_req_regs[mp + (mode * num_maps)] & bit_mask)
> +						seq_printf(s, " %9s |",
> +							   "Required");
> +					else
> +						seq_printf(s, " %9s |", " ");

It would be better to not branch like this but alter param instead:

					bool required = lpm_req_regs[...

					seq_printf(s, " %9s |",
						   required ? "Required" : " ");

> +				}
> +
> +				/* In Status column, show the last captured state of this agent */
> +				if (lpm_status & bit_mask)
> +					seq_printf(s, " %9s |", "Yes");
>  				else
>  					seq_printf(s, " %9s |", " ");

Likewise here although I know this comes from the original.

-- 
 i.


> +
> +				seq_puts(s, "\n");
>  			}
> -
> -			/* In Status column, show the last captured state of this agent */
> -			if (lpm_status & bit_mask)
> -				seq_printf(s, " %9s |", "Yes");
> -			else
> -				seq_printf(s, " %9s |", " ");
> -
> -			seq_puts(s, "\n");
>  		}
>  	}
> -
>  	return 0;
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_req_regs);
> 
