Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4832767EBD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjG2LhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjG2LhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:37:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DD5E7C;
        Sat, 29 Jul 2023 04:37:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 959C060B8F;
        Sat, 29 Jul 2023 11:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E94C433C8;
        Sat, 29 Jul 2023 11:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690630622;
        bh=UayIjxHwlnAcaTvtEIYrbgAned9lO0CxfMlcQ4GbUBU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pVrYuOYZJquHZ+alKe6yJq8moufLuxRkEdHaNlLVMec0DcPfsCLLfo36YMSOXwRP9
         5AyVQVUU6U/BmEhlZVf1D440OR9KuTQ0xtWhmj42aPxClzq9VTkOQtL5Ziu1WFKoZC
         CVI+UpTAvuoCPgu9hv47X9XyN6ulBw9hwm7Jeu+q8RwfYgnjbK5h+iukX/K6EDPdzu
         eJddUtxCE7klGXmTSxF7Ob2RlVNmacJaBCZGYOF2ynWYy7mDjyPPukzjPzmzxlPLB7
         azkVMl54e1EGZs2HvTefl9khgYyAV6hoZsVEe+DwjRxOTPBtaQKmDQje4MZ5AHHIEW
         AuWhKt+LGTfeA==
Date:   Sat, 29 Jul 2023 12:37:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v3 1/4] iio: core: Use sysfs_match_string() helper
Message-ID: <20230729123708.0b5ee75e@jic23-huawei>
In-Reply-To: <20230724110204.46285-2-andriy.shevchenko@linux.intel.com>
References: <20230724110204.46285-1-andriy.shevchenko@linux.intel.com>
        <20230724110204.46285-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 14:02:01 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use sysfs_match_string() helper instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
I'm not loving the match against a larger list in order to then throw
away the ones we don't like, but I guess it is harmless and will make
reuse easier if this ever becomes more generally useful.

Hopefully it won't because no one else will think: "Let's provide
an interface that gives userspace the option to pick from many weird
clock choices".

In case you haven't guessed, that's one decision from a long time back
I wish I'd made differently.   2 choices would have been plenty..

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 71 +++++++++++++++------------------
>  1 file changed, 32 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 5f337f59330c..b153adc5bc84 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1397,50 +1397,42 @@ static ssize_t label_show(struct device *dev, struct device_attribute *attr,
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
>  	switch (clk) {
>  	case CLOCK_REALTIME:
> -		name = "realtime\n";
> -		sz = sizeof("realtime\n");
> -		break;
>  	case CLOCK_MONOTONIC:
> -		name = "monotonic\n";
> -		sz = sizeof("monotonic\n");
> -		break;
>  	case CLOCK_MONOTONIC_RAW:
> -		name = "monotonic_raw\n";
> -		sz = sizeof("monotonic_raw\n");
> -		break;
>  	case CLOCK_REALTIME_COARSE:
> -		name = "realtime_coarse\n";
> -		sz = sizeof("realtime_coarse\n");
> -		break;
>  	case CLOCK_MONOTONIC_COARSE:
> -		name = "monotonic_coarse\n";
> -		sz = sizeof("monotonic_coarse\n");
> -		break;
>  	case CLOCK_BOOTTIME:
> -		name = "boottime\n";
> -		sz = sizeof("boottime\n");
> -		break;
>  	case CLOCK_TAI:
> -		name = "tai\n";
> -		sz = sizeof("tai\n");
>  		break;
>  	default:
>  		BUG();
>  	}
>  
> -	memcpy(buf, name, sz);
> -	return sz;
> +	return sysfs_emit(buf, "%s\n", clock_names[clk]);
>  }
>  
>  static ssize_t current_timestamp_clock_store(struct device *dev,
> @@ -1450,22 +1442,23 @@ static ssize_t current_timestamp_clock_store(struct device *dev,
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
> +	clk = ret;
> +
> +	switch (clk) {
> +	case CLOCK_REALTIME:
> +	case CLOCK_MONOTONIC:
> +	case CLOCK_MONOTONIC_RAW:
> +	case CLOCK_REALTIME_COARSE:
> +	case CLOCK_MONOTONIC_COARSE:
> +	case CLOCK_BOOTTIME:
> +	case CLOCK_TAI:
> +		break;
> +	default:
>  		return -EINVAL;
> +	}
>  
>  	ret = iio_device_set_clock(dev_to_iio_dev(dev), clk);
>  	if (ret)

