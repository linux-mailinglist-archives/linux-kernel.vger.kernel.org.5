Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB5A7E7FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbjKJR6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjKJR4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:56:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250A338EBF;
        Fri, 10 Nov 2023 06:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699626913; x=1731162913;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uo06VXUB/vf5aOi2Yd+6utwASdeGhe7osoEmsxnb6cM=;
  b=TpK99T54Gk6MrDn9+6PrQKX7Z5gvV8gMgQA2ycn243zcFyXq5AilwFzc
   Bqu80dqzbQshq1vMA5IJXCP7Zgzi91Qjm1IQUqQjSj2wqKuxt7lOTGL5h
   F+cK7cu8QV6HBN9quLWZF9ZoNKtd6yuOQ5oi4AUXzF72r5csMPpsXve/e
   Kf1hQ6q2zuXM2KPaGthmeFKDB7iTbtfxEYCFMzvx7fJK4DXp30zX9JbaO
   sLKYX2r/tP9lP88Pwkc/mtDa4C/FsOq94XhoB0NH0ym251fjnpE8iEoJR
   cGZBYZpdjlITqJZmsHVEux5fs3qdiqaR0VpFwiwFNqCcnTn8zaiDP6OKh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="11739533"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="11739533"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 06:35:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="880979315"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="880979315"
Received: from joudin-mobl2.ger.corp.intel.com (HELO mciobota-mobl.ger.corp.intel.com) ([10.252.38.36])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 06:35:09 -0800
Date:   Fri, 10 Nov 2023 16:35:07 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
cc:     Jorge Lopez <jorge.lopez2@hp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com,
        vegard.nossum@oracle.com, darren.kenny@oracle.com
Subject: Re: [PATCH v2 3/4] platform/x86: hp-bioscfg: move mutex_lock down
 in hp_add_other_attributes()
In-Reply-To: <20231110142921.3398072-3-harshit.m.mogalapalli@oracle.com>
Message-ID: <8ebcdb8-e1a-11ce-c42b-e73bdf55a58@linux.intel.com>
References: <20231110142921.3398072-1-harshit.m.mogalapalli@oracle.com> <20231110142921.3398072-3-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-782047625-1699626912=:1596"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-782047625-1699626912=:1596
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 10 Nov 2023, Harshit Mogalapalli wrote:

> attr_name_kobj's memory allocation is done with mutex_lock held, this

Please use () with function names.

> probably is not needed.

Just remove probably.

> Move the mutex_lock downward so we need not unlock when allocation
> fails.

Move allocation outside of mutex_lock() so unlock is not needed when
allocation fails.

The code change looks fine.

-- 
 i.

> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> index 3b735b071a01..351d782f3e96 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> @@ -575,77 +575,75 @@ static void release_attributes_data(void)
>  /**
>   * hp_add_other_attributes() - Initialize HP custom attributes not
>   * reported by BIOS and required to support Secure Platform and Sure
>   * Start.
>   *
>   * @attr_type: Custom HP attribute not reported by BIOS
>   *
>   * Initialize all 2 types of attributes: Platform and Sure Start
>   * object.  Populates each attribute types respective properties
>   * under sysfs files.
>   *
>   * Returns zero(0) if successful. Otherwise, a negative value.
>   */
>  static int hp_add_other_attributes(int attr_type)
>  {
>  	struct kobject *attr_name_kobj;
>  	int ret;
>  	char *attr_name;
>  
> -	mutex_lock(&bioscfg_drv.mutex);
> -
>  	attr_name_kobj = kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
> -	if (!attr_name_kobj) {
> -		ret = -ENOMEM;
> -		goto err_other_attr_init;
> -	}
> +	if (!attr_name_kobj)
> +		return -ENOMEM;
> +
> +	mutex_lock(&bioscfg_drv.mutex);
>  
>  	/* Check if attribute type is supported */
>  	switch (attr_type) {
>  	case HPWMI_SECURE_PLATFORM_TYPE:
>  		attr_name_kobj->kset = bioscfg_drv.authentication_dir_kset;
>  		attr_name = SPM_STR;
>  		break;
>  
>  	case HPWMI_SURE_START_TYPE:
>  		attr_name_kobj->kset = bioscfg_drv.main_dir_kset;
>  		attr_name = SURE_START_STR;
>  		break;
>  
>  	default:
>  		pr_err("Error: Unknown attr_type: %d\n", attr_type);
>  		ret = -EINVAL;
>  		goto err_other_attr_init;
>  	}
>  
>  	ret = kobject_init_and_add(attr_name_kobj, &attr_name_ktype,
>  				   NULL, "%s", attr_name);
>  	if (ret) {
>  		pr_err("Error encountered [%d]\n", ret);
>  		kobject_put(attr_name_kobj);
>  		goto err_other_attr_init;
>  	}
>  
>  	/* Populate attribute data */
>  	switch (attr_type) {
>  	case HPWMI_SECURE_PLATFORM_TYPE:
>  		ret = hp_populate_secure_platform_data(attr_name_kobj);
>  		break;
>  
>  	case HPWMI_SURE_START_TYPE:
>  		ret = hp_populate_sure_start_data(attr_name_kobj);
>  		break;
>  
>  	default:
>  		ret = -EINVAL;
>  	}
>  
>  	if (ret)
>  		goto err_other_attr_init;
>  
>  	mutex_unlock(&bioscfg_drv.mutex);
>  	return 0;
>  
>  err_other_attr_init:
>  	mutex_unlock(&bioscfg_drv.mutex);
>  	return ret;
>  }
> 
--8323329-782047625-1699626912=:1596--
