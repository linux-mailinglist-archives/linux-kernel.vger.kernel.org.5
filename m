Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4554D771CBD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjHGJA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHGJAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:00:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC808E6C;
        Mon,  7 Aug 2023 02:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691398821; x=1722934821;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YZn4F6oopYk9LPhtJxgyd4MGLusgxNp60pKSxVNkoe0=;
  b=Tg/gSoQS7+d3qyQFI9k1N+NufeXIXC6Sy9FBalc136z/pfpGPAJvHexH
   KzJasEbg44B1CMfCZtAO+aryxeS4uBTFU6e0qvWNuvm6XfEXUt7JN0KSJ
   4ARFrAFHG4V+CGqkaIKmkyNbfMrexEeams4sA81XO+G1o+Ha0P7SLYazc
   4GSE0arQ7GyzDtlanABFKKuQEh5Izc5hUkAn+u/9Wg37zK0nMMtBQ6q9a
   rqEtJEcTZXYMDA4k0T4VLYZnaLdOd4l9zXU7cL+FHQdE+v511PPvxVjA9
   RQg1Ep3VY5UhqSkaxJI0l3posqAWnnsNPyqGKNKNUiIt/To5kuRKv9KYl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="374169185"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="374169185"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 02:00:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="1061521135"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="1061521135"
Received: from siminapx-mobl1.ger.corp.intel.com ([10.251.210.150])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 02:00:17 -0700
Date:   Mon, 7 Aug 2023 12:00:11 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     xingtong_wu@163.com
cc:     hdegoede@redhat.com, markgross@kernel.org, xingtong.wu@siemens.com,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        gerd.haeussler.ext@siemens.com, tobias.schaffner@siemens.com,
        lkp@intel.com
Subject: Re: [PATCH v2 2/2] platform/x86/siemens: simatic-ipc-batt: fix logic
 error for BX-59A
In-Reply-To: <20430731173417.2692-1-xingtong_wu@163.com>
Message-ID: <197a523b-eae-e7ef-dd7d-29e614a1941f@linux.intel.com>
References: <d41d3ae3-9c1b-661-4664-51d62ad1d786@linux.intel.com> <20430731173417.2692-1-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1794303338-1691398819=:9752"
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

--8323329-1794303338-1691398819=:9752
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 1 Aug 2043, xingtong_wu@163.com wrote:

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

The tags block should not have extra newlines like there's now one in 
between Closes and Signed-off-by.

For patches 1-2:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

(In case you end up submitting a new version, you should collect the tags 
other people have given you, except e.g., if you did major modifications 
to the patch.)

-- 
 i.

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
> 

--8323329-1794303338-1691398819=:9752--
