Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7F97AD93F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjIYNio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjIYNim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:38:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC944B3;
        Mon, 25 Sep 2023 06:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695649115; x=1727185115;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tzL5UPIxLNg3ierRGxOkkjvUg6OsD7TX5sjo2ZMUfTE=;
  b=kimFoxizp+Pxjggbcm2MqiokSZ+yCJLxViSdWlYazJCmDPNy/S1TxgRv
   xxg2HlwIBFGKhgpQNOUvgC3VjKL06zZjTU1XqknaM5PvYcOemfC6RAKd+
   kQ0f+4Cxno/AzvJZ5dO7XNZGzwQ5S3bPAl+PD91D0CMuI5x7i7lrQ+m90
   isf9iLpcio3xSNyqSYq1jluzI/qyLNhjUmGvWV51z2lSK7C7BR7U3r22m
   15pfixGeR8iSvt9xqVcRtVw6iiFBUtn+tgM0dvFeN8uJ/7b47RjNPkZ24
   fhSUfPkEIiVD6LRZVPYx6vaf/xS6Vrjf4ddfzRmGxOG8Z2tbdPIjWy7I2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="385079374"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="385079374"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 06:38:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="777650757"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="777650757"
Received: from stamengx-mobl1.ger.corp.intel.com ([10.249.32.149])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 06:38:32 -0700
Date:   Mon, 25 Sep 2023 16:38:30 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Armin Wolf <W_Armin@gmx.de>
cc:     markpearson@lenovo.com, jorge.lopez2@hp.com,
        Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] platform/x86: hp-bioscfg: Fix reference leak
In-Reply-To: <20230925132844.72479-3-W_Armin@gmx.de>
Message-ID: <eaabc245-bf5a-b4a0-f319-1e1c4f02d7a@linux.intel.com>
References: <20230925132844.72479-1-W_Armin@gmx.de> <20230925132844.72479-3-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1596787364-1695649114=:2147"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1596787364-1695649114=:2147
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 25 Sep 2023, Armin Wolf wrote:

> If a duplicate attribute is found using kset_find_obj(), a reference
> to that attribute is returned which needs to be disposed accordingly
> using kobject_put(). Use kobject_put() to dispose the duplicate
> attribute in such a case.
> As a side note, a very similar bug was fixed in
> commit 7295a996fdab ("platform/x86: dell-sysman: Fix reference leak"),
> so it seems that the bug was copied from that driver.
> 
> Compile-tested only.
> 
> Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Changes in v3:
> - no changes
> Changes in v2:
> - add patch
> ---
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> index 8c4f9e12f018..0c83e66f8d0b 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> @@ -659,7 +659,7 @@ static int hp_init_bios_package_attribute(enum hp_wmi_data_type attr_type,
>  					  const char *guid, int min_elements,
>  					  int instance_id)
>  {
> -	struct kobject *attr_name_kobj;
> +	struct kobject *attr_name_kobj, *duplicate;
>  	union acpi_object *elements;
>  	struct kset *temp_kset;
> 
> @@ -704,8 +704,11 @@ static int hp_init_bios_package_attribute(enum hp_wmi_data_type attr_type,
>  	}
> 
>  	/* All duplicate attributes found are ignored */
> -	if (kset_find_obj(temp_kset, str_value)) {
> +	duplicate = kset_find_obj(temp_kset, str_value);
> +	if (duplicate) {
>  		pr_debug("Duplicate attribute name found - %s\n", str_value);
> +		/* kset_find_obj() returns a reference */
> +		kobject_put(duplicate);
>  		goto pack_attr_exit;
>  	}
> 
> @@ -768,7 +771,7 @@ static int hp_init_bios_buffer_attribute(enum hp_wmi_data_type attr_type,
>  					 const char *guid, int min_elements,
>  					 int instance_id)
>  {
> -	struct kobject *attr_name_kobj;
> +	struct kobject *attr_name_kobj, *duplicate;
>  	struct kset *temp_kset;
>  	char str[MAX_BUFF_SIZE];
> 
> @@ -794,8 +797,11 @@ static int hp_init_bios_buffer_attribute(enum hp_wmi_data_type attr_type,
>  		temp_kset = bioscfg_drv.main_dir_kset;
> 
>  	/* All duplicate attributes found are ignored */
> -	if (kset_find_obj(temp_kset, str)) {
> +	duplicate = kset_find_obj(temp_kset, str);
> +	if (duplicate) {
>  		pr_debug("Duplicate attribute name found - %s\n", str);
> +		/*kset_find_obj() returns a reference */

Thanks. Whitespace is missing here.

Other than that, 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

> +		kobject_put(duplicate);
>  		goto buff_attr_exit;
>  	}
> 
> --
> 2.39.2
> 

-- 
 i.

--8323329-1596787364-1695649114=:2147--
