Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25567A219C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjIOO6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjIOO6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:58:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5305C1BE6;
        Fri, 15 Sep 2023 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694789895; x=1726325895;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2z/dkyd5Stib+6LmzNwLg0OjKOGPr/1NjgAbwJkJ+88=;
  b=AfhE7lNDdF3FlEoqq0xiNx9/fJURdKFkr8i3Rw846Dih00TedPbpqVMz
   dM6QLshuOVCvrYPLA/UmIFcRHydkMTnysFH4N/70OYinddO4wzWNHqGBv
   idVF89RQtrhCoPf9fLfqyopXAr7Yqg+ZLLToQzD0My+qW8oiyMjAfdV7n
   dYPgYA51GGqvFut014hhXfEv6TFinobMtIih653cmXY9Sj5mnpGDEmmBh
   IH3Z7S0D6fUaBkU/TZcdw+eqr4f33chkdIozWpkN3q307riZfbQjHjE8N
   3O6Dd6HBvPzN/V/ROKEVfmA9zrN7DdyWqgMXDOr2niwdDc1gaKM4HbgDY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="410204205"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="410204205"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 07:58:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="1075826203"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="1075826203"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 07:58:01 -0700
Date:   Fri, 15 Sep 2023 17:57:59 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v1 2/2] platform/x86: think-lmi: Use strreplace() to
 replace a character by nul
In-Reply-To: <20230913092701.440959-2-andriy.shevchenko@linux.intel.com>
Message-ID: <227454d0-e33a-179c-b4df-1f486136ca6@linux.intel.com>
References: <20230913092701.440959-1-andriy.shevchenko@linux.intel.com> <20230913092701.440959-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2140016275-1694789883=:2347"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2140016275-1694789883=:2347
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 13 Sep 2023, Andy Shevchenko wrote:

> We can replace
> 	p = strchrnul(str, '$OLD');
> 	*p = '\0';
> with
> 	strreplace(str, '$OLD', '\0');
> that does the compatible modification without a need of the temporary variable.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/think-lmi.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 94a3c7a74bc4..2f20fafe7f55 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -198,14 +198,6 @@ static struct think_lmi tlmi_priv;
>  static struct class *fw_attr_class;
>  static DEFINE_MUTEX(tlmi_mutex);
>  
> -/* ------ Utility functions ------------*/
> -/* Strip out CR if one is present */
> -static void strip_cr(char *str)
> -{
> -	char *p = strchrnul(str, '\n');
> -	*p = '\0';
> -}
> -
>  /* Convert BIOS WMI error string to suitable error code */
>  static int tlmi_errstr_to_err(const char *errstr)
>  {
> @@ -411,7 +403,7 @@ static ssize_t current_password_store(struct kobject *kobj,
>  
>  	strscpy(setting->password, buf, setting->maxlen);
>  	/* Strip out CR if one is present, setting password won't work if it is present */
> -	strip_cr(setting->password);
> +	strreplace(setting->password, '\n', '\0');
>  	return count;
>  }
>  
> @@ -921,7 +913,7 @@ static ssize_t display_name_show(struct kobject *kobj, struct kobj_attribute *at
>  static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
>  {
>  	struct tlmi_attr_setting *setting = to_tlmi_attr_setting(kobj);
> -	char *item, *value, *p;
> +	char *item, *value;
>  	int ret;
>  
>  	ret = tlmi_setting(setting->index, &item, LENOVO_BIOS_SETTING_GUID);
> @@ -934,8 +926,7 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
>  		ret = -EINVAL;
>  	else {
>  		/* On Workstations remove the Options part after the value */
> -		p = strchrnul(value, ';');
> -		*p = '\0';
> +		strreplace(value, ';', '\0');
>  		ret = sysfs_emit(buf, "%s\n", value + 1);
>  	}
>  	kfree(item);
> @@ -1418,7 +1409,6 @@ static int tlmi_analyze(void)
>  	for (i = 0; i < TLMI_SETTINGS_COUNT; ++i) {
>  		struct tlmi_attr_setting *setting;
>  		char *item = NULL;
> -		char *p;
>  
>  		tlmi_priv.setting[i] = NULL;
>  		ret = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
> @@ -1435,8 +1425,7 @@ static int tlmi_analyze(void)
>  		strreplace(item, '/', '\\');
>  
>  		/* Remove the value part */
> -		p = strchrnul(item, ',');
> -		*p = '\0';
> +		strreplace(item, ',', '\0');
>  
>  		/* Create a setting entry */
>  		setting = kzalloc(sizeof(*setting), GFP_KERNEL);
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-2140016275-1694789883=:2347--
