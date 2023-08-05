Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4AC771177
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjHESf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHESfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:35:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7B0B7;
        Sat,  5 Aug 2023 11:35:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2904760DEC;
        Sat,  5 Aug 2023 18:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F699C433C7;
        Sat,  5 Aug 2023 18:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691260522;
        bh=FuhFjr9cwhcJLZ9jigWsfJqMNCkQMPeBDutnXl4pb+0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gb5JYxBgmRSt0KTWN/9g17y4H5z7fOzb4QRb+vpd5xbSjvjUl/lfxHsld2SJXfV4e
         1A/yn1ET9SrLCAO3N8NyRzExt9PYA/Wb3AdXzVnoJyoeAdamlt4PvxY+lAYymavazI
         fW2pxEdrmsEcsNmp5OVn0hUL+w8bsjlnKBUhfmERs8PejjwFjBiXX7AjS5e8e0bl/i
         WjMlXZvaM8MeHJfoQhO72WHKrBqs3hjZfpkBgHTD/rziy5mmqOy04GXjW01BJbcK/E
         tpJJKxcrXvjde041CGGxStocorMugs3vBmKFz0o8gX3WcTmlKhXfgpiucxXBgBW0Q/
         ACkSR5QhJHhiA==
Date:   Sat, 5 Aug 2023 19:35:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Cc:     <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] iio: Add IIO_DELTA_ANGL channel type
Message-ID: <20230805193516.332122e1@jic23-huawei>
In-Reply-To: <20230804064559.47192-2-ramona.bolboaca@analog.com>
References: <20230804064559.47192-1-ramona.bolboaca@analog.com>
        <20230804064559.47192-2-ramona.bolboaca@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 09:45:57 +0300
Ramona Bolboaca <ramona.bolboaca@analog.com> wrote:

> The delta angle is defined as a piece-wise integration of angular
> velocity data. The delta angle represents the amount of
> angular displacement between two consecutive measurements and it
> is measured in degrees.

That's not consistent with angl and it should be.
Hence should be radians, with appropriate changes in the scale
exposed by the driver.

> 
> In order to track the total angular displacement during a desired
> period of time, simply sum-up the delta angle samples acquired
> during that time.
> 
> IIO currently does not offer a suitable channel type for this
> type of measurements hence this patch adds it.
> 
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 14 ++++++++++++++
>  drivers/iio/industrialio-core.c         |  1 +
>  include/uapi/linux/iio/types.h          |  1 +
>  tools/iio/iio_event_monitor.c           |  2 ++
>  4 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index a2854dc9a839..1561c33b05a1 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -279,6 +279,20 @@ Description:
>  		but should match other such assignments on device).
>  		Units after application of scale and offset are m/s^2.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_deltaangl_x_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_deltaangl_y_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_deltaangl_z_raw
> +KernelVersion:	6.5
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Angular displacement between two consecutive samples on x, y or
> +		z (may be arbitrarily assigned but should match other such
> +		assignments on device).
> +		In order to compute the total angular displacement during a
> +		desired period of time, the application should sum-up the delta
> +		angle samples acquired during that time.
> +		Units after application of scale and offset are angles.

Units above are degrees, but should be radians.

> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_angl_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_raw
>  KernelVersion:	4.17
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index a92b8b6ad647..2e2fd0be2504 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -89,6 +89,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_POSITIONRELATIVE]  = "positionrelative",
>  	[IIO_PHASE] = "phase",
>  	[IIO_MASSCONCENTRATION] = "massconcentration",
> +	[IIO_DELTA_ANGL] = "deltaangl",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index c79f2f046a0b..55666a17d311 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -47,6 +47,7 @@ enum iio_chan_type {
>  	IIO_POSITIONRELATIVE,
>  	IIO_PHASE,
>  	IIO_MASSCONCENTRATION,
> +	IIO_DELTA_ANGL,
>  };
>  
>  enum iio_modifier {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 0a5c2bb60030..3505450060e6 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -59,6 +59,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_POSITIONRELATIVE] = "positionrelative",
>  	[IIO_PHASE] = "phase",
>  	[IIO_MASSCONCENTRATION] = "massconcentration",
> +	[IIO_DELTA_ANGL] = "deltaangl",
>  };
>  
>  static const char * const iio_ev_type_text[] = {
> @@ -173,6 +174,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_POSITIONRELATIVE:
>  	case IIO_PHASE:
>  	case IIO_MASSCONCENTRATION:
> +	case IIO_DELTA_ANGL:
>  		break;
>  	default:
>  		return false;

