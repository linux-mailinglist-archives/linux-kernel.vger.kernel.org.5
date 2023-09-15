Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2347A2196
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbjIOO5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjIOO5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:57:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2CC1BE6;
        Fri, 15 Sep 2023 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694789858; x=1726325858;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rEf9Z4LNeh54fCUJ0cFYoLvWjBKytco8Ls7maBLYR6w=;
  b=YcInYwXA7fq2V9FayK3s3ZfEueyKzhkJnDjV7dZTf2IbXRO1M5qeM8nY
   kQqvIMwoOQ4bIQqc5BaWmBxoRDtZQmaP4fiYBGf5CKD3gl57kqggddNvf
   W4vRLSrUBRvSeRQHZrL7kM75BTF6HvEuHwrJ6sfdZfjQf4kCaQ16VvjYa
   306GFevNldy4oJtNkjfSgGG9Bjd2/7OfMQ8bUBjR8gSaF0oXHMatuSyTa
   GCGN9B+h2OJ7csIpCndvCfitji/3tMk8Mi02krFjbQDVqGKtQoTa50ePa
   +Kky1eAJlRm99lDXP3hWnVGWKyPtRwnAkN6BITybSuiKqTd6lMCBAVUj1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="410204121"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="410204121"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 07:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="1075825956"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="1075825956"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 07:57:23 -0700
Date:   Fri, 15 Sep 2023 17:57:19 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v1 1/2] platform/x86: think-lmi: Replace kstrdup() +
 strreplace() with kstrdup_and_replace()
In-Reply-To: <20230913092701.440959-1-andriy.shevchenko@linux.intel.com>
Message-ID: <b97ac865-40a7-1278-1fa4-138fdc99f680@linux.intel.com>
References: <20230913092701.440959-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1181405544-1694789845=:2347"
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

--8323329-1181405544-1694789845=:2347
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 13 Sep 2023, Andy Shevchenko wrote:

> Replace open coded functionalify of kstrdup_and_replace() with a call.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/think-lmi.c | 43 +++++++++++---------------------
>  1 file changed, 15 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 79346881cadb..94a3c7a74bc4 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -15,7 +15,7 @@
>  #include <linux/errno.h>
>  #include <linux/fs.h>
>  #include <linux/mutex.h>
> -#include <linux/string.h>
> +#include <linux/string_helpers.h>
>  #include <linux/types.h>
>  #include <linux/dmi.h>
>  #include <linux/wmi.h>
> @@ -432,13 +432,11 @@ static ssize_t new_password_store(struct kobject *kobj,
>  	if (!tlmi_priv.can_set_bios_password)
>  		return -EOPNOTSUPP;
>  
> -	new_pwd = kstrdup(buf, GFP_KERNEL);
> +	/* Strip out CR if one is present, setting password won't work if it is present */
> +	new_pwd = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
>  	if (!new_pwd)
>  		return -ENOMEM;
>  
> -	/* Strip out CR if one is present, setting password won't work if it is present */
> -	strip_cr(new_pwd);
> -
>  	/* Use lock in case multiple WMI operations needed */
>  	mutex_lock(&tlmi_mutex);
>  
> @@ -709,13 +707,11 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
>  	if (!setting->signature || !setting->signature[0])
>  		return -EACCES;
>  
> -	passwd = kstrdup(buf, GFP_KERNEL);
> +	/* Strip out CR if one is present */
> +	passwd = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
>  	if (!passwd)
>  		return -ENOMEM;
>  
> -	/* Strip out CR if one is present */
> -	strip_cr(passwd);
> -
>  	/* Format: 'Password,Signature' */
>  	auth_str = kasprintf(GFP_KERNEL, "%s,%s", passwd, setting->signature);
>  	if (!auth_str) {
> @@ -765,11 +761,10 @@ static ssize_t certificate_store(struct kobject *kobj,
>  		return ret ?: count;
>  	}
>  
> -	new_cert = kstrdup(buf, GFP_KERNEL);
> +	/* Strip out CR if one is present */
> +	new_cert = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
>  	if (!new_cert)
>  		return -ENOMEM;
> -	/* Strip out CR if one is present */
> -	strip_cr(new_cert);
>  
>  	if (setting->cert_installed) {
>  		/* Certificate is installed so this is an update */
> @@ -817,13 +812,11 @@ static ssize_t signature_store(struct kobject *kobj,
>  	if (!tlmi_priv.certificate_support)
>  		return -EOPNOTSUPP;
>  
> -	new_signature = kstrdup(buf, GFP_KERNEL);
> +	/* Strip out CR if one is present */
> +	new_signature = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
>  	if (!new_signature)
>  		return -ENOMEM;
>  
> -	/* Strip out CR if one is present */
> -	strip_cr(new_signature);
> -
>  	/* Free any previous signature */
>  	kfree(setting->signature);
>  	setting->signature = new_signature;
> @@ -846,13 +839,11 @@ static ssize_t save_signature_store(struct kobject *kobj,
>  	if (!tlmi_priv.certificate_support)
>  		return -EOPNOTSUPP;
>  
> -	new_signature = kstrdup(buf, GFP_KERNEL);
> +	/* Strip out CR if one is present */
> +	new_signature = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
>  	if (!new_signature)
>  		return -ENOMEM;
>  
> -	/* Strip out CR if one is present */
> -	strip_cr(new_signature);
> -
>  	/* Free any previous signature */
>  	kfree(setting->save_signature);
>  	setting->save_signature = new_signature;
> @@ -985,13 +976,11 @@ static ssize_t current_value_store(struct kobject *kobj,
>  	if (!tlmi_priv.can_set_bios_settings)
>  		return -EOPNOTSUPP;
>  
> -	new_setting = kstrdup(buf, GFP_KERNEL);
> +	/* Strip out CR if one is present */
> +	new_setting = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
>  	if (!new_setting)
>  		return -ENOMEM;
>  
> -	/* Strip out CR if one is present */
> -	strip_cr(new_setting);
> -
>  	/* Use lock in case multiple WMI operations needed */
>  	mutex_lock(&tlmi_mutex);
>  
> @@ -1163,13 +1152,11 @@ static ssize_t debug_cmd_store(struct kobject *kobj, struct kobj_attribute *attr
>  	if (!tlmi_priv.can_debug_cmd)
>  		return -EOPNOTSUPP;
>  
> -	new_setting = kstrdup(buf, GFP_KERNEL);
> +	/* Strip out CR if one is present */
> +	new_setting = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
>  	if (!new_setting)
>  		return -ENOMEM;
>  
> -	/* Strip out CR if one is present */
> -	strip_cr(new_setting);
> -
>  	if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
>  		auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
>  				tlmi_priv.pwd_admin->password,
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1181405544-1694789845=:2347--
