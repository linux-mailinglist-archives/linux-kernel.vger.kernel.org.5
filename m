Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785227A5C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjISIdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjISIdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:33:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59075181
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695112378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DD7OhrfdclwmkqiRSi/2mVzEoaQ6HLto/eRRJjfIyIM=;
        b=M2K48oKihDcTJi188CCwLiCj8QtbNxUJB21Na6W3Yo1h9U1EdXF7HlJZJ4Fi8rhSPsywnv
        mWLq2qM23gl5972GWrPAU7xETkJ3CzeQ0LpJVFUJFEJ75137ChF+zxkUESrdQB7z2abjhY
        5sINTxbTJ/hie0HI9kj48vMgkL22BeY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-Tjfp0IXKO5ixPNuGwi4dKQ-1; Tue, 19 Sep 2023 04:32:56 -0400
X-MC-Unique: Tjfp0IXKO5ixPNuGwi4dKQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-52f274df255so10314617a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695112375; x=1695717175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DD7OhrfdclwmkqiRSi/2mVzEoaQ6HLto/eRRJjfIyIM=;
        b=EkVze2BJj0/5sHr0FoczVQUW1qVB3oOFNFzYA9n66rl4OwEsO7wYgDbgmxUs+OtUOd
         KWEAtcpsmNs17WkHj+6IQLAx6wSlCY2RrdNRrKFBMfZ2mS2crjSxTjGB0yROuT4COC5S
         NeQyFV6mRF4pZJHK8mmuF6CiiPH61UfTugx31Su0C6v0pj20XaGw1sHedTpmif6CQSkn
         qUdn+sZns86WGeAWYgqfhqdlxUCX/CnLYDAf6mFwfcs/cPC7EfH57zAKf50sFtFt7nGe
         O5GQO5UdmrMI6fwPSdvKgDGreGhMfrXDqQXzwpqW7JBaB8GkubxVm80KuyLatwlJXh9Z
         ysAg==
X-Gm-Message-State: AOJu0YyUPKdmwYOaNfvABuCZzdKAQKY1vafqMGFX0bSD6wMT3VSmi1aE
        cG4bZRjKY3hfshOmvKluaiMQ2YmYa6ozoLaGoHh8IoY670+Uez+vH5kVqctYNYDDYYNIwjdtdgq
        u2qcQu015qIGiAg9lZz7BecUX
X-Received: by 2002:a05:6402:354c:b0:530:8b92:b69d with SMTP id f12-20020a056402354c00b005308b92b69dmr2396071edd.10.1695112375566;
        Tue, 19 Sep 2023 01:32:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmXDIMG9E0295pWOz+tkg88tAxAa346nT1njIIxhurAcl3MzR8Xh/zMA0Lh+IPatX7lMIrVw==
X-Received: by 2002:a05:6402:354c:b0:530:8b92:b69d with SMTP id f12-20020a056402354c00b005308b92b69dmr2396055edd.10.1695112375250;
        Tue, 19 Sep 2023 01:32:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id dn22-20020a05640222f600b00532c1dfe8ecsm350447edb.66.2023.09.19.01.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 01:32:54 -0700 (PDT)
Message-ID: <bcdfa891-c821-30b9-e45c-ea4d30bd6b7f@redhat.com>
Date:   Tue, 19 Sep 2023 10:32:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] platform/x86: think-lmi: Add bulk save feature
Content-Language: en-US, nl
To:     Mark Pearson <mpearson-lenovo@squebb.ca>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20230906121328.50437-1-mpearson-lenovo@squebb.ca>
 <ZQhXZkBHviGOEl-x@smile.fi.intel.com>
 <878da778-e183-6ef5-61ce-3a3d059f1a1e@redhat.com>
 <bf511687-8b29-42e2-92df-fcbf763cd3a2@app.fastmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <bf511687-8b29-42e2-92df-fcbf763cd3a2@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 9/18/23 17:23, Mark Pearson wrote:
> Thanks Andy for the review
> 
> On Mon, Sep 18, 2023, at 10:07 AM, Hans de Goede wrote:
>> Hi,
>>
>> On 9/18/23 15:57, Andy Shevchenko wrote:
>>> On Wed, Sep 06, 2023 at 08:13:14AM -0400, Mark Pearson wrote:
>>>> On Lenovo platforms there is a limitation in the number of times an
>>>> attribute can be saved. This is an architectural limitation and it limits
>>>> the number of attributes that can be modified to 48.
>>>> A solution for this is instead of the attribute being saved after every
>>>> modification allow a user to bulk set the attributes and then trigger a
>>>> final save. This allows unlimited attributes.
>>>>
>>>> This patch introduces a save_settings attribute that can be configured to
>>>> either single or bulk mode by the user.
>>>> Single mode is the default but customers who want to avoid the 48
>>>> attribute limit can enable bulk mode.
>>>>
>>>> Displaying the save_settings attribute will display the enabled mode.
>>>>
>>>> When in bulk mode writing 'save' to the save_settings attribute will
>>>> trigger a save. Once this has been done a reboot is required before more
>>>> attributes can be modified.
>>>
>>> ...
>>>
>>>> +Date:		August 2023
>>>> +KernelVersion:	6.5
>>>
>>> This is obviously incorrect (outdated) information.
>>
>> Mark can you please submit a follow up patch fixing this.
> 
> So I assume I put 6.6 in here? Or will it be 6.7?

Yes this should be 6.6 .


>>> ...
>>>
>>>> +static const char * const save_mode_strings[] = {
>>>> +	[TLMI_SAVE_SINGLE] = "single",
>>>> +	[TLMI_SAVE_BULK] = "bulk",
>>>> +	[TLMI_SAVE_SAVE] = "save"
>>>
>>> Missing comma.
>>
>> Fixing this retro-actively is not really useful, if we
>> ever need an extra entry we can deal with the churn then.
> 
> As I'm making other changes I assume I address this one too.

Please skip fixing / do not fix this one. The goal of having
a "," after the last (non terminating) entry of an array
is to avoid getting the last line listed as modified in the diff
when adding further entries just to add the ','.

So fixing this after the fact is not really useful. If this array
ever gets an extra entry we can just add the ',' when that happens.


>>>
>>>> +};
>>>
>>> ...
>>>
>>>> +static ssize_t save_settings_show(struct kobject *kobj, struct kobj_attribute *attr,
>>>> +				  char *buf)
>>>> +{
>>>> +	/* Check that setting is valid */
>>>> +	if (WARN_ON((tlmi_priv.save_mode < TLMI_SAVE_SINGLE) ||
>>>> +		    (tlmi_priv.save_mode > TLMI_SAVE_BULK)))
>>>> +		return -EIO;
>>>> +	return sprintf(buf, "%s\n", save_mode_strings[tlmi_priv.save_mode]);
>>>
>>> According to the documentation it must be sysfs_emit() if I'm not missing
>>> anything here.
>>
>> Yes switching to sysfs_emit() here in the followup patch would be good.
> 
> Ack
> 
>>
>>>
>>>> +}
>>>
>>> ...
>>>
>>>> +static ssize_t save_settings_store(struct kobject *kobj, struct kobj_attribute *attr,
>>>> +				   const char *buf, size_t count)
>>>> +{
>>>> +	char *auth_str = NULL;
>>>> +	int ret = 0;
>>>> +	int cmd;
>>>> +
>>>> +	cmd = sysfs_match_string(save_mode_strings, buf);
>>>> +
>>>> +	/* Use lock in case multiple WMI operations needed */
>>>> +	mutex_lock(&tlmi_mutex);
>>>> +
>>>> +	switch (cmd) {
>>>> +	case TLMI_SAVE_SINGLE:
>>>> +	case TLMI_SAVE_BULK:
>>>> +		tlmi_priv.save_mode = cmd;
>>>> +		goto out;
>>>> +	case TLMI_SAVE_SAVE:
>>>> +		/* Check if supported*/
>>>> +		if ((!tlmi_priv.can_set_bios_settings) ||
>>>> +		    (tlmi_priv.save_mode == TLMI_SAVE_SINGLE)) {
>>>> +			ret = -EOPNOTSUPP;
>>>> +			goto out;
>>>> +		}
>>>> +		/* Check there is actually something to save */
>>>> +		if (!tlmi_priv.save_required) {
>>>> +			ret = -ENOENT;
>>>> +			goto out;
>>>> +		}
>>>> +		/* Check if certificate authentication is enabled and active */
>>>> +		if (tlmi_priv.certificate_support && tlmi_priv.pwd_admin->cert_installed) {
>>>> +			if (!tlmi_priv.pwd_admin->signature ||
>>>> +			    !tlmi_priv.pwd_admin->save_signature) {
>>>> +				ret = -EINVAL;
>>>> +				goto out;
>>>> +			}
>>>> +			ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
>>>> +					       tlmi_priv.pwd_admin->save_signature);
>>>> +			if (ret)
>>>> +				goto out;
>>>> +		} else if (tlmi_priv.opcode_support) {
>>>> +			if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
>>>> +				ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
>>>> +							  tlmi_priv.pwd_admin->password);
>>>> +				if (ret)
>>>> +					goto out;
>>>> +			}
>>>> +			ret = tlmi_save_bios_settings("");
>>>> +		} else { /* old non-opcode based authentication method (deprecated) */
>>>> +			if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
>>>> +				auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
>>>> +						     tlmi_priv.pwd_admin->password,
>>>> +						     encoding_options[tlmi_priv.pwd_admin->encoding],
>>>> +						     tlmi_priv.pwd_admin->kbdlang);
>>>> +				if (!auth_str) {
>>>> +					ret = -ENOMEM;
>>>> +					goto out;
>>>> +				}
>>>> +			}
>>>> +
>>>> +			if (auth_str)
>>>> +				ret = tlmi_save_bios_settings(auth_str);
>>>> +			else
>>>> +				ret = tlmi_save_bios_settings("");
>>>> +		}
>>>> +		tlmi_priv.save_required = false;
>>>> +		tlmi_priv.reboot_required = true;
>>>> +
>>>> +		if (!ret && !tlmi_priv.pending_changes) {
>>>> +			tlmi_priv.pending_changes = true;
>>>> +			/* let userland know it may need to check reboot pending again */
>>>> +			kobject_uevent(&tlmi_priv.class_dev->kobj, KOBJ_CHANGE);
>>>> +		}
>>>> +		break;
>>>
>>>> +	default:
>>>> +		ret = -EINVAL;
>>>> +	}
>>>
>>> Missing break; and actually no need to do this part under the lock, besides
>>> that it shadows an error code, that said this should be
>>>
>>> 	cmd = sysfs_match_string(...);
>>> 	if (cmd < 0)
>>> 		return cmd;
>>>
>>>
>>>> +out:
>>>> +	mutex_unlock(&tlmi_mutex);
>>>> +	kfree(auth_str);
>>>> +	return ret ?: count;
>>>
>>> You can switch the driver to use cleanup.h at some point.
>>>
>>>> +}
>>>
> 
> Ack - thanks for the notes.
> 
>>> ...
>>>
>>>> +/* There are a limit on the number of WMI operations you can do if you use
>>>> + * the default implementation of saving on every set. This is due to a
>>>> + * limitation in EFI variable space used.
>>>> + * Have a 'bulk save' mode where you can manually trigger the save, and can
>>>> + * therefore set unlimited variables - for users that need it.
>>>> + */
>>>
>>> /*
>>>  * This is wrong multi-line comment style. This one
>>>  * is used solely in net subsystem.
>>>  */
>>>
>>
>> Good catch, Mark can you fix this one too please ?
>>
> Will do - not sure why I did that in the first place (it's a habit from a looong time ago that came back. Sigh).

Regards,

Hans


