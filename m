Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8569D7B0A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjI0Qe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjI0QeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:34:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEE861725;
        Wed, 27 Sep 2023 09:34:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9837A1FB;
        Wed, 27 Sep 2023 09:34:39 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 134613F59C;
        Wed, 27 Sep 2023 09:33:59 -0700 (PDT)
Date:   Wed, 27 Sep 2023 17:33:58 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 1/2] firmware: arm_scmi: clock: support clock parents
Message-ID: <ZRRZduhOAASNe7pP@pluto>
References: <20230925-scmi-clock-v2-v2-0-2d4d7127ebc1@nxp.com>
 <20230925-scmi-clock-v2-v2-1-2d4d7127ebc1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925-scmi-clock-v2-v2-1-2d4d7127ebc1@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 04:47:42PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> SCMI v3.2 spec introduces CLOCK_POSSIBLE_PARENTS_GET, CLOCK_PARENT_SET
> and CLOCK_PARENT_GET. This patch is to add the upper three new
> commands.
> 

Hi,

a few notes down below.

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/arm_scmi/clock.c | 156 ++++++++++++++++++++++++++++++++++++--
>  include/linux/scmi_protocol.h     |   5 ++
>  2 files changed, 155 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index d18bf789fc24..38278922890a 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -22,6 +22,9 @@ enum scmi_clock_protocol_cmd {
>  	CLOCK_RATE_NOTIFY = 0x9,
>  	CLOCK_RATE_CHANGE_REQUESTED_NOTIFY = 0xA,
>  	CLOCK_CONFIG_GET = 0xB,
> +	CLOCK_POSSIBLE_PARENTS_GET = 0xC,
> +	CLOCK_PARENT_SET = 0xD,
> +	CLOCK_PARENT_GET = 0xE,
>  };
>  
>  enum clk_state {
> @@ -42,10 +45,28 @@ struct scmi_msg_resp_clock_attributes {
>  #define SUPPORTS_RATE_CHANGED_NOTIF(x)		((x) & BIT(31))
>  #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
>  #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
> +#define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
>  	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
>  	__le32 clock_enable_latency;
>  };
>  
> +struct scmi_msg_clock_possible_parents {
> +	__le32 id;
> +	__le32 skip_parents;
> +};
> +
> +struct scmi_msg_resp_clock_possible_parents {
> +	__le32 num_parent_flags;
> +#define NUM_PARENTS_RETURNED(x)		((x) & 0xff)
> +#define NUM_PARENTS_REMAINING(x)	((x) >> 24)
> +	u32 possible_parents[];
> +};
> +
> +struct scmi_msg_clock_set_parent {
> +	__le32 id;
> +	__le32 parent_id;
> +};
> +
>  struct scmi_msg_clock_config_set_v2 {
>  	__le32 id;
>  	__le32 attributes;
> @@ -167,6 +188,81 @@ scmi_clock_protocol_attributes_get(const struct scmi_protocol_handle *ph,
>  	return ret;
>  }
>  
> +struct scmi_clk_ipriv {
> +	struct device *dev;
> +	u32 clk_id;
> +	struct scmi_clock_info *clk;
> +};
> +
> +static void iter_clk_possible_parents_prepare_message(void *message, unsigned int desc_index,
> +						      const void *priv)
> +{
> +	struct scmi_msg_clock_possible_parents *msg = message;
> +	const struct scmi_clk_ipriv *p = priv;
> +
> +	msg->id = cpu_to_le32(p->clk_id);
> +	/* Set the number of OPPs to be skipped/already read */
> +	msg->skip_parents = cpu_to_le32(desc_index);
> +}
> +
> +static int iter_clk_possible_parents_update_state(struct scmi_iterator_state *st,
> +						  const void *response, void *priv)
> +{
> +	const struct scmi_msg_resp_clock_possible_parents *r = response;
> +	u32 flags;
> +
> +	flags = le32_to_cpu(r->num_parent_flags);
> +	st->num_returned = NUM_PARENTS_RETURNED(flags);
> +	st->num_remaining = NUM_PARENTS_REMAINING(flags);
> +
> +	return 0;
> +}
> +
> +static int iter_clk_possible_parents_process_response(const struct scmi_protocol_handle *ph,
> +						      const void *response,
> +						      struct scmi_iterator_state *st,
> +						      void *priv)
> +{
> +	const struct scmi_msg_resp_clock_possible_parents *r = response;
> +	struct scmi_clk_ipriv *p = priv;
> +
> +	u32 *parent = &p->clk->parents[st->desc_index + st->loop_idx];
> +
> +	*parent = le32_to_cpu(r->possible_parents[st->loop_idx]);
> +	p->clk->num_parents++;
> +
> +	return 0;
> +}
> +
> +static int scmi_clock_possible_parents(const struct scmi_protocol_handle *ph, u32 clk_id,
> +				       struct scmi_clock_info *clk)
> +{
> +	struct scmi_iterator_ops ops = {
> +		.prepare_message = iter_clk_possible_parents_prepare_message,
> +		.update_state = iter_clk_possible_parents_update_state,
> +		.process_response = iter_clk_possible_parents_process_response,
> +	};
> +
> +	struct scmi_clk_ipriv ppriv = {
> +		.clk_id = clk_id,
> +		.clk = clk,
> +		.dev = ph->dev,
> +	};
> +	void *iter;
> +	int ret;
> +
> +	iter = ph->hops->iter_response_init(ph, &ops, SCMI_MAX_NUM_PARENTS,

SCMI_MAX_NUM_PARENTS is arbitrarily set to 8 elsewhere, but this is
out-of-spec, even though possibly reasonable.

Indeed, the spec for this protocol does not give you a way to know
upfront how many parents are possibly defined for the clock at hand, so
I suppose that's the reason why you have set the max number arbitrarily
to 8.

Even though this is true, we can really deduce the maximum number of
parents looking at the first reply: max_parents = remaining + returned.

It is a bit tricky but this can be done inside the .update_state callback
of the iterator, so that on the first invocation you can calculate
st->max_resources and allocate dynamically the needed resources.

You can find an example of something similar to this inside

drivers/firmware/arm_scmi/sensors.c::iter_intervals_update_state().

> +					    CLOCK_POSSIBLE_PARENTS_GET,
> +					    sizeof(struct scmi_msg_clock_possible_parents),
> +					    &ppriv);
> +	if (IS_ERR(iter))
> +		return PTR_ERR(iter);
> +
> +	ret = ph->hops->iter_response_run(iter);
> +
> +	return ret;
> +}
> +
>  static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
>  				     u32 clk_id, struct scmi_clock_info *clk,
>  				     u32 version)
> @@ -211,6 +307,8 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
>  			clk->rate_changed_notifications = true;
>  		if (SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(attributes))
>  			clk->rate_change_requested_notifications = true;
> +		if (SUPPORTS_PARENT_CLOCK(attributes))
> +			scmi_clock_possible_parents(ph, clk_id, clk);
>  	}
>  
>  	return ret;
> @@ -228,12 +326,6 @@ static int rate_cmp_func(const void *_r1, const void *_r2)
>  		return 1;
>  }
>  
> -struct scmi_clk_ipriv {
> -	struct device *dev;
> -	u32 clk_id;
> -	struct scmi_clock_info *clk;
> -};
> -
>  static void iter_clk_describe_prepare_message(void *message,
>  					      const unsigned int desc_index,
>  					      const void *priv)
> @@ -457,6 +549,56 @@ scmi_clock_config_set_v2(const struct scmi_protocol_handle *ph, u32 clk_id,
>  	return ret;
>  }
>  
> +static int
> +scmi_clock_set_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
> +		      u32 parent_id)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_clock_set_parent *cfg;
> +	struct clock_info *ci = ph->get_priv(ph);
> +	struct scmi_clock_info *clk = ci->clk + clk_id;
> +

Better to add a check here that the provided clk_id is within the
boundary of the existing clocks (i.e. clk_id < ci->num_clocks) before
dereferencing, given that the argument is provided by a caller.
(even though a kernel/driver caller I understand...)

> +	ret = ph->xops->xfer_get_init(ph, CLOCK_PARENT_SET,
> +				      sizeof(*cfg), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	t->hdr.poll_completion = false;
> +
> +	cfg = t->tx.buf;
> +	cfg->id = cpu_to_le32(clk_id);
> +	cfg->parent_id = cpu_to_le32(clk->parents[parent_id]);
> +

Same here, parent_id, which is proivided by the caller, should have been
checked previously against clk->num_parents, bailing out on out of
boundary.

> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int
> +scmi_clock_get_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
> +		      u32 *parent_id)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +
> +	ret = ph->xops->xfer_get_init(ph, CLOCK_PARENT_GET,
> +				      sizeof(__le32), sizeof(u32), &t);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_le32(clk_id, t->tx.buf);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret)
> +		*parent_id = get_unaligned_le32(t->rx.buf);
> +
> +	ph->xops->xfer_put(ph, t);
> +	return ret;
> +}
> +
>  static int
>  scmi_clock_config_set_v21(const struct scmi_protocol_handle *ph, u32 clk_id,
>  			  enum clk_state state, u8 oem_type, u32 oem_val,
> @@ -647,6 +789,8 @@ static const struct scmi_clk_proto_ops clk_proto_ops = {
>  	.state_get = scmi_clock_state_get,
>  	.config_oem_get = scmi_clock_config_oem_get,
>  	.config_oem_set = scmi_clock_config_oem_set,
> +	.parent_set = scmi_clock_set_parent,
> +	.parent_get = scmi_clock_get_parent,
>  };
>  
>  static int scmi_clk_rate_notify(const struct scmi_protocol_handle *ph,
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index 27bfa5a65b45..3175a9b4b8d8 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -16,6 +16,7 @@
>  #define SCMI_MAX_STR_SIZE		64
>  #define SCMI_SHORT_NAME_MAX_SIZE	16
>  #define SCMI_MAX_NUM_RATES		16
> +#define SCMI_MAX_NUM_PARENTS		8

Should be dynamically calculated as said above.

>  
>  /**
>   * struct scmi_revision_info - version information structure
> @@ -58,6 +59,8 @@ struct scmi_clock_info {
>  			u64 step_size;
>  		} range;
>  	};
> +	int num_parents;
> +	u32 parents[SCMI_MAX_NUM_PARENTS];

As said, you can dynamnically allocate this on protocol_init when
querying the parents.

>  };
>  
>  enum scmi_power_scale {
> @@ -104,6 +107,8 @@ struct scmi_clk_proto_ops {
>  			      bool atomic);
>  	int (*config_oem_set)(const struct scmi_protocol_handle *ph, u32 clk_id,
>  			      u8 oem_type, u32 oem_val, bool atomic);
> +	int (*parent_get)(const struct scmi_protocol_handle *ph, u32 clk_id, u32 *parent_id);
> +	int (*parent_set)(const struct scmi_protocol_handle *ph, u32 clk_id, u32 parent_id);
>  };
>  

Please add related comments for this new operations in the block comment
above the scmi_clk_proto_ops.

Thanks,
Cristian
