Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18937787179
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbjHXO0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241639AbjHXOZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:25:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F9C21FCE;
        Thu, 24 Aug 2023 07:25:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09C2DD75;
        Thu, 24 Aug 2023 07:26:03 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07C9B3F762;
        Thu, 24 Aug 2023 07:25:20 -0700 (PDT)
Date:   Thu, 24 Aug 2023 15:25:21 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        etienne.carriere@linaro.org, peng.fan@oss.nxp.com,
        chuck.cannon@nxp.com, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/6] firmware: arm_scmi: Simplify enable/disable Clock
 operations
Message-ID: <ZOdoP00tlAIRr9fN@pluto>
References: <20230811161446.636253-1-cristian.marussi@arm.com>
 <20230811161446.636253-2-cristian.marussi@arm.com>
 <17bd83d833b59fd4f64eec433589fa55.sboyd@kernel.org>
 <ZOXLNliOogkNyJYQ@e120937-lin>
 <a14cdd584283d32a3642658aaed6c98c.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a14cdd584283d32a3642658aaed6c98c.sboyd@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 11:01:17AM -0700, Stephen Boyd wrote:
> Quoting Cristian Marussi (2023-08-23 02:02:46)
> > On Tue, Aug 22, 2023 at 01:17:15PM -0700, Stephen Boyd wrote:
> > > Quoting Cristian Marussi (2023-08-11 09:14:41)
> > > > Add a param to Clock enable/disable operation to ask for atomic operation
> > > > and remove _atomic version of such operations.
> > > 
> > 
> > Hi,
> 
> Yo
> 
> > 
> > > Why?
> > > 
> > 
> > :D, given that the 2 flavours of SCMI enable/disable ops (and the upcoming
> > state_get) just differ in their operating mode (atomic or not) and the
> > Clock framework in turn wrap such calls into 4 related and explicitly
> > named clk_ops (scmi_clock_enable/scmi_clock_atomic_enable etc) that hint
> > at what is being done, seemed to me reasonable to reduce the churn and
> > remove a bit of code wrappers in favour of a param.
> 
> Please add these extra details to the commit text about why we're making
> the change.
> 
Sure I'll do.

> > 
> > > > 
> > > > No functional change.
> > > > 
> > > > CC: Michael Turquette <mturquette@baylibre.com>
> > > > CC: Stephen Boyd <sboyd@kernel.org>
> > > > CC: linux-clk@vger.kernel.org
> > > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > > ---
> > > >  drivers/clk/clk-scmi.c            |  8 ++++----
> > > >  drivers/firmware/arm_scmi/clock.c | 24 ++++++------------------
> > > >  include/linux/scmi_protocol.h     |  9 ++++-----
> > > >  3 files changed, 14 insertions(+), 27 deletions(-)
> > > > 
> > > > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> > > > index 2c7a830ce308..ff003083e592 100644
> > > > --- a/drivers/clk/clk-scmi.c
> > > > +++ b/drivers/clk/clk-scmi.c
> > > > @@ -78,28 +78,28 @@ static int scmi_clk_enable(struct clk_hw *hw)
> > > >  {
> > > >         struct scmi_clk *clk = to_scmi_clk(hw);
> > > >  
> > > > -       return scmi_proto_clk_ops->enable(clk->ph, clk->id);
> > > > +       return scmi_proto_clk_ops->enable(clk->ph, clk->id, false);
> > > >  }
> > > >  
> > > >  static void scmi_clk_disable(struct clk_hw *hw)
> > > >  {
> > > >         struct scmi_clk *clk = to_scmi_clk(hw);
> > > >  
> > > > -       scmi_proto_clk_ops->disable(clk->ph, clk->id);
> > > > +       scmi_proto_clk_ops->disable(clk->ph, clk->id, false);
> > > 
> > > I enjoyed how it was before because I don't know what 'false' means
> > > without looking at the ops now.
> > > 
> > 
> > Yes indeed, I can drop this and rework if you prefer to maintain the old
> > API calls, but this would mean that whenever we'll add new atomic
> > flavour to some new SCMI clk operations we'll have to add 2 ops instead
> > of a parametrized one...this is what would happen also in this series
> > with state_get (and what really triggered this refactor)
> > 
> > (and please consider that on the SCMI side, for testing purposes, I would
> > prefer to expose always both atomic and non-atomic flavours even if NOT
> > both actively used by the Clock framework...like state_get() that can only
> > be atomic for Clock frmwk...)
> > 
> 
> Perhaps we need a local variable to make it more readable.
> 
> 	static int scmi_clk_enable(struct clk_hw *hw)
> 	{
> 	       bool can_sleep = false;
> 	       struct scmi_clk *clk = to_scmi_clk(hw);
> 
> 	       return scmi_proto_clk_ops->enable(clk->ph, clk->id, can_sleep);
> 	}
> 
> This let's the reader quickly understand what the parameter means. I'm
> OK with adding the function parameter, but a plain 'true' or 'false'
> doesn't help with clarity.

Thanks for the suggestion, it would help definitely making it more
readable, maybe a local define or enum could make it without even
putting anything on the stack.

Thanks,
Cristian
