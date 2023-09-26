Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314657AE9E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjIZKFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjIZKF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:05:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D372597
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:05:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B6FC433C7;
        Tue, 26 Sep 2023 10:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695722721;
        bh=FRY+2/YiUx0GUA9zrZNTOcop5bKxxb0FkPII665yLe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6wXDAvx09MwQSbEG/KS/MCClUoRd8vdwsocvrUHjhzaw52fGEreFjMzciKxioW38
         PUlSPMxQ0s2lOi9K0Ah4az6D23Duhh7eKyaR6oi3l91Z/gR5YGk+E62RZwm/2j1pKF
         3MGAoo/AAkjx9zD3J867j6X8wOOg25nJF33jWCJg=
Date:   Tue, 26 Sep 2023 12:05:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        Nipun.Gupta@amd.com, nikhil.agarwal@amd.com, puneet.gupta@amd.com,
        git@amd.com, michal.simek@amd.com,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: Re: [PATCH v5 3/5] cdx: add support for bus enable and disable
Message-ID: <2023092613-clean-antitoxic-077c@gregkh>
References: <20230922101828.33456-1-abhijit.gangurde@amd.com>
 <20230922101828.33456-4-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922101828.33456-4-abhijit.gangurde@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 03:48:26PM +0530, Abhijit Gangurde wrote:
> CDX bus needs to be disabled before updating/writing devices
> in the FPGA. Once the devices are written, the bus shall be
> rescanned. This change provides sysfs entry to enable/disable the
> CDX bus.
> 
> Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
>  Changes in v5:
>  - Rebased on Linux 6.6
> 
>  Changes in v4:
>  - Add sparse marking for lock around cdx_find_controller() function
> 
>  Changes in v3:
>  - Use platform bus to locate controller
> 
>  Changes in v2:
>  - Improve documentation
>  - Split sysfs entry enable to enable and disable
>  - sysfs entry enable and disable take bus number as an argument
> 
>  Documentation/ABI/testing/sysfs-bus-cdx | 27 +++++++
>  drivers/cdx/cdx.c                       | 97 +++++++++++++++++++++++++
>  drivers/cdx/controller/cdx_controller.c | 50 +++++++++++++
>  drivers/cdx/controller/mc_cdx_pcol.h    | 54 ++++++++++++++
>  drivers/cdx/controller/mcdi_functions.c | 24 ++++++
>  drivers/cdx/controller/mcdi_functions.h | 18 +++++
>  include/linux/cdx/cdx_bus.h             | 12 +++
>  7 files changed, 282 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
> index 7af477f49998..04c8dfe7e201 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cdx
> +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> @@ -11,6 +11,33 @@ Description:
>  
>  		  # echo 1 > /sys/bus/cdx/rescan
>  
> +What:		/sys/bus/cdx/enable
> +Date:		July 2023
> +Contact:	nipun.gupta@amd.com
> +Description:
> +		Writing bus number in hex to this file will attempt to enable
> +		the CDX bus. The bus number for the cdx devices can be found
> +		at /sys/bus/cdx/devices/cdx-BB:DD, where BB denotes the bus
> +		number for the respective device.
> +
> +		For example ::
> +
> +		  # echo 00 > /sys/bus/cdx/enable
> +
> +What:		/sys/bus/cdx/disable
> +Date:		July 2023
> +Contact:	nipun.gupta@amd.com
> +Description:
> +		Writing bus number in hex to this file will attempt to disable
> +		the CDX bus. CDX bus should be disabled before updating the
> +		devices in FPGA. The bus number for the cdx devices can be
> +		found at /sys/bus/cdx/devices/cdx-BB:DD, where BB denotes the
> +		bus number for the respective device.
> +
> +		For example ::
> +
> +		  # echo 00 > /sys/bus/cdx/disable
> +

I can't remember, but why aren't these just attributes on the bus
controller for that specific bus, and not a bus-wide attribute?
Wouldn't that make more sense and remove the need for parsing values of
a bus number and make it more obvious what bus was and was not enabled
at any point in time (i.e. you can't read to see what bus is
enabled/disabled right now with this change.)

thanks,

greg k-h
