Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71CE7EE19E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345215AbjKPNiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344962AbjKPNiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:38:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CA99C;
        Thu, 16 Nov 2023 05:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700141898; x=1731677898;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4XUvWNRQgRglkQHuzWKzQgMQJ4YYwlfuTIUE8Uup+I0=;
  b=ckjIskC2OhyYznJtyTBy7M+TFqTSIA2hdo8WAOKCtLcMzcYI+WJdYiyl
   V4cHTfyclxXF7DADnhdC2AJWPqStFOB5YUJTBhnzVKRE+Xz+MwYZU6WIg
   za+vmd39FhT0jZzySoOiWIPqw0FWfTY3GW0JFbqtOqRkBAAMBl/88ML4I
   t384IDJWrom6O9yZqhS2Cl5BhzfwZbtLV21qsoOG8gHkHpJYsTuvNsnP0
   sP8VRrQXHKzAJhjBvhrFr2nXwXPoz/pUQh9NdhZcETsG5iaLhI4zBDi0L
   HMdbu01KY/waUULZRsuXFLIYPbDacoxQNl+utfV4+BteASj1+fryptNh9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="455381008"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="455381008"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 05:38:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="856005354"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="856005354"
Received: from jhsteyn-mobl1.ger.corp.intel.com ([10.252.40.9])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 05:38:15 -0800
Date:   Thu, 16 Nov 2023 15:38:13 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Armin Wolf <W_Armin@gmx.de>
cc:     jithu.joseph@intel.com, Hans de Goede <hdegoede@redhat.com>,
        markgross@kernel.org, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] platform/x86/intel/wmi: thunderbolt: Use bus-based
 WMI interface
In-Reply-To: <20231103182526.3524-4-W_Armin@gmx.de>
Message-ID: <da657e8-d692-c1ad-9016-bcaabb30c37d@linux.intel.com>
References: <20231103182526.3524-1-W_Armin@gmx.de> <20231103182526.3524-4-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-454726224-1700141896=:1886"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-454726224-1700141896=:1886
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 3 Nov 2023, Armin Wolf wrote:

> Currently, the driver still uses the legacy GUID-based interface
> to invoke WMI methods. Use the modern bus-based interface instead.
> 
> Tested on a Lenovo E51-80.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Changes in v2:
> - fix spelling issue
> ---
>  drivers/platform/x86/intel/wmi/thunderbolt.c | 3 +--
>  drivers/platform/x86/wmi.c                   | 1 +
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/wmi/thunderbolt.c b/drivers/platform/x86/intel/wmi/thunderbolt.c
> index fc333ff82d1e..e2ad3f46f356 100644
> --- a/drivers/platform/x86/intel/wmi/thunderbolt.c
> +++ b/drivers/platform/x86/intel/wmi/thunderbolt.c
> @@ -32,8 +32,7 @@ static ssize_t force_power_store(struct device *dev,
>  	mode = hex_to_bin(buf[0]);
>  	dev_dbg(dev, "force_power: storing %#x\n", mode);
>  	if (mode == 0 || mode == 1) {
> -		status = wmi_evaluate_method(INTEL_WMI_THUNDERBOLT_GUID, 0, 1,
> -					     &input, NULL);
> +		status = wmidev_evaluate_method(to_wmi_device(dev), 0, 1, &input, NULL);
>  		if (ACPI_FAILURE(status)) {
>  			dev_dbg(dev, "force_power: failed to evaluate ACPI method\n");
>  			return -ENODEV;
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 4c4effc883ae..cb7e74f2b009 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -107,6 +107,7 @@ static const char * const allow_duplicates[] = {
>  	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
>  	"8A42EA14-4F2A-FD45-6422-0087F7A7E608",	/* dell-wmi-ddv */
>  	"44FADEB1-B204-40F2-8581-394BBDC1B651",	/* intel-wmi-sbl-fw-update */
> +	"86CCFD48-205E-4A77-9C48-2021CBEDE341",	/* intel-wmi-thunderbolt */
>  	NULL
>  };

For the entire series:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-454726224-1700141896=:1886--
