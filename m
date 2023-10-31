Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999CC7DCF64
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344498AbjJaOjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjJaOjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:39:22 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0ED30E4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:39:19 -0700 (PDT)
Received: (qmail 717485 invoked by uid 1000); 31 Oct 2023 10:39:19 -0400
Date:   Tue, 31 Oct 2023 10:39:19 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Guan-Yu Lin <guanyulin@google.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, heikki.krogerus@linux.intel.com, mkl@pengutronix.de,
        hadess@hadess.net, mailhol.vincent@wanadoo.fr,
        ivan.orlov0322@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pumahsu@google.com, raychi@google.com, albertccwang@google.com
Subject: Re: [PATCH] rpm: pm: enable PM_RPM_EXCEPTION config flag
Message-ID: <f75d6cd2-fa9f-4820-969f-2a8839d78c9e@rowland.harvard.edu>
References: <20231031093921.755204-1-guanyulin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031093921.755204-1-guanyulin@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 05:38:55PM +0800, Guan-Yu Lin wrote:
> Introducing PM_RPM_EXCEPTION config flag, which may alter the priority
> between system power management and runtime power management. In
> suspend-to-idle flow, PM core will suspend all devices to avoid device

Your patch affects all forms of system suspend, not just 
suspend-to-idle.  What do you actually mean here?

> interact with the system. However, chances are devices might be used by
> other systems rather than a single system. In this case, PM core shouldn't
> suspend the devices. One may use PM_RPM_EXCEPTION config flag to mark
> such exception, and determine the power state of a device with runtime
> power management rather than system power management.

This sort of arrangement -- a device shared between two different 
systems -- could happen with any sort of device.  Why does your patch 
affect only USB devices?

> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 4b31629c5be4..beba7a0f3947 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -193,6 +193,14 @@ config PM
>  	  responsible for the actual handling of device suspend requests and
>  	  wake-up events.
>  
> +config PM_RPM_EXCEPTION
> +	bool "Prioritize Runtime Power Management more than Power Management"

Runtime Power Management is a form of Power Management, so what you 
wrote doesn't make sense.  What you really meant is: Prioritize Runtime 
Power Management more than System Power Management.

> +	default n
> +	help
> +	Provides a way to prioritize Runtime Power Management more than Power
> +	Management. This way system can suspnd with maintaining specific

s/suspnd/suspend/
s/with/while/

> +	components in operation.

Your patch does not allow _specific_ components to be kept in operation.  
_All_ in-use components that support prioritized PM (with this patch, 
all USB components) will remain powered during system suspend, even if 
the user wants only _some_ of them to be kept powered.

Alan Stern

> +
>  config PM_DEBUG
>  	bool "Power Management Debug Support"
>  	depends on PM
> -- 
> 2.42.0.820.g83a721a137-goog
> 
