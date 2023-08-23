Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27AD785DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbjHWQuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjHWQuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:50:51 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B184ECD5;
        Wed, 23 Aug 2023 09:50:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdbbede5d4so46360305ad.2;
        Wed, 23 Aug 2023 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692809449; x=1693414249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1rJRywRerSHpKN9caLA2gQ8y2MlCgXj2iqPjlxyJ44=;
        b=ZbJqUYDB3GH7o2Dm2wwcpAzSQT4h22XkwlJbjDjyNNmOncay379skFsmRHmELyV4/R
         IgvA/cow2ZAkGqAh8APe6+AMtAb++uacUJvIA93GQV4mOxDUWB9jdP0L72ojG5vy4Cz1
         Wn8Awn3qs5GETBGRhRcqXZn2Bcd5g64xf1uf27MO3ib51XXDXEW+D0SFd0cuFzfBmD6F
         hzCzycyvMwyLh91/WxMAGwZHNqvlKgsIA0iUTqsdsn6ZibQr/TSJHH8leGDrghxKdjni
         nP8M180gNQeFRMpuDop737u0V8M2LfgRBGae3AZyJW3luesgnrnM7dCqjBoGFTZdTrcM
         Jzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692809449; x=1693414249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1rJRywRerSHpKN9caLA2gQ8y2MlCgXj2iqPjlxyJ44=;
        b=GR5IAmB5ycEohXdmnfqBXzuAUztLdgWf+alHruX2cKQQ+EDamtXO1fKUfn49DfAslW
         ZdruYxWWMl80GBtr98geLHsRTHeP8/NMavz+kE1+SPlhLB/pNsvlOd79Ev3J8willXHt
         5VoJ57Dmc2AtC679C2wq/EciuBbEhSptgpLRBlNPpbnYTLXWkqYreD9sT296/0MBaJOd
         9aR3Msynq1n9VKmfR+TRTEoZHE/FBAlun3Ck3VhcMLRk+0zXQ5B2+lao9FESAV14jmF6
         Ro2YLnHzAffBhq7ElLHaNgCshPvQclIRYyaPItymDcP1f2J3o6jqh0Ei0Y6pUn2HeJxz
         yeJw==
X-Gm-Message-State: AOJu0Ywnq/fQzmJq80sRbNVHT8rtDSDpjEUlkZFWdP7+t7eT7MfPgUN8
        oVMv/duVlOSN4yVOECYcwdau/yGY2zc=
X-Google-Smtp-Source: AGHT+IGJ4zPUahe+I8pV4fKp97GwuTJ5+jKETKiilPbd2CcbtxsDMr1YLovxtT0fLpMFWDJ1Tyo4Og==
X-Received: by 2002:a17:903:25d4:b0:1bd:bbc3:c87b with SMTP id jc20-20020a17090325d400b001bdbbc3c87bmr11857518plb.41.1692809449014;
        Wed, 23 Aug 2023 09:50:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b001bbc8d65de0sm11221936plg.67.2023.08.23.09.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 09:50:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 23 Aug 2023 09:50:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 1/7] rtc: Add support for limited alarm timer offsets
Message-ID: <b07b19ce-7f04-409c-bcb9-6deba059f57a@roeck-us.net>
References: <20230817225537.4053865-1-linux@roeck-us.net>
 <20230817225537.4053865-2-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817225537.4053865-2-linux@roeck-us.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Thu, Aug 17, 2023 at 03:55:31PM -0700, Guenter Roeck wrote:
> Some alarm timers are based on time offsets, not on absolute times.
> In some situations, the amount of time that can be scheduled in the
> future is limited. This may result in a refusal to suspend the system,
> causing substantial battery drain.
> 
> Some RTC alarm drivers remedy the situation by setting the alarm time
> to the maximum supported time if a request for an out-of-range timeout
> is made. This is not really desirable since it may result in unexpected
> early wakeups.
> 
> To reduce the impact of this problem, let RTC drivers report the maximum
> supported alarm timer offset. The code setting alarm timers can then
> decide if it wants to reject setting alarm timers to a larger value, if it
> wants to implement recurring alarms until the actually requested alarm
> time is met, or if it wants to accept the limited alarm time.
> 
> Only introduce the necessary variable into struct rtc_device.
> Code to set and use the variable will follow with subsequent patches.
> 
> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

I guess it is a bit late to get the series into v6.6, but would it be
possible to apply it to a -next branch to get some more test coverage ?

Either case, do you have any additional comments / feedback ?

Thanks,
Guenter

> ---
> v2: Rename range_max_offset -> alarm_offset_max
> 
>  include/linux/rtc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> index 1fd9c6a21ebe..4c0bcbeb1f00 100644
> --- a/include/linux/rtc.h
> +++ b/include/linux/rtc.h
> @@ -146,6 +146,7 @@ struct rtc_device {
>  
>  	time64_t range_min;
>  	timeu64_t range_max;
> +	timeu64_t alarm_offset_max;
>  	time64_t start_secs;
>  	time64_t offset_secs;
>  	bool set_start_time;
