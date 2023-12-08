Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1017380A48F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjLHNlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHNlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:41:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0C41706;
        Fri,  8 Dec 2023 05:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702042877; x=1733578877;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0PJzpPfQVmmySmavIHtuTDJ47oXFef9tPz7lH278iZA=;
  b=iebnMMueflNm/1lU9OxCPV2E8XQ+k7ubzriyyM5el62Bn4demgJXz6b6
   ntCbPBp2rFGXmQrhBgUzejg5aJMKcC4ipL1p0dFwfYJ0vV2rx4WCkC7ES
   Q6QCz+GtuUHFUMssX1RG7+cqGymvOIsMrMhTIlpZ7aNSzX6Qmr9cmxym+
   TCekVerFBNWs1olvNETfo8X8e2RQopL2nW772aOquBAEJGGdu0Vl3QhIl
   nvFI1v3LZRjWkanOOuw+incYGwm+QpTqH89WfMcZeJVcXQa6ibGOLvBd3
   E2btSXUN3bakDTsBgrfbJ8oW4AHYTXCX1HdiLfR7alci/XsQsMJ1mfJ9M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="384809276"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="384809276"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 05:41:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="772131365"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="772131365"
Received: from smatua-mobl.ger.corp.intel.com ([10.251.223.110])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 05:41:14 -0800
Date:   Fri, 8 Dec 2023 15:41:12 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Armin Wolf <W_Armin@gmx.de>
cc:     Hans de Goede <hdegoede@redhat.com>, corbet@lwn.net,
        Dell.Client.Kernel@dell.com, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] platform/x86: dell-smbios-wmi: Stop using WMI
 chardev
In-Reply-To: <20231207222623.232074-4-W_Armin@gmx.de>
Message-ID: <b4789282-920-e9e-5deb-d107d5bb4c7@linux.intel.com>
References: <20231207222623.232074-1-W_Armin@gmx.de> <20231207222623.232074-4-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023, Armin Wolf wrote:

> The WMI chardev API will be removed in the near future.
> Reimplement the necessary bits used by this driver so
> that userspace software depending on it does no break.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/dell/dell-smbios-wmi.c | 163 ++++++++++++++------
>  1 file changed, 117 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-smbios-wmi.c b/drivers/platform/x86/dell/dell-smbios-wmi.c
> index 931cc50136de..61f40f462eca 100644
> --- a/drivers/platform/x86/dell/dell-smbios-wmi.c
> +++ b/drivers/platform/x86/dell/dell-smbios-wmi.c

> @@ -32,7 +35,9 @@ struct wmi_smbios_priv {
>  	struct list_head list;
>  	struct wmi_device *wdev;
>  	struct device *child;
> -	u32 req_buf_size;
> +	u64 req_buf_size;
> +	u32 hotfix;
> +	struct miscdevice char_dev;
>  };
>  static LIST_HEAD(wmi_list);


>  static int dell_smbios_wmi_probe(struct wmi_device *wdev, const void *context)
>  {
> -	struct wmi_driver *wdriver =
> -		container_of(wdev->dev.driver, struct wmi_driver, driver);
>  	struct wmi_smbios_priv *priv;
> -	u32 hotfix;
> +	u32 buffer_size;
>  	int count;
>  	int ret;
> 
> @@ -162,39 +225,44 @@ static int dell_smbios_wmi_probe(struct wmi_device *wdev, const void *context)
>  	if (!priv)
>  		return -ENOMEM;
> 
> +	priv->wdev = wdev;
> +	dev_set_drvdata(&wdev->dev, priv);
> +
>  	/* WMI buffer size will be either 4k or 32k depending on machine */
> -	if (!dell_wmi_get_size(&priv->req_buf_size))
> +	if (!dell_wmi_get_size(&buffer_size))
>  		return -EPROBE_DEFER;
> 
> +	priv->req_buf_size = buffer_size;
> +
>  	/* some SMBIOS calls fail unless BIOS contains hotfix */
> -	if (!dell_wmi_get_hotfix(&hotfix))
> +	if (!dell_wmi_get_hotfix(&priv->hotfix))
>  		return -EPROBE_DEFER;
> -	if (!hotfix) {
> +
> +	if (!priv->hotfix)
>  		dev_warn(&wdev->dev,
>  			"WMI SMBIOS userspace interface not supported(%u), try upgrading to a newer BIOS\n",
> -			hotfix);
> -		wdriver->filter_callback = NULL;
> -	}
> +			priv->hotfix);
> 
>  	/* add in the length object we will use internally with ioctl */
>  	priv->req_buf_size += sizeof(u64);
> -	ret = set_required_buffer_size(wdev, priv->req_buf_size);
> -	if (ret)
> -		return ret;
> 
>  	count = get_order(priv->req_buf_size);
>  	priv->buf = (void *)__get_free_pages(GFP_KERNEL, count);
>  	if (!priv->buf)
>  		return -ENOMEM;
> 
> +	if (priv->hotfix) {
> +		ret = dell_smbios_wmi_register_chardev(priv);
> +		if (ret)
> +			goto fail_chardev;
> +	}
> +
>  	/* ID is used by dell-smbios to set priority of drivers */
>  	wdev->dev.id = 1;
>  	ret = dell_smbios_register_device(&wdev->dev, &dell_smbios_wmi_call);
>  	if (ret)
>  		goto fail_register;
> 
> -	priv->wdev = wdev;
> -	dev_set_drvdata(&wdev->dev, priv);
>  	mutex_lock(&list_mutex);
>  	list_add_tail(&priv->list, &wmi_list);
>  	mutex_unlock(&list_mutex);
> @@ -202,6 +270,9 @@ static int dell_smbios_wmi_probe(struct wmi_device *wdev, const void *context)
>  	return 0;
> 
>  fail_register:
> +	if (priv->hotfix)
> +               dell_smbios_wmi_unregister_chardev(priv);

I don't understand how hotfix -> priv->hotfix is related to this patch nor 
why it's necessary?

Or did you mean to use it also in dell_smbios_wmi_remove() but forgot to 
add the if (priv->hotfix) there?

In any case, it would be better to put that conversion into own patch 
before this one.

> @@ -211,6 +282,7 @@ static void dell_smbios_wmi_remove(struct wmi_device *wdev)
>        struct wmi_smbios_priv *priv = dev_get_drvdata(&wdev->dev);
>        int count;
>
> +      dell_smbios_wmi_unregister_chardev(priv);
>        mutex_lock(&call_mutex);
>        mutex_lock(&list_mutex);
>        list_del(&priv->list);

-- 
 i.

