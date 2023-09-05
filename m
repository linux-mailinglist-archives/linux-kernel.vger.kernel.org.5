Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F90E792B9A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbjIEQz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353484AbjIEGWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:22:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525FA191;
        Mon,  4 Sep 2023 23:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693894922; x=1725430922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VEoIeRK2p8fuiPJCyGj4dLFE/iZ5NCsrzx+VLk9PNNE=;
  b=dUvSJdiX7lhbKow5UpXMvHQzNxkKmFzV8b1Oky35l9ZnCDiSEuOw+xED
   jyY3csQLwdjwFIIvlMGhP7GcZAdp+d/ygFf1pVyG7Ds8CwOanvOQGR0fm
   Nk9pmwDaMEv4qIIvebld8EK5jHZx73YUeUHkCKTAV7ZnfyyCVJ5T9aufV
   ft8fgale13WKcs6w0DnwLuV60HSRCBDi6FFYXytSGuJ8l5XhEMHMAedlc
   Q+GKYuf7GbLvVrj07Xs5tj9vePLV4lKyF2WPY3eJF0MPaQo466fwTFLtR
   lkl4YCLV2XLN9k0rASZaMcQY+u1TPdDNWn9wdWQ8cb3fTbwZkA+gA1aGl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="380515106"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="380515106"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 23:22:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="806484363"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="806484363"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.153])
  by fmsmga008.fm.intel.com with SMTP; 04 Sep 2023 23:21:58 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 05 Sep 2023 09:21:57 +0300
Date:   Tue, 5 Sep 2023 09:21:57 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        srinivas.pandruvada@intel.com
Subject: Re: [PATCH v2 09/15] powercap/intel_rapl: Cleanup Power Limits
 support
Message-ID: <ZPbJBanVmoMuOhMR@intel.com>
References: <20230419024419.324436-1-rui.zhang@intel.com>
 <20230419024419.324436-10-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230419024419.324436-10-rui.zhang@intel.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 10:44:13AM +0800, Zhang Rui wrote:
> The same set of operations are shared by different Powert Limits,
> including Power Limit get/set, Power Limit enable/disable, clamping
> enable/disable, time window get/set, and max power get/set, etc.
> 
> But the same operation for different Power Limit has different
> primitives because they use different registers/register bits.
> 
> A lot of dirty/duplicate code was introduced to handle this difference.
> 
> Introduce a universal way to issue Power Limit operations.
> Instead of using hardcoded primitive name directly, use Power Limit id
> + operation type, and hide all the Power Limit difference details in a
> central place, get_pl_prim(). Two helpers, rapl_read_pl_data() and
> rapl_write_pl_data(), are introduced at the same time to simplify the
> code for issuing Power Limit operations.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Tested-by: Wang Wendy <wendy.wang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 343 ++++++++++++---------------
>  include/linux/intel_rapl.h           |   1 -
>  2 files changed, 146 insertions(+), 198 deletions(-)
> 
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 8e77df42257a..7f80c35e5c86 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
<snip>
> @@ -818,6 +778,33 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
>  	return ret;
>  }
>  
> +static int rapl_read_pl_data(struct rapl_domain *rd, int pl,
> +			      enum pl_prims pl_prim, bool xlate, u64 *data)
> +{
> +	enum rapl_primitives prim = get_pl_prim(pl, pl_prim);
> +
> +	if (!is_pl_valid(rd, pl))
> +		return -EINVAL;
> +
> +	return rapl_read_data_raw(rd, prim, xlate, data);
> +}
> +
> +static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
> +			       enum pl_prims pl_prim,
> +			       unsigned long long value)
> +{
> +	enum rapl_primitives prim = get_pl_prim(pl, pl_prim);
> +
> +	if (!is_pl_valid(rd, pl))
> +		return -EINVAL;
> +
> +	if (rd->state & DOMAIN_STATE_BIOS_LOCKED) {
> +		pr_warn("%s:%s:%s locked by BIOS\n", rd->rp->name, rd->name, pl_names[pl]);
> +		return -EACCES;

This seems to be causing a lot of WARN level dmesg spam [1] during
suspend/resume on several machines. I suppose previously the
warning was only printed when trying to change the limits explicitly,
but now it gets printed in a lot more cases even if the user didn't
try to change anything.

[1] https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_13594/fi-snb-2520m/igt@i915_suspend@basic-s2idle-without-i915.html

-- 
Ville Syrjälä
Intel
