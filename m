Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747687BF775
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjJJJfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjJJJfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:35:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E71C493;
        Tue, 10 Oct 2023 02:35:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E96391FB;
        Tue, 10 Oct 2023 02:35:53 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B4C43F762;
        Tue, 10 Oct 2023 02:35:11 -0700 (PDT)
Date:   Tue, 10 Oct 2023 10:35:09 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, ranjani.vaidyanathan@nxp.com,
        souvik.chakravarty@arm.com, glen.wienecke@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [RFC] firmware: arm_scmi: clock: add fixed clock attribute
 support
Message-ID: <20231010093509.ddy75og4jd72n6cq@bogus>
References: <20231010022911.4106863-1-peng.fan@oss.nxp.com>
 <20231010091223.rvcyrgbjcrmjzmvp@bogus>
 <ZSUXu65bOYVG689E@pluto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSUXu65bOYVG689E@pluto>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:22:03AM +0100, Cristian Marussi wrote:
> On Tue, Oct 10, 2023 at 10:12:23AM +0100, Sudeep Holla wrote:
> > On Tue, Oct 10, 2023 at 10:29:11AM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > > 
> > > There are clocks:
> > >  system critical, not allow linux to disable, change rate
> > >  allow linux to get rate, because some periphals will use the frequency
> > >  to configure periphals.
> > > 
> > >  So introduce an attribute to indicated FIXED clock
> > > 
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/clk/clk-scmi.c            | 6 ++++++
> > >  drivers/firmware/arm_scmi/clock.c | 5 ++++-
> > >  include/linux/scmi_protocol.h     | 1 +
> > >  3 files changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> > > index 8cbe24789c24..a539a35bd45a 100644
> > > --- a/drivers/clk/clk-scmi.c
> > > +++ b/drivers/clk/clk-scmi.c
> > > @@ -182,6 +182,10 @@ static const struct clk_ops scmi_clk_ops = {
> > >  	.determine_rate = scmi_clk_determine_rate,
> > >  };
> > >  
> > > +static const struct clk_ops scmi_fixed_rate_clk_ops = {
> > > +	.recalc_rate = scmi_clk_recalc_rate,
> > > +};
> > > +
> > >  static const struct clk_ops scmi_atomic_clk_ops = {
> > >  	.recalc_rate = scmi_clk_recalc_rate,
> > >  	.round_rate = scmi_clk_round_rate,
> > > @@ -293,6 +297,8 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
> > >  		if (is_atomic &&
> > >  		    sclk->info->enable_latency <= atomic_threshold)
> > >  			scmi_ops = &scmi_atomic_clk_ops;
> > > +		else if (sclk->info->rate_fixed)
> > > +			scmi_ops = &scmi_fixed_rate_clk_ops;
> > >  		else
> > >  			scmi_ops = &scmi_clk_ops;
> > >  
> > > diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> > > index ddaef34cd88b..8c52db539e54 100644
> > > --- a/drivers/firmware/arm_scmi/clock.c
> > > +++ b/drivers/firmware/arm_scmi/clock.c
> > > @@ -46,6 +46,7 @@ struct scmi_msg_resp_clock_attributes {
> > >  #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
> > >  #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
> > >  #define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
> > > +#define SUPPORTS_FIXED_RATE_CLOCK(x)		((x) & BIT(27))
> > 
> > I don't see this in the specification, am I missing something ?
> > 
> > And why do we need it. Can't this be discrete clock with only one clock
> > rate ? Or step clock with both lowest and highest the same and step being 0.
> > At-least I don't see the need to change the spec for this and hence no need
> > to assign any attribute bit-field to represent the same.
> > 
> 
> No this is not in the spec, it would require a spec change.
> 
> My understanding is that they have clocks that CAN have more than one rate BUT
> such clock cannot be changed by Linux, only other agents can
> enable/disable/set_rate BUT they still want to be able to query the
> current rate for configuration purposes.
> 

Fair enough. As I mentioned to Peng on the other thread, it is *not a fixed*
clock. It is read only for this agent.

-- 
Regards,
Sudeep
