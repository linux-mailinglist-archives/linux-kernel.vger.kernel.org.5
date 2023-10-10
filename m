Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE007BF4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442589AbjJJHtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442488AbjJJHtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:49:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 614AE9E;
        Tue, 10 Oct 2023 00:49:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0F761FB;
        Tue, 10 Oct 2023 00:50:17 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BBEA3F7A6;
        Tue, 10 Oct 2023 00:49:35 -0700 (PDT)
Date:   Tue, 10 Oct 2023 08:49:33 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        ranjani.vaidyanathan@nxp.com, glen.wienecke@nxp.com,
        Peng Fan <peng.fan@nxp.com>, souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [RFC] firmware: arm_scmi: clock: add fixed clock attribute
 support
Message-ID: <ZSUCDdfJjs1blK1T@e120937-lin>
References: <20231010022911.4106863-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010022911.4106863-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:29:11AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> There are clocks:
>  system critical, not allow linux to disable, change rate
>  allow linux to get rate, because some periphals will use the frequency
>  to configure periphals.
> 
>  So introduce an attribute to indicated FIXED clock
> 

Hi,

(CCed souvik.chakravarty@arm.com)

so AFAIU here you are describing a clock that really is NOT fixed in
general, it is just that the Linux SCMI Agent cannot touch it, but
other SCMI agents on the system CAN change it and so, on one side, you
keep the ability for the Linux agent to read back the current rate with
recalc_rate() and remove all the Clk frameworks callbacks needed to modify
its state, am I right ?

In this scenario, it is really the SCMI platform fw (server) that has to
implement the checks and simply DENY the requests coming from an agent that
is not supposed to touch that clock, while allowing the current rate to
be retrieved.

JUNO/SCP is an example of how the CPUs clocks are visible to Linux BUT
cannot be touched directly via Clock protocol by Linux since in the SCMI
world you are supposed to use the Perf protocol instead to change the OPPs
when you want to modify the performance level of the runnning CPU.

This kind of server-side permissions checks, meant to filter access to
resources based on the requesting agent, are part of the SCMI declared
aim to push the responsibility of such controls out of the kernel into the
platform fw in order to avoid attacks like CLOCK_SCREW by letting the
SCMI firmware be the one and only final arbiter on the requests coming
from the agents; you can ask teh server whatever you like as an agent but
your request can be DENIED or silently ignored (in case of shared resources)
at the will of the platform which has the final say and it is
implemented in a physically distinct code-base.

It seems to me that this patch and the possible associated SCMI specification
change would give back the control to the Linux agent and could allow the
implementation of an SCMI Server that does NOT perform any of these
permission checks.

So, IMO, while this change, on one side, could be certainly useful by
removing a bunch of unused/uneeded callbacks from the CLK SCMI driver when
a fixed clock is identified, it could open the door to a bad implementation
like the one mentioned above which does NOT perform any agent-based
permission check.

Maybe Sudeep or Souvik think differently.

Thanks,
Cristian


> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/clk-scmi.c            | 6 ++++++
>  drivers/firmware/arm_scmi/clock.c | 5 ++++-
>  include/linux/scmi_protocol.h     | 1 +
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> index 8cbe24789c24..a539a35bd45a 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -182,6 +182,10 @@ static const struct clk_ops scmi_clk_ops = {
>  	.determine_rate = scmi_clk_determine_rate,
>  };
>  
> +static const struct clk_ops scmi_fixed_rate_clk_ops = {
> +	.recalc_rate = scmi_clk_recalc_rate,
> +};
> +
>  static const struct clk_ops scmi_atomic_clk_ops = {
>  	.recalc_rate = scmi_clk_recalc_rate,
>  	.round_rate = scmi_clk_round_rate,
> @@ -293,6 +297,8 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
>  		if (is_atomic &&
>  		    sclk->info->enable_latency <= atomic_threshold)
>  			scmi_ops = &scmi_atomic_clk_ops;
> +		else if (sclk->info->rate_fixed)
> +			scmi_ops = &scmi_fixed_rate_clk_ops;
>  		else
>  			scmi_ops = &scmi_clk_ops;
>  
> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index ddaef34cd88b..8c52db539e54 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -46,6 +46,7 @@ struct scmi_msg_resp_clock_attributes {
>  #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
>  #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
>  #define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
> +#define SUPPORTS_FIXED_RATE_CLOCK(x)		((x) & BIT(27))
>  	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
>  	__le32 clock_enable_latency;
>  };
> @@ -326,7 +327,9 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
>  			clk->rate_changed_notifications = true;
>  		if (SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(attributes))
>  			clk->rate_change_requested_notifications = true;
> -		if (SUPPORTS_PARENT_CLOCK(attributes))
> +		if (SUPPORTS_FIXED_RATE_CLOCK(attributes))
> +			clk->rate_fixed = true;
> +		else if (SUPPORTS_PARENT_CLOCK(attributes))
>  			scmi_clock_possible_parents(ph, clk_id, clk);
>  	}
>  
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index f2f05fb42d28..e068004c151a 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -47,6 +47,7 @@ struct scmi_clock_info {
>  	bool rate_discrete;
>  	bool rate_changed_notifications;
>  	bool rate_change_requested_notifications;
> +	bool rate_fixed;
>  	union {
>  		struct {
>  			int num_rates;
> -- 
> 2.37.1
> 
