Return-Path: <linux-kernel+bounces-62174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4DD851CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A771F232B0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3703FE3E;
	Mon, 12 Feb 2024 18:26:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F51405FD;
	Mon, 12 Feb 2024 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762369; cv=none; b=RZoS5n0QWMo+qX93mKge6qoKuxfVBYl28WDUPQS7b9Mlg+40msbWVwfN0NUBgLVyg5R6IRwzfExXEDgXVbXG6Y0hkYDSx/43RV3xV55Xm9ARFqg7n2N1cj05Caif3fVH+qyP7PBUF8EHJQ6TnmiP2o/bqHFvfRBQN96q4Ehi+w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762369; c=relaxed/simple;
	bh=RVBiiKt71wjFsnRdAFPjF0d4lGi7IogOJgAvmxhOfIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=movyyexd2AphoO4XQ6o34tBxiFu9z9t5/M8ualL5x/ukshP4uzVIrj4gVzCczu/pnSGJQIuaUyWRfRprBizWaEdFRxbrl9HJ2EBFK6I/FNE1ZGzRisR1OeLXYu6iLd8r1993uftu/byayeDgjjwO0WebhtHV/ZrFMYVrwnxpf7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA73C43399;
	Mon, 12 Feb 2024 18:26:07 +0000 (UTC)
Date: Mon, 12 Feb 2024 13:26:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, "Manivannan Sadhasivam"
 <manivannan.sadhasivam@linaro.org>, <linux-kernel@vger.kernel.org>,
 <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
 <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
 <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>
Subject: Re: [PATCH v11] bus: mhi: host: Add tracing support
Message-ID: <20240212132649.767e9b87@gandalf.local.home>
In-Reply-To: <20240206-ftrace_support-v11-1-3f71dc187544@quicinc.com>
References: <20240206-ftrace_support-v11-1-3f71dc187544@quicinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Feb 2024 10:02:05 +0530
Krishna chaitanya chundru <quic_krichai@quicinc.com> wrote:



> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index abb561db9ae1..2d38f6005da6 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -15,6 +15,7 @@
>  #include <linux/skbuff.h>
>  #include <linux/slab.h>
>  #include "internal.h"
> +#include "trace.h"
>  
>  int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
>  			      void __iomem *base, u32 offset, u32 *out)
> @@ -493,11 +494,8 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
>  
>  	state = mhi_get_mhi_state(mhi_cntrl);
>  	ee = mhi_get_exec_env(mhi_cntrl);
> -	dev_dbg(dev, "local ee: %s state: %s device ee: %s state: %s\n",
> -		TO_MHI_EXEC_STR(mhi_cntrl->ee),
> -		mhi_state_str(mhi_cntrl->dev_state),
> -		TO_MHI_EXEC_STR(ee), mhi_state_str(state));
>  
> +	trace_mhi_intvec_states(mhi_cntrl, ee, state);
>  	if (state == MHI_STATE_SYS_ERR) {
>  		dev_dbg(dev, "System error detected\n");
>  		pm_state = mhi_tryset_pm_state(mhi_cntrl,
> @@ -838,6 +836,8 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>  	while (dev_rp != local_rp) {
>  		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
>  
> +		trace_mhi_ctrl_event(mhi_cntrl, local_rp);
> +
>  		switch (type) {
>  		case MHI_PKT_TYPE_BW_REQ_EVENT:
>  		{
> @@ -1003,6 +1003,8 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>  	while (dev_rp != local_rp && event_quota > 0) {
>  		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
>  
> +		trace_mhi_data_event(mhi_cntrl, local_rp);
> +
>  		chan = MHI_TRE_GET_EV_CHID(local_rp);
>  
>  		WARN_ON(chan >= mhi_cntrl->max_chan);
> @@ -1243,6 +1245,7 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>  	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(info->len);
>  	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, eot, eob, chain);
>  
> +	trace_mhi_gen_tre(mhi_cntrl, mhi_chan, mhi_tre);
>  	/* increment WP */
>  	mhi_add_ring_element(mhi_cntrl, tre_ring);
>  	mhi_add_ring_element(mhi_cntrl, buf_ring);
> @@ -1337,9 +1340,7 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
>  	enum mhi_cmd_type cmd = MHI_CMD_NOP;
>  	int ret;
>  
> -	dev_dbg(dev, "%d: Updating channel state to: %s\n", mhi_chan->chan,
> -		TO_CH_STATE_TYPE_STR(to_state));
> -
> +	trace_mhi_channel_command_start(mhi_cntrl, mhi_chan, to_state, "Updating");

The string above "Updating"

>  	switch (to_state) {
>  	case MHI_CH_STATE_TYPE_RESET:
>  		write_lock_irq(&mhi_chan->lock);
> @@ -1406,9 +1407,7 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
>  		write_unlock_irq(&mhi_chan->lock);
>  	}
>  
> -	dev_dbg(dev, "%d: Channel state change to %s successful\n",
> -		mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
> -
> +	trace_mhi_channel_command_end(mhi_cntrl, mhi_chan, to_state, "Updated");

And here "Updated"

>  exit_channel_update:
>  	mhi_cntrl->runtime_put(mhi_cntrl);
>  	mhi_device_put(mhi_cntrl->mhi_dev);

Please add them to the printk_formats (like RCU trace events do).

#define TPS(x)	tracepoint_string(x)

Then the above should have:

	trace_mhi_channel_command_start(mhi_cntrl, mhi_chan, to_state, TPS("Updating"));

and

	trace_mhi_channel_command_end(mhi_cntrl, mhi_chan, to_state, TPS("Updated"));

> +DECLARE_EVENT_CLASS(mhi_update_channel_state,
> +
> +	TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan, int state,
> +		 const char *reason),
> +
> +	TP_ARGS(mhi_cntrl, mhi_chan, state, reason),
> +
> +	TP_STRUCT__entry(
> +		__string(name, mhi_cntrl->mhi_dev->name)
> +		__field(int, ch_num)
> +		__field(int, state)
> +		__field(const char *, reason)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, mhi_cntrl->mhi_dev->name);
> +		__entry->ch_num = mhi_chan->chan;
> +		__entry->state = state;
> +		__entry->reason = reason;
> +	),
> +
> +	TP_printk("%s: chan%d: %s state to: %s\n",
> +		  __get_str(name),  __entry->ch_num, __entry->reason,
> +		  __print_symbolic(__entry->state, MHI_CH_STATE_TYPE_LIST))
> +);

The above print fmt has "%s" on __entry->reason which is just an internal
kernel pointer to the string that is saved in the ring buffer. User space
tools like perf and trace-cmd will not report them. It will just show some
internal kernel address. By adding the TPS() logic above, those addresses
will be mapped to strings:

 ~# grep RCU /sys/kernel/tracing/printk_formats 
 0xffffffffb069a4e0 : "End RCU core"
 0xffffffffb069a520 : "Start RCU core"

As RCU uses direct string pointers in its name space, it has the TPS()
logic that allows perf and ftrace to map the addresses that are saved in
the ring buffer to the strings they represent.

-- Steve


> +
> +DEFINE_EVENT(mhi_update_channel_state, mhi_channel_command_start,
> +
> +	TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan, int state,
> +		 const char *reason),
> +
> +	TP_ARGS(mhi_cntrl, mhi_chan, state, reason)
> +);
> +
> +DEFINE_EVENT(mhi_update_channel_state, mhi_channel_command_end,
> +
> +	TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan, int state,
> +		 const char *reason),
> +
> +	TP_ARGS(mhi_cntrl, mhi_chan, state, reason)
> +);
> +

