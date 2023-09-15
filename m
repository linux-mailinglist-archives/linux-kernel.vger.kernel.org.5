Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4967A2384
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbjIOQXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbjIOQWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:22:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACDFAC;
        Fri, 15 Sep 2023 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694794966; x=1726330966;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pg5Qfsfw4EoHhGK5PwUoF4RZdbDdImVbr3P2mO/lLhU=;
  b=XDLYtxnNHb8sI4DP4dOSrp7voPG6MSUQtqvMrcAIH7nh1fjCcuQ277ng
   X+b3Kxgka//bbk7VUVjmGVVimoIk9MyNBFPHTYPMNup21poSY+5vuke3g
   2SazdlB8TItkjujLId9k/K83fPaiI18QkuZNJpG58PoGk9p8Mtxaqymgw
   tvn0vRDW5H3wIOsYgAMWC/VIVmSDhosvoEnIWEHni8o9II4zIarUBxWPm
   UEbCPSg+ihNDj6e7/LWgDz16Iqgjda9eiuXcF3FZJqmvceBXvZ84XW+dE
   iKzyDrw+lwML75ufM5PhJ5JFz3K521FqhlTVwSqthR7h8RY0q6aeWYvcy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="383111975"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="383111975"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:18:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="991892255"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="991892255"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:18:34 -0700
Date:   Fri, 15 Sep 2023 19:18:31 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Fernando Eckhardt Valle <fevalle@ipt.br>
cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>, corbet@lwn.net,
        hmh@hmh.eng.br, markgross@kernel.org, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: sysfs interface to
 auxmac
In-Reply-To: <20230915123136.4286-1-fevalle@ipt.br>
Message-ID: <97ac516a-5d9f-f58d-2313-d7d3453f58cb@linux.intel.com>
References: <20230915123136.4286-1-fevalle@ipt.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023, Fernando Eckhardt Valle wrote:

> Newer Thinkpads have a feature called Mac Address Passthrough.
> This patch provides a sysfs interface that userspace can use
> to get this auxiliary mac address.
> 
> Changes in v2:
> - Added documentation
> - All handling of the auxmac value is done in the _init function.
> 
> Signed-off-by: Fernando Eckhardt Valle <fevalle@ipt.br>
> ---
>  .../admin-guide/laptops/thinkpad-acpi.rst     | 20 +++++
>  drivers/platform/x86/thinkpad_acpi.c          | 78 +++++++++++++++++++
>  2 files changed, 98 insertions(+)
> 
> diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
> index e27a1c3f6..6207c363f 100644
> --- a/Documentation/admin-guide/laptops/thinkpad-acpi.rst
> +++ b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
> @@ -53,6 +53,7 @@ detailed description):
>  	- Lap mode sensor
>  	- Setting keyboard language
>  	- WWAN Antenna type
> +	- Auxmac
>  
>  A compatibility table by model and feature is maintained on the web
>  site, http://ibm-acpi.sf.net/. I appreciate any success or failure
> @@ -1511,6 +1512,25 @@ Currently 2 antenna types are supported as mentioned below:
>  The property is read-only. If the platform doesn't have support the sysfs
>  class is not created.
>  
> +Auxmac
> +------
> +
> +sysfs: auxmac
> +
> +Some newer Thinkpads have a feature called MAC Address Passthrough. This
> +feature is implemented by the system firmware to provide a system unique MAC,
> +that can override a dock or USB ethernet dongle MAC, when connected to a
> +network. This property enables user-space to easily determine the MAC address
> +if the feature is enabled.
> +
> +The values of this auxiliary MAC are:
> +
> +        cat /sys/devices/platform/thinkpad_acpi/auxmac
> +
> +If the feature is disabled, the value will be 'disabled'.
> +
> +This property is read-only.
> +
>  Adaptive keyboard
>  -----------------
>  
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index d70c89d32..05cc3a1e2 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10785,6 +10785,79 @@ static struct ibm_struct dprc_driver_data = {
>  	.name = "dprc",
>  };
>  
> +/*
> + * Auxmac
> + *
> + * This auxiliary mac address is enabled in the bios through the
> + * Mac Address Passthrough feature. In most cases, there are three
> + * possibilities: Internal Mac, Second Mac, and disabled.
> + *
> + */
> +
> +#define AUXMAC_LEN 12
> +#define AUXMAC_START 9
> +#define AUXMAC_STRLEN 22
> +static char auxmac[AUXMAC_LEN];
> +
> +static int auxmac_init(struct ibm_init_struct *iibm)
> +{
> +	acpi_status status;
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *obj;
> +
> +	status = acpi_evaluate_object(NULL, "\\MACA", NULL, &buffer);
> +
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	obj = (union acpi_object *)buffer.pointer;
> +
> +	if (obj->type != ACPI_TYPE_STRING || obj->string.length != AUXMAC_STRLEN) {
> +		pr_info("Invalid buffer for mac addr passthrough.\n");

MAC address

> +		goto auxmacinvalid;
> +	}
> +
> +	if (strncmp(obj->string.pointer + 0x8, "#", 1) != 0 ||
> +	    strncmp(obj->string.pointer + 0x15, "#", 1) != 0) {

Why use strncmp with (..., 1)? These offsets should defines above and not 
use literals.

> +		pr_info("Invalid header for mac addr passthrough.\n");

MAC address

> +		goto auxmacinvalid;
> +	}
> +
> +	if (strncmp(obj->string.pointer + 0x9, "XXXXXXXXXXXX", AUXMAC_LEN) == 0)

Why you're not using AUXMAC_START here?

It's also bit confusing that some of the offset are hex and some non-hex 
numbers. 

> +		memcpy(auxmac, "disabled", 9);

Don't use memcpy() for copying a string.

> +	else
> +		memcpy(auxmac, obj->string.pointer + AUXMAC_START, AUXMAC_LEN);

What about the termination of auxmac? It's given 

> +
> +	kfree(obj);
> +	return 0;
> +
> +auxmacinvalid:
> +	kfree(obj);
> +	memcpy(auxmac, "unavailable", 11);

Again, don't use memcpy() to copy a string. You even got it wrong here 
compared with the other case where you copied also the zero terminator.

> +	return 0;
> +}
> +
> +static struct ibm_struct auxmac_data = {
> +	.name = "auxmac",
> +};
> +
> +static ssize_t auxmac_show(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", auxmac);

This requires proper termination for the string but you didn't ensure it 
above.

-- 
 i.

> +}
> +static DEVICE_ATTR_RO(auxmac);
> +
> +static struct attribute *auxmac_attributes[] = {
> +	&dev_attr_auxmac.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group auxmac_attr_group = {
> +	.attrs = auxmac_attributes,
> +};
> +
>  /* --------------------------------------------------------------------- */
>  
>  static struct attribute *tpacpi_driver_attributes[] = {
> @@ -10843,6 +10916,7 @@ static const struct attribute_group *tpacpi_groups[] = {
>  	&proxsensor_attr_group,
>  	&kbdlang_attr_group,
>  	&dprc_attr_group,
> +	&auxmac_attr_group,
>  	NULL,
>  };
>  
> @@ -11414,6 +11488,10 @@ static struct ibm_init_struct ibms_init[] __initdata = {
>  		.init = tpacpi_dprc_init,
>  		.data = &dprc_driver_data,
>  	},
> +	{
> +		.init = auxmac_init,
> +		.data = &auxmac_data,
> +	},
>  };
>  
>  static int __init set_ibm_param(const char *val, const struct kernel_param *kp)
> 

