Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218D47A4F16
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjIRQeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjIRQdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:33:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7252C23CF4;
        Mon, 18 Sep 2023 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695053702; x=1726589702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BgwZTNb4fHHTZH2HZ4fYbJ0AKhM9dn5cKYQ9HQrxfxE=;
  b=cOm4MXJlIPcRv+FXudzI6BIH5g3OOjCXcNSlmHHxi0HMsWjHqWjTd4Ty
   O0youeCHyPQW8hcgki5ZgzuluwhTHFNh2qEBcUKfbd77k0zRdUaYdZNcT
   HrHXBr4j4uxFeczVV4K4LnxQjb4od5QthjxMmXRoAyE2fvrFH1pqG2Q2w
   z3iyB9+vi0XR7t1wxTQsOO0QySNZbw14B87yOlgmMW/0rP9t+B5vCfOVc
   WZLK07GbQZnVTlhCmmNH/O3dJewNW9Z4qc7pzuhuuxfRiu4iOsamX5mUX
   sxzp4X1aMfJC/L/JkUau4WnZIE9TcbZYz2nBARJ6TK4yGP+c6qAmWazuG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="379566472"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="379566472"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:58:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="1076597208"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="1076597208"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:58:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qiElC-00000009bSN-37Ah;
        Mon, 18 Sep 2023 16:57:58 +0300
Date:   Mon, 18 Sep 2023 16:57:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: think-lmi: Add bulk save feature
Message-ID: <ZQhXZkBHviGOEl-x@smile.fi.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20230906121328.50437-1-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906121328.50437-1-mpearson-lenovo@squebb.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 08:13:14AM -0400, Mark Pearson wrote:
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

...

> +Date:		August 2023
> +KernelVersion:	6.5

This is obviously incorrect (outdated) information.

...

> +static const char * const save_mode_strings[] = {
> +	[TLMI_SAVE_SINGLE] = "single",
> +	[TLMI_SAVE_BULK] = "bulk",
> +	[TLMI_SAVE_SAVE] = "save"

Missing comma.

> +};

...

> +static ssize_t save_settings_show(struct kobject *kobj, struct kobj_attribute *attr,
> +				  char *buf)
> +{
> +	/* Check that setting is valid */
> +	if (WARN_ON((tlmi_priv.save_mode < TLMI_SAVE_SINGLE) ||
> +		    (tlmi_priv.save_mode > TLMI_SAVE_BULK)))
> +		return -EIO;
> +	return sprintf(buf, "%s\n", save_mode_strings[tlmi_priv.save_mode]);

According to the documentation it must be sysfs_emit() if I'm not missing
anything here.

> +}

...

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

Missing break; and actually no need to do this part under the lock, besides
that it shadows an error code, that said this should be

	cmd = sysfs_match_string(...);
	if (cmd < 0)
		return cmd;


> +out:
> +	mutex_unlock(&tlmi_mutex);
> +	kfree(auth_str);
> +	return ret ?: count;

You can switch the driver to use cleanup.h at some point.

> +}

...

> +/* There are a limit on the number of WMI operations you can do if you use
> + * the default implementation of saving on every set. This is due to a
> + * limitation in EFI variable space used.
> + * Have a 'bulk save' mode where you can manually trigger the save, and can
> + * therefore set unlimited variables - for users that need it.
> + */

/*
 * This is wrong multi-line comment style. This one
 * is used solely in net subsystem.
 */

-- 
With Best Regards,
Andy Shevchenko


