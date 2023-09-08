Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D83479896B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244309AbjIHPC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239616AbjIHPC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:02:28 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0EF61BF9;
        Fri,  8 Sep 2023 08:02:24 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 6EFBB212B5DB; Fri,  8 Sep 2023 08:02:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6EFBB212B5DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1694185344;
        bh=fkBgC4K+PqEBZmAXZvNvZfd0P/rD4V69d6ky2EyNgfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GxJaAYz2iR09RZAQRVt7POgYzx7rn5QyVz6C2ONeI0aCkOyacNca1MzvnaYdsXwVT
         NSccPdMnMZwLUUO7vlNZdoxjbed9iNv1RxV70TujXMhGI7j78ZDSjn32jJdv8hsBxw
         vac8J1K/+wx37/4PudAfhi4Ms8rUfBqlpaA/1mi0=
Date:   Fri, 8 Sep 2023 08:02:24 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] x86/hyperv/vtl: Replace real_mode_header only under
 Hyper-V
Message-ID: <20230908150224.GA3196@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20230908102610.1039767-1-minipli@grsecurity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908102610.1039767-1-minipli@grsecurity.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 12:26:10PM +0200, Mathias Krause wrote:
> Booting a CONFIG_HYPERV_VTL_MODE=y enabled kernel on bare metal or a
> non-Hyper-V hypervisor leads to serve memory corruption as

FWIW, CONFIG_HYPERV_VTL_MODE is not expected to be enabled for non VTL
platforms. Referring Kconfig documentation:
"A kernel built with this option must run at VTL2, and will not run as
a normal guest."

- Saurabh

> hv_vtl_early_init() will run even though hv_vtl_init_platform() did not.
> This skips no-oping the 'realmode_reserve' and 'realmode_init' platform
> hooks, making init_real_mode() -> setup_real_mode() try to copy
> 'real_mode_blob' over 'real_mode_header' which we set to the stub
> 'hv_vtl_real_mode_header'. However, as 'real_mode_blob' isn't just a
> 'struct real_mode_header' -- it's the complete code! -- copying it over
> 'hv_vtl_real_mode_header' will corrupt quite some memory following it.
> 
> The real cause for this erroneous behaviour is that hv_vtl_early_init()
> blindly assumes the kernel is running on Hyper-V, which it may not.
> 
> Fix this by making sure the code only replaces the real mode header with
> the stub one iff the kernel is running under Hyper-V.
> 
> Fixes: 3be1bc2fe9d2 ("x86/hyperv: VTL support for Hyper-V")
> Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
> Cc: stable@kernel.org
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> ---
>  arch/x86/hyperv/hv_vtl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 57df7821d66c..54c06f4b8b4c 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -12,6 +12,7 @@
>  #include <asm/desc.h>
>  #include <asm/i8259.h>
>  #include <asm/mshyperv.h>
> +#include <asm/hypervisor.h>
>  #include <asm/realmode.h>
>  
>  extern struct boot_params boot_params;
> @@ -214,6 +215,9 @@ static int hv_vtl_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
>  
>  static int __init hv_vtl_early_init(void)
>  {
> +	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
> +		return 0;
> +
>  	/*
>  	 * `boot_cpu_has` returns the runtime feature support,
>  	 * and here is the earliest it can be used.
> -- 
> 2.30.2
> 
