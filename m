Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCA47A79BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbjITKvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbjITKvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:51:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2F0E6;
        Wed, 20 Sep 2023 03:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695207065; x=1726743065;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Xf+UZEfn7rC+Qte0CL3CXZpBR9LRbgEa0lssvdc8chs=;
  b=fuJXOOFqYHczGBzY9QQoUECs7ImY2NF2BZwuL40cvhnzT4ImW3c4xQ13
   I3yDXwRKLGM/bxrrrwYth0ug0K5gXxIstNQafU2u9zPoWkt7XIvOznnDx
   SzqcbKqLABX5XReryrzIhPM6kWU6ZRAIs7t8AV6JYnQNxkXfabSRnQWFI
   fjAXoxk4sBTae9syyJfzCO59YzupTT7VG2Le8q/YdrOMJ4INjTDBgz9K2
   BYqhumnXRDptg+yX50R+OB7EWb64bDGpO6Elq5lcT4W237BOjsfIWqdDQ
   PYjT2dZQxWY6Lg+kcoObJhVquG8RHz4+guUaZZ45+q0DgYvzHXkKu5WUB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="466501487"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="466501487"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 03:51:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746596854"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="746596854"
Received: from swegrzyn-mobl.ger.corp.intel.com ([10.252.52.91])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 03:51:01 -0700
Date:   Wed, 20 Sep 2023 13:50:58 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Fernando Eckhardt Valle <fevalle@ipt.br>
cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>, corbet@lwn.net,
        hmh@hmh.eng.br, markgross@kernel.org, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86: thinkpad_acpi: sysfs interface to
 auxmac
In-Reply-To: <20230919201136.63736-1-fevalle@ipt.br>
Message-ID: <965b4ab5-3526-c7c-58ab-2252734e3ad6@linux.intel.com>
References: <20230919201136.63736-1-fevalle@ipt.br>
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

On Tue, 19 Sep 2023, Fernando Eckhardt Valle wrote:

> Newer Thinkpads have a feature called MAC Address Pass-through.
> This patch provides a sysfs interface that userspace can use
> to get this auxiliary mac address.
> 
> Signed-off-by: Fernando Eckhardt Valle <fevalle@ipt.br>

Thanks for the update, in general this looks much better already. A few 
further comments below.

> ---
> Changes in v3:
> - Added null terminator to auxmac string when copying auxiliary
> mac address value.
> Changes in v2:
> - Added documentation
> - All handling of the auxmac value is done in the _init function.
> ---
>  .../admin-guide/laptops/thinkpad-acpi.rst     | 20 +++++
>  drivers/platform/x86/thinkpad_acpi.c          | 81 +++++++++++++++++++
>  2 files changed, 101 insertions(+)
> 
> diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
> index e27a1c3f6..98d304010 100644
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
> +Some newer Thinkpads have a feature called MAC Address Pass-through. This
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
> index d70c89d32..ccb4969ac 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10785,6 +10785,82 @@ static struct ibm_struct dprc_driver_data = {
>  	.name = "dprc",
>  };
>  
> +/*
> + * Auxmac
> + *
> + * This auxiliary mac address is enabled in the bios through the
> + * MAC Address Pass-through feature. In most cases, there are three
> + * possibilities: Internal Mac, Second Mac, and disabled.
> + *
> + */
> +
> +#define AUXMAC_LEN 12
> +#define AUXMAC_START 9
> +#define AUXMAC_STRLEN 22
> +#define AUXMAC_BEGIN_MARKER 8
> +#define AUXMAC_END_MARKER 21
> +static char auxmac[AUXMAC_LEN + 1];

Add a newline between the defines and the declaration.

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

Assigment from void * does not need explicit casting.

> +
> +	if (obj->type != ACPI_TYPE_STRING || obj->string.length != AUXMAC_STRLEN) {
> +		pr_info("Invalid buffer for MAC address pass-through.\n");
> +		goto auxmacinvalid;
> +	}
> +
> +	if (obj->string.pointer[AUXMAC_BEGIN_MARKER] != '#' ||
> +	    obj->string.pointer[AUXMAC_END_MARKER] != '#') {
> +		pr_info("Invalid header for MAC address pass-through.\n");
> +		goto auxmacinvalid;
> +	}
> +
> +	if (strncmp(obj->string.pointer + AUXMAC_START, "XXXXXXXXXXXX", AUXMAC_LEN) != 0) {
> +		memcpy(auxmac, obj->string.pointer + AUXMAC_START, AUXMAC_LEN);
> +		auxmac[AUXMAC_LEN] = '\0';
> +	} else
> +		strcpy(auxmac, "disabled");

strcpy() is deprecated, please use strscpy().

https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

Btw, the usual coding style requires braces to be balanced so the else 
should have braces on both sides if either side requires them.

> +	kfree(obj);
> +	return 0;
> +
> +auxmacinvalid:
> +	kfree(obj);
> +	strcpy(auxmac, "unavailable");

strscpy().

Can't you do this strscpy() before you goto here? Then you can share the 
return path with the normal return path since only kfree() remains here.

-- 
 i.


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
> @@ -10843,6 +10919,7 @@ static const struct attribute_group *tpacpi_groups[] = {
>  	&proxsensor_attr_group,
>  	&kbdlang_attr_group,
>  	&dprc_attr_group,
> +	&auxmac_attr_group,
>  	NULL,
>  };
>  
> @@ -11414,6 +11491,10 @@ static struct ibm_init_struct ibms_init[] __initdata = {
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
