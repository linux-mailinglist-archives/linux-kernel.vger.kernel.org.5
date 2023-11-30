Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE4C7FEF14
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345422AbjK3M0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbjK3M0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:26:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628C51997;
        Thu, 30 Nov 2023 04:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701347183; x=1732883183;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RoEIdyKdvoc0YWy0wPrPcHsxA+PGoycpnNMawLRTVKQ=;
  b=brdT4UrV6FO/625dGUpI+uoNd/ZSV/yHlyapC0keDmmSnewNe9d2we6S
   j3hAf8hjOEqRCs+NlwhDAEJRkr3RG356t3Ny5qUSaE7ZkguR7yCRed0Bc
   dgteZ7DBoS+eod3A8+R+tjNNGArwOP4ajUiSo6Xnm8KlbB+R5NqEI2A8S
   aCZJB8eXmZNMONo193xnZzZgbNmXAQOFvjdzVWhLsuze/7Sp9zP6KLCc+
   AZLe9H21f5fBMX7MSaIe4/BErit/Tfi/5AAHPqvIwe5TJLKppP2j1G7y7
   Rfcm4saSK7G8ohDbn6MMyjT465GwL1C8YEZdfsVbFXLT7IUWONcxGmJg1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="457637708"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="457637708"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 04:26:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="17214176"
Received: from bergler-mobl.ger.corp.intel.com ([10.249.33.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 04:26:21 -0800
Date:   Thu, 30 Nov 2023 14:26:18 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] platform/x86/intel/tpmi: Don't create devices for
 disabled features
In-Reply-To: <20231128185605.3027653-3-srinivas.pandruvada@linux.intel.com>
Message-ID: <9603f75-3adb-8eba-9322-cbd9551668c8@linux.intel.com>
References: <20231128185605.3027653-1-srinivas.pandruvada@linux.intel.com> <20231128185605.3027653-3-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023, Srinivas Pandruvada wrote:

> If some TPMI features are disabled, don't create auxiliary devices. In
> this way feature drivers will not load.
> 
> While creating auxiliary devices, call tpmi_read_feature_status() to
> check feature state and return if the feature is disabled without
> creating a device.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/platform/x86/intel/tpmi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
> index c89aa4d14bea..4edaa182db04 100644
> --- a/drivers/platform/x86/intel/tpmi.c
> +++ b/drivers/platform/x86/intel/tpmi.c
> @@ -604,9 +604,17 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
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
> +	if (!feature_state.enabled)
> +		return -EOPNOTSUPP;

-ENODEV sounds more appropriate.  

-- 
 i.

