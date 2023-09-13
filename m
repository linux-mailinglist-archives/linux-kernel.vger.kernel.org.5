Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1139B79EF20
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjIMQoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjIMQn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:43:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75BE0420E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694623239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g0aLIFFDSBpbpLkAvAxYd71PTXHU6ggKEjN1XOK5kQo=;
        b=Llz7Q+U1L9XgxZhm4blGFW8t9skY7h0+q8ePepkJHUEpmQGkXBCNvyqWI7vpM/h1PGnZTf
        2r4sH/vYf1wgdWH/ZBdZb3P8e+FbVjtR33QBujW47NDO01bioRmGDxwNx3OaPUOSpefUqt
        uI+rPztfwMOiy4RgqlnHcts97RRZnDE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-jAJdMJ9VN5-taT4VVcfNOQ-1; Wed, 13 Sep 2023 12:40:37 -0400
X-MC-Unique: jAJdMJ9VN5-taT4VVcfNOQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-978a991c3f5so6139766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694623236; x=1695228036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0aLIFFDSBpbpLkAvAxYd71PTXHU6ggKEjN1XOK5kQo=;
        b=D0KErtfuVgPpiYvvgmic0yVZZPn7uqZpqNRFaMncjMtBHWshOwaTBm82kfhaHk1W8l
         s3UqJahUKjVAamrnmZtX66PID/OO4VTssM/N+HjceWGkRZ1WhQ4e+WDk9LhSIzbKQ4fK
         d2Ew7GyeC4sfz2IUEcbkSRv35CGRCAXTD8laWVKv2JZq5zf3UilfIp0qLypVT3ydjPv7
         RHP1yqtPJu4NbQZB5KO1U4rjRD7gk1cwg40Ep/rzb5GYt8fwJltncudhRloGcOWw0cTa
         okxRdnRbpMf3Wwrp0zP43wpIPov9D4mO2KJ7bIsK2It+JG+yRZsKiL2EyPGzKHKvVG3W
         3Ujg==
X-Gm-Message-State: AOJu0Yzalh51/POxDeSxTejRDm8OxIiX7ihLwFU+tyi2+1JzvGuoX/MY
        colHszWYx/3RDFz8JLU+H118opewD4gkvU+V3SCg5TqqED6q0jwB/HD/NLK3VG/sUBdwu90oBwn
        BYnR5tRs49ctaBtl3laOt8CKi
X-Received: by 2002:a17:906:8468:b0:99d:6b3c:3d40 with SMTP id hx8-20020a170906846800b0099d6b3c3d40mr2309633ejc.6.1694623236717;
        Wed, 13 Sep 2023 09:40:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmO4cDGlmI7FUyTuA4rIh+7DFY1qGORDLf53qavXa66JUxmblLVzn5tdHfe+owYmuo75ynDw==
X-Received: by 2002:a17:906:8468:b0:99d:6b3c:3d40 with SMTP id hx8-20020a170906846800b0099d6b3c3d40mr2309621ejc.6.1694623236312;
        Wed, 13 Sep 2023 09:40:36 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id l15-20020a1709066b8f00b0099bca8b9a31sm8571966ejr.100.2023.09.13.09.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 09:40:35 -0700 (PDT)
Message-ID: <f4e846f0-1084-0999-0fb7-592198666bc5@redhat.com>
Date:   Wed, 13 Sep 2023 18:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] platform/x86: think-lmi: Add bulk save feature
Content-Language: en-US, nl
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20230906121328.50437-1-mpearson-lenovo@squebb.ca>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230906121328.50437-1-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/6/23 14:13, Mark Pearson wrote:
> On Lenovo platforms there is a limitation in the number of times an
> attribute can be saved. This is an architectural limitation and it limits
> the number of attributes that can be modified to 48.
> A solution for this is instead of the attribute being saved after every
> modification allow a user to bulk set the attributes and then trigger a
> final save. This allows unlimited attributes.
> 
> This patch introduces a save_settings attribute that can be configured to
> either single or bulk mode by the user.
> Single mode is the default but customers who want to avoid the 48
> attribute limit can enable bulk mode.
> 
> Displaying the save_settings attribute will display the enabled mode.
> 
> When in bulk mode writing 'save' to the save_settings attribute will
> trigger a save. Once this has been done a reboot is required before more
> attributes can be modified.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
> Changes in v2: Improve string handling in store and show functions. Use
> sysfs_match_string for cleaner implementation.
> 
>  .../testing/sysfs-class-firmware-attributes   |  30 ++++
>  drivers/platform/x86/think-lmi.c              | 152 ++++++++++++++++--
>  drivers/platform/x86/think-lmi.h              |  15 ++
>  3 files changed, 182 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> index f205d39409a3..c2f1a044475e 100644
> --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> @@ -383,6 +383,36 @@ Description:
>  		Note that any changes to this attribute requires a reboot
>  		for changes to take effect.
>  
> +What:		/sys/class/firmware-attributes/*/attributes/save_settings
> +Date:		August 2023
> +KernelVersion:	6.5
> +Contact:	Mark Pearson <mpearson-lenovo@squebb.ca>
> +Description:
> +		On Lenovo platforms there is a limitation in the number of times an attribute can be
> +		saved. This is an architectural limitation and it limits the number of attributes
> +		that can be modified to 48.
> +		A solution for this is instead of the attribute being saved after every modification,
> +		to allow a user to bulk set the attributes, and then trigger a final save. This allows
> +		unlimited attributes.
> +
> +		Read the attribute to check what save mode is enabled (single or bulk).
> +		E.g:
> +		# cat /sys/class/firmware-attributes/thinklmi/attributes/save_settings
> +		single
> +
> +		Write the attribute with 'bulk' to enable bulk save mode.
> +		Write the attribute with 'single' to enable saving, after every attribute set.
> +		The default setting is single mode.
> +		E.g:
> +		# echo bulk > /sys/class/firmware-attributes/thinklmi/attributes/save_settings
> +
> +		When in bulk mode write 'save' to trigger a save of all currently modified attributes.
> +		Note, once a save has been triggered, in bulk mode, attributes can no longer be set and
> +		will return a permissions error. This is to prevent users hitting the 48+ save limitation
> +		(which requires entering the BIOS to clear the error condition)
> +		E.g:
> +		# echo save > /sys/class/firmware-attributes/thinklmi/attributes/save_settings
> +
>  What:		/sys/class/firmware-attributes/*/attributes/debug_cmd
>  Date:		July 2021
>  KernelVersion:	5.14
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 52d1ce8dfe44..a319a358ddcf 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -985,6 +985,13 @@ static ssize_t current_value_store(struct kobject *kobj,
>  	if (!tlmi_priv.can_set_bios_settings)
>  		return -EOPNOTSUPP;
>  
> +	/*
> +	 * If we are using bulk saves a reboot should be done once save has
> +	 * been called
> +	 */
> +	if (tlmi_priv.save_mode == TLMI_SAVE_BULK && tlmi_priv.reboot_required)
> +		return -EPERM;
> +
>  	new_setting = kstrdup(buf, GFP_KERNEL);
>  	if (!new_setting)
>  		return -ENOMEM;
> @@ -1011,10 +1018,11 @@ static ssize_t current_value_store(struct kobject *kobj,
>  		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTING_CERT_GUID, set_str);
>  		if (ret)
>  			goto out;
> -		ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
> -				tlmi_priv.pwd_admin->save_signature);
> -		if (ret)
> -			goto out;
> +		if (tlmi_priv.save_mode == TLMI_SAVE_BULK)
> +			tlmi_priv.save_required = true;
> +		else
> +			ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
> +					       tlmi_priv.pwd_admin->save_signature);
>  	} else if (tlmi_priv.opcode_support) {
>  		/*
>  		 * If opcode support is present use that interface.
> @@ -1033,14 +1041,17 @@ static ssize_t current_value_store(struct kobject *kobj,
>  		if (ret)
>  			goto out;
>  
> -		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
> -			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
> -						  tlmi_priv.pwd_admin->password);
> -			if (ret)
> -				goto out;
> +		if (tlmi_priv.save_mode == TLMI_SAVE_BULK) {
> +			tlmi_priv.save_required = true;
> +		} else {
> +			if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
> +				ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
> +							  tlmi_priv.pwd_admin->password);
> +				if (ret)
> +					goto out;
> +			}
> +			ret = tlmi_save_bios_settings("");
>  		}
> -
> -		ret = tlmi_save_bios_settings("");
>  	} else { /* old non-opcode based authentication method (deprecated) */
>  		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
>  			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
> @@ -1068,10 +1079,14 @@ static ssize_t current_value_store(struct kobject *kobj,
>  		if (ret)
>  			goto out;
>  
> -		if (auth_str)
> -			ret = tlmi_save_bios_settings(auth_str);
> -		else
> -			ret = tlmi_save_bios_settings("");
> +		if (tlmi_priv.save_mode == TLMI_SAVE_BULK) {
> +			tlmi_priv.save_required = true;
> +		} else {
> +			if (auth_str)
> +				ret = tlmi_save_bios_settings(auth_str);
> +			else
> +				ret = tlmi_save_bios_settings("");
> +		}
>  	}
>  	if (!ret && !tlmi_priv.pending_changes) {
>  		tlmi_priv.pending_changes = true;
> @@ -1152,6 +1167,107 @@ static ssize_t pending_reboot_show(struct kobject *kobj, struct kobj_attribute *
>  
>  static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
>  
> +static const char * const save_mode_strings[] = {
> +	[TLMI_SAVE_SINGLE] = "single",
> +	[TLMI_SAVE_BULK] = "bulk",
> +	[TLMI_SAVE_SAVE] = "save"
> +};
> +
> +static ssize_t save_settings_show(struct kobject *kobj, struct kobj_attribute *attr,
> +				  char *buf)
> +{
> +	/* Check that setting is valid */
> +	if (WARN_ON((tlmi_priv.save_mode < TLMI_SAVE_SINGLE) ||
> +		    (tlmi_priv.save_mode > TLMI_SAVE_BULK)))
> +		return -EIO;
> +	return sprintf(buf, "%s\n", save_mode_strings[tlmi_priv.save_mode]);
> +}
> +
> +static ssize_t save_settings_store(struct kobject *kobj, struct kobj_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	char *auth_str = NULL;
> +	int ret = 0;
> +	int cmd;
> +
> +	cmd = sysfs_match_string(save_mode_strings, buf);
> +
> +	/* Use lock in case multiple WMI operations needed */
> +	mutex_lock(&tlmi_mutex);
> +
> +	switch (cmd) {
> +	case TLMI_SAVE_SINGLE:
> +	case TLMI_SAVE_BULK:
> +		tlmi_priv.save_mode = cmd;
> +		goto out;
> +	case TLMI_SAVE_SAVE:
> +		/* Check if supported*/
> +		if ((!tlmi_priv.can_set_bios_settings) ||
> +		    (tlmi_priv.save_mode == TLMI_SAVE_SINGLE)) {
> +			ret = -EOPNOTSUPP;
> +			goto out;
> +		}
> +		/* Check there is actually something to save */
> +		if (!tlmi_priv.save_required) {
> +			ret = -ENOENT;
> +			goto out;
> +		}
> +		/* Check if certificate authentication is enabled and active */
> +		if (tlmi_priv.certificate_support && tlmi_priv.pwd_admin->cert_installed) {
> +			if (!tlmi_priv.pwd_admin->signature ||
> +			    !tlmi_priv.pwd_admin->save_signature) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
> +					       tlmi_priv.pwd_admin->save_signature);
> +			if (ret)
> +				goto out;
> +		} else if (tlmi_priv.opcode_support) {
> +			if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
> +				ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
> +							  tlmi_priv.pwd_admin->password);
> +				if (ret)
> +					goto out;
> +			}
> +			ret = tlmi_save_bios_settings("");
> +		} else { /* old non-opcode based authentication method (deprecated) */
> +			if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
> +				auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
> +						     tlmi_priv.pwd_admin->password,
> +						     encoding_options[tlmi_priv.pwd_admin->encoding],
> +						     tlmi_priv.pwd_admin->kbdlang);
> +				if (!auth_str) {
> +					ret = -ENOMEM;
> +					goto out;
> +				}
> +			}
> +
> +			if (auth_str)
> +				ret = tlmi_save_bios_settings(auth_str);
> +			else
> +				ret = tlmi_save_bios_settings("");
> +		}
> +		tlmi_priv.save_required = false;
> +		tlmi_priv.reboot_required = true;
> +
> +		if (!ret && !tlmi_priv.pending_changes) {
> +			tlmi_priv.pending_changes = true;
> +			/* let userland know it may need to check reboot pending again */
> +			kobject_uevent(&tlmi_priv.class_dev->kobj, KOBJ_CHANGE);
> +		}
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +out:
> +	mutex_unlock(&tlmi_mutex);
> +	kfree(auth_str);
> +	return ret ?: count;
> +}
> +
> +static struct kobj_attribute save_settings = __ATTR_RW(save_settings);
> +
>  /* ---- Debug interface--------------------------------------------------------- */
>  static ssize_t debug_cmd_store(struct kobject *kobj, struct kobj_attribute *attr,
>  				const char *buf, size_t count)
> @@ -1221,6 +1337,8 @@ static void tlmi_release_attr(void)
>  		}
>  	}
>  	sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &pending_reboot.attr);
> +	sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &save_settings.attr);
> +
>  	if (tlmi_priv.can_debug_cmd && debug_support)
>  		sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &debug_cmd.attr);
>  
> @@ -1302,6 +1420,10 @@ static int tlmi_sysfs_init(void)
>  	if (ret)
>  		goto fail_create_attr;
>  
> +	ret = sysfs_create_file(&tlmi_priv.attribute_kset->kobj, &save_settings.attr);
> +	if (ret)
> +		goto fail_create_attr;
> +
>  	if (tlmi_priv.can_debug_cmd && debug_support) {
>  		ret = sysfs_create_file(&tlmi_priv.attribute_kset->kobj, &debug_cmd.attr);
>  		if (ret)
> diff --git a/drivers/platform/x86/think-lmi.h b/drivers/platform/x86/think-lmi.h
> index 4daba6151cd6..b2e654bd8316 100644
> --- a/drivers/platform/x86/think-lmi.h
> +++ b/drivers/platform/x86/think-lmi.h
> @@ -27,6 +27,18 @@ enum level_option {
>  	TLMI_LEVEL_MASTER,
>  };
>  
> +/* There are a limit on the number of WMI operations you can do if you use
> + * the default implementation of saving on every set. This is due to a
> + * limitation in EFI variable space used.
> + * Have a 'bulk save' mode where you can manually trigger the save, and can
> + * therefore set unlimited variables - for users that need it.
> + */
> +enum save_mode {
> +	TLMI_SAVE_SINGLE,
> +	TLMI_SAVE_BULK,
> +	TLMI_SAVE_SAVE,
> +};
> +
>  /* password configuration details */
>  struct tlmi_pwdcfg_core {
>  	uint32_t password_mode;
> @@ -86,6 +98,9 @@ struct think_lmi {
>  	bool can_debug_cmd;
>  	bool opcode_support;
>  	bool certificate_support;
> +	enum save_mode save_mode;
> +	bool save_required;
> +	bool reboot_required;
>  
>  	struct tlmi_attr_setting *setting[TLMI_SETTINGS_COUNT];
>  	struct device *class_dev;

