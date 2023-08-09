Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E133B774FC2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 02:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjHIAUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 20:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHIAUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 20:20:09 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E05A1982
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 17:20:08 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so54601925ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 17:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691540407; x=1692145207;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zOSYuHnym2FwqD1we2DD5H7k4wgLaijhaz/3VHmzXc=;
        b=AyqS8RwGVuMU7YkGmKGEZQsV5b0bzZYTq4XWlCaBbr52CiOoqkp22T0xMdZz2VAME6
         sPlYEcNjSPtzBGAGGnZniNbDiTyRU/ywrXj/LqgcqgET2o1STQ9HSpfJiD7gJy1R7HnV
         DKv+hOUKwaNlpENxQAIEI3KuqIc0J+emjBdVBvaofLIHR3WtOQNC9VQg2yPRhktmNORH
         BD6mC39VawfWiNvRMdoRqP0zx3bP9/qdGToMc7naTRPU9vO37ULT0fXThhX9Xpp+LN8z
         WkPB9yuhXOhbRYZG+CPiy+Vevc0Pcn4lSBD1mTw86r1xPuQUuIscf3qvZeiUvrsd0eAd
         0v0w==
X-Gm-Message-State: AOJu0Yz2XcRo9oELL5hG98J7CJW58qEnILc76I6r7cSUCq5KRyWQi3Ih
        PN9TpuvPDSBvhBdILsvr8mhrAA==
X-Google-Smtp-Source: AGHT+IE0L2cGA3Z91KiPpHf69xBPly0QCy8a7bmvASy2Wr9dCqLmRNKXCZLq1MOiXFVsZKwoILfE7g==
X-Received: by 2002:a17:902:ce90:b0:1b9:e23a:f761 with SMTP id f16-20020a170902ce9000b001b9e23af761mr1184280plg.63.1691540407463;
        Tue, 08 Aug 2023 17:20:07 -0700 (PDT)
Received: from localhost ([75.172.135.98])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001b8a2edab6asm9600441pld.244.2023.08.08.17.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:20:06 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>, Georgi Vlaev <g-vlaev@ti.com>
Subject: Re: [PATCH V6 4/4] firmware: ti_sci: Introduce system suspend
 resume support
In-Reply-To: <20230808115403.dkz6ev5vc6bhcmzh@dhruva>
References: <20230803064247.503036-1-d-gole@ti.com>
 <20230803064247.503036-5-d-gole@ti.com>
 <3882f0ac-b74c-6eb2-197c-34ca233cd7a3@ti.com>
 <20230803155541.nwsfwobfkbpefoyw@dhruva>
 <8c330bd9-5f4e-8cd0-ed02-c3a696d7473a@ti.com>
 <20230803160815.yfpkdfssv75d4inf@dhruva> <7ho7jifrda.fsf@baylibre.com>
 <20230808115403.dkz6ev5vc6bhcmzh@dhruva>
Date:   Tue, 08 Aug 2023 17:20:06 -0700
Message-ID: <7httt9dq2x.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dhruva,

Dhruva Gole <d-gole@ti.com> writes:

> Kevin,
>
> Thanks for the suggestion. I have a rough proposal inline, please can
> you take a look? I will test those changes and respin this series
> accordingly
>
> On Aug 07, 2023 at 14:57:05 -0700, Kevin Hilman wrote:
>> Dhruva Gole <d-gole@ti.com> writes:
>> 
>> > On Aug 03, 2023 at 11:00:11 -0500, Andrew Davis wrote:
>> >> On 8/3/23 10:55 AM, Dhruva Gole wrote:
>> >> > On Aug 03, 2023 at 10:26:32 -0500, Andrew Davis wrote:
>> >> > > On 8/3/23 1:42 AM, Dhruva Gole wrote:
>> >> > > > Introduce system suspend resume calls that will allow the ti_sci
>> >> > > > driver to support deep sleep low power mode when the user space issues a
>> >> > > > suspend to mem.
>> >> > > > 
>> >> > > > Also, write a ti_sci_prepare_system_suspend call to be used in the driver
>> >> > > > suspend handler to allow the system to identify the low power mode being
>> >> > > > entered and if necessary, send TISCI_MSG_PREPARE_SLEEP with information
>> >> > > > about the mode is being entered and the address for allocated memory for
>> >> > > > storing the context during Deep Sleep.
>> >> > > > 
>> >> > > > We're using "pm_suspend_target_state" to map the kernel's target suspend
>> >> > > > state to SysFW low power mode. Make sure this is available only when
>> >> > > > CONFIG_SUSPEND is enabled.
>> >> > > > 
>> >> > > > Co-developed-by: Dave Gerlach <d-gerlach@ti.com>
>> >> > > > Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> >> > > > Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
>> >> > > > Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
>> >> > > > Signed-off-by: Dhruva Gole <d-gole@ti.com>
>> >> > > > ---
>> >> > > >    drivers/firmware/ti_sci.c | 63 +++++++++++++++++++++++++++++++++++++++
>> >> > > >    1 file changed, 63 insertions(+)
>> >> > > > 
>> >> > [..snip..]
>> >> > > > +static int ti_sci_suspend(struct device *dev)
>> >> > > > +{
>> >> > > > +	struct ti_sci_info *info = dev_get_drvdata(dev);
>> >> > > > +	int ret;
>> >> > > > +
>> >> > > > +	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_ENABLE);
>> >> > > 
>> >> > > After this the will the IOs be in isolation? Or does the firmware wait
>> >> > > until power down begins later?
>> >> > 
>> >> >  From what I understand,
>> >> > IOs will be in isolation immediately
>> >> > 
>> >> 
>> >> That is what I understand too, so then any device that may need to do some
>> >> external communication for its suspend will not function, this must be the
>> >> last driver _suspend() the system calls, how do you enforce that?
>> >
>> > I will make use of .suspend_noirq callbacks in that case. Does that
>> > sound better, or is there anything else I may not be aware of?
>> 
>> Using _noirq just moves the problem.  What if other drivers are also
>> using _noirq callbacks and run after the SCI driver?  You still cannot
>
> True, this thought occurred to me as well which is why I was thinking
> that moving it to ATF might be a better choice.
>
>> guarantee ordering.
>> 
>> It seems to me that the IO isolation stuff is a system-wide operation,
>> and should probably be handled at the platform suspend_ops level
>> (e.g. suspend_ops->prepare_late()).   This would ensure that it runs
>
> I must have missed this approach! Are you suggesting something like what
> was done for am335?
>
> static const struct platform_suspend_ops am33xx_pm_ops
>
> have a similar code for tisci..?
>
> static const struct platform_suspend_ops tisci_pm_ops = {
> 	.prepare_late = tisci_set_io_isolation
> 	};

Yes, with the minor nit that I would make a tisci_prepare_late()
function, which then calls _set_io_isolation(), since there may be some
other things we want to do in the "late" prepare for other LPM modes.

Also, for the additional LPM modes (more than DeepSleep), we're looking
at using suspend-to-idle (s2idle) to manage those.  So in addition to
platform_suspend_ops->prepare_late(), you should add this function to
s2idle_ops->prepare_late() also.

> And then while resuming we may want the pinctrl driver to scan for the
> wk_evt bit[0] before the isolation is disabled, so we want the
> tisci_resume/ remove isolation to be called later than that.
>
> So I a wondering if the code below makes sense?
>
> static const struct platform_suspend_ops tisci_pm_ops = {
> 	.prepare_late = tisci_suspend // also includes set isolation
> 	.end = tisci_resume 	// Disables isolation
> 	};
>
> However a minor drawback here maybe that the serial logs on the resume
> path may not appear when using a serial console for example. However
> they should be able to easily access using dmesg.

I'm not sure I fully understand this usecase, but using ->end() seems
drastic.  If IO isolation is disabled that long, won't that cause
problems for driver's ->resume callbacks that want to touch hardware?

To me, it sounds like you might want to use ->resume_early() or maybe
->resume_noirq() in the pinctrl driver for this so that IO isolation can
be disabled sooner?

>> *after* all the driver hooks (even driver _noirq hooks.) and right
>> before the full suspend (or s2idle.)
>> 
>> Now, all that being said, I noticed that in v7, you didn't move this to
>> _noirq, but instead suggested that this be handled by TF-A.  I suppose
>> that's an option also, but my suggestion above should work also.
>
> Thanks for the pointer! I do believe it will make more sense to do it
> from linux itself unless we have no way to do it in linux.
>
>> 
>> Kevin
>
>
> [0] Table 5-517. Description Of The Pad Configuration Register Bits
> https://www.ti.com/lit/pdf/spruid7
>
> NOTE: The hardware works in such a way that as soon as the IO isolation
> is disabled the wake_evt information is lost so the pinctrl-single
> driver won't be able to know what pin woke it up if we disable io
> isolation before it has the chance to look at the padconf registers

Ah, OK.  So yeah, as I hinted at above, what about using
->resume_noirq() in the pinctrl driver to get the wake_evt information,
and then use the s2idle_ops->restore_early() to disable IO isolation,
since this happens after all the driver's noirq hooks have run.

Kevin

