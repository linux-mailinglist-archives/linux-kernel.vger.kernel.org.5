Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A0D7AD761
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjIYMAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjIYMAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:00:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E58DA;
        Mon, 25 Sep 2023 05:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695643216; x=1727179216;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=i3bAMHCHVTIFT58YiqClyS+AktS20qC/6LC/sWIT2HI=;
  b=UjCbHDx00fd5akuw69/Z95Pvcqds8hSLoy09I67tQRdmSICcz8526cZN
   GicwPE5Ur4k9agzyqeMNc5Q1QDeycR+EH5HrNkaLd0Tot7JOGANaZUf6M
   axUsBPbZwib7SPTEl+tKXoqQ/GliEW9lhrm6M7lry05Rx0UGEHdJGR1CG
   /dnCGR16A2AI2zUFfEh3zen5OLwIzOI6Zw/pK8K8d04FrdssVDFOW/GDb
   5Md+z1iOtB9vHswPNZpiUMZmnaW73jft0u9ritPEKo8awgK6uHp1xRnqO
   PjuCpGaqgFjbmkbgew4PkzXZh0+H4NqKMOaSWbBnvXOWSGGrPYSNh0tAK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360612789"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="360612789"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 05:00:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="751645081"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="751645081"
Received: from stamengx-mobl1.ger.corp.intel.com ([10.249.32.149])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 05:00:12 -0700
Date:   Mon, 25 Sep 2023 15:00:10 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Armin Wolf <W_Armin@gmx.de>
cc:     markpearson@lenovo.com, Hans de Goede <hdegoede@redhat.com>,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: think-lmi: Fix reference leak
In-Reply-To: <20230923204154.86815-1-W_Armin@gmx.de>
Message-ID: <7e68e66f-40a2-1ac7-416b-bf63bafa6fe7@linux.intel.com>
References: <20230923204154.86815-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1222309367-1695643214=:2147"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1222309367-1695643214=:2147
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 23 Sep 2023, Armin Wolf wrote:

> If a duplicate attribute is found using kset_find_obj(), a reference
> to that attribute is returned which needs to be disposed accordingly
> using kobject_put(). Move the setting name validation into a separate
> function to allow for this change without having to duplicate the
> cleanup code for this setting.
> As a side note, a very similar bug was fixed in
> commit 7295a996fdab ("platform/x86: dell-sysman: Fix reference leak"),
> so it seems that the bug was copied from that driver.
> 
> Compile-tested only.
> 
> Fixes: 1bcad8e510b2 ("platform/x86: think-lmi: Fix issues with duplicate attributes")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/think-lmi.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 4be6f28d4600..3a396b763c49 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -1344,6 +1344,24 @@ static void tlmi_release_attr(void)
>  	kset_unregister(tlmi_priv.authentication_kset);
>  }
> 
> +static int tlmi_validate_setting_name(struct kset *attribute_kset, char *name)
> +{
> +	struct kobject *duplicate;
> +
> +	if (!strcmp(name, "Reserved"))
> +		return -EINVAL;
> +
> +	duplicate = kset_find_obj(attribute_kset, name);
> +	if (duplicate) {
> +		pr_debug("Duplicate attribute name found - %s\n", name);
> +		/* kset_find_obj() returns a reference */
> +		kobject_put(duplicate);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
>  static int tlmi_sysfs_init(void)
>  {
>  	int i, ret;
> @@ -1372,10 +1390,8 @@ static int tlmi_sysfs_init(void)
>  			continue;
> 
>  		/* check for duplicate or reserved values */
> -		if (kset_find_obj(tlmi_priv.attribute_kset, tlmi_priv.setting[i]->display_name) ||
> -		    !strcmp(tlmi_priv.setting[i]->display_name, "Reserved")) {
> -			pr_debug("duplicate or reserved attribute name found - %s\n",
> -				tlmi_priv.setting[i]->display_name);
> +		if (tlmi_validate_setting_name(tlmi_priv.attribute_kset,
> +					       tlmi_priv.setting[i]->display_name) < 0) {
>  			kfree(tlmi_priv.setting[i]->possible_values);
>  			kfree(tlmi_priv.setting[i]);
>  			tlmi_priv.setting[i] = NULL;

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

There seem to be two more of these in hp-bioscfg.

-- 
 i.

--8323329-1222309367-1695643214=:2147--
