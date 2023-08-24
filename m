Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA897865D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 05:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239607AbjHXD06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 23:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbjHXD0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:26:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B6010F1;
        Wed, 23 Aug 2023 20:26:30 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c0bae4da38so3667965ad.0;
        Wed, 23 Aug 2023 20:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692847590; x=1693452390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcGYMXgYpBCElk15uP8fPMKVPYLlXf+c4KnubixoY38=;
        b=Ja3ruaOEx42FX4oWcwYW8o+k7SGSonhpx4/aUpiyENJIdiSAlCH7gUUHLESD/X5aZh
         ItmWGcEXgPyelRoEVx32YRXYtnLXTWaX5jBlFGIuABNaer1krh0K25cV9LGERdmOMZSE
         7LwLL9bDFxgeCfrNionwPQjys6pU4k2nLiMIeMlK6WehkH2WWcDPmVc0CxBAzSM+HoiQ
         d6IaEG1J+QSYxImtjlHYpqNlfnX4/ZTHGIUMOdinWEcMxU4MvvfBT1+ABz54kWRgxAiI
         69HqNTWy5uTnSpy7/LbZQN8CgKtbA7ERpSe6hqY+ZZWhinBrkCtRbPngYlMWDqv3boZH
         Vrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692847590; x=1693452390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcGYMXgYpBCElk15uP8fPMKVPYLlXf+c4KnubixoY38=;
        b=StWEUbE8GYXEwcOboTDqKp62xmP3Ezv9xi5FDaGrFXiWT6jl7qOll4yK9/+jgjYPv8
         85Fpk508GkMWJIstke1ps7WXmTzPloCCkfvUpuJYRBRF953WNV7ry/+uoDqf+IzD94G7
         aVDkFVH4xkck1cTmimGzrtx+MsuWmSPzbJ125284SHL0ZbRx4DV8LOG8JUu60qZbhl6C
         zYSSk+MeeKnEPUTMhF7tyfvq/OUkONP1ENwQlbR9yLa6Kp77oTM45tdsueV71i9x9v1B
         Hwz3x59cRH+rvumE39Fl6C3IrUAQv706psg8fiDr4sZQonccxS7Wv0FCAa4v/WUlle4b
         nfOw==
X-Gm-Message-State: AOJu0YzOCIo7ILmZlaw3louBWjYGgDxLI2lMCUJMU+eSSfJbz6sIFrXA
        2KoqyvFHmeKtBm2RZgSNAtXw3ArQ84Y=
X-Google-Smtp-Source: AGHT+IErqcMwHCEEqaldyOuOPE7uGxuESre3Uf1mw3uVdjhqCo7r2j6gc/vsySNkdhSz+Xk6wRDTTA==
X-Received: by 2002:a17:902:db09:b0:1bf:8132:d19f with SMTP id m9-20020a170902db0900b001bf8132d19fmr17569128plx.27.1692847590065;
        Wed, 23 Aug 2023 20:26:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b001bc6536051bsm11560801plh.184.2023.08.23.20.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:26:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 23 Aug 2023 20:26:28 -0700
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
Message-ID: <65119fd3-59e6-44c9-9fe0-85e9270b3a48@roeck-us.net>
References: <20230817225537.4053865-1-linux@roeck-us.net>
 <20230817225537.4053865-2-linux@roeck-us.net>
 <b07b19ce-7f04-409c-bcb9-6deba059f57a@roeck-us.net>
 <20230823225129d2bc7dcd@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823225129d2bc7dcd@mail.local>
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

On Thu, Aug 24, 2023 at 12:51:29AM +0200, Alexandre Belloni wrote:
> Hello,
> 
> On 23/08/2023 09:50:47-0700, Guenter Roeck wrote:
> > Hi Alexandre,
> > 
> > On Thu, Aug 17, 2023 at 03:55:31PM -0700, Guenter Roeck wrote:
> > > Some alarm timers are based on time offsets, not on absolute times.
> > > In some situations, the amount of time that can be scheduled in the
> > > future is limited. This may result in a refusal to suspend the system,
> > > causing substantial battery drain.
> > > 
> > > Some RTC alarm drivers remedy the situation by setting the alarm time
> > > to the maximum supported time if a request for an out-of-range timeout
> > > is made. This is not really desirable since it may result in unexpected
> > > early wakeups.
> > > 
> > > To reduce the impact of this problem, let RTC drivers report the maximum
> > > supported alarm timer offset. The code setting alarm timers can then
> > > decide if it wants to reject setting alarm timers to a larger value, if it
> > > wants to implement recurring alarms until the actually requested alarm
> > > time is met, or if it wants to accept the limited alarm time.
> > > 
> > > Only introduce the necessary variable into struct rtc_device.
> > > Code to set and use the variable will follow with subsequent patches.
> > > 
> > > Cc: Brian Norris <briannorris@chromium.org>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > I guess it is a bit late to get the series into v6.6, but would it be
> > possible to apply it to a -next branch to get some more test coverage ?
> > 
> 
> I'm probably going to take 1 and 3-7 for 6.6 once I get a reliable
> internet access. I can't take 2/7 without a review or ack from the time
> maintainers.
> 
Ok, makes sense.

> > Either case, do you have any additional comments / feedback ?
> > 
> 
> The main issue that remains is that after 2/7, the rtc_device structure
> is not opaque anymore to its user as alarmtimer_suspend now directly
> accesses one of the members. But I'd have to find which RTCs have an
> absolute limit so we can design a proper API. I may also decide that it
> is good enough to require that the alarm range must cover the registered
> RTC range.
> 
What exactly do you have in mind ? For our use case, we need
alarmtimer_suspend() to either sleep for the requested time, or as long
as possible. Would an API function returning the alarm limit address
your concerns ?

Regarding relative/absolute, it is a mixed bag. Below is what I found
for the alphabetically first ~40 drivers. Note that "absolute" in the
configuration column means that the alarm time is specified as absolute
value (e.g, at 1am), not that the limit is absolute or relative to the
current time. The limit column gives a hint if the limit is relative
or absolute. In many cases the alarm is configured as absolute value
but limited to day/week/month/year in the future.

On a side note, struct rtc_device isn't exactly opaque even today.
Both alarmtimer.c and ntp.c already access some of its members.

Thanks,
Guenter

---
driver			configuration	limit		comments
rtc-88pm80x.c           relative        24 hours        silently adjusted
rtc-88pm860x.c          relative        32 bit seconds  unchecked
rtc-ab8500.c            absolute        ~2032           unchecked
rtc-ab-b5ze-s3.c        relative        1 month         -EINVAL
rtc-ab-eoz9.c           absolute        1 month         month & year ignored (1 month + 1 day -> fires after 1 day)
rtc-abx80x.c            absolute        1 year          year ignored (1 year + 1 day -> fires after 1 day)
rtc-ac100.c             absolute        2069            -EINVAL
rtc-armada38x.c         absolute        2106            unchecked
rtc-as3722.c            absolute        unlimited       unchecked
rtc-asm9260.c           absolute        unlimited       unchecked
rtc-at91rm9200.c        absolute        1 year          year ignored (1 year + 1 day -> fires after 1 day)
rtc-at91sam9.c          relative        32 bit seconds  unchecked
rtc-bd70528.c           absolute        2099            unchecked
rtc-brcmstb-waketimer.c absolute        2106            unchecked
rtc-cadence.c           absolute        2999            unchecked
rtc-cmos.c              absolute        day/month/year  -EINVAL if out of range
rtc-cpcap.c             absolute        ~2059           in days since 1970, day masked, unchecked (2060 -> 1971)
rtc-cros-ec.c           relative        24h or max      -EINVAL
rtc-da9052.c            absolute        2063            unchecked, year masked
rtc-da9055.c            absolute        2133 ?          unchecked, year masked
rtc-da9063.c            absolute        2063            unchecked, year masked
rtc-digicolor.c         relative        32-bit seconds  unchecked
rtc-ds1286.c            absolute        24 hours        unchecked, month & year ignored
rtc-ds1305.c            absolute        24 hours        -EINVAL
rtc-ds1307.c            absolute        1 year          unchecked, year ignored
rtc-ds1343.c            absolute        1 month         unchecked, month / year ignored
rtc-ds1374.c            relative        ~194 days       unchecked, masked (195 days -> fires after 1 day)
rtc-ds1511.c            absolute        1 month         unchecked, month/year ignored
rtc-ds1553.c            absolute        1 month         unchecked, month/year ignored
rtc-ds1685.c            absolute        1 month         unchecked, month/year ignored
rtc-ds3232.c            absolute        1 month         unchecked, month/year ignored
rtc-efi.c               absolute        not specified   several years
rtc-fm3130.c            absolute        1 year          year ignored
rtc-fsl-ftm-alarm.c     relative        262 seconds     -ERANGE
rtc-goldfish.c          absolute        ~500 years      unchecked
rtc-hym8563.c           absolute        1 month         unchecked, month/year ignored
rtc-imxdi.c             abolute         2106            unchecked (32 bit seconds since 1970)
rtc-imx-sc.c            absolute        unknown         Value passed to SCU which determines if valid
rtc-isl1208.c           absolute        1 year          unchecked, year ignored
rtc-jz4740.c            absolute        2106            unchecked (32 bit seconds since 1970)

