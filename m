Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FC1770207
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjHDNlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjHDNlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:41:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C08FB2;
        Fri,  4 Aug 2023 06:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691156480; x=1722692480;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MDSYZhj7/7wGWpS1UJBXxryVsZGphR0ixktJVtaUnls=;
  b=ZV4lwNwQzL5GranKTXwmexjiMN0+fntX+cnIjZMcCwdLed4Mo8SoTiiK
   xrECSDzIBG0evdfGVhabPJuFJiCCmibCLb+wOjn63qTFY9statslmkW/D
   jnHlCyEUOVkpQhXt4EpgAUBA/85+gU3TUhPGGSWhKFJWBXTlOlys3WNCP
   ujvudk9g6fBMzi4VS7iJy5bRxoJX1q4v4a7g0MVORaN65jFYxl1jZV6xH
   83jr/Y2tk+Jrov6AGVmhB3LZBXVx1Ch89OUqaxaZed5rEB1lCLMrHm3bQ
   1BlYPxZlBuDezC1yo/QibYkj7srmEHbhGI9IiM10VW18avWgf4PqDifS2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="436476102"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="436476102"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 06:41:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="759599363"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="759599363"
Received: from mmocanu-mobl1.ger.corp.intel.com ([10.252.38.186])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 06:41:16 -0700
Date:   Fri, 4 Aug 2023 16:41:14 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     xingtong_wu@163.com
cc:     hdegoede@redhat.com, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        xingtong.wu@siemens.com, lee@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        gerd.haeussler.ext@siemens.com, tobias.schaffner@siemens.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] platform/x86/siemens: simatic-ipc: fix logic error
 in BX-59A
In-Reply-To: <20230801090423.4747-1-xingtong_wu@163.com>
Message-ID: <7196d4b9-34fe-4a18-863b-65d07c4a348c@linux.intel.com>
References: <20230731071424.4663-2-xingtong_wu@163.com> <20230801090423.4747-1-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-411269591-1691156479=:1581"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-411269591-1691156479=:1581
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 1 Aug 2023, xingtong_wu@163.com wrote:

> From: "xingtong.wu" <xingtong.wu@siemens.com>
> 
> There is a bug in if statement that lead to logical error

Variable is missing from the ledmode if statement that leads to a logic 
error.

> and have influence to other IPC

I don't understand what you're trying to say with this. Not that it feels 
very necessary anyway.

>, it get correct now.

I'd say (in own sentence):

"Add the missing variable to the if condition."

> Fixes: b8af77951941 ("platform/x86/siemens: simatic-ipc: add new models BX-56A/BX-59A")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307312322.Aa8upHWK-lkp@intel.com/
> Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
> ---
>  drivers/platform/x86/siemens/simatic-ipc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/siemens/simatic-ipc.c b/drivers/platform/x86/siemens/simatic-ipc.c
> index 02c540cf4070..8ca6e277fa03 100644
> --- a/drivers/platform/x86/siemens/simatic-ipc.c
> +++ b/drivers/platform/x86/siemens/simatic-ipc.c
> @@ -129,7 +129,7 @@ static int register_platform_devices(u32 station_id)
>  		pdevname = KBUILD_MODNAME "_leds";
>  		if (ledmode == SIMATIC_IPC_DEVICE_127E)
>  			pdevname = KBUILD_MODNAME "_leds_gpio_apollolake";
> -		if (ledmode == SIMATIC_IPC_DEVICE_227G || SIMATIC_IPC_DEVICE_BX_59A)
> +		if (ledmode == SIMATIC_IPC_DEVICE_227G || ledmode == SIMATIC_IPC_DEVICE_BX_59A)
>  			pdevname = KBUILD_MODNAME "_leds_gpio_f7188x";
>  		if (ledmode == SIMATIC_IPC_DEVICE_BX_21A)
>  			pdevname = KBUILD_MODNAME "_leds_gpio_elkhartlake";
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-411269591-1691156479=:1581--
