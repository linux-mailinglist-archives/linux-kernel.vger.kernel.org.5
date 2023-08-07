Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541B47731B0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjHGV5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjHGV5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:57:08 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925F094
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 14:57:07 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-564af0ac494so2490089a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 14:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691445427; x=1692050227;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvIEaTGboMwJuS/k2b6YBv94pmgX2U83ceP6WGTpdkM=;
        b=CxEA1DnrJufBvFMJe9iCWLnY+6V4ZlMdCbvcdwWO8SQlAdAbPEZ7aaUY4yU7itBeqj
         stf2HYOTPVdGhvfQ7woSK4XHHbiCAkwLPIJ9hyJlFMb+7+hqOetmtSPli3eozooAtLH3
         mx1KPRN37znObMXlgzXgkjlI1feFjpyZeJTZuja0VtaNGa733fEJxzzH1e8A/JatNOH4
         kaVLQ8Z2ngCVAeRuci9IabJgIbYp5/9kGdkx1o/wembUMFT8+kBTXPWzQQJSics2ifD7
         igf2UNhyrwzd9RzH5yhcR50lKV3BEgltUnCquvRW/kBL8tg0Q2ofhZzxhhkeWGsufFLA
         ZkeQ==
X-Gm-Message-State: AOJu0YyFkiInuOa1wf0bkPNnd1ghgA1HKOJsZ0slNwlzmc3p0JQKtHS5
        JA0I1NrzYV5W/EDom68BoqyNdA==
X-Google-Smtp-Source: AGHT+IEdiUMcXmPMcKTJnHdeH59gwbfl+t+l+pkmpPSb1V346uMtAeM99tfVQPHhldq22o7KUFssAw==
X-Received: by 2002:a17:90b:38c3:b0:262:f09c:e73d with SMTP id nn3-20020a17090b38c300b00262f09ce73dmr8289917pjb.34.1691445426934;
        Mon, 07 Aug 2023 14:57:06 -0700 (PDT)
Received: from localhost ([75.172.135.98])
        by smtp.gmail.com with ESMTPSA id u19-20020a17090a891300b00267fbd521dbsm9237293pjn.5.2023.08.07.14.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:57:06 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>, Andrew Davis <afd@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>, Georgi Vlaev <g-vlaev@ti.com>
Subject: Re: [PATCH V6 4/4] firmware: ti_sci: Introduce system suspend
 resume support
In-Reply-To: <20230803160815.yfpkdfssv75d4inf@dhruva>
References: <20230803064247.503036-1-d-gole@ti.com>
 <20230803064247.503036-5-d-gole@ti.com>
 <3882f0ac-b74c-6eb2-197c-34ca233cd7a3@ti.com>
 <20230803155541.nwsfwobfkbpefoyw@dhruva>
 <8c330bd9-5f4e-8cd0-ed02-c3a696d7473a@ti.com>
 <20230803160815.yfpkdfssv75d4inf@dhruva>
Date:   Mon, 07 Aug 2023 14:57:05 -0700
Message-ID: <7ho7jifrda.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dhruva Gole <d-gole@ti.com> writes:

> On Aug 03, 2023 at 11:00:11 -0500, Andrew Davis wrote:
>> On 8/3/23 10:55 AM, Dhruva Gole wrote:
>> > On Aug 03, 2023 at 10:26:32 -0500, Andrew Davis wrote:
>> > > On 8/3/23 1:42 AM, Dhruva Gole wrote:
>> > > > Introduce system suspend resume calls that will allow the ti_sci
>> > > > driver to support deep sleep low power mode when the user space issues a
>> > > > suspend to mem.
>> > > > 
>> > > > Also, write a ti_sci_prepare_system_suspend call to be used in the driver
>> > > > suspend handler to allow the system to identify the low power mode being
>> > > > entered and if necessary, send TISCI_MSG_PREPARE_SLEEP with information
>> > > > about the mode is being entered and the address for allocated memory for
>> > > > storing the context during Deep Sleep.
>> > > > 
>> > > > We're using "pm_suspend_target_state" to map the kernel's target suspend
>> > > > state to SysFW low power mode. Make sure this is available only when
>> > > > CONFIG_SUSPEND is enabled.
>> > > > 
>> > > > Co-developed-by: Dave Gerlach <d-gerlach@ti.com>
>> > > > Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> > > > Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
>> > > > Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
>> > > > Signed-off-by: Dhruva Gole <d-gole@ti.com>
>> > > > ---
>> > > >    drivers/firmware/ti_sci.c | 63 +++++++++++++++++++++++++++++++++++++++
>> > > >    1 file changed, 63 insertions(+)
>> > > > 
>> > [..snip..]
>> > > > +static int ti_sci_suspend(struct device *dev)
>> > > > +{
>> > > > +	struct ti_sci_info *info = dev_get_drvdata(dev);
>> > > > +	int ret;
>> > > > +
>> > > > +	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_ENABLE);
>> > > 
>> > > After this the will the IOs be in isolation? Or does the firmware wait
>> > > until power down begins later?
>> > 
>> >  From what I understand,
>> > IOs will be in isolation immediately
>> > 
>> 
>> That is what I understand too, so then any device that may need to do some
>> external communication for its suspend will not function, this must be the
>> last driver _suspend() the system calls, how do you enforce that?
>
> I will make use of .suspend_noirq callbacks in that case. Does that
> sound better, or is there anything else I may not be aware of?

Using _noirq just moves the problem.  What if other drivers are also
using _noirq callbacks and run after the SCI driver?  You still cannot
guarantee ordering.

It seems to me that the IO isolation stuff is a system-wide operation,
and should probably be handled at the platform suspend_ops level
(e.g. suspend_ops->prepare_late()).   This would ensure that it runs
*after* all the driver hooks (even driver _noirq hooks.) and right
before the full suspend (or s2idle.)

Now, all that being said, I noticed that in v7, you didn't move this to
_noirq, but instead suggested that this be handled by TF-A.  I suppose
that's an option also, but my suggestion above should work also.

Kevin
