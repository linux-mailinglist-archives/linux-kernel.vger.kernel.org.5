Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FCB7B520C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbjJBMC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbjJBMCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:02:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88791B7;
        Mon,  2 Oct 2023 05:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696248100; x=1727784100;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=X2lNsFi54t5i8ra4NGCnEQUShIBP6jKAEiOaisifSZQ=;
  b=be6DV4Mqoq+5QyW9/ogvP0BFxm2gRmvt/yQcGcnP3znNntlzTCIVPjqK
   9AuEBO9JYXpwLHL9S6G05yTtw6zUwvj59SIb298kPV0foZHYkVfSGqBG+
   U0mcM7Cy6BHn7xdi1yqhG3N9TXQUARNYj56V58TbNOE0EP9qGxZKfNS1a
   82jpTmkDmLdV2qJsqFEFX3OQJVZDo5Ny2KY/NkOUlpudOSNV4FD03TFPt
   1HpfFln8A0ciMrZGqGCvkZDn2jADIu8NjLTAwR1fa6s8uIN3VTwA0l7bj
   mottVSxpuSpBEeSUW4COTlLTTFM8qxHZf40lBUecPe+eMXjdMYXY5lqoL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="446780149"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="446780149"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 05:01:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="1081614648"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1081614648"
Received: from roliveir-mobl1.ger.corp.intel.com ([10.251.222.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 05:01:28 -0700
Date:   Mon, 2 Oct 2023 15:01:26 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Conditionally create
 attribute for read frequency
In-Reply-To: <20231002115622.1588852-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <d725871b-12a0-c2c0-6323-1b7e3a705937@linux.intel.com>
References: <20231002115622.1588852-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2023, Srinivas Pandruvada wrote:

> When the current uncore frequency can't be read, don't create attribute
> "current_freq_khz" as any read will fail later. Some user space
> applications like turbostat fail to continue with the failure. So, check
> error during attribute creation.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Should there be a Fixes tag?

-- 
 i.

> ---
>  .../x86/intel/uncore-frequency/uncore-frequency-common.c  | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
> index 1152deaa0078..33ab207493e3 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
> @@ -176,7 +176,7 @@ show_uncore_data(initial_max_freq_khz);
>  
>  static int create_attr_group(struct uncore_data *data, char *name)
>  {
> -	int ret, index = 0;
> +	int ret, freq, index = 0;
>  
>  	init_attribute_rw(max_freq_khz);
>  	init_attribute_rw(min_freq_khz);
> @@ -197,7 +197,11 @@ static int create_attr_group(struct uncore_data *data, char *name)
>  	data->uncore_attrs[index++] = &data->min_freq_khz_dev_attr.attr;
>  	data->uncore_attrs[index++] = &data->initial_min_freq_khz_dev_attr.attr;
>  	data->uncore_attrs[index++] = &data->initial_max_freq_khz_dev_attr.attr;
> -	data->uncore_attrs[index++] = &data->current_freq_khz_dev_attr.attr;
> +
> +	ret = uncore_read_freq(data, &freq);
> +	if (!ret)
> +		data->uncore_attrs[index++] = &data->current_freq_khz_dev_attr.attr;
> +
>  	data->uncore_attrs[index] = NULL;
>  
>  	data->uncore_attr_group.name = name;
> 
