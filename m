Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BD1774918
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjHHTsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjHHTsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:48:32 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C094DEA7;
        Tue,  8 Aug 2023 09:52:59 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378Bs6Yf059357;
        Tue, 8 Aug 2023 06:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691495646;
        bh=85O1LHmFg/AJ8yaKognKgKFx1SZjvS1koBhd4R/gD6w=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=bkSh49bjXjvQxiVC9sI24Tb/WFdJvqVLySYHPdnrPSqsVT/ddYZMMdHpUWtrnQmVj
         NpLqEufiYT2xQA5YvU0PFkaYSuYeAQKcXDIupDqlRZQUom+GZ8l9ou76UQ55ki0kvL
         mnIhd3XDxHpFxS7KniEQNYRPjmhCU6/T8LDYxeq8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378Bs6IT025553
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 06:54:06 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 06:54:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 06:54:04 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378Bs4SH098556;
        Tue, 8 Aug 2023 06:54:04 -0500
Date:   Tue, 8 Aug 2023 17:24:03 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Kevin Hilman <khilman@kernel.org>
CC:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Praneeth Bajjuri" <praneeth@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>, Georgi Vlaev <g-vlaev@ti.com>
Subject: Re: [PATCH V6 4/4] firmware: ti_sci: Introduce system suspend resume
 support
Message-ID: <20230808115403.dkz6ev5vc6bhcmzh@dhruva>
References: <20230803064247.503036-1-d-gole@ti.com>
 <20230803064247.503036-5-d-gole@ti.com>
 <3882f0ac-b74c-6eb2-197c-34ca233cd7a3@ti.com>
 <20230803155541.nwsfwobfkbpefoyw@dhruva>
 <8c330bd9-5f4e-8cd0-ed02-c3a696d7473a@ti.com>
 <20230803160815.yfpkdfssv75d4inf@dhruva>
 <7ho7jifrda.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7ho7jifrda.fsf@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin,

Thanks for the suggestion. I have a rough proposal inline, please can
you take a look? I will test those changes and respin this series
accordingly

On Aug 07, 2023 at 14:57:05 -0700, Kevin Hilman wrote:
> Dhruva Gole <d-gole@ti.com> writes:
> 
> > On Aug 03, 2023 at 11:00:11 -0500, Andrew Davis wrote:
> >> On 8/3/23 10:55 AM, Dhruva Gole wrote:
> >> > On Aug 03, 2023 at 10:26:32 -0500, Andrew Davis wrote:
> >> > > On 8/3/23 1:42 AM, Dhruva Gole wrote:
> >> > > > Introduce system suspend resume calls that will allow the ti_sci
> >> > > > driver to support deep sleep low power mode when the user space issues a
> >> > > > suspend to mem.
> >> > > > 
> >> > > > Also, write a ti_sci_prepare_system_suspend call to be used in the driver
> >> > > > suspend handler to allow the system to identify the low power mode being
> >> > > > entered and if necessary, send TISCI_MSG_PREPARE_SLEEP with information
> >> > > > about the mode is being entered and the address for allocated memory for
> >> > > > storing the context during Deep Sleep.
> >> > > > 
> >> > > > We're using "pm_suspend_target_state" to map the kernel's target suspend
> >> > > > state to SysFW low power mode. Make sure this is available only when
> >> > > > CONFIG_SUSPEND is enabled.
> >> > > > 
> >> > > > Co-developed-by: Dave Gerlach <d-gerlach@ti.com>
> >> > > > Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> >> > > > Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> >> > > > Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> >> > > > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> >> > > > ---
> >> > > >    drivers/firmware/ti_sci.c | 63 +++++++++++++++++++++++++++++++++++++++
> >> > > >    1 file changed, 63 insertions(+)
> >> > > > 
> >> > [..snip..]
> >> > > > +static int ti_sci_suspend(struct device *dev)
> >> > > > +{
> >> > > > +	struct ti_sci_info *info = dev_get_drvdata(dev);
> >> > > > +	int ret;
> >> > > > +
> >> > > > +	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_ENABLE);
> >> > > 
> >> > > After this the will the IOs be in isolation? Or does the firmware wait
> >> > > until power down begins later?
> >> > 
> >> >  From what I understand,
> >> > IOs will be in isolation immediately
> >> > 
> >> 
> >> That is what I understand too, so then any device that may need to do some
> >> external communication for its suspend will not function, this must be the
> >> last driver _suspend() the system calls, how do you enforce that?
> >
> > I will make use of .suspend_noirq callbacks in that case. Does that
> > sound better, or is there anything else I may not be aware of?
> 
> Using _noirq just moves the problem.  What if other drivers are also
> using _noirq callbacks and run after the SCI driver?  You still cannot

True, this thought occurred to me as well which is why I was thinking
that moving it to ATF might be a better choice.

> guarantee ordering.
> 
> It seems to me that the IO isolation stuff is a system-wide operation,
> and should probably be handled at the platform suspend_ops level
> (e.g. suspend_ops->prepare_late()).   This would ensure that it runs

I must have missed this approach! Are you suggesting something like what
was done for am335?

static const struct platform_suspend_ops am33xx_pm_ops

have a similar code for tisci..?

static const struct platform_suspend_ops tisci_pm_ops = {
	.prepare_late = tisci_set_io_isolation
	};

And then while resuming we may want the pinctrl driver to scan for the
wk_evt bit[0] before the isolation is disabled, so we want the
tisci_resume/ remove isolation to be called later than that.

So I a wondering if the code below makes sense?

static const struct platform_suspend_ops tisci_pm_ops = {
	.prepare_late = tisci_suspend // also includes set isolation
	.end = tisci_resume 	// Disables isolation
	};

However a minor drawback here maybe that the serial logs on the resume
path may not appear when using a serial console for example. However
they should be able to easily access using dmesg.

> *after* all the driver hooks (even driver _noirq hooks.) and right
> before the full suspend (or s2idle.)
> 
> Now, all that being said, I noticed that in v7, you didn't move this to
> _noirq, but instead suggested that this be handled by TF-A.  I suppose
> that's an option also, but my suggestion above should work also.

Thanks for the pointer! I do believe it will make more sense to do it
from linux itself unless we have no way to do it in linux.

> 
> Kevin


[0] Table 5-517. Description Of The Pad Configuration Register Bits
https://www.ti.com/lit/pdf/spruid7

NOTE: The hardware works in such a way that as soon as the IO isolation
is disabled the wake_evt information is lost so the pinctrl-single
driver won't be able to know what pin woke it up if we disable io
isolation before it has the chance to look at the padconf registers

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
