Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7288177E588
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbjHPPrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344393AbjHPPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:47:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAECE26A8;
        Wed, 16 Aug 2023 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692200846; x=1723736846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GMVGcSIQ+QH/TIp6M4nqrBd2HmKhNCvR/nQLZrf3CoE=;
  b=Gf3KU/x5oB0qOcTEEeVMOUN9nPsxUwAblqskVHe5zmVeEo7o2FC93I9k
   FuA8GkrYTUzltCpT4igzdk7XHAduylVnW0AgDHiFqyX7SbZhy/SOx/ZY0
   Kt/q0Arn3Kr/EkQDyd7shOivXvy8FMIGHHCNLH8H/Xw3DU2gQqB/x6gis
   DRLXfMBwCYBsWxMhPQuiqEvxHecy1J8xHVx8vvdPohRYYjES91tnA6RkC
   EseyKKuILZKGcZCUyOuc9f/WR36ASVyXGnALykw41yWnbhw/9AsQ6dy4k
   Z4cElbWABoDUn/qahIfo2xmGDIDt61VaU8lYFcHh7ip9jqyEOPsl6h2Sg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="458918297"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="458918297"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 08:47:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="684113034"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="684113034"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 08:47:26 -0700
Date:   Wed, 16 Aug 2023 08:45:52 -0700
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     xingtong_wu@163.com
Cc:     ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org, xingtong.wu@siemens.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        gerd.haeussler.ext@siemens.com, tobias.schaffner@siemens.com,
        lkp@intel.com, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v2 2/2] platform/x86/siemens: simatic-ipc-batt: fix logic
 error for BX-59A
Message-ID: <ZNzvMMCUMDrgmTnn@araj-dh-work>
References: <d41d3ae3-9c1b-661-4664-51d62ad1d786@linux.intel.com>
 <20430731173417.2692-1-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20430731173417.2692-1-xingtong_wu@163.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 01, 2043 at 01:34:17AM +0800, xingtong_wu@163.com wrote:
^^^^^^^^^^^^^^^^^^^^

Nice way to keep your mail on top of the sort :-).. You need to fixup your
system date.

> From: "xingtong.wu" <xingtong.wu@siemens.com>
> 
> The variable "priv.devmode" is missing from if statement that leads
> to a logical error. Add the missing variable to the if condition.
> 
> Fixes: c56beff20375 ("platform/x86/siemens: simatic-ipc-batt: add support for module BX-59A")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308010001.BGYCSQrl-lkp@intel.com/
> 
> Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
> ---
>  drivers/platform/x86/siemens/simatic-ipc-batt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt.c b/drivers/platform/x86/siemens/simatic-ipc-batt.c
> index d66b9969234b..e6c12c52843c 100644
> --- a/drivers/platform/x86/siemens/simatic-ipc-batt.c
> +++ b/drivers/platform/x86/siemens/simatic-ipc-batt.c
> @@ -194,7 +194,8 @@ int simatic_ipc_batt_probe(struct platform_device *pdev, struct gpiod_lookup_tab
>  
>  	if (table->table[2].key) {
>  		flags = GPIOD_OUT_HIGH;
> -		if (priv.devmode == SIMATIC_IPC_DEVICE_BX_21A || SIMATIC_IPC_DEVICE_BX_59A)
> +		if (priv.devmode == SIMATIC_IPC_DEVICE_BX_21A ||
> +		    priv.devmode == SIMATIC_IPC_DEVICE_BX_59A)
>  			flags = GPIOD_OUT_LOW;
>  		priv.gpios[2] = devm_gpiod_get_index(dev, "CMOSBattery meter", 2, flags);
>  		if (IS_ERR(priv.gpios[2])) {
> -- 
> 2.25.1
> 
