Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDAB7F4449
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbjKVKtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjKVKtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:49:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC09B2;
        Wed, 22 Nov 2023 02:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700650159; x=1732186159;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0rSQb2urA603nTz22RYSdrYHdTMQYrctow0hPn/0OOA=;
  b=SU+VH6pcsmCjjVbSHHCYd0qHi2cX7ciqeVkTfVCbWzgMZR3Ke8ouBwgi
   Fek8YASuu/TtiWdgXWn30gD9+5553J0sHnkFHH867hWH9SL5+AjidbGwK
   uRsvqDn26q4/h4WTVkhU4gyodf71OTHJJ/xz+mXgU3gJa0lbuJ9i9PpNQ
   rXv83MydiMZ/33fSq8Dmb0+UUESTh5FPfiLJ/2VearIKekgHz0qK9Wi6l
   mkWC7qFrRD8mOruv6rzu3YM4b8xpsFWrtTsWFrIUH595kOWtSbXFxP0Eh
   +afCZc/kJYhFEOKTWTLVwNVIn2Atzsawi8k9gcl10zm1H2gtwGD01PEt+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="458526033"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="458526033"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 02:49:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1098353877"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="1098353877"
Received: from johannes-ivm.ger.corp.intel.com ([10.249.47.139])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 02:49:15 -0800
Date:   Wed, 22 Nov 2023 12:49:13 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     David Thompson <davthompson@nvidia.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        vadimp@nvidia.com, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kblaiech@nvidia.com
Subject: Re: [PATCH v2] mlxbf-bootctl: correctly identify secure boot with
 development keys
In-Reply-To: <20231121161216.3803-1-davthompson@nvidia.com>
Message-ID: <1967c625-6d63-badd-6b2c-fe7267bfeb@linux.intel.com>
References: <20231121161216.3803-1-davthompson@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023, David Thompson wrote:

> The secure boot state of the BlueField SoC is represented by two bits:
>                 0 = production state
>                 1 = secure boot enabled
>                 2 = non-secure (secure boot disabled)
>                 3 = RMA state
> There is also a single bit to indicate whether production keys or
> development keys are being used when secure boot is enabled.

Thanks for the extra details but there are more bits that come into play 
here and you mention anything about them. More about this below with the 
relevant code.

> The current logic in "lifecycle_state_show()" does not handle the case
> where the SoC is configured for secure boot and is using development
> keys.

This still doesn't state why the current state is a problem. That is, why
"GA Secured" is a problem.

> This patch updates the logic in "lifecycle_state_show()" to
> support this combination and properly report this state.
> 
> Fixes: 79e29cb8fbc5c ("platform/mellanox: Add bootctl driver for Mellanox BlueField Soc")
> Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> ---
> v1->v2
> a) commit message was expanded and re-worded for clarity
> b) replaced use of hardcoded 0x10 with BIT(4) for MLXBF_BOOTCTL_SB_DEV_MASK
> ---
>  drivers/platform/mellanox/mlxbf-bootctl.c | 24 +++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
> index 1ac7dab22c63..13c62a97a6f7 100644
> --- a/drivers/platform/mellanox/mlxbf-bootctl.c
> +++ b/drivers/platform/mellanox/mlxbf-bootctl.c
> @@ -20,6 +20,7 @@
>  
>  #define MLXBF_BOOTCTL_SB_SECURE_MASK		0x03
>  #define MLXBF_BOOTCTL_SB_TEST_MASK		0x0c
> +#define MLXBF_BOOTCTL_SB_DEV_MASK		BIT(4)

You only covered MLXBF_BOOTCTL_SB_SECURE_MASK and 
MLXBF_BOOTCTL_SB_DEV_MASK in your description above, is that correct?

>  #define MLXBF_SB_KEY_NUM			4
>  
> @@ -40,11 +41,18 @@ static struct mlxbf_bootctl_name boot_names[] = {
>  	{ MLXBF_BOOTCTL_NONE, "none" },
>  };
>  
> +enum {
> +	MLXBF_BOOTCTL_SB_LIFECYCLE_PRODUCTION = 0,
> +	MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE = 1,
> +	MLXBF_BOOTCTL_SB_LIFECYCLE_GA_NON_SECURE = 2,
> +	MLXBF_BOOTCTL_SB_LIFECYCLE_RMA = 3
> +};
> +
>  static const char * const mlxbf_bootctl_lifecycle_states[] = {
> -	[0] = "Production",
> -	[1] = "GA Secured",
> -	[2] = "GA Non-Secured",
> -	[3] = "RMA",
> +	[MLXBF_BOOTCTL_SB_LIFECYCLE_PRODUCTION] = "Production",
> +	[MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE] = "GA Secured",
> +	[MLXBF_BOOTCTL_SB_LIFECYCLE_GA_NON_SECURE] = "GA Non-Secured",
> +	[MLXBF_BOOTCTL_SB_LIFECYCLE_RMA] = "RMA",
>  };
>  
>  /* Log header format. */
> @@ -254,8 +262,9 @@ static ssize_t lifecycle_state_show(struct device *dev,
>  	if (lc_state < 0)
>  		return lc_state;
>  
> -	lc_state &=
> -		MLXBF_BOOTCTL_SB_TEST_MASK | MLXBF_BOOTCTL_SB_SECURE_MASK;
> +	lc_state &= (MLXBF_BOOTCTL_SB_TEST_MASK |
> +		     MLXBF_BOOTCTL_SB_SECURE_MASK |
> +		     MLXBF_BOOTCTL_SB_DEV_MASK);
>  
> @@ -266,6 +275,9 @@ static ssize_t lifecycle_state_show(struct device *dev,

I'm quoting some extra code not fully visible in the contexts:

        /*
         * If the test bits are set, we specify that the current state may be
         * due to using the test bits.
         */
        if (lc_state & MLXBF_BOOTCTL_SB_TEST_MASK) {
                lc_state &= MLXBF_BOOTCTL_SB_SECURE_MASK;

Here what is output also depends on MLXBF_BOOTCTL_SB_TEST_MASK, right?
And those bits even takes precedence over the code you're adding into 
else if branch. So your description in commit message seems quite 
inadequate to me.

Note that you've also added an out-of-bound accesses here since only 
MLXBF_BOOTCTL_SB_SECURE_MASK gets cleared from lc_state:

>  
>  		return sprintf(buf, "%s(test)\n",
>  			       mlxbf_bootctl_lifecycle_states[lc_state]);
> +	} else if ((lc_state & MLXBF_BOOTCTL_SB_SECURE_MASK) == MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE
> +		   && (lc_state & MLXBF_BOOTCTL_SB_DEV_MASK)) {
> +		return sprintf(buf, "Secured (development)\n");
>  	}
>  
>  	return sprintf(buf, "%s\n", mlxbf_bootctl_lifecycle_states[lc_state]);

Here's another potential out-of-bound access if the holes in the above if 
logic aligns.

-- 
 i.

