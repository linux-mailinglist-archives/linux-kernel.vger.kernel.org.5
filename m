Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BBE80E8B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346099AbjLLKJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjLLKJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:09:41 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBC5AC;
        Tue, 12 Dec 2023 02:09:45 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BCA9MtG032172;
        Tue, 12 Dec 2023 04:09:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702375762;
        bh=3E28BIhAcMlfJBxKwzHjZKYVki+pv/1ePwSlsPJFXqA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=dYUjpGYnCWMwtwO2vXRWaabk7M3/0Mx1dRZiDbmHNZyxS5c4hPIoF/O9yFc7BD6D9
         6Lv6h4kO2b2z0uAudu6ulU9ASp9Rbmy+p9q9/s+uWuaqpOW2wKG5Imvjixwkp8peAt
         zrshnmQ1vldj1rY8zNlfmbZwFnY6c/oQQ5FBkHWg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BCA9MdL127284
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Dec 2023 04:09:22 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Dec 2023 04:09:22 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Dec 2023 04:09:22 -0600
Received: from localhost (uda0497581.dhcp.ti.com [10.24.69.44])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BCA9Lvx017052;
        Tue, 12 Dec 2023 04:09:22 -0600
Date:   Tue, 12 Dec 2023 15:39:20 +0530
From:   Manorit Chawdhry <m-chawdhry@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tero Kristo <kristo@kernel.org>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>
Subject: Re: [PATCH v2] watchdog: rti_wdt: Drop RPM count when unused
Message-ID: <20231212100920.wq26mylvn5qsms6w@uda0497581>
References: <20231122041642.2015936-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231122041642.2015936-1-vigneshr@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On 09:46-20231122, Vignesh Raghavendra wrote:
> Do a RPM put if watchdog is not already started during probe and re
> enable it in watchdog start.
> 
> On K3 SoCs, watchdogs and their corresponding CPUs are under same PD, so
> if the reference count of unused watchdogs aren't dropped, it will lead
> to CPU hotplug failures as Device Management firmware won't allow to
> turn off the PD due to dangling reference count.
> 
> Fixes: 2d63908bdbfb ("watchdog: Add K3 RTI watchdog support")
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
> 
> v2:
> * Drop 1/2 (will be posted along with runtime_pm callbacks)
> * Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync() which
>  takes care of err handling
> 
> v1: lore.kernel.org/r/20231110100726.2930218-1-vigneshr@ti.com
> 
>  drivers/watchdog/rti_wdt.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index 8e1be7ba0103..9215793a1c81 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -77,6 +77,11 @@ static int rti_wdt_start(struct watchdog_device *wdd)
>  {
>  	u32 timer_margin;
>  	struct rti_wdt_device *wdt = watchdog_get_drvdata(wdd);
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(wdd->parent);
> +	if (ret)
> +		return ret;
>  
>  	/* set timeout period */
>  	timer_margin = (u64)wdd->timeout * wdt->freq;
> @@ -343,6 +348,9 @@ static int rti_wdt_probe(struct platform_device *pdev)
>  	if (last_ping)
>  		watchdog_set_last_hw_keepalive(wdd, last_ping);
>  
> +	if (!watchdog_hw_running(wdd))
> +		pm_runtime_put_sync(&pdev->dev);
> +
>  	return 0;
>  
>  err_iomap:
> @@ -357,7 +365,10 @@ static void rti_wdt_remove(struct platform_device *pdev)
>  	struct rti_wdt_device *wdt = platform_get_drvdata(pdev);
>  
>  	watchdog_unregister_device(&wdt->wdd);
> -	pm_runtime_put(&pdev->dev);
> +
> +	if (!pm_runtime_suspended(&pdev->dev))
> +		pm_runtime_put(&pdev->dev);
> +
>  	pm_runtime_disable(&pdev->dev);
>  }
>  

Tested the following on j721s2 evm.
https://gist.github.com/manorit2001/05a85582fea670d39cc3cfb2df1e5328

Tested-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit

> -- 
> 2.42.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
