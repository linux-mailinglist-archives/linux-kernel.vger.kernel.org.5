Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF58785393
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbjHWJOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjHWJLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:11:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86A5946AD;
        Wed, 23 Aug 2023 02:03:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 168A41042;
        Wed, 23 Aug 2023 02:03:31 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76B3E3F740;
        Wed, 23 Aug 2023 02:02:48 -0700 (PDT)
Date:   Wed, 23 Aug 2023 10:02:46 +0100
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
Message-ID: <ZOXLNliOogkNyJYQ@e120937-lin>
References: <20230811161446.636253-1-cristian.marussi@arm.com>
 <20230811161446.636253-2-cristian.marussi@arm.com>
 <17bd83d833b59fd4f64eec433589fa55.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17bd83d833b59fd4f64eec433589fa55.sboyd@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 01:17:15PM -0700, Stephen Boyd wrote:
> Quoting Cristian Marussi (2023-08-11 09:14:41)
> > Add a param to Clock enable/disable operation to ask for atomic operation
> > and remove _atomic version of such operations.
> 

Hi,

> Why?
> 

:D, given that the 2 flavours of SCMI enable/disable ops (and the upcoming
state_get) just differ in their operating mode (atomic or not) and the
Clock framework in turn wrap such calls into 4 related and explicitly
named clk_ops (scmi_clock_enable/scmi_clock_atomic_enable etc) that hint
at what is being done, seemed to me reasonable to reduce the churn and
remove a bit of code wrappers in favour of a param.

> > 
> > No functional change.
> > 
> > CC: Michael Turquette <mturquette@baylibre.com>
> > CC: Stephen Boyd <sboyd@kernel.org>
> > CC: linux-clk@vger.kernel.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/clk/clk-scmi.c            |  8 ++++----
> >  drivers/firmware/arm_scmi/clock.c | 24 ++++++------------------
> >  include/linux/scmi_protocol.h     |  9 ++++-----
> >  3 files changed, 14 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> > index 2c7a830ce308..ff003083e592 100644
> > --- a/drivers/clk/clk-scmi.c
> > +++ b/drivers/clk/clk-scmi.c
> > @@ -78,28 +78,28 @@ static int scmi_clk_enable(struct clk_hw *hw)
> >  {
> >         struct scmi_clk *clk = to_scmi_clk(hw);
> >  
> > -       return scmi_proto_clk_ops->enable(clk->ph, clk->id);
> > +       return scmi_proto_clk_ops->enable(clk->ph, clk->id, false);
> >  }
> >  
> >  static void scmi_clk_disable(struct clk_hw *hw)
> >  {
> >         struct scmi_clk *clk = to_scmi_clk(hw);
> >  
> > -       scmi_proto_clk_ops->disable(clk->ph, clk->id);
> > +       scmi_proto_clk_ops->disable(clk->ph, clk->id, false);
> 
> I enjoyed how it was before because I don't know what 'false' means
> without looking at the ops now.
> 

Yes indeed, I can drop this and rework if you prefer to maintain the old
API calls, but this would mean that whenever we'll add new atomic
flavour to some new SCMI clk operations we'll have to add 2 ops instead
of a parametrized one...this is what would happen also in this series
with state_get (and what really triggered this refactor)

(and please consider that on the SCMI side, for testing purposes, I would
prefer to expose always both atomic and non-atomic flavours even if NOT
both actively used by the Clock framework...like state_get() that can only
be atomic for Clock frmwk...)

Thanks,
Cristian
