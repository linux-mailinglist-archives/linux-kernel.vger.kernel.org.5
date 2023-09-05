Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD9B79275D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjIEQCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354395AbjIELSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364AB1AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693912675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lz27U5Kf5m2Y2KJQjXZ9NnxsAx8VJafnm8+91J7UNQE=;
        b=IK0fE8byrkWX0rcv7evBHYLUxi7UZmG1+KtXpRYxPQhdEFrWwKaKyI09oGhlIW/YRk6bQo
        jqJTCOWyUKKPfjxxrbhSRPrmunCgdvnPw7rE+2KiEpDfqGPDrG6w13S6Khvskkv5bDlnQw
        0rqSeO9hfS23tYoK6K6U6JfaSVXj8LQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-rwVz2owKOA-K2Ix9dAET1Q-1; Tue, 05 Sep 2023 07:17:54 -0400
X-MC-Unique: rwVz2owKOA-K2Ix9dAET1Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-997c891a88dso183081066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 04:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693912673; x=1694517473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz27U5Kf5m2Y2KJQjXZ9NnxsAx8VJafnm8+91J7UNQE=;
        b=KzWWgJ/dtlW6BcXuDaqJfkHd3f8hpJduZ24kUxbLcQLJwWjEGc7rPXaPJWA64fajMc
         EtzHXtfZIsKAK8sym1C6SIEWvPtfWYtk15qgo1tHvoMmszMfLYaZ8yWMFeub2d7gXML4
         0lao14b8DTmZkKThWgUyMDGwaJdfCdo6fVR5skL05u9m6aVAV3thsy4QZEEqOn80cFyk
         CVGk9kOahP8mpYpQ/BtuhsOPy7+pEJ1Jm64JR5+RH5KtULozJWbW59Vc+tYtsEbsFmFf
         7BRf9hnsk9Ijr+V+OaGEiy/JayU8L0dSbbzk1mhzi2hM+EVjjkgXaFkurmsussjU2jd0
         QkDQ==
X-Gm-Message-State: AOJu0Yw/Z1wKbUF5hypK7rTnl/HEfZuFgClFScgir43qMcoQK61VXUrb
        p1z/y09e0R7AdiDTQexmQd11VliLKy7SAZ4c25sItQmWlYwYWOJ8YEMCPclQ/zXJB1pDt8/+B+j
        sE0kJE1RONzyywJR6wNSiR2rjfPu7ItZt
X-Received: by 2002:a17:907:a04d:b0:99b:cd1a:a453 with SMTP id gz13-20020a170907a04d00b0099bcd1aa453mr8428063ejc.3.1693912673103;
        Tue, 05 Sep 2023 04:17:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCT4j1lyT19Rz3sk4BZWGzCU4ktQwNW8ng//oZv+HvW9reup1xc9tDgoMScjI5bVO8ew43yQ==
X-Received: by 2002:a17:907:a04d:b0:99b:cd1a:a453 with SMTP id gz13-20020a170907a04d00b0099bcd1aa453mr8428050ejc.3.1693912672724;
        Tue, 05 Sep 2023 04:17:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id g20-20020a1709067c5400b00999bb1e01dfsm7402576ejp.52.2023.09.05.04.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 04:17:52 -0700 (PDT)
Message-ID: <59d1b822-e8e1-9373-1942-0f376abb02b8@redhat.com>
Date:   Tue, 5 Sep 2023 13:17:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] platform/x86: think-lmi: Add bulk save feature
Content-Language: en-US, nl
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20230829131523.17369-1-mpearson-lenovo@squebb.ca>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230829131523.17369-1-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 8/29/23 15:15, Mark Pearson wrote:
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
>  .../testing/sysfs-class-firmware-attributes   |  30 ++++
>  drivers/platform/x86/think-lmi.c              | 134 ++++++++++++++++--
>  drivers/platform/x86/think-lmi.h              |  14 ++
>  3 files changed, 163 insertions(+), 15 deletions(-)
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
> index 52d1ce8dfe44..87e8f06ee7c8 100644
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
> @@ -1152,6 +1167,89 @@ static ssize_t pending_reboot_show(struct kobject *kobj, struct kobj_attribute *
>  
>  static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
>  
> +static ssize_t save_settings_show(struct kobject *kobj, struct kobj_attribute *attr,
> +				  char *buf)
> +{
> +	return sprintf(buf, "%s\n", tlmi_priv.save_mode == TLMI_SAVE_SINGLE ? "single" : "bulk");
> +}
> +
> +static ssize_t save_settings_store(struct kobject *kobj, struct kobj_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	char *auth_str = NULL;
> +	int ret;
> +
> +	/* Check if user is trying to change the save mode */
> +	if (!strncmp(buf, "bulk", 4) || !strncmp(buf, "single", 6)) {
> +		tlmi_priv.save_mode = strncmp(buf, "bulk", 4) ? TLMI_SAVE_SINGLE : TLMI_SAVE_BULK;
> +		return count;
> +	}
> +	if (strncmp(buf, "save", 4))
> +		return -EINVAL;

Things look good up to this point, but I'm not happy
with the string parsing here. Using strncmp to avoid
a possible '\n' means that writing
"bulk extra special with onions" will also match "bulk".

Instead I suggest the following (better names
for the enum are welcome):

	enum { save_single, save_bulk, save_save };

	const char * const save_strings[] = {
		[save_single] = "single",
		[save_bulk] = "bulk",
		[save_save] = "save",
	};

	int ret = 0;
	int cmd;

	cmd = sysfs_match_string(save_strings, buf);
	if (cmd < 0)
		return cmd;

	mutex_lock(&tlmi_mutex);

	switch (cmd) {
	case save_single:
		tlmi_priv.save_mode = TLMI_SAVE_SINGLE;
		goto out;
	case save_bulk:
		tlmi_priv.save_mode = TLMI_SAVE_BULK;
		goto out;
	case save_save:
		break; /* Continue with saving settings */
	}

	/* The user is triggering a save - if supported */
	if (!tlmi_priv.can_set_bios_settings ||
	    tlmi_priv.save_mode == TLMI_SAVE_SINGLE)
		return -EOPNOTSUPP;

	...

This lets sysfs_match_string() do the string parsing work
for us, getting rid of having to do this ourselves.

Notice I have also moved the mutex_lock() up, so that
it is also done for updating the save_mode since we
don't want that the change halfway through a possibly
racing current_value_store() call.


> +
> +	/* Otherwise assume the user is triggering a save - if supported*/
> +	if (!tlmi_priv.can_set_bios_settings ||
> +	    tlmi_priv.save_mode == TLMI_SAVE_SINGLE)
> +		return -EOPNOTSUPP;
> +
> +	/* Check there is actually something to save */
> +	if (!tlmi_priv.save_required)
> +		return -ENOENT;
> +
> +	/* Use lock in case multiple WMI operations needed */
> +	mutex_lock(&tlmi_mutex);
> +
> +	/* Check if certificate authentication is enabled and active */
> +	if (tlmi_priv.certificate_support && tlmi_priv.pwd_admin->cert_installed) {
> +		if (!tlmi_priv.pwd_admin->signature || !tlmi_priv.pwd_admin->save_signature) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
> +				       tlmi_priv.pwd_admin->save_signature);
> +		if (ret)
> +			goto out;
> +	} else if (tlmi_priv.opcode_support) {
> +		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
> +			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
> +						  tlmi_priv.pwd_admin->password);
> +			if (ret)
> +				goto out;
> +		}
> +		ret = tlmi_save_bios_settings("");
> +	} else { /* old non-opcode based authentication method (deprecated) */
> +		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
> +			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
> +					     tlmi_priv.pwd_admin->password,
> +					     encoding_options[tlmi_priv.pwd_admin->encoding],
> +					     tlmi_priv.pwd_admin->kbdlang);
> +			if (!auth_str) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +		}
> +
> +		if (auth_str)
> +			ret = tlmi_save_bios_settings(auth_str);
> +		else
> +			ret = tlmi_save_bios_settings("");
> +	}
> +	tlmi_priv.save_required = false;
> +	tlmi_priv.reboot_required = true;
> +
> +	if (!ret && !tlmi_priv.pending_changes) {
> +		tlmi_priv.pending_changes = true;
> +		/* let userland know it may need to check reboot pending again */
> +		kobject_uevent(&tlmi_priv.class_dev->kobj, KOBJ_CHANGE);
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
> @@ -1221,6 +1319,8 @@ static void tlmi_release_attr(void)
>  		}
>  	}
>  	sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &pending_reboot.attr);
> +	sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &save_settings.attr);
> +
>  	if (tlmi_priv.can_debug_cmd && debug_support)
>  		sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &debug_cmd.attr);
>  
> @@ -1302,6 +1402,10 @@ static int tlmi_sysfs_init(void)
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
> index 4daba6151cd6..0c6304f323ed 100644
> --- a/drivers/platform/x86/think-lmi.h
> +++ b/drivers/platform/x86/think-lmi.h
> @@ -27,6 +27,17 @@ enum level_option {
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
> +};
> +
>  /* password configuration details */
>  struct tlmi_pwdcfg_core {
>  	uint32_t password_mode;
> @@ -86,6 +97,9 @@ struct think_lmi {
>  	bool can_debug_cmd;
>  	bool opcode_support;
>  	bool certificate_support;
> +	enum save_mode save_mode;
> +	bool save_required;
> +	bool reboot_required;
>  
>  	struct tlmi_attr_setting *setting[TLMI_SETTINGS_COUNT];
>  	struct device *class_dev;

Regards,

Hans

