Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E4E7AA507
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjIUW1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjIUW12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3331BC6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695315609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Y5SoJ9MH2LvAlChqhtoNZjyaWnLg3jstc/Ac0bYhH0=;
        b=hv5Y9yC8xFlwvdBuzwNw2TMowbMyijreriRNID5uWrPf7hRnnOg33ELac0+cBaTwwON1SE
        CeC04dANbiJUGMOtI01Y1V7GluD8Cqjq+pOGakMjU51uhc/YmL4kbUk/zpNxRG5i+hPKm5
        kPX8L0jShG+4p9pn2Pcp8lhHh1VaBw4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-bWoT-e1rOtqslnBRlqC5bg-1; Thu, 21 Sep 2023 12:38:30 -0400
X-MC-Unique: bWoT-e1rOtqslnBRlqC5bg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-993eeb3a950so90365066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695314309; x=1695919109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Y5SoJ9MH2LvAlChqhtoNZjyaWnLg3jstc/Ac0bYhH0=;
        b=tVY39msqmtqfYfK8FRLCiTkpJbToaq4zuw4on7tx0+7mWc1cerrLDetSQj4Pb3vJQi
         bsDb0aadT7M4WT39Hv77G403G8DvgPhcTMoaxgJA7ihPYQv895eAOvr4dBiUgZSS0FJg
         fLJ2TEniPaP44qIzwbkYZy0soPlMVSHuSRPFW0hGr44HnjNcobf0lL6K6yv7X30dln+e
         amIVp4CtvRsQwRz53AhHvFDl581nKUS4CdzKRYzNc2aHppIiqjifRitfGCmMshFkLc8U
         sd05qPqWjv/aAYP3BlFx8yy4GRp+sy834YQLUydOBE13JtZc4x5mtnOLrV26grTUX2u1
         Tqbg==
X-Gm-Message-State: AOJu0YxvHXBdbYhyj84d5B272a23gF5W3zeaazrmVt6Ya5mAozL9U3v+
        A5lwltzRDFL+BQ3JzK4y7WY/AJbI1yhUgEsfCy0RbszUFnf0S0ucOKP2byaSnFQ43JF3M/FGcjB
        uPjmxoYdINkqF6IhNgllArJah
X-Received: by 2002:a17:907:b12:b0:9a2:225a:8d01 with SMTP id h18-20020a1709070b1200b009a2225a8d01mr5259396ejl.7.1695314309477;
        Thu, 21 Sep 2023 09:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyWR/oL+0uB2onxR8tUnhpBEiAldf+hdUkM70huhyaqEyRi1C+dLpGym8L7IU2J0iRGAwxZw==
X-Received: by 2002:a17:907:b12:b0:9a2:225a:8d01 with SMTP id h18-20020a1709070b1200b009a2225a8d01mr5259386ejl.7.1695314309099;
        Thu, 21 Sep 2023 09:38:29 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906591500b0099bd0b5a2bcsm1281356ejq.101.2023.09.21.09.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 09:38:28 -0700 (PDT)
Message-ID: <e29cd141-0f38-e806-51cb-bc82c451b9c4@redhat.com>
Date:   Thu, 21 Sep 2023 18:38:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] platform/x86: think-lmi: Add bulk save feature
Content-Language: en-US, nl
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     markgross@kernel.org, andriy.shevchenko@intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20230919141530.4805-1-mpearson-lenovo@squebb.ca>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230919141530.4805-1-mpearson-lenovo@squebb.ca>
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

Hi Mark,

On 9/19/23 16:15, Mark Pearson wrote:
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
> ---
> Changes in v2:
>  - Correct kernel version in documentation
>  - Updated to sysfs_emit
>  - Clean up code in save_settings_store as recommended
>  - Use correct comment formatting

Thank you for the new version, but next time when a patch has
already been merged please send any fixes as a follow-up /
separate patch with just the fixes.

I've replaced the original patch with this one now doing
a forced push to both my review-hans and the for-next
branch.

Regards,

Hans





> 
>  .../testing/sysfs-class-firmware-attributes   |  30 ++++
>  drivers/platform/x86/think-lmi.c              | 152 ++++++++++++++++--
>  drivers/platform/x86/think-lmi.h              |  16 ++
>  3 files changed, 183 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> index f205d39409a3..9c82c7b42ff8 100644
> --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> @@ -383,6 +383,36 @@ Description:
>  		Note that any changes to this attribute requires a reboot
>  		for changes to take effect.
>  
> +What:		/sys/class/firmware-attributes/*/attributes/save_settings
> +Date:		August 2023
> +KernelVersion:	6.6
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
> index 52d1ce8dfe44..6f9fa80b19fc 100644
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
> +	if (WARN_ON(tlmi_priv.save_mode < TLMI_SAVE_SINGLE ||
> +		    tlmi_priv.save_mode > TLMI_SAVE_BULK))
> +		return -EIO;
> +	return sysfs_emit(buf, "%s\n", save_mode_strings[tlmi_priv.save_mode]);
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
> +	if (cmd < 0)
> +		return cmd;
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
> +		if (!tlmi_priv.can_set_bios_settings ||
> +		    tlmi_priv.save_mode == TLMI_SAVE_SINGLE) {
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
> index 4daba6151cd6..e1975ffebeb4 100644
> --- a/drivers/platform/x86/think-lmi.h
> +++ b/drivers/platform/x86/think-lmi.h
> @@ -27,6 +27,19 @@ enum level_option {
>  	TLMI_LEVEL_MASTER,
>  };
>  
> +/*
> + * There are a limit on the number of WMI operations you can do if you use
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
> @@ -86,6 +99,9 @@ struct think_lmi {
>  	bool can_debug_cmd;
>  	bool opcode_support;
>  	bool certificate_support;
> +	enum save_mode save_mode;
> +	bool save_required;
> +	bool reboot_required;
>  
>  	struct tlmi_attr_setting *setting[TLMI_SETTINGS_COUNT];
>  	struct device *class_dev;

