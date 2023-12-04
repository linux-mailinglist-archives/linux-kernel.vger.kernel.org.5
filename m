Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735098037C9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjLDO46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345790AbjLDOa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:30:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5866213E;
        Mon,  4 Dec 2023 06:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701700117; x=1733236117;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5u4R57caJafnF5P5+FowKsO+lhHgZToLy8OifJAyScI=;
  b=Og2rx+JVq61zJptJMfRqaEEUP6vlfad07JPjQMx0UsG7aSYqOWo12PCO
   PhbJySfoMQXHfOMvFYDl3fyq+5LT8rE3j77WfhQ7gzp7Pv3KMCmK1TlJ5
   C/Oq2BxlFMrBclAB9BRTzj9/53ecjxRkLS72ZFt+7MBl02OXEysvtegl+
   UP5qI2DjWGfNJ02QXTG0R/zSxz412K0E5l3T8mIBSvb2kjxj5HjyGyU0A
   +VdpYg8olCg0JlJyF9VQ2VMBzj85+3tTp8rHH8dlU+jnZLINg+P7TNtSy
   g8Kc4J01P4qh4IJ0yZekKXDwkj7wrh4NPAwRyHraLMsL0Ee9SHZ1kjnyD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="384147231"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="384147231"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 06:14:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="720330683"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="720330683"
Received: from malladhi-mobl.gar.corp.intel.com ([10.249.34.28])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 06:14:12 -0800
Date:   Mon, 4 Dec 2023 16:14:09 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] platform/x86/intel/tpmi: Don't create devices
 for disabled features
In-Reply-To: <20231130214751.3100418-2-srinivas.pandruvada@linux.intel.com>
Message-ID: <754da92-fa4e-5340-c9be-348c4b8f97a2@linux.intel.com>
References: <20231130214751.3100418-1-srinivas.pandruvada@linux.intel.com> <20231130214751.3100418-2-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-989722860-1701699254=:3149"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-989722860-1701699254=:3149
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 30 Nov 2023, Srinivas Pandruvada wrote:

> If some TPMI features are disabled, don't create auxiliary devices. In
> this way feature drivers will not load.
> 
> While creating auxiliary devices, call tpmi_read_feature_status() to
> check feature state and return if the feature is disabled without
> creating a device.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2
> - Add comment for returning -EOPNOTSUPP
> 
>  drivers/platform/x86/intel/tpmi.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
> index c89aa4d14bea..868067ff966e 100644
> --- a/drivers/platform/x86/intel/tpmi.c
> +++ b/drivers/platform/x86/intel/tpmi.c
> @@ -604,9 +604,21 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
>  	struct intel_vsec_device *vsec_dev = tpmi_info->vsec_dev;
>  	char feature_id_name[TPMI_FEATURE_NAME_LEN];
>  	struct intel_vsec_device *feature_vsec_dev;
> +	struct tpmi_feature_state feature_state;
>  	struct resource *res, *tmp;
>  	const char *name;
> -	int i;
> +	int i, ret;
> +
> +	ret = tpmi_read_feature_status(tpmi_info, pfs->pfs_header.tpmi_id, &feature_state);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * If not enabled, continue to look at other features in the PFS, so return -EOPNOTSUPP.
> +	 * This will not cause failure of loading of this driver.
> +	 */
> +	if (!feature_state.enabled)
> +		return -EOPNOTSUPP;
>  
>  	name = intel_tpmi_name(pfs->pfs_header.tpmi_id);
>  	if (!name)

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-989722860-1701699254=:3149--
