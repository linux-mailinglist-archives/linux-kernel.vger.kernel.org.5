Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D3A7A49B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbjIRMbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241477AbjIRMba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:31:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E752E7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695040232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qhf/uP3BzaKliN1JjTAzysRLJ1VfLUvoN2dZE1cRqW8=;
        b=Tijy0zydyy8oLlHtyLnYgAus3Er19UqinZqUR2BXtgYJt4AFGrNbgk0UDh5LVezb80PgeC
        4VjydNCZRljs1uQo1fJQpWmN9pdshW8R4EUD4/yTrBcc+sGu2yhp09XgDbjkLvJBFJsZcq
        IK4tOmEMkUbGXRur8IiVE6431LrdPuo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-t2DXFbl4NO-QRgLTVPLgDg-1; Mon, 18 Sep 2023 08:30:30 -0400
X-MC-Unique: t2DXFbl4NO-QRgLTVPLgDg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9a1cf3e6c04so328156166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695040230; x=1695645030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhf/uP3BzaKliN1JjTAzysRLJ1VfLUvoN2dZE1cRqW8=;
        b=g7mBMA8mqBcSzY5E3NQIYmIKOFIxlbsLknmTpuYJzPVhv6S1o4Y0dXZbImQWA4vJmX
         vaWq2EEf1soQpaVzGS+b7qMScxOyfj13m557PGT2hXYhb0SQT67raIcgTpWVk9wkCt3w
         zFds3vc42aeH0AkmFsUd+7ymZRcYryrvvEoBQLPQEIENgIjLdeFpCP0gezygyPLtK593
         bDFDu7SCeAytjrollu+MA0K+/VnfgXwbNAZTBFMbiJbAwOfPjLyJtz4XVYOS+yFmGA14
         TrOT/2zTzlMhSdFYt6fkK5jMn/72Ocq6sHEybfcXUVa13Ze3/9uy4xg8vTD+viHWDJUG
         gH/A==
X-Gm-Message-State: AOJu0Yx/G9uNwS80QOFxI9RmHrPfvSVO1ZFSFeMvKB8UwhPyvuBIZG1B
        kXijEoW/V1o6xZDbpr3Un0+biZKaE7lXbgvfMSk0oeVMNF7jvl98VdJnDpcsQKMjltYiNllB15n
        sCA05uPiiCNhp+Z3cJL8XQ6hJ
X-Received: by 2002:a17:906:21a:b0:9ad:e317:33de with SMTP id 26-20020a170906021a00b009ade31733demr6616160ejd.17.1695040229856;
        Mon, 18 Sep 2023 05:30:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu7R3LskG/9HGn8kp3Rk/Nku4TSOXELaWHFwXeIMz9sSGlOoCWdjRY8YTTEq1GkrX6JsjWug==
X-Received: by 2002:a17:906:21a:b0:9ad:e317:33de with SMTP id 26-20020a170906021a00b009ade31733demr6616142ejd.17.1695040229567;
        Mon, 18 Sep 2023 05:30:29 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id se17-20020a170907a39100b009adc86b75d5sm5127516ejc.189.2023.09.18.05.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:30:28 -0700 (PDT)
Message-ID: <77bde3cf-ca94-1cdb-53d8-39df22f8c551@redhat.com>
Date:   Mon, 18 Sep 2023 14:30:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/2] platform/x86: think-lmi: Replace kstrdup() +
 strreplace() with kstrdup_and_replace()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Pearson <markpearson@lenovo.com>,
        Mark Gross <markgross@kernel.org>
References: <20230913092701.440959-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230913092701.440959-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 9/13/23 11:27, Andy Shevchenko wrote:
> Replace open coded functionalify of kstrdup_and_replace() with a call.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for the patches, but this one does not apply
cleanly.

Can you please rebase the series on top of my latest review-hans branch ?

Regards,

Hans



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

