Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19BB78639A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbjHWWvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbjHWWvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:51:39 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC18A8;
        Wed, 23 Aug 2023 15:51:36 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 153A4C0003;
        Wed, 23 Aug 2023 22:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692831095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=irfMPiuTrH/ekzdTcMQMefW3AEXMXQNNMz0TBz63xFg=;
        b=YyZBjsNdkjnQWMQCOe6+X8YhzpMjxQiAE0jZwgDO+ZAMQiLcqu17Nf5k7xebUwNF8M1BPn
        Qy9ETg8AmYreSJz/sZZKutqh0EB5dBH/00RE0sLt4DoRhJ1C50osnJNuk3t+Mj4d2Z6zgG
        z/b8KWQJjb3T1sMe4n82/tx30AtcBRW2GFckuXqkvoYWHeifb2MLmxOgaqEpstD/xCOeWF
        xt2i+VEOru+e10Y6f2KGhAJsA+vyo70+Wb/O61v2PUjU/hE1o761oqVNvcvGzhtSYYbDgd
        ko2pQIauQHu4ox2N15MP0HBYittZQHwWx7BigVinP87PdX1ljSaUAun9GmVTBw==
Date:   Thu, 24 Aug 2023 00:51:29 +0200
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
Subject: Re: [PATCH v2 1/7] rtc: Add support for limited alarm timer offsets
Message-ID: <20230823225129d2bc7dcd@mail.local>
References: <20230817225537.4053865-1-linux@roeck-us.net>
 <20230817225537.4053865-2-linux@roeck-us.net>
 <b07b19ce-7f04-409c-bcb9-6deba059f57a@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b07b19ce-7f04-409c-bcb9-6deba059f57a@roeck-us.net>
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

Hello,

On 23/08/2023 09:50:47-0700, Guenter Roeck wrote:
> Hi Alexandre,
> 
> On Thu, Aug 17, 2023 at 03:55:31PM -0700, Guenter Roeck wrote:
> > Some alarm timers are based on time offsets, not on absolute times.
> > In some situations, the amount of time that can be scheduled in the
> > future is limited. This may result in a refusal to suspend the system,
> > causing substantial battery drain.
> > 
> > Some RTC alarm drivers remedy the situation by setting the alarm time
> > to the maximum supported time if a request for an out-of-range timeout
> > is made. This is not really desirable since it may result in unexpected
> > early wakeups.
> > 
> > To reduce the impact of this problem, let RTC drivers report the maximum
> > supported alarm timer offset. The code setting alarm timers can then
> > decide if it wants to reject setting alarm timers to a larger value, if it
> > wants to implement recurring alarms until the actually requested alarm
> > time is met, or if it wants to accept the limited alarm time.
> > 
> > Only introduce the necessary variable into struct rtc_device.
> > Code to set and use the variable will follow with subsequent patches.
> > 
> > Cc: Brian Norris <briannorris@chromium.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> I guess it is a bit late to get the series into v6.6, but would it be
> possible to apply it to a -next branch to get some more test coverage ?
> 

I'm probably going to take 1 and 3-7 for 6.6 once I get a reliable
internet access. I can't take 2/7 without a review or ack from the time
maintainers.

> Either case, do you have any additional comments / feedback ?
> 

The main issue that remains is that after 2/7, the rtc_device structure
is not opaque anymore to its user as alarmtimer_suspend now directly
accesses one of the members. But I'd have to find which RTCs have an
absolute limit so we can design a proper API. I may also decide that it
is good enough to require that the alarm range must cover the registered
RTC range.

> Thanks,
> Guenter
> 
> > ---
> > v2: Rename range_max_offset -> alarm_offset_max
> > 
> >  include/linux/rtc.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> > index 1fd9c6a21ebe..4c0bcbeb1f00 100644
> > --- a/include/linux/rtc.h
> > +++ b/include/linux/rtc.h
> > @@ -146,6 +146,7 @@ struct rtc_device {
> >  
> >  	time64_t range_min;
> >  	timeu64_t range_max;
> > +	timeu64_t alarm_offset_max;
> >  	time64_t start_secs;
> >  	time64_t offset_secs;
> >  	bool set_start_time;

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
