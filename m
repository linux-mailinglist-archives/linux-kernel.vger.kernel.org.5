Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5301E75DDAA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 19:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjGVRLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 13:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVRLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 13:11:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08951A7;
        Sat, 22 Jul 2023 10:11:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EC7160B06;
        Sat, 22 Jul 2023 17:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2223FC433CA;
        Sat, 22 Jul 2023 17:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690045899;
        bh=U9JOz+mgUIxGOmWhwhz9t8plaw7DwJDJuAtyOyeLx5E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HppSdQxeLzmuuHqSF7E8dWk+HKkts0UI9nH8YFCORNwleT6DeXqCxpY/GuuXcQrfV
         80h39gx66muPbQka3uWS8GYsTfw0Zu+NeDFK9e9jKZs++Ex5bMEop5tPBSKtJiHmUx
         V3lbGECJ+xFwv2iBRd3aOJZQQJzASEzdAnROd9RV3t+QU+ZGNXOe4gcLKhCNhjjmxT
         n0dbYJdFA7lYq70WrgEMZitOy5zuAQ2vXttX76rZIMykJiu39gf1kCTZZRPlWun+85
         NAnE5PgW3QGGrazXR5ifps9iOUCDlm1Hznk0WJbAxKa7mnhnkeBYQFwehrK80lLh/f
         8K0eHvbjgHYJA==
Date:   Sat, 22 Jul 2023 18:11:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v2 2/8] iio: core: Use sysfs_match_string() helper
Message-ID: <20230722181136.4e2d1017@jic23-huawei>
In-Reply-To: <20230721170022.3461-3-andriy.shevchenko@linux.intel.com>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
        <20230721170022.3461-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 20:00:16 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use sysfs_match_string() helper instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>

It 'should' be impossible to end up with one of the clocks
that we reject for the store..

So I wonder if it would be cleaner to only add the clocks we
actually use to the clock_names[] array and use the failure to match
(-EINVAL) to call BUG() which then matches the existing behaviour.

If the clock matching was a generic function I'd be fine with doing what
you have here, but it's local to IIO so we don't have to play nice with
clocks we don't understand.

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 81 +++++++++++++--------------------
>  1 file changed, 31 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 6cca86fd0ef9..4e45740331ee 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1400,50 +1400,32 @@ static ssize_t label_show(struct device *dev, struct device_attribute *attr,
>  
>  static DEVICE_ATTR_RO(label);
>  
> +static const char * const clock_names[] = {
> +	[CLOCK_REALTIME]	 	= "realtime",
> +	[CLOCK_MONOTONIC]	 	= "monotonic",
> +	[CLOCK_PROCESS_CPUTIME_ID]	= "process_cputime_id",
> +	[CLOCK_THREAD_CPUTIME_ID]	= "thread_cputime_id",
> +	[CLOCK_MONOTONIC_RAW]	 	= "monotonic_raw",
> +	[CLOCK_REALTIME_COARSE]	 	= "realtime_coarse",
> +	[CLOCK_MONOTONIC_COARSE] 	= "monotonic_coarse",
> +	[CLOCK_BOOTTIME]	 	= "boottime",
> +	[CLOCK_REALTIME_ALARM]		= "realtime_alarm",
> +	[CLOCK_BOOTTIME_ALARM]		= "boottime_alarm",
> +	[CLOCK_SGI_CYCLE]		= "sgi_cycle",
> +	[CLOCK_TAI]		 	= "tai",
> +};
> +
>  static ssize_t current_timestamp_clock_show(struct device *dev,
>  					    struct device_attribute *attr,
>  					    char *buf)
>  {
>  	const struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	const clockid_t clk = iio_device_get_clock(indio_dev);
> -	const char *name;
> -	ssize_t sz;
>  
> -	switch (clk) {
> -	case CLOCK_REALTIME:
> -		name = "realtime\n";
> -		sz = sizeof("realtime\n");
> -		break;
> -	case CLOCK_MONOTONIC:
> -		name = "monotonic\n";
> -		sz = sizeof("monotonic\n");
> -		break;
> -	case CLOCK_MONOTONIC_RAW:
> -		name = "monotonic_raw\n";
> -		sz = sizeof("monotonic_raw\n");
> -		break;
> -	case CLOCK_REALTIME_COARSE:
> -		name = "realtime_coarse\n";
> -		sz = sizeof("realtime_coarse\n");
> -		break;
> -	case CLOCK_MONOTONIC_COARSE:
> -		name = "monotonic_coarse\n";
> -		sz = sizeof("monotonic_coarse\n");
> -		break;
> -	case CLOCK_BOOTTIME:
> -		name = "boottime\n";
> -		sz = sizeof("boottime\n");
> -		break;
> -	case CLOCK_TAI:
> -		name = "tai\n";
> -		sz = sizeof("tai\n");
> -		break;
> -	default:
> +	if (clk < 0 && clk >= ARRAY_SIZE(clock_names))
>  		BUG();

This is a functional change as more clocks are allowed without
things going boom.

> -	}
>  
> -	memcpy(buf, name, sz);
> -	return sz;
> +	return sysfs_emit(buf, "%s\n", clock_names[clk]);
>  }
>  
>  static ssize_t current_timestamp_clock_store(struct device *dev,
> @@ -1453,22 +1435,21 @@ static ssize_t current_timestamp_clock_store(struct device *dev,
>  	clockid_t clk;
>  	int ret;
>  
> -	if (sysfs_streq(buf, "realtime"))
> -		clk = CLOCK_REALTIME;
> -	else if (sysfs_streq(buf, "monotonic"))
> -		clk = CLOCK_MONOTONIC;
> -	else if (sysfs_streq(buf, "monotonic_raw"))
> -		clk = CLOCK_MONOTONIC_RAW;
> -	else if (sysfs_streq(buf, "realtime_coarse"))
> -		clk = CLOCK_REALTIME_COARSE;
> -	else if (sysfs_streq(buf, "monotonic_coarse"))
> -		clk = CLOCK_MONOTONIC_COARSE;
> -	else if (sysfs_streq(buf, "boottime"))
> -		clk = CLOCK_BOOTTIME;
> -	else if (sysfs_streq(buf, "tai"))
> -		clk = CLOCK_TAI;
> -	else
> +	ret = sysfs_match_string(clock_names, buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (ret) {
> +	case CLOCK_PROCESS_CPUTIME_ID:
> +	case CLOCK_THREAD_CPUTIME_ID:
> +	case CLOCK_REALTIME_ALARM:
> +	case CLOCK_BOOTTIME_ALARM:
> +	case CLOCK_SGI_CYCLE:
>  		return -EINVAL;
> +	default:
> +		clk = ret;
> +		break;
> +	}
>  
>  	ret = iio_device_set_clock(dev_to_iio_dev(dev), clk);
>  	if (ret)

