Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4669B7E815A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345331AbjKJS12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346107AbjKJS0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:26:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BE8371E8;
        Fri, 10 Nov 2023 05:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699622146; x=1731158146;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9XeZedIwQg8ZXfkQPaf33QRQVLu2yfGJUNSa/st/kWU=;
  b=MNbB2egm4dCHBRz825N0yMpxKimatmZafvjm4ZZLW+XEaLfP0Odpel2G
   sqgrP5V0196Q36uTbYADo6Qa/DSrEP7aX++FjpWBL37ruSHf0318qMe99
   LLdUx6XyGyfZk5icS6+cDF1/srkziboaLfV18q4QRx3j9QMPopcu36HV0
   NxFwINm64AHd/xZalsjk8SeTw+kDhyzBq8e5X3hNj8eafkaA35xTGxYw5
   9LfWdNqhjiOjO3aTJo6YyuxEIvzH1fsFYJaKU/UwFg4asPN2Oal37+5+S
   BIGj3OO3idcTRRBkmz5HcHym5qMC5iNp2Qf3H3pIKK+y6eGdZMfh626zz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="456680773"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="456680773"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 05:15:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="792854238"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="792854238"
Received: from joudin-mobl2.ger.corp.intel.com ([10.252.38.36])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 05:15:42 -0800
Date:   Fri, 10 Nov 2023 15:15:40 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
cc:     Jorge Lopez <jorge.lopez2@hp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] platform/x86: hp-bioscfg: Fix error handling in
 hp_add_other_attributes()
In-Reply-To: <20231110090408.3383881-1-harshit.m.mogalapalli@oracle.com>
Message-ID: <e8f9ec8d-8920-2334-62d9-bb522f5e3a63@linux.intel.com>
References: <20231110090408.3383881-1-harshit.m.mogalapalli@oracle.com>
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

On Fri, 10 Nov 2023, Harshit Mogalapalli wrote:

> 1. acpi_object *obj is unused in this function, so delete it, also
>    delete a unnecessary kfree(obj);
> 2. Fix a memory leak of 'attr_name_kobj' in the error handling path.
> 3. When kobject_init_and_add() fails on every subsequent error path call
>    kobject_put() to cleanup.
> 
> Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202309201412.on0VXJGo-lkp@intel.com/
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is only compile tested, based on static analysis.
> ---
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> index 5798b49ddaba..b28e52b64690 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> @@ -588,7 +588,6 @@ static void release_attributes_data(void)
>  static int hp_add_other_attributes(int attr_type)
>  {
>  	struct kobject *attr_name_kobj;
> -	union acpi_object *obj = NULL;
>  	int ret;
>  	char *attr_name;
>  
> @@ -596,8 +595,8 @@ static int hp_add_other_attributes(int attr_type)
>  
>  	attr_name_kobj = kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
>  	if (!attr_name_kobj) {
> -		ret = -ENOMEM;
> -		goto err_other_attr_init;
> +		mutex_unlock(&bioscfg_drv.mutex);

I don't understand why this has to be inside the mutex at all, cannot 
you just move it outside of the mutex and then there's no need to unlock?

> +		return -ENOMEM;
>  	}
>  
>  	/* Check if attribute type is supported */
> @@ -614,15 +613,15 @@ static int hp_add_other_attributes(int attr_type)
>  
>  	default:
>  		pr_err("Error: Unknown attr_type: %d\n", attr_type);
> -		ret = -EINVAL;
> -		goto err_other_attr_init;
> +		kfree(attr_name_kobj);
> +		mutex_unlock(&bioscfg_drv.mutex);
> +		return -EINVAL;

Add a new label for unlock and goto to it instead.

>  	}
>  
>  	ret = kobject_init_and_add(attr_name_kobj, &attr_name_ktype,
>  				   NULL, "%s", attr_name);
>  	if (ret) {
>  		pr_err("Error encountered [%d]\n", ret);
> -		kobject_put(attr_name_kobj);
>  		goto err_other_attr_init;
>  	}
>  
> @@ -647,10 +646,9 @@ static int hp_add_other_attributes(int attr_type)
>  
>  	mutex_unlock(&bioscfg_drv.mutex);
>  	return 0;
> -
>  err_other_attr_init:
> +	kobject_put(attr_name_kobj);

unlock:

>  	mutex_unlock(&bioscfg_drv.mutex);
> -	kfree(obj);
>  	return ret;
>  }
>  
> 


-- 
 i.

