Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B352277029A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjHDOKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjHDOKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:10:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69674198C;
        Fri,  4 Aug 2023 07:10:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6C906203B;
        Fri,  4 Aug 2023 14:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5682C433C8;
        Fri,  4 Aug 2023 14:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691158204;
        bh=UWitlbycvGbarZEVsXx6MkJ1vRTMyQOcOFtKt+TUFAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DtdZzMIvpQdTMIuitLzYZGRQMzQinbKsL3ia9lAXkVYBjGP4QtByWEioWeLQjNDTj
         gkrKCF1IfzwuCy45JI7eXrI96q2Y5TYwXrVR0DMB/q4nqClark4es3Nmxx0oFCDGjB
         s5B3MpG6RIVTETqK3lzdNkkrrb9/xOgMiDFdPH6M=
Date:   Fri, 4 Aug 2023 16:10:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tero Kristo <kristo@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 2/4] driver core: Replace kstrdup() + strreplace()
 with kstrdup_and_replace()
Message-ID: <2023080456-ride-unrobed-b738@gregkh>
References: <20230628153211.52988-1-andriy.shevchenko@linux.intel.com>
 <20230628153211.52988-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628153211.52988-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 06:32:09PM +0300, Andy Shevchenko wrote:
> Replace open coded functionalify of kstrdup_and_replace() with a call.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3dff5037943e..af0ee691520a 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -17,7 +17,6 @@
>  #include <linux/kstrtox.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> -#include <linux/string.h>
>  #include <linux/kdev_t.h>
>  #include <linux/notifier.h>
>  #include <linux/of.h>
> @@ -28,6 +27,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/mm.h>
> +#include <linux/string_helpers.h>
>  #include <linux/swiotlb.h>
>  #include <linux/sysfs.h>
>  #include <linux/dma-map-ops.h> /* for dma_default_coherent */
> @@ -3910,10 +3910,9 @@ const char *device_get_devnode(const struct device *dev,
>  		return dev_name(dev);
>  
>  	/* replace '!' in the name with '/' */
> -	s = kstrdup(dev_name(dev), GFP_KERNEL);
> +	s = kstrdup_and_replace(dev_name(dev), '!', '/', GFP_KERNEL);
>  	if (!s)
>  		return NULL;
> -	strreplace(s, '!', '/');
>  	return *tmp = s;
>  }
>  
> -- 
> 2.40.0.1.gaa8946217a0b
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
