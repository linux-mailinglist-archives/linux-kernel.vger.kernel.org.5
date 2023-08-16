Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EE177E45C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbjHPO6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343843AbjHPO5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:57:35 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35EB1B2;
        Wed, 16 Aug 2023 07:57:32 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A1D9FC0006;
        Wed, 16 Aug 2023 14:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692197851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TU5z/ON0bT6BUefnfahNwl9FbNoTsfHur3QkjSZEKjU=;
        b=MzhLZ7X3PtTqiAozXpxfe8H5qfDOK2+Hk2egf03Y6hEsY+tR7+UN0tGdZz9Pyx2UHbPAQT
        +8iEBErAp9OhMEb3dBc4lcAeVDFJkGnq/+US6lERZLeaD7Vs57TzKxGgydhnb0Eoe5FqvO
        +0/erTG91cetirVuxA2ZUJC4eMrIN3r7evfzE0nivSNkvrz1u+m9TdjSwhUULNMEPbNMdQ
        HLKcGkXo9+XgcOhtKKAYlFd+ZlaMnPnCYYZn1Z3RMlycGC8WM/1GeJC2Ph5y8LsA2JKNyh
        59P3RoV7kPKzrgj/dtR6MUrcBJzj/rxY161IWn7VReVJ14KAYDVjsJEVl72HHA==
Date:   Wed, 16 Aug 2023 16:57:30 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/7] rtc: Add support for limited alarm timer offsets
Message-ID: <202308161457306eecdefb@mail.local>
References: <20230816133936.2150294-1-linux@roeck-us.net>
 <20230816133936.2150294-2-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816133936.2150294-2-linux@roeck-us.net>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 06:39:30-0700, Guenter Roeck wrote:
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
> ---
>  include/linux/rtc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> index 1fd9c6a21ebe..b6d000ab1e5e 100644
> --- a/include/linux/rtc.h
> +++ b/include/linux/rtc.h
> @@ -146,6 +146,7 @@ struct rtc_device {
>  
>  	time64_t range_min;
>  	timeu64_t range_max;
> +	timeu64_t range_max_offset;

While range_min and range_max are for the wall clock time, I would
prefer using a name that would clearly mark this as an alarm related
variable.

>  	time64_t start_secs;
>  	time64_t offset_secs;
>  	bool set_start_time;
> -- 
> 2.39.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
