Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E063177909E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbjHKNR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbjHKNRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:17:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E6E2D52;
        Fri, 11 Aug 2023 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691759874; x=1723295874;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UtEU+TMPBT1c10GjY9uMrXkMmC6y0n8ZdxPYDC6jDys=;
  b=N6bhm8frt3Ww6pUHuqelDfZegYOBE4QL6wjybnyM0vZa7+2P1RX/rf4u
   Vh8DD3FWGZ2bw4GiU4wKdqhRPfbiihMTgjsdL1OOCh9+KeOsXyqKJZa5+
   nwKStPRI1areQUwsVwqIU1SoEPWsNXANMj3ruE1h+gN10Me4E6weDrpIm
   0F2qkLpNdCjV+fBjfmbftr2a8SDH1M7XdTXBRTtOROo2f6c3529WfrcBU
   m68wU5A/qGOi9az4v0gl92mwVzfAfQ/Pcy7mfEuLQuQY7ufhl8W3c3WoI
   z8be14COX1VBPpp4nMhaUBFzJxUxicY7fdlFu4H3Lvw6V0f3HtizaTsHl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="370572250"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="370572250"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:17:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="726264645"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="726264645"
Received: from aberko-mobl1.ger.corp.intel.com ([10.252.51.87])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:17:43 -0700
Date:   Fri, 11 Aug 2023 16:17:41 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "xingtong.wu" <xingtong.wu@siemens.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Henning Schild <henning.schild@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] platform/x86/siemens: simatic-ipc: fix nonsensical
 condition
In-Reply-To: <20230811130948.2211800-1-arnd@kernel.org>
Message-ID: <97764bad-7091-e9ed-6f49-d31861fc622f@linux.intel.com>
References: <20230811130948.2211800-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The condition checking for a constant SIMATIC_IPC_DEVICE_BX_59A value
> clearly makes no sense, as clang warns:
> 
> drivers/platform/x86/siemens/simatic-ipc.c:132:42: error: use of logical '||' with constant operand [-Werror,-Wconstant-logical-operand]
>                 if (ledmode == SIMATIC_IPC_DEVICE_227G || SIMATIC_IPC_DEVICE_BX_59A)
>                                                        ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/platform/x86/siemens/simatic-ipc-batt.c:197:49: error: use of logical '||' with constant operand [-Werror,-Wconstant-logical-operand]
>                 if (priv.devmode == SIMATIC_IPC_DEVICE_BX_21A || SIMATIC_IPC_DEVICE_BX_59A)
>                                                               ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Most likely, this was meant to check ledmode to be one of the two values,
> so change it to that.
> 
> Fixes: b8af77951941e ("platform/x86/siemens: simatic-ipc: add new models BX-56A/BX-59A")
> Fixes: c56beff203754 ("platform/x86/siemens: simatic-ipc-batt: add support for module BX-59A")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/platform/x86/siemens/simatic-ipc-batt.c | 3 ++-
>  drivers/platform/x86/siemens/simatic-ipc.c      | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt.c b/drivers/platform/x86/siemens/simatic-ipc-batt.c
> index d66b9969234bf..e6c12c52843ca 100644
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
> diff --git a/drivers/platform/x86/siemens/simatic-ipc.c b/drivers/platform/x86/siemens/simatic-ipc.c
> index 02c540cf40702..e11d28ffac604 100644
> --- a/drivers/platform/x86/siemens/simatic-ipc.c
> +++ b/drivers/platform/x86/siemens/simatic-ipc.c
> @@ -129,7 +129,8 @@ static int register_platform_devices(u32 station_id)
>  		pdevname = KBUILD_MODNAME "_leds";
>  		if (ledmode == SIMATIC_IPC_DEVICE_127E)
>  			pdevname = KBUILD_MODNAME "_leds_gpio_apollolake";
> -		if (ledmode == SIMATIC_IPC_DEVICE_227G || SIMATIC_IPC_DEVICE_BX_59A)
> +		if (ledmode == SIMATIC_IPC_DEVICE_227G ||
> +		    ledmode == SIMATIC_IPC_DEVICE_BX_59A)
>  			pdevname = KBUILD_MODNAME "_leds_gpio_f7188x";
>  		if (ledmode == SIMATIC_IPC_DEVICE_BX_21A)
>  			pdevname = KBUILD_MODNAME "_leds_gpio_elkhartlake";

Thank you for the patch but these are already fixed by commits:

7abf253afa5c ("platform/x86/siemens: simatic-ipc-batt: fix logical error for BX-59A")
b01c1e022f7f ("platform/x86/siemens: simatic-ipc: fix logical error for BX-59A")


-- 
 i.

